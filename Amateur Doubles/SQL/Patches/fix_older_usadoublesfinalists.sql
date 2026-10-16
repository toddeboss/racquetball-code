
/*
2001 losing finalists: Pointelin/Llacera
2000 losing finalists: Ruben/Guidry
1999 losing finalists: Roberts/Karp
*/

select * from results_doubles where event='1999 32nd US National Doubles Championships - Mens Open';

create table results_doubles_20191118 as select * from results_doubles;

update results_doubles set loser_p1='Roberts, Andy', loser_p2='Karp, Adam' 
where event='1999 32nd US National Doubles Championships - Mens Open' and round=2;


update results_doubles set loser_p1='Gonzalez, Ruben', loser_p2='Guidry, Mike' 
where event='2000 33rd US National Doubles Championships - Mens Open' and round=2;

update results_doubles set loser_p1='Pointelin, Brian', loser_p2='Llacera, Dan' 
where event='2001 34th US National Doubles Championships - Mens Open' and round=2;

commit;
