function [PHsub, THsub, P, T] = extract_samples(Hsub,P,T)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   Hsub is a sub-hyperbox
%   P is a matrix that contains the remaining training samples 
%   T is a vector that contains the clases for remaining training samples

% Output:
%   PHsub is a matrix containing the training samples that are inside of
%       the sub-hyperbox Hsub
%   THsub is a vector containing the clases for PHsub
%   P is a matrix that contains the training samples outside of Hsub
%   T is a vector that contains the clases for the training samples outside 
%       of Hsub

% Important note: the global variable "tol" avoids infinity recursions due 
%       to the small numerical errors 
global tol

N = size(Hsub,1)/2;
Pmin = Hsub(1:N);
Pmax = Hsub(N+1:end);
Q = size(P,2);
cond1 = (P >= Pmin(:,ones(Q,1)) - tol);  
cond2 = (P <= Pmax(:,ones(Q,1)) + tol);
ind = find(sum(cond1 & cond2)==N);
PHsub = P(:,ind);
THsub = T(:,ind);
P(:,ind) = [];
T(:,ind) = [];

