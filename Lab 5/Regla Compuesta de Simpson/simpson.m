% Regla compuesta de Simpson
clc
format long
disp("=========REGLA COMPUESTA DE SIMPSON=========");
%{
  Entrada de datos
  - f_i: función a integrar
  - a: extremo inferior del intervalo de integracion
  - b: extremo superior del intervalo de integracion
  - p: cantidad de nodos
%}
f_i = input("Ingrese la función: ",'s');
a = input("Ingrese el extremo inferior de la integral (a): ");
b = input("Ingrese el extremo superior de la integral (b): ");
p = input("Ingrese la cantidad de nodos a trabajar (número impar): ");

% Conversion del string f_i a función
f = str2func(strcat("@(x)",f_i));

% Declaración de M y h
M = (p-1)/2;
h = (b-a)/(2*M);

% Primer valor de la aproximación a la integral
aprox = h/3 *(f(a) + f(b));

% Variable para guardar las sumatorias
sum = 0;

% Ciclo para la segunda parte de la aproximacion a la integral
% Σ f(x_2k)
for k=1: M-1
  sum = sum + f(a+2*k*h);
endfor
% 2*h/3*Σ x_2k
aprox = aprox + (2/3)*h*sum;
sum = 0;

% Ciclo para la tercera parte de la aproximacion a la integral
% Σ f(x_2k-1)
for k=1: M
  sum = sum + f(a + (2*k-1)*h);
endfor

% 4*h/3*Σ x_2k-1
% Aproximación final de la integral
aprox = aprox + (4/3)*h*sum;

% Valor real de la integracion
int_r = integral(f,a,b);

% Gráficos
x = linspace(a,b,2*M+1);
y = f(x);

x_1 = linspace(a-1,b+1);
y_1 = f(x_1);

subplot(1,3,1);
plot(x_1,y_1, 'k','LineWidth', 1.5);
axis([min(x_1) max(x_1) 0 max(y_1)]);
title("Función original");
xlabel("x");
ylabel("y");
legend(["f(x) = " f_i]);

subplot(1,3,2);
area(x,y);

hold on
plot(x_1,y_1, 'k','LineWidth', 1.5);
axis([min(x_1) max(x_1) 0 max(y_1)]);
title("Área bajo la curva real");
xlabel("x");
ylabel("y");
legend(strcat("ÁREA REAL= ", num2str(int_r)));
hold off

subplot(1,3,3);
area_curva(f,a,b,M,h);
axis([min(x_1) max(x_1) 0 max(y_1)]);
title("Área bajo la curva aproximada (mediante intervalos)");
xlabel("x");
ylabel("y");
legend(strcat("ÁREA APROXIMADA = ", num2str(aprox)))

% Salidas por consola
fprintf("\nEl área real es: ");
disp(int_r);
fprintf("\nEl área aproximada es: ");
disp(aprox);

% Entradas
% f = 2+sin(2*sqrt(x))
% a = 1
% b = 6
% Nodos = 11
