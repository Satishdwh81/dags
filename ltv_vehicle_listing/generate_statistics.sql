SELECT count(DISTINCT vin) from LTV.stage_public_vehicle_list;
--171,520
SELECT COUNT(1) from LTV.stage_public_vehicle_list
where vin is not null and price is not NULL
--499,999
SELECT COUNT(1)
from
(SELECT
ID,
vin ,
CAST(price as decimal(20,2)),
CAST(miles as decimal(20,2)),
stock_no ,
cast(year as UNSIGNED),
make,
model ,
trim ,
body_type
vehicle_type ,
drivetrain ,
transmission ,
fuel_type ,
engine_size ,
engine_block ,
seller_name ,
street ,
city ,
state,
zip
from  LTV.stage_public_vehicle_list
) REFINED

-- top 10 cities having max registered truck count
-- sometimes same city exists in two different states so keeping that in mind , state is mentioned here.
select  city ,state ,count(1) as vehiclecount
from stage_public_vehicle_list
WHERE vehicle_type ='Truck' and model = 'F-150'
and stock_no!=''
GROUP BY city ,state
order by 3 desc
limit 10
