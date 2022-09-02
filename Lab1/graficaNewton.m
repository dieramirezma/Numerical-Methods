#{
  Funcion para realizar un grafico
  Argumentos de la funcion:
  f -> Funcion a graficar
  a -> Valor inicial del metodo de newton (abscisa)
  xks -> Vector de abscisas (de cada aproximacion en el metodo de Newton-Raphson)
  yks -> Vector de ordenadas (de cada aproximacion en el metodo de Newton-Raphson)
  tit -> Titulo del grafico
#}

function grafico = graficaNewton (f, a, xks, yks, tit)

  % Declaracion del vector de abscisas y ordenadas para realizar el grafico
  men = min(a-a, a+a);
  may = max(a-a, a+a);
  x = linspace(men,may,200);
  y = [];

  for i=1: length(x)
    y(i) = f(x(i));
  endfor

  % Realizacion del grafico de f
  plot(x,y,xks(end),f(xks(end)),'r','markersize', 20 ,xks, yks, 'og');

  % Personalizacion del grafico
  hold on

  % Grafico de los puntos de aproximacion en cada iteracion del metodo
  for i=1: length(xks)
    t = ['x_' num2str(i)];
    text(xks(i)+0.1, yks(i)+0.1, t);
  endfor

  % Titulo del grafico
  title(tit);

  % Grafico de los ejes del plano
  minx = min(x); maxx = max(x);
  miny = min(y); maxy = max(y);
  plot([minx, maxx], [0,0], 'k');
  plot([0,0],[miny, maxy], 'k');

  % Limites de los ejes del plano
  axis([men may min(y) max(y)]);

  hold off

  % Personalizacion de la leyenda del grafico
  texto = ["x = " num2str(xks(end)) '   f(x) = ' num2str(yks(end))];
  legend (func2str(f),texto,'FontSize',14);

endfunction

