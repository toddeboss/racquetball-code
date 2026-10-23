/* 10/15/10: making the rankings table ... 

5/17/11: changed rank to be a varchar, since it has to hold Q,S plus 10t and other tie values 
5/18/11: need to add in prize money

*/

----------------------------------------------------------------------------------

use wwwbossconsultingcom;

drop table rankings;

create table rankings
(season varchar(10),
rank varchar(5),
player varchar(50),
points int,
record varchar(10),
prizemoney varchar(10));

----------------------------------------------------------------------------------
-- qa/working


delete from rankings;
truncate table rankings;

select * from rankings;
select * from rankings order by season, rank;

select player from rankings where player not in 
(select distinct loser from results);

select * from rankings where season='2009-10' order by rank asc;


--------
-- 6/8/20: realized that points can be fractions.

create table rankings_20200608 as select * from rankings;

alter table rankings modify column points numeric(9,2);