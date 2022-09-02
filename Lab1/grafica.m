#{
  Funcion para realizar un grafico
  Argumentos de la function:
  f -> funcion a graficar
  a -> Abscisa inicial
  b -> Abscisa final
  aprox -> Abscisa de aproximacion
  tit -> Titulo del grafico
#}
function grafico = grafica (f,a,b, aprox, tit)
  % Vector de abscisas (x) y ordenadas (y)
  x = linspace(a,b,200);
  y = [];
  for i=1: length(x)
    y(i) = f(x(i));
  endfor

  % Grafico de la funcion junto al punto de aproximacion del metodo
  plot(x,y,aprox,f(aprox),'r','markersize', 20);

  % Personalizacion del grafico
  hold on
  % Titulo del grafico
  title(tit)
  minx = min(x); maxx = max(x);
  miny = min(y); maxy = max(y);

  % Grafica de los ejes x y y
  plot([minx, maxx], [0,0], 'k');
  plot([0,0],[miny, maxy], 'k');

  % Limite de los ejes
  axis([min(a,b) max(a,b) min(f(a),f(b)) max(f(a),f(b))]);

  hold off

  % Personalizacion de la leyenda del grafico
  texto = ["x = " num2str(aprox) ' f(x) = ' num2str(f(aprox))];
  legend (func2str(f),texto,'FontSize',14);

endfunction

