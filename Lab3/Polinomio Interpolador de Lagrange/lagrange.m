%Le pedimos al usuario el caso a analizar para saber si posee la función original o no
caso = input('Ingrese 1 si tiene la función original o 2 si solo posee los puntos: ');

%Recibimos la función original del análisis si es caso 1
if caso == 1
  f = input("Ingrese la función original (en terminos de x): ", 's');
  funcion = inline(f,'x');
endif

%Recibimos la cantidad de puntos a partir de los cuales se obtendrá el polinomio
w = input('Ingresa la cantidad de puntos de la interpolación: ');

%Declaramos los vectores en los que guardamos los valores para las abcisas y ordenadas
X=[]; %Vector de abscisas
Y=[]; %Vector de ordenadas

%Realizamos la lectura de datos de cada punto
for r=1:w
  a = input(sprintf('Ingresa el valor en el eje x del punto %s: ',num2str(r)));
  X = [X a];
  if caso != 1
    b = input(sprintf('Ingresa el valor en el eje y del punto %s: ',num2str(r)));
    Y = [Y b];
  endif
endfor

if caso == 1
  Y = cos(X);
endif

n = w-1;

%Declaramos la matriz de los polinomio de coeficientes
L=zeros(w,w);

%Inicializa k para relizar la sumatoria de terminos desde k =1 hasta k = n+1
for k=1:n+1
  %Inicializamos el polinomio coeficiente de Lagrange en 1
   V=1;
   %Calculamos el polinomio coeficiente de Lagrange
   for j=1:n+1
     %Comprobamos que k sea diferente de j
     if k~=j
       %Si es diferente calculamos el valor del polinomio actual
       V = conv(V,poly(X(j)))/(X(k)-X(j));
     endif
   endfor
   %Una vez calculado el polinomio coeficiente, lo agregamos a la matriz L
   L(k,:)=V;
endfor

%Una vez concluida la matriz de los polinomio de coeficientes se multiplica por el
%vector de las ordenadas y obtenemos el polinomio de Lagrange
C= Y*L;
warning('off', 'all');
polinomio = poly2sym(C);

%Calculamos e imprimimos la tabla con los valores resultantes
if caso == 1
  x= 0:.1:1.2;
else
  x= min(X)-1:.1:max(X)+1;
endif

if caso == 1
  y = funcion(x);
  y2 = polyval(C,x);
  data = [x;y;y2;y-y2];
  fprintf('%s ║ \t%s   ║ \t%s   ║ \t%s\n','x_k','f(x_k)','p(x_k)','f(x_k)-p(x_k)');
  fprintf('%d ║ \t%1.6f ║ \t%1.6f ║\t%1.6f\n',data);
endif

%Imprimimos la gráfica del polinomio junto con los puntos dados en el inicio
hold on
plot(x,polyval(C,x),'b')
plot(X,Y,'r.', 'MarkerSize', 14)
if caso == 1
  plot(x,funcion(x),'g', x, cos(x), 'r')
endif

hold off

legend('Polinomio de Lagrage','Puntos dados','Función original')

