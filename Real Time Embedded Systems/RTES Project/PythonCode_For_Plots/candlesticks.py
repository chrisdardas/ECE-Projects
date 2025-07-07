import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from mplfinance.original_flavor import candlestick_ohlc
import pytz

# Function to read and prepare data for a candlestick chart with timezone conversion
def prepare_data(file_name, local_tz):
    df = pd.read_csv(file_name) # read the csv file and convert into DataFrame

    df.columns = df.columns.str.strip() # removes whitespaces

    df['Creation Time'] = pd.to_numeric(df['Creation Time']) / 1000  # Convert milliseconds to seconds

    # Convert 'Creation Time' to UTC datetime and then to local timezone
    df['Date'] = pd.to_datetime(df['Creation Time'], unit='s', utc=True)  # Convert to UTC datetime
    df['Date'] = df['Date'].dt.tz_convert(local_tz)  # Convert to local timezone

    df['Date'] = df['Date'].apply(mdates.date2num) # convert the date to matplotlib data

    df['Time Difference'] = df['Creation Time'].diff() # calculate the difference between the current and the previous candlestick


    # Convert the columns of the DataFrame into numeric values
    df['Open'] = pd.to_numeric(df['Open'])
    df['Close'] = pd.to_numeric(df['Close'])
    df['Max'] = pd.to_numeric(df['Max'])
    df['Min'] = pd.to_numeric(df['Min'])

    # Comment these two lines to plot the candlesticks without the zeros
    # Un-comment these two lines to plot the delays between two candlesticks
    non_zero_candles = (df['Open'] != 0) & (df['Close'] != 0) & (df['Max'] != 0) & (df['Min'] != 0) & (df['Volume'] != 0) # Ignoring zero value candlesticks
    df = df[non_zero_candles]

    return df[['Date', 'Open', 'Max', 'Min', 'Close', 'Time Difference', 'Volume']]


local_timezone = pytz.timezone('Europe/Athens')

# Get the candlestick data for the 4 symbols
amazon   = prepare_data('amazon_candlestick.csv', local_timezone)
nvidia   = prepare_data('nvda_candlestick.csv', local_timezone)
tesla    = prepare_data('tesla_candlestick.csv', local_timezone)
ethereum = prepare_data('ethereum_candlestick.csv', local_timezone)


fig, axs = plt.subplots(2, 2, figsize=(12, 10))
fig.suptitle("Candlestick Charts", color='white')

fig.patch.set_facecolor('#121212')

axes = axs.flatten()

data = [amazon, nvidia, tesla, ethereum]
colors = ['blue', 'green', 'red', 'yellow']
titles = ['Amazon', 'Nvidia', 'Tesla', 'Ethereum']


for i, (ax, ohlc, title) in enumerate(zip(axes, [amazon[1:-1], nvidia[:-1], tesla[:-1], ethereum[:-1]], titles)):
    ax.grid(True)
    ax.set_axisbelow(True)
    ax.set_facecolor('black')
    ax.set_title(f"{title} Candlestick Chart", color='white')
    ax.set_xlabel("Date", color='white')
    ax.set_ylabel("Price", color='white')
    ax.tick_params(axis='x', colors='white', labelrotation=0)
    ax.tick_params(axis='y', colors='white')


    ax.xaxis_date()
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%H:%M'))

    candlestick_ohlc(ax, ohlc.values, width=0.0005, colorup='#00ff00', colordown='red') # Plot of the candlestick




fig_diff, axs_diff = plt.subplots(2, 2, figsize=(12, 10))
fig_diff.suptitle("Candlestick Time Differences", color='white')
fig_diff.patch.set_facecolor('#121212')
axs_diff = axs_diff.flatten()
for i, df in enumerate(data):
    axs_diff[i].plot(df['Time Difference'][1:-1], color= colors[i])
    axs_diff[i].grid(True)
    axs_diff[i].set_axisbelow(True)
    axs_diff[i].set_title(titles[i], color='white')
    axs_diff[i].set_facecolor('black')
    axs_diff[i].tick_params(colors='white')
    axs_diff[i].set_xlabel('Minutes', color='white')
    axs_diff[i].set_ylabel('Time Difference From The Previous Candlestick', color='white')
    axs_diff[i].tick_params(axis='x', colors='white')
    axs_diff[i].tick_params(axis='y', colors='white')


fig_vol, ax_vol = plt.subplots(2, 2, figsize=(12, 10))
fig_vol.suptitle("Volumes", color='white')
fig_vol.patch.set_facecolor('#121212')
ax_vol = ax_vol.flatten()

for i, df in enumerate(data):
    ax_vol[i].plot(df['Volume'], color=colors[i])
    ax_vol[i].grid(True)
    ax_vol[i].set_axisbelow(True)
    ax_vol[i].set_title(titles[i], color='white')
    ax_vol[i].set_facecolor('black')
    ax_vol[i].tick_params(color='white')
    ax_vol[i].set_xlabel('Minutes', color='white')
    ax_vol[i].set_ylabel('Volume', color='white')
    axs_diff[i].tick_params(axis='x', colors='white')
    axs_diff[i].tick_params(axis='y', colors='white')

plt.tight_layout()
plt.subplots_adjust(top=0.95)  # Adjust to leave space for the title
plt.show()

