function cost = dmnsoftmax_cost(P,T,dendrite)
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
%   cost is objetive function to be minimize (softmax cost function)

Qbatch = size(P,2);
Nc = size(dendrite,2);
cost = 0;
for q=1:Qbatch
    for c=1:Nc
        h = 0;
        for k = 1:size(dendrite(c).W,2)
            w = dendrite(c).W(:,k);
            b = dendrite(c).B(:,k);
            h(k) = min(min(P(:,q)-w,w+b-P(:,q)));
        end
        d(c) = max(h);
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
end
cost = cost/Qbatch;
    
    



