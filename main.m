%% INITIALIZATION & CONTANTS
NETSIZE = [7,7, 2];
%% DATA PREPARATION
% iris=csvread('iris.csv');

iris.variety = [];
X = table2array(iris);
X(:,3) = [];
X(:,3) = [];
X = normalize(X);
%% TRAIN

t = SOM(X, NETSIZE);

