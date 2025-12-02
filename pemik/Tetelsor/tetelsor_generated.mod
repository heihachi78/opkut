var Anna_A binary;
var Anna_B binary;
var Anna_C binary;
var Anna_D binary;
var Anna_E binary;
var Anna_F binary;
var Bela_A binary;
var Bela_B binary;
var Bela_C binary;
var Bela_D binary;
var Bela_E binary;
var Bela_F binary;
var Cela_A binary;
var Cela_B binary;
var Cela_C binary;
var Cela_D binary;
var Cela_E binary;
var Cela_F binary;
var legtobbmunka >= 0;
s.t. A_meg_kell_csinalni: Anna_A + Bela_A + Cela_A = 1;
s.t. B_meg_kell_csinalni: Anna_B + Bela_B + Cela_B = 1;
s.t. C_meg_kell_csinalni: Anna_C + Bela_C + Cela_C = 1;
s.t. D_meg_kell_csinalni: Anna_D + Bela_D + Cela_D = 1;
s.t. E_meg_kell_csinalni: Anna_E + Bela_E + Cela_E = 1;
s.t. F_meg_kell_csinalni: Anna_F + Bela_F + Cela_F = 1;
s.t. Anna_mennyit_dolgozik:
  legtobbmunka >= 3 * Anna_A + 4 * Anna_B + 5 * Anna_C + 6 * Anna_D + 7 * Anna_E + 5 * Anna_F;
s.t. Bela_mennyit_dolgozik:
  legtobbmunka >= 6 * Bela_A + 1 * Bela_B + 9 * Bela_C + 8 * Bela_D + 4 * Bela_E + 4 * Bela_F;
s.t. Cela_mennyit_dolgozik:
  legtobbmunka >= 5 * Cela_A + 5 * Cela_B + 5 * Cela_C + 5 * Cela_D + 5 * Cela_E + 5 * Cela_F;
minimize Hatarido: legtobbmunka;

