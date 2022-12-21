close all, clc, clear
format long
pkg load symbolic
pkg load tablicious
disp("============ DERIVADA DEL POLINOMIO INTERPOLADOR DE NEWTON: ============");

% ENTRADAS: f(x) y x0
str = input('Ingresa la función a derivar: ','s');
x0 = input('Ingresa el valor de la abscisa x0 a evaluar: ');

% Cálculo de la f'(x) y evaluación en x0 para el posterior error
str = strcat('@(x)',str);
funcion = str2func(str);
syms f(x);
f(x) = funcion;
derivada = diff(f,x);
x0_prima = double(derivada(x0));

% Tabla en donde se almacenan los resultados
tabla = zeros(4, 5);

% for para cada incremento h
for i=1:4
  h = [0.1 0.01 0.001 0.0001](i);
  tabla(i, 1) = h;

  fprintf("\nDERIVADAS PARA h = %d: \n", h);

  % for para las dos funciones
  for f = 1:2
    % X para la primera función
    if (f==1)
      X = [x0 x0+h x0-h];
    % X para la segunda función
    else
      X = [x0 x0+2*h x0+h x0-h x0-2*h];
    end

    % Cálculo de las ordenadas
    Y = funcion(X);

    % Cálculo de las diferencias divididas
    diferencias = Y;
    N = length(X);
    for j=2:N
      for k=N:-1:j
        diferencias(k)=(diferencias(k)-diferencias(k-1))/(X(k)-X(k-j+1));
      end
    end

    % Valor inicial de la derivada
    df0 = diferencias(2);

    % Valor inicial de la productoria
    prod = 1;

    % String para almacenar la derivada del polinomio
    p_prima = num2str(df0);
    prods = '';

    % Cálculo de la derivada aproximada
    for k=2:N - 1
      prod = prod*(x0 - X(k));
      df0 = df0 + diferencias(k + 1)*prod;

      % Actualización del string de la derivada
      prods = strcat(prods,  '(x0 - (', num2str(X(k)), '))');
      p_prima = strcat(p_prima, ' + (', num2str(diferencias(k+1)), ')', prods);
    end

    % Se almacenan la derivada aproximada y el error en la tabla
    tabla(i, f*2) = df0;
    tabla(i, f*2 + 1) = x0_prima - df0;


    fprintf("FUNCIÓN %d: \n", f);
    p_prima
  end
end
tabla(:,3)
% Tabla
t = table(tabla(:,1),tabla(:,2),tabla(:,3),tabla(:,4),tabla(:,5), 'VariableNames', {"Incremento", "Aprox. fórmula 1", "Error fórmula 1", "Aprox. Fórmula 2", "Error fórmula 2"});
prettyprint(t);

