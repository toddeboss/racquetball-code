-- Cleaning up tourney names.

SET SQL_SAFE_UPDATES = 0;

create table tourneys_20171112 as select * from tourneys;



select count(*) from results;

-- 515, now 516 after finding missing new orleans event.
select distinct event,date from results order by tmp_date;

-- 513, no2 516 after putting in 3 below; then found the discrepancy.
select count(*) from tourneys;

select event,date from tourneys order by tmp_date;

-- was 20, fixed them all and found 2 missing.
select * from tourneys where event not in 
(select distinct(event) from results);





update tourneys set event='IRA Louisville 74' where event='Louisville 74' and date='10/15/1974';
update tourneys set event='IRA San Carlos 74' where event='San Carlos 74' and date='11/15/1974';
update tourneys set event='IRA Tanner Pro-Am 74' where event='Tanner Pro-Am' and date='12/1/1974';
update tourneys set event='IRA Dallas 75' where event='Dallas 75' and date='1/15/1975';
update tourneys set event='IRA Houston 75' where event='Houston 75' and date='3/15/1975';
update tourneys set event='IRA Tanner Pro-Am 75' where event='Tanner Pro-Am' and date='12/1/1975';
update tourneys set event='IRA San Antonio 76' where event='San Antonio 76' and date='2/15/1976';
update tourneys set event='Tulsa Open 85' where event='Tulsa Open' and date='2/10/1985';
update tourneys set event='Tulsa Open 86' where event='Tulsa Open' and date='2/1/1986';
update tourneys set event='Tulsa Open 87' where event='Tulsa Open' and date='2/1/1987';
update tourneys set event='Foxwoods Pro-Am 97' where event='Foxwoods Pro-Am' and date='11/23/1997';
update tourneys set event='Halloween Classic 00' where event='Halloween Classic' and date='10/29/2000';
update tourneys set event='Foxwoods Pro-Am 01' where event='Foxwoods Pro-Am' and date='2/4/2001';
update tourneys set event='Halloween Classic 01' where event='Halloween Classic' and date='10/28/2001';
update tourneys set event='Foxwoods Pro-Am 02' where event='Foxwoods Pro-Am' and date='1/27/2002';
update tourneys set event='Halloween Classic 02' where event='Halloween Classic' and date='11/3/2002';
update tourneys set event='Halloween Classic 03' where event='Halloween Classic' and date='11/2/2003';
update tourneys set event='Coca-Cola Pro-Am 94' where event='Coca-Cola Pro-Am' and date='12/4/1994';
update tourneys set event='Michael Lanning Benefit Pro-Am 00' where event='Michael Lanning Benefit Pro-Am' and date='2/20/2000';
update tourneys set event='2014 Pete Pierces Party with the Pros' where event='2014 Pete Pierce''s Party with the Pros'
and date='10/18/2014';



-- 3 ... weird.
select * from results where event not in (select event from tourneys);

select * from tourneys where season='1998-9' order by tmp_date;

insert into tourneys (city,event,date,tmp_date,season,major_flag)
values ('Santa Barbara, CA','Santa Barbara IRT Pro-Am','3/21/1999','1999-03-21','1998-9','N');

insert into tourneys (city,event,date,tmp_date,season,major_flag)
values ('Los Angeles, CA','Coast to Coast California Open','1/10/2010','2010-01-10','2009-10','N');

insert into tourneys (city,event,date,tmp_date,season,major_flag)
values ('Sarasota, FL','2017 IRT Florida Pro-am','4/30/2017','2017-04-30','2016-17','N');



select event, count(*) from tourneys group by event having count(*) > 1;

