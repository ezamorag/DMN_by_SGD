function errorrate = dmnsoftmax_errorrate(P,T,dendrite)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P is a matrix containing patterns  
%   T is a vector containing the clases for patterns in P
%   dendrite is a structure that constains the hyperboxes
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class, where
%       dendrite(c).W is a matrix that constains position vectors for a hyperbox in each column 
%       dendrite(c).B is a matrix that constains size vectors for a hyperbox in each column  

% Output:
%   errorrate is the percentage of classification error

Q = size(P,2);
error = 0;
for q=1:Q
    y = dmn_softmax(P(:,q),dendrite);
    if isempty(y), error('Error: y is empty'); end
    if y(1) ~= T(q)  % Taking the first output 
        error = error + 1;
    end
end
errorrate = error/Q;
  
