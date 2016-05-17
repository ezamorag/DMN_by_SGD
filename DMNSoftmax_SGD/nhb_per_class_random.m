function dendrite = nhb_per_class_random(P,T,nH)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P: matrix NxQbatch of patterns
%   T: vector 1xQbatch containing class of patterns
%   nH: number of hyperboxes per class

% Output:
%   dendrite is a structure that constains the hyperboxes
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class, where
%       dendrite(c).W is a matrix that constains position vectors for a hyperbox in each column 
%       dendrite(c).B is a matrix that constains size vectors for a hyperbox in each column  

dendrite = [];
N = size(P,1);
C = unique(T);
if ~isempty(C) % Si T=P=[] -> dendrite = []
    for c=1:length(C)
        intC = find(T == C(c));
        % Ignorar si solo hay un ejemplo de esa clase
        if length(intC) == 1, continue, end
        [w,b] = generateWB(P(:,intC),0.0);
        dendrite(c).W = w*ones(1,nH) + b*ones(1,nH).*rand(N,nH);
        dendrite(c).B = ((w+b)*ones(1,nH)-dendrite(c).W).*rand(N,nH);
    end
end

