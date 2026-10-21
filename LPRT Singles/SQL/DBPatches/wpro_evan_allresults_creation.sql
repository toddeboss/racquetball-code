/*  9/26/09: creating all wpro tables

-- creation sql
create table wpro_results as select * from results where 1=2;
create table wpro_results_staging as select * from results where 1=2;
create table wpro_tourneys as select * from tourneys where 1=2;
create table wpro_wins as select * from wins where 1=2;

-- holding table for evan's xls
create table wpro_allevents
(season varchar(10),
tourney_order integer,
event varchar(255),
winner varchar(100),
runnerup varchar(100),
semi1 varchar(100),
semi2 varchar(100),
qf1 varchar(100),
qf2 varchar(100),
qf3 varchar(100),
qf4 varchar(100));

create table wpro_allevents (see table ddl)


load data local infile 'c:/temp/wpro_event_results_evan.csv' into table wpro_allevents
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from wpro_allevents;
delete from wpro_allevents where season='Season';

create table wpro_results_incoming as select * from results where 1=2;

truncate table wpro_results_incoming;

desc wpro_results_incoming;

select count(*) from wpro_results_incoming;

select * from wpro_results_incoming order by season,event,round desc;

insert into wpro_results_incoming (winner,loser,round,event,source,season)
select winner,runnerup,2,event,'Evan from racquetballblogspot',season from wpro_allevents;

insert into wpro_results_incoming (winner,loser,round,event,source,season)
select winner,semi1,4,event,'Evan from racquetballblogspot',season from wpro_allevents;
insert into wpro_results_incoming (winner,loser,round,event,source,season)
select runnerup,semi2,4,event,'Evan from racquetballblogspot',season from wpro_allevents;

insert into wpro_results_incoming (winner,loser,round,event,source,season)
select winner,qf1,8,event,'Evan from racquetballblogspot',season from wpro_allevents;
insert into wpro_results_incoming (winner,loser,round,event,source,season)
select runnerup,qf2,8,event,'Evan from racquetballblogspot',season from wpro_allevents;
insert into wpro_results_incoming (winner,loser,round,event,source,season)
select semi1,qf3,8,event,'Evan from racquetballblogspot',season from wpro_allevents;
insert into wpro_results_incoming (winner,loser,round,event,source,season)
select semi2,qf4,8,event,'Evan from racquetballblogspot',season from wpro_allevents;

select * from wpro_results_incoming where season='1990-91' order by event,round desc;

select distinct(season) from wpro_results_incoming;

update wpro_results_incoming set city=event;
update wpro_results_incoming set city='Memphis, TN' where city='US Open';

select distinct(city) from wpro_results_incoming order by 1;

update wpro_results_incoming set winner='?' where winner='';
update wpro_results_incoming set loser='?' where loser='';

-- don't want to overwrite the last event I input for last season
delete from wpro_results_incoming where event='Concord, CA' and season='2008-09';

create table wpro_results_preall as select * from wpro_results;


insert into wpro_results select * from wpro_results_incoming;
commit;

------------

-- Now, the name cleanup; the xls has embedded ^M and names in the wrong format.

create table wpro_results_prename_cleanup as select * from wpro_results;

update wpro_results set winner='Cheryl Gudinas Holmes' where winner like 'C Gudinas Holmes%';
update wpro_results set loser='Cheryl Gudinas Holmes' where loser like 'C Gudinas Holmes%';

update wpro_results set winner='Fisher, Adrienne' where winner like 'Adrienne Fisher%';
update wpro_results set loser='Fisher, Adrienne' where loser like 'Adrienne Fisher%';

update wpro_results set winner='Foster, Amy' where winner like 'Amy Foster%';
update wpro_results set loser='Foster, Amy' where loser like 'Amy Foster%';

update wpro_results set winner='Kilbane, Amy' where winner like 'Amy Kilbane%';
update wpro_results set loser='Kilbane, Amy' where loser like 'Amy Kilbane%';

update wpro_results set winner='Grisar, Angela' where winner like 'Angela Grisar%';
update wpro_results set loser='Grisar, Angela' where loser like 'Angela Grisar%';

update wpro_results set winner='Marcas, B.' where winner like 'B. Marcas%';
update wpro_results set loser='Marcas, B.' where loser like 'B. Marcas%';

update wpro_results set winner='Kyzer, Brenda' where winner like 'Brenda Kyzer%';
update wpro_results set loser='Kyzer, Brenda' where loser like 'Brenda Kyzer%';

update wpro_results set winner='Crawford, Brooke' where winner like 'Brooke Crawford%';
update wpro_results set loser='Crawford, Brooke' where loser like 'Brooke Crawford%';

update wpro_results set winner='McKinney, Caryn' where winner like 'Caryn McKinney%';
update wpro_results set loser='McKinney, Caryn' where loser like 'Caryn McKinney%';

update wpro_results set winner='Holmes, Cheryl Gudinas' where winner like 'Cheryl Gudinas%';
update wpro_results set loser='Holmes, Cheryl Gudinas' where loser like 'Cheryl Gudinas%';

update wpro_results set winner='Holmes, Cheryl Gudinas' where winner like 'Cheryl Gudinas Holmes%';
update wpro_results set loser='Holmes, Cheryl Gudinas' where loser like 'Cheryl Gudinas Holmes%';

update wpro_results set winner='Gudinas Holmes, Cheryl' where winner like 'Holmes, Cheryl Gudinas%';
update wpro_results set loser='Gudinas Holmes, Cheryl' where loser like 'Holmes, Cheryl Gudinas%';

update wpro_results set winner='Evon, Chris' where winner like 'Chris Evon%';
update wpro_results set loser='Evon, Chris' where loser like 'Chris Evon%';

update wpro_results set winner='Van Hees, Christie' where winner like 'Christie Van Hees%';
update wpro_results set loser='Van Hees, Christie' where loser like 'Christie Van Hees%';

update wpro_results set winner='Doyle, Cindy' where winner like 'Cindy Doyle%';
update wpro_results set loser='Doyle, Cindy' where loser like 'Cindy Doyle%';

update wpro_results set winner='Garcia, Claudine' where winner like 'Claudine Garcia%';
update wpro_results set loser='Garcia, Claudine' where loser like 'Claudine Garcia%';

update wpro_results set winner='Mock, Denise' where winner like 'Denise Mock%';
update wpro_results set loser='Mock, Denise' where loser like 'Denise Mock%';

update wpro_results set winner='Bullard, Diane' where winner like 'Diane Bullard%';
update wpro_results set loser='Bullard, Diane' where loser like 'Diane Bullard%';

update wpro_results set winner='Moore, Diane' where winner like 'Diane Moore%';
update wpro_results set loser='Moore, Diane' where loser like 'Diane Moore%';

update wpro_results set winner='Moreland, Dina' where winner like 'Dina Moreland%';
update wpro_results set loser='Moreland, Dina' where loser like 'Dina Moreland%';

update wpro_results set winner='Fowler, Doreen' where winner like 'Doreen Fowler%';
update wpro_results set loser='Fowler, Doreen' where loser like 'Doreen Fowler%';

update wpro_results set winner='Kelly, Dottie' where winner like 'Dottie Kelly%';
update wpro_results set loser='Kelly, Dottie' where loser like 'Dottie Kelly%';

update wpro_results set winner='Albrecht, Elaine' where winner like 'Elaine Albrecht%';
update wpro_results set loser='Albrecht, Elaine' where loser like 'Elaine Albrecht%';

update wpro_results set winner='Crawford, Ellen' where winner like 'Ellen Crawford%';
update wpro_results set loser='Crawford, Ellen' where loser like 'Ellen Crawford%';

update wpro_results set winner='McKay, Heather' where winner like 'Heather McKay%';
update wpro_results set loser='McKay, Heather' where loser like 'Heather McKay%';

update wpro_results set winner='Gibson, Jackie' where winner like 'Jackie Gibson%';
update wpro_results set loser='Gibson, Jackie' where loser like 'Jackie Gibson%';

update wpro_results set winner='Gibson, Jackie' where winner like 'Jackie Gibson%';
update wpro_results set loser='Gibson, Jackie' where loser like 'Jackie Gibson%';

update wpro_results set winner='Rice, Jackie' where winner like 'Jackie Rice%';
update wpro_results set loser='Rice, Jackie' where loser like 'Jackie Rice%';

update wpro_results set winner='Campbell, Jan' where winner like 'Jan Campbell%';
update wpro_results set loser='Campbell, Jan' where loser like 'Jan Campbell%';

update wpro_results set winner='Marriott, Janell' where winner like 'Janell Marriott%';
update wpro_results set loser='Marriott, Janell' where loser like 'Janell Marriott%';

update wpro_results set winner='Wheeler, Janell' where winner like 'Janell Wheeler%';
update wpro_results set loser='Wheeler, Janell' where loser like 'Janell Wheeler%';

update wpro_results set winner='Myers, Janet' where winner like 'Janet Myers%';
update wpro_results set loser='Myers, Janet' where loser like 'Janet Myers%';

update wpro_results set winner='Sauser, Jean' where winner like 'Jean Sauser%';
update wpro_results set loser='Sauser, Jean' where loser like 'Jean Sauser%';

update wpro_results set winner='Saunders, Jen' where winner like 'Jen Saunders%';
update wpro_results set loser='Saunders, Jen' where loser like 'Jen Saunders%';
update wpro_results set winner='Saunders, Jennifer' where winner like 'Saunders, Jen';
update wpro_results set loser='Saunders, Jennifer' where loser like 'Saunders, Jen';

update wpro_results set winner='Harding, Jennifer' where winner like 'Jennifer Harding%';
update wpro_results set loser='Harding, Jennifer' where loser like 'Jennifer Harding%';

update wpro_results set winner='Shattuck, Jo' where winner like 'Jo Shattuck%';
update wpro_results set loser='Shattuck, Jo' where loser like 'Jo Shattuck%';

-- Killed Josee's actual name: Josée Grand'Maître

update wpro_results set winner='Grand Maitre, Josee' where winner like '%Grand%';
update wpro_results set loser='Grand Maitre, Josee' where loser like '%Grand%';

update wpro_results set winner='Morton, Karen' where winner like 'Karen Morton%';
update wpro_results set loser='Morton, Karen' where loser like 'Karen Morton%';

update wpro_results set winner='Walton, Karin' where winner like 'Karin Walton%';
update wpro_results set loser='Walton, Karin' where loser like 'Karin Walton%';

update wpro_results set winner='Williams, Kathy' where winner like 'Kathy Willams%';
update wpro_results set loser='Williams, Kathy' where loser like 'Kathy Willams%';
update wpro_results set winner='Williams, Kathy' where winner like 'Kathy Williams%';
update wpro_results set loser='Williams, Kathy' where loser like 'Kathy Williams%';

update wpro_results set winner='Kuhfeld, Kaye' where winner like 'Kaye Kuhfeld%';
update wpro_results set loser='Kuhfeld, Kaye' where loser like 'Kaye Kuhfeld%';

update wpro_results set winner='Wachtel (Stoffregen), Kerri' where winner like 'Kerri Wachtel%';
update wpro_results set loser='Wachtel (Stoffregen), Kerri' where loser like 'Kerri Wachtel%';
update wpro_results set winner='Wachtel (Stoffregen), Kerri' where winner like 'Wachtel, Kerry%';
update wpro_results set loser='Wachtel (Stoffregen), Kerri' where loser like 'Wachtel, Kerry%';
update wpro_results set winner='Wachtel (Stoffregen), Kerri' where winner like 'Kerri Stoffregen%';
update wpro_results set loser='Wachtel (Stoffregen), Kerri' where loser like 'Kerri Stoffregen%';
update wpro_results set winner='Wachtel (Stoffregen), Kerri' where winner like 'Wachtel, Kerri';
update wpro_results set loser='Wachtel (Stoffregen), Kerri' where loser like 'Wachtel, Kerri';

update wpro_results set winner='Hallander, Kersten' where winner like 'Kersten Hallander%';
update wpro_results set loser='Hallander, Kersten' where loser like 'Kersten Hallander%';

update wpro_results set winner='Machiran, Kim' where winner like 'Kim Machiran%';
update wpro_results set loser='Machiran, Kim' where loser like 'Kim Machiran%';

update wpro_results set winner='Russell, Kim' where winner like 'Kim Russell%';
update wpro_results set loser='Russell, Kim' where loser like 'Kim Russell%';

update wpro_results set winner='Wilkerson, Kim' where winner like 'Kim Wilkerson%';
update wpro_results set loser='Wilkerson, Kim' where loser like 'Kim Wilkerson%';

update wpro_results set winner='Bellows (Walsh), Kristen' where winner like 'Kristen Bellows%';
update wpro_results set loser='Bellows (Walsh), Kristen' where loser like 'Kristen Bellows%';
update wpro_results set winner='Bellows (Walsh), Kristen' where winner like 'Kristen Walsh%';
update wpro_results set loser='Bellows (Walsh), Kristen' where loser like 'Kristen Walsh%';

update wpro_results set winner='Fenton, Laura' where winner like 'Laura Fenton%';
update wpro_results set loser='Fenton, Laura' where loser like 'Laura Fenton%';

update wpro_results set winner='Martino, Laura' where winner like 'Laura Martino%';
update wpro_results set loser='Martino, Laura' where loser like 'Laura Martino%';

update wpro_results set winner='Moore, Linda' where winner like 'Linda Moore%';
update wpro_results set loser='Moore, Linda' where loser like 'Linda Moore%';

update wpro_results set winner='Kerr, Lisa' where winner like 'Lisa Kerr%';
update wpro_results set loser='Kerr, Lisa' where loser like 'Lisa Kerr%';

update wpro_results set winner='Powell, Lori-Jane' where winner like 'Lori-Jane Powell%';
update wpro_results set loser='Powell, Lori-Jane' where loser like 'Lori-Jane Powell%';

update wpro_results set winner='Galloway, Lorraine' where winner like 'Lorraine Galloway%';
update wpro_results set loser='Galloway, Lorraine' where loser like 'Lorraine Galloway%';

update wpro_results set winner='Hammock, Lydia' where winner like 'Lydia Hammock%';
update wpro_results set loser='Hammock, Lydia' where loser like 'Lydia Hammock%';

update wpro_results set winner='Adams, Lynn' where winner like 'Lynn Adams%';
update wpro_results set loser='Adams, Lynn' where loser like 'Lynn Adams%';

update wpro_results set winner='Coburn, Lynne' where winner like 'Lynne Coburn%';
update wpro_results set loser='Coburn, Lynne' where loser like 'Lynne Coburn%';

update wpro_results set winner='Bailey, Malia' where winner like 'Malia Bailey%';
update wpro_results set loser='Bailey, Malia' where loser like 'Malia Bailey%';

update wpro_results set winner='Drexler, Marci' where winner like 'Marci Drexler%';
update wpro_results set loser='Drexler, Marci' where loser like 'Marci Drexler%';
update wpro_results set winner='Drexler, Marci' where winner like 'Marcy Drexler%';
update wpro_results set loser='Drexler, Marci' where loser like 'Marcy Drexler%';

update wpro_results set winner='Greer, Marci' where winner like 'Marci Greer%';
update wpro_results set loser='Greer, Marci' where loser like 'Marci Greer%';

update wpro_results set winner='Lynch, Marcy' where winner like 'Marcy Lynch%';
update wpro_results set loser='Lynch, Marcy' where loser like 'Marcy Lynch%';

update wpro_results set winner='McDonald, Martha' where winner like 'Martha McDonald%';
update wpro_results set loser='McDonald, Martha' where loser like 'Martha McDonald%';

update wpro_results set winner='Gould (Gilman), Michelle' where winner like 'Michelle Gilman%';
update wpro_results set loser='Gould (Gilman), Michelle' where loser like 'Michelle Gilman%';
update wpro_results set winner='Gould (Gilman), Michelle' where winner like 'Michelle Gould%';
update wpro_results set loser='Gould (Gilman), Michelle' where loser like 'Michelle Gould%';

update wpro_results set winner='Lucas (Wiragh), Michelle' where winner like 'Michelle Lucas%';
update wpro_results set loser='Lucas (Wiragh), Michelle' where loser like 'Michelle Lucas%';
update wpro_results set winner='Lucas (Wiragh), Michelle' where winner like 'Michelle Wiragh%';
update wpro_results set loser='Lucas (Wiragh), Michelle' where loser like 'Michelle Wiragh%';

-- took out O'Brien during update
update wpro_results set winner='OBrien, Molly' where winner like 'Molly%';
update wpro_results set loser='OBrien, Molly' where loser like 'Molly%';

update wpro_results set winner='Schultz, Nicole' where winner like 'Nicole Schultz%';
update wpro_results set loser='Schultz, Nicole' where loser like 'Nicole Schultz%';

update wpro_results set winner='Longoria, Paola' where winner like 'Paola Longoria%';
update wpro_results set loser='Longoria, Paola' where loser like 'Paola Longoria%';
update wpro_results set winner='Longoria, Paola' where winner like 'Paolo Longoria%';
update wpro_results set loser='Longoria, Paola' where loser like 'Paolo Longoria%';


update wpro_results set winner='Steding, Peggy' where winner like 'Peggy Steding%';
update wpro_results set loser='Steding, Peggy' where loser like 'Peggy Steding%';

update wpro_results set winner='Gellman, Rachel' where winner like 'Rachel Gellman%';
update wpro_results set loser='Gellman, Rachel' where loser like 'Rachel Gellman%';

update wpro_results set winner='Freidman, Randy' where winner like 'Randi Friedman%';
update wpro_results set loser='Freidman, Randy' where loser like 'Randi Friedman%';
update wpro_results set winner='Freidman, Randy' where winner like 'Randy Friedman%';
update wpro_results set loser='Freidman, Randy' where loser like 'Randy Friedman%';

update wpro_results set winner='Rajsich, Rhonda' where winner like 'Rhonda Rajsich%';
update wpro_results set loser='Rajsich, Rhonda' where loser like 'Rhonda Rajsich%';

update wpro_results set winner='Hoff, Rita' where winner like 'Rita Hoff%';
update wpro_results set loser='Hoff, Rita' where loser like 'Rita Hoff%';

update wpro_results set winner='Levine, Robin' where winner like 'Robin Levine%';
update wpro_results set loser='Levine, Robin' where loser like 'Robin Levine%';

update wpro_results set winner='Torres, Rosy' where winner like 'Rosy Torres%';
update wpro_results set loser='Torres, Rosy' where loser like 'Rosy Torres%';


update wpro_results set winner='Salas, Samantha' where winner like 'Samantha Salas%';
update wpro_results set loser='Salas, Samantha' where loser like 'Samantha Salas%';
update wpro_results set winner='Salas, Samantha' where winner like 'Samatha Salas%';
update wpro_results set loser='Salas, Samantha' where loser like 'Samatha Salas%';

update wpro_results set winner='Robson, Sandy' where winner like 'Sandy Robson%';
update wpro_results set loser='Robson, Sandy' where loser like 'Sandy Robson%';

update wpro_results set winner='Borland, Sara' where winner like 'Sara Borland%';
update wpro_results set loser='Borland, Sara' where loser like 'Sara Borland%';

update wpro_results set winner='Green, Sarah' where winner like 'Sarah Green%';
update wpro_results set loser='Green, Sarah' where loser like 'Sarah Green%';

update wpro_results set winner='Wright, Shannon' where winner like 'Shannon Wright%';
update wpro_results set loser='Wright, Shannon' where loser like 'Shannon Wright%';

update wpro_results set winner='Carow, Sue' where winner like 'Sue Carow%';
update wpro_results set loser='Carow, Sue' where loser like 'Sue Carow%';

update wpro_results set winner='Acosta, Susy' where winner like 'Susy Acosta%';
update wpro_results set loser='Acosta, Susy' where loser like 'Susy Acosta%';

update wpro_results set winner='Brown, Tammy' where winner like 'Tammy Brown%';
update wpro_results set loser='Brown, Tammy' where loser like 'Tammy Brown%';

update wpro_results set winner='Gilreath, Terri' where winner like 'Terri Gilreath%';
update wpro_results set loser='Gilreath, Terri' where loser like 'Terri Gilreath%';

update wpro_results set winner='Bevelock, Toni' where winner like 'Toni Bevelock%';
update wpro_results set loser='Bevelock, Toni' where loser like 'Toni Bevelock%';

update wpro_results set winner='Sotomayor, Veronica' where winner like 'Veronica Sotomayor%';
update wpro_results set loser='Sotomayor, Veronica' where loser like 'Veronica Sotomayor%';

update wpro_results set winner='Guillemette, Vernoique' where winner like 'Veronique Guillemette%';
update wpro_results set loser='Guillemette, Vernoique' where loser like 'Veronique Guillemette%';

update wpro_results set winner='Panzeri, Vicki' where winner like 'Vicki Panzeri%';
update wpro_results set loser='Panzeri, Vicki' where loser like 'Vicki Panzeri%';

update wpro_results set winner='Gomez, Vivian' where winner like 'Vivian Gomez%';
update wpro_results set loser='Gomez, Vivian' where loser like 'Vivian Gomez%';


-- final test
select distinct(winner) from wpro_results 
union
select distinct(loser) from wpro_results
order by 1;