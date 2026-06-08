var A >= 0, <= 0.5;
var B >= 0, <= 0.5;
var C >= 0, <= 0.5;
var D >= 0, <= 0.5;
var E >= 0, <= 0.5;

var x_1;
var x_2;
var x_3;
var x_4;

minimize z:
    2*A + 4*B + 6*C + 8*D + 10*E;

s.t. elso_idopont:
    x_1 = 0;

s.t. A_el:
    x_2 >= x_1 + 1 - A;

s.t. B_el:
    x_3 >= x_1 + 3 - B;

s.t. C_el:
    x_3 >= x_2 + 1 - C;

s.t. D_el:
    x_4 >= x_2 + 3 - D;

s.t. E_el:
    x_4 >= x_3 + 1 - E;

s.t. projekt_hatarido:
    x_4 - x_1 <= 3.5;

solve;

printf "Optimalis megoldas:\n";
printf "z = %g\n", z;
printf "A = %g\n", A;
printf "B = %g\n", B;
printf "C = %g\n", C;
printf "D = %g\n", D;
printf "E = %g\n", E;
printf "x_1 = %g\n", x_1;
printf "x_2 = %g\n", x_2;
printf "x_3 = %g\n", x_3;
printf "x_4 = %g\n", x_4;

end;
