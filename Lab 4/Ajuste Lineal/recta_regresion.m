close all, clc, clear
pkg load symbolic
%pkg load tablicious

disp("============ RECTA DE REGRESIÓN EN MÍNIMOS CUADRADOS: ============");

% Número de puntos a ingresar
num_parejas = input('Ingresa la cantidad de puntos a ajustar: ');

% Se almacenan en 4 columnas los valores necesarios para calcular los
% coeficientes de las ecuaciones normales de Gauss (x, y, x^2, xy)
coeficientes = zeros(num_parejas+1, 4);
for i=1:num_parejas
  fprintf("Ingresa la pareja [x y] del punto %d: ", i);
  pareja = input(' ');
  coeficientes(i, 1) = pareja(1);
  coeficientes(i, 2) = pareja(2);
  coeficientes(i, 3) = pareja(1)^2;
  coeficientes(i, 4) = pareja(1)*pareja(2);
endfor

% Cálculo de los coeficientes para cada columna, se almacena en la última fila de
% la matriz coeficientes
suma = sum(coeficientes);
coeficientes(end, 1) = suma(1);
coeficientes(end, 2) = suma(2);
coeficientes(end, 3) = suma(3);
coeficientes(end, 4) = suma(4);

% Tabla
t = table(coeficientes(:,1), coeficientes(:,2), coeficientes(:,3), coeficientes(:,4), 'VariableNames', {"x", "y", "x^2", "xy"});

prettyprint(t);

% Impresión del sistema de ecuaciones
fprintf('\nSISTEMA DE ECUACIONES:\n');
fprintf("(%d)A + (%d)B = %d\n", suma(3), suma(1), suma(4));
fprintf("(%d)A + (%d)B = %d\n", suma(1), num_parejas, suma(2));

%Cálculo de la solución del sistema de ecuaciones
sol = [suma(3) suma(1);suma(1) num_parejas]\[suma(4);suma(2)];

% Impresión de la recta
fprintf('\nRECTA:\n');
fprintf("y = (%d)x + (%d)\n", sol(1), sol(2));

% Gráfica
x = min(coeficientes(1:end-1,1)) - 1:0.01:max(coeficientes(1:end-1,1)) + 1;
plot(x, sol(1)*x + sol(2));
grid on
hold on
plot(coeficientes(1:end-1,1), coeficientes(1:end-1,2), '.', 'markersize', 10);
legend(strcat('y = (', num2str(sol(1)), ')x + (', num2str(sol(2)), ')'), 'Puntos originales');
hold off
