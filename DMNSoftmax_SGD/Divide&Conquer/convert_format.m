function dendrite = convert_format(ListH,ListC)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   ListH is a matrix that contains the hyperboxes for dendrite
%       morphological neuron
%   ListC is a vector NHx1 that contains the corresponding class for 
%         hyperboxes in ListH

% Output:
%   dendrite is a structure that constains the same hyperboxes in ListH
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class. 

Nc = max(ListC);
for c=1:Nc
    ind = (ListC == c);
    Wmin = ListH(ind,1:end/2)';
    Wmax = ListH(ind,end/2+1:end)';
    dendrite(c).W = Wmin;
    dendrite(c).B = Wmax-Wmin;
end