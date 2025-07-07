#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <libwebsockets.h>
#include <jansson.h>
#include <string.h>
#include <time.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <sys/time.h>

#define COLOR_RED     "\x1b[31m"
#define COLOR_GREEN   "\x1b[32m"
#define COLOR_YELLOW  "\x1b[33m"
#define COLOR_BLUE    "\x1b[34m"
#define COLOR_MAGENTA "\x1b[35m"
#define COLOR_RESET   "\x1b[0m"

#define QUEUESIZE 10000
#define NUM_VALUES 15
#define NUM_PINGS 3
#define REC_TIME 5
#define PRODUCERS 3
#define CONSUMERS 5


void *producer (void *args); 
void *consumer (void *args);
void *minute_candlestick(void* args);
void *quarter_mvg_avg(void* args);

volatile sig_atomic_t destroy_flag = 0 ; // once this flag is set to 1 the program stops running
bool subscribed = false ; // to make sure I have subscribed to every symbol
static int connected = 0 ; // every time this becomes 0 I attempt to reconnect
static int wrong_pings = 0; // because of how finnhub works, I accept at least 3 consecutive pings
static int found_zero = 0; // sometimes I don't receive data for no apparent reason so I disconnect and re-establish the connection
static int closed_markets = 0; // if found_zero has occured 3 times then the markets have closed

pthread_mutex_t* mutex_candlestick; // mutex to lock the candlesticks
pthread_mutex_t* connection_mutex; // mutex to only allow one producer to establish the connection
pthread_cond_t* done; // condition to notify the moving average that the candlesticks have been saved
pthread_cond_t* minute; // condition to notify the candlestick thread that the timer reached one minute


typedef struct{
  double price;
  char symbol[10];
  char timestamp[20];
  double volume;
  unsigned long long time_received;
}trade; // struct for trade objects

typedef struct{
  double open;
  double close;
  double max;
  double min;
  double sum_prices;
  bool first_time;
  long total_trades;
  float total_volume;
}candlestick; // struct for candlestick objects

typedef struct{
  double total_prices[NUM_VALUES];
  double total_trades[NUM_VALUES];
  long volume[NUM_VALUES];
  int index;
  int count; 
}moving_avg; // struct for moving average objects

typedef struct {
  trade buf[QUEUESIZE];
  long head, tail;
  int full, empty;
  pthread_mutex_t *queue_mut;
  pthread_cond_t *notFull, *notEmpty;
} queue; // struct for the queue


// candlestick pointers for the symbols we have subscribed
candlestick* amazon_candlestick;
candlestick* tesla_candlestick;
candlestick* nvda_candlestick;
candlestick* ethereum_candlestick;

// moving average pointers for the symbols we have subscribed
moving_avg* amazon_mvg_avg;
moving_avg* tesla_mvg_avg;
moving_avg* nvda_mvg_avg;
moving_avg* ethereum_mvg_avg;

// moving average calculated every minute over a period of 15 minutes
static double amazon_ma = 0; 
static double tesla_ma = 0;
static double nvda_ma = 0;
static double ethereum_ma = 0;

static float amazon_vol = 0;
static float tesla_vol = 0;
static float nvda_vol = 0 ;
static float ethereum_vol = 0;


// File descriptors for trade data for Apple, Nvidia, Tesla, Amazon
FILE* fd_tesla;
FILE* fd_amazon;
FILE* fd_nvda;
FILE* fd_ethereum;

// File descriptors for candlestick data for Apple, Nvidia, Tesla, Amazon
FILE* fd_candlestick_tesla;
FILE* fd_candlestick_amazon;
FILE* fd_candlestick_nvda;
FILE* fd_candlestick_ethereum;

// File descriptors for moving average data for Apple, Nvidia, Tesla, Amazon
FILE* fd_moving_avg_tesla;
FILE* fd_moving_avg_amazon;
FILE* fd_moving_avg_nvda;
FILE* fd_moving_avg_ethereum;


static const char* subscriptions[] = {
  "{\"type\":\"subscribe\",\"symbol\":\"NVDA\"}",
  "{\"type\":\"subscribe\",\"symbol\":\"BINANCE:ETHUSDT\"}",
  "{\"type\":\"subscribe\",\"symbol\":\"TSLA\"}",
  "{\"type\":\"subscribe\",\"symbol\":\"AMZN\"}"
}; // an array of strings with each string being a JSON message to subscribe to a different symbol


queue *queueInit (void);
void queueDelete (queue *q);
void queueAdd (queue *q, trade in);
void queueDel (queue *q, trade *out);
void SIG_HANDLER(int signum);
void process_message(const char* message);
void create_header_trade_data();
void create_header_candlestick_data();
void create_header_moving_avg_data();
void save_trade_data(trade* t);
void save_candlestick_data(const char* symbol, candlestick* c);
void save_moving_average(const char* symbol, double mvg_avg,long volume);
void candlestick_init(candlestick* c);
void create_candlestick(candlestick* c, trade* t);
void moving_avg_init(moving_avg* mvg_avg);
void add_mean_volume(moving_avg* mvg_avg, double total, float volume, long total_trades);
double calculate_mvg_avg(moving_avg* mvg_avg);
float total_volume(moving_avg* mvg_avg);
int count_lines(FILE* fd, long start_position);
void cleanup();
void reconnect(); // In case of an internet connection problem
void create_client();
unsigned long long int time_in_queue();


struct lws_context_creation_info info;
struct lws_context* context = NULL;
struct lws_client_connect_info client;
struct lws* wsi;
queue *fifo;


static int ws_callback(struct lws* wsi, enum lws_callback_reasons reason, void* user, void* in, size_t len)
{
  switch(reason)
  {
    // this event is triggered when a connection is established
    case LWS_CALLBACK_CLIENT_ESTABLISHED:
      printf(COLOR_GREEN"Client Connected\n"COLOR_RESET);
      lws_callback_on_writable(wsi); // this function ensures that the client is
      // marked as writeable allowing it to send messages
      break;

    // Essential for sending messages to the WebSocket server
    case LWS_CALLBACK_CLIENT_WRITEABLE: 
      printf(COLOR_YELLOW"Writeable is called\n"COLOR_RESET);
      if(subscribed == false)
      {
        for(size_t i = 0; i < sizeof(subscriptions) / sizeof(subscriptions[0]); i++)
        {
          size_t msg_len = strlen(subscriptions[i]);
          // creating a buffer to hold the message
          unsigned char buf[LWS_SEND_BUFFER_PRE_PADDING + msg_len + LWS_SEND_BUFFER_POST_PADDING]; // must account for the pre-buffer size required by libwebsockets

          //copies the subscriptions message into the buffer
          memcpy(&buf[LWS_SEND_BUFFER_PRE_PADDING], subscriptions[i], msg_len);

          //sends the message using the lws_write 
          lws_write(wsi, &buf[LWS_PRE], msg_len, LWS_WRITE_TEXT);
        }
        subscribed = true;
      }
     
      break;

    // this event is triggered when the client receives a message from the server
    case LWS_CALLBACK_CLIENT_RECEIVE:
      //printf(COLOR_YELLOW"Received: %s\n"COLOR_RESET, (char* ) in);
      process_message((char *) in);
      break; 

    //this event is triggered when the connection is closed
    case LWS_CALLBACK_CLIENT_CLOSED:
      printf(COLOR_BLUE"\rClient closed\n"COLOR_RESET);
      connected = 0;
      if(destroy_flag == 0)
      {
        subscribed = false; // setting in to false so we are forced to subscribe again to these symbols
      }
      break;

    case LWS_CALLBACK_CLIENT_CONNECTION_ERROR:
      lwsl_err(COLOR_RED"CLIENT CONNECTION ERROR: %s\n"COLOR_RESET, in ? (char*) in : "(null)");
      connected = 0;
      wsi = NULL;
      if(destroy_flag == 0)
      {
        subscribed = false;
      }
        
      break;

    default:
      break;
  }
  return lws_callback_http_dummy(wsi, reason, user, in, len);
}

static struct lws_protocols protocols[] = {
  {
    "websocket_protocol",
    ws_callback,
  },
  {NULL, NULL, 0, 0} // Terminator
};

void create_client()
{
  memset(&info, 0, sizeof(info)); // Initializing the configuration Information
  info.protocols = protocols; // Configuration protocols are the ones we created
  info.port = CONTEXT_PORT_NO_LISTEN; // we do not run any server therefore no need to listen for incoming connections
  info.options = LWS_SERVER_OPTION_DO_SSL_GLOBAL_INIT;


  context = lws_create_context(&info);

  if(context == NULL)
  {
    printf(COLOR_RED"Error creating context information for the WebSocket Connection\n"COLOR_RESET);
    exit(EXIT_FAILURE);
  }

  /*Creating the Client*/
  memset(&client, 0, sizeof(client)); // Initializing the client information

  client.context = context;
  client.address = "ws.finnhub.io";
  client.port = 443; // For secure WebSocket connection
  client.path = "/?token=cqjma0pr01qnjotg7cp0cqjma0pr01qnjotg7cpg";
  client.host = client.address;
  client.origin = client.address;
  client.protocol = protocols[0].name; // protocol to be used for the client
  client.ssl_connection = LCCSCF_USE_SSL; // ensures SSL is used for secure connection
}


void reconnect()
{
    // closing the previous WebSocket connection so we don't get an error for too many API calls
    lws_cancel_service(context);
    lws_context_destroy(context);

    create_client(); // re-creating the client
    wsi = lws_client_connect_via_info(&client);

    if(wsi == NULL)
    {
        printf(COLOR_MAGENTA"Error reconnecting...Trying again\n"COLOR_RESET);
        sleep(REC_TIME); // sleeping for 5 seconds before attempting to reconnect if we didn't manage the first time
        reconnect();
    }
}


int main ()
{
  mutex_candlestick = (pthread_mutex_t*)malloc(sizeof(pthread_mutex_t));
  pthread_mutex_init(mutex_candlestick, NULL);

  connection_mutex = (pthread_mutex_t*)malloc(sizeof(pthread_mutex_t));
  pthread_mutex_init(connection_mutex, NULL);

  done =(pthread_cond_t*)malloc(sizeof(pthread_cond_t));
  pthread_cond_init(done, NULL);

  minute = (pthread_cond_t*)malloc(sizeof(pthread_cond_t));
  pthread_cond_init(minute, NULL);

  
  // initializing the file pointers for write
  fd_amazon = fopen("amazon_trade_data.csv", "w");
  fd_tesla = fopen("tesla_trade_data.csv", "w");
  fd_nvda = fopen("nvda_trade_data.csv","w");
  fd_ethereum = fopen("ethereum_trade_data.csv","w");

  fd_candlestick_amazon = fopen("amazon_candlestick.csv", "w");
  fd_candlestick_tesla = fopen("tesla_candlestick.csv", "w");
  fd_candlestick_nvda = fopen("nvda_candlestick.csv", "w");
  fd_candlestick_ethereum = fopen("ethereum_candlestick.csv", "w");

  fd_moving_avg_amazon = fopen("amazon_moving_average.csv", "w");
  fd_moving_avg_tesla= fopen("tesla_moving_average.csv", "w");
  fd_moving_avg_nvda = fopen("nvda_moving_average.csv","w");
  fd_moving_avg_ethereum = fopen("ethereum_moving_average.csv","w");

  // Create Headers for the CSV files 
  create_header_candlestick_data();
  create_header_trade_data();
  create_header_moving_avg_data();

  // Can only malloc on compile time
  amazon_candlestick = (candlestick*)malloc(sizeof(candlestick));
  tesla_candlestick = (candlestick*)malloc(sizeof(candlestick));
  nvda_candlestick = (candlestick*)malloc(sizeof(candlestick));
  ethereum_candlestick = (candlestick*)malloc(sizeof(candlestick));

  // Can only malloc on compile time 
  amazon_mvg_avg = (moving_avg*)malloc(sizeof(moving_avg));
  tesla_mvg_avg = (moving_avg*)malloc(sizeof(moving_avg));
  nvda_mvg_avg = (moving_avg*)malloc(sizeof(moving_avg));
  ethereum_mvg_avg = (moving_avg*)malloc(sizeof(moving_avg));

  // Initialize the candlesticks
  candlestick_init(amazon_candlestick);
  candlestick_init(tesla_candlestick);
  candlestick_init(nvda_candlestick);
  candlestick_init(ethereum_candlestick);

  // Initialize the moving averages
  moving_avg_init(amazon_mvg_avg);
  moving_avg_init(tesla_mvg_avg);
  moving_avg_init(nvda_mvg_avg);
  moving_avg_init(ethereum_mvg_avg);


  // Signal handling to shut down the program
  struct sigaction sgn_act; // creating a signal action struct
  sgn_act.sa_handler = SIG_HANDLER; // creating a pointer to the function that will handle the incoming signal
  sigemptyset(&sgn_act.sa_mask); // initializes the signal action set mask to be empty, meaning that no signal will be blocked
  sigaction(SIGINT, &sgn_act, 0); // specifies for which signal the action will be performed
  sigaction(SIGALRM, &sgn_act, NULL);

  struct sigevent sev; // create a struct for the event
  timer_t timerid; // create a timer struct
  struct itimerspec its;

  sev.sigev_notify = SIGEV_SIGNAL; // it will be notified with an event signal
  sev.sigev_signo = SIGALRM; // setting the signal that will trigger the timer
  timer_create(CLOCK_REALTIME, &sev, &timerid); // create the timer based on our local time

  its.it_value.tv_sec = 60; // every one minute
  its.it_value.tv_nsec = 0;

  its.it_interval.tv_sec = 60; // repeat this every minute
  its.it_interval.tv_nsec = 0;
  timer_settime(timerid, 0, &its, NULL);

  
  pthread_t pro[PRODUCERS], con[CONSUMERS];
  pthread_t candlestick_con;
  pthread_t mvg_avg_con;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE); // unnecessary, since the threads are already joinable with the main thread

  fifo = queueInit ();
  if (fifo ==  NULL) {
    fprintf (stderr, "main: Queue Init failed.\n");
    exit (1);
  }
  // creating the threads for producer, consumer, candlestick and moving average
  for(int i = 0 ; i < PRODUCERS; i++)
  {
    if(pthread_create(&pro[i], &attr, producer, NULL) != 0)
    {
      fprintf(stderr ,COLOR_RED"Error creating producer threads\n"COLOR_RESET);
      kill(getpid(), SIGINT); // if creation of the thread fails, send a SIGINT singal to kill the current process
      exit(EXIT_FAILURE);
    }
  }

  for(int i = 0 ; i < CONSUMERS; i++)
  {
    if(pthread_create(&con[i], &attr, consumer, (void*) fifo) != 0)
    {
      fprintf(stderr ,COLOR_RED"Error creating consumer threads!\n"COLOR_RESET);
      kill(getpid(), SIGINT); // if creation of the thread fails, send a SIGINT singal to kill the current process
      exit(EXIT_FAILURE);
    }
  }

  if(pthread_create(&candlestick_con, &attr, minute_candlestick, NULL) != 0)
  {
    fprintf(stderr ,COLOR_RED"Error creating consumer candlestick thread\n"COLOR_RESET);
    kill(getpid(), SIGINT); // if creation of the thread fails, send a SIGINT singal to kill the current process
    exit(EXIT_FAILURE);
  }

  if(pthread_create(&mvg_avg_con, &attr, quarter_mvg_avg, NULL) != 0)
  {
    fprintf(stderr ,COLOR_RED"Error creating moving average consumer thread\n"COLOR_RESET);
    kill(getpid(), SIGINT); // if creation of the thread fails, send a SIGINT singal to kill the current process
    exit(EXIT_FAILURE);
  }
  // Joining the threads with the main thread
  for(int i = 0 ; i < PRODUCERS; i++)
  {
    if(pthread_join(pro[i], NULL) != 0)
    {
      printf(COLOR_RED"Error joining producer threads\n"COLOR_RESET);
      kill(getpid(), SIGINT);
      exit(EXIT_FAILURE);
    }
  }

  for(int i = 0; i < CONSUMERS; i++)
  {
    if(pthread_join(con[i], NULL) != 0)
    {
      printf(COLOR_RED"Error joining consumer threads\n"COLOR_RESET);
      kill(getpid(), SIGINT);
      exit(EXIT_FAILURE);
    }
  }

  if(pthread_join(candlestick_con, NULL) != 0)
  {
    printf(COLOR_RED"Error joining candlestick consumer\n"COLOR_RESET);
    kill(getpid(), SIGINT);
    exit(EXIT_FAILURE);
  }

  if(pthread_join(mvg_avg_con, NULL) != 0)
  {
    printf(COLOR_RED"Error joining candlestick consumer\n"COLOR_RESET);
    kill(getpid(), SIGINT);
    exit(EXIT_FAILURE);
  }

  if(destroy_flag == 1)
    pthread_attr_destroy(&attr);

  return 0;
}


void *producer (void *args)
{
  //TODO : WATCH OUT, THEY NEED TO BE TRADE
  //printf("Producer : %d\n", data->thread_id);
  while(!destroy_flag) {
    pthread_mutex_lock(connection_mutex);
    if(!connected)
    {
      if(wsi != NULL)
      {
        // if the connection flag is zero we delete the context and attempt to recreate it
        lws_cancel_service(context);
        lws_context_destroy(context);
      }
      create_client();
      wsi = lws_client_connect_via_info(&client);

      if(wsi == NULL)
      {
        printf(COLOR_RED"Client Connection Failed\n"COLOR_RESET);
        reconnect(); // reconnecting in the case of an Internet connection problem
      }
      printf(COLOR_GREEN"Client Connection Established!\n"COLOR_RESET);
      connected = 1;
    }
    

    while (fifo->full && !destroy_flag) {
      //printf ("producer: queue FULL.\n");
      pthread_cond_wait (fifo->notFull, fifo->queue_mut);
    }
    lws_service(context, 1000); // constantly calling the WebSocket callback function
    pthread_mutex_unlock(connection_mutex);
    pthread_cond_signal (fifo->notEmpty);
  }
  return (NULL);
}

void *consumer (void *args)
{
  trade  t; 
  while (!destroy_flag) {
    pthread_mutex_lock(fifo->queue_mut);
    //printf("Time to consume\n");
    while (fifo->empty && !destroy_flag) {
      //printf ("consumer: queue EMPTY.\n");
      pthread_cond_wait (fifo->notEmpty, fifo->queue_mut);
    }
    queueDel (fifo, &t);
    pthread_mutex_unlock(fifo->queue_mut);
    pthread_cond_signal (fifo->notFull);
    save_trade_data(&t);
    //printf ("consumer: recieved %s.\n", t.symbol);
  }
  return (NULL);
}

void *minute_candlestick(void* args)
{
  //time_t start_time = time(NULL);
  while(!destroy_flag)
  {
    //   time_t current_time = time(NULL); // I receive the current time 
    //   double elapsed_time = difftime(current_time, start_time); // I calcualte the difference between the time the thread started running and the current time
    //   int remaining_seconds = 60 - ((int)elapsed_time % 60); // I find the remaining time, so that candlesticks are exactly created after a minute passes
    //   printf("Remaining Seconds : %d\n", remaining_seconds);


    //   sleep(remaining_seconds);
        //printf("Creating Candlestick\n");
        
        pthread_mutex_lock(mutex_candlestick); // lock the mutex so the moving average thread has to wait for the candlesticks to finish
        pthread_cond_wait(minute, mutex_candlestick); // wait for the condition signal from the timer
        pthread_mutex_lock(fifo->queue_mut);
        
        save_candlestick_data("AMZN", amazon_candlestick);
        amazon_ma = calculate_mvg_avg(amazon_mvg_avg); // calculating the moving average and the total volume of the current minute
        amazon_vol = total_volume(amazon_mvg_avg);

        save_candlestick_data("TSLA", tesla_candlestick);
        tesla_ma = calculate_mvg_avg(tesla_mvg_avg);
        tesla_vol = total_volume(tesla_mvg_avg);

        save_candlestick_data("NVDA", nvda_candlestick);
        nvda_ma = calculate_mvg_avg(nvda_mvg_avg);
        nvda_vol = total_volume(nvda_mvg_avg);

        save_candlestick_data("BINANCE:E", ethereum_candlestick);
        ethereum_ma = calculate_mvg_avg(ethereum_mvg_avg);
        ethereum_vol = total_volume(ethereum_mvg_avg);

        if(found_zero >= 2 && closed_markets <= 2)
        {
            connected = 0; // If I don't receive data from more than 2 symbols I try to reconnect
            closed_markets += 1; // If I don't receive data more than 3 consecutive times its night time
        }

        else if(found_zero < 2)
        {
          closed_markets = 0;
        }
        printf("Closed Markets : %d\n", closed_markets);
        found_zero = 0;

        printf(COLOR_BLUE"Created Candlesticks\n"COLOR_RESET);

        // initializing the candlesticks again after we saved them
        candlestick_init(amazon_candlestick);
        candlestick_init(tesla_candlestick);
        candlestick_init(nvda_candlestick);
        candlestick_init(ethereum_candlestick);
        // unlocking the queue mutex so we can continue accepting trade data and consuming them
        pthread_mutex_unlock(fifo->queue_mut);
        pthread_mutex_unlock(mutex_candlestick);
        pthread_cond_signal(done); // notifying the moving average thread to start storing 
  
  }
  return NULL;
}


void* quarter_mvg_avg(void* args)
{
    while(!destroy_flag)
    {
        {
            pthread_mutex_lock(mutex_candlestick);
            pthread_cond_wait(done, mutex_candlestick);
            if(destroy_flag == 0)
            {
              printf(COLOR_GREEN"Received condintion signal\n"COLOR_RESET);
              save_moving_average("AMZN", amazon_ma, amazon_vol);
              save_moving_average("TSLA", tesla_ma, tesla_vol);
              save_moving_average("NVDA", nvda_ma, nvda_vol);
              save_moving_average("BINANCE:E", ethereum_ma, ethereum_vol);

              printf(COLOR_MAGENTA"Created Moving Average\n"COLOR_RESET);
              pthread_mutex_unlock(mutex_candlestick);
            }

        }


    }
    return NULL;
}

queue *queueInit (void)
{
  queue *q;

  q = (queue *)malloc (sizeof (queue));
  if (q == NULL) return (NULL);

  q->empty = 1;
  q->full = 0;
  q->head = 0;
  q->tail = 0;
  q->queue_mut = (pthread_mutex_t *) malloc (sizeof (pthread_mutex_t));
  pthread_mutex_init (q->queue_mut, NULL);
  q->notFull = (pthread_cond_t *) malloc (sizeof (pthread_cond_t));
  pthread_cond_init (q->notFull, NULL);
  q->notEmpty = (pthread_cond_t *) malloc (sizeof (pthread_cond_t));
  pthread_cond_init (q->notEmpty, NULL);
	
  return (q);
}

void queueDelete (queue *q)
{
  pthread_mutex_destroy (q->queue_mut);
  free (q->queue_mut);	
  pthread_cond_destroy (q->notFull);
  free (q->notFull);
  pthread_cond_destroy (q->notEmpty);
  free (q->notEmpty);
  free (q);
}

void queueAdd (queue *q, trade in)
{
  if(q->full)
  {
    //printf("Item lost\n");
    return;
  }
  memcpy(&q->buf[q->tail], &in, sizeof(trade));
  q->tail++;
  if (q->tail == QUEUESIZE)
    q->tail = 0;
  if (q->tail == q->head)
    q->full = 1;
  q->empty = 0;
  return;
}

void queueDel (queue *q, trade *out)
{
  
  if(q->empty)
  {
    //printf("WHAT\n");
    return ;
  }  
  *out = q->buf[q->head];
  //printf (COLOR_YELLOW"consumer: recieved %s.\n"COLOR_RESET, out->volume);

  q->head++;
  if (q->head == QUEUESIZE)
    q->head = 0;
  if (q->head == q->tail)
    q->empty = 1;
  q->full = 0;

  return;
}

void SIG_HANDLER(int signum)
{
    if(signum == SIGINT)
    {
        destroy_flag = 1;
        if (wsi) {
            lws_set_timeout(wsi, PENDING_TIMEOUT_CLOSE_SEND, LWS_TO_KILL_ASYNC);
        }
        
        // Destroy the context
        if (context) {
            //lws_cancel_service(context);
            lws_context_destroy(context);
        }
        // broadcast the condition signals so the producer and consumer stop their execution and don't get stuck
        pthread_cond_broadcast(fifo->notFull);
        pthread_cond_broadcast(fifo->notEmpty);
        pthread_cond_broadcast(done);
        pthread_cond_broadcast(minute);
        cleanup(); // calling the cleanup() function to free the allocated memory and close the files

        exit(EXIT_SUCCESS);
    }
    // case of the timer
    else if(signum == SIGALRM)
    {
        pthread_mutex_lock(mutex_candlestick); // lock the mutex of the candlestick
        printf("Timer ISR\n");
        pthread_cond_signal(minute); // send the signal so it starts storing data
        pthread_mutex_unlock(mutex_candlestick);
    }

}

void process_message(const char* message)
{
  json_t* root;
  json_error_t error;

  root = json_loads(message, 0, &error); // to decode the JSON message
  // if it fails, it loads the error information to the json_error_t

  if(root == NULL)
  {
    fprintf(stderr, COLOR_RED"Error: On line %d: %s\n"COLOR_RESET, error.line, error.text);
    lws_context_destroy(context);
    exit(EXIT_FAILURE);
  }

  // check if our returned value is a JSON array
  json_t *data_array = json_object_get(root, "data");
  if(!json_is_array(data_array))
  {
    fprintf(stderr, COLOR_RED"Error: Root is not an array\n"COLOR_RESET);
    json_decref(root); // as soon as this function is called the value is destroyed

    wrong_pings += 1;
    if(wrong_pings == NUM_PINGS)
    {
        connected = 0; // if the number of pings reachs a certain point I consider I have lost connection
    }
    return;
  }

  // json_array_size --> Returns the size of a JSON array
  wrong_pings = 0;

  for(int i = 0; i < json_array_size(data_array); i++)
  {
    json_t *data, *price, *symbol, *timestamp, *volume;
    trade transaction;

    data = json_array_get(data_array, i); // extract the i'th element of the root

    if(!json_is_object(data)) // checking if the extracted element is a JSON object
    {
      fprintf(stderr, COLOR_RED"Error: Data %d is not an object\n"COLOR_RESET, i+1);
      lws_context_destroy(context);
      json_decref(root);
      exit(EXIT_FAILURE);
    }

    price = json_object_get(data, "p"); // get the price value from the object

    if(!json_is_number(price))
    {
      fprintf(stderr, COLOR_RED"Error receiving the price\n"COLOR_RESET);
      json_decref(root);
      lws_context_destroy(context);
      exit(EXIT_FAILURE);
    }

    symbol = json_object_get(data, "s"); // get the symbol value from the object

    if(!json_is_string(symbol))
    {
      fprintf(stderr, COLOR_RED"Error receiving the symbol\n"COLOR_RESET);
      json_decref(root);
      lws_context_destroy(context);
      exit(EXIT_FAILURE);
    }


    timestamp = json_object_get(data, "t"); // get the timestamp value from the object

    if(!json_is_integer(timestamp))
    {
      fprintf(stderr, COLOR_RED"Error receiving the timestamp\n"COLOR_RESET);
      json_decref(root);
      lws_context_destroy(context);
      exit(EXIT_FAILURE);
    }

    volume = json_object_get(data, "v"); // get the price value from the object

    if(!json_is_number(volume))
    {
      fprintf(stderr, COLOR_RED"Error receiving the volume\n"COLOR_RESET);
      json_decref(root);
      lws_context_destroy(context);
      exit(EXIT_FAILURE);
    }

    // copying the values to the transaction structure
    // snprintf --> the value is stored as a C string 
    //snprintf(transaction.price, sizeof(transaction.price), "%.4f", json_number_value(price));
    transaction.price = json_number_value(price);
    snprintf(transaction.symbol, sizeof(transaction.symbol), "%s", json_string_value(symbol));
    snprintf(transaction.timestamp, sizeof(transaction.timestamp), "%lld", json_integer_value(timestamp));
    transaction.volume = json_number_value(volume);
    //snprintf(transaction.volume, sizeof(transaction.volume), "%.4f", json_number_value(volume));
    transaction.time_received  = time_in_queue();

    //printf("Symbol : %s, Price : %s, Timestamp : %s, Volume : %s\n", transaction.symbol, transaction.price, transaction.timestamp, transaction.volume);

    //printf("Added\n");
    if(connected == 1)
    {
        pthread_mutex_lock(fifo->queue_mut);
        queueAdd(fifo, transaction);
        pthread_mutex_unlock(fifo->queue_mut);
    }

  }

  json_decref(root);
}


void create_header_trade_data()
{
  if(count_lines(fd_amazon, 0) == 0)
    fprintf(fd_amazon, "Symbol, Price, Timestamp, Volume, Time Received, Actual Time\n");

  if(count_lines(fd_tesla, 0) == 0)
    fprintf(fd_tesla, "Symbol, Price, Timestamp, Volume, Time Received, Actual Time\n");

  if(count_lines(fd_nvda, 0) == 0)
    fprintf(fd_nvda, "Symbol, Price, Timestamp, Volume, Time Received, Actual Time\n");

  if(count_lines(fd_ethereum, 0) == 0)
    fprintf(fd_ethereum, "Symbol, Price, Timestamp, Volume, Time Received, Actual Time\n");
  
}

void create_header_candlestick_data()
{
  if(count_lines(fd_candlestick_amazon, 0) == 0)
    fprintf(fd_candlestick_amazon, "Open, Close, Max, Min, Volume, Creation Time\n");

  if(count_lines(fd_candlestick_tesla, 0) == 0)
    fprintf(fd_candlestick_tesla, "Open, Close, Max, Min, Volume, Creation Time\n");

  if(count_lines(fd_candlestick_nvda, 0) == 0)
    fprintf(fd_candlestick_nvda, "Open, Close, Max, Min, Volume, Creation Time\n");

  if(count_lines(fd_candlestick_ethereum, 0) == 0)
    fprintf(fd_candlestick_ethereum, "Open, Close, Max, Min, Volume, Creation Time\n");
}

void create_header_moving_avg_data()
{
  if(count_lines(fd_moving_avg_amazon, 0) == 0)
    fprintf(fd_moving_avg_amazon, "Symbol, Moving Average, Total Volume, Creation Time\n");

  if(count_lines(fd_moving_avg_tesla, 0) == 0)
    fprintf(fd_moving_avg_tesla, "Symbol, Moving Average, Total Volume, Creation Time\n");

  if(count_lines(fd_moving_avg_nvda, 0) == 0)
    fprintf(fd_moving_avg_nvda, "Symbol, Moving Average, Total Volume, Creation Time\n");

  if(count_lines(fd_moving_avg_ethereum, 0) == 0)
    fprintf(fd_moving_avg_ethereum, "Symbol, Moving Average, Total Volume, Creation Time\n");
}

void save_trade_data(trade* t)
{
  if(strcmp(t->symbol, "AMZN") == 0)
  {
    fprintf(fd_amazon, "%s, %.4lf, %s, %.4lf, %lld, %lld\n", t->symbol, t->price, t->timestamp, t->volume, t->time_received, time_in_queue());
    create_candlestick(amazon_candlestick, t);
  }

  else if(strcmp(t->symbol, "TSLA") == 0)
  {
    fprintf(fd_tesla, "%s, %.4lf, %s, %.4lf, %lld, %lld\n", t->symbol, t->price, t->timestamp, t->volume, t->time_received, time_in_queue());
    create_candlestick(tesla_candlestick, t);
  }

  else if(strcmp(t->symbol, "NVDA") == 0)
  {
    fprintf(fd_nvda, "%s, %.4lf, %s, %.4lf, %lld, %lld\n", t->symbol, t->price, t->timestamp, t->volume, t->time_received, time_in_queue());
    create_candlestick(nvda_candlestick, t);
  }

  else if(strcmp(t->symbol, "BINANCE:E") == 0)
  {
    fprintf(fd_ethereum, "%s, %.4lf, %s, %.4lf, %lld, %lld\n", t->symbol, t->price, t->timestamp, t->volume, t->time_received, time_in_queue());
    create_candlestick(ethereum_candlestick, t);
  }

  else
  {
    // fprintf(stderr, COLOR_RED"Error! No symbol with that name(trade)\n"COLOR_RESET);
    // kill(getpid(), SIGINT);
    // exit(EXIT_FAILURE);
  }
}

void save_candlestick_data(const char* symbol, candlestick* c)
{
  double mean ;
  float volume;
  if(c->total_trades == 0)
  {
    mean = 0.0;
    volume = 0;
  }
  else
  {
    mean = c->sum_prices / c->total_trades;
    volume = c->total_volume;
  }


  if(strcmp(symbol, "AMZN") == 0)
  {
    fprintf(fd_candlestick_amazon, "%.3lf, %.3lf, %.3lf, %.3lf, %.3f, %lld\n", c->open, c->close, c->max, c->min, c->total_volume, time_in_queue());
    add_mean_volume(amazon_mvg_avg, c->sum_prices, volume, c->total_trades);
  }

  else if(strcmp(symbol, "TSLA") == 0)
  {
    fprintf(fd_candlestick_tesla, "%.3lf, %.3lf, %.3lf, %.3lf, %.3f, %lld\n", c->open, c->close, c->max, c->min, c->total_volume, time_in_queue());
    add_mean_volume(tesla_mvg_avg, c->sum_prices, volume, c->total_trades);
  }

  else if(strcmp(symbol, "NVDA") == 0)
  {
    fprintf(fd_candlestick_nvda, "%.3lf, %.3lf, %.3lf, %.3lf, %.3f, %lld\n", c->open, c->close, c->max, c->min, c->total_volume, time_in_queue());
    add_mean_volume(nvda_mvg_avg, c->sum_prices, volume, c->total_trades);
  }

  else if(strcmp(symbol, "BINANCE:E") == 0)
  {
    fprintf(fd_candlestick_ethereum, "%.3lf, %.3lf, %.3lf, %.3lf, %.3f, %lld\n", c->open, c->close, c->max, c->min, c->total_volume, time_in_queue());
    add_mean_volume(ethereum_mvg_avg, c->sum_prices, volume, c->total_trades);
  }
  else
  {
    fprintf(stderr, COLOR_RED"Error! No symbol with that name(candlestick)\n"COLOR_RESET);
    kill(getpid(), SIGINT);
    exit(EXIT_FAILURE);
  }
  printf("MEAN : %lf\n", mean);
}

void save_moving_average(const char* symbol, double mvg_avg, long volume)
{
   if(strcmp(symbol, "AMZN") == 0)
    fprintf(fd_moving_avg_amazon, "%s, %.3lf, %ld, %lld\n", symbol, mvg_avg, volume, time_in_queue());

  else if(strcmp(symbol, "TSLA") == 0)
    fprintf(fd_moving_avg_tesla, "%s, %.3lf, %ld, %lld\n", symbol, mvg_avg, volume, time_in_queue());


  else if(strcmp(symbol, "NVDA") == 0)
    fprintf(fd_moving_avg_nvda, "%s, %.3lf, %ld, %lld\n", symbol, mvg_avg, volume, time_in_queue());


  else if(strcmp(symbol, "BINANCE:E") == 0)
    fprintf(fd_moving_avg_ethereum, "%s, %.3lf, %ld, %lld\n", symbol, mvg_avg, volume, time_in_queue());

  else
  {
    fprintf(stderr, COLOR_RED"Error! No symbol with that name(moving average)\n"COLOR_RESET);
    kill(getpid(), SIGINT);
    //exit(EXIT_FAILURE);
  }
}

void candlestick_init(candlestick* c)
{
  c->open = 0.0;
  c->close = 0.0;
  c->max = 0.0;
  c->min = 0.0;
  c->sum_prices = 0.0;
  c->total_trades = 0;
  c->total_volume = 0.0;
  c->first_time = true;
}

void create_candlestick(candlestick* c, trade* t)
{
  double price = t->price;//strtod(t->price, NULL);
  // first we check if this is the first trade of the minute
  if(c->first_time && price > 0.0)
  {
    c->open = price;
    c->close = price;
    c->min = price;
    c->max = price;
  }
  // if it is not the first trade of the minute we save the values accordingly
  if(!c->first_time && price > 0.0)
  {
    c->close = price;
    if(c->max < price)
    {
      c->max = price;
    }

    if(c->min > price)
    {
      c->min = price;
    }
  }
  //c->total_volume += strtol(t->volume, NULL, 10);
  c->total_volume += t->volume;//strtof(t->volume, NULL);
  c->sum_prices += price;
  c->total_trades += 1;
  c->first_time = false;
}


void moving_avg_init(moving_avg* mvg_avg)
{ 
  // initializing the fields of the moving average struct
  for(int i = 0; i < NUM_VALUES; i++)
  {
    mvg_avg->total_prices[i] = 0.0;
    mvg_avg->volume[i] = 0;
  }

  mvg_avg->index = 0;
  mvg_avg->count = 0;
}

void add_mean_volume(moving_avg* mvg_avg, double total, float volume, long total_trades)
{
  // store the values into a circular buffer with max storage of 15 values
  mvg_avg->total_prices[mvg_avg->index] = total;
  mvg_avg->total_trades[mvg_avg->index] = total_trades;
  mvg_avg->volume[mvg_avg->index] = volume;
  mvg_avg->index = (mvg_avg->index + 1) % NUM_VALUES;
  if(mvg_avg->count < NUM_VALUES)
  {
    mvg_avg->count += 1;
  }
  if(total < 0.1)
    found_zero += 1;
}

float total_volume(moving_avg* mvg_avg)
{
  float total_volume = 0.0 ;

  if(mvg_avg->count == 0)
    return 0;

  for(int i = 0; i < mvg_avg->count; i++)
  {
    total_volume += mvg_avg->volume[i];
  }

  return total_volume;
}

double calculate_mvg_avg(moving_avg* mvg_avg)
{
    double sum = 0.0;
    long total_trades = 0;
    
    if(mvg_avg->count == 0)
    {
      return 0;
    }
    for(int i = 0; i < mvg_avg->count; i++)
    {
      sum += mvg_avg->total_prices[i];
      total_trades += mvg_avg->total_trades[i];
    }

    if(sum < 0.1)
        return 0;

    printf("Total Trades : %ld\n", total_trades);
    double ma = (sum / total_trades);
    return ma;
}

int count_lines(FILE* fd, long start_position) {
    fseek(fd, start_position, SEEK_SET); // Move to the starting position

    int total_number = 0;
    char line[300];

    while (fgets(line, sizeof(line), fd) != NULL) {
        total_number += 1;
    }

    fseek(fd, start_position, SEEK_SET); // Reset the file pointer to the starting position
    return total_number;
}

unsigned long long int time_in_queue()
{
  // function to return the current time in UNIX timestamp
    unsigned long long int deque = 0;
    struct timeval tv;
    gettimeofday(&tv, NULL);

    deque = (unsigned long long int)(tv.tv_sec) * 1000 + (unsigned long long int)(tv.tv_usec)/1000;
    return deque;
}

void cleanup()
{
    // function to free the allocated memory
    // close the files
    // and destroy the queue, the mutexes and the conditions
    printf(COLOR_RED"Cleaning Up ...\n"COLOR_RESET);
    
    lws_context_destroy(context);
    free(amazon_candlestick);
    free(tesla_candlestick);
    free(nvda_candlestick);
    free(ethereum_candlestick);

    free(amazon_mvg_avg);
    free(tesla_mvg_avg);
    free(nvda_mvg_avg);
    free(ethereum_mvg_avg);

    fclose(fd_amazon);
    fclose(fd_tesla);
    fclose(fd_nvda);
    fclose(fd_ethereum);

    fclose(fd_candlestick_amazon);
    fclose(fd_candlestick_tesla);
    fclose(fd_candlestick_nvda);
    fclose(fd_candlestick_ethereum);

    fclose(fd_moving_avg_amazon);
    fclose(fd_moving_avg_tesla);
    fclose(fd_moving_avg_nvda);
    fclose(fd_moving_avg_ethereum);

    pthread_mutex_destroy(mutex_candlestick);
    free(mutex_candlestick);
    pthread_mutex_destroy(connection_mutex);
    free(connection_mutex);
    pthread_cond_destroy(done);
    free(done);
    pthread_cond_destroy(minute);
    free(minute);
    queueDelete (fifo);
    printf(COLOR_BLUE"Cleaned\n"COLOR_RESET);
}