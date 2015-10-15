function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)

% Batch Neural Gas
%   Data contains data,
%   n is the number of clusters,
%   epoch the number of iterations,
%   xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2

% % TEst
% dat = kmeans1;
% n = 100;
% epochs = 1;

error(nargchk(3, 5, nargin));  % check the number of input arguments
if (nargin<4)
    xdim=1; ydim=2;   % default plot values
end;

[dlen,dim] = size(Data);

%prototypes =  % small initial values
% % or
sbrace = @(x,y)(x{y});
fromfile = @(x)(sbrace(struct2cell(load(x)),1));
prototypes=fromfile('clusterCentroids.mat');


lambda0 = n/2; %initial neighborhood value
% lambda
lambda = lambda0 * (0.01/lambda0).^([0:(epochs-1)]/epochs);
% note: the lecture slides refer to this parameter as sigma^2
%       instead of lambda

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Action

for i=1:epochs,
    datestr(now)
    i
    D_prototypes = zeros(n,dim);   % difference for vectors is initially zero
    D_prototypes_av = zeros(n,1);       % the same holds for the quotients
    
    for j=1:dlen,  % consider all points at once for the batch update
        
        % sample vector
        x = Data(j,:); % sample vector
        X = x(ones(n,1),:);  % we'll need this
        
        % neighborhood ranking
        
        % Distances (sorted) to each prototype
        % 1st column = distance
        % 2d column = prototype index
        distances = sortrows([pdist2(x, prototypes); 1:n].');
        % 3d column = rank
        ranks = [distances.'; 1:n].';
        % Sort according to prototype index
        ranks = sortrows(ranks, 2);
        
        % 1-BMU, 2-BMU, etc. (hint:sort)
        %find ranking,h,H
        
        % accumulate update
        D_prototypes = D_prototypes + (exp((-1*ranks(:,3))/lambda(i)) * x);
        D_prototypes_av = D_prototypes_av + exp((-1*ranks(:,3))/lambda(i));
    end
    D_prototypes = D_prototypes ./ [D_prototypes_av D_prototypes_av];
    
    % update
    prototypes = D_prototypes ;
    
    %plot after 20, 100, 200, and 500 epochs
%     if 1,
    if sum(i == [20, 100, 200, 500])
        figure();
        fprintf(1,'%d / %d \r',i,epochs);
        hold off
        plot(Data(:,xdim),Data(:,ydim),'bo','markersize',3)
        hold on
        plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3)
        % write code to plot decision boundaries
        %     ...
        %     plot decision boundaries here
        %     ...
        %pause
        %or
        voronoi(prototypes(:,xdim),prototypes(:,ydim));
        drawnow
        print(sprintf('../Report/NeuralGas_%d', i), '-depsc');
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
