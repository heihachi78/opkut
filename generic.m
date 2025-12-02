set Task;
set People;

param cost{Task, People} >= 0;

var do{Task, People} binary;

s.t. task_one_to_one{t in Task}:
    sum{p in People} do[t, p] = 1;

s.t. people_one_to_one{p in People}:
    sum{t in Task} do[t, p] = 1;

minimize Objective:
    sum{t in Task, p in People} cost[t, p] * do[t, p];

solve;

for {t in Task} {
    for {p in People : do[t, p] != 0}{
        printf "%s do %s : %g\n", p, t, cost[t, p];
    }
}

end;