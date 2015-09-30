% Compute the values of the hit rate h and the false alarm rate fa and plot the point
% (fa, h) in the plot computed in assignment 1.1 above. This point lies on a ROC curve
hitrate= sum(outcomes(:,1) == 1 & outcomes(:,2) == 1)/length(outcomes)
false =  sum(outcomes(:,1) == 0 & outcomes(:,2) == 1)/length(outcomes)
plot(false,hitrate, 'x')
% with a given disciminability value d . Determine this value by trial and error, i.e. taking
% different values d and drawing the corresponding ROC curves until you find a value of d
% for which the corresponding ROC curve passes through the experimentally determined
% point.

% x = [];y4 = [];
% for xStar = -1:0.1:13
%     x(end+1) = (1 - normcdf(xStar, 5, 2));
%     y4(end+1) = (1 - normcdf(xStar, 8.08917676, 2));
% end
% plot(x,y4)

x = [];y4 = [];
for xStar = -100:.1:100
    x(end+1) = (1 - normcdf(xStar, 5, 2));
    y4(end+1) = (1 - normcdf(xStar, 8, 2));
end 
plot(x,y4)

% So d' is 1.5
% Found by trial and error with two distributions with sigma = 1.
