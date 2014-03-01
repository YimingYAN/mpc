function [param, options] = setParamOptions(param_in)
% SETPARAMOPTIONS
% -------------------------------------------------------------------------
% This script is used to set the default value of parameters that control
% the behavior of the algorithm.
% -------------------------------------------------------------------------
% Input:
%         param_in: optional, user-defined parameters
% Output:
%         param   : struct, parameters
%         options : struct, options
%
% -------------------------------------------------------------------------
% Yiming Yan @ University of Edinburgh
% Version 0.1    Date: 23/02/2012

param = []; options=[];

% Basic paramters --- default value
param.maxN      = 100;               % maximum number of iterations allowed
param.eps       = 1e-08;             % tolorence for termination
param.theta     = 0.9995;            % ratio for choosing step sizes
param.verbose   = 2;                 % 0, nothing
                                     % 1, only optimal information
                                     % 2, iterative info

if nargin > 0
    if isfield(param_in, 'maxN')
        param.maxN = param_in.maxN;
    end
    if isfield(param_in, 'eps')
        param.eps = param_in.eps;
    end
    if isfield(param_in, 'verbose')
        param.verbose = param_in.verbose;
    end
end

% Debuging options
options.errorCheck = 0;              % 1, check the residuals of Newton's
% directions. 0, do nothing.
