/*
 *	File	: pc.c
 *
 *	Title	: Demo PRODUCERSducer/CONSUMERSsumer.
 *
 *	Short	: A solution to the PRODUCERSducer CONSUMERSsumer PRODUCERSblem using
 *		pthreads.	
 *
 *	Long 	:
 *
 *	Author	: Andrae Muys
 *
 *	Date	: 18 September 1997
 *
 *	Revised	:
 */

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>


#define QUEUESIZE 10
#define LOOP 100000
#define PRODUCERS 10
#define CONSUMERS 32
#define M_PI 3.14159265358979323846

//FILE* myFile;

typedef struct
{
  void* (*work)(void*);
  void* arg;
}workFunction;

typedef struct {
  workFunction buf[QUEUESIZE];
  long head, tail;
  int full, empty;
  pthread_mutex_t *mut;
  pthread_cond_t *notFull, *notEmpty;
} queue;


void *producer (void *args);
void *consumer (void *args);
queue *queueInit (void);
void queueDelete (queue *q);
void queueAdd (queue *q, workFunction in);
void queueDel (queue *q, workFunction *out);
void* calculateSine(void* arg);

struct timeval start;
struct timeval end;
unsigned long e_usec;

/*

Να λειτουργεί με p νήματα producer που βάζουν στην κοινή ουρά δείκτες σε συναρτήσεις με την παραπάνω δομή, και q νήματα consumer που παίρνουν τους δείκτες από την ουρά, και εκτελούν τη συνάρτηση.
 Οι συναρτήσεις στην ουρά κάνουν κάτι απλό, πχ υπολογίζουν το ημίτονο για δέκα γωνίες. To νήμα producer φροντίζει τα ορισματα να έχουν νόημα, και να είναι έτοιμα προς ανάγνωση και εγγραφή.

*/

void sigintHandler(int signal)
{
  //fclose(myFile);
  //printf("\n\t\tClosing the File and Exiting...\n");
  exit(0);
}



int main ()
{
  srand(time(NULL));
  
  signal(SIGINT, sigintHandler);
  //myFile = fopen("test.txt", "w");
  

  queue *fifo;
  pthread_t pro[PRODUCERS], con[CONSUMERS];

  fifo = queueInit ();
  if (fifo ==  NULL) {
    fprintf (stderr, "main: Queue Init failed.\n");
    exit (1);
  }
  for(int i = 0 ; i < PRODUCERS ; i++)
  {
    if(pthread_create(&pro[i], NULL, producer, (void*) fifo) != 0)
    {
      printf("Error creating producer threads\n");
      exit(EXIT_FAILURE);
    }
  }

  for(int i = 0 ; i < CONSUMERS; i++)
  {
    if(pthread_create(&con[i], NULL, consumer, (void*) fifo) != 0)
    {
      printf("Error creating consumer threads\n");
      exit(EXIT_FAILURE);
    }
  }

  for(int i = 0 ; i < PRODUCERS; i++)
  {
    if(pthread_join(pro[i], NULL) != 0)
    {
      printf("Error joining producer threads\n");
      exit(EXIT_FAILURE);
    }
  }
  for(int i = 0; i < CONSUMERS; i++)
  {
    if(pthread_join(con[i], NULL) != 0)
    {
      printf("Error joining consumer threads\n");
      exit(EXIT_FAILURE);
    }
  }
  
  queueDelete (fifo);

  return 0;
}

void *producer (void *q)
{
  queue *fifo;
  int i;
  workFunction w;

    

  fifo = (queue *)q;

  for (i = 0; i < LOOP; i++) {
    pthread_mutex_lock (fifo->mut);

    double* matrix = (double*)malloc(sizeof(double) * 10);

    for(int j = 0 ; j < 10; j++)
    {
      matrix[j] = ((double)rand() / RAND_MAX) * 2 * M_PI - M_PI; // create a random angle between -100 and 100 rads
      //printf("matrix[%d] = %lf\n", j, matrix[j]);
    }
  
    w.arg = (void*)matrix;
    w.work = calculateSine;
    
   

    while (fifo->full) {
      //printf ("Producer: queue FULL.\n");
      pthread_cond_wait (fifo->notFull, fifo->mut);
    }

    gettimeofday(&start, 0);
    queueAdd (fifo, w);
    
    pthread_mutex_unlock (fifo->mut);
    pthread_cond_signal (fifo->notEmpty);
  }

  return (NULL);
}

void *consumer (void *q)
{
  queue *fifo;
  workFunction d;


  fifo = (queue *)q;

  while (1) {
    pthread_mutex_lock (fifo->mut);
    while (fifo->empty) {
      //printf ("Consumer: queue EMPTY.\n");
      pthread_cond_wait (fifo->notEmpty, fifo->mut);
    }

    queueDel (fifo, &d);
    d.work(d.arg);
    free(d.arg);
    pthread_mutex_unlock (fifo->mut);
    pthread_cond_signal (fifo->notFull);

  }

  return (NULL);
}

/*
  typedef struct {
  int buf[QUEUESIZE];
  long head, tail;
  int full, empty;
  pthread_mutex_t *mut;
  pthread_CONSUMERSd_t *notFull, *notEmpty;
  } queue;
*/

queue *queueInit (void)
{
  queue *q;

  q = (queue *)malloc (sizeof (queue));
  if (q == NULL) return (NULL);

  q->empty = 1;
  q->full = 0;
  q->head = 0;
  q->tail = 0;
  q->mut = (pthread_mutex_t *) malloc (sizeof (pthread_mutex_t));
  pthread_mutex_init (q->mut, NULL);
  q->notFull = (pthread_cond_t *) malloc (sizeof (pthread_cond_t));
  pthread_cond_init (q->notFull, NULL);
  q->notEmpty = (pthread_cond_t *) malloc (sizeof (pthread_cond_t));
  pthread_cond_init (q->notEmpty, NULL);
	
  return (q);
}

void queueDelete (queue *q)
{
  pthread_mutex_destroy (q->mut);
  free (q->mut);	
  pthread_cond_destroy (q->notFull);
  free (q->notFull);
  pthread_cond_destroy (q->notEmpty);
  free (q->notEmpty);
  free (q);
}

void queueAdd (queue *q, workFunction in)
{
  q->buf[q->tail] = in;
  q->tail++;
  if (q->tail == QUEUESIZE)
    q->tail = 0;
  if (q->tail == q->head)
    q->full = 1;
  q->empty = 0;

  return;
}

void queueDel (queue *q, workFunction *out)
{
  *out = q->buf[q->head];
  gettimeofday(&end, 0);
  e_usec = ((end.tv_sec * 1000000) + end.tv_usec) - ((start.tv_sec * 1000000) + start.tv_usec);
  //fprintf(myFile, "%lu\n", e_usec);
  //fprintf(myFile, "%lu\n", e_usec);
  //printf("%lu\n", e_usec);
  //printf("elapsed time: %lu microseconds\n", e_usec);
  //printf("======================================================================\n");
  printf("%lu\n",e_usec);

  q->head++;
  if (q->head == QUEUESIZE)
    q->head = 0;
  if (q->head == q->tail)
    q->empty = 1;
  q->full = 0;

  return;
}

void* calculateSine(void* arg)
{
  double* matrix = (double*)malloc(sizeof(double) * 10);
  matrix = (double *)arg;
  double* returnMatrix = (double*)malloc(sizeof(double) * 10);
  
  for(int i = 0 ; i < 10; i++)
  {
    returnMatrix[i] = sin(matrix[i]);
    //printf("Sine of %lf is %lf\n", matrix[i], returnMatrix[i]);
  }
  free(returnMatrix);
  return NULL;
}
