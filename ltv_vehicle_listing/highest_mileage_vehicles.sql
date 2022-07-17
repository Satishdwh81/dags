select   A.make ,A.miles
from
(select  distinct make,miles ,DENSE_RANK () over(PARTITION by make order by CAST(miles as decimal(20,2)) DESC  ) as rnk
from stage_public_vehicle_list
where vehicle_type ='Car'
and miles<>0) A
where A.rnk=1
;

