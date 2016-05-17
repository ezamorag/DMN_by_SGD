% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt
clear, close all, clc
addpath(genpath('DMNSoftmax_SGD'))

% HERE YOU CAN CHANGE DATASET
dataset = 'B';
load(['Datasets/', dataset,'.mat']);
% Dataset filenames
% A, B, iris, liver, glassC, pageblocks, letterrecognition
% miceprotein, MNIST_1000, CIFAR10_1000

global tol
tol = 1e-10; N = size(P,1); Nc = max(T);
Qtrain = size(P,2); Qtest = size(Ptest,2);

%%  Initialization method
% CHOOSE INICIALIZATION METHOD
tic
% 1) Hyperbox per Class
% M = 0.0;
% dendrite = hb_per_class(P,T,M); 
% 2) Divide Hyperbox per Class
M = 0.0;
n = 2;
dendrite = nhb_per_class(P,T,M,n); 
% 3) Divide & conquer (You can create new pretraining models with DCtpretraining.m)
% load(['pretrainingD&C/pretrainingD&C_',dataset,'.mat'])
% 4) K-means
% yo = 0.5; 
% S = 4;
% dendrite = h_kmeans(P',T',S,yo);
% 5) Random
% dendrite = nhb_per_class_random(P,T,1);


%% Learning by Stochastic Gradient Machine
% Adjustable parameters for learning
alfa = 1e-2;
Neph= 1000;
Qbatch = 10;
for eph=1:Neph
    indq = randi(Qtrain,1,Qbatch);
    [cost(eph), grad] = dmnsoftmax_costgrad(dendrite,P(:,indq),T(:,indq));
    for c=1:Nc
        dendrite(c).W = dendrite(c).W - alfa*grad(c).W;
        dendrite(c).B = dendrite(c).B - alfa*grad(c).B;
    end
    
    eph
    if mod(eph,50)  == 0
        pause(0.01)
        plot(cost,'r'), title('Cost vs Epochs')
    end
    
end
toc
plot(cost,'r'), title('Cost vs Epochs')
% Clasification Errors 
Etrain = dmnsoftmax_errorrate(P,T,dendrite)
Etest = dmnsoftmax_errorrate(Ptest,Ttest,dendrite)
NH = dendritenumber(dendrite)


rmpath(genpath('DMNSoftmax_SGD'))