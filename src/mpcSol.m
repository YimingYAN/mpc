function [f, x, y, s, N] = mpcSol(A, b, c, param_in, Name)
% Function MPCSOL --- augumented system used
% Mehrotra's predictor-corrector interior point algorithm
%
% Syntax:   [f, x, y, s, N] = mpc(A, b, c)
%           [f, x, y, s, N] = mpc(A, b, c, param)
%           [f, x, y, s, N] = mpc(A, b, c, [],    Name)
%           [f, x, y, s, N] = mpc(A, b, c, param, Name)
%
% Required Input:
%      (A, b, c) --- problem data
%
% Optional Input
%           Name --- name of the test problems.
%                    Default name is testProb
%          param --- struct of parameters
%
% Output
%      (x, y, s) --- optimal solution
%              N --- total number of iterations
%              f --- optimal value of the objective function
%
% Version 0.7
% Author: Yiming Yan, University of Edinburgh
% 18/12/2013

warning('off');
%% Check inputs and set parameters
if nargin < 5 || isempty(Name)
    Name = 'testProb';
end

if nargin < 4 || isempty(param_in)
    [param, options] = setParamOptions;
else
    [param, options] = setParamOptions(param_in);
end

if nargin < 3
    error('MPCSOL: Not enough inputs.');
end

% Check if A is sparese
if ~issparse(A)
    A = sparse(A);
end

% Initialization

[m,n] = size(A);
alphax = 0; alphas = 0;

if param.verbose > 0
    fprintf('\n======== %s ========\n', Name);
end
if param.verbose > 1
    fprintf('\n%3s %6s %11s %9s %9s\n',...
        'ITER', 'MU', 'RESIDUAL', 'ALPHAX', 'ALPHAS');
end
%% Choose initial point
[x, y, s] = initialPoint(A, b, c);

bc = 1+max([norm(b),norm(c)]);

% Start the loop
for iter = 0:param.maxN
    %% Compute residuals and update mu
    Rb = A*x-b;
    Rc = A'*y+s-c;
    Rxs = x.*s;
    mu = mean(Rxs);
    
    %% Check relative decrease in residual, for purposes of convergence test
    residual  = norm([Rb;Rc;Rxs])/bc;
    
    if param.verbose > 1
        fprintf('%3d %9.2e %9.2e %9.4g %9.4g\n',...
            iter, full(mu), full(residual), alphax, alphas);
    end
    
    if residual < param.eps
        break;
    end
    
    %% ----- Predictor step -----
    
    % Get affine-scaling direction
    [dx_aff, dy_aff, ds_aff, L, D, pm] =...
        newtonDirection(Rb, Rc, Rxs, A, m, n,...
        x, s, [], [], [], options.errorCheck);
    
    % Get affine-scaling step length
    [alphax_aff, alphas_aff] = stepSize(x, s, dx_aff, ds_aff, 1);
    mu_aff = (x+alphax_aff*dx_aff)'*(s+alphas_aff*ds_aff)/n;
    
    % Set central parameter
    sigma = (mu_aff/mu)^3;
    
    %% ----- Corrector step -----
    
    % Set up right hand sides
    Rb = sparse(m,1);
    Rc = sparse(n,1);
    Rxs = dx_aff.*ds_aff - sigma*mu*ones(n,1);
    
    % Get corrector's direction
    [dx_cc, dy_cc, ds_cc, ~, ~, ~] =...
        newtonDirection(Rb, Rc, Rxs, A, m, n,...
        x, s, L, D, pm, options.errorCheck);
    
    %% Compute search direction and step
    dx = dx_aff+dx_cc;
    dy = dy_aff+dy_cc;
    ds = ds_aff+ds_cc;
    
    [alphax, alphas] =  stepSize(x, s, dx, ds, param.theta);
    
    %% Update iterates
    x = x + alphax*dx;
    y = y + alphas*dy;
    s = s + alphas*ds;
    
    if iter == param.maxN && param.verbose > 1
        fprintf('maxN reached!\n');
    end
end
if param.verbose > 0
    fprintf('\nDONE! [m,n] = [%d, %d], N = %d\n',m,n,iter);
end

%% Output results
N = iter;
x = full(x); y = full(y); s = full(s); f = c'*x;

end
