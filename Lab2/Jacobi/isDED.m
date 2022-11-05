function isDed = isDED(A)
  isDed = true;

  for i = 1 : length(A)
    sum = 0;
    for j = 1: length(A)
      if j != i
        sum += abs(A(i,j));
      endif
    endfor

    if sum > abs(A(i,i))
      isDed = false;
      break
    endif
  endfor

endfunction
