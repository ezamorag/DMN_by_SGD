function [W,B] = dividing_hb(w,b,n)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   w is a position vector for a hyperbox
%   b is a size vector for a hyperbox 
%   n is the number of times the hyperbox is divided

% Output:
%   W is a matrix that constains position vectors for a hyperbox in each column 
%   B is a matrix that constains size vectors for a hyperbox in each column  

if n > size(w,1), error('n must be less than dimensions'), end

ListW = w;
ListB = b;
for k=1:n
    Q = size(ListW,2);
    nListW = [];
    nListB = [];
    for q=1:Q
        [W,B] = dividing_at_half(ListW(:,q),ListB(:,q),k);
        nListW = [nListW W];
        nListB = [nListB B];
    end
    ListW = nListW;
    ListB = nListB;
end
W = ListW;
B = ListB;