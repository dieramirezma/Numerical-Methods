%% Machine Learning - Regresión Logística con regularización
clear ; close all; clc

% Cargue de datos de archivo txt
% Columnas 1 y 2 resultados de los tests de chips
% Columna 3 clasificación de Pasó o No Pasó

data = load('ex2data2.txt');
X = data(:, [1, 2]); y = data(:, 3);

% Gráfico
plotData(X, y);

hold on;

xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

legend('y = 1', 'y = 0')
hold off;


%% =========== Regularizacion de los datos ============

%  Se crea un vector polinomial con nuevas características de los datos
%  Este proceso de asemeja a la regresión polinomial
X = mapFeature(X(:,1), X(:,2));

%  Inicialización de los valores de theta
initial_theta = zeros(size(X, 2), 1);

% Declaración de la variable de regularización lambda
lambda = 1;

%  Calculo del costo y gradiente usando los valores de theta iniciales
[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros) - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.0085\n 0.0188\n 0.0001\n 0.0503\n 0.0115\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% Calculo de los valores de costo y gradiente usando valores de theta 1's
% y valor de lambda 10
test_theta = ones(size(X,2),1);
[cost, grad] = costFunctionReg(test_theta, X, y, 10);

fprintf('\nCost at test theta (with lambda = 10): %f\n', cost);
fprintf('Expected cost (approx): 3.16\n');
fprintf('Gradient at test theta - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.3460\n 0.1614\n 0.1948\n 0.2269\n 0.0922\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============= Regularizacion y precisión del método =============
%  Para probar la efectividad y la regularización, se tomarán diversos valores de lambda (0, 1, 10, 100).

% Inicializacion de theta
initial_theta = zeros(size(X, 2), 1);

% Declaración de lambdas
lambda = [0 1 10 100];

% Declaración de opciones para fminuncc
options = optimset('GradObj', 'on', 'MaxIter', 400);

for i=1 : length(lambda)
  [theta, J, exit_flag] = ...
	  fminunc(@(t)(costFunctionReg(t, X, y, lambda(i))), initial_theta, options);

  % Gráfico de Límite de decision
  plotDecisionBoundary(theta, X, y);
  hold on;
  title(sprintf('lambda = %g', lambda(i)))

  xlabel('Microchip Test 1')
  ylabel('Microchip Test 2')

  legend('y = 1', 'y = 0', 'Decision boundary')
  hold off;

  % Cálculo de la precisión del entrenamiento
  p = predict(theta, X);

  fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
  fprintf('\nProgram paused. Press enter to continue.\n\n');
  pause;
end




