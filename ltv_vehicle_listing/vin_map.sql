create table LTV.vin_map as
SELECT distinct  vin,case when (substr(vin,1,3) like '1%' OR
			               substr(vin,1,3) like '3%' OR
			 substr(vin,1,3) like '4%' OR
			 substr(vin,1,3) like '5%' OR
			 substr(vin,1,3) like '6%' OR
			 substr(vin,1,3) like '7%'
			)
                               then 'US'
						  when substr(vin,1,3) like '2%' then 'Canada'
					ELSE
						'Outside US and Cananda'
					end Country_of_Manufacture,make,model,year
from LTV.stage_public_vehicle_list ;