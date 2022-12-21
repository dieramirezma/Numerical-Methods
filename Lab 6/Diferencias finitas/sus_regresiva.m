## Funcion que permite resolver un sistema triangular superior mediante sustituicones regresivas
## A -> Matriz de coeficientes
## B -> Matriz de constantes
function sol = sus_regresiva(A,B)

  % Declaracion de la matriz solucion
  sol = [];

  % Despeje de la ultima variable
  N = length(A);
  x_N =B(N) / A(N,N);

  % Actualizacion de la matriz solucion con el primer valor hallado x_N (ultima posicion)
  sol(N) = x_N;

  % Inicializacion de la variable x_k
  x_k = 0;

  % Inicializacion de la variable iteradora k (N-1 porque empieza desde la penultima fila)
  k = N-1;

  % Ciclo que ejecuta el metodo hasta que se llegue a la primera fila de A
  while k > 0

    % Variable suma que guarda la sumatoria de todos a_kj*x_j del sistema (formula general del metodo)
    suma = 0;

    %Ciclo que realiza la sumatoria de los a_kj*x_j
    for j = k+1: N
      suma = suma + A(k,j)*sol(j);
    endfor

    % Asignacion del valor x_k correspondido con la formula general del metodo
    x_k = (B(k) - suma) / A(k,k);

    % Actualizacion de la matriz solucion con el x_k en la posicion k
    sol(k) = x_k;

    % Decrecimiento de la variable iteradora
    k--;

  endwhile

  % Transpuesta de la matriz solucion (vector fila -> vector columna)
  sol';
endfunction
