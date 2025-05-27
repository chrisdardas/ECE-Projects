import pandas as pd
import matplotlib.pyplot as plt

def prepare_data(filename):
    df = pd.read_csv(filename)

    df.columns = df.columns.str.strip()

    df['Moving Average']  = pd.to_numeric(df['Moving Average'])
    df['Creation Time']   = pd.to_numeric(df['Creation Time']) / 1000
    df['Time Difference'] = df['Creation Time'].diff()

    # Comment these two lines to plot the moving averages without the zeros
    # Un-comment these two lines to plot the delays between two moving averages
    #non_zero = (df['Moving Average'] != 0)
    #df = df[non_zero]
    return df[['Moving Average', 'Time Difference', 'Creation Time', 'Total Volume']]


amazon   = prepare_data('amazon_moving_average.csv')
nvidia   = prepare_data('nvda_moving_average.csv')
tesla    = prepare_data('tesla_moving_average.csv')
ethereum = prepare_data('ethereum_moving_average.csv')


data = [amazon, nvidia, tesla, ethereum]
titles = ['Amazon', 'Nvidia', 'Tesla', 'Ethereum']
colors = ['blue', 'green', 'red', 'yellow']

fig_mvg, axs_mvg = plt.subplots(2, 2, figsize=(12, 10))
fig_mvg.suptitle("Moving Average", color='white')
fig_mvg.patch.set_facecolor('#121212')
axs_mvg = axs_mvg.flatten()

for i, df in enumerate(data):
    axs_mvg[i].plot(df['Moving Average'], color=colors[i])
    axs_mvg[i].grid(True)
    axs_mvg[i].set_axisbelow(True)
    axs_mvg[i].set_title(titles[i], color='white')
    axs_mvg[i].set_facecolor('black')
    axs_mvg[i].tick_params(colors='white')
    axs_mvg[i].set_xlabel('Minutes', color='white')
    axs_mvg[i].set_ylabel('Moving Average', color='white')
    axs_mvg[i].tick_params(axis='x', colors='white')
    axs_mvg[i].tick_params(axis='y', colors='white')

fig_diff, axs_diff = plt.subplots(2, 2, figsize=(12, 10))
fig_diff.suptitle("Moving Average Time Differences", color='white')
fig_diff.patch.set_facecolor('#121212')
axs_diff = axs_diff.flatten()
for i, df in enumerate(data):
    print(f"{titles[i]} Time Difference Min: {df['Time Difference'].min()}")
    print(f"{titles[i]} Time Difference Max: {df['Time Difference'].max()}")
    axs_diff[i].plot(df['Time Difference'], color= colors[i])
    axs_diff[i].grid(True)
    axs_diff[i].set_axisbelow(True)
    axs_diff[i].set_title(titles[i], color='white')
    axs_diff[i].set_facecolor('black')
    axs_diff[i].tick_params(colors='white')
    axs_diff[i].set_xlabel('Minutes', color='white')
    axs_diff[i].set_ylabel('Time Difference From The Previous Average', color='white')
    axs_diff[i].tick_params(axis='x', colors='white')
    axs_diff[i].tick_params(axis='y', colors='white')

fig_vol, ax_vol = plt.subplots(2, 2, figsize=(12, 10))
fig_vol.suptitle("Volumes", color='white')
fig_vol.patch.set_facecolor('#121212')
ax_vol = ax_vol.flatten()

for i, df in enumerate(data):
    ax_vol[i].plot(df['Total Volume'], color=colors[i])
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
plt.subplots_adjust(top=0.9)
plt.show()







