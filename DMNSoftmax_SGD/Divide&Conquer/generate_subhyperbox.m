function Hsub = generate_subhyperbox(H,p)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   H is a hyperbox
%   p is a training sample

% Output:
%   Hsub is a sub-hyperbox generated around the training sample p

global tol 
N = size(H,1)/2;
Wmin = H(1:N);
Wmax = H(N+1:2*N);
if sum(p > Wmax + tol) > 0  || sum(p < Wmin - tol) > 0
    error('Error: the training sample is outside from hyperbox H')
end
Pcentral = (Wmax + Wmin)/2;
cond = (p >= Pcentral);
indmin = find(~cond);
indcentral = find(cond);
wminsub(indmin,:) = Wmin(indmin);
wminsub(indcentral,:) = Pcentral(indcentral);
delta = (Wmax-Wmin)/2;
Hsub = [wminsub; wminsub + delta];

