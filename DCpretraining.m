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
E0 = 0.0;     % The tolerated error rate inside an hyperbox [0.0,1.0]
M = 0.1;        % The margen of initial hyperbox [0.0,+inf)

% Regularized Divide and Conquer Training
tic
H0 = generate_initial_hyperbox(P,M);
[ListH, ListC] = DivideAndConquer(H0,P,T,0);
toc
% Validation
Etrain = dmneuron_errorrate(P,T,ListH,ListC)
Etest = dmneuron_errorrate(Ptest,Ttest,ListH,ListC)
nH = size(ListH,1)
nH_Qtrain = nH/size(P,2)

dendrite = convert_format(ListH,ListC);
save(['pretrainingD&C_',dataset,'.mat'],'dendrite')

rmpath('DMNSoftmax_SGD/Divide&Conquer')