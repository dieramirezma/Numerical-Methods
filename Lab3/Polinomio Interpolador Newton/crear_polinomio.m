% Funcion para construir el polinomio de Newton en diferencias finitas
function [pol,s, polstr] = crear_polinomio(D,G,h,x,x_i)

  % Parametro adicional para el polinomio en diferencias finitas
  s = @(x) (x-D(x_i,1))/h;

  % Valor para el polinomio de grado cero
  f_0 = D(x_i,2);

  % Construccion del polinomio
  if G == 0
    pol = f_0;
  else
    num = "";
    for k=1: G
      temp = "";
      for i=0: k-1
        % Concatenacion de los productos de s (e.j s*(s-1)*(s-2)...)
        temp = strcat(temp, "(", "s", "-", num2str(i), ")", "*");
      endfor
      temp = strtrunc(temp, length(temp)-1);
      num = strcat(num, temp, "/", num2str(factorial(k)),"*", num2str(D(x_i+k,k+2)), "+");
    endfor

    num = strtrunc(num, length(num)-1);

    % Conversion del polinomio string a funcion
    polstr = strcat(num2str(D(x_i, 2)), "+", num);
    pol = str2func(strcat("@(s)",num2str(D(x_i, 2)), "+", num));
  endif

endfunction
