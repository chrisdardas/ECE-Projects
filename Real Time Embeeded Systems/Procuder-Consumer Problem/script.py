import matplotlib.pyplot as plt
import subprocess
import signal

def ExpectedValue(time):
    n = len(time)
    prob = 1 / n
    
    expected = 0
    
    for i in range(n):
        expected += time[i] * prob
        
    return expected

def changeConsumerNumber(C_File, consumerNumber):
    with open(C_File, 'r') as f:
        lines = f.readlines()
        
        
    for i, line in enumerate(lines):
        for key, value in consumerNumber.items():
            if f"#define {key}" in line:
                lines[i] = f"#define {key} {value}\n"
                break
            
    with open(C_File, 'w') as f:
        f.writelines(lines)
        
        
def changeQueueNumber(C_File, queueNumber):
    with open(C_File, 'r') as f:
        lines = f.readlines()
        
        
    for i, line in enumerate(lines):
        for key, value in queueNumber.items():
            if f"#define {key}" in line:
                lines[i] = f"#define {key} {value}\n"
                break
            
    with open(C_File, 'w') as f:
        f.writelines(lines)
        
        
def run_make(makefilePath):
    try:
        subprocess.run(["make", "-f", makefilePath], check=True)
        print("Makefile executed successfully.")
    except subprocess.CalledProcessError as error:
        print("Error running Makefile:", error)
        

def run_c_program(executablePath):
    filename = "/home/chris/cprogs/pitsianis/test.txt"
    try:
        with open(filename, 'w') as f:
            process = subprocess.Popen([executablePath], stdout=f)
            
            process.communicate(timeout = 60)  # Wait for the process to finish or timeout
            process.send_signal(signal.SIGINT)
    except subprocess.TimeoutExpired:
        with open(filename, 'r') as data:
            lines = data.readlines()
            line = lines
            time = [string.split() for string in line]
            time = [int(element) for sublist in time for element in sublist]
    return ExpectedValue(time)  


C_File = r"/home/chris/cprogs/pitsianis/producer_consumer.c"
makefilePath = "/home/chris/cprogs/pitsianis/Makefile"
executablePath = "/home/chris/cprogs/pitsianis/producer_consumer"
consumerNumber = {"CONSUMERS" : 100}
queueNumber = {"QUEUESIZE" : 10}

expected = []
consumers = []

for i in range(2, 42, 2):
    consumerNumber["CONSUMERS"] = i
    consumers.append(i)
    changeConsumerNumber(C_File, consumerNumber)
    run_make(makefilePath)
    expected.append(run_c_program(executablePath))
    
    
    
plt.plot(consumers, expected)
plt.xlabel("Consumers")
plt.ylabel("Expected Value of Time in uSeconds")
plt.grid(visible = 'on')
plt.show()

        










