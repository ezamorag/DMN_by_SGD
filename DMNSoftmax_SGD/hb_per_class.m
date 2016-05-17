function dendrite = hb_per_class(P,T,M)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P: matrix NxQbatch of patterns
%   T: vector 1xQbatch containing class of patterns
%   M: scalar for distance margin of the hyperboxes

% Output:
%   dendrite is a structure that constains the hyperboxes
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class, where
%       dendrite(c).W is a matrix that constains position vectors for a hyperbox in each column 
%       dendrite(c).B is a matrix that constains size vectors for a hyperbox in each column  

dendrite = [];
C = unique(T);
if ~isempty(C) % Si T=P=[] -> dendrite = []
    for c=1:length(C)
        intC = find(T == C(c));
        % Ignorar si solo hay un ejemplo de esa clase
        if length(intC) == 1, continue, end
        [dendrite(c).W dendrite(c).B] = generateWB(P(:,intC),M);
    end
end

