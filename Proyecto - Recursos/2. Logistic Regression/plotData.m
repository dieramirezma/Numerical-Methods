function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

figure; hold on;

% =========================================================================

admitted = zeros(1,2);
notadmitted = zeros(1,2);
for i=1: length(y)
  if (y(i,1) == 0)
    notadmitted(end+1,1) = X(i,1);
    notadmitted(end,2) = X(i,2);
  else
    admitted(end+1,1) = X(i,1);
    admitted(end,2) = X(i,2);
  endif
endfor
plot(admitted(2:end,1), admitted(2:end,2), 'k+', 'MarkerSize', 7);
plot(notadmitted(2:end,1), notadmitted(2:end,2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

% =========================================================================

hold off;

end
