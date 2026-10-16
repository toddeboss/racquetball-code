-- 1987 USA national finals from John Foust face book post

select * from results_doubles where event='1987 20th US National Doubles Championships - Mens Open';

create table results_doubles_20201213 as select * from results_doubles;

update results_doubles 
set loser_p1='Roberts, Andy', loser_p2='Anthony, Tim', score='13,10'
where event='1987 20th US National Doubles Championships - Mens Open';

select * from results_doubles where event='1987 20th US National Doubles Championships - Womens Open';

update results_doubles 
set loser_p1='Green, Diane', loser_p2='Pinnell, Julia', score='11,(14),5'
where event='1987 20th US National Doubles Championships - Womens Open';

select * from results_doubles;

insert into results_doubles values
('Obremski, Dan','Bevelock, Toni','Rodriguez, Bobby','Rasmussen, Trina',2,'(14),10,1','USA Mixed Open','Tempe, AZ',
'1987 20th US National Doubles Championships - Mixed Open', '10/1/1987','John Foust facebook post Dec 2020','1987','','1987-10-01');


commit;