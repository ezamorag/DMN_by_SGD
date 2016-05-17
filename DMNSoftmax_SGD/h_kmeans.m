function dendrite = h_kmeans(X_train, y_train, centersPerCategory, y0)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   X_train is a matrix containing patterns in each row
%   y_train is a horizontal vector containing the clases for patterns in X_train
%   centersPerCategory: how many RBF centers to select per category. 
%   y0 adjusts the width of hyperboxes

% Output:
%   dendrite is a structure that constains the hyperboxes
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class, where
%       dendrite(c).W is a matrix that constains position vectors for a hyperbox in each column 
%       dendrite(c).B is a matrix that constains size vectors for a hyperbox in each column

N = size(X_train,2);
numCats = size(unique(y_train), 1);
for c = 1:numCats
    Xc = X_train((y_train == c), :);
    init_Centroids = Xc(1:centersPerCategory, :);
    [Centroids_c, memberships_c] = kMeans(Xc, init_Centroids, 100);    
    % Remove any empty clusters.
    toRemove = [];
    for (i = 1 : size(Centroids_c, 1))
        if (sum(memberships_c == i) == 0)        
            toRemove = [toRemove; i];
        end
    end
    if (~isempty(toRemove))
        Centroids_c(toRemove, :) = [];
        memberships_c = findClosestCentroids(Xc, Centroids_c);
    end

    % Compute betas for all the clusters.
    betas_c = computeRBFBetas(Xc, Centroids_c, memberships_c);
%     Centers = [Centers; Centroids_c];
%     betas = [betas; betas_c];
    
    
    deltax = sqrt(-log(y0)./betas_c);
    dendrite(c).W = Centroids_c' - repmat(deltax',N,1); 
    dendrite(c).B = 2*repmat(deltax',N,1);
end