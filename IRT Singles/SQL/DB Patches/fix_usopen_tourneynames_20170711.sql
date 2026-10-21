-- 7/11/17: noticed a discrepancy in the 21 US open tourney names between
-- results and tourneys table.  This fixes it.


use cp30725_men;

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
'13th US Open Racquetball Championships',
'2007 Choice Hotels US Open',
'11th Choice Hotels US Open',
'10th Choice Hotels US Open',
'Choice Hotels 9th US Open',
'Choice Hotels 8th US Open',
'Choice Hotels 7th US Open',
'Hilton 6th US Open',
'Hilton 5th US Open',
'4th US Open',
'Promus Hotels 3rd US Open',
'Promus Hotel 2nd US Open',
'Promus Hotels 1st US Open')
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
'13th US Open Racquetball Championships',
'2007 Choice Hotels US Open',
'11th Choice Hotels US Open',
'10th Choice Hotels US Open',
'Choice Hotels 9th US Open',
'Choice Hotels 8th US Open',
'Choice Hotels 7th US Open',
'Hilton 6th US Open',
'Hilton 5th US Open',
'4th US Open',
'Promus Hotels 3rd US Open',
'Promus Hotel 2nd US Open',
'Promus Hotels 1st US Open')
order by tmp_date desc;


select * from results where round='2' and city in ('Memphis, TN','Minneapolis, MN')
order by tmp_date desc;

create table tourneys_20170711 as select * from tourneys;

-- generated via XLS

update tourneys set event='21st United Healthcare US Open' where event='21st United Healthcare US Open';
update tourneys set event='20th United Healthcare US Open' where event='20th United Healthcare US Open';
update tourneys set event='United Healthcare 19th US Open' where event='2014 United Healthcare US Open';
update tourneys set event='United Healthcare 18th US Open' where event='2013 United Healthcare US Open';
update tourneys set event='United Healthcare 17th US Open' where event='2012 United Healthcare US Open';
update tourneys set event='16th US Open' where event='16th US Open';
update tourneys set event='15th Annual US Open' where event='15th Annual US Open';
update tourneys set event='14th Annual US Open' where event='14th Annual US Open';
update tourneys set event='13th US Open Racquetball Championships' where event='13th US Open Racquetball Championships';
update tourneys set event='Choice Hotels 12th US Open' where event='2007 Choice Hotels US Open';
update tourneys set event='Choice Hotels 11th US Open' where event='11th Choice Hotels US Open';
update tourneys set event='Choice Hotels 10th US Open' where event='10th Choice Hotels US Open';
update tourneys set event='Choice Hotels 9th US Open' where event='Choice Hotels 9th US Open';
update tourneys set event='Choice Hotels 8th US Open' where event='Choice Hotels 8th US Open';
update tourneys set event='Choice Hotels 7th US Open' where event='Choice Hotels 7th US Open';
update tourneys set event='Hilton 6th US Open' where event='Hilton 6th US Open';
update tourneys set event='Hilton 5th US Open' where event='Hilton 5th US Open';
update tourneys set event='4th US Open' where event='4th US Open';
update tourneys set event='Promus Hotels 3rd US Open' where event='Promus Hotels 3rd US Open';
update tourneys set event='Promus Hotel 2nd US Open' where event='Promus Hotel 2nd US Open';
update tourneys set event='Promus Hotels 1st US Open' where event='Promus Hotels 1st US Open';


-- this is now the correct sql

('21st United Healthcare US Open',
'20th United Healthcare US Open',
'United Healthcare 19th US Open',
'United Healthcare 18th US Open',
'United Healthcare 17th US Open',
'16th US Open',
'15th Annual US Open',
'14th Annual US Open',
'13th US Open Racquetball Championships',
'Choice Hotels 12th US Open',
'Choice Hotels 11th US Open',
'Choice Hotels 10th US Open',
'Choice Hotels 9th US Open',
'Choice Hotels 8th US Open',
'Choice Hotels 7th US Open',
'Hilton 6th US Open',
'Hilton 5th US Open',
'4th US Open',
'Promus Hotels 3rd US Open',
'Promus Hotel 2nd US Open',
'Promus Hotels 1st US Open')