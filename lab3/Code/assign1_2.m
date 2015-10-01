% Compute the values of the hit rate h and the false alarm rate fa and plot the point (fa, h) in the plot computed in assignment 1.1 above. This point lies on a ROC curve

hitrate= sum(outcomes(:,1) == 1 & outcomes(:,2) == 1)/length(outcomes)
false =  sum(outcomes(:,1) == 0 & outcomes(:,2) == 1)/length(outcomes)
plot(false,hitrate, 'x')

% with a given disciminability value d . Determine this value by trial and error.

x = [];y4 = [];
for xStar = -100:.1:100
    x(end+1) = (1 - normcdf(xStar, 5, 2));
    y4(end+1) = (1 - normcdf(xStar, 8, 2));
end 
plot(x,y4)
legend('Hits = False alarms', '\mu2 = 7','\mu2 = 9','\mu2 = 11', 'calculated (fa, h) point', 'ROC curve of estimated d accent', 'Location','east')
% So d' is approximately 1.5.
