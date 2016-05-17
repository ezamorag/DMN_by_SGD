function errorrate = dmneuron_errorrate(P,T,ListH,ListC)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P is a matrix containing patterns  
%   T is a vector containing the clases for patterns in P
%   ListH is a matrix that contains the hyperboxes for dendrite
%       morphological neuron
%   ListC is a vector NHx1 that contains the corresponding class for 
%         hyperboxes in ListH

% Output:
%   errorrate is the percentage of classification errors 

Q = size(P,2);
error = 0;
for q=1:Q
    y = dmneuron(P(:,q),ListH,ListC);
    if isempty(y), error('Error: y is empty'); end
    if y(1) ~= T(q)  % Taking the first output 
        error = error + 1;
    end
end
errorrate = error/Q;
  
