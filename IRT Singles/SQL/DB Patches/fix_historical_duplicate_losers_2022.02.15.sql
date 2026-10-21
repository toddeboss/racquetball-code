-- fixing duplicated losers from bad data entry.
-- 2/14/22 alerted to issue, alos cleaned up some duplicate tourney names.

SET SQL_SAFE_UPDATES = 0;

create table results_20220214 as select * from results;

-- master list.
select event, loser, count(*) from results 
where event not in ('1979 Kunnan/Kennex Tournament of Champions','1980 Kunnan/Kennex Tournament of Champions')
and loser <> '?' group by event,loser having count(*) > 1;

-----------------------------------------------------------------------
-- individual tourney fixes

select * from results where event='1979 Kunnan/Kennex Tournament of Champions';
select * from results where event='1980 Kunnan/Kennex Tournament of Champions';

update results set notes='Double elimination, hence multiple losses for some players' 
where event in ('1979 Kunnan/Kennex Tournament of Champions','1980 Kunnan/Kennex Tournament of Champions');

----------
select * from results where event='1995 Tournament of Champions';

-- deleting and re-inserting entire tourney

delete from results where event='1995 Tournament of Champions';

------------
select * from results where event='1st Red Swain Memorial 2003';

update results set winner='Barnes, Dave' where event='1st Red Swain Memorial 2003' and round=64 and loser='Barnes, Dave';

update results set loser='?' where event='1st Red Swain Memorial 2003' and round=64 and winner='Barnes, Dave';

------------
select * from results where event='2003 IRT Pro Nationals';

update results set winner='Herrera, Anthony' where event='2003 IRT Pro Nationals' and round=128 and loser='DeJesus, Rob';

update results set winner='Herrera, German' where event='2003 IRT Pro Nationals' and round=128 and loser='Yasser, Garcia';

update results set loser='Herrera, German' where event='2003 IRT Pro Nationals' and round=64 and winner='Coy, Chris';

update results set winner='Herrera, Anthony' where event='2003 IRT Pro Nationals' and round=64 and loser='Rivas, Juan';

update results set loser='Herrera, Anthony' where event='2003 IRT Pro Nationals' and round=32 and winner='Thoerner, Jason';


------------------
select * from results where event='2005 7th Annual Douglas Kitchen & Bath NYC Pro-Am';

update results set loser='Harmon, Mike' where event='2005 7th Annual Douglas Kitchen & Bath NYC Pro-Am' and round=16 and winner='Huczek, Jack';

-------------------
select * from results where event='2009 Pro Nationals';

update results set loser='Rocchi, Dave' where event='2009 Pro Nationals' and round=64 and winner='Carson, Tony';


-----------------------
select * from results where event='2014 Ektelon 209 Battle of the Ages';

update results set source='https://www.r2sports.com/website/event-results.asp?TID=12545' 
where event='2014 Ektelon 209 Battle of the Ages';

update results set loser='Allen, Jansen' where event='2014 Ektelon 209 Battle of the Ages' and round=8 and winner='Carson, Rocky';

-----------------------
select * from results where event='20th United Healthcare US Open';

update results set loser='Castillo, Cesar' where event='20th United Healthcare US Open' and round=64 and winner='Horn, David';

update results set loser='Rojas, Marco' where event='20th United Healthcare US Open' and round=8 and winner='Carson, Rocky';


-----------------------
select * from results where event='8th Schoebers Christmas Classic';

-- no way to fix this.  two players named Johnson. 

-----------------------
select * from results where event='Canadian Racquetball Classic 2006';

-- Burgess, Michael

update results set loser='Husulak, Nathaniel' where event='Canadian Racquetball Classic 2006' and round=32 and winner='Croft, Ben';

-----------------------

select * from results where event='Chihuahua Open';

-- Gutierrez, Reydecel

update results set loser='Sanchez, Ivan' where event='Chihuahua Open' and round=32 and winner='Guidry, Mike';


------------------

select * from results where event='Choice Hotels 7th US Open' order by round desc;
-- and loser='Sturgess, Brent'
;

-- Sturgess, Brent

update results set loser='Cook, Rob' where event='Choice Hotels 7th US Open' and round=64 and winner='Doyle, Tim';


-----------------------
select * from results where event='Choice Hotels 9th US Open' 
-- and loser='Gutierrez, Polo'
;

-- Gutierrez, Polo

update results set loser='Gutierrez, ?' where event='Choice Hotels 9th US Open' and round=256 and winner='Linnell, Joe';



-----------------------
select * from results where event='Denver 75';

-- Wright,  no way to fix this.

-----------------------
select * from results where event='Kings/Bank of Newport Pro-Am Classic' and score='11,13';

-- Bolan, Bobby

update results set loser='Bowman, Jeff', winner='Bolan, Bobby' where event='Kings/Bank of Newport Pro-Am Classic' and score='11,13';

