function [dx, dy, ds, L, D, pm] =...
    newtonDirection(Rb, Rc, Rxs, A, m, n, x, s, L, D, pm, errorCheck)
% Function NEWTONDIRECTION
% -----------------------------------------------------------------------
% Syntax:
%  [dx, dy, ds, L, D] =...
%    newtonDirection(Rb, Rc, Rxs, A, m, n, x, y, s, L, D, errorCheck)
% -----------------------------------------------------------------------
% Augmented system is used. More stable but less efficient. For the
% corrector step, we reuse the LDL' factorization from the predictor step
% -----------------------------------------------------------------------
% Input:
% Output:
% -----------------------------------------------------------------------
% Version 0.3              23/02/2012
% Yiming Yan @ University of Edinburgh

rhs = sparse([-Rb; -Rc+Rxs./x]);
D_2 = -min(1e+16, s./x);
B = [sparse(m,m) A; A' sparse(1:n,1:n,D_2)];

% ldl' factorization
% if L and D are not provided, we calc new factorization; otherwise,
% reuse them
if isempty(L) || isempty(D) || isempty(pm)
    [L,D,pm] = ldl(B,'vector');
end

sol(pm,:) = L'\(D\(L\(rhs(pm,:))));

dy = sol(1:m);
dx = sol(m+1:m+n);
ds = -(Rxs+s.*dx)./x;


if errorCheck == 1
    fprintf('error = %6.2e',norm(A'*dy + ds + Rc)+ norm(A*dx + Rb) + norm(s.*dx + x.*ds + Rxs));
    fprintf('\t + err_d = %6.2e',norm(A'*dy + ds + Rc));
    fprintf('\t + err_p = %6.2e',norm(A*dx + Rb));
    fprintf('\t + err_gap = %6.2e\n',norm(s.*dx + x.*ds + Rxs));
end
end