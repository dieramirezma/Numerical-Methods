clear all, close all, clc

disp("============ FACTORIZACION TRIANGULAR DE SISTEMA AX=B: ============");
fprintf("\n============ INGRESO DE DATOS MATRIZ A: ============\n");

% Ingreso dimension de la matriz A (NXN)
N = input("Ingrese la dimension de la matriz A (cuadrada): ");

% Declaracion de la matriz A y el vector solucion B
A =[];
B = [];
string = "";

% Ciclo que solicita los valores de A fila por fila
for i = 1: N
  fprintf("Ingrese los elementos de la fila %d separados por un espacio y terminando con punto y coma (;):",i);
  filas = input(" ","s");
  string = strcat(string, filas);
endfor

% Ciclo que solicita los valores de B fila por fila (vector columna)
fprintf("\n============ INGRESO DE DATOS VECTOR B: ============\n");
for i = 1: N
  fprintf("Ingrese elemento de la fila %d:",i);
  b_i = input(" ");
  B(i) = b_i;
endfor

% Conversion de la cadena de elementos de A a matriz de numeros de octave
A=str2num([string]);

% Conversion de vector fila B a vector columna (transpuesta)
B = B';

% Declaracion de matriz L (matriz identidad)
L = eye(N);

% Matriz U (copia de A)
U = A;

% Declaracion de los vectores solucion (X y Y)
X = [];
Y = [];

% Bandera para controlar si la matriz A admite factorizacion LU directa (Sin Intercambios de Fila)
admite = true;

% Vectores de variables del sistema (para impresion de resultados)
literales_x = ["x_1"; "x_2" ;"x_3"; "x_4";"x_5"; "x_6" ;"x_7"; "x_8"];
literales_y = ["y_1"; "y_2" ;"y_3"; "y_4";"y_5"; "y_6" ;"y_7"; "y_8"];
xs = [literales_x(1:N,:)];
ys = [literales_y(1:N,:)];

% Impresion del sistema inicial (AX=B)
inicio = imprimir_sistema(A, xs, B);
fprintf('\nSistema sin solucionar => AX=B\n');
disp(inicio);

% Ciclo For que aplica la Reduccion Gaussiana (sin intercambio de filas)
% Primer for recorre las filas de la matriz A
for k = 1: N

  %Segundo for realiza la reduccion operando las filas de U
  for j = k+1: N

    % if de validacion en caso de haber un cero en la diagonal principal de U
    % si la condicion es cierta, rompe el ciclo (no admite factorizacion LU)
    if U(k,k) == 0
      admite = false;
      break;
    endif

    % Calculo del multiplicador para hacer la reduccion
    m = U(j,k) / U(k,k);

    % Actualizacion de L con el multiplicador
    L(j,k) = m;

    % Operacion entre las filas de la matriz U (haciendo ceros elementos inferiores al pivote)
    % para aplicar la Reduccion Gaussiana
    U(j,:) = U(j,:) -U(k,:).*m;

  endfor

  % if de validacion en caso de que no admita factorizacion LU (se rompe el ciclo externo, terminando
  % proceso)
  if !admite
    break;
  endif
endfor

% if de validacion que permite mostrar dos salidas distintas, en caso de que
% A admita factorizacion LU o no la admita
if admite
  % Si admite factorizacion LU:
  % Impresion del sistema A=LU (factorizacion)
  fprintf("\nFactorizacion A=LU\n");
  LU = imprimir_sistema(A,L,U);
  disp(LU);

  % Solucion del sistema LY=B por sustitucion progresiva
  Y = sus_progresiva(L,B)';

  % Solucion del sistema UX=Y por sustitucion regresiva
  X = sus_regresiva(U,Y)';

  % Impresion del sistema LY=B
  fprintf("\nSISTEMA LY=B\n");
  LY = imprimir_sistema(L,ys,B);
  disp(LY);

  % Impresion del vector columna Y (solucion de Y)
  fprintf("\nSOLUCION Y\n");
  disp([["║";"║";"║";"║"] num2str(Y) ["║";"║";"║";"║"]]);

  % Impresion del sistema UX=Y
  fprintf("\nSISTEMA UX=Y\n");
  UX = imprimir_sistema(U,xs,Y);
  disp(UX);

  % Impresion del vector columna X (solucion de X)
  fprintf("\nSOLUCION X\n");
  disp([["║";"║";"║";"║"] num2str(X) ["║";"║";"║";"║"]]);

  % Impresion del sistema original solucionado (AX=B)
  fprintf('\nSistema solucionado => AX=B\n');
  solucion = imprimir_sistema(A, X, B);
  disp(solucion);
else
  % Si no admite LU:

  % Impresion de la matriz U mostrando el cero en la diagonal principal
  disp("La matriz no admite factorizacion triangular directa, hay un cero en la diagonal principal de U");
  U

endif


#{
Caso de Prueba
A = [1 2 4 1
     2 8 6 4
     3 10 8 8
     4 12 10 6];
B = [21 52 79 82]';
#}

