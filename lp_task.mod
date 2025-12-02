var x >= 0;
var y >= 0;

s.t. one:
    3*x + 4*y <= 15;

s.t. two:
    2*x + y <= 8;

s.t. three:
    x + 4*y <= 25;

maximize M: x + 2*y;

solve;

printf "Optimal solution: x = %g, y = %g\n", x, y;