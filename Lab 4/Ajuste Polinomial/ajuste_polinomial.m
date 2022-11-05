clc

% Entrada de datos
M = input("Ingrese el grado del polinomio: ");
X = input("Ingrese el vector de abscisas: ");
Y = input("Ingrese el vector de ordenadas: ");

% Validacion de la entrada de vectores
while (length(X) != length(Y))
  clc
  disp("Los vectores deben tener el mismo número de elementos")
  X = input("Ingrese el vector de abscisas: ");
  Y = input("Ingrese el vector de ordenadas: ");
end

clc

% Declaracion de matrices iniciales
n = length(X);
F = zeros(n, M+1);
b = zeros(1,n);

% Calculo de los elementos de F (M + 1 funciones dadas por x^(j-1))
for j = 1 : M+1
  F(:,j) = X(1,:).^(j-1);
end

% Declaracion de matrices para resolver el sistema de ecuaciones F'FC = F'Y
A = F'*F;
b = F'*Y';

% Solución del sistema de ecuaciones usando mldivide
C = A \ b;

% Declaracion del polinomio de grado M
pol = "";
polstr = "";
i = M+1;
while i > 0
  % Concatenacion de cada monomio (c_j*x^(j-1))
  pol = strcat(pol, " (",num2str(C(i,1)), "*x.^", num2str(i-1), ") +");
  polstr = strcat(polstr, " (",num2str(C(i,1)), "*x^", num2str(i-1), ") +");
  i--;
end

polstr = strtrunc(polstr, length(polstr)-1);
pol = strtrunc(pol, length(pol)-1);


% Conversion del polinomio de string a function
f = str2func(strcat("@(x)", pol));

% Salidas
disp("F: ")
disp(imprimir(F));
disp("-----------------------------")
fprintf("\nF': \n")
disp(imprimir((F')));
disp("-----------------------------")
fprintf("\nA = F'F : \n")
disp(imprimir(A));
disp("-----------------------------")
fprintf("\nb = F'Y : \n")
disp(imprimir(b));
disp("-----------------------------")
fprintf("\nC = A\b: \n")
disp(imprimir(C));
disp("-----------------------------")

fprintf("\nPOLINOMIO: \nForma general: f(x) = %s\nForma simplificada: \n", polstr);
% Simplificacion del polinomio
polstr = simplify(sym(polstr));
disp(polstr);

disp(" ");

% Grafico del polinomio con los X dados
x = linspace(min(X)-1,max(X)+1, 100);
plot(x, f(x));

hold on
title("Ajuste polinomial")
axis([min(X)-1 max(X)+1 min(Y)-1 max(Y)+1]);
xlabel("x");
ylabel("y");
plot(X,Y, ".g","markersize",20);

if (M == 2)
  txt = 'f(x) = 0.17846x^2 - 0.1925x + 0.85052 \rightarrow';
  text(4,f(4),txt,'HorizontalAlignment','right', "fontsize", 12);
end

legend("Polinomio de ajuste", "Puntos iniciales", "fontsize", 12);
hold off

% Entradas de prueba
% Grado: 2
% X = [-3 0 2 4];
% Y = [3 1 1 3];
