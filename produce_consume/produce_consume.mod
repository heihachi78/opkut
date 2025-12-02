set Producer;
set Consumer;

param supply{Producer} >=0;
param demand{Consumer} >=0;
param cost_to_fulfill{Producer, Consumer} >= 0;

var fulfill{Producer,Consumer} >=0;

s.t. supply_limit{p in Producer}:
    sum{c in Consumer} fulfill[p, c] <= supply[p];

s.t. demand_limit{c in Consumer}:
    sum{p in Producer} fulfill[p, c] = demand[c];

minimize Objective:
    sum{p in Producer, c in Consumer} cost_to_fulfill[p, c] * fulfill[p, c];

solve;

for {p in Producer} {
    for {c in Consumer : fulfill[p,c] != 0}{
        printf "From %s to %s : %g\n", p, c, fulfill[p, c];
    }
}

end;