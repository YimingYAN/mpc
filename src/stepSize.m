function [alphax, alphas] = stepSize(x, s, Dx, Ds, eta)
% Function STEPSIZE
% -------------------------------------------------------------------------
% Syntex: [alphax, alphas] = stepSize(x, s, Dx, Ds, eta)
% -------------------------------------------------------------------------
% Get the stepsizes (alphax, alphas) for the primal and dual Newton's
% directions
% -------------------------------------------------------------------------
% Version 0.8
% -------------------------------------------------------------------------
% Yiming Yan, University of Edinburgh                          21/02/2012

if nargin < 5
    eta = 0.9995;
end
if nargin < 4
    error('STEPSIZE: Not enough inputs')
end

alphax = -1/min(min(Dx./x),-1); alphax = min(1, eta * alphax);
alphas = -1/min(min(Ds./s),-1); alphas = min(1, eta * alphas);
%alpha = min(alphax, alphas);
end