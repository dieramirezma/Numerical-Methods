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

a = intervalo(1);
b = intervalo(2);

% Conversión de strings a funciones (PVI)
u__ = strcat("@(t,x,y) (", p, ")*y + (",q, ")*x + (", r,")");
u__ = str2func(u__);

v__ = strcat("@(t,x,y) (", p, ")*y + (",q, ")*x");
v__ = str2func(v__);

% Valores iniciales para los PVI
ua = alfa; u_a = 0;
va = 0; v_a = 1;

% Número de particiones del intervalo [a b]
M = (b-a)/h;

% Vector de los t_k (t+k*h, k = 0,1,2,3,...,M+1)
t_j = linspace(a,b,M+1);

% Impresion de ecuaciones por consola
clc
fprintf("Ecuación diferencial inicial: x´´(t) = (%s\n", strcat(p, ")x´(t) + (", q, ")x(t) + (", r,")"));
disp("Ecuaciones PVI: ");
fprintf("u´´ = (%s   u(%d) = %d,  u´(%d) = %d\n", strcat(p,")u´(t) + (", q, ")u(t) + (",r,")"),a,alfa,a,u_a);

% Solucion de la ecuacion u´´ usando ED orden superior > Sistemas de ecuaciones > RK4
u = ED_orden_sup(u__, ua, u_a, a, b, h);
fprintf("v´´ = (%s   v(%d) = %d,  v´(%d) = %d", strcat(p,")v´(t) + (", q, ")v(t)"),a,va,a,v_a);

% Solucion de la ecuacion v´´ usando ED orden superior > Sistemas de ecuaciones > RK4
v = ED_orden_sup(v__, va, v_a, a, b, h);
disp(" ");

% Solución aproximada a u(b) y v(b)
u_b = u(end);
v_b = v(end);

% Solucion de w
w = ((beta-u_b)/v_b) * v;

% Solucion final aproximada de la ED x´´(t)
x = u + w;

% Salidas de tabla
if sol != 'N'
  sol = str2func(strcat("@(t) ", sol));
  exacto = zeros(1,length(t_j));
  error = zeros(1, length(t_j));
  for i=1: length(t_j)
    exacto(1,i) = sol(t_j(i));
    error(1,i) = sol(t_j(i)) - x(i);
  endfor
  t1 = table(t_j', 'VariableNames', {"t_j"});
  t2 = table(u', 'VariableNames', {"u_j"});
  t3 = table(v', 'VariableNames', {"v_j"});
  t4 = table(w', 'VariableNames', {"w_j"});
  t5 = table(x', 'VariableNames', {"x_j = u_j+w_j"});
  t6 = table(exacto', 'VariableNames', {["x(t_j) " "exacto"]});
  t7 = table(error', 'VariableNames', {"error"});
  tabla = [t1 t2 t3 t4 t5 t6 t7];

  % Salidas de gráficos
  subplot(1,3,1);
  plot(t_j, x, 'r', t_j, w, 'b', t_j, u, 'c');
  title("Aproximaciones numéricas usadas para formar x(t) = u(t) + w(t)", 'FontSize', 12);
  xlabel("t");
  ylabel("y");

  hold on
  plot([a b], [0 0], 'k');
  legend("x(t)","w(t)","u(t)","t=0", 'FontSize', 12);
  hold off

  subplot(1,3,2);
  plot(t_j,x,'b');
  title("Gráfica de la solución numérica de la ecuación x´´(t)", 'FontSize', 12);
  xlabel("t");
  ylabel("y");

  hold on
  plot([a b], [0 0], 'k');
  legend("x(t)", "t=0", 'FontSize', 12);
  hold off

  subplot(1,3,3);
  plot(t_j,exacto,'g');
  title("Gráfica de la solución exacta de la ecuación x´´(t)", 'FontSize', 12);
  xlabel("t");
  ylabel("y");

  hold on
  plot([a b], [0 0], 'k');
  legend("x(t)", "t=0", 'FontSize', 12);
  hold off

else
  t1 = table(t_j', 'VariableNames', {"t_j"});
  t2 = table(u', 'VariableNames', {"u_j"});
  t3 = table(v', 'VariableNames', {"v_j"});
  t4 = table(w', 'VariableNames', {"w_j"});
  t5 = table(x', 'VariableNames', {"x_j = u_j+w_j" });
  tabla = [t1 t2 t3 t4 t5];

  % Salidas de gráficos
  subplot(1,2,1);
  plot(t_j, x, 'r', t_j, w, 'b', t_j, u, 'c');
  title("Aproximaciones numéricas usadas para formar x(t) = u(t) + w(t)", 'FontSize', 12);
  xlabel("t");
  ylabel("y");

  hold on
  plot([0 4], [0 0], 'k');
  legend("x(t)","w(t)","u(t)","t=0", 'FontSize', 12);
  hold off

  subplot(1,2,2);
  plot(t_j,x,'b');
  title("Gráfica de la solución numérica de la ecuación x´´(t)", 'FontSize', 12);
  xlabel("t");
  ylabel("y");

  hold on
  plot([0 4], [0 0], 'k');
  legend("x(t)", "t=0", 'FontSize', 12);
  hold off
endif

prettyprint(tabla);



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
