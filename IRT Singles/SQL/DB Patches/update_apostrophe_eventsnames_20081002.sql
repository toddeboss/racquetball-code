/* 10/02/08: time to rid the database of apostrphes. */

create table results_20081002 as select * from results;

-- diagnosis:
select * from results where event like '%''%';
select distinct(event) from results where event like '%''%';
select * from results where event = 'Shop ''n Save Pro-Am'

-- fixing
update results set event='Ralphs Pro-Am' where event='Ralph''s Pro-Am';
update results set event='Shop n Save Pro-Am' where event='Shop ''n Save Pro-Am';

update results set event='4th Campbells Healthy Request Pro-Am' 
  where event='4th Campbell''s Healthy Request Pro-Am';
update results set event='5th Campbells Healthy Request Pro-Am' 
  where event='5th Campbell''s Healthy Request Pro-Am';
update results set event='6th Campbells Healthy Request' 
  where event='6th Campbell''s Healthy Request';
update results set event='7th Annual St. Vincents 1st Coast Classic' 
  where event='7th Annual St. Vincent''s 1st Coast Classic';
update results set event='Crohns & Colitis Foundation ProAm' 
  where event='Crohn''s & Colitis Foundation ProAm';
update results set event='RacquetballCatalogs Profest' 
  where event='RacquetballCatalog''s Profest';
update results set event='Ralphs Food 4 Less Pro-Am' where event='Ralph''s Food 4 Less Pro-Am';
update results set event='Ralphs Grocery Pro-Am' where event='Ralph''s Grocery Pro-Am';

/* now players */

update results set winner='OBrien, Tom' where winner='O''Brien, Tom';
update results set winner='OBrien,?' where winner='O''Brien,?';
update results set winner='OConnor,J' where winner='O''Connor,J';
update results set winner='ONeil, Todd' where winner='O''Neil, Todd';

update results set loser='OBrien, Tom' where loser='O''Brien, Tom';
update results set loser='OBrien,?' where loser='O''Brien,?';
update results set loser='OConnor,J' where loser='O''Connor,J';
update results set loser='ONeil, Todd' where loser='O''Neil, Todd';



commit;