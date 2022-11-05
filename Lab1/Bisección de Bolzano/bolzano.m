% SCRIPT QUE IMPLEMENTA EL METODO DE BISECCION DE BOLZANO PARA SOLUCION DE ECUACIONES NO LINEALES

% Cargar el paquete para la tabla
% Ejecutar los siguientes comandos en consola para instalar y cargar el paquete
% pkg install https://github.com/apjanke/octave-tablicious/releases/download/v0.3.6/tablicious-0.3.6.tar.gz
% pkg load tablicious

%Recibir la funcion
str = input('Ingresa la función a evaluar: ','s');
%Recibir el valor de error
error = input('Ingresa el error en y: ');

% Validacion del valor de error
while error < 10^(-7)
  disp('El error es muy pequeño. Ingrese nuevamente el error');
  error = input('Ingresa el error en y: ');
end

%Recibir los rangos del intervalo
x0 = input('Ingresa el valor inicial del rango: ');
x1 = input('Ingresa el valor final del rango: ');

%Convertir cadena de entrada a funcion octave
str = strcat('@(x)',str);
funcion = str2func(str);

% Variable para controlar el numero maximo de iteraciones
num_iteraciones = 30;

% Imagenes de los rangos iniciales
y0 = funcion(x0);
y1 = funcion(x1);

% Variable que almacena la aproximacion final
aprox_final = 0;

%Ciclo que verifica que las imagenes de los rangos iniciales sean de diferente signo
while (y0 * y1) >= 0

  % if - elseif de validacion en caso de que las imagenes de los rangos iniciales sean cero (al menos 1)
  if (y0 == 0)
    aprox_final = x0;
    break;
  elseif (y1 == 0)
    aprox_final = x1;
    break;
  endif

  fprintf('\nRecuerde que los signos de las imagenes de los limites del intervalo deben ser opuestos. Intente nuevamente\n\n');

  x0 = input('Ingresa el valor inicial del rango: ');
  x1 = input('Ingresa el valor final del rango: ');

  y0 = funcion(x0);
  y1 = funcion(x1);
end

%% Copia de los valores iniciales del rango para ser utilizados en el grafico
a = x0;
b = x1;

% Punto medio del intervalo inicial y su imagen
xr = (x0 + x1)/2;
yr = funcion(xr);

% Imagen de la aprox. final
f_aprox = funcion(aprox_final);

%Vectores que guardaran los datos para hacer la tabla
ext_izq_ak = [x0];
punto_medio_ck = [xr];
ext_der_bk = [x1];
valor_funcion_ck = [yr];

% Variable iteradora
k = 0;
valoresx = [];
valoresy = [];
% Ciclo que realiza el metodo de bolzano
% Se mantiene el ciclo mientras el valor absoluto de la imagen del valor medio del intervalo sea mayor al error
% y el numero de iteraciones sea menor al maximo, y mientras no se encuentre un cero exacto  de la funcion
while (abs(yr) > error && k < num_iteraciones && (f_aprox != 0 || (aprox_final != x0 && aprox_final != x1 )))
  k = k + 1;

  % Validacion de un cero exacto
  if (yr == 0)
    aprox_final = xr;
    break;

  % Si el extremo izquierdo tiene el mismo signo que el valor medio, se actualiza x1 con xr, al igual que su imagen
  elseif (y0 < 0 && yr < 0) || (y0 > 0 && yr > 0)
    x0 = xr;
    y0 = yr;
  % En caso contrario significa que el extremo derecho tiene igual signo que el valor medio, por lo cual
  % se actualiza x1 con xr, al igual que su imagen
  else
    x1 = xr;
    y1 = yr;
  end

  %Actualizacion del rango
  xr = (x0 + x1)/2;
  yr = funcion(xr);

  f_aprox = funcion(aprox_final);

  %Actualizacion de los vectores
  ext_izq_ak(end + 1) = x0;
  punto_medio_ck(end + 1) = xr;
  ext_der_bk(end + 1) = x1;
  valor_funcion_ck(end + 1) = yr;

  aprox_final = xr;
  valoresx(end+1) = aprox_final;
  valoresy(end+1) = funcion(aprox_final);
end

f_aprox = funcion(aprox_final);
valoresx(end+1) = aprox_final;
valoresy(end+1) = funcion(aprox_final);

% Realizacion de la tabla con resultados finales
names_var = ['k';'Ext izq a_k';'Punto medio c_k';'Ext der b_k';'Valor función f(c_k)'];
c = cellstr(names_var);
obj = table((0:k)', (ext_izq_ak)', (punto_medio_ck)', (ext_der_bk)', (valor_funcion_ck)', 'VariableNames', c);

% Validacion si se encontró un cero exacto o solo una aproximacion
if ((f_aprox==0 && (aprox_final == x0 || aprox_final == x1 || aprox_final == xr)))
  fprintf("Se encontró un cero en: x = %d, f(%f) = %f\n",aprox_final, aprox_final, f_aprox);
  prettyprint(obj);
else
  plot(valoresx, valoresy, "ro");
  fprintf('\nAproximación: ');
  aprox_final
  f_aprox
  prettyprint(obj);
endif

#{
  Funcion de prueba
  x*sin(x)-1
  Rango = [0, 2]
#}
