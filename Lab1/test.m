%Limpiar la consola
clear all, close all, clc

%Declaracion de variables
mitad = 0;
numero_iteraciones = 15;
aproximacion = 0;
valores_k= [];
valores_izq = [];
valores_med = [];
valores_der = [];
imagen_mitad = [];


%Ingreso de funcion por teclado
f = input('Ingrese la función a trabajar en terminos de x. Ej. x*sin(x)-1: ','s');

%Ingreso del limite por teclado
limite = input("Ingrese el limite numerico hasta el cual desea aproximar con el metodo. Ej: 0.00000001: ");

%Ingreso de los limites del intervalo
a_0 = input("Ingrese el valor del extremo inicial del intervalo cerrado: ");
b_0 = input("Ingrese el valor del extremo final del intervalo cerrado: ");

a=a_0; b =b_0;
%Validacion de los limites (f(a_0) y f(b_0) tienen signo diferente)
while (ejecutarFuncion(f,a_0) * ejecutarFuncion(f,b_0)) >= 0

  if (ejecutarFuncion(f,a_0) == 0)
    aproximacion = a_0;
    break;
  elseif (ejecutarFuncion(f,b_0) == 0)
    aproximacion = b_0;
    break;
  endif

  fprintf('Recuerde que los signos de las imagenes de los limites del intervalo deben ser opuestos. ');
  fprintf('Intente nuevamente\n')
  a_0 = input("Ingrese el valor del extremo inicial del intervalo cerrado: ");
  b_0 = input("Ingrese el valor del extremo final del intervalo cerrado: ");
end

mitad = (a_0 + b_0) / 2;
i = 1;

while ((i<numero_iteraciones) && (ejecutarFuncion(f,aproximacion)!=0 || (aproximacion != a_0 || aproximacion != b_0)) && (ejecutarFuncion(f,mitad) > limite || ejecutarFuncion(f,mitad) < -limite))
  mitad = (a_0 + b_0) / 2;
  valores_k(i) = i-1;
  valores_izq(i) = a_0;
  valores_der(i) = b_0;
  valores_med(i) = mitad;
  imagen_mitad(i) = ejecutarFuncion(f, mitad);
  if (ejecutarFuncion(f,mitad) * ejecutarFuncion(f, b_0) < 0)
    a_0 = mitad;
  elseif (ejecutarFuncion(f, mitad) * ejecutarFuncion(f,a_0) < 0)
    b_0 = mitad;
  elseif (ejecutarFuncion(f,mitad) == 0)
    aproximacion = mitad;
    break;
  endif
  i = i + 1;
endwhile

if ((ejecutarFuncion(f,aproximacion)==0 && (aproximacion == a_0 || aproximacion == b_0 || aproximacion == mitad)))
  fprintf("Se encontró un cero en: x = %d",aproximacion);
else
  data = [valores_k;valores_izq;valores_med;valores_der;imagen_mitad];
  fprintf('%s\t%s\t%s\t%s\t%s\n','k','Izquierda','Mitad','Derecha','Valor f(Mitad)');
  fprintf('%d\t%f\t%f\t%f\t%f\n',data);

  aproximacion = valores_med(end);
  fprintf("\nVALOR APROXIMADO: x = %f",aproximacion);
endif


funci(f,a,b, aproximacion);
%absisas = linspace(a_0, b_0, 500);
%plot(x,);
