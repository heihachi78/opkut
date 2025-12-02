# https://hegyhati.github.io/IMOLS/pages/motivational_froccs.html

set Froccs;
set Alapanyag;

param Hozzavalok{Froccs, Alapanyag} >= 0 integer;
param Ar{Froccs} >=0 integer;
param Keszlet{Alapanyag} >=0 integer;

var Elad{Froccs} >=0;

s.t. Alapanyag_korlat{a in Alapanyag}:
    sum{f in Froccs} Hozzavalok[f, a] * Elad[f] <= Keszlet[a];

maximize Objective:
    sum{f in Froccs} Elad[f] * Ar[f];

solve;

for {f in Froccs} {
    printf "Elad %s-ból %g-adagot %g összegben\n", f, Elad[f], Elad[f] * Ar[f];
}
printf "Nyereség: %g\n", sum{f in Froccs} Elad[f] * Ar[f];
for {a in Alapanyag} {
    printf "Felhasznált %s: %g\n", a, sum{f in Froccs} Elad[f] * Hozzavalok[f, a];
}

end;
