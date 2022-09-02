%recibimos los extremos del intervalo a analizar
a = input("Ingrese el valor del extremo inicial del intervalo cerrado: ");
b = input("Ingrese el valor del extremo final del intervalo cerrado: ");

%y = input("Ingrese la función con la que trabajar: ", 's')

%comprobamos si f(a) y f(b) tienen signos opuestos
while (funcion1(a)*funcion1(b)) > 0 || a==b
  fprintf('Recuerde que los signos deben ser opuestos, intentelo nuevamente \n')
  a = input("Ingrese el valor del extremo inicial del intervalo cerrado: ")
  b = input("Ingrese el valor del extremo final del intervalo cerrado: ")
end

c = b;

while abs(funcion1(c)) > 0.00001
  c = (a+b)/2;

  %comprobamos si f(a) y f(c) tienen signos opuestos
  if funcion1(a)*funcion1(c) < 0
    b = c;
  elseif funcion1(c)*funcion1(b) < 0
    a = c;
  elseif funcion1(c) ==0
    r = c;
  else
    r = 0;
  endif

end

printf('Resultado aproximado \n')
r = c

