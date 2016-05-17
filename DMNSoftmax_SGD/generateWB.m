function [w, b] = generateWB(P,M)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P: matrix NxQbatch of patterns
%   M: scalar for distance margin of the hyperboxes

% Output:
%   w is the position vector for hyperbox
%   b is the size vector for hyperbox 

% if P = [] -> HB = []
if size(P,2) == 1
    error('A hyperbox enclosing a only one pattern is not possible to generate')
elseif isempty(P)
    error('A hyperbox enclosing no patterns is not possible to generate')
end
Pmin = min(P');
Pmax = max(P');
a = M*abs(Pmax-Pmin);
wmin = Pmin-a;
wmax = Pmax+a;
w = wmin';
b = wmax'-w;