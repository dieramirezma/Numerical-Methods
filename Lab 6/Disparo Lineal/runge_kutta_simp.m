function y_k = runge_kutta_simp(f,y0,a,b,h)
  M = (b-a)/h;

  f1 = f(a, y0);
  f2 = f(a + h/2, y0 + h/2*f1);
  f3 = f(a + h/2, y0 + h/2*f2);
  f4 = f(a + h, y0 + h*f3);
  y_kk = y0 + h/6 * (f1 + 2*f2 + 2*f3 + f4);

  y_k = [y0 y_kk];

  for k=1: M-1
    f1 = f(a + k*h, y_k(k+1));
    f2 = f((a + k*h) + h/2, y_k(k+1) + h/2*f1);
    f3 = f((a + k*h) + h/2, y_k(k+1) + h/2*f2);
    f4 = f((a + k*h) + h, y_k(k+1) + h*f3);
    y_kk = y_k(k+1) + h/6 * (f1 + 2*f2 + 2*f3 + f4);
    y_k(end+1) = y_kk;
  endfor
end

