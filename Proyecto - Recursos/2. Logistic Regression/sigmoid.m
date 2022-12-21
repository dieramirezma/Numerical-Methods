  function g = sigmoid(z)
%SIGMOID Calculo de la función sigmoide
%   g = SIGMOID(z) calcula el sigmoide de z.

% =============================================================

g = 1 ./ (1 + e.^-z);

% =============================================================

end
