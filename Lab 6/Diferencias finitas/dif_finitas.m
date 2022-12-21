clc, close all
pkg load tablicious

% Entradas:
%   - x__: Ec. dif de contorno x´´(t)
%   - p: Ecuacion p(t)
%   - q: Ecuación q(t)
%   - r: Ecuación r(t)
%   - intervalo: Intervalo para calcular la sol a la ec dif
%   - alfa: valor inicial de frontera
%   - beta: valor final de frontera
%   - sol: Ec. dif. como solucion a x''(t)

x__ = input("Ingrese la ecuación diferencial x´´(t): ",'s');
p = input("Ingrese la función p(t): ",'s');
q = input("Ingrese la función q(t): ",'s');
r = input("Ingrese la función r(t): ",'s');
intervalo = input("Ingrese el intervalo para la ecuación [a b]: ");
fprintf("Ingrese el valor de frontera x(%d): ",intervalo(1));
alfa = input("");
fprintf("Ingrese el valor de frontera x(%d): ",intervalo(2));
beta = input("");
h = input("Ingrese el valor del incremento h: ");

sol = input("Ingrese la solución exacta, en caso de no tenerla, ingrese N: ", 's');

% Declaración de a y b
a = intervalo(1);
b = intervalo(2);

% Conversion de strings a funciones
q = str2func(strcat("@(t)", q));
p = str2func(strcat("@(t)", p));
r = str2func(strcat("@(t)", r));

% Número de particiones del intervalo [a b]
M = (b-a)/h;

% Vector de los t_k (t+k*h, k = 1,2,3,...,M-1)
t = linspace(a+h, b-h, M-1);

% Declaración de los vectores para el sistema de ecuaciones
S = zeros(M-1,M-1);
B = zeros(M-1,1);

% Asignación de los valores de la primera y última fila de S
S(1,1) =  2 + h^2*q(t(1));
S(1,2) = (h/2)*p(t(1))-1;
S(M-1, M-2) = (-h/2)*p(t(end))-1;
S(M-1, M-1) = 2 + h^2*q(t(end));

% Asignación del primer y último valor de B
B(1,1) = -h^2*r(t(1)) + ((h/2)*p(t(1))+1)*alfa;
B(M-1,1) = -h^2*r(t(end)) + ((-h/2)*p(t(end))+1)*beta;

% Ciclo para completar la matriz S
for j=2: M-2
  S(j,j-1) = (-h/2)*p(t(j))-1;
  S(j, j) = 2 + h^2*q(t(j));
  S(j, j+1) = (h/2)*p(t(j))-1;
  B(j,1) = -h^2*r(t(j));
endfor
fprintf("Matriz S: \n\n");
disp(S);
fprintf("\n\nVector B:\n\n");
disp(B);
fprintf("\n")

% Solucion del sistema SX=B
% Sistema tridiagonal solucionado por el método de Thomas
x = thomas(S,B);

% Concatenación de los valores de contorno al vector x
x = horzcat(alfa,x,beta);

% Concatenacion de los valores del intervalo al vector t
t = horzcat(a,t, b);

% Salidas del programa
t1 = table(t', 'VariableNames', {"t_j"});
t2 = table(x', 'VariableNames', {"x_j"});

if sol != 'N'
    sol = str2func(strcat("@(t) ", sol));
    x_r = zeros(length(t), 1);
    error = zeros(length(t), 1);

    for i=1: length(t)
      x_r(i,1) = sol(t(i));
      error(i,1) = sol(t(i)) - x(i);
    endfor

    t3 = table(x_r, 'VariableNames', {"x(t_j) exacto"});
    t4 = table(error, 'VariableNames', {"x(t_j)-x_j"});
    prettyprint([t1 t2 t3 t4]);

    subplot(1,2,1);
    plot(t,x,'r');
    hold on
    xlabel("t");
    ylabel("y");
    title("Aproximacion numérica de solucion a x´´(t)");
    minx = min(t); maxx = max(t);
    miny = min(x); maxy = max(x);
    plot([minx maxx], [0 0], 'k');
    plot([0 0], [miny maxy], 'k');
    legend("x(t)", "t = 0", "y = 0", 'FontSize', 12);
    hold off

    subplot(1,2,2);
    plot(t,x_r,'b');
    hold on
    xlabel("t");
    ylabel("y");
    title("Solución exacta a x´´(t)");
    minx = min(t); maxx = max(t);
    miny = min(x); maxy = max(x);
    plot([minx maxx], [0 0], 'k');
    plot([0 0], [miny maxy], 'k');
    legend("x(t)", "t = 0", "y = 0", 'FontSize', 12);
    hold off
else
    prettyprint([t1 t2]);
    plot(t,x,'r', t, x_r, 'b');
    hold on
    xlabel("t");
    ylabel("y");
    title("Aproximacion numérica de solucion a x´´(t)");
    minx = min(t); maxx = max(t);
    miny = min(x); maxy = max(x);
    plot([minx maxx], [0 0], 'k');
    plot([0 0], [miny maxy], 'k');
    legend("x(t)", "t = 0", "y = 0", 'FontSize', 12);
    hold off
endif

% Entradas prueba
% x´´(t) -> 2*t/(1+t^2)x'(t)-2/(1+t^2)x(t)+1
% p(t) -> 2*t/(1+t^2)
% q(t) ->  -2/(1+t^2)
% r(t) -> 1
% [a b] -> [0 4]
% x(0) -> 1.25
% x(4) -> -0.95
% h -> 0.2
% Solución ->  1.25+0.486089652*t - 2.25*t^2 + 2*t*atan(t)+0.5*(t^2 - 1)*log(1+t^2)
