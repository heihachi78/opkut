set Breweries;
param production{Breweries} >= 0; # l
set Universities;
param demand{Universities} >= 0; # l 
param distance{Breweries,Universities} >= 0; # km
param transportation_cost >= 0; # Ft/l/km

var transport{Breweries,Universities} >= 0; # l

s.t. Brewery_capacity_cannot_be_exceeded {b in Breweries}: # l
    # Nem vihetek el tobb sort, mint amennyit naponta csinalnak
    # Legfeljebb annyit vihetek el, mint amennyit naponta csinalnak
    # amennyit elviszek  <=  amennyit naponta csinalnak
    # amennyit elviszek  <=  production[b]
    # mennyit visznek u1-be + mennyit visznek u2-be + ...  <=  production[b]
    # sum{u in Universities} mennyit visznek b-bol u-ba  <=  production[b]
    sum{u in Universities} transport[b,u]  <=  production[b];

s.t. University_demand_must_be_satisfied {u in Universities}: # l 
    sum{b in Breweries} transport[b,u] >= demand[u]; 

minimize Cost: # Ft
    sum{b in Breweries, u in Universities} 
        distance[b,u] transportation_cost * transport[b,u]; 
;