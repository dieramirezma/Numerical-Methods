clc
% Ejecutar el siguiente comando en caso de no tener ejecutado tablicious
% pkg install https://github.com/apjanke/octave-tablicious/releases/download/v0.3.6/tablicious-0.3.6.tar.gz
pkg load tablicious

%POLINOMIO INTERPOLADOR DE NEWTON EN DIFERENCIAS FINITAS
%{
  Ingreso de datos haciendo uso de la funcion validacion_entradas()
  DATOS:
    DF: Matriz que almacena los vectores de abscisas y ordenadas ingrados por el usuario
    h: Distancia entre abscisas (valor constante)
    x: Valor de abscisa a interpolar
    G: Grado del polinomio que se desea generar
    x_i: Valor de abscisa sobre el cual se interpolara x
%}

[DF,h,x,G,x_i] = validacion_entradas();

% Creacion de la tabla de diferencias finitas
for k=1: rows(DF)-1
  y = columns(DF)+1;
  for i=k+1: rows(DF)
    DF(i,y) = DF(i,y-1) - DF(i-1, y-1);
  endfor
endfor

%{
  Creacion del polinomio interpolador de Newton
  Funcion crear_polinomio()
  RETORNO:
    polinomioN: Polinomio interpolador de Newton en funcion del parametro s
    s: Parametro clave en el polinomio en diferencias finitas
%}

[polinomioN,s,polstr] = crear_polinomio(DF, G, h, x, x_i);

polstr = simplify(sym(polstr));

% Valor interpolado
aprox = polinomioN(s(x));

% Vectores de puntos para graficar
Xs = linspace(DF(1,1)-20,DF(end,1)+20, 1000);
Ys = [];

for i = 1: length(Xs)
  Ys(i) = polinomioN(s(Xs(i)));
endfor

% Grafico del polinomio con los puntos dados y el valor interpolado

plot(Xs,Ys,"b","linewidth",1);

hold on
xlabel("x","fontsize",15);
ylabel("y","fontsize",15);
title("Grafico del polinomio interpolador de Newton en diferencias finitas");

grid on
axis([DF(1,1)-20 DF(end,1)+20 polinomioN(s(DF(1,1)-20)) polinomioN(s(DF(end,1)+20))]);

plot(DF(:,1),DF(:,2), ".g","markersize",20);
plot(64, aprox, ".r", "markersize",25);

legend("Polinomio Interpolador de Newton", "Puntos dados", strcat("Punto Interpolado:   (x=", num2str(64), ", y=",num2str(aprox), ")"), "fontsize",12);
hold off

% Creacion de la tabla de resultados
puntos = 0:1:5;
t0 = table(puntos', 'VariableNames', {"Punto"});
t1 = table(DF(:,1), 'VariableNames', {"x_i"});
t2 = table(DF(:,2), 'VariableNames', {"f[x_i]"});

obj = horzcat(t0,t1,t2);

j = 1;
for i=3: columns(DF)
  str = strcat("▲^", num2str(i-2), "f[x_i]");
  t = table(DF(:,i), 'VariableNames', {str});
  obj = horzcat(obj, t);
endfor


fprintf("\n=============================================================================\n");
prettyprint(obj);
fprintf("\n=============================================================================\n");

fprintf("Polinomio interpolador de Newton en diferencias finitas de grado %d:\nForma General => ",G);
disp(polinomioN);
fprintf("\nForma Simplificada => \n");
disp(polstr);
fprintf("\nValor de h => h = %d\nValor de s => s = %d", h, s(x));
fprintf("\nVALOR INTERPOLADO: x = %d, y = %d\n",x,aprox );
disp(" ");


% ENTRADAS DE PRUEBA
%X = [50 60 70 80 90 100]; => Abscisas
%Y = [24.94 30.11 36.05 42.84 50.57 59.30]; => Ordenadas
%x = 64; => Valor a interpolar
%G = 1; => Grado del pol
