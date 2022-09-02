function sistema = imprimir_sistema(A,X,B)

  li = ["║"; "║"; "║"; "║";"║"; "║"; "║"; "║"];
  es = [' '; ' '; ' '; ' ';' '; ' '; ' '; ' '];
  ig = [' '; ' '; '='; ' ';' '; ' '; ' '; ' '];

  lineas = [li(1:rows(X),:)];
  espacios = [es(1:rows(X),:)];
  iguales = [ig(1:rows(X),:)];
  if columns(X) <= columns(A)
    sistema = [lineas espacios num2str(A) espacios lineas espacios num2str(X) espacios lineas espacios iguales espacios lineas espacios num2str(B) espacios lineas];
  else
    sistema = [lineas espacios num2str(A) lineas espacios iguales espacios lineas espacios num2str(X) espacios lineas espacios  lineas espacios num2str(B) espacios lineas];
  endif

endfunction
