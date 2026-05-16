set Varosok;

param n := card(Varosok);
param kezdo_varos in Varosok default 1;
param tavolsagok {Varosok, Varosok} >= 0;

var x {i in Varosok, j in Varosok: i <> j} binary;
var sorrend {i in Varosok} integer, >= 1, <= n;

minimize TeljesTavolsag:
    sum {i in Varosok, j in Varosok: i <> j} tavolsagok[i,j] * x[i,j];

subject to CsakEgyKimeno {i in Varosok}:
    sum {j in Varosok: j <> i} x[i,j] = 1;

subject to CsakEgyBejovo {j in Varosok}:
    sum {i in Varosok: i <> j} x[i,j] = 1;

subject to KezdoVarosFixalasa:
    sorrend[kezdo_varos] = 1;

subject to NemKezdoVarosSorrendAlso {i in Varosok: i <> kezdo_varos}:
    sorrend[i] >= 2;

subject to NincsReszkor {i in Varosok, j in Varosok: 
            i <> j and i <> kezdo_varos and j <> kezdo_varos}:
    sorrend[i] - sorrend[j] + n * x[i,j] <= n - 1;

solve;

printf "\nOptimalis teljes tavolsag: %g\n", TeljesTavolsag;
printf "Valasztott elek:\n";
for {i in Varosok, j in Varosok: i <> j and x[i,j] > 0.5} {
    printf "%g -> %g  tavolsag: %g\n", i, j, tavolsagok[i,j];
}

printf "Korut:";
for {k in 1..n} {
    for {i in Varosok: sorrend[i] = k} {
        printf " %g ->", i;
    }
}
printf " %g\n", kezdo_varos;

end;
