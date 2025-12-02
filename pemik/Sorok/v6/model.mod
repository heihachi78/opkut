set Breweries;
param production_hl{Breweries} >= 0; # l
param production{b in Breweries} := production_hl[b] / 10;

param price_Ft_p_l{Breweries} >= 0; # Ft/l
param price{b in Breweries} := price_Ft_p_l[b] * 1000 / beer_density; # Ft/kg
set Universities;
param demand_l{Universities} >= 0; # l 
param demand{u in Universities} := demand_l / 1000;
param distance_km{Breweries,Universities} >= 0; # km
param distance{b in Breweries, u in Universities} := distance_km[b,u] / 1000;
param likes{Universities, Breweries} binary; # -

set Cars;
param capacity_l{Cars} >= 0; # l
param capacity{c in Cars} := capacity_l / 1000;
param weight_kg{Cars} >= 0; # kg
param weight{c in Cars} := weight_kg[c];
param consumption_l_p_100km_p_kg{Cars} >= 0; # l / 100km / kg
param consumption{c in Cars} := consumption_l_p_100km_p_kg[c] / 100 / 1000 / 1000;

param beer_density_g_p_cm3; # g / cm^3
param beer_density := beer_density_g_p_cm3 / 1000 * 1000000;
param fuel_price_Ft_p_l >= 0; # Ft/l
param fuel_price := fuel_price_Ft_p_l * 1000;

var transport{Breweries,Universities,Cars} >= 0; # kg
var trips{Breweries,Universities,Cars} >= 0, integer; # -

s.t. Number_of_trips_should_be_enough_for_transport_led_beer{b in Breweries, u in Universities, c in Cars}:
    beer_density * capacity[c] * trips[b,u,c] >= transport[b,u,c];

s.t. Dont_transport_unliked_beer{b in Breweries, u in Universities: likes[b,u] == 0}: 
    sum{c in Cars} transport[b,u,c] = 0; 

s.t. Brewery_capacity_cannot_be_exceeded {b in Breweries}: 
    sum{c in Cars, u in Universities} transport[b,u,c] / beer_density  <=  production[b];

s.t. University_demand_must_be_satisfied {u in Universities}: 
    sum{c in Cars, b in Breweries} transport[b,u,c] / beer_density >= demand[u]; 

var transport_consumption{Breweries, Universities, Cars} >= 0;
s.t. Set_transport_cost_for_car_type{b in Breweries, u in Universities, c in Cars}:
    transport_consumption = consumption[c] * distance[b,u] * transport_weight[b,u,c];

var transport_weight{Breweries, Universities, Cars} >= 0;
s.t. set_transport_weight{b in Breweries, u in Universities, c in Cars}:
    transport_weight[b,u,c] = 2*trips[b,u]*weight[c] + transport[b,u,c];

minimize Cost: # Ft
    # Transportation cost
    fuel_price * 
    sum{b in Breweries, u in Universities, c in Cars} * transport_consumption[b,u,c]
    +
    # Purchase cost
    sum{b in Breweries} price[b] * sum{u in Universities} transport[b,u]
;