% Assignment 4: independent identically distributed random binary variables.
% We play a game of “random walk”

% Every player starts at 0.
% Each turn every player tosses a coin.
% Head → Lose and don’t move.
% Tail → Advance one position.

% 1. Simulate a game where 1000000 people play for 100 turns. Make a plot of the number of
% people that end on a specific end-point. What does this distribution resemble? Explain
% why. What would be the theoretical mean and variance of this distribution?
output = zeros(100,1);
for i=1:1000000
    step = 0;
    for j = 1:100
        if rand > 0.5
            % Move forward
            step = step + 1;
        end
    end
    output(step) = output(step) + 1;
end

plot(output)
        
% This plot resembles the binomial distribution with a mean of 50 and a
% chance of 0.5. 
% Each person that tosses a coin a 100 times can be viewed as a random draw
% from the binomial distribution with a chance P of 0.5 because of the 50/50 chances of the coin flip,
% and thus a mean of 100 throws * 0.5 = 50 positions advanced.
% The 1000000 people together form 1000000 draws from this binomial
% distribution, and by plotting them, an approximation of the distribution
% is shown.

% By tossing a coin 100 times (N) with a 50% chance to go forward (P),
% the theoretical mean would be N*P or 100*0.5 = 50
% The variance would be N*P(1-P) = 100*0.5(1-0.5) = 25