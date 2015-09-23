% 1. Using the na ̈ıve Bayes rule, classify the following email texts as spam or non-spam:
% a) “We offer our dear customers a wide selection of class

% Following the Naive Bayes rules as shown on the slides (so calculating
% the ratio):
% P(spam|Customers,Watches)/P(non-spam|Customers,Watches) =
% p(customers|spam)/p(customers|non-spam)
% p(watches|spam)/p(watches|non-spam) p(spam)/p(non-spam) = 
(0.005/0.0001)*(0.0003/0.000004)*(0.9/0.1)
1-1/33750

% b) “Did you have fun on vacation? I sure did!”
% P(spam|Fun,Vacation)/P(non-spam|Fun,Vacation) =
% p(fun|spam)/p(fun|non-spam)*
% p(vacation|spam)/p(vacation|non-spam)*p(spam)/p(non-spam) = 
(0.00015/0.0007)*(0.00025/0.00014)*(0.9/0.1)