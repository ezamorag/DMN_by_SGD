function y = dmn_softmax(x,dendrite)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input;
%   x is a input pattern for dendrite morphological neuron 
%   dendrite is a structure that constains the hyperboxes
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class, where
%       dendrite(c).W is a matrix that constains position vectors for a hyperbox in each column 
%       dendrite(c).B is a matrix that constains size vectors for a hyperbox in each column  

% Output:
%   y is the class output of dendrite morphological neuron

% Important notes: 
%   1) The global variable "tol" avoids classfication errors due 
%       to the small numerical errors 
%   2) The output y is not unique when sample x is at equal distance to two
%       or more hyperboxes
global tol
Nc = size(dendrite,2);
for c=1:Nc
    h = 0;
    for k = 1:size(dendrite(c).W,2)
        w = dendrite(c).W(:,k);
        b = dendrite(c).B(:,k);
        h(k) = min(min(x-w,w+b-x));
    end
    d(c) = max(h);
end
expd = exp(d);
sexpd = sum(expd);
% singularity management
if sexpd ~= 0 && sexpd ~= inf
    Pr = expd'/sexpd;
else
    Pr = zeros(1,Nc);
    if sum(isinf(expd)) == 1
         Pr(expd == inf) = 1;
    end
end
dmax = max(Pr);
kmax = find(Pr >= dmax-tol & Pr <= dmax+tol);
y = unique(kmax);


