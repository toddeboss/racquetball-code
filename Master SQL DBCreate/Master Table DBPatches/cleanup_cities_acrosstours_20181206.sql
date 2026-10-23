/* 11/20/07: noticed inconsistencies in teh city names 

12/6/18: noticed even more, will do some fixing */


use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

select city, count(*) from results group by city order by 1;

select city, count(*) from results_doubles group by city order by 1;

select city, count(*) from tourneys group by city order by 1;

select city, count(*) from tourneys_doubles group by city order by 1;


select city, count(*) from results where city like '%MEX' group by 1;

select city, count(*) from results where city like '%Can' group by 1;

select city, count(*) from results where city like '%COL' group by 1;

select city, count(*) from results where city like '%CHI' group by 1;

select city, count(*) from tourneys where city like '%MEX' group by 1;

select city, count(*) from tourneys where city like '%Can' group by 1;



-- what is this for?
-- select * from city_state;

-- created new sp_ to do all four needed tables: results, tourneys, results_doubles, tourneys_doubles

call sp_fixcity('Riverside, CA','Riverside');
call sp_fixcity('Albuquerque, NM','Albuequerque, NM');
call sp_fixcity('St. Louis, MO','St Louis, MO');

call sp_fixcity('Chihuahua, CH, MEX','Chihuahua, Mex');
call sp_fixcity('San Luis Potosi, SL, MEX','San Luis Potosi, Mex');
call sp_fixcity('San Luis Potosi, SL, MEX','San Luis Potosi, SL MeX');
call sp_fixcity('San Luis Potosi, SL, MEX','San Luis, SL MEX');
call sp_fixcity('Tijuana, BC, MEX','Tijuana, Mex');

call sp_fixcity('Guadalajara, JA, MEX','Guadelajara, MEX');
call sp_fixcity('Guadalajara, JA, MEX','Guadelajara, JA, MEX');
call sp_fixcity('Guadalajara, JA, MEX','Guadalajara, MEX');

call sp_fixcity('Huixquilucan, MX, MEX','Huixquilucan, MEX');
call sp_fixcity('Monterrey, NL, MEX','Monterrey, MEX');
call sp_fixcity('Monterrey, NL, MEX','Monterrey, NL MEX');
call sp_fixcity('Rosarito Beach, BC, MEX','Rosarito Beach, MEX');
call sp_fixcity('Toluca, MX, MEX','Toluca, MEX');
call sp_fixcity('Veracruz, VE, MEX','Veracruz, MEX');
call sp_fixcity('Veracruz, VE, MEX','Veracruz, VZ, MEX');
call sp_fixcity('Ciudad Juarez, CH MEX','Ciudad Juarez, MEX');
call sp_fixcity('Ciudad Juarez, CH MEX','Juarez, MEX');
call sp_fixcity('Ciudad Juarez, CH MEX','Juarez, CH ,MEX');
call sp_fixcity('Mexicali, BC, MEX','Mexicali, MEX');
call sp_fixcity('Baja, BC, MEX','Baja, MEX');
call sp_fixcity('Boca del Rio, VE, MEX','Boca del Rio, VE MEX');



call sp_fixcity('Saskatoon, SK, CAN','Saskatoon, Can');
call sp_fixcity('Toronto, AB, CAN','Toronto, CA');
call sp_fixcity('Toronto, AB, CAN','Toronto, Can');
call sp_fixcity('Vancouver, BC, CAN','Vancouver, Can');
call sp_fixcity('Winnipeg, MB, CAN','Winnipeg, Can');
call sp_fixcity('Winnipeg, MB, CAN','Winnipeg, ONT, CAN');
call sp_fixcity('Montreal, QC, CAN','Montreal, Can');
call sp_fixcity('Edmonton, AB, CAN','Edmonton, Can');
call sp_fixcity('Edmonton, AB, CAN','Edmonton, ON, CAN');
call sp_fixcity('Mayfield, AB, CAN','Mayfield, CAN');
call sp_fixcity('Quebec City, QC, CAN','Quebec City, CAN');
call sp_fixcity('Quebec City, QC, CAN',' Qu‚bec City, QC, CAN');
call sp_fixcity('Burnaby, BC, CAN','Burnaby, BC CAN');
call sp_fixcity('Burnaby, BC, CAN',' Burnaby, BC CAN');
call sp_fixcity('Halifax, NS, CAN',' Halifax, CAN');
call sp_fixcity('Port Hawkesbury, NS, CAN',' Port Hawkesbury, NS CAN');
call sp_fixcity('Regina, SK, CAN',' Regina, CAN');
call sp_fixcity('Kelowna, BC, CAN',' Kelowna, BC CAN');





-- Regions/provies for Colombia?

-- Regions/provinces for Chile

-- call sp_fixcity('Santiago, RM, CHI','Santiago, RM CHI');
-- call sp_fixcity('Vina del Mar,VR, CHI','Vina del Mar, CHI');

-- Some variation between DOM and DR; could address.

