function H0 = generate_initial_hyperbox(P,M)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   P is a matrix NxQtrain containing all training samples 
%   M is a percentage margen for initial hyperbox 

% Output:
%   H0 is the initial hyperbox that enclose all the training samples (if M>0)

Wmin = min(P')';
Wmax = max(P')';
a = M*abs(Wmax-Wmin);
Wmin = Wmin-a;
Wmax = Wmax+a;
H0 = [Wmin; Wmax];