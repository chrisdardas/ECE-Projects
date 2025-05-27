import pandas as pd
import matplotlib.pyplot as plt

def prepare_data(filename):
    df = pd.read_csv(filename)

    df.columns = df.columns.str.strip()

    df['Timestamp'] = pd.to_numeric(df['Timestamp']) / 1000
    df['Time Received'] = pd.to_numeric(df['Time Received']) / 1000
    df['Actual Time'] = pd.to_numeric(df['Actual Time']) / 1000

    df['FinnHub Delay'] = df['Time Received'].sub(df['Timestamp'], axis=0)
    df['Consuming Delay'] = df['Actual Time'].sub(df['Time Received'], axis=0)

    return df[['FinnHub Delay', 'Consuming Delay']]

amazon   = prepare_data('amazon_trade_data.csv')
nvidia   = prepare_data('nvda_trade_data.csv')
tesla    = prepare_data('tesla_trade_data.csv')
ethereum = prepare_data('ethereum_trade_data.csv')

data = [amazon, nvidia, tesla, ethereum]
titles = ['Amazon', 'Nvidia', 'Tesla', 'Ethereum']
colors = ['blue', 'green', 'red', 'yellow']

# Create a figure for FinnHub delays
fig_finnhub, axs_finnhub = plt.subplots(2, 2, figsize=(12, 10))
fig_finnhub.suptitle("FinnHub Delays", color='white')
fig_finnhub.patch.set_facecolor('#121212')
axs_finnhub = axs_finnhub.flatten()

# Plot FinnHub delays
for i, df in enumerate(data):
    axs_finnhub[i].plot(df['FinnHub Delay'], color=colors[i])
    axs_finnhub[i].grid(True)
    axs_finnhub[i].set_axisbelow(True)
    axs_finnhub[i].set_title(titles[i], color='white')
    axs_finnhub[i].set_facecolor('black')
    axs_finnhub[i].tick_params(colors='white')
    axs_finnhub[i].set_xlabel('Number Of Trades', color='white')
    axs_finnhub[i].set_ylabel('Delay In Milliseconds', color='white')
    axs_finnhub[i].tick_params(axis='x', colors='white')
    axs_finnhub[i].tick_params(axis='y', colors='white')


# Create a figure for Consuming delays
fig_consuming, axs_consuming = plt.subplots(2, 2, figsize=(12, 10))
fig_consuming.suptitle("Consuming Delays", color='white')
fig_consuming.patch.set_facecolor('#121212')
axs_consuming = axs_consuming.flatten()

# Plot Consuming delays
for i, df in enumerate(data):
    axs_consuming[i].plot(df['Consuming Delay'][:-5], color=colors[i])
    axs_consuming[i].grid(True)
    axs_finnhub[i].set_axisbelow(True)
    axs_consuming[i].set_title(titles[i], color='white')
    axs_consuming[i].set_facecolor('black')
    axs_consuming[i].tick_params(colors='white')
    axs_consuming[i].set_xlabel('Number Of Trades', color='white')
    axs_consuming[i].set_ylabel('Delay In Milliseconds', color='white')


plt.tight_layout()
plt.subplots_adjust(top=0.9)
plt.show()

