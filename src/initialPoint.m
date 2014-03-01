function [x0,y0,s0] = initialPoint(A,b,c)
% Function INITIALPOINT
% -------------------------------------------------------------------------
% Syntex: [x0, y0, s0] = initialPoint(A, b, c)
% -------------------------------------------------------------------------
% Get the starting point (x0,y0,s0) for the primal-dual interior point
% mehtod, especially for Mehrotra's predictor-corrector method. 
% 
% For reference, please refer to "On the Implementation of a Primal-Dual 
% Interior Point Method" by Sanjay Mehrotra.
% -------------------------------------------------------------------------
% Version 0.3
% -------------------------------------------------------------------------
% Yiming Yan, University of Edinburgh                          21/02/2012
n = size(A,2);
e = ones(n,1);

% solution for min norm(s) s.t. A'*y + s = c
y = (A*A')\(A*c); 
s = c-A'*y;

% solution for min norm(x) s.t. Ax = b 
x = A'*((A*A')\b);

% delta_x and delta_s
delta_x = max(-1.5*min(x),0);
delta_s = max(-1.5*min(s),0);

% delta_x_c and delta_s_c
pdct = 0.5*(x+delta_x*e)'*(s+delta_s*e);
delta_x_c = delta_x+pdct/(sum(s)+n*delta_s);
delta_s_c = delta_s+pdct/(sum(x)+n*delta_x);

% output
x0 = x+delta_x_c*e;
s0 = s+delta_s_c*e;
y0 = y;