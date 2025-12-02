set Breweries;
param production{Breweries} >= 0; # l
param price{Breweries} >= 0; # Ft/l
set Universities;
param demand{Universities} >= 0; # l 
param distance{Breweries,Universities} >= 0; # km
param transportation_cost >= 0; # Ft/l/km
param likes{Universities, Breweries} binary; # -

param car_capacity >= 0; # l
param car_weight >= 0; # kg
param car_consumption >= 0; # l / 100km / kg
param beer_density; # g / cm^3
param fuel_price >= 0; # Ft/l

var transport{Breweries,Universities} >= 0; # l
var trips{Breweries,Universities} >= 0, integer; # -

s.t. Number_of_trips_should_be_enough_for_transported_beer{b in Breweries, u in Universities}: # l
    car_capacity * trips[b,u] >= transport[b,u];

s.t. Dont_transport_unliked_beer_1{b in Breweries, u in Universities : likes[b,u] == 0}: # l
    transport[b,u] = 0; 

s.t. Brewery_capacity_cannot_be_exceeded {b in Breweries}: # l
    sum{u in Universities} transport[b,u]  <=  production[b];

s.t. University_demand_must_be_satisfied {u in Universities}: # l 
    sum{b in Breweries} transport[b,u] >= demand[u]; 

minimize Cost: # Ft
    # Transportation cost
    sum{b in Breweries, u in Universities} 
        fuel_price * car_consumption * (distance[b,u]/100) * (2*trips[b,u]*car_weight  + transport[b,u] * beer_density)
    +
    # Purchase cost
    sum{b in Breweries} price[b] * sum{u in Universities} transport[b,u]
;