Maintenance SQL on old results:

desc results_old;
alter table results_old modify round varchar(5);
delete from results_old;

load data local infile 'c:/boss/rball/irt/MPRO_fixed_tab_modern.csv' into table results_old
fields terminated by ',' enclosed by '"' lines terminated by '\n';

delete from results_old where winner='Winner';

--select * from results_old;
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
update results_old set date='6/1/76' where city='San Diego' and season='1976-7';

update results_old set event='Milwaukee 77', date='9/1/77' where city='Milwaukee' and season='1977-8';
update results_old set event='Westbury 77', date='10/1/77' where city='Westbury Ny' and season='1977-8';
update results_old set event='Westminster 77', date='11/1/77' where city='Westminster' and season='1977-8';
update results_old set event='Marietta 77', date='12/1/77' where city='Marietta Ga' and season='1977-8';
update results_old set event='Gresham 78', date='1/1/78', city='Gresham' where city='Gresham Or' and season='1977-8';
update results_old set event='Tempe 78', date='2/1/78' where city='Tempe' and season='1977-8';
update results_old set event='San Antonio 78', date='3/1/78' where city='San Antonio' and season='1977-8';
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

select * from results where city='Baltimore' order by date,round

/* missed this final */
insert into results values ('Ray, Mike','Roberts, Andy',2,'(9),9,(2),3,6','IRT','Baltimore','VCI Challenger Cup Series #2','11/22/1992','Racquetball Magazine Jan/Feb 93 v4n1','1992-3','','1992-11-22')