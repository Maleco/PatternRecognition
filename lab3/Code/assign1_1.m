% Consider two normal distributions with different means μ 1 = 5 and μ 2 = 7 (μ 1 < μ 2 )
% and equal variances σ 2 = 4 (see Fig.2.19 in book or lecture sheets). Let x ∗ be the value
% of a decision criterion used to classify an object having a feature with value x in class
% ω 1 for x < x ∗ and in class ω 2 for x ≥ x ∗ .

% The integral of the first distribution (with mean μ 1 ) for values of x ≥ x ∗ specifies the
% probability of wrongly classifying an object from class ω 1 into class ω 2 to be referred to
% as a false alarm. The integral of the second distribution for values of x ≥ x ∗ specifies the
% probability of correctly classifying an object from class ω 2 into class ω 2 , to be referred
% to as a hit.

% 1. Choose a value of x ∗ and compute the probabilities of hit (h) and false alarm (fa).
%x* = 6
% hit = integral 6 to inf for dist 2 = 1 - integral -inf to 6 = 
1 - normcdf(6, 7, 2)
% fa = integral 6 to inf for dist 1 = 1 - integral -inf to 6 = 
1 - normcdf(6, 5, 2)

% Plot the point (fa, h) in a graph with horizontal axis fa and vertical axis h. 
%Choose a few
% other values of x ∗ in the interval [μ 1 − 3σ; μ 2 + 3σ] (-1 ; 13) 
% and plot the corresponding (fa, h) points too.
x = [];y1 = [];y2 = [];y3 = [];
for xStar = -1:0.1:13
    x(end+1) = (1 - normcdf(xStar, 5, 2));
    y1(end+1) = (1 - normcdf(xStar, 7, 2));
    y2(end+1) = (1 - normcdf(xStar, 9, 2));
    y3(end+1) = (1 - normcdf(xStar, 11, 2));
    
    
end
plot(x,x)
hold on
plot(x,y1)
plot(x,y2)
plot(x,y3)
xlabel('False alarm')
ylabel('Hit')
legend('random', '\mu2 = 7','\mu2 = 9','\mu2 = 11')

% Repeat the computation of a ROC curve for the cases μ 2 = 9 and μ 2 = 11 and plot all
% three ROC curves in the same diagram. What is the value of the discriminability d for
% each of these cases?
% D(9) = (9-5)/2 = 2, 
% D(11) = (11-5)/2 = 3