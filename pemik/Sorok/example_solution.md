Nagykanizsa -> Pannon EGyetem(Veszprem) : 500l 
    - trabi 100
    - trabi 100
    - uaz   300 
Soproni -> SZE: 200l 
....

var szallit{Sorgyar,Egyetem} >= 0;#l
var hany_auto{Sorgyar,Egyete,Tipius} >= 0 integer; #db
var tipus_szallit{Sorgyar,Egyetem,Tipus} >0; #l

Ellenorzes Veszprem igeny:
    500 + 100 + 300 >= 1000

Ellenorzes Soproni sorgyar:
  200 + 100 + 1000 <= 2000

Ne vigyek olyat, amit nem szeretnek.

Kocsit ne terheljunk tul



Celf:

sum{egyetem, sorgyar, tipus}:
    (tomeg[t] + tipus_szallitas[s,e,t]*suruseg) * szar[t] + 
    (tomeg[t]) * szar[t] -> min
