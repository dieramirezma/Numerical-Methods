function s = dbl2str(d);
  z = typecast(d,"uint32");
  s = sprintf("%.3g{%08x%08x}\n",d,z);
endfunction
