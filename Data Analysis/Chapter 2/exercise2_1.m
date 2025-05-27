clc; 
clearvars;
close all;

% number smaller than 0.5 is heads 
% number greater than 0.5 is tails

n = 10; % number of repetitions

res = rand(n, 1); % generate values in [0, 1] from Uniform
tails = 0;

for k = 1:length(res)
    if res(k) > 0.5
        tails = tails + 1;
    end
end

prob = tails / n;
fprintf("Probability of tails : %f\n", prob);

n = 10:10:5000;
len = length(n);
heads = zeros(len, 1);
tails = zeros(len, 1);
prob_heads = zeros(len, 1);
prob_tails = zeros(len, 1);

for i=1:len
    res = rand(n(i), 1); % creating a column vector from Uniform 
    % length(res)
    for k=1:length(res)
        if res(k) > 0.5
            tails(i, 1) = tails(i, 1) + 1; % Adding values to tails vector
        else
            heads(i, 1) = heads(i, 1) + 1; % Adding values to heads vector
        end
    end
    prob_heads(i, 1) = heads(i, 1) / n(i); % calculating the probability
    prob_tails(i, 1) = tails(i, 1) / n(i);
end


% Graph Plotting
plot(n, prob_heads, 'r')
grid on;
hold on;
plot(n, prob_tails, 'b')
legend("Probability Of Heads", "Probability Of Tails");
xlabel('Number Of Samples')
ylabel('Probability')


