-- updating 1988 finals from https://www.youtube.com/watch?v=IE_VUwzi5ks


select * from results_doubles where event='1988 21st US National Doubles Championships - Mens Open';

update results_doubles set loser_p1='Hansen, Tim', loser_p2='Gonzales, Sergio' where event='1988 21st US National Doubles Championships - Mens Open'
and round=2;

update results_doubles set score='5,(8),10' where event='1988 21st US National Doubles Championships - Mens Open' and round=2;


commit;