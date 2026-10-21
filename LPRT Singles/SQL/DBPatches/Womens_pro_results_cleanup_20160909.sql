/* 
filename: Womens_pro_results_cleanup_20160909.sql
purpose: SQL to clean up the womens results so the code works better

modification history
when	who	what
9/9/16	tboss	creation
12/1/16 tboss	saving more cleanup

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

create table results_20190909 as select * from wpro_results;

select * from results where tmp_date is not null order by tmp_date asc;

select * from results where tmp_date is null order by season,event,round desc;

--------------

-- copying text as we create it soas to keep this file small


select * from wpro_results where event='Denver' and season='1975-76';

select * from wpro_results where event='Denver 75-76';



--------------

create table results as select * from wpro_results;
create table results_staging as select * from wpro_results_staging;
create table tourneys as select * from wpro_tourneys;
create table wins as select * from wpro_wins;

drop table wpro_results;
drop table wpro_results_staging;
drop table wpro_tourneys;
drop table wpro_wins;

--------------


-- 75-76

update wpro_results set event='Denver 75-76', date='12/1/1975', tmp_date='1975-12-01' where event='Denver' and season='1975-76';

-- syncing w/ NRC mens event the same time
update wpro_results set event='Denver 75', date='9/1/1975', tmp_date='1975-09-01' where event='Denver 75-76';

update wpro_results set event='San Diego 75-76', date='3/1/1976', tmp_date='1976-03-01' where event='San Diego' and season='1975-76';
-- syncing w/ NRC mens event the same time
update wpro_results set event='NRC DP/Leach Nationals 76', date='6/1/76', tmp_date='1976-06-01' where event='San Diego 75-76';



-- 76/77
update wpro_results set event='Burlington 76-77', date='9/1/1976', tmp_date='1976-09-01' where event='Burlington, VT' and season='1976-77';
-- syncing w/ NRC mens event the same time
update wpro_results set event='Burlington 76', date='10/15/76', tmp_date='1976-10-15' where event='Burlington 76-77';


update wpro_results set event='Chattanooga 76-77', date='11/1/1976', tmp_date='1976-11-01' where event='Chattanooga' and season='1976-77';
-- syncing w/ NRC mens event the same time
update wpro_results set event='Chattanooga 77', date='4/1/1977', tmp_date='1977-04-01' where event='Chattanooga 76-77';

update wpro_results set event='Denver 76-77', date='12/1/1976', tmp_date='1976-12-01' where event='Denver' and season='1976-77';
-- syncing w/ NRC mens event the same time
update wpro_results set event='Denver 77', date='3/1/1977', tmp_date='1977-03-01' where event='Denver 76-77';

update wpro_results set event='Edmonton 76-77', date='2/11/1977', tmp_date='1977-02-01' where event='Edmonton' and season='1976-77';
-- syncing w/ NRC mens event the same time
update wpro_results set event='Canadian Nationals 76', date='9/15/1976', tmp_date='1976-09-15' where event='Edmonton 76-77';


update wpro_results set event='Edmonton 76-77', date='2/11/1977', tmp_date='1977-02-01' where event='Edmonton' and season='1976-77';

-- syncing w/ NRC mens event the same time
update wpro_results set event='Courtrooms Pro-Am 76', date='10/1/1976', tmp_date='1976-10-01' where event='Ft Lauderdale' and season='1976-77';

update wpro_results set event='Houston 77', date='2/1/1977', tmp_date='1977-02-01' where event='Houston' and season='1976-77';

update wpro_results set event='Las Vegas 77', date='1/1/1977', tmp_date='1977-01-01' where event='Las Vegas' and season='1976-77';

update wpro_results set event='Lombard 77', date='5/1/1977', tmp_date='1977-05-01' where event='Lombard' and season='1976-77';

update wpro_results set event='Newport Beach 77', date='5/15/1977', tmp_date='1977-05-15' where event='Newport Beach' and season='1976-77';

update wpro_results set event='Sacramento 77', date='9/1/1976', tmp_date='1976-09-01' where event='Sacramento' and season='1976-77';

update wpro_results set event='NRC DP/Leach Nationals 77', date='6/1/1977', tmp_date='1977-06-01' where event='San Diego' and season='1976-77';


-- 77/78

update wpro_results set event='NRC DP/Leach Nationals 78', date='6/1/1978', tmp_date='1978-06-01' where event='Belleville' and season='1977-78';

update wpro_results set event='Milwaukee 77', date='9/1/1977', tmp_date='1977-09-01' where event='Milwaukee' and season='1977-78';

update wpro_results set event='San Antonio 78', date='3/1/1978', tmp_date='1978-03-01' where event='San Antonio' and season='1977-78';

update wpro_results set event='Tempe 78', date='2/1/1978', tmp_date='1978-02-01' where event='Tempe' and season='1977-78';

update wpro_results set event='Omaha 77', date='11/1/1977', tmp_date='1977-11-01' where event='Omaha' and season='1977-78';

-- 78-79

update wpro_results set event='Catalina Classic 79', date='3/1/1979', tmp_date='1979-03-01' where event='Westminster' and season='1978-79';

update wpro_results set event='1st Robert W. Kendler Classic', date='4/29/1979', tmp_date='1979-04-29' where event='New Haven' and season='1978-79';

update wpro_results set event='Leach Motor City Classic 78', date='10/15/1978', tmp_date='1978-10-15' where event='Southfield' and season='1978-79';

update wpro_results set event='NRC DP/Leach Nationals 79', date='5/1/1979', tmp_date='1979-05-01' where event='Tempe' and season='1978-79';

update wpro_results set event='St. Louis 78', date='10/1/1978', tmp_date='1978-10-01' where event='St. Louis' and season='1978-79';

update wpro_results set event='Seamco Racquetball Classic 78', date='11/9/1978', tmp_date='1978-11-09' where event='New York' and season='1978-79';

update wpro_results set event='Arvada 79', date='1/1/1979', tmp_date='1979-01-01' where event='Arvada' and season='1978-79';

update wpro_results set event='King of Prussia 79', date='2/1/1979', tmp_date='1979-02-01' where event='King of Prussia' and season='1978-79';


-- 1979-80

update results set event='Kunnan/Kennex Tournament of Champions 80', date='2/2/1980', tmp_date='1980-02-02' where event='Coral Gables' and season='1979-80';

delete from results where event='Lombard' and season='1979-80';

update results set event='Tanner/Coca Cola Classic 79', date='12/16/1979', tmp_date='1979-12-16' where event='Memphis' and season='1979-80';

update results set event='Jack in the Box Classic 79', date='11/8/1979', tmp_date='1979-11-08' where event='Tempe' and season='1979-80';

update results set event='Winnipeg 80', date='1/1/1980', tmp_date='1980-0101' where event='Winnipeg' and season='1979-80';


-- 80-81 
update results set event='Winnipeg 80', date='1/1/1980', tmp_date='1980-0101' where event='Winnipeg' and season='1979-80';

select * from results where event='Winnipeg 80';
update results set tmp_date='1980-01-01' where event='Winnipeg 80';

delete from results where event='Bloomingdale' and season='1980-81';

update results set event='Boise 80', date='9/1/1980', tmp_date='1980-09-01' where event='Boise' and season='1980-81';

update results set event='Columbus 80', date='10/1/1980', tmp_date='1980-10-01' where event='Columbus' and season='1980-81';

update results set event='Escondido 80', date='11/1/1980', tmp_date='1980-11-01' where event='Escondido' and season='1980-81';

update results set event='Federal Way 80', date='12/1/1980', tmp_date='1980-12-01' where event='Federal Way' and season='1980-81';

update results set event='Federal Way 80', date='12/1/1980', tmp_date='1980-12-01' where event='Federal Way' and season='1980-81';

update results set event='Fishkill 81', date='1/1/1981', tmp_date='1981-01-01' where event='Fishkill' and season='1980-81';

update results set event='Newport Beach 81', date='2/1/1981', tmp_date='1981-02-01' where event='Newport Beach' and season='1980-81';

update results set event='Palantine 81', date='3/1/1981', tmp_date='1981-03-01' where event='Palantine' and season='1980-81';

update results set event='Warwick 81', date='4/1/1981', tmp_date='1981-04-01' where event='Warwick' and season='1980-81';



-- 1981-82

update results set event='Ektelon/Pony Nationals 82', date='5/9/1982', tmp_date='1982-05-09' where event='Anaheim' and season='1981-82';

update results set event='Bangor 81', date='9/1/1981', tmp_date='1981-09-01' where event='Bangor' and season='1981-82';

update results set event='Columbus 81', date='10/1/1981', tmp_date='1981-10-01' where event='Columbus' and season='1981-82';

update results set event='Denver 81', date='11/1/1981', tmp_date='1981-11-01' where event='Denver' and season='1981-82';

update results set event='Federal Way 81', date='12/1/1981', tmp_date='1981-12-01' where event='Federal Way' and season='1981-82';

update results set event='Fishkill 82', date='1/1/1982', tmp_date='1982-01-01' where event='Fishkill' and season='1981-82';

update results set event='Lombard 82', date='2/1/1982', tmp_date='1982-02-01' where event='Lombard' and season='1981-82';

update results set event='Palantine 82', date='3/1/1982', tmp_date='1982-03-01' where event='Palantine' and season='1981-82';

update results set event='Warwick 82', date='4/1/1982', tmp_date='1982-04-01' where event='Warwick' and season='1981-82';


-- 1982-3

update results set event='Toronto 82', date='9/1/1982', tmp_date='1982-09-01' where event='Toronto' and season='1982-83';

update results set event='Vancouver 82', date='10/1/1982', tmp_date='1982-10-01' where event='Vancouver' and season='1982-83';

update results set event='Winnipeg 82', date='11/1/1982', tmp_date='1982-11-01' where event='Winnipeg' and season='1982-83';

update results set event='Lafayette 82', date='12/1/1982', tmp_date='1982-12-01' where event='Lafayette' and season='1982-83';

update results set event='Atlanta 82', date='12/15/1982', tmp_date='1982-12-15' where event='Atlanta' and season='1982-83';

update results set event='Melbourne 83', date='1/1/1983', tmp_date='1983-01-01' where event='Melbourne' and season='1982-83';

update results set event='Fort Worth 83', date='2/1/1983', tmp_date='1983-02-01' where event='Fort Worth' and season='1982-83';

update results set event='Quebec City 83', date='3/1/1983', tmp_date='1983-03-01' where event='Quebec City' and season='1982-83';

update results set event='Bangor 83', date='3/15/1983', tmp_date='1983-03-15' where event='Bangor' and season='1982-83';

update results set event='Pleasanton 83', date='4/1/1983', tmp_date='1983-04-01' where event='Pleasanton' and season='1982-83';

update results set event='Kent 83', date='5/1/1983', tmp_date='1983-05-01' where event='Kent' and season='1982-83';

update results set event='Lombard 83', date='6/1/1983', tmp_date='1983-06-01' where event='Lombard' and season='1982-83';



-- 83-84

update results set event='Auburn 83', date='9/1/1983', tmp_date='1983-09-01' where event='Auburn' and season='1983-84';

update results set event='Plymouth 83', date='10/1/1983', tmp_date='1983-10-01' where event='Plymouth' and season='1983-84';

update results set event='Seattle 83', date='11/1/1983', tmp_date='1983-11-01' where event='Seattle' and season='1983-84';

update results set event='Bangor 84', date='1/1/1984', tmp_date='1984-01-01' where event='Bangor' and season='1983-84';

update results set event='DP/Leach Nationals 84', date='6/1/1984', tmp_date='1984-06-01' where event='Atlanta' and season='1983-84';

update results set event='Fort Worth 84', date='2/1/1984', tmp_date='1984-02-01' where event='Fort Worth' and season='1983-84';

update results set event='Costa Mesa 84', date='3/1/1984', tmp_date='1984-03-01' where event='Costa Mesa' and season='1983-84';


-- 84-85


update results set event='Atlanta 84', date='9/1/1984', tmp_date='1984-09-01' where event='Atlanta' and season='1984-85';

update results set event='Auburn 84', date='10/1/1984', tmp_date='1984-10-01' where event='Auburn' and season='1984-85';

update results set event='Anchorage 84', date='11/1/1984', tmp_date='1984-11-01' where event='Anchorage' and season='1984-85';

update results set event='Essex Junction 84', date='12/1/1984', tmp_date='1984-12-01' where event='Essex Junction' and season='1984-85';

update results set event='Lynwood 85', date='1/1/1985', tmp_date='1985-01-01' where event='Lynwood' and season='1984-85';

update results set event='Anaheim 85', date='2/1/1985', tmp_date='1985-02-01' where event='Anaheim' and season='1984-85';

update results set event='Oklahoma 85', date='3/1/1985', tmp_date='1985-03-01' where event='Oklahoma' and season='1984-85';

update results set event='Fort Worth 85', date='4/1/1985', tmp_date='1985-04-01' where event='Fort Worth' and season='1984-85';

update results set event='DP Nationals Boston 85', date='6/1/1985', tmp_date='1985-06-01' where event='Boston' and season='1984-85';


-- 85-86

update results set event='Anchorage 85', date='9/1/1985', tmp_date='1985-09-01' where event='Anchorage' and season='1985-86';

update results set event='Fountain Valley 85', date='11/1/1985', tmp_date='1985-11-01' where event='Fountain Valley' and season='1985-86';

update results set event='Ektelon Nationals Anaheim 86', date='5/1/1986', tmp_date='1986-05-01' where event='Anaheim' and season='1985-86';

update results set event='DP Nationals Arlington 86', date='6/1/1986', tmp_date='1986-06-01', city='Arlington, TX' where event='Arlington' and season='1985-86';

update results set event='Fort Worth 86', date='6/15/1986', tmp_date='1986-06-15' where event='Fort Worth' and season='1985-86';


-- 86-87

update results set event='Anchorage 86', date='9/1/1986', tmp_date='1986-09-01' where event='Anchorage' and season='1986-87';

update results set event='Chicago 86', date='10/1/1986', tmp_date='1986-10-01' where event='Chicago' and season='1986-87';

update results set event='Anaheim 86', date='11/1/1986', tmp_date='1986-11-01' where event='Anaheim' and season='1986-87';

update results set event='Hershey 87', date='1/1/1987', tmp_date='1987-01-01' where event='Hershey' and season='1986-87';

update results set event='Atlanta 87', date='3/1/1987', tmp_date='1987-03-01' where event='Atlanta' and season='1986-87';

update results set event='Ohio 87', date='5/1/1987', tmp_date='1987-05-01' where event='Ohio' and season='1986-87';

update results set event='Fort Worth 87', date='6/1/1987', tmp_date='1987-06-01' where event='Fort Worth' and season='1986-87';


-- 87-88
update results set event='Chicago 87', date='9/1/1987', tmp_date='1987-09-01' where event='Chicago' and season='1987-88';
update results set event='Anaheim 87', date='10/1/1987', tmp_date='1987-10-01' where event='Anaheim' and season='1987-88';

update results set event='Atlanta 87', date='11/1/1987', tmp_date='1987-11-01' where event='Atlanta' and season='1987-88';

update results set event='Sellersville 88', date='1/1/1988', tmp_date='1988-01-01' where event='Sellersville' and season='1987-88';
update results set event='Hershey 88', date='2/1/1988', tmp_date='1988-02-01' where event='Hershey' and season='1987-88';
update results set event='Fort Worth 88', date='3/1/1988', tmp_date='1988-03-01' where event='Fort Worth' and season='1987-88';


-- 88-89
update results set event='Anchorage 88', date='9/1/1988', tmp_date='1988-09-01' where event='Anchorage' and season='1988-89';

update results set event='Anaheim 88', date='10/1/1988', tmp_date='1988-10-01' where event='Anaheim' and season='1988-89';

update results set event='Atlanta 88', date='11/1/1988', tmp_date='1988-11-01' where event='Atlanta' and season='1988-89';

update results set event='Hershey 89', date='1/1/1989', tmp_date='1989-01-01' where event='Hershey' and season='1988-89';

update results set event='Fort Worth 89', date='3/1/1989', tmp_date='1989-03-01' where event='Fort Worth' and season='1988-89';


-- 89-90
update results set event='Colma 89', date='9/1/1989', tmp_date='1989-09-01' where event='Colma' and season='1989-90';

update results set event='Anchorage 89', date='10/1/1989', tmp_date='1989-10-01' where event='Anchorage' and season='1989-90';

update results set event='Anaheim 89', date='11/1/1989', tmp_date='1989-11-01' where event='Anaheim' and season='1989-90';

update results set event='Atlanta 90', date='1/1/1990', tmp_date='1990-01-01' where event='Atlanta' and season='1989-90';

update results set event='Chalfont 90', date='2/1/1990', tmp_date='1990-02-01' where event='Chalfont' and season='1989-90';


-- 90-91

update results set event='Santa Ana 90', date='9/1/1990', tmp_date='1990-09-01' where event='Santa Ana' and season='1990-91';

update results set event='Atlanta 90', date='10/1/1990', tmp_date='1990-10-01' where event='Atlanta' and season='1990-91';

update results set event='St. Louis 90', date='11/1/1990', tmp_date='1990-11-01' where event='St. Louis' and season='1990-91';

update results set event='Anchorage 90', date='12/1/1990', tmp_date='1990-12-01' where event='Anchorage' and season='1990-91';

update results set event='Philadelphia 91', date='1/1/1991', tmp_date='1991-01-01' where event='Philadelphia' and season='1990-91';

update results set event='San Francisco 91', date='2/1/1991', tmp_date='1991-02-01' where event='San Francisco' and season='1990-91';

update results set event='Baltimore 91', date='3/1/1991', tmp_date='1991-03-01' where event='Baltimore' and season='1990-91';


-- 91-92

update results set event='Syracuse 91', date='9/1/1991', tmp_date='1991-09-01' where event='Syracuse?' and season='1991-92';

update results set event='Atlanta 91', date='10/1/1991', tmp_date='1991-10-01' where event='Atlanta' and season='1991-92';

update results set event='Santa Ana 91', date='11/1/1991', tmp_date='1991-11-01' where event='Santa Ana' and season='1991-92';

update results set event='Anchorage 91', date='12/1/1991', tmp_date='1991-12-01' where event='Anchorage' and season='1991-92';

update results set event='Chalfont 92', date='1/1/1992', tmp_date='1992-01-01' where event='Chalfont' and season='1991-92';

update results set event='Toronto 92', date='2/1/1992', tmp_date='1992-02-01' where event='Toronto' and season='1991-92';

update results set event='Baltimore 92', date='3/1/1992', tmp_date='1992-03-01' where event='Baltimore' and season='1991-92';


-- 92-93

update results set event='Chalfont 92', date='9/1/1992', tmp_date='1992-09-01' where event='Chalfont' and season='1992-93';

update results set event='Atlanta 92', date='10/1/1992', tmp_date='1992-10-01' where event='Atlanta' and season='1992-93';

update results set event='Syracuse 92', date='11/1/1992', tmp_date='1992-11-01' where event='Syracuse' and season='1992-93';

update results set event='Baltimore 93', date='1/1/1993', tmp_date='1993-01-01' where event='Baltimore' and season='1992-93';

update results set event='Los Angeles 93', date='2/1/1993', tmp_date='1993-02-01' where event='Los Angeles' and season='1992-93';


-- 93-94


update results set event='Syracuse 93', date='9/1/1993', tmp_date='1993-09-01' where event='Syracuse' and season='1993-94';

update results set event='Arlington 93', date='10/1/1993', tmp_date='1993-10-01' where event='Arlington' and season='1993-94';

update results set event='Chalfont 93', date='11/1/1993', tmp_date='1993-11-01' where event='Chalfont' and season='1993-94';

update results set event='Mayfield 93', date='12/1/1993', tmp_date='1993-12-01' where event='Mayfield' and season='1993-94';

update results set event='Chattanooga 94', date='1/1/1994', tmp_date='1994-01-01' where event='Chattanooga' and season='1993-94';

update results set event='Atlanta 94', date='1/1/1994', tmp_date='1994-01-01' where event='Atlanta' and season='1993-94';

update results set event='Baltimore 94', date='1/1/1994', tmp_date='1994-01-01' where event='Baltimore' and season='1993-94';


-- 94-95

update results set event='Baltimore II 94', date='9/1/1994', tmp_date='1994-09-01' where event='Baltimore' and season='1994-95';

update results set event='Arlington 94', date='11/1/1994', tmp_date='1994-11-01' where event='Arlington' and season='1994-95';

update results set event='Syracuse 95', date='1/1/1995', tmp_date='1995-01-01' where event='Syracuse' and season='1994-95';

update results set event='Baltimore 95', date='3/1/1995', tmp_date='1995-03-01' where event='Baltimore' and season='1994-95';



-- 95-96
update results set event='Baltimore II 95', date='9/1/1995', tmp_date='1995-09-01' where event='Baltimore' and season='1995-96';

update results set event='Los Angeles95', date='10/1/1995', tmp_date='1995-10-01' where event='Los Angeles' and season='1995-96';

update results set event='Manchester 95', date='11/1/1995', tmp_date='1995-11-01' where event='Manchester' and season='1995-96';

update results set event='Chalfont 95', date='12/1/1995', tmp_date='1995-12-01' where event='Chalfont' and season='1995-96';

update results set event='Annapolis 96', date='1/1/1996', tmp_date='1996-01-01' where event='Annapolis' and season='1995-96';

update results set event='Houston 96', date='2/1/1996', tmp_date='1996-02-01' where event='Houston' and season='1995-96';

update results set event='Las Vegas 96', date='3/1/1996', tmp_date='1996-03-01' where event='Las Vegas' and season='1995-96';



-- 96-97
update results set event='Annapolis 96', date='9/1/1996', tmp_date='1996-09-01' where event='Baltimore' and season='1996-97';

update results set event='Canoga Park 96', date='9/15/1996', tmp_date='1996-09-15' where event='Canoga Park' and season='1996-97';

update results set event='Baltimore 96', date='10/1/1996', tmp_date='1996-10-01' where event='Baltimore' and season='1996-97';

update results set event='1st US Open 96', date='11/17/1996', tmp_date='1996-11-17' where event='US Open' and season='1996-97';

update results set event='Denver 96', date='12/1/1996', tmp_date='1996-12-01' where event='Denver' and season='1996-97';

update results set event='Chalfont 97', date='1/1/1997', tmp_date='1997-01-01' where event='Chalfont' and season='1996-97';

update results set event='Roanoke 97', date='2/1/1997', tmp_date='1997-02-01' where event='Roanoke' and season='1996-97';

update results set event='Future Cellular Pro-Am Columbus 97', date='2/23/1997', tmp_date='1997-02-23' where event='Columbus' and season='1996-97';

update results set event='Foxwoods Pro Nationals 97', date='4/27/1997', tmp_date='1997-04-27' where event='Las Vegas' and season='1996-97';

update results set event='Arlington 97', date='5/1/1997', tmp_date='1997-05-01' where event='Arlington' and season='1996-97';

update results set event='Milpitas 97', date='5/15/1997', tmp_date='1997-05-15' where event='Milpitas' and season='1996-97';

update results set event='Spalding IRT Tournament of Champions 97', date='6/8/1997', tmp_date='1997-06-08' where event='Portland' and season='1996-97';


-- 97=98
update results set event='Annapolis 97', date='9/1/1997', tmp_date='1997-09-01' where event='Annapolis' and season='1997-98';

update results set event='Promus Hotel 2nd US Open', date='11/16/1997', tmp_date='1997-11-16' where event='US Open' and season='1997-98';

update results set event='Roanoke 98', date='1/1/1998', tmp_date='1998-01-01' where event='Roanoke' and season='1997-98';

update results set event='New York 98', date='3/1/1998', tmp_date='1998-03-01' where event='New York' and season='1997-98';


------ mid range fixes here due to past data errors

update results set event='Annapolis 96', date='9/1/1996', tmp_date='1996-09-01' where event='Annapolis' and season='1996-97';

update results set event='Annapolis 96', date='9/1/1996', tmp_date='1996-09-01' where event='Annapolis 96' and season='1996-97';

update results set event='Arlington 97', date='5/1/1997', tmp_date='1997-05-01' where event='Arlington 96' and season='1996-97';

update results set event='Baltimore 96', date='10/1/1996', tmp_date='1996-10-01' where event='Baltimore 96' and season='1996-97';

update results set event='1st US Open 96', date='11/17/1996', tmp_date='1996-11-17' where event='Memphis 96' and season='1996-97';

update results set event='Promus Hotel 2nd US Open', date='11/16/1997', tmp_date='1997-11-16' where event='Memphis 97' and season='1997-98';



-- 98-99


update results set event='Baltimore 98', date='9/1/1998', tmp_date='1998-09-01' where event='Baltimore' and season='1998-99';

update results set event='Promus Hotels 3rd US Open 98', date='11/15/1998', tmp_date='1998-11-15' where event='US Open' and season='1998-99';

update results set event='Promus Hotels 3rd US Open 98', date='11/15/1998', tmp_date='1998-11-15' where event='Memphis 98' and season='1998-99';

update results set event='Ralph Schomp Pro-Am 99', date='1/17/1999', tmp_date='1999-01-17' where event='Denver' and season='1998-99';

update results set event='Chalfont 99', date='2/1/1999', tmp_date='1999-02-01' where event='Chalfont' and season='1998-99';

update results set event='Roanoke 99', date='3/1/1999', tmp_date='1999-03-01' where event='Roanoke' and season='1998-99';

update results set event='Roanoke 99', date='3/1/1999', tmp_date='1999-03-01' where event='Roanoke 98' and season='1998-99';

update results set event='Bud Light Pro Nationals 99', date='4/25/1999', tmp_date='1999-04-25' where event='Las Vegas' and season='1998-99';

update results set event='Bud Light Pro Nationals 99', date='4/25/1999', tmp_date='1999-04-25' where event='Las Vegas 98' and season='1998-99';

update results set event='Portland 99', date='5/1/1999', tmp_date='1999-05-01' where event='Portland' and season='1998-99';



-- 99-00
update results set event='Furrs Supermarkets Pro-Am 99', date='10/24/1999', tmp_date='1999-10-24' where event='Albuquerque' and season='1999-00';

update results set event='4th US Open 99', date='12/5/1999', tmp_date='1999-12-05' where event='US Open' and season='1999-00';

update results set event='Denver 00', date='2/1/2000', tmp_date='2000-02-01' where event='Denver' and season='1999-00';

update results set event='Bud Light Irt Pro Nationals 00', date='4/30/2000', tmp_date='2000-04-30' where event='Las Vegas' and season='1999-00';

update results set event='Tournament of Champions 00', date='6/4/2000', tmp_date='2000-06-04' where event='Portland' and season='1999-00';


-- 00-01

update results set event='New Mexico Pro-Am 00', date='10/22/2000', tmp_date='2000-10-22' where event='Albuquerque' and season='2000-01';

update results set event='Colorado Springs 00', date='11/1/2000', tmp_date='2000-11-01' where event='Co Springs' and season='2000-01';

update results set event='Hilton 5th US Open 00', date='11/19/2000', tmp_date='2000-11-19' where event='US Open' and season='2000-01';

update results set event='Denver 00', date='12/1/2000', tmp_date='2000-12-01' where event='Denver' and season='2000-01';

update results set event='Rosarito Beach 01', date='1/1/2001', tmp_date='2001-01-01' where event='Rosarito Beach' and season='2000-01';

update results set event='Watertown 01', date='2/1/2001', tmp_date='2001-02-01' where event='Watertown' and season='2000-01';

update results set event='Michael Lanning Pro-Am 01', date='2/18/2001', tmp_date='2001-02-18' where event='Minneapolis' and season='2000-01';

update results set event='Chicago 01', date='3/1/2001', tmp_date='2001-03-01' where event='Chicago' and season='2000-01';

update results set event='Pro Nationals 01', date='5/6/2001', tmp_date='2001-05-06' where event='Las Vegas' and season='2000-01';

update results set event='Tournament of Champions 01', date='6/3/2001', tmp_date='2001-06-03' where event='Portland' and season='2000-01';


-- 01-02

update results set event='Charlotte 01', date='9/1/2001', tmp_date='2001-09-01' where event='Charlotte' and season='2001-02';

update results set event='Albuquerque 01', date='9/15/2001', tmp_date='2001-09-15' where event='Albuquerque' and season='2001-02';

update results set event='Co Springs 01', date='10/1/2001', tmp_date='2001-10-01' where event='Co Springs' and season='2001-02';

update results set event='Hilton 6th US Open 01', date='11/20/2001', tmp_date='2001-11-20' where event='US Open' and season='2001-02';

update results set event='Saskatoon 01', date='12/1/2001', tmp_date='2001-12-01' where event='Saskatoon' and season='2001-02';

update results set event='Denver 01', date='12/15/2001', tmp_date='2001-12-15' where event='Denver' and season='2001-02';

update results set event='Rosarito Beach 02', date='1/1/2002', tmp_date='2002-01-01' where event='Rosarito Beach' and season='2001-02';

update results set event='Chicago 02', date='1/15/2002', tmp_date='2002-01-15' where event='Chicago' and season='2001-02';

update results set event='Minneapolis 02', date='2/1/2002', tmp_date='2002-02-01' where event='Minneapolis' and season='2001-02';

update results set event='San Diego Open 02', date='3/3/2002', tmp_date='2002-03-03' where event='San Diego' and season='2001-02';

update results set event='Pro Nationals 02', date='5/12/2002', city='Fountain Valley, CA', tmp_date='2002-05-12' where event='Pro Nationals' and season='2001-02';

update results set event='McLean 02', date='4/1/2002', tmp_date='2002-04-01' where event='Mclean, VA' and season='2001-02';


-- 02-03

update results set event='Rosarito Beach 02 again', date='9/1/2002', tmp_date='2002-09-01' where event='Rosarito Beach' and season='2002-03';

update results set event='Charlotte 02', date='10/1/2002', tmp_date='2002-10-01' where event='Charlotte' and season='2002-03';

update results set event='Albuquerque 02', date='10/15/2002', tmp_date='2002-10-15' where event='Albuquerque' and season='2002-03';

update results set event='Co Springs 02', date='11/1/2002', tmp_date='2002-11-01' where event='Co Springs' and season='2002-03';

update results set event='Choice Hotels 7th US Open 02', date='11/24/2002', tmp_date='2002-11-24' where event='US Open' and season='2002-03';

update results set event='Denver 02', date='12/1/2002', tmp_date='2002-12-01' where event='Denver' and season='2002-03';

update results set event='Cincinnati 03', date='1/1/2003', tmp_date='2003-01-01' where event='Cincinnati' and season='2002-03';

update results set event='San Diego Open 03', date='3/2/2003', tmp_date='2003-03-02' where event='San Diego' and season='2002-03';

update results set event='Nashville 03', date='3/15/2003', tmp_date='2003-03-15' where event='Nashville' and season='2002-03';

update results set event='Baltimore 03', date='4/1/2003', tmp_date='2003-04-01' where event='Baltimore' and season='2002-03';

update results set event='Saskatoon 03', date='4/15/2003', tmp_date='2003-04-15' where event='Saskatoon' and season='2002-03';

update results set event='Pro Nationals 03', date='5/4/2003', tmp_date='2003-05-04' where event='Tempe' and season='2002-03';



-- 03-04

update results set event='Rosarito Beach 03', date='9/1/2003', tmp_date='2003-09-01' where event='Rosarito Beach' and season='2003-04';

update results set event='Charlotte 03', date='10/1/2003', tmp_date='2003-10-01' where event='Charlotte' and season='2003-04';

update results set event='Albuquerque 03', date='10/15/2003', tmp_date='2003-10-15' where event='Albuquerque' and season='2003-04';

update results set event='Choice Hotels 8th US Open 03', date='11/23/2003', tmp_date='2003-11-23' where event='US Open' and season='2003-04';

update results set event='Hawaii 03', date='12/1/2003', tmp_date='2003-12-01' where event='Hawaii' and season='2003-04';

update results set event='Coral Springs 04', date='1/1/2004', tmp_date='2004-01-01' where event='Coral Springs' and season='2003-04';

update results set event='Chicago 04', date='2/1/2004', tmp_date='2004-02-01' where event='Chicago' and season='2003-04';

update results set event='Nashville 04', date='3/1/2004', tmp_date='2004-03-01' where event='Nashville' and season='2003-04';

update results set event='Tempe 04', date='4/1/2004', tmp_date='2004-04-01' where event='Tempe' and season='2003-04';


-- 04-05

update results set event='Rosarito Beach 04', date='9/1/2004', tmp_date='2004-09-01' where event='Rosarito Beach' and season='2004-05';

update results set event='Gaithersburg 04', date='10/1/2004', tmp_date='2004-10-01' where event='Gaithersburg' and season='2004-05';

update results set event='Choice Hotels 9th US Open 04', date='11/21/2004', tmp_date='2004-11-21' where event='US Open' and season='2004-05';

update results set event='Stockton 05', date='1/1/2005', tmp_date='2005-01-01' where event='Stockton' and season='2004-05';

update results set event='Miami 05', date='2/1/2005', tmp_date='2005-02-01' where event='Miami' and season='2004-05';

update results set event='Nashville 05', date='3/1/2005', tmp_date='2005-03-01' where event='Nashville' and season='2004-05';

update results set event='Atlanta 05', date='4/1/2005', tmp_date='2005-04-01' where event='Atlanta' and season='2004-05';



-- 05-06

update results set event='Rosarito Beach 05', date='9/1/2005', tmp_date='2005-09-01' where event='Rosarito Beach' and season='2005-06';

update results set event='Albuquerque 05', date='10/1/2005', tmp_date='2005-10-01' where event='Albuquerque' and season='2005-06';

update results set event='Choice Hotels 10th US Open 05', date='11/20/2005', tmp_date='2005-11-20' where event='US Open' and season='2005-06';

update results set event='Miami 06', date='2/1/2006', tmp_date='2006-02-01' where event='Miami' and season='2005-06';

update results set event='Boise 06', date='3/1/2006', tmp_date='2006-03-01' where event='Boise' and season='2005-06';

update results set event='Greensboro 06', date='4/1/2006', tmp_date='2006-04-01' where event='Greensboro' and season='2005-06';


-- 06-07

update results set event='Arlington 06', date='9/1/2006', tmp_date='2006-09-01' where event='Arlington' and season='2006-07';

update results set event='Denver 06', date='10/1/2006', tmp_date='2006-10-01' where event='Denver' and season='2006-07';

update results set event='Fayetteville 06', date='11/1/2006', tmp_date='2006-11-01' where event='Fayetteville' and season='2006-07';

update results set event='New Orleans 06', date='12/1/2006', tmp_date='2006-12-01' where event='New Orleans' and season='2006-07';

update results set event='Miami 07', date='1/1/2007', tmp_date='2007-01-01' where event='Miami' and season='2006-07';

update results set event='Seattle 07', date='2/1/2007', tmp_date='2007-02-01' where event='Seattle' and season='2006-07';

update results set event='Stockton 07', date='3/1/2007', tmp_date='2007-03-01' where event='Stockton' and season='2006-07';

update results set event='Toronto 07', date='4/1/2007', tmp_date='2007-04-01' where event='Toronto' and season='2006-07';

-- 07-08

update results set event='Fayetteville 07', date='9/1/2007', tmp_date='2007-09-01' where event='Fayetteville' and season='2007-08';

update results set event='Canadian Racquetball Classic 07', date='10/14/2007', tmp_date='2007-10-14' where event='Toronto' and season='2007-08';

update results set event='Choice Hotels 12th US Open 07', date='11/18/2007', tmp_date='2007-11-18' where event='US Open' and season='2007-08';

update results set event='Arlington 07', date='12/1/2007', tmp_date='2007-12-01' where event='Arlington' and season='2007-08';

update results set event='Panama 08', date='1/1/2008', tmp_date='2008-01-01' where event='Panama' and season='2007-08';

update results set event='Sacramento 08', date='2/1/2008', tmp_date='2008-02-01' where event='Sacramento' and season='2007-08';

update results set event='Phoenix 08', date='3/1/2008', tmp_date='2008-03-01' where event='Phoenix' and season='2007-08';

update results set event='Miami 08', date='4/1/2008', tmp_date='2008-04-01' where event='Miami' and season='2007-08';

update results set event='York 08', date='5/1/2008', tmp_date='2008-05-01' where event='York' and season='2007-08';

update results set event='New Orleans 08', date='6/1/2008', tmp_date='2008-06-01' where event='New Orleans' and season='2007-08';



-- 08-09

update results set event='Fayetteville 08', date='9/1/2008', tmp_date='2008-09-01' where event='Fayetteville' and season='2008-09';

update results set event='Tijuana 08', date='10/1/2008', tmp_date='2008-10-01' where event='Tijuana' and season='2008-09';

update results set event='Edmonton', date='10/15/2008', tmp_date='2008-10-15' where event='Edmonton' and season='2008-09';

update results set event='13th US Open Racquetball Championships 08', date='10/26/2008', tmp_date='2008-10-26' where event='US Open' and season='2008-09';

update results set event='Arlington 08', date='12/1/2008', tmp_date='2008-12-01' where event='Arlington' and season='2008-09';

update results set event='Miami 09', date='1/1/2009', tmp_date='2009-01-01' where event='Miami' and season='2008-09';

update results set event='York 09', date='1/1/2009', tmp_date='2009-01-01' where event='York' and season='2008-09';

update results set event='Gaithersburg 09', date='1/1/2009', tmp_date='2009-01-01' where event='Gaithersburg' and season='2008-09';




===============================

-- cities:

select city,count(*) from results group by city order by 1;


update results set city='Lombard, IL' where city='Lombard,IL';

update results set city='McLean, VA' where city='Mclean, VA';




-- seasons:

select * from results where season like '1980%';

select * from results where event='Bloomingdale 81';

update results set season='1980-81' where event='Bloomingdale 81';




-- Fixing tour name
update results set tour='NRC' where tmp_date <= '1980-04-01';

update results set tour='WPRA' where tmp_date >= '1980-09-01' and tmp_date <= '1995-01-01';

update results set tour='WIRT' where tmp_date >='1995-09-01' and tmp_date <= '2000-06-04';

update results set tour='LPRA' where tmp_date >='2000-10-22' and tmp_date <= '2005-04-01';

update results set tour='WPRO' where tmp_date >='2005-09-01' and tmp_date <= '2009-01-01';

-- no need to update for LPRT: current and good as of 8/26/12

select * from results where tour is null;



---------


create table results_20161129 as select * from results;

select * from results order by tmp_date;

select * from results 
-- where season='1976-77' 
where round=2 order by tmp_date,round desc;

select event, count(*) from results group by event order by 2 desc;

----
-- Fixes to results data from Linda Mojer's data.

update results set score='19,(18),5', date='6/1/1976' where event='NRC DP/Leach Nationals 76' and tmp_date='1976-06-01' and round=2;

update results set score=null, date='6/1/1976' where event='NRC DP/Leach Nationals 76' and tmp_date='1976-06-01' and round<> 2;

update results set event='Sacramento 76' where event='Sacramento 77';

update results set score='17,13' where event='Houston 77' and round=2;

update results set score='(5),18, 6' where event='Denver 77' and round=2;

update results set date='9/1/1979', event='King of Prussia 78', tmp_date='1978-09-01' where event='King of Prussia 79';

update results set date='4/1/1980', tmp_date='1980-04-01' where event='Winnipeg 80';

-- Fixing all 80-81 dates to be in correct order

update results set date='9/1/1980', event='Newport Beach 80', tmp_date='1980-09-01' where event='Newport Beach 81';

update results set date='10/1/1980', tmp_date='1980-10-01' where event='Escondido 80';

update results set date='11/1/1980', tmp_date='1980-11-01' where event='Boise 80';

update results set date='3/1/1981', tmp_date='1981-03-01', event='Federal Way 81' where event='Federal Way 80';

update results set date='4/15/1981', tmp_date='1981-04-15'  where event='Palantine 81';

update results set date='5/1/1981', tmp_date='1981-05-01'  where event='Fishkill 81';

update results set date='6/1/1981', tmp_date='1981-06-01', event='Columbus 81'  where event='Columbus 80';

-- Fixing all 81-82 dates to be in correct order

update results set date='9/1/1981', tmp_date='1981-09-01', event='Warwick 81'  where event='Warwick 82';

update results set date='10/1/1981', tmp_date='1981-10-01', event='Palantine 81'  where event='Palantine 82';

update results set date='11/1/1981', tmp_date='1981-11-01', event='Fishkill Fall 81'  where event='Fishkill 82';

update results set date='11/15/1981', tmp_date='1981-11-15', event='Columbus 81'  where event='Columbus 81';

update results set date='12/1/1981', tmp_date='1981-12-01', event='Federal Way 81'  where event='Federal Way 81';

update results set date='1/1/1982', tmp_date='1982-01-01', event='Bangor 82'  where event='Bangor 81';

update results set date='2/1/1982', tmp_date='1982-02-01', event='Lombard 82'  where event='Lombard 82';

update results set date='6/1/1982', tmp_date='1982-06-01', event='Denver 82'  where event='Denver 81';

-- trying to fix specifically double counting of fishkill

select * from results where event='Fishkill Fall 81';

delete from results where event='Fishkill Fall 81' and round > 2;

update results set event='Fishkill Spring 82' where event='Fishkill Fall 81' and winner='Adams, Lynn';

update results set date='3/1/1982', tmp_date='1982-03-01'  where event='Fishkill Spring 82';

update results set date='3/1/94', tmp_date='1994-03-01'  where event='Atlanta 94';

update results set date='4/1/94', tmp_date='1994-04-01'  where event='Chattanooga 94';

update results set date='5/1/94', tmp_date='1994-05-01', event='Baltimore Spring 94' where event='Baltimore 94' and tmp_date='1994-01-01';


select * from results where event='Baltimore II 94';

update results set event='Baltimore Fall 94' where event='Baltimore 94';

update results set event='Baltimore Spring 95', date='5/1/95', tmp_date='1995-05-01' where event='Baltimore II 94';

update results set event='Baltimore Fall 95' where event='Baltimore II 95';

update results set event='Los Angeles 95' where event='Los Angeles95';

select * from results 
where season = '2008-09' 
order by tmp_date;

update results set event='Baltimore 96', date='10/1/1996', tmp_date='1996-10-01' where season='1996-97' and city='Baltimore, MD';

update results set event='Lakewood 01', city='Lakewood, CO' where event='Denver 01';

select * from results where city like 'Rosarito%';

update results set city='Rosarito Beach, MEX' where city = 'Rosarito Beach, CA';

update results set event='Rosarito Beach Spring 02' where season ='2001-02' and event='Rosarito Beach 02';

update results set event='Rosarito Beach Fall 02' where season='2002-03' and event='Rosarito Beach 02 again';

update results set event='Edmonton 08' where season='2008-09' and event='Edmonton';

update results set event='York 09', date='2/1/2009', tmp_date='2009-02-01' where event='York 09';

update results set event='Miami 09', date='3/1/2009', tmp_date='2009-03-01' where event='Miami 09';

------------------

update results set date='9/23/2001', tmp_date='2001-09-23' where event='Charlotte 01';

update results set date='10/21/2016', tmp_date='2001-10-21' where event='Albuquerque 01';




use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

-- Fixes to rankings post loading

select distinct(player) from rankings where player like '%Kristen%';

select * from rankings where player like '%Paz%';

select * from results where loser like '%Allen%';

update rankings set player='Munoz, Maria Paz' where player='Paz, Maria' and season='2009-10';

select * from results where winner like '%Anderson%';

select * from results where winner like '%Lynch%' or loser like '%Lynch%';

select * from results where winner='Carplo, Jvonne' or loser='Carplo, Jvonne';


select player,count(*) from rankings group by player order by 2 desc;

select * from seedings where player like '%Lynch%';

select * from rankings where season='1999-00';

update rankings set rank=34 where player='Torres, Lupita' and season='1999-00';

delete from rankings_source where season='1999-00';

insert into rankings_source (season,source) values ('1999-00','RM july-aug 2000, irt-tour.com WIRT final season rankings via archive.org');





-- fixing age based queries for LPRT data


use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

select * from player_profile order by player;

select dob,tmp_dob from player_profile where player = 'Rajsich, Rhonda';

select distinct(winner) from results where round=2 order by winner;


select * from results where date='5/1/94';

select distinct date from results order by date;

SELECT STR_TO_DATE(date, '%m/%d/%Y') from results order by 1;

select * from results where event='Albuquerque 01';


select * from tour_champions;



-- need 4-year dates in Results or else age queries don't work right.

update results set date='10/15/1976' where date='10/15/76';

update results set date='5/1/1994' where date='5/1/94';

update results set date='4/1/1994' where date='4/1/94';

update results set date='3/1/1994' where date='3/1/94';

update results set date='5/1/1995' where date='5/1/95';

update results set date='10/21/2001' where event='Albuquerque 01';



--- as we add tourneys, here's code to clean out old results.


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

