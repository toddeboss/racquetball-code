-- 7/11/17: noticed a discrepancy in the 21 US open tourney names between
-- results and tourneys table.  This fixes it.

-- this is lprt version.


use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys where major_flag='Y' order by tmp_date desc;

select event,date,tmp_date,year(tmp_date),season from tourneys where event in 
('21st United Healthcare US Open',
'20th United Healthcare US Open',
'2014 United Healthcare US Open',
'2013 United Healthcare US Open',
'2012 United Healthcare US Open',
'16th US Open',
'15th Annual US Open',
'14th Annual US Open',
'13th US Open Racquetball Championships 08',
'Choice Hotels 12th US Open 07',
'Choice Hotels 11th US Open',
'Choice Hotels 10th US Open 05',
'Choice Hotels 9th US Open 04',
'Choice Hotels 8th US Open 03',
'Choice Hotels 7th US Open 02',
'Hilton 6th US Open 01',
'2000 Hilton 5th US Open',
'4th US Open 99',
'Promus Hotels 3rd US Open 98',
'Promus Hotel 2nd US Open 97',
'1st US Open 96')
order by tmp_date desc;


select * from results where round='2' and event in 
('21st United Healthcare US Open',
'20th United Healthcare US Open',
'2014 United Healthcare US Open',
'2013 United Healthcare US Open',
'2012 United Healthcare US Open',
'16th US Open',
'15th Annual US Open',
'14th Annual US Open',
'13th US Open Racquetball Championships 08',
'Choice Hotels 12th US Open 07',
'Choice Hotels 11th US Open',
'Choice Hotels 10th US Open 05',
'Choice Hotels 9th US Open 04',
'Choice Hotels 8th US Open 03',
'Choice Hotels 7th US Open 02',
'Hilton 6th US Open 01',
'2000 Hilton 5th US Open',
'4th US Open 99',
'Promus Hotels 3rd US Open 98',
'Promus Hotel 2nd US Open 97',
'1st US Open 96')
order by tmp_date desc;


select * from results where round='2' and city in ('Memphis, TN','Minneapolis, MN')
order by tmp_date desc;

create table tourneys_20170711 as select * from tourneys;

-- generated via XLS

update tourneys set event='21st United Healthcare US Open' where event='21st United Healthcare US Open';
update tourneys set event='20th United Healthcare US Open' where event='20th United Healthcare US Open';
update tourneys set event='2014 United Healthcare US Open' where event='2014 United Healthcare US Open';
update tourneys set event='2013 United Healthcare US Open' where event='2013 United Healthcare US Open';
update tourneys set event='2012 United Healthcare US Open' where event='2012 United Healthcare US Open';
update tourneys set event='16th US Open' where event='16th US Open';
update tourneys set event='15th Annual US Open' where event='15th Annual US Open';
update tourneys set event='14th Annual US Open' where event='14th Annual US Open';
update tourneys set event='13th US Open Racquetball Championships 08' where event='13th US Open Racquetball Championships 08';
update tourneys set event='Choice Hotels 12th US Open 07' where event='Choice Hotels 12th US Open 07';
update tourneys set event='Choice Hotels 11th US Open' where event='Choice Hotels 11th US Open';
update tourneys set event='Choice Hotels 10th US Open 05' where event='Choice Hotels 10th US Open 05';
update tourneys set event='Choice Hotels 9th US Open 04' where event='Choice Hotels 9th US Open 04';
update tourneys set event='Choice Hotels 8th US Open 03' where event='Choice Hotels 8th US Open 03';
update tourneys set event='Choice Hotels 7th US Open 02' where event='Choice Hotels 7th US Open 02';
update tourneys set event='Hilton 6th US Open 01' where event='Hilton 6th US Open 01';
update tourneys set event='2000 Hilton 5th US Open' where event='2000 Hilton 5th US Open';
update tourneys set event='4th US Open 99' where event='4th US Open 99';
update tourneys set event='Promus Hotels 3rd US Open 98' where event='Promus Hotels 3rd US Open 98';
update tourneys set event='Promus Hotel 2nd US Open 97' where event='Promus Hotel 2nd US Open 97';
update tourneys set event='1st US Open 96' where event='1st US Open 96';

commit;

select winner from results where round=2 and event='21st United Healthcare US Open';

select loser,round from results where event='21st United Healthcare US Open';