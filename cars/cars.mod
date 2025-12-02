set cars;
set days;

param prices{cars, days} >= 0;

var buy{cars, days} binary;

s.t. one_car_per_day{d in days}:
    sum {c in cars} buy[c, d] <= 1;

s.t. all_cars_must_be_bought{c in cars}:
    sum {d in days} buy[c, d] = 1;

minimize spending:
    sum {c in cars, d in days} buy[c, d] * prices[c, d];

solve;

for {c in cars, d in days : buy[c, d] > 0} {
    printf "buy %s at %s for %d\n", c, d, prices[c, d];
}
printf "total money spent: %d\n", spending;

end;
