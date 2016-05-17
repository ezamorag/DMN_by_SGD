function y = dmneuron(x,ListH,ListC)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input;
%   ListH is a matrix NHx(2*N) that contains the hyperboxes 
%   ListC ia a vector NHx1 that contains the corresponding class for 
%         hyperboxes in ListH

% Output:
%   y is the class output of dendrite morphological neuron

% Important notes: 
%   1) The global variable "tol" avoids classfication errors due 
%       to the small numerical errors 
%   2) The output y is not unique when sample x is at equal distance to two
%       or more hyperboxes
global tol

N = size(ListH,2)/2;
for k=1:size(ListH,1)
    Wmin = ListH(k,1:N)' - tol;
    Wmax = ListH(k,N+1:end)' + tol;
    d(k) = min(min(x-Wmin,Wmax-x));
end
dmax = max(d);
kmax = find(d >= dmax-tol & d <= dmax+tol);
y = unique(ListC(kmax));


