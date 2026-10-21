-- miscellaneous data loading fixing while loading Evan's data.

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

select * from results where season='2000-01' order by tmp_date;

create table results_pre200001load as select * from results;

delete from results where season='2000-01' and event='New Mexico Pro-Am 00';
delete from results where season='2000-01' and event='Colorado Springs 00';
delete from results where season='2000-01' and event='Hilton 5th US Open 00';
delete from results where season='2000-01' and event='Denver 00';
delete from results where season='2000-01' and event='Rosarito Beach 01';
delete from results where season='2000-01' and event='Watertown 01';
delete from results where season='2000-01' and event='Michael Lanning Pro-Am 01';
delete from results where season='2000-01' and event='Chicago 01';
delete from results where season='2000-01' and event='Pro Nationals 01';

delete from results where season='2001-02';


select * from results where event='Albuquerque 01';

update results set date='10/21/2001', tmp_date='2001-10-21' where event='Albuquerque 01';


create table results_pre200203load as select * from results;

select * from results where season='1995-96' order by tmp_date, round desc;

delete from results where season='1995-96';

select * from results where season='1996-97' order by tmp_date, round desc;

delete from results where event='Annapolis 96';

delete from results where event='Canoga Park 96';

delete from results where event='Baltimore 96';

delete from results where event='Denver 96';

delete from results where event='1st US Open 96' and score='';

select * from results where season='2009-10';

select * from results where score='7,67,4';

update results set score='7,6,4' where score='7,67,4';


select * from rankings;

select * from rankings where season = '2013-14' order by cast(rank as unsigned);

select * from rankings where season='2013-14' order by player;

select * from rankings where player like '%Tobon%';


create table results_20161228 as select * from results;

select * from results where event='WPRO Ektelon World Championships 2010';

update results set score='1,0,1' where event='WPRO Ektelon World Championships 2010' and round=16 and winner='Longoria, Paola';

update results set source='www.r2sports.com' where event='WPRO Ektelon World Championships 2010';

update results set source='www.r2sports.com' where event='In Shape WPRO Championships 2010';

update results set source='www.r2sports.com' where event='Miller Lite Open 2010';




select * from results where event='Ektelon WPRO Texas Open';

select * from results where event='Promus Hotels 3rd US Open 98';


 and round=32 and loser='Emerson, Danielle';

update results set loser='Amaya, Cristina' where event='Ektelon WPRO Texas Open' and loser='Baumbaugh, T.J.' and round=16;

update results set loser='Warhaftig, Sarah' where event='Ektelon WPRO Texas Open' and round=32 and loser='Emerson, Danielle';


create table results_20170112 as select * from results;

create table seedings_20170112 as select * from seedings;

-- Big 2006-2009 update

delete from results where event='Miami 09';
delete from results where event='Gaithersburg 09';
delete from results where event='Edmonton 08';
delete from results where event='13th US Open Racquetball Championships 08';
delete from results where event='New Orleans 08';
delete from results where event='Phoenix 08';
delete from results where event='Sacramento 08';
delete from results where event='Choice Hotels 12th US Open 07';
delete from results where event='Canadian Racquetball Classic 07';
delete from results where event='Stockton 07';
delete from results where event='New Orleans 06';
delete from results where event='Miami 05';
delete from results where event='Promus Hotels 3rd US Open 98';
delete from results where event='Denver 75';

----
-- Evan's data load
select distinct event,date, tmp_date from results order by tmp_date;
 
delete from results where event='Courtrooms Pro-Am 76';
delete from results where event='Burlington 76';

delete from results where event='Las Vegas 77';
delete from results where event='Houston 77';
delete from results where event='Denver 77';
delete from results where event='Chattanooga 77';

select * from results;

update results set city='Las Vegas, NV' where city='Las Vegas';
update results set city='Houston, TX' where city='Houston';
update results set city='Denver, CO' where city='Denver';
update results set city='Chattanooga, TN' where city='Chattanooga';
update results set city='Ft. Lauderdale, FL' where city='Fort Lauderdale';


delete from results where event='St. Louis 77';
delete from results where event='Denver 78';
delete from results where event='Seamco Racquetball Classic 78';
delete from results where event='Arvada 79';
delete from results where event='Catalina Classic 79';
delete from results where event='1st Robert W. Kendler Classic';
delete from results where event='NRC DP/Leach Nationals 79';

select * from results where event='Columbus 81';

delete from results where event='Federal Way 81' and season='1980-81';
delete from results where event='Warwick 81';

delete from results where event='Lafayette 82';
delete from results where event='Federal Way 81';
delete from results where event='Bangor 82';
delete from results where event='Lombard 82';
delete from results where event='Fishkill Spring 82';
delete from results where event='Denver 82';

delete from results where event='Winnipeg 82';
delete from results where event='Atlanta 82';
delete from results where event='Melbourne 83';
delete from results where event='Fort Worth 83';
delete from results where event='Pleasanton 83';
delete from results where event='Lombard 83';

delete from results where event='Atlanta 83';
delete from results where event='Toronto 83';
delete from results where event='Vancouver 83';
delete from results where event='Auburn 83';
delete from results where event='Plymouth 83';
delete from results where event='Bangor 84';
delete from results where event='Kent 84';
delete from results where event='Las Vegas 84';
delete from results where event='Fort Worth 84';
delete from results where event='Costa Mesa 84';
delete from results where event='DP/Leach Nationals 84';

delete from results where event='Anchorage 84';
delete from results where event='Auburn 84';
delete from results where event='Essex Junction 84';
delete from results where event='Lynwood 85';
delete from results where event='Anaheim 85';
delete from results where event='Oklahoma 85';
delete from results where event='DP Nationals Boston 85';
delete from results where event='Fort Worth 85';


select * from results where score like '%-%' and season not in ('1981-82','1982-83') and score not like '%inj%';

update results set score='11,20,(17),(12),7' where score='11,20,(17),(12),15-7';

update results set score='20,(17),20,(7),14' where score='20,(17),20,(7),16-14';

update results set score='9,9,9' where score='21-9,21-9,21-9';


delete from results where event='Anchorage 85';
delete from results where event='Fountain Valley 85';

delete from results where event='Anchorage 86';
delete from results where event='Hershey 87';
delete from results where event='Atlanta 87';
delete from results where event='Ohio 87';

delete from results where event='Fort Worth 87';

delete from results where event='Choice Hotels 9th US Open 04';

select player,rank,points,prizemoney from rankings where player='Hoff-Scott, Rita' and season='1983-84' ;

select max(cast(rank as unsigned)) from rankings where season='1979-80';

delete from results where event='Anchorage 87';
delete from results where event='Anaheim 87';
delete from results where event='Fort Worth 88';
delete from results where event='Chicago 88';
delete from results where event='Atlanta 88';
delete from results where event='Fort Worth 89';


delete from results where event='Anchorage 87';
delete from results where event='Anaheim 87';
delete from results where event='Fort Worth 88';
delete from results where event='Chicago 88';
delete from results where event='Atlanta 89';
delete from results where event='Fort Worth 89';

delete from results where event='Anchorage 90';
delete from results where event='Anchorage Spring 91';
delete from results where event='San Francisco 91';

select city, count(*) from results 
-- where city not like '%,%' 
group by city;

update results set city='Anchorage, AK' where city ='Anchorage';
update tourneys set city='Anchorage, AK' where city ='Anchorage';

update results set city='Atlanta, GA' where city ='Atlanta';
update tourneys set city='Atlanta, GA' where city ='Atlanta';

update results set city='Bangor, ME' where city ='Bangor';
update tourneys set city='Bangor, ME' where city ='Bangor';

update results set city='Chicago, IL' where city ='Chicago';
update tourneys set city='Chicago, IL' where city ='Chicago';

update results set city='Denver, CO' where city ='Denver';
update tourneys set city='Denver, CO' where city ='Denver';

update results set city='Federal Way, WA' where city ='Federal Way';
update tourneys set city='Federal Way, WA' where city ='Federal Way';

update results set city='Fishkill, NY' where city ='Fishkill';
update tourneys set city='Fishkill, NY' where city ='Fishkill';

update results set city='Fishkill, NY' where city ='Fishkill,NY';
update tourneys set city='Fishkill, NY' where city ='Fishkill,NY';

update results set city='Fort Worth, TX' where city ='Fort Worth';
update tourneys set city='Fort Worth, TX' where city ='Fort Worth';

update results set city='Lombard, IL' where city ='Lombard';
update tourneys set city='Lombard, IL' where city ='Lombard';

update results set city='Melbourne, FL' where city = 'Melbourne';
update tourneys set city='Melbourne, FL' where city = 'Melbourne';

update results set city='Winnipeg, CAN' where city = 'Winnipeg';
update tourneys set city='Winnipeg, CAN' where city = 'Winnipeg';


delete from results where event='Annapolis 97';
delete from results where event='Promus Hotel 2nd US Open';
delete from results where event='Roanoke 98';
delete from results where event='New York 98';

delete from results where event='Las Vegas 98';

select * from results where date='1/9/2012';

update results set event='2012 Coast to Coast California Open' where event='Canoga Park 12';

delete from results where event='Baltimore 98';
delete from results where event='Lakewood 98';
delete from results where event='Chalfont 99';


delete from results where event='Furrs Supermarkets Pro-Am 99';
delete from results where event='4th US Open 99';
delete from results where event='Denver 00';
delete from results where event='Bud Light Irt Pro Nationals 00';
delete from results where event='Tournament of Champions 00';

delete from results where event='Rosarito Beach 03';
delete from results where event='Charlotte 03';
delete from results where event='Albuquerque 03';
delete from results where event='Choice Hotels 8th US Open 03';
delete from results where event='Hawaii 03';
delete from results where event='Coral Springs 04';
delete from results where event='Chicago 04';
delete from results where event='Nashville 04';
delete from results where event='Tempe 04';

delete from results where event='Rosarito Beach 04';
delete from results where event='Gaithersburg 04';
delete from results where event='Stockton 05';

delete from results where event='Rosarito Beach 05';
delete from results where event='Choice Hotels 10th US Open 05';
delete from results where event='Great Balls of Fire Pro/Am 2006';
delete from results where event='Miami 06';
delete from results where event='Greensboro 06';
delete from results where event='New Orleans 06';
delete from results where event='Boise 06';

create table results_20170126 as select * from results;

delete from results where event='Fayetteville 06';
delete from results where event='Choice Hotels 11th US Open';
delete from results where event='Gaithersburg 06';


delete from results where event='Fayetteville 07';
delete from results where event='2008 California Greater Sacramento Open';
delete from results where event='Sacramento 08';
delete from results where event='York 08';
delete from results where event='Fayetteville 08';
delete from results where event='Tijuana 08';
delete from results where event='Arlington 08';
delete from results where event='York 09';

delete from results where event='13th US Open Racquetball Championships 08' and round <=32;


select count(*) from results;

