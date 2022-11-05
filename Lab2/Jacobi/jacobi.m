close all, clc
% Ejecutar el siguiente comando en consola, en caso de no tener instalado tablicious
% pkg install https://github.com/apjanke/octave-tablicious/releases/download/v0.3.6/tablicious-0.3.6.tar.gz
pkg load tablicious
pkg load symbolic

disp("============ MÉTODO ITERATIVO DE JACOBI: ============");
num_ecuaciones = input('Ingresa el número de ecuaciones a resolver: ');
ecuaciones = {};
ecu_despejadas = {};
dicc = ['x','y','z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w'];

count = 0;
%Despeje de ecuaciones
while count < num_ecuaciones
  count = count + 1;
  syms x y z a b c d e f g h i j k l m n o p q r s t u v w
  fprintf("Ingresa la ecuación %d: ", count)
  ecuacion = input(" ");

  %Orden de las variables a ingresar, también será el orden de despeje
  funcion = @(x,y,z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w) ecuacion;

  %Comprobación de DED
  [c, t] = coeffs(ecuacion);
  sum = 0;
  for inx=1:size(c)(2) - 1
    if inx ~= count
      sum = sum + abs(c(inx));
    endif
  endfor

  %Si la fila no cumple con la condición de DED, se reinicia el ingreso de
  %funciones
  if abs(c(count)) < sum
    fprintf("LA MATRIZ INGRESADA NO ES DE DED, INTÉNTALO DE NUEVO\n\n");
    count = 0;
    ecu_despejadas = {};

  %Si la fila es DED, se despeja la variable de la ecuación correspondiente y
  %se guarda la función resultante
  else
    %Despeje de la variable correspondiente y almacenado
    ecu_despejadas{count} = matlabFunction(solve(funcion, sym(dicc(count))));
  end
endwhile

val_iniciales = input('Ingrese el vector con los puntos iniciales: ');
solucion_exacta = input('Ingrese el vector con la solución exacta: ');
resultado = val_iniciales;
resultados = [resultado];

distancia_euclidiana = [];
count = 0;
names_var = {};
%Mientras la aproximación no sea igual al resultado exacto, continúa la
%iteración
while isequal(resultado, solucion_exacta) == false
  count = count + 1;
  distancia_euclidiana(count) = norm(resultado - solucion_exacta,2);
  %Se reemplazan los valores de las variables en cada una de las funciones
  for indx=1:num_ecuaciones
    copia_resultado = resultado;
    copia_resultado(indx) = [];
    copia_resultado = num2cell(copia_resultado);
    resultado(indx) = ecu_despejadas{indx}(copia_resultado{:});
    names_var{indx} = strcat(dicc(indx),'k');
  endfor

  %Se guardan los resultados obtenidos en cada operación
  resultados = [resultados;resultado];

  %Gráfica de cada X, Y y Z, además de la solución exacta

endwhile

if (num_ecuaciones == 3)
  plot3(resultado(1), resultado(2), resultado(3), 'o');
  xlabel('X');
  ylabel('Y');
  zlabel('Z');
  title('f(x, y, z) - Grafica de Aproximacion vs Resultado exacto');
  hold on
  box on;
  plot3(solucion_exacta(1), solucion_exacta(2), solucion_exacta(3),'x');
  plot3(0, 0, 0, 'w.')
  legend(['Aproximación: (' num2str(resultado) ')'],['Resultado exacto: (' num2str(solucion_exacta) ')'],['Distancia entre los puntos:  (' num2str(distancia_euclidiana(count)) ')']);
  axis([0 solucion_exacta(1) + 1 0 solucion_exacta(2) + 1 0 solucion_exacta(3) + 1]);
  hold off
endif
distancia_euclidiana(count+1) = norm(resultado - solucion_exacta,2);

%Tabla
t3 = table(distancia_euclidiana', 'VariableNames', {"P-P_k"})
t2 = array2table(resultados, 'VariableNames', names_var);
t1 = table((0:count)', 'VariableNames', {'k'});

obj = [t1 t2 t3];

prettyprint(obj);
