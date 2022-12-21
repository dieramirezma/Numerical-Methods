function plotDecisionBoundary(theta, X, y)
%PLOTDECISIONBOUNDARY Grafica los puntos X y y representativos del
%   límite de decision
%   PLOTDECISIONBOUNDARY(theta, X,y)
%   Casos:
%   1) X Mx3, Línea de Decisión
%   2) X MxN, N>3, Curva de contorno de Decisión

% Gráfico de datos
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % Se establecen los 2 puntos para trazar la recta (eje x)
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Se calculan los puntos en y de la línea de decision
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % Gráfico de la línea
    plot(plot_x, plot_y)

    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else
    % Se establecen los cuadricula
    u = linspace(-1, 1.5, 50);
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % Se evalua z = theta*x sobre la cuadrilla
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature(u(i), v(j))*theta;
        end
    end
    z = z';

    % Gráfico de la curva
    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end
