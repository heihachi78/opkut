set Eroforras;
set Termek;

param Korlat{Eroforras} >=0;
param Technologia{Eroforras, Termek} >= 0;
param Nyereseg{Termek} >= 0;

var Gyart{Termek} >=0;

s.t. Eroforras_korlat{e in Eroforras}:
    sum{t in Termek} Technologia[e, t] * Gyart[t] <= Korlat[e];

maximize Objective:
    sum{t in Termek} Gyart[t] * Nyereseg[t];

solve;

for {t in Termek} {
    printf "Gyárt %s-ból %g-darabot %g nyereséggel\n", t, Gyart[t], Gyart[t] * Nyereseg[t];
}
printf "Nyereség: %g\n", sum{t in Termek} Gyart[t] * Nyereseg[t];
for {e in Eroforras} {
    printf "Felhasznált %s erőforrás: %g\n", e, sum{t in Termek} Gyart[t] * Technologia[e, t];
}

end;
