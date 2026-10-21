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

select city, count(*) from tourneys where city like '%MEX' group by 1;

select city, count(*) from tourneys where city like '%Can' group by 1;



-- what is this for?
select * from city_state;

-- created new sp_ to do all four needed tables: results, tourneys, results_doubles, tourneys_doubles

call sp_fixcity('Riverside, CA','Riverside');
call sp_fixcity('Albuquerque, NM','Albuequerque, NM');

call sp_fixcity('Chihuahua, CH, MEX','Chihuahua, Mex');
call sp_fixcity('San Luis Potosi, SL, MEX','San Luis Potosi, Mex');
call sp_fixcity('Tijuana, BC, MEX','Tijuana, Mex');

call sp_fixcity('Saskatoon, SK, CAN','Saskatoon, Can');
call sp_fixcity('Toronto, AB, CAN','Toronto, CA');
call sp_fixcity('Toronto, AB, CAN','Toronto, Can');
call sp_fixcity('Vancouver, BC, CAN','Vancouver, Can');
call sp_fixcity('Winnipeg, MB, CAN','Winnipeg, Can');
call sp_fixcity('Montreal, QC, CAN','Montreal, Can');
call sp_fixcity('Edmonton, AB, CAN','Edmonton, Can');





