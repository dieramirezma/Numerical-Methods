function [] = area_curva(f, a, b, M, h)
  %{
    Funcion para graficar los intervalos de integracion
    aproximados por polinomios interpoladores de Lagrange
    de grado 2.

    Entradas:
     - f: funcion a integrar
     - a: extremo inferior del intervalo de integracion
     - b: extremo inferior del intervalo de integracion
     - M: cantidad de intervalos
     - h: separacion de abscisas
  %}
  x = linspace(a,b,2*M+1);

  x_1 = linspace(a-1,b+1);
  y_1 = f(x_1);

  hold on
  axis([min(x_1) max(x_1) 0 max(y_1)]);
  i = 1;
  while i < b
    pol = lagrange(f, [x(2*i-1) x(2*i) x(2*i+1)]);
    x_k = linspace(x(2*i-1),x(2*i+1));
    y_k = pol(x_k);

    plot(x_k,y_k, 'LineWidth', 1.5);
    area(x_k,y_k, 'FaceColor', "#BECBF5");
    i = i+1;
  end
  plot(x_1,y_1, 'k','LineWidth', 1.5);
  hold off

endfunction
