function out = mapFeature(X1, X2)
% MAPFEATURE Mapeo de las caracteristicas de X1 y X2 usando polinomio de caracteristicas
%
%   MAPFEATURE(X1, X2) mapea las caracteristicas de 2 entradas
%   a caracteristicas cuadratiacas usando la regularización.
%
%   Retorna un vector 28x1 con las caracteristicas
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   X1 y X2 deben tener el mismo tamaño
%

degree = 6;
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end
