function [x_k] = sistema_RK(f,g,x0,y0,a,b,h)
  % Entradas
  %  - f: primera ED del sistema (y)
  %  - g: segunda ED del sistema (f(t,x,y))
  %  - x0: valor inicial de f
  %  - y0: valor inicial de g
  %  - a: valor inferior del intervalo
  %  - b: valor superior del intervalo
  %  - h: separación de los t_k
  % Salidas
  %  - x_k: solución aproximada al sistema de ED f,g (usando RK4)

  % Numero de t_k
  M = (b-a)/h;

  % Valores iniciales para cada ecuacion RK4
  f1 = f(a, x0, y0);
  g1 = g(a, x0, y0);

  f2 = f(a + h/2, x0 + h/2*f1, y0 + h/2*g1);
  g2 = g(a + h/2, x0 + h/2*f1, y0 + h/2*g1);

  f3 = f(a + h/2, x0 + h/2*f2, y0 + h/2*g2);
  g3 = g(a + h/2, x0 + h/2*f2, y0 + h/2*g2);

  f4 = f(a + h, x0 + h*f3, y0 + h*g3);
  g4 = g(a + h, x0 + h*f3, y0 + h*g3);

  x_kk = x0 + h/6 * (f1 + 2*f2 + 2*f3 + f4);
  y_kk = y0 + h/6 * (g1 + 2*g2 + 2*g3 + g4);

  % Vectores de soluciones a cada ecuación
  y_k = [y0 y_kk];
  x_k = [x0 x_kk];

  % Ciclo para calcular los x_k y y_k valores de las soluciones
  for k=1: M-1
    f1 = f((a + k*h), x_k(k+1), y_k(k+1));
    g1 = g((a + k*h), x_k(k+1), y_k(k+1));

    f2 = f((a + k*h) + h/2, x_k(k+1) + h/2*f1, y_k(k+1) + h/2*g1);
    g2 = g((a + k*h) + h/2, x_k(k+1) + h/2*f1, y_k(k+1) + h/2*g1);

    f3 = f((a + k*h) + h/2, x_k(k+1) + h/2*f2, y_k(k+1) + h/2*g2);
    g3 = g((a + k*h) + h/2, x_k(k+1) + h/2*f2, y_k(k+1) + h/2*g2);

    f4 = f((a + k*h) + h, x_k(k+1) + h*f3, y_k(k+1) + h*g3);
    g4 = g((a + k*h) + h, x_k(k+1) + h*f3, y_k(k+1) + h*g3);

    x_kk = x_k(k+1) + h/6 * (f1 + 2*f2 + 2*f3 + f4);
    y_kk = y_k(k+1) + h/6 * (g1 + 2*g2 + 2*g3 + g4);

    x_k(end+1) = x_kk;
    y_k(end+1) = y_kk;
  endfor
end

