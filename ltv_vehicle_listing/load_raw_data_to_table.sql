LOAD DATA INFILE '/Users/navyasatish/Downloads/vehicle_challenge.csv'
INTO TABLE LTV.stage_public_vehicle_list
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;