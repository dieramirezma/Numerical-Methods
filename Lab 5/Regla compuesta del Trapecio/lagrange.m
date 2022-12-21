function pol = lagrange(f,X)
  %{
    Funcion polinomio interpolador de Lagrange grado 2
    Entradas:
     - f: funcion a interpolar
     - X: abscisas a inertpolar
    Salidas:
     - pol: polinomio interpolador de grado 2
  %}
  f_1 = "f(X(1)) .* ((x-X(2)).*(x-X(3)))/((X(1)-X(2)).*(X(1)-X(3)))";
  f_2 = "f(X(2)) .* ((x-X(1)).*(x-X(3)))/((X(2)-X(1)).*(X(2)-X(3)))";
  f_3 = "f(X(3)) .* ((x-X(1)).*(x-X(2)))/((X(3)-X(1)).*(X(3)-X(2)))";
  pol = strcat("@(x)",f_1,"+",f_2,"+",f_3);
  pol = str2func(pol);
end
