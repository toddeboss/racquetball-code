-- Feb 2024; fixing canada event names to correct wrong tourney put in last fall.

SET SQL_SAFE_UPDATES = 0;

select * from results where event='2023-24 Racquetball Canada Winter National Team Selection Event - Mens Open';

update results set event='2023-24 Racquetball Canada Fall National Team Selection Event - Womens Open' 
where event='2023-24 Racquetball Canada Winter National Team Selection Event - Womens Open';

select * from seedings where event='2023-24 Racquetball Canada Winter National Team Selection Event - Mens Open';

update seedings set event='2023-24 Racquetball Canada Fall National Team Selection Event - Womens Open' 
where event='2023-24 Racquetball Canada Winter National Team Selection Event - Womens Open';

update tourneys set event='2023-24 Racquetball Canada Fall National Team Selection Event - womens Open' 
where event='2023-24 Racquetball Canada Winter National Team Selection Event - Womens Open';

-- why are there two records??
select * from tourneys where event='2023-24 Racquetball Canada Fall National Team Selection Event - Womens Open';

SET @row_number = 0; 

create table tourneys_20240208 as select * from tourneys;

select  (@row_number:=@row_number + 1) AS num, t.* from tourneys t 
-- where event like'2023-24 Racquetball Canada Fall National Team Selection Event%';
where event='2023-24 Racquetball Canada Fall National Team Selection Event - Mens Open';


delete from tourneys where event like '2023-24 Racquetball Canada Fall National Team Selection Event%';


insert into tourneys (city,event,date,tmp_date,season,major_flag)
values ('Winnipeg, MT, CAN','2023-24 Racquetball Canada Fall National Team Selection Event - Mens Open','11/25/2023','2023-11-25','2023','N');

insert into tourneys (city,event,date,tmp_date,season,major_flag)
values ('Winnipeg, MT, CAN','2023-24 Racquetball Canada Fall National Team Selection Event - Womens Open','11/25/2023','2023-11-25','2023','N');

