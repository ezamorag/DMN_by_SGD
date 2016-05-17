function [W,B] = dividing_at_half(w,b,id)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   w is a position vector for a hyperbox
%   b is a size vector for a hyperbox 
%   id is the dimension where the hyperbox is divided

% Output:
%   W is a matrix that constains position vectors for a hyperbox in each column 
%   B is a matrix that constains size vectors for a hyperbox in each column  

W = [w w];
B = [b b];
B(id,:) = B(id,:)/2;
W(id,2) = W(id,2) + b(id)/2;