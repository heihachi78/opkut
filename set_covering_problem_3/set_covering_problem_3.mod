# https://hegyhati.github.io/IMOLS/pages/motivational_festival.html

set Festival;
set Band;

param Perform{Band, Festival} binary;
param Price{Festival} integer >= 0;

var Go{Festival} binary;

s.t. hear_all_bands{b in Band}:
    sum{f in Festival} Perform[b, f] * Go[f] >= 1;

minimize Objective:
    sum{f in Festival} Go[f] * Price[f];

solve;

for {f in Festival} {
    printf "Go to festival %s: %g\n", f, Go[f];
}
printf "Total money spent:", sum{f in Festival} Go[f] * Price[f];

end;
