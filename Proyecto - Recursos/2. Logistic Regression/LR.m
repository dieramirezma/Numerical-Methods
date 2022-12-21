%% Machine Learning - Logistic Regression


clear ; close all; clc

% Cargue de datos de archivo txt
% Columnas 1 y 2 con notas de alumnos
% Columna 3 clasificación de Admitido o No Admitido
data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

%% ==================== Gráfico de Datos ====================
fprintf(['Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']);
plotData(X, y);

% Configuración de gráfico
hold on;
xlabel('Exam 1 score')
ylabel('Exam 2 score')

legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ Cálculo de la función de costo y gradiente ============

%  Declaración de vectores para la construcción de función de costo
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Inicializar los valores para theta
initial_theta = zeros(n + 1, 1);

% Cálculo del costo y gradiente llamando a función costFunction
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n -0.1000\n -12.0092\n -11.2628\n');

% Cálculo del costo y gradiente con valores de theta diferentes a cero
test_theta = [-24; 0.2; 0.2];
[cost, grad] = costFunction(test_theta, X, y);

fprintf('\nCost at test theta: %f\n', cost);
fprintf('Expected cost (approx): 0.218\n');
fprintf('Gradient at test theta: \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n 0.043\n 2.566\n 2.647\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= Optimización para hallar los valores óptimos de theta  =============

%  Se usa una función de matlabroot
% Inicialización de los párametros de configuración
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Ejecución de la funcióny obtención de los parámetros óptimos de theta
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Impresión de resultados
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('Expected cost (approx): 0.203\n');
fprintf('theta: \n');
fprintf(' %f \n', theta);
fprintf('Expected theta (approx):\n');
fprintf(' -25.161\n 0.206\n 0.201\n');

% Gráfico del límite de decisión
plotDecisionBoundary(theta, X, y);

% Configuración del gráfico
hold on;
xlabel('Exam 1 score')
ylabel('Exam 2 score')

legend('Admitted', 'Not admitted', 'Decision Boundary')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== Predicción y precisión del método ==============

%  Para probar el algoritmo usando los parámetros óptimos de theta, se plantea hallar
%  la probabilidad de que un estudiante, con puntajes de 45 y 85 en los exámenes 1 y 2 respectivamente,
%  sea adimitido. Conjunto a esto se calcula el porcentaje de efectividad de la predicción

prob = sigmoid([0 45 85] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n'], prob);
fprintf('Expected value: 0.775 +/- 0.002\n\n');

% Otros ejemplos más de prueba, tomados de las entradas dadas
prob = sigmoid([1 34.62365962451697 78.0246928153624] * theta);
fprintf(['For a student with scores %s and %s, we predict an admission ' ...
         'probability of %f\n'], num2str(34.62365962451697), num2str(78.0246928153624), prob)

prob = sigmoid([1 60.18259938620976 86.30855209546826] * theta);
fprintf(['For a student with scores %s and %s, we predict an admission ' ...
         'probability of %f\n\n'], num2str(60.18259938620976), num2str(86.30855209546826), prob);

%  Cálculo de la efectividad del algoritmo
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (approx): 89.0\n');
fprintf('\n');


