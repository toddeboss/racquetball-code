-- IRF Working data

SET SQL_SAFE_UPDATES = 0;

truncate table irf_main;

select count(*) from irf_main;

select * from irf_main where division_flag='S' order by year desc, tournament_name;

select distinct year,tournament_name, location from irf_main order by year desc, tournament_name;

select Age_Bracket , gender_combined_flg, First_Place_First_Name, first_place_last_name, first_place_country_1,
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11,
third_place_first_name_2, third_place_last_name_2, third_place_country_21
from irf_main 
-- where year='2015' and tournament_name='Pan American Championships' 
where division_flag='S'
order by year,tournament_name, ifnull(age_bracket,'Open'), gender_combined_flg;



select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11 
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='S';

select ifnull(age_bracket,'Open') from irf_main 
where year='2015' and tournament_name='Pan American Championships' and division_flag='S';

select isnull(null,'blah') from dual;

select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
         Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
         Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11 

         from irf_main where year='2015' and tournament_name='Pan American Championships'  and division_flag='S';
         
         
         

select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg 
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='S' 
order by ifnull(age_bracket,'Open'), gender_combined_flg;         

select age_bracket, 
First_Place_First_Name, first_place_last_name, first_place_country_1, 
First_Place_First_Name_Doubles, First_Place_Last_Name_Doubles, first_place_country_2,
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1,
Second_Place_First_Name_Doubles, Second_Place_Last_Name_Doubles, second_place_country2,
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
third_place_first_name_1_doubles, Third_Place_Last_Name_1_Doubles, third_place_country_12,
Third_Place_First_Name_2, Third_Place_Last_Name_2, Third_Place_Country_21, 
third_place_first_name_2_doubles, Third_Place_Last_Name_2_Doubles, third_place_country_22
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='D' 
order by ifnull(age_bracket,'Open'), gender_combined_flg;        


select * from irf_main where division_flag='D';

select distinct gender_combined_flg from irf_main;


select year, tournament_name, gender_combined_flg, first_place_country_1, Second_Place_Country_1,  Third_Place_Country_11 
from irf_main where team_flag='Team'
order by year, tournament_name
;

select distinct third_place_country_11 from irf_main;

select * from irf_main where third_place_country_11='BEL';


select count(*) from irf_main where year='2015' and tournament_name='Pan American Championships';





update results set round='99' where round='RR';

select last_update_date,banner_text from banner;

select * from seedings;

insert into seedings values ('2017 Pan American Racquetball Championships','29','Zea, Luis Felipe');

select * from results;

select tour,city,date,source,season from results where event='2017 Pan American Racquetball Championships' and round='2' and date='4/15/2017';

ALTER TABLE results_staging MODIFY tour VARCHAR(100);

ALTER TABLE results MODIFY tour VARCHAR(100);

delete from results;


CREATE TABLE `wins` (
  `winner` varchar(50) NOT NULL DEFAULT '',
  `wins` bigint(21) NOT NULL DEFAULT '0',
  KEY `wins_ndx` (`wins`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



update results set event='2017 Pan American Racquetball Championships - Mens Open';

update tourneys set event='2017 Pan American Racquetball Championships - Mens Open';

update seedings set event='2017 Pan American Racquetball Championships - Mens Open';


select tournament_name, count(*) from irf_main group by tournament_name order by 1;

select distinct(year) from irf_main where tournament_name like 'World%' order by year;

select * from irf_main where tournament_name='Pan American Sports Festival';

-- World Games: 1985, 1993, 2009, 2013
select * from irf_main where tournament_name='World Games';

select distinct(tournament_name) from irf_main order by 1;

select distinct(gender_combined_flg) from irf_main;

select distinct(age_bracket) from irf_main;


select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
      Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
      Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
	  third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg,
      year, tournament_name 
      from irf_main where tournament_name= 'Pan American Championships' and division_flag='S' 
      and age_bracket='18U' and gender_combined_flg='W'
      order by year desc, ifnull(age_bracket,'Open'), gender_combined_flg;
      
      
select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, Second_Place_First_Name, 
Second_Place_Last_Name, Second_Place_Country_1, Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg, year, tournament_name 
from irf_main where tournament_name= 'Junior World Championships' 
and division_flag='S' 
-- and age_bracket='18U' 
and gender_combined_flg='M'; 

order by year desc, ifnull(age_bracket,'Open'), gender_combined_flg;      

select distinct(ifnull(age_bracket,'Open')) from irf_main order by ifnull(age_bracket,'Open');

select * from irf_main;

select distinct(concat(first_place_first_name , ' ' , first_place_last_name)) from irf_main where division_flag='S'
union
select distinct(concat(second_place_first_name , ' ' , second_place_last_name)) from irf_main  where division_flag='S'
union 
select distinct(concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1)) from irf_main  where division_flag='S'
union
select distinct(concat(third_place_first_name_2, ' ', third_place_last_name_2)) from irf_main  where division_flag='S'
order by 1;

select 'first',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
where concat(first_place_first_name , ' ' , first_place_last_name) = 'Rocky Carson' and division_flag='S'
union
select 'second',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
where concat(second_place_first_name , ' ' , second_place_last_name) = 'Rocky Carson' and division_flag='S'
union
select 'third',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
where concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = 'Rocky Carson' and division_flag='S'
union
select 'third',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
where concat(third_place_first_name_2, ' ', third_place_last_name_2) = 'Rocky Carson' and division_flag='S'
order by year desc, 1;


select distinct(concat(first_place_last_name, ', ',first_place_first_name)) from irf_main where division_flag='S' \
union \
select distinct(concat(second_place_last_name, ', ',second_place_first_name)) from irf_main  where division_flag='S' \
union \
select distinct(concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) from irf_main  where division_flag='S' \
union
select distinct(concat(third_place_last_name_2, ', ',third_place_first_name_2)) from irf_main  where division_flag='S' \
order by 1;
              
              
              
SET SQL_SAFE_UPDATES = 0;

create table results_20171103a as select * from results;              
              
select * from results where score='14,913),1';

update results set score='14,(13),1' where score='14,913),1';

update results set score='8,(14),6' where score='8,914),6';

update results set score='3,(13),10' where score='3,913),10';




SET SQL_SAFE_UPDATES = 0;

truncate table irf_main;

select count(*) from irf_main;

select * from irf_main where division_flag='S' order by year desc, tournament_name;

select distinct year,tournament_name, location from irf_main order by year desc, tournament_name;

select Age_Bracket , gender_combined_flg, First_Place_First_Name, first_place_last_name, first_place_country_1,
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11,
third_place_first_name_2, third_place_last_name_2, third_place_country_21
from irf_main 
-- where year='2015' and tournament_name='Pan American Championships' 
where division_flag='S'
order by year,tournament_name, ifnull(age_bracket,'Open'), gender_combined_flg;



select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11 
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='S';

select ifnull(age_bracket,'Open') from irf_main 
where year='2015' and tournament_name='Pan American Championships' and division_flag='S';

select isnull(null,'blah') from dual;

select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
         Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
         Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11 

         from irf_main where year='2015' and tournament_name='Pan American Championships'  and division_flag='S';
         
         
         

select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, 
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, 
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg 
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='S' 
order by ifnull(age_bracket,'Open'), gender_combined_flg;         

select age_bracket, 
First_Place_First_Name, first_place_last_name, first_place_country_1, 
First_Place_First_Name_Doubles, First_Place_Last_Name_Doubles, first_place_country_2,
Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1,
Second_Place_First_Name_Doubles, Second_Place_Last_Name_Doubles, second_place_country2,
Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
third_place_first_name_1_doubles, Third_Place_Last_Name_1_Doubles, third_place_country_12,
Third_Place_First_Name_2, Third_Place_Last_Name_2, Third_Place_Country_21, 
third_place_first_name_2_doubles, Third_Place_Last_Name_2_Doubles, third_place_country_22
from irf_main where year='2015' and tournament_name='Pan American Championships' and division_flag='D' 
order by ifnull(age_bracket,'Open'), gender_combined_flg;        


select * from irf_main where division_flag='D';

select distinct gender_combined_flg from irf_main;


select year, tournament_name, gender_combined_flg, first_place_country_1, Second_Place_Country_1,  Third_Place_Country_11 
from irf_main where team_flag='Team'
order by year desc, tournament_name
;

select distinct third_place_country_11 from irf_main;

select * from irf_main where third_place_country_11='BEL';


select count(*) from irf_main where year='2015' and tournament_name='Pan American Championships';


select tournament_name, count(*) from irf_main group by tournament_name order by 1;


select * from seedings;


select * from irf_main;

select * from irf_main order by year desc, tournament_name desc;


desc results;


delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner;
commit;


select * from players_all;

select * from wins;

select p.player from (
select (concat(first_place_last_name, ', ',first_place_first_name)) as player from irf_main where division_flag='S' 
              union all 
              select (concat(second_place_last_name, ', ',second_place_first_name)) as player from irf_main  where division_flag='S' 
              union all
              select (concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) as player from irf_main  where division_flag='S' 
              union all
              select (concat(third_place_last_name_2, ', ',third_place_first_name_2)) as player from irf_main  where division_flag='S' 
              order by player
) p where p.player is not null group by p.player having count(*) > 5 order by p.player;
	
    
select year, tournament_name, location, age_bracket, First_Place_First_Name, first_place_last_name, first_place_country_1, First_Place_First_Name_Doubles, 
First_Place_Last_Name_Doubles, first_place_country_2, Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1,
 Second_Place_First_Name_Doubles, Second_Place_Last_Name_Doubles, second_place_country2, Third_Place_First_Name_1, 
 Third_Place_Last_Name_1, Third_Place_Country_11, third_place_first_name_1_doubles, Third_Place_Last_Name_1_Doubles, 
 third_place_country_12, Third_Place_First_Name_2, Third_Place_Last_Name_2, Third_Place_Country_21, third_place_first_name_2_doubles, 
 Third_Place_Last_Name_2_Doubles, third_place_country_22, gender_combined_flg 
 from irf_main where ifnull(age_bracket,'Open')='Open' and gender_combined_flg='M' and division_flag='D' order by year desc, tournament_name    ;
 
select * from irf_main where division_flag='D';

select 'Winner',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(first_place_first_name , ' ' , first_place_last_name) = 'Jose Diaz' and division_flag='D'
         union
         select 'Winner',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
		 where concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) = 'Jose Diaz' and division_flag='D'
         union
         select 'Finalist',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(second_place_first_name , ' ' , second_place_last_name) = 'Jose Diaz' and division_flag='D'
         union
         select 'Finalist',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(second_place_first_name_doubles , ' ' , second_place_last_name_doubles) = 'Jose Diaz' and division_flag='D'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = 'Jose Diaz' and division_flag='D'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(Third_Place_First_Name_1_doubles, ' ', Third_Place_Last_Name_1_doubles) = 'Jose Diaz' and division_flag='D'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(third_place_first_name_2, ' ', third_place_last_name_2) = 'Jose Diaz' and division_flag='D'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(third_place_first_name_2_doubles, ' ', third_place_last_name_2_doubles) = 'Jose Diaz' and division_flag='D'
         order by year desc, 1; 
         
select concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) from irf_main
			where tournament_name='World Championships' and year='2014' and division_flag='D' 
            and concat(first_place_first_name , ' ' , first_place_last_name) = 'Paola Longoria';         
            
select 'Winner1',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(first_place_first_name , ' ' , first_place_last_name) = 'Paola Longoria' and division_flag='D' union select 'Winner2',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) = 'Paola Longoria' and division_flag='D' union select 'Finalist1',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(second_place_first_name , ' ' , second_place_last_name) = 'Paola Longoria' and division_flag='D' union select 'Finalist2',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(second_place_first_name_doubles , ' ' , second_place_last_name_doubles) = 'Paola Longoria' and division_flag='D' union select '3rd Place11',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = 'Paola Longoria' and division_flag='D' union select '3rd Place12',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(Third_Place_First_Name_1_doubles, ' ', Third_Place_Last_Name_1_doubles) = 'Paola Longoria' and division_flag='D' union select '3rd Place21',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(third_place_first_name_2, ' ', third_place_last_name_2) = 'Paola Longoria' and division_flag='D' union select '3rd Place22',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main where concat(third_place_first_name_2_doubles, ' ', third_place_last_name_2_doubles) = 'Paola Longoria' and division_flag='D' order by year desc, 1;             

select concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) from irf_main where tournament_name='Pan American Championships' and year='2015' and division_flag='D' and concat(first_place_first_name , ' ' , first_place_last_name) = 'Paola Longoria';

select * from irf_main where division_flag='D';


select distinct(concat(first_place_last_name, ', ',first_place_first_name)) from irf_main 
              union 
              select distinct(concat(first_place_last_name_doubles, ', ',first_place_first_name_doubles)) from irf_main  
              union
              select distinct(concat(second_place_last_name, ', ',second_place_first_name)) from irf_main 
              union
              select distinct(concat(second_place_last_name_doubles, ', ',second_place_first_name_doubles)) from irf_main 
              union 
              select distinct(concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) from irf_main  
              union 
              select distinct(concat(Third_Place_Last_Name_1_doubles, ', ',Third_Place_First_Name_1_doubles)) from irf_main  
              union 
              select distinct(concat(third_place_last_name_2, ', ',third_place_first_name_2)) from irf_main  
              union 
              select distinct(concat(third_place_last_name_2_doubles, ', ',third_place_first_name_2_doubles)) from irf_main 
              order by 1;

select p.player, count(*) from (              
select (concat(first_place_last_name, ', ',first_place_first_name)) as player from irf_main 
              union all
              select (concat(first_place_last_name_doubles, ', ',first_place_first_name_doubles)) as player from irf_main  
              union all
              select (concat(second_place_last_name, ', ',second_place_first_name)) as player from irf_main 
              union all
              select (concat(second_place_last_name_doubles, ', ',second_place_first_name_doubles)) as player from irf_main 
              union all
              select (concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) as player from irf_main  
              union all
              select (concat(Third_Place_Last_Name_1_doubles, ', ',Third_Place_First_Name_1_doubles)) as player from irf_main  
              union all
              select (concat(third_place_last_name_2, ', ',third_place_first_name_2)) as player from irf_main  
              union all
              select (concat(third_place_last_name_2_doubles, ', ',third_place_first_name_2_doubles)) as player from irf_main 
              order by player
              ) p where p.player is not null group by p.player having count(*) > 10 order by p.player;
              
select count(*) from irf_main;

select count(*) from results;              


