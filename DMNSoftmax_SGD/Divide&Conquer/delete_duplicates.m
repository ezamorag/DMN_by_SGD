function [Pnew, Tnew] = delete_duplicates(P, T)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P is a matrix containing training samples, possibly with duplicates
%   T is a vector containing the clases for P

% Output:
%   Pnew is a matrix of training samples with NO duplicates
%   Tnew is a vector containing the clases for Pnew

Pnew = [];
Tnew = [];
N = size(P,1);
while ~isempty(P)
    Pnew = [Pnew P(:,1)];
    Tnew = [Tnew T(:,1)];
    ind = 1;
    for j=2:size(P,2)
        if sum(P(:,1) == P(:,j)) == N
            ind = [ind j];
        end
    end
    P(:,ind) = [];
    T(:,ind) = [];
end