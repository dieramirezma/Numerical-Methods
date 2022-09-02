## Funcion que permite resolver un sistema triangular inferior mediante sustituicones progresivas
## A -> Matriz de coeficientes
## B -> Matriz de constantes
function sol = sus_progresiva(A,B)

  % Declaracion de la matriz solucion
  sol = []';

  % Despeje de la primera variable
  N = length(A);
  x_N =B(1) / A(1,1);

  % Actualizacion de la matriz solucion con el primer valor hallado x_1 (primera posicion)
  sol(1) = x_N;

  % Inicializacion de la variable x_k
  x_k = 0;

  % Inicializacion de la variable iteradora k (2 porque empieza desde la segunda fila)
  k = 2;

  % Ciclo que ejecuta el metodo hasta que se llegue a la ultima fila de A
  while k < N+1

    % Variable suma que guarda la sumatoria de todos a_kj*x_j del sistema (formula general del metodo)
    suma=0;

    %Ciclo que realiza la sumatoria de los a_kj*x_j
    j = k-1;
    while j > 0
      suma = suma + A(k,j)*sol(j);
      j--;
    endwhile

    % Asignacion del valor x_k correspondido con la formula general del metodo
    x_k = (B(k) - suma) / A(k,k);

    % Actualizacion de la matriz solucion con el x_k en la posicion k
    sol(k) = x_k;

    k++;

  endwhile

  % Transpuesta de la matriz solucion (vector fila -> vector columna)
  sol';
endfunction
