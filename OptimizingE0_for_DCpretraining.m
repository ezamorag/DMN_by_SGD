% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt

clc, clear all, close all
addpath('DMNSoftmax_SGD/Divide&Conquer')
dataset = 'iris';
load(['Datasets/', dataset,'.mat']);
% A, B, iris, liver, glassC, pageblocks, letterrecognition
% miceprotein, MNIST_1000, CIFAR10_1000

global L tol E0
tol = 1e-10;    % Tolerance to avoid numerical errors
L = 0;          % The depth in recursions

% Adjustable parameters for training
E = linspace(0,1,60);       % The tolerated error rate inside an hyperbox [0.0,1.0]
M = 0.1;        % The margen of initial hyperbox [0.0,+inf)
% Optimizar M, y luego, optimizar E0

tic
for i=1:length(E)
    i
    E0 = E(i);
    % Regularized Divide and Conquer Training
    H0 = generate_initial_hyperbox(P,M);
    [ListH, ListC] = DivideAndConquer(H0,P,T,0);
    % Validation
    Etrain(i) = dmneuron_errorrate(P,T,ListH,ListC);
    Etest(i) = dmneuron_errorrate(Ptest,Ttest,ListH,ListC);
    nH(i) = size(ListH,1);
    nH_Qtrain(i) = nH(i)/size(P,2);
end
toc 

plot(E,Etrain,'r',E,Etest,'b',E,nH_Qtrain)
axis([0 1 0 1])


rmpath('DMNSoftmax_SGD/Divide&Conquer')




