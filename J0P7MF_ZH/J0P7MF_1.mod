set Ismeros;
set Konyv;

param Fizet{Ismeros, Konyv} >= 0;
param Keret{Ismeros} >= 0;
param Mindent{Ismeros} >= 0 binary;

var Megvasarol{Ismeros, Konyv} binary;
var Vasarol{Ismeros} binary;

s.t. egy_konyvet_csak_egyszer_adjak_el{k in Konyv}:
    sum{i in Ismeros} Megvasarol[i, k] <= 1;

s.t. keretet_be_kell_tartani{i in Ismeros}:
    sum{k in Konyv} Megvasarol[i, k] * Fizet[i, k] <= Keret[i];

s.t. mindent_visz{i in Ismeros, k in Konyv: Mindent[i] > 0 and Fizet[i, k] > 0}:
    Megvasarol[i, k] = Vasarol[i];

maximize bevetel:
    sum{i in Ismeros, k in Konyv} Fizet[i, k] * Megvasarol[i, k];

solve;

for {i in Ismeros, k in Konyv : Megvasarol[i, k] > 0} {
    printf "%s megveszi %s bevetel = %d\n", i, k, Fizet[i, k];
}
printf "teljes bevetel: %d\n", bevetel;

data;

set Ismeros:= I1 I2 I3 I4 I5;
set Konyv:= K1 K2 K3 K4 K5;

param Fizet:
         K1   K2   K3   K4   K5 :=
I1      100    0   25   60  115
I2        0   75   33    0    0
I3       50    0    0   55    0
I4       75  100    0   35  100
I5        0    0  140    0  144
;

param Keret :=
 I1  125
 I2   75
 I3  105
 I4  175
 I5   284
;

param Mindent :=
 I1  0
 I2  0
 I3  1
 I4  0
 I5  1
;