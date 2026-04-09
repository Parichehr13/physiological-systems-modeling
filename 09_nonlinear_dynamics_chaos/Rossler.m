function dX = Rossler(~, X)
% Rossler system for module 9b
global a b c

dX = zeros(3,1);
dX(1) = -X(2) - X(3);
dX(2) = X(1) + a * X(2);
dX(3) = b + X(3) * (X(1) - c);
end

