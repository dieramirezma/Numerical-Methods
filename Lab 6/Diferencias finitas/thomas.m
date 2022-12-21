function [X] = thomas(A,B)
  % Algoritmo de Thomas para sistemas tridiagonales
  % Entradas
  %  - A: Matriz tridiagonal
  %  - B: Vector de valores independientes del sistema AX=B
  % Salidas
  %  - X: Vector solucion a AX=B

  % Tamaño de A
  N = length(A);

  % Matriz identidad de tamaño NxN
  L = eye(N,N);

  % U copia de A
  U = A;

  % Reduccion de A en factorizacion LU
  for k=2: N
    U(k,k-1) = 0;
    L(k,k-1) = A(k,k-1)/U(k-1,k-1);
    U(k,k) = U(k,k) - L(k,k-1)*A(k-1,k);
  endfor

  % Solución sistemas LY=B y UX=Y
  Y = sus_progresiva(L,B);
  X = sus_regresiva(U,Y);
end
