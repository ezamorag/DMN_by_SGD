% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt
clc, clear all, close all
addpath(genpath('DMNSoftmax_SGD'))
dataset = 'B';
load(['Datasets/', dataset,'.mat']);

global tol
tol = 1e-10;
N = size(P,1); Nc = max(T); Q = size(P,2);

%%  Initialization method
% CHOOSE INICIALIZATION METHOD
% 1) Hyperbox per Class
M = -0.4;
dendrite = hb_per_class(P,T,M); 
% 2) Divide Hyperbox per Class
% M = 0.0;
% n = 2;
% dendrite = nhb_per_class(P,T,M,n); 
% 3) Divide & conquer
% load(['pretrainingD&C/pretrainingD&C_',dataset,'.mat'])
% 4) K-means
% yo = 0.5; 
% S = 4;
% dendrite = h_kmeans(P',T',S,yo);
% 5) Random
% nH = 3;
% dendrite = nhb_per_class_random(P,T,nH);

%% Training
alfa = 1e-3;
for eph=1:100
    % Optimizacion: Descenso por gradiente
    indq = randi(Q,1,1000);
    [cost(eph), grad] = dmnsoftmax_costgrad(dendrite,P(:,indq),T(:,indq));
    for c=1:Nc
        dendrite(c).W = dendrite(c).W - alfa*grad(c).W;
        dendrite(c).B = dendrite(c).B - alfa*grad(c).B;
    end
    
    % Visualizacion
    figure(1),
    plot(P(1,1:500),P(2,1:500),'r*',P(1,501:1000),...
        P(2,501:1000),'go',P(1,1001:1500),P(2,1001:1500),'b+','markers',3),   
    hold on
    color = {'r','g','b'};
    for c=1:Nc
        for i=1:size(dendrite(c).W,2)
            Pm = dendrite(c).W(:,i)';
            Pb = dendrite(c).B(:,i)';
            rectangle('Position',[Pm abs(Pb)],'EdgeColor',color{c},'LineWidth',1.5)
        end
    end
    pause(0.001)
    hold off
end
figure(2), plot(cost)
% Classification error
Etrain = dmnsoftmax_errorrate(P,T,dendrite)
Etest = dmnsoftmax_errorrate(Ptest,Ttest,dendrite)

rmpath(genpath('DMNSoftmax_SGD'))

