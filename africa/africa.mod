set PetrolStation;

param DistanceInKm{PetrolStation} >= 0;
param PetrolPricePerLiter{PetrolStation} >= 0;

param FuelConsumptionPerKm > 0;
param MaxFuelCapacityInLiters > 0;
param MinFuelRemainingInKm > 0;
param IntialFuelInLiters > 0;
param TotalDistance >= 0;

var RefuelInLiters{PetrolStation} >= 0;

s.t. MinFuelInTank{s in PetrolStation}:
    (IntialFuelInLiters + sum {s2 in PetrolStation: DistanceInKm[s2] < DistanceInKm[s]} RefuelInLiters[s2]) / FuelConsumptionPerKm >= DistanceInKm[s] + MinFuelRemainingInKm;

s.t. PreventFuelOverload{s in PetrolStation}:
    (IntialFuelInLiters + sum {s2 in PetrolStation: DistanceInKm[s2] < DistanceInKm[s]} RefuelInLiters[s2]) - (DistanceInKm[s] * FuelConsumptionPerKm) + RefuelInLiters[s] <= MaxFuelCapacityInLiters;

s.t. EnoughFuelToDestination:
    (IntialFuelInLiters + sum {s in PetrolStation} RefuelInLiters[s]) / FuelConsumptionPerKm >= TotalDistance;

minimize FuelCost:
    sum {s in PetrolStation} RefuelInLiters[s] * PetrolPricePerLiter[s];

solve;

printf "Total cost: %g\n\n", FuelCost;

for{s in PetrolStation}
{
    printf "%14s  (%5g km, %3g Dh/l): %5.2g + %5.2g ---> %5.2g l\n", s, DistanceInKm[s], PetrolPricePerLiter[s],
    IntialFuelInLiters + sum {s2 in PetrolStation: DistanceInKm[s2] < DistanceInKm[s]} RefuelInLiters[s2] - DistanceInKm[s] * FuelConsumptionPerKm,
    RefuelInLiters[s],
    IntialFuelInLiters + sum {s2 in PetrolStation: DistanceInKm[s2] < DistanceInKm[s]} RefuelInLiters[s2] - DistanceInKm[s] * (FuelConsumptionPerKm) + RefuelInLiters[s]
    ; 
}

end;
