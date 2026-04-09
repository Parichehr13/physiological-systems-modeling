function dX = Lorenz(~, X)
% Lorenz system for module 9a
global sigma beta rho

dX = zeros(3,1);
dX(1) = sigma * (X(2) - X(1));
dX(2) = X(1) * (rho - X(3)) - X(2);
dX(3) = X(1) * X(2) - beta * X(3);
end

