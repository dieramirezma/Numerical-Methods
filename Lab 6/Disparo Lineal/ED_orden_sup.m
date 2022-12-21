function [x_k] = ED_orden_sup(f, x0, y0, a, b, h)
  % Entradas
  %  - f: ED orden superior (2)
  %  - x0: valor inicial primera ecuacion del sistema
  %  - y0: valor inicial segunda ecuacion del sistema
  %  - a: valor inferior del intervalo
  %  - b: valor superior del intervalo
  %  - h: separación de los t_k
  % Salidas
  %  - x_k: solución aproximada a la ED f (usando RK4)
  g = @(t,x,y) y;
  x_k = sistema_RK(g,f,x0,y0,a,b,h);
end
