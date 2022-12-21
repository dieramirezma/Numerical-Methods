function resultado = ejecutarFuncion(funcion,x)
  sol = strrep (funcion, "x", num2str(x));
  resultado = eval(sol);
endfunction
