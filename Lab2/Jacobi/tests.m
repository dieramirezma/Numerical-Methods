clc
A = [4 -1 1
     4 -8 1
     -2 1 5];
B = [7 -21 15];
P_0 = [1 2 2];

x_k = 0; y_k = 2; z_k = 2;

syms x y z

x_f = @(x,y,z) (7+y-z) / 4;
y_f = @(x,y,z) (7+y-z) / 4;
z_f = @(x,y,z) (7+y-z) / 4;

% x_k(0, y_k, z_k);

xs = []';
for i = 1: 10
  x_k =
  xs(end) = x_k;
endfor


% Despeje de variables
#{
for i = 1: length(A)
  for j = 1: length(A)

  endfor
endfor
#}
