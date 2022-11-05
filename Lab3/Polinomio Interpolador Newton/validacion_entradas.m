function [DF,h,x,G,x_i] = validacion_entradas()
  X = [];
  Y = [];

  h = 0;
  flag = false;

  % Entrada de los vectores de absc y ordenadas
  while !flag
    while !flag
      disp("=============================================================================");
      X = input("Ingrese el vector de abscisas: ");
      Y = input("Ingrese el vector de ordenadas: ");
      flag = true;

      % Validacion en caso de que los vectores X y Y tengan distinto tamaño
      if length(X) != length(Y)
        fprintf("\n----- Los vectores deben tener la misma cantidad de elementos -----\n");
        flag = false;
      endif
    endwhile

    % Validacion en caso de que los valores de abscisas no sean equidistantes
    h = X(2) - X(1);
    for i=2: length(X)-1
      if (X(i+1) - X(i)) != h
        flag = false;
        fprintf("\n----- Los valores de abscisas deben ser equidistantes -----\n");
        break;
      endif
      flag = true;
    endfor
  endwhile

  % Ingreso de la abscisa a interpolar
  disp("=============================================================================");
  x = input("Ingrese el valor de abscisa a interpolar: ");

  % Validacion en caso de que la abscisa sea menor al menor valor de X o mayor al mayor valor de X
  while x < X(1) || x > X(end)
    fprintf("\n----- La abscisa debe estar entre los extremos del vector de abscisas ingresado -----\n");
    x = input("Ingrese el valor de abscisa a interpolar: ");
  endwhile

  DF = horzcat(X',Y');

  x_i = 0;

  % Busqueda del x_i. En este caso se toma el x inmediatamente menor al valor a interpolar
  for i=1: rows(DF)
    if DF(i,1) > x
      x_i = i-1;
      break;
    endif
  endfor

  % Ingreso del grado que tendrá el polinomio
  disp("=============================================================================");
  fprintf("Rango permitido para el grado: [%d %d]\n", 0, min(rows(DF)-1, rows(DF)-x_i));
  G = input("Ingrese el grado del polinomio que desea crear: ");

  % Validacion en caso de que el grado ingresado este fuera de los límites permitidos
  while (G < 0 || G > min(rows(DF)-1, rows(DF)-x_i))
    fprintf("\n----- El grado del polinomio esta fuera del rango permitido -----\n");
    fprintf("Rango permitido para el grado: [%d %d]\n", 0, min(rows(DF)-1, rows(DF)-x_i));
    G = input("Ingrese el grado del polinomio que desea crear: ");
  endwhile

endfunction
