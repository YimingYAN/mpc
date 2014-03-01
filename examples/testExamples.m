% Test examples

clear;
clc;

param_in = [];

% Example: random
m = 4;
n = 6;

A = randn(m,n)
b = A*rand(n,1)
c = A'*rand(m,1) + rand(n,1)

param_in.verbose = 0;

[f, x, y, s, N] = mpcSol(A, b, c, param_in);
x
N

% Example: afiro -- in standard form
param_in.verbose = 1;
load afiro;
[f, x, y, s, N] = mpcSol(A, b, c, param_in, Name);

% Example: blend -- in standard form
clear;
load blend;
param_in.verbose = 2;
[f, x, y, s, N] = mpcSol(A, b, c, param_in, Name);