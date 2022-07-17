create table LTV.vehicle_decision_maker as
SELECT DISTINCT
ID,
vin ,
CAST(price as decimal(20,2)),
CAST(miles as decimal(20,2)),
case when CAST(miles as decimal(20,2))  <= 30000 then '0-30000'
	 when CAST(miles as decimal(20,2))  between 30001 and 100000 then '30000-100000'
     when CAST(miles as decimal(20,2)) between 100000 and 200000 then '100000-200000'
     when CAST(miles as decimal(20,2)) between 200000 and 400000 then '200000-400000'
     when CAST(miles as decimal(20,2)) > 400000 then '>400000'
end as MileAge_classification,
(case when CAST(miles as decimal(20,2)) <= 30000 then 'Semi-New' else 'Used' end) as Vehicle_condition ,
avg(CAST(miles as decimal(20,2))) over (PARTITION by make,model,year),
stock_no ,
year ,
make,
model ,
trim ,
body_type
vehicle_type ,
drivetrain ,
transmission ,
fuel_type ,
case when fuel_type = 'Electric' then 'Electric'
     when fuel_type like '%Diesel%' then 'Diesel'
     when fuel_type like '%Natural%' then 'Gas'
     when fuel_type in ('Electric / Premium Unleaded',
						'Unleaded / Electric'
						'Electric / Unleaded'
						'Electric / Hydrogen'
						'Electric / Premium Unleaded; Electric / Unleaded')
						then 'Hybrid'
else
      'Gasoline'
end as fuel_classification,
engine_size ,
engine_block ,
seller_name ,
street ,
city ,
state,
zip
from  LTV.stage_public_vehicle_list;

-- seller information
create table LTV.SELLER_DETAILS as
SELECT seller_name ,street ,city ,state ,zip,count(id) as no_of_vehicles_listed
from LTV.stage_public_vehicle_list
group by seller_name ,street ,city ,state ,zip
having count(ID)>5;