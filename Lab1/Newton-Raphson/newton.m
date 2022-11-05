% SCRIPT QUE IMPLEMENTA EL METODO DE NEWTON-RAPHSON PARA SOLUCION DE ECUACIONES NO LINEALES

% Cargar paquetes de calculos y tablas respectivamente
% Ejecutar el siguiente comando en consola en caso de no haber instalado el paquete tablicious aun
% pkg install https://github.com/apjanke/octave-tablicious/releases/download/v0.3.6/tablicious-0.3.6.tar.gz
pkg load symbolic
pkg load tablicious

% Recibir la funcion, el error y el x inicial
str = input('Ingresa la función a evaluar: ','s');
error = input('Ingresa el error en y: ');
xk = input('Ingresa el valor inicial de x: ');

% Copia del valor inicial de abscisa para ser utilizado en el grafico
a = xk;

% Validacion del valor de error
while error < 10^(-8)
  disp('El error es muy pequeño. Ingrese nuevamente el error');
  error = input('Ingresa el error en y: ');
end

% Convertir la cadena a funcion octave
str = strcat('@(x)',str);
funcion = str2func(str);

% Funcion para calculo de la derivada
syms f(x);
f(x) = funcion;
df = diff(f,x);

%Imagen del x inicial
yk = funcion(xk);

% Vectores para la tabla
xks = [];
diferencias_xks = [];
yks = [];

aprox_final = 0;
f_aprox = funcion(aprox_final);

%Variable iteradora
k = -1;

% Ciclo que ejecuta el metodo mientras la variable iteradora sea menor al maximo
% de iteraciones, y el valor abs de la imagen de xk sea mayor al error y no se encuentre un cero exacto
while  k < 5 && (f_aprox != 0 || aprox_final != xk )
  k = k + 1;

  %Variable que almacena la diferencia para la tabla
  anterior = xk;
  yks(end + 1) = yk;

  % Formula para calcular el valor del x_(k+1) (Metodo de Newton-Raphson)
  xk=xk-funcion(xk)/double(df(xk));

  % Imagen del x_(k+1)
  yk=funcion(xk);

  % Validacion en caso de que se encuentre un cero verdadero
  if (yk == 0)
    aprox_final = xk;
    break;
  end

  % Actualizacion de vectores
  xks(end + 1) = anterior;
  diferencias_xks(end + 1) = [xk - anterior];
end

aprox_final = xk;
f_aprox = funcion(xk);

% Creacion de la tabla de resultados
names_var = ['k';'p_k';'p_k+1 - p_k'; 'f(p_k)'];
c = cellstr(names_var);
obj = table((0:k)',(xks)',(diferencias_xks)',(yks)', 'VariableNames', c);

% Impresion de resultados
fprintf('Resultado x = %f, f(x) = %f\n', aprox_final, f_aprox);
prettyprint(obj);

% Grafica de la funcion y el cero aproximado
graficaNewton(funcion, a, xks, yks, 'Newton Raphson');

#{
  Funcion de prueba
  (1980)*(1-e^-(x/10))-98*x
  Abscisa inicial = 16
#}
