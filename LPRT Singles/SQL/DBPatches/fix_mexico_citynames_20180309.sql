-- Quick fix of a typo in a city name for Mexico based events 3/9/18

SET SQL_SAFE_UPDATES = 0;

select * from tourneys where city like '%MeX%';

update tourneys set city='Guadelajara, MEX' where city='Guadelajara, Mexico';
update results set city='Guadelajara, MEX' where city='Guadelajara, Mexico';

update tourneys set city='Chihuahua, MEX' where city='Chihuahua, Mexico';
update results set city='Chihuahua, MEX' where city='Chihuahua, Mexico';

update tourneys set city='San Luis Potosi, SL, MEX' where city='San Luis Potosi, SL MeX';
update results set city='San Luis Potosi, SL, MEX' where city='San Luis Potosi, SL MeX';