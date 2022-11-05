function S = imprimir(M)
  lineas = [""];

  for i = 1 : rows(M)
    lineas = [lineas; "║"];
  end
  S = horzcat(lineas, num2str(M), lineas);
end


