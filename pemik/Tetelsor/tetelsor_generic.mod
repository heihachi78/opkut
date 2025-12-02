set People;
set Subjects;

param worktime{People,Subjects} >= 0;

var do{People,Subjects} binary;
var makespan >= 0;

s.t. All_subjects_must_be_done_by_at_least_one_person{s in Subjects}:
    sum{p in People} do[p,s] >= 1;

s.t. Workload{p in People}:
    sum{s in Subjects} worktime[p,s] * do[p,s] <= makespan;

minimize Makespan: makespan;

solve;

for {p in People} 
{
    printf "%s: ", p;
    for {s in Subjects : do[p,s] == 1}
        printf " %s(%d) ", s, worktime[p,s];
    printf "\n"; 
}

end;
