This is Steps to re-load IRT rball data, if it needs to be done.

/* PART I: load up 2000-present results */

delete from results;

alter table results modify column round varchar(3);


/* Load command for data */

load data local infile 'c:/boss/rball/irt/Pro_Results_new.csv' into table results
--load data local infile 'Pro_Results_new.csv' into table results
fields terminated by ',' enclosed by '"' lines terminated by '\n';


/* maintenance that must be done post load*/
delete from results where winner='Winner';
delete from results where winner='';

update results set round='8' where round='Q';
update results set round='4' where round='S';
update results set round='2' where round='F';

update results set season='2000-1' where season like '2000%';
update results set season='2001-2' where season like '2001%';
update results set season='2002-3' where season like '2002%';
update results set season='2003-4' where season like '2003%';

alter table results modify column round integer;

commit;




/**********************************************************************************************/


/* PART II: loading up the 1974-1999 results */


desc results_old;
alter table results_old modify round varchar(5);
delete from results_old;

load data local infile 'c:/boss/rball/irt/MPRO_fixed_tab_modern.csv' into table results_old
fields terminated by ',' enclosed by '"' lines terminated by '\n';

delete from results_old where winner='Winner';

--select * from results_old;

/* Fixing Cities from old REsults*/

update results_old set city='Davison' where city='Davison, MI';
update results_old set city='Stockton' where city='Stockton, California';
update results_old set city='Bangor' where city='Bangor, Maine';
update results_old set city='Pleasanton' where city='Pleasanton, California';
update results_old set city='Tempe' where city='Tempe, Arizona';
update results_old set city='Tulsa' where city='Tulsa, Oklahoma';
update results_old set city='Beaverton' where city='Beaverton, Oregon';
update results_old set city='Beaverton' where city='Beaverton,or';
update results_old set city='Concord' where city='Concord, California';
update results_old set city='Baltimore' where city='Baltimore, Maryland';
update results_old set city='Anaheim' where city='Anaheim, California';
update results_old set city='Cheyenne' where city='Cheyenne, Wyoming';
update results_old set city='Arlington' where city='Arlington, Virginia';
update results_old set city='Arlington' where city='Arlington,va';
update results_old set city='Omaha' where city='Omaha, Nebraska';
update results_old set city='Dallas' where city='Dallas, Texas';
update results_old set city='Dallas' where city='Dallas,tx';
update results_old set city='Sacramento' where city='Sacramento, California';
update results_old set city='Boulder' where city='Boulder, Colorado';
update results_old set city='Phoenix' where city='Phoenix, Arizona';
update results_old set city='Burnsville' where city='Burnsville,mn';
update results_old set city='New York' where city='New York,ny';
update results_old set city='Vancouver' where city='Vancouver, Bc';
update results_old set city='Vancouver' where city='Vancouver,bc';
update results_old set city='Grand Rapids' where city='Grand Rapids,mi';
update results_old set city='Salem' where city='Salem, OR';

/* Fixing tourney events, dates where missing */


update results_old set event='Houston 75', date='3/15/75' where city='Houston' and season='1974-5';
update results_old set date='4/1/75' where city='Las Vegas' and season='1974-5';
update results_old set date='5/1/75' where city='St. Louis' and season='1974-5';


update results_old set event='Denver 75', date='9/1/75' where city='Denver' and season='1975-6';
update results_old set event='Burlington 75', date='10/1/75' where city='Burlington' and season='1975-6';
update results_old set date='12/1/75' where city='Memphis' and season='1975-6';
update results_old set event='Tucson 75', date='12/15/75' where city='Tucson' and season='1975-6';
update results_old set event='Aurora 76', date='1/1/76', city='Aurora' where city='Aurora, Il' and season='1975-6';
update results_old set event='Milwaukee 76', date='2/1/76' where city='Milwaukee' and season='1975-6';
update results_old set event='San Antonio 76', date='2/15/76' where city='San Antonio' and season='1975-6';
update results_old set event='Buffalo 76', date='3/28/76' where city='Buffalo' and season='1975-6';
update results_old set event='Peoria 76', date='5/1/76' where city='Peoria' and season='1975-6';
update results_old set date='6/1/76' where city='San Diego' and season='1975-6';

update results_old set event='Sacramento 76', date='9/1/76' where city='Sacramento' and season='1976-7';
update results_old set event='Canadian Nationals', date='9/15/76' where city='Edmonton' and season='1976-7';
update results_old set event='Ft. Lauderdale 76', date='10/1/76' where city='Ft Lauderdale' and season='1976-7';
update results_old set event='Burlington 76', date='10/15/76' where city='Burlington' and season='1976-7';
update results_old set event='Las Vegas 77', date='1/1/77' where city='Las Vegas' and season='1976-7';
update results_old set event='Houston 77', date='2/1/77' where city='Houston' and season='1976-7';
update results_old set event='Denver 77', date='3/1/77' where city='Denver' and season='1976-7';
update results_old set event='Chattanooga 77', date='4/1/77' where city='Chattanooga' and season='1976-7';
update results_old set event='Southfield 77', date='4/15/77' where city='Southfield' and season='1976-7';
update results_old set event='Newport Beach 77', date='5/15/77' where city='Newport Beach' and season='1976-7';
update results_old set event='Lombard 77', date='5/1/77' where city='Lombard' and season='1976-7';
update results_old set date='6/1/77' where city='San Diego' and season='1976-7';

update results_old set event='Milwaukee 77', date='9/1/77' where city='Milwaukee' and season='1977-8';
update results_old set event='Westbury 77', date='10/1/77' where city='Westbury Ny' and season='1977-8';
update results_old set event='Westminster 77', date='11/1/77' where city='Westminster' and season='1977-8';
update results_old set event='Marietta 77', date='12/1/77' where city='Marietta Ga' and season='1977-8';
update results_old set event='Gresham 78', date='1/1/78', city='Gresham' where city='Gresham Or' and season='1977-8';
update results_old set event='Tempe 78', date='2/1/78' where city='Tempe' and season='1977-8';
update results_old set event='San Antonio 78', date='3/1/78' where city='San Antonio' and season='1977-8';
update results set event='Aurora 78', date='4/1/78', tmp_date='1978-04-01' where city='Aurora' and season='1977-8';
update results_old set date='6/1/78' where city='Belleville' and season='1977-8';

commit;

update results_old set event='St. Louis 78', date='10/1/78' where city='St Louis' and season='1978-9';
update results_old set event='Leach Motor City Classic', date='10/15/78' where city='Southfield' and season='1978-9';
update results_old set event='Seamco Racquetball Classic', date='11/9/78' where city='New York' and season='1978-9';
update results_old set event='Kunnan/Kennex Tournament of Champions', date='1/1/79' where city='Miami' and season='1978-9';
update results_old set event='Coors Racquetball Classic', date='2/1/79', city='Aurora' where city='Aurora Co' and season='1978-9';
update results_old set event='Catalina Classic', date='3/1/79' where city='Westminster Ca' and season='1978-9';
update results_old set event='1st Robert W. Kendler Classic', date='4/29/79' where city='New Haven' and season='1978-9';
update results_old set date='5/1/79' where city='Tempe' and season='1978-9';


update results_old set event='2nd Robert W. Kendler Classic', date='9/30/79' where city='Lombard' and season='1979-80';
update results_old set event='Jack in the Box Classic', date='11/8/79' where city='Tempe' and season='1979-80';
update results_old set event='Tanner/Coca Cola Classic', date='12/16/79' where city='Memphis' and season='1979-80';
update results_old set event='Kunnan/Kennex Tournament of Champions', date='2/2/80' where city='Coral Gables' and season='1979-80';
update results_old set event='Coors Classic', date='2/24/80' where city='Denver' and season='1979-80';
update results_old set event='Catalina Classic West', date='3/23/80' where city='San Francisco' and season='1979-80';
update results_old set event='Kings Bank Newport Classic', date='3/26/80' where city='Westminster' and season='1979-80';
update results_old set event='Seamco Classic', date='4/20/80' where city='Beverly' and season='1979-80';
update results_old set event='Catalina Classic East', date='5/4/80' where city='Atlanta' and season='1979-80';
update results_old set event='Leach National Pro-Am Championship', date='6/7/80' where city='Las Vegas' and season='1979-80';

update results_old set event='CBC International Classic', date='6/29/80' where city='Winnipeg' and season='1980-1';
update results_old set event='Coors Grand Prix I', date='10/12/80' where city='Omaha' and season='1980-1';
update results_old set event='Kings/Bank of Newport Pro-Am Classic', date='8/30/80' where city='Westminster' and season='1980-1';
update results_old set event='3rd Robert W. Kendler Classic', date='11/23/80' where city='Chicago' and season='1980-1';
update results_old set event='Tanner/Coca Cola RB Classic', date='12/14/80' where city='Memphis' and season='1980-1';
update results_old set event='Catalina Racquetball Classic', date='1/18/81' where city='Honolulu' and season='1980-1';
update results_old set event='Coors Grand Prix II', date='2/22/81' where city='Houston' and season='1980-1';
update results_old set event='Kunnan/Kennex Tournament of Champions', date='3/22/81' where city='Coral Gables' and season='1980-1';
update results_old set event='Seamco Classic', date='4/12/81' where city='Beverly' and season='1980-1';
update results_old set event='Coors Grand Prix Final', date='5/10/81' where city='St Louis' and season='1980-1';
update results_old set event='El Paso 81', date='5/15/81' where city='El Paso' and season='1980-1';
update results_old set date='6/13/81' where city='Tempe' and season='1980-1';

update results_old set event='Catalina #1', date='10/1/81' where city='Westminster' and season='1981-2';
update results_old set event='NRC Winnipeg 81', date='10/10/81' where city='Winnipeg' and season='1981-2';
update results_old set event='Catalina #2', date='10/20/81' where city='Burnsville' and season='1981-2';
update results_old set event='Catalina #3', date='11/1/81' where city='New Haven' and season='1981-2';
update results_old set event='Catalina #4', date='1/17/82' where city='Honolulu' and season='1981-2';
update results_old set event='Catalina #5', date='2/21/82' where city='Beaverton' and season='1981-2';
update results_old set event='Catalina #6', date='3/15/82' where city='Coral Gables' and season='1981-2';
update results_old set date='4/1/82' where city='Austin' and season='1981-2';
update results_old set event='Catalina Nationals', date='5/23/82' where city='Ft. Worth' and season='1981-2';
update results_old set event='Ektelon/Pony Nationals', date='5/9/82' where city='Anaheim' and season='1981-2';
update results_old set date='6/26/82' where city='Chicago' and season='1981-2';

update results_old set event='Catalina #1', date='10/1/82' where city='Westminster' and season='1982-3';
update results_old set event='Catalina #2', date='10/15/82' where city='Burnsville' and season='1982-3';
update results_old set event='Catalina #3', date='11/1/82' where city='New Haven' and season='1982-3';
update results_old set event='Catalina #4', date='1/1/83' where city='Honolulu' and season='1982-3';
update results_old set event='Catalina #5', date='2/1/83' where city='Beaverton' and season='1982-3';
update results_old set event='Catalina #6', date='3/1/83' where city='Austin' and season='1982-3';
update results_old set event='Catalina #7', date='4/1/83' where city='Toronto' and season='1982-3';
update results_old set date='5/1/83' where city='Anaheim' and season='1982-3';
update results_old set date='6/1/83' where city='Chicago' and season='1982-3';
update results_old set date='6/15/83' where city='Atlanta' and season='1982-3';


update results_old set event='Natural Light Open', date='9/1/83' , city='Davison' where city='Davison, MI' and season='1983-4';
update results_old set date='9/15/83' , city='Stockton' where city='Stockton, California' and season='1983-4';
update results_old set event='Bangor 83', date='11/15/83'  where city='Bangor' and season='1983-4';
update results_old set event='8th Schoebers Christmas Classic', date='12/11/83'  where city='Pleasanton' and season='1983-4';
update results_old set event='Beaverton 84', date='2/1/84'  where city='Beaverton' and season='1983-4';
update results_old set event='Austin 84', date='5/15/84' , city='Austin' where city='Austin, Texas' and season='1983-4';
update results_old set date='5/1/84' where city='Anaheim' and season='1983-4';
update results_old set date='6/1/84' where city='Atlanta' and season='1983-4';


update results_old set event='7th Lewerenz Sports Clinic Open', date='9/1/84' where city='Davison' and season='1984-5';
update results_old set event='2nd Stockton Pro-Am', date='9/15/84' where city='Stockton' and season='1984-5';
update results_old set event='Bangor 84', date='11/1/84' where city='Bangor' and season='1984-5';
update results_old set event='9th Schoebers Christmas Classic', date='12/9/84'  where city='Pleasanton' and season='1984-5';
update results_old set event='Arizona Pro-Am', date='1/27/85'  where city='Tempe' and season='1984-5';
update results_old set event='Tulsa Open', date='2/10/85'  where city='Tulsa' and season='1984-5';
update results_old set event='Concord 85', date='3/17/85'  where city='Concord' and season='1984-5';
update results_old set event='Labatts Pro-Am', date='3/1/85'  where city='Beaverton' and season='1984-5';
update results_old set event='Toyota/Lite Classic', date='4/1/85'  where city='Baltimore' and season='1984-5';
update results_old set date='5/1/85'  where city='Anaheim' and season='1984-5';
update results_old set event='Cracker Shooter Open', date='5/15/85'  where city='Cheyenne' and season='1984-5';
update results_old set date='6/1/85'  where city='Boston' and season='1984-5';

update results_old set event='3rd Stockton Pro-Am', date='9/1/85' where city='Stockton' and season='1985-6';
update results_old set date='9/15/85' where city='Davison' and season='1985-6';
update results_old set date='10/1/85' where city='Arlington' and season='1985-6';
update results_old set event='Omaha 85', date='10/15/85' where city='Omaha' and season='1985-6';
update results_old set event='Dallas 85', date='11/1/85' where city='Dallas' and season='1985-6';
update results_old set event='Sacramento 85', date='12/1/85' where city='Sacramento' and season='1985-6';
update results_old set event='Arizona Pro-Am', date='1/1/86' where city='Tempe' and season='1985-6';
update results_old set event='Tulsa Open', date='2/1/86' where city='Tulsa' and season='1985-6';
update results_old set event='Beaverton 86', date='3/1/86' where city='Beaverton' and season='1985-6';
update results_old set event='Baltimore 86', date='4/1/86' where city='Baltimore' and season='1985-6';
update results_old set date='5/1/86'  where city='Anaheim' and season='1985-6';
update results_old set event='Boulder 86', date='5/15/86' where city='Boulder' and season='1985-6';
update results_old set date='6/1/86' where city='Arlington, TX' and season='1985-6';

update results_old set event='4th Stockton Pro-Am', date='8/1/86' where city='Stockton' and season='1986-7';
update results_old set date='9/1/86' where city='Davison' and season='1986-7';
update results_old set event='Vancouver 86', date='10/1/86' where city='Vancouver, Bc' and season='1986-7';
update results_old set date='10/15/86' where city='Arlington' and season='1986-7';
update results_old set event='Dallas 86', date='11/1/86' where city='Dallas' and season='1986-7';
update results_old set event='Boulder 87', date='1/1/87' where city='Boulder' and season='1986-7';
update results_old set event='Tulsa Open', date='2/1/86' where city='Tulsa' and season='1986-7';
update results_old set event='Beaverton 87', date='2/15/87' where city='Beaverton' and season='1986-7';
update results_old set event='Phoenix 87', date='3/1/87' where city='Phoenix' and season='1986-7';
update results_old set event='Burnsville 87', date='6/1/87' where city='Burnsville' and season='1986-7';

update results_old set date='9/1/87' where city='Davison' and season='1987-8';
update results_old set date='10/1/87' where city='Arlington' and season='1987-8';
update results_old set date='12/1/87' where city='New York' and season='1987-8';
update results_old set date='2/1/88' where city='Beaverton' and season='1987-8';
update results_old set date='3/10/88' where city='Vancouver' and season='1987-8';
update results_old set date='3/1/88' where city='Dallas' and season='1987-8';
update results_old set date='3/20/88' where city='Grand Rapids' and season='1987-8';
update results_old set date='5/1/88' where city='Seattle' and season='1987-8';

update results_old set event='7th Stockton Pro-Am', date='9/4/89' where city='Stockton' and season='1989-90';

update results_old set event='8th Stockton Pro-Am', date='9/3/90' where city='Stockton' and season='1990-1';
update results_old set event='Riverside 90', date='12/11/90' where city='Riverside' and season='1990-1';
update results_old set event='Chelseas Pro-Am', date='9/30/90' where city='Salem' and season='1990-1';
update results_old set date='2/1/91' where city='Pittsburgh' and season='1990-1';
update results_old set date='4/1/91' where city='Chicago' and season='1990-1';

update results_old set event='9th Stockton Pro-Am' where city='Stockton' and season='1991-2';
update results_old set event='Las Vegas 92' where city='Las Vegas' and season='1991-2';
update results_old set date='1/1/92' where city='Little Rock' and season='1991-2';


---

/* perform date maintenance */

delete from results_old where winner='Winner';
delete from results_old where winner='';

update results_old set round='8' where round='Q';
update results_old set round='4' where round='S';
update results_old set round='2' where round='F';

alter results_old modify column round integer;


update results_old set season='1973-4' where season like '1973%';
update results_old set season='1974-5' where season like '1974%';
update results_old set season='1975-6' where season like '1975%';
update results_old set season='1976-7' where season like '1976%';
update results_old set season='1977-8' where season like '1977%';
update results_old set season='1978-9' where season like '1978%';
update results_old set season='1979-80' where season like '1979%';
update results_old set season='1980-1' where season like '1980%';
update results_old set season='1981-2' where season like '1981%';
update results_old set season='1982-3' where season like '1982%';
update results_old set season='1983-4' where season like '1983%';
update results_old set season='1984-5' where season like '1984%';
update results_old set season='1985-6' where season like '1985%';
update results_old set season='1986-7' where season like '1986%';
update results_old set season='1987-8' where season like '1987%';
update results_old set season='1988-9' where season like '1988%';
update results_old set season='1989-90' where season like '1989%';
update results_old set season='1990-1' where season like '1990%';
update results_old set season='1991-2' where season like '1991%';
update results_old set season='1992-3' where season like '1992%';
update results_old set season='1993-4' where season like '1993%';
update results_old set season='1994-5' where season like '1994%';
update results_old set season='1995-6' where season like '1995%';
update results_old set season='1996-7' where season like '1996%';
update results_old set season='1997-8' where season like '1997%';
update results_old set season='1998-9' where season like '1998%';
update results_old set season='1999-00' where season like '1999%';
update results_old set season='2000-1' where season like '2000%';
update results_old set season='2001-2' where season like '2001%';
update results_old set season='2002-3' where season like '2002%';
update results_old set season='2003-4' where season like '2003%';
update results_old set season='2004-5' where season like '2004%';



/* Other maintenance noticed later */

select * from results where city='Baltimore' order by date,round

/* missed this final */
insert into results values ('Ray, Mike','Roberts, Andy',2,'(9),9,(2),3,6','IRT','Baltimore','VCI Challenger Cup Series #2','11/22/1992','Racquetball Magazine Jan/Feb 93 v4n1','1992-3','','1992-11-22')

/* Two chicago events 1990-1 */

update results set date='10/21/90', tmp_date='1990-10-21' where city='Chicago' and season='1990-1' and event='Head Halloween Classic'

/* missed this event */
update results set event='Aurora 78', date='4/1/78', tmp_date='1978-04-01' where city='Aurora' and season='1977-8';

/* wrong date */
update results set date='2/1/87', tmp_date='1987-02-01' where city='Tulsa' and season='1986-7';

/* typos in scores entered */

update results set score='8,(9),8,2' where city='Minneapolis' and date='6/27/1993' and loser='Graham, Kevin';
update results set score='7,(9),10,(6),10' where city='Riverside' and date='11/15/1992' and loser='Gonzalez, Ruben';
update results set score='4,(5),3,9' where city='Pittsburgh' and date='2/21/1993' and loser='Swain, Cliff'
update results set score='7,(5),9,10,4' where city='Minneapolis' and date='6/27/1993' and loser='Swain, Cliff'
update results set score='9,(2),(5),10,10' where date='8/29/1993' and winner='Ellis, John' and round=4;
update results set score='7,2,(4),(9),8' where date='8/8/1993' and loser='Ellis, John';
update results set score='9,9,(3),9' where date='3/14/1993' and loser='Guidry, Mike';
update results set score='6,(9),(8),8,5' where date='2/6/1994' and loser='Ellis, John';
update results set score='5,(1),2,(3),2' where date='5/8/1994' and loser='Monchik, Sudsy';
update results set score='5,(2),8,(2),2' where date='11/5/1995' and loser='Ray, MIke';
update results set score='8,(9),1,2' where date='4/4/1993' and loser='Newman, Jack';
update results set score='(9),8,6,7' where date='9/6/1993' and loser='Evans, Jeff';
update results set score='(9),6,(7),10,8' where date='9/10/1994' and loser='Kachtik, Drew';
update results set score='(9),8,5,5' where date='2/19/1995' and loser='Swain, Cliff';
update results set score='1,(5),5,(8),10' where date='3/14/1993' and loser='Jelso, Tony';
update results set score='(8),7,(4),7,8' where date='8/8/1993' and loser='Newman, Jack';
update results set score='5,7,(8),8' where date='1/23/1994' and loser='Doyle, Tim';
update results set score='3,7,(8),(8),0' where date='2/20/1994' and loser='Gonzalez, Ruben';
update results set score='7,(8),(4),6,8' where date='1/22/1995' and loser='Kachtik, Drew';
update results set score='10,(7),5,(5),9' where date='9/6/1993' and loser='Clouse, Woody';
update results set score='7,10,(7),(7),9' where date='1/23/1994' and loser='Kachtik, Drew';
update results set score='(7),2,3,(3),2' where date='1/22/1995' and loser='Swain, Cliff';
update results set score='(7),8,(10),4,8' where date='12/10/1995' and loser='Fowler, Dan';

/* more score fixing */
update results set score='(8),5,(10),10,10' where date='9/15/85' and round=32 and winner='Newman, Jack'
update results set score='(2),10,(10),9,10' where date='4/1/85' and round=16 and winner='Brysman, Corey'
update results set score='(8),(9),4,10,2' where date='4/1/86' and round=2 and winner='Hogan, Marty'

/* error in Louisville 74 events */
update results set date='10/15/74', tmp_date='1974-10-15' where city='Louisville' and season='1974-5';
update results set winner='Strom,R' where winner='0';


/* name cleanup */
update results set winner='Amatulli, John' where winner='Amatuli, John';
update results set loser='Amatulli, John' where loser='Amatuli, John';
update results set winner='Amatulli, John' where winner='Amatulli,J';
update results set loser='Amatulli, John' where loser='Amatulli,J';
update results set winner='Bronfeld, Michael' where winner='Bronfeld, Mike';
update results set loser='Bronfeld, Michael' where loser='Bronfeld, Mike';
update results set winner='Bronfeld, Michael' where winner='Bronfeld,M';
update results set loser='Bronfeld, Michael' where loser='Bronfeld,M';
update results set winner='Bustillos, Luis' where winner='Busillos, Luis';
update results set loser='Bustillos, Luis' where loser='Busillos, Luis';
update results set winner='Campbell, Darin' where winner='Campbell,D';
update results set loser='Campbell, Darin' where loser='Campbell,D';
update results set loser='Cherry, Chad' where loser='Cherry, ?';
update results set winner='Conine, Jeff' where winner='Conine,J';
update results set loser='Conine, Jeff' where loser='Conine,J';
update results set winner='Cullins, Scott' where winner='Cullins,S';
update results set loser='Cullins, Scott' where loser='Cullins,S';
update results set winner='DeJesus, Rob' where winner='De Jesus, Rob';
update results set loser='DeJesus, Rob' where loser='De Jesus, Rob';
update results set winner='DiGiacomo, Ron' where winner='Dijacamo,R';
update results set loser='DiGiacomo, Ron' where loser='Dijacamo,R';
update results set winner='Drake, Charlie' where winner='Drake,C';
update results set loser='Drake, Charlie' where loser='Drake,C';
update results set winner='Eagle, Doug' where winner='Eagle,D';
update results set loser='Eagle, Doug' where loser='Eagle,D';
update results set winner='Embry, Aaron' where winner='Embry,A';
update results set loser='Embry, Aaron' where loser='Embry,A';
update results set winner='Evans, Jeff' where winner='Evans,J';
update results set loser='Evans, Jeff' where loser='Evans,J';
update results set winner='Filippini, Rafael' where winner='Fillipini, Rafael';
update results set loser='Filippini, Rafael' where loser='Fillipini, Rafael';
update results set loser='Foley, Eric' where loser='Foley,E';
update results set winner='Gelhaus, Kelly' where winner='Gelhouse, Kelly';
update results set loser='Gelhaus, Kelly' where loser='Gelhouse, Kelly';
update results set loser='Gibbs, Joe' where loser='Gibbs,';
update results set winner='Gilliam, Lance' where winner='Gillian, Lance';
update results set loser='Gilliam, Lance' where loser='Gillian, Lance';
update results set winner='Gonzalez, Ruben' where winner='Gonzales, Ruben';
update results set loser='Gonzalez, Ruben' where loser='Gonzales, Ruben';
update results set winner='Graham, Sean' where winner='Graham,S';
update results set loser='Graham, Sean' where loser='Graham,S';
update results set winner='Gutierrez, Polo' where winner='Guitierrez, Polo';
update results set loser='Gutierrez, Polo' where loser='Guitierrez, Polo';
update results set winner='Karmelin, Shane' where winner='Karmelin';
update results set loser='Karmelin, Shane' where loser='Karmelin';
update results set winner='Liparelli, Scott' where winner='Lipparelli, Scott';
update results set loser='Liparelli, Scott' where loser='Lipparelli, Scott';
update results set winner='Kasay, J' where winner='Kasay,';
update results set loser='Kasay, J' where loser='Kasay,';
update results set winner='Kasay, J' where winner='Kasay,J';
update results set loser='Kasay, J' where loser='Kasay,J';
update results set winner='Marcus, Hank' where winner='Marcus,H';
update results set loser='Marcus, Hank' where loser='Marcus,H';
update results set winner='McCunniff, Brad' where winner='McCuniff, Brad';
update results set loser='McCunniff, Brad' where loser='McCuniff, Brad';
update results set winner='McAuliffe, ?' where winner='Mcauliffe,';
update results set loser='McAuliffe, ?' where loser='Mcauliffe,';
update results set winner='McCormick,B' where winner='Mccormick,B';
update results set loser='McCormick,B' where loser='Mccormick,B';
update results set winner='McDonough, M' where winner='Mcdonough,M';
update results set loser='McDonough, M' where loser='Mcdonough,M';
update results set winner='McDouwell, ?' where winner='Mcdowell,';
update results set loser='McDouwell, ?' where loser='Mcdowell,';
update results set winner='McDouwell, D' where winner='Mcdowell,D';
update results set loser='McDouwell, D' where loser='Mcdowell,D';
update results set winner='McGlone, ?' where winner='Mcglone,';
update results set loser='McGlone, ?' where loser='Mcglone,';
update results set winner='McKie, T' where winner='Mckie,T';
update results set loser='McKie, T' where loser='Mckie,T';
update results set winner='McKinney, B' where winner='Mckinney,B';
update results set loser='McKinney, B' where loser='Mckinney,B';
update results set winner='McQuarrie, D' where winner='Mcquarrie,D';
update results set loser='McQuarrie, D' where loser='Mcquarrie,D';
update results set winner='Menache, Sammy' where winner='Menache, Sam';
update results set loser='Menache, Sammy' where loser='Menache, Sam';
-- probably a mistake here: Meyers,L == Larry Meyers.
--update results set winner='Myers, Lindsay' where winner='Meyers,L';
--update results set loser='Myers, Lindsay' where loser='Meyers,L';
update results set winner='Negrete, J' where winner='Negrete,J';
update results set loser='Negrete, J' where loser='Negrete,J';
update results set winner='Niederhoffer, Victor' where winner='Niederhoffer,Vic';
update results set loser='Niederhoffer, Victor' where loser='Niederhoffer,Vic';
update results set loser='O''Neil, Todd' where loser='Oneil,T';
update results set winner='Palazzo, Joe' where winner='Palozzi, Joe';
update results set loser='Palazzo, Joe' where loser='Palozzi, Joe';
update results set winner='Plazak, Jeff' where winner='Plazak,J';
update results set loser='Plazak, Jeff' where loser='Plazak,J';
update results set winner='Richards, Torrey' where winner='Richards, torrey';
update results set loser='Richards, Torrey' where loser='Richards, torrey';
update results set loser='Roberts, Andy' where loser='Rob';
update results set winner='Rodriguez, Bobby' where winner='Rodriguez,B';
update results set loser='Rodriguez, Bobby' where loser='Rodriguez,B';
update results set winner='Sable, Dave' where winner='Sable,';
update results set loser='Sable, Dave' where loser='Sable,';
update results set winner='Sacco, Joey' where winner='Sacco,J';
update results set loser='Sacco, Joey' where loser='Sacco,J';
update results set winner='Simonette, Dave' where winner='Simonette,D';
update results set loser='Simonette, Dave' where loser='Simonette,D';
update results set winner='Thoerner, Jason' where winner='Thoerner';
update results set loser='Thoerner, Jason' where loser='Thoerner';
update results set winner='?' where winner='Unknown';
update results set loser='?' where loser='Unknown';
update results set winner='Waggoner, Jason' where winner='Wagonner,J';
update results set loser='Waggoner, Jason' where loser='Wagonner,J';
update results set winner='Wetherbee, John' where winner='Wetherbe, John';
update results set loser='Wetherbee, John' where loser='Wetherbe, John';
update results set winner='Wetherbee, John' where winner='Weatherbee, John';
update results set loser='Wetherbee, John' where loser='Weatherbee, John';
update results set winner='Winterton, Jim' where winner='Winterton,J';
update results set loser='Winterton, Jim' where loser='Winterton,J';

/* later on name fixing */
update results set loser='Cohen, Doug' where loser='Cohen,D';
update results set winner='Cohen, Doug' where winner='Cohen,D';
update results set loser='Koltun, Ben' where loser='Koltun,B';
update results set winner='Koltun, Ben' where winner='Koltun,B';
update results set winner='Champagne, Bo' where winner='Champagne,B';
update results set loser='Champagne, Bo' where loser='Champagne,B';
update results set winner='Derocheres, Eric' where winner='Derouchers, Eric';
update results set loser='Derocheres, Eric' where loser='Derouchers, Eric';
update results set winner='O''Connor, J' where winner='O''connor,J';
update results set loser='O''Connor, J' where loser='O''connor,J';
update results set winner='Tristan, Agustin' where winner='Tristan, Augusin';
update results set loser='Tristan, Agustin' where loser='Tristan, Augusin';




/* Cleaning Up Cities */

/* to consider: fix up anaheim vs Los Angeles, Lakewood vs Denver, consolidate DC events */


update results set city='Ft. Lauderdale, FL' where city='Ft Lauderdale';
update results set city='Livonia, MI' where city='Livonia,mi'

update results set city="Albuquerque, NM" where city="Albuquerque";
update results set city="Anaheim, CA" where city="Anaheim";
update results set city="Arlington, VA" where city="Arlington";
--update results set city="Arlington, TX" where city="Arlington, TX";
update results set city="Atlanta, GA" where city="Atlanta";
update results set city="Aurora, IL" where city="Aurora";
update results set city="Austin, TX" where city="Austin";
update results set city="Baltimore, MD" where city="Baltimore";
update results set city="Bangor, ME" where city="Bangor";
update results set city="Beaverton, OR" where city="Beaverton";
update results set city="Belleville, IL??" where city="Belleville";
update results set city="Beverly, MA??" where city="Beverly";
update results set city="Birmingham, AL" where city="Birmingham";
update results set city="Boston, MA" where city="Boston";
update results set city="Boulder, CO" where city="Boulder";
update results set city="Buffalo, NY" where city="Buffalo";
update results set city="Burlington, VT" where city="Burlington";
update results set city="Burnsville, MN" where city="Burnsville";
update results set city="Chattanooga, TN" where city="Chattanooga";
update results set city="Cheyenne, WY" where city="Cheyenne";
update results set city="Chicago, IL" where city="Chicago";
update results set city="Chihuahua, Mex" where city="Chihuahua";
update results set city="Cleveland, OH" where city="Cleveland";
update results set city="Columbus, OH" where city="Columbus";
update results set city="Concord, NH" where city="Concord";
update results set city="Coral Gables, FL" where city="Coral Gables";
update results set city="Coral Springs, FL" where city="Coral Springs";
update results set city="Dallas, TX" where city="Dallas";
update results set city="Davison, MI" where city="Davison";
update results set city="Denver, CO" where city="Denver";
update results set city="Edmonton, Can" where city="Edmonton";
update results set city="El Paso, TX" where city="El Paso";
update results set city="Fairfield, NJ" where city="Fairfield";
update results set city="Fountain Valley, CA" where city="Fountain Valley";
update results set city="Ft. Lauderdale, FL" where city="Ft Lauderdale";
update results set city="Ft. Worth, TX" where city="Ft. Worth";
update results set city="Grand Rapids, MI" where city="Grand Rapids";
update results set city="Greensboro, NC" where city="Greensboro";
update results set city="Gresham, OR" where city="Gresham";
update results set city="Honolulu, HI" where city="Honolulu";
update results set city="Houston, TX" where city="Houston";
update results set city="Jacksonville, FL" where city="Jacksonville";
update results set city="Lakewood, CO" where city="Lakewood";
update results set city="Las Vegas, NV" where city="Las Vegas";
update results set city="Little Rock, AR" where city="Little Rock";
update results set city="Livonia, MI" where city="Livonia,mi";
update results set city="Lombard, IL??" where city="Lombard";
update results set city="Long Beach, CA" where city="Long Beach";
update results set city="Long Island, NY" where city="Long Island";
update results set city="Los Angeles, CA" where city="Los Angeles";
update results set city="Louisville, KY" where city="Louisville";
--update results set city="Lyndhurst, NJ" where city="Lyndhurst, NJ";
update results set city="Marietta, GA" where city="Marietta Ga";
update results set city="McLean, VA" where city="McLean";
update results set city="Memphis, TN" where city="Memphis";
update results set city="Miami, FL" where city="Miami";
update results set city="Detriot??, MI" where city="Michigan";
update results set city="Milpitas, CA" where city="Milpitas";
update results set city="Milwaukee, WI" where city="Milwaukee"; 
update results set city="Minneapolis, MN" where city="Minneapolis";
update results set city="Montreal, Can" where city="Montreal";
update results set city="New Haven, CT" where city="New Haven";
update results set city="New Orleans, LA" where city="New Orleans";
update results set city="Long Island??, NY" where city="New York"; 
update results set city="Newport Beach, CA" where city="Newport Beach";
update results set city="Oceanside, CA?" where city="Oceanside";
update results set city="Omaha, NE" where city="Omaha";       
update results set city="Peoria, IL" where city="Peoria";       
update results set city="Phoenix, AZ" where city="Phoenix";
update results set city="Pittsburgh, PA" where city="Pittsburgh";
update results set city="Pleasanton, CA" where city="Pleasanton";
update results set city="Portland, OR" where city="Portland";
update results set city="Riverside, CA" where city="Riverside";
update results set city="Rochester, NY" where city="Rochester";
update results set city="Sacramento, CA" where city="Sacramento";     
update results set city="Salem, OR" where city="Salem";        
update results set city="San Antonio, TX" where city="San Antonio";
update results set city="San Carlos, CA??" where city="San Carlos";  
update results set city="San Diego, CA" where city="San Diego"; 
update results set city="San Francisco, CA" where city="San Francisco";
update results set city="San Luis Potosi, Mex" where city="San Luis Potosi";
update results set city="Santa Barbara, CA" where city="Santa Barbara";
update results set city="Saskatoon, Can" where city="Saskatoon";   
update results set city="Seattle, WA" where city="Seattle"; 
update results set city="Southfield, MI" where city="Southfield";
update results set city="St. Louis, MO" where city="St Louis";   
update results set city="St. Louis, MO" where city="St. Louis"; 
update results set city="Stockton, CA" where city="Stockton";
update results set city="Sunnyvale, CA" where city="Sunnyvale"; 
update results set city="Tempe, AZ" where city="Tempe";      
update results set city="Toronto, Can" where city="Toronto";    
update results set city="Tucson, AZ" where city="Tucson";    
update results set city="Tulsa, OK" where city="Tulsa";        
update results set city="Vancouver, Can" where city="Vancouver";  
update results set city="Vancouver, Can" where city="Vancouver, Can";
update results set city="Westbury, NY" where city="Westbury Ny";
update results set city="Westminster, CA" where city="Westminster";
update results set city="Westminster, CA" where city="Westminster Ca";
update results set city="Winnipeg, Can" where city="Winnipeg";

update results set city="Chihuahua, Mex" where city="Chihuahua, MEX";
update results set city="Edmonton, Can" where city="Edmonton, CAN";
update results set city="Montreal, Can" where city="Montreal, CAN";
update results set city="San Luis Potosi, Mex" where city="San Luis Potosi, MEX";
update results set city="Saskatoon, Can" where city="Saskatoon, CAN";   
update results set city="Toronto, Can" where city="Toronto, CAN";    
update results set city="Winnipeg, Can" where city="Winnipeg, CAN";



/* fixing scores: standardized codes for forfeits */
/* fft, ret inj, ret */

update results set score='?,?,9' where score=' , ,9';
update results set score='(7),9,7,ret inj' where score=' (7),9,7,Inf fft';
update results set score='10,2,ret' where score='10,2,Ret.';
update results set score='(7),9,7,inj fft' where score='(7),9,7,Inf fft';

update results set score='fft' where score='def';
update results set score='' where score='n/a';
update results set score='' where score='N/A';
update results set score='' where score='SNA';
update results set score ='inj fft' where score='fft inj';
update results set score ='inj fft' where score='fft, inj';
update results set score='fft' where score='FORFEIT';
update results set score ='inj fft' where score='INJURY';
update results set score ='inj fft' where score='INJURY FORFEIT';
update results set score ='inj fft' where score='ret inj';
update results set score='' where score='?';
update results set score='fft' where score='FFT';
update results set score='0,10,ret' where score='0,10,FORFEIT';
update results set score='(0),3,9,ret' where score='(0),3,9,FORFEIT';
update results set score='5,inj fft' where score='5,INJ FORFEIT';


/* Incorrect city/tourney info for Austin/Coral Springs events: fix sql */

update results set event='America''s Cup', date='2/2/2003', tmp_date='2003-02-02', city='Coral Springs, FL' 
where event='Longhorn Pro-Am' and round=64;

update results set event='America''s Cup', date='2/2/2003', tmp_date='2003-02-02', city='Coral Springs, FL' 
--where event='Longhorn Pro-Am' and round=32 and winner ='Dennison, Mike' and loser='Fredenburg, Brian';
--where event='Longhorn Pro-Am' and round=32 and winner ='Green, Mike' and loser='Herrera, Anthony';
--where event='Longhorn Pro-Am' and round=32 and winner ='Guidry, Mike' and loser='Gutierrez, Polo';
--where event='Longhorn Pro-Am' and round=32 and winner ='Llacera, Dan' and loser='Harmon, Mike';
--where event='Longhorn Pro-Am' and round=32 and winner ='Moreno, Javier' and loser='Williams, Mitch';
--where event='Longhorn Pro-Am' and round=32 and winner ='Thoerner, Jason' and loser='Coyle, Eugene';
--where event='Longhorn Pro-Am' and round=32 and winner ='Tucker, Josh' and loser='Gonzalez, Ruben';
where event='Longhorn Pro-Am' and round=32 and winner ='Vanderson, Shane' and loser='Irvine, Nick';

/* fix apostrophe so query comes up */
update results set event='Americas Cup' where event='America''s Cup';

/* Fixes from Jaime Arroyave 4/6/04 */

update results set loser='Arroyave, Jaime' where loser='Arroyave, ?';
update results set loser='Satawa, Brian' where loser='Satawa, ?';
update results set loser='Bhuta, Jed' where loser='Bhuta, ?';




/**********************************************************************************************/
/* Part III: ongoing loading up of each tourney */

use wwwbossconsultingcom;

/* already done */
create table results_staging as 
select * from results where 1=2;

alter table results_staging modify column round char(3);
delete from results_staging;

/* start here */

load data local infile 'c:/temp/irt_longisland.csv' into table results_staging
--load data local infile 'Pro_Results_new.csv' into table results
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging;
delete from results_staging where winner='';
delete from results_staging where winner='winner';

select distinct(date) from results_staging;
update results_staging set tmp_date='1997-06-08' where date='6/8/1997'
update results_staging set tmp_date='1998-05-09' where date='5/9/1998'
update results_staging set tmp_date='1994-11-06' where date='11/6/2004'
update results_staging set date='11/6/1994' where date='11/6/2004'

update results_staging set tmp_date='1995-04-30' where date='4/30/1995'

update results_staging set tmp_date='2005-01-24';

update results_staging set round='8' where round='Q';
update results_staging set round='4' where round='S';
update results_staging set round='2' where round='F';

select distinct(season) from results_staging;
update results_staging set season='1996-7' where season like '1996%';
update results_staging set season='1997-8' where season like '1997%';
update results_staging set season='1994-5' where season like '1994%';

update results_staging set season='2004-5';

insert into results select * from results_staging;

delete from results_staging;



/**********************************************************************************************/

/* Part IV: populate Wins table for "regular tour player" query on front page */


delete from wins;
insert into wins
select winner, count(winner) as wins
from results
group by winner








/**********************************************************************************************/
/* Indexes post loading */

/* unindexed fields : score,tour,city,source,notes */

create index winner_ndx on results(winner);
create index loser_ndx on results(loser);
create index round_ndx on results (round);
create index event_ndx on results (event);
create index date_ndx on results (date);
create index season_ndx on results(season);
create index tmp_date_ndx on results (tmp_date);

create index event_date_ndx on results(event,date);
create index winner_round_ndx on results(winner,round);
create index loser_round_ndx on results(loser,round);

create index wins_ndx on wins (wins);


/**********************************************************************************************/
/* backup attempts */

mysqldump -h mysql.bossconsulting.com -utboss --password=Maryland \
--tab results --fields-terminated-by='|' >> results_fromdb.csv


mysqldump -h mysql.bossconsulting.com -u tboss --password=Maryland \
--tab="/usr/home/tboss/backup" --fields-terminated-by="|" wwwbossconsultingcom results


/**********************************************************************************************/
9/17/04: complete reloading efforts.

1. ftp'd results.csv to the server.

2. Do the load, do some cleanup
delete from results_staging;

load data local infile 'results.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

delete from results_staging where winner='';
delete from results_staging where winner='winner';

3. run fix_tmp_date.pl; this populates tmp_date from the real date,
important for many date-related queries.

4. Didn't have to re-run any of the above queries, since the data was dumped
out and used to do the add'l updates.

5. Do some Name cleaning.  Went through database, looking for any names
that could be fixed.

select distinct(winner) as name from results_staging
union
select distinct(loser) as name from results_staging
order by name

update results_staging set winner='Amatulli, John' where winner='Amatuli, John';
update results_staging set loser='Amatulli, John' where loser='Amatuli, John';
update results_staging set winner='Arroyave, Jaime' where winner='Arroyave, Jamie';
update results_staging set loser='Arroyave, Jaime' where loser='Arroyave, Jamie';
update results_staging set winner='Bustillos, Luis' where winner='Busillos, Luis';
update results_staging set loser='Bustillos, Luis' where loser='Busillos, Luis';
update results_staging set winner='Calabrese, Fred' where winner='Calabrese,F';
update results_staging set winner='Calabrese, Fred' where winner='Caliabrese, Fred';
update results_staging set winner='Calabrese, Fred' where winner='Callabrese, Fred';
update results_staging set loser='Calabrese, Fred' where loser='Calabrese,F';
update results_staging set loser='Calabrese, Fred' where loser='Caliabrese, Fred';
update results_staging set loser='Calabrese, Fred' where loser='Callabrese, Fred';
update results_staging set winner='Filippini, Rafael' where winner='Fillippini, Rafael';
update results_staging set loser='Filippini, Rafael' where loser='Fillippini, Rafael';
update results_staging set winner='Garner, Jeff' where winner='Garner, Jeffrey';
update results_staging set loser='Garner, Jeff' where loser='Garner, Jeffrey';
update results_staging set winner='Garrison, Glenn' where winner='Garrison, Glen';
update results_staging set loser='Garrison, Glenn' where loser='Garrison, Glen';
update results_staging set winner='Garrison, Glenn' where winner='Garrison,G';
update results_staging set loser='Garrison, Glenn' where loser='Garrison,G';
update results_staging set winner='Greenfield, Sherman' where winner='Greenfeld, Sherman';
update results_staging set loser='Greenfield, Sherman' where loser='Greenfeld, Sherman';
update results_staging set winner='Giunta, Nick' where winner='Guinta, ?';
update results_staging set loser='Giunta, Nick' where loser='Guinta, ?';
update results_staging set winner='Hadid, Sameer' where winner='Hadid, Samir';
update results_staging set loser='Hadid, Sameer' where loser='Hadid, Samir';
update results_staging set winner='Hamon, Scott' where winner='Hamon, ?';
update results_staging set loser='Hamon, Scott' where loser='Hamon, ?';
update results_staging set winner='Harnett, Brett' where winner='Harnett, Bret';
update results_staging set loser='Harnett, Brett' where loser='Harnett, Bret';
update results_staging set winner='Swift, James' where winner='James Swift';
update results_staging set loser='Swift, James' where loser='James Swift';
update results_staging set winner='Barros, Jeff' where winner='Jeff Barros';
update results_staging set loser='Barros, Jeff' where loser='Jeff Barros';
update results_staging set winner='Johnson, Dale' where winner='johnson, Dale';
update results_staging set loser='Johnson, Dale' where loser='johnson, Dale';
update results_staging set winner='Kazuhshuge,Oikawa' where winner='Kazuhshge, Oikawa';
update results_staging set loser='Kazuhshuge,Oikawa' where loser='Kazuhshge, Oikawa';
update results_staging set winner='Lerner, Steve (CA)' where winner='Steve Lerner';
update results_staging set loser='Lerner, Steve (CA)' where loser='Steve Lerner';
update results_staging set winner='Liparelli, Scott' where winner='Lipparelli, Scott';
update results_staging set loser='Liparelli, Scott' where loser='Lipparelli, Scott';
update results_staging set winner='Martinez, Mike' where winner='Martinez,M';
update results_staging set loser='Martinez, Mike' where loser='Martinez,M';
update results_staging set winner='McCunniff, Brad' where winner='McCunnniff, Brad';
update results_staging set loser='McCunniff, Brad' where loser='McCunnniff, Brad';
update results_staging set winner='McCunniff, Brad' where winner='McCunniff';
update results_staging set loser='McCunniff, Brad' where loser='McCunniff';
update results_staging set winner='McDouwell, D' where winner='McDouwell, ?';
update results_staging set loser='McDouwell, D' where loser='McDouwell, ?';
update results_staging set winner='Negrete, John' where winner='Negrete, J';
update results_staging set loser='Negrete, John' where loser='Negrete, J';
update results_staging set winner='Parodi, Bill' where winner='Parodi,B';
update results_staging set loser='Parodi, Bill' where loser='Parodi,B';
update results_staging set winner='Rahn, David' where winner='Rahn, Dave';
update results_staging set loser='Rahn, David' where loser='Rahn, Dave';
update results_staging set winner='Sawyer, Buz' where winner='Sawyer, Buzz';
update results_staging set loser='Sawyer, Buz' where loser='Sawyer, Buzz';
update results_staging set winner='Schenck, Darrin' where winner='Schneck, Darrin';
update results_staging set loser='Schenck, Darrin' where loser='Schneck, Darrin';
update results_staging set winner='Shepley, William' where winner='Shepley, Bill';
update results_staging set loser='Shepley, William' where loser='Shepley, Bill';
update results_staging set winner='Shepley, William' where winner='Shepley, Billy';
update results_staging set loser='Shepley, William' where loser='Shepley, Billy';
update results_staging set winner='Rojas, Steve' where winner='Steve Rojas';
update results_staging set loser='Rojas, Steve' where loser='Steve Rojas';
update results_staging set winner='Ulliman, Pete' where winner='Ulliman, Peter';
update results_staging set loser='Ulliman, Pete' where loser='Ulliman, Peter';
update results_staging set winner='Villareal, Manuel' where winner='Villareal, ?';
update results_staging set loser='Villareal, Manuel' where loser='Villareal, ?';

oops, couple more
update results_staging set winner='Barnes, Dave' where winner='Barnes, Dane';
update results_staging set loser='Barnes, Dave' where loser='Barnes, Dane';
update results_staging set winner='Burrell, Arturo' where winner='Burruel, Arturo';
update results_staging set loser='Burrell, Arturo' where loser='Burruel, Arturo';
update results_staging set winner='Cannady, Devin' where winner='Canady, Devin';
update results_staging set loser='Cannady, Devin' where loser='Canady, Devin';
update results_staging set winner='Herrera, ?' where winner='Herera, ?';
update results_staging set loser='Herrera, ?' where loser='Herera, ?';
update results_staging set winner='Anderson, Michael' where winner='Anderson, Mike';
update results_staging set loser='Anderson, Michael' where loser='Anderson, Mike';
update results_staging set winner='Sheppick, Dan' where winner='Dan Sheppick';
update results_staging set loser='Sheppick, Dan' where loser='Dan Sheppick';
update results_staging set winner='Gonzales, Pat' where winner='Gonzalez, Pat';
update results_staging set loser='Gonzales, Pat' where loser='Gonzalez, Pat';
update results_staging set winner='Green,D' where winner='Green,';
update results_staging set loser='Green,D' where loser='Green,';
update results_staging set winner='Rivas, Juan' where winner='Juan Rivas';
update results_staging set loser='Rivas, Juan' where loser='Juan Rivas';
update results_staging set winner='Kazuhshuge, Oikawa' where winner='Kazuhshuge,Oikawa';
update results_staging set loser='Kazuhshuge, Oikawa' where loser='Kazuhshuge,Oikawa';
update results_staging set winner='Lerner, Steve (CA)' where winner='Lerner, Steve';
update results_staging set loser='Lerner, Steve (CA)' where loser='Lerner, Steve';
update results_staging set winner='St. Onge,S' where winner='St.onge,S';
update results_staging set loser='St. Onge,S' where loser='St.onge,S';
update results_staging set winner='Stevens,R' where winner='Stephens,R';
update results_staging set loser='Stevens,R' where loser='Stephens,R';
update results_staging set winner='' where winner='';
update results_staging set loser='' where loser='';
update results_staging set winner='' where winner='';
update results_staging set loser='' where loser='';
update results_staging set winner='' where winner='';
update results_staging set loser='' where loser='';


6. Do some other cleaning; did select distinct() on all fields, looking for errors.

update results_staging set round=8 where round=6;

7. move old results to old, mve new results to new, reindex

alter table results rename to results_old;
alter table results_staging rename to results;
create table results_staging as select * from results where 1=2;

8. make the round an integer again.
alter table results modify column round integer;

9. fix seasons; getting weird results

update results set season='1994-5' where season like '1994%';
update results set season='1995-6' where season like '2005%';
update results set season='1996-7' where season like '2006%';

update results set season='1988-9' where season like '1988%';

10. fixed cities: 
update results set city='Boston, MA' where city='Boston';
update results set city='Dallas, TX' where city='Dallas';
update results set city='Detroit, MI' where city='Detriot??, MI';
update results set city='Ft. Lauderdale, FL' where city='Ft. Lauderdale';
update results set city='Las Vegas, NV' where city='Las Vegas';
update results set city='Long Island, NY' where city='Long Island??, NY';

update results set city='Long Island, NY' where city='Long Island??, NY';
update results set city='Belleville, IL' where city='Belleville, IL??';
update results set city='Beverly, MA' where city='Beverly, MA??';
update results set city='Lombard, IL' where city='Lombard, IL??';
update results set city='Oceanside, CA' where city='Oceanside, CA?';
update results set city='San Carlos, CA' where city='San Carlos, CA??';


/**********************************************************************************************/
city_state 

drop table city_state;
create table city_state as select distinct city from results;
alter table city_state add column state char(3);

update city_state set state=substr(city,instr(city,',')+2,3);


update results set season='1973-4' where season like '1973%';
update results set season='1974-5' where season like '1974%';
update results set season='1975-6' where season like '1975%';
update results set season='1976-7' where season like '1976%';
update results set season='1977-8' where season like '1977%';
update results set season='1978-9' where season like '1978%';
update results set season='1979-80' where season like '1979%';
update results set season='1980-1' where season like '1980%';
update results set season='1981-2' where season like '1981%';
update results set season='1982-3' where season like '1982%';
update results set season='1983-4' where season like '1983%';
update results set season='1984-5' where season like '1984%';
update results set season='1985-6' where season like '1985%';
update results set season='1986-7' where season like '1986%';
update results set season='1987-8' where season like '1987%';
update results set season='1988-9' where season like '1988%';
update results set season='1989-90' where season like '1989%';
update results set season='1990-1' where season like '1990%';
update results set season='1991-2' where season like '1991%';
update results set season='1992-3' where season like '1992%';
update results set season='1993-4' where season like '1993%';
update results set season='1994-5' where season like '1994%';
update results set season='1995-6' where season like '1995%';
update results set season='1996-7' where season like '1996%';
update results set season='1997-8' where season like '1997%';
update results set season='1998-9' where season like '1998%';
update results set season='1999-00' where season like '1999%';
update results set season='2000-1' where season like '2000%';
update results set season='2001-2' where season like '2001%';
update results set season='2002-3' where season like '2002%';
update results set season='2003-4' where season like '2003%';
update results set season='2004-5' where season like '2004%';