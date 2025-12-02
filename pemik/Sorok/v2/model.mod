set Breweries;
param production{Breweries} >= 0; # l
param price{Breweries} >= 0; # Ft/l
set Universities;
param demand{Universities} >= 0; # l 
param distance{Breweries,Universities} >= 0; # km
param transportation_cost >= 0; # Ft/l/km

var transport{Breweries,Universities} >= 0; # l

s.t. Brewery_capacity_cannot_be_exceeded {b in Breweries}: # l
    sum{u in Universities} transport[b,u]  <=  production[b];

s.t. University_demand_must_be_satisfied {u in Universities}: # l 
    sum{b in Breweries} transport[b,u] >= demand[u]; 

minimize Cost: # Ft
    # Transportation cost
    sum{b in Breweries, u in Universities} 
        distance[b,u] * transportation_cost * transport[b,u]; 
    +
    # Purchase cost
    sum{b in Breweries} price[b] * sum{u in Universities} transport[b,u]
;