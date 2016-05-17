function [cost, grad] = dmnsoftmax_costgrad(dendrite,P,T)
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
%   cost is the value of cost function based on softmax and dendrite
%       morphological neuron
%   grad is a structure containing the gradients for each dendrite's
%       parameters


Qbatch = size(P,2);
N = size(P,1);
Nc = size(dendrite,2);
for c=1:Nc
    grad(c).W = zeros(size(dendrite(c).W));
    grad(c).B = zeros(size(dendrite(c).B));
end
cost = 0;
for q=1:Qbatch
    for c=1:Nc
        h = 0; ihk = 0;
        for k = 1:size(dendrite(c).W,2)
            w = dendrite(c).W(:,k);
            b = dendrite(c).B(:,k);
            aux = [P(:,q)-w,w+b-P(:,q)];
            [h(k), ihw(k)] = min(aux(:));
        end
        [d(c),kw(c)] = max(h);
        indw = ihw(kw(c));
        if indw <= N
            iw(c) = indw;
            jw(c) = 1;
        else
            iw(c) = indw - N;
            jw(c) = 2;
        end
    end
    expd = exp(d);
    sexpd = sum(expd);
    % singularity management
    if sexpd ~= 0 && sexpd ~= inf
        Pr(q,:) = expd'/sexpd;
    else
        Pr(q,:) = zeros(1,Nc);
        if sum(isinf(expd)) == 1
            Pr(q,expd == inf) = 1;
        end
    end
    if Pr(q,T(q)) == 0  %Limitando la maxima penalización
        costq = log(realmin);
    else
        costq = log(Pr(q,T(q)));
    end
    cost = cost - costq; 
    
    for c=1:Nc
        gW = zeros(size(dendrite(c).W));
        gW(iw(c),kw(c)) = ((jw(c)==2)-(jw(c)==1))*((T(q)==c)-Pr(q,c));
        grad(c).W = grad(c).W - gW;
        
        gB = zeros(size(dendrite(c).B));
        gB(iw(c),kw(c)) = (jw(c)==2)*((T(q)==c)-Pr(q,c));
        grad(c).B = grad(c).B - gB;
    end

end 
cost = cost/Qbatch;
% gradW = gradW/Qbatch;
% gradB = gradB/Qbatch;