function p = predict(theta, X)
%   p = PREDICT(theta, X) calcula la probabilidad de un valor X
%   usando un valor límite 0.5 (si sigmoid(theta'*x) >= 0.5, predice 1)

m = size(X, 1);

p = zeros(m, 1);

% =========================================================================

p = sigmoid(X*theta) >= 0.5;

% =========================================================================


end
