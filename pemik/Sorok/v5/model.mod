set Breweries;
param production{Breweries} >= 0; # l
param price{Breweries} >= 0; # Ft/l
set Universities;
param demand{Universities} >= 0; # l 
param distance{Breweries,Universities} >= 0; # km
param transportation_cost >= 0; # Ft/l/km
param likes{Universities, Breweries} binary; # -

set Cars;
param capacity{Cars} >= 0; # l
param weight{Cars} >= 0; # kg
param consumption{Cars} >= 0; # l / 100km / kg

param beer_density; # g / cm^3
param fuel_price >= 0; # Ft/l

var transport{Breweries,Universities,Cars} >= 0; # l
var trips{Breweries,Universities,Cars} >= 0, integer; # -

s.t. Number_of_trips_should_be_enough_for_transported_beer{b in Breweries, u in Universities, c in Cars}: # l
    capacity[c] * trips[b,u,c] >= transport[b,u,c];

s.t. Dont_transport_unliked_beer_1{b in Breweries, u in Universities: likes[b,u] == 0}: # l
    sum{c in Cars} transport[b,u,c] = 0; 

s.t. Brewery_capacity_cannot_be_exceeded {b in Breweries}: # l
    sum{c in Cars, u in Universities} transport[b,u,c]  <=  production[b];

s.t. University_demand_must_be_satisfied {u in Universities}: # l 
    sum{c in Cars, b in Breweries} transport[b,u,c] >= demand[u]; 

minimize Cost: # Ft
    # Transportation cost
    sum{b in Breweries, u in Universities, c in Cars} 
        fuel_price * consumption[c] * (distance[b,u]/100) * (2*trips[b,u]*weight[c]  + transport[b,u,c] * beer_density)
    +
    # Purchase cost
    sum{b in Breweries} price[b] * sum{u in Universities} transport[b,u]
;