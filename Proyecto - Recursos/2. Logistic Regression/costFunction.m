function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Calculo del costo y gradiente
%   J = COSTFUNCTION(theta, X, y) calcula el costo de usar theta
%   como parametros, además, retorna el gradiente de dicho costo.

m = length(y);

J = 0;
grad = zeros(size(theta));

% =============================================================

h = sigmoid(X * theta);

J = (1/m) * sum(-y.*log(h) - (1-y).*log(1-h));
grad = (1/m) * sum((h-y).*X);

% =============================================================

end
