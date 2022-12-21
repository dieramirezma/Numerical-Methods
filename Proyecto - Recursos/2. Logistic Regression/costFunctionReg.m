function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Calculo del costo y gradiente para regresion logistica cond regularización
%   J = COSTFUNCTIONREG(theta, X, y, lambda) calcula el costo de usar theta
%   como parametro, además, retorna el gradiente de dicho costo.

m = length(y);

J = 0;
grad = zeros(size(theta));

% ================================================================================

h = sigmoid(X * theta);
theta(1,1) = 0;
J = (1/m) * ((-y)'*log(h) - (1-y)'*log(1-h)) + (lambda/(2*m)) * sum(theta'*theta);

grad = (1/m) * X'*(h-y) + (lambda/m) *theta;

% =================================================================================

end
