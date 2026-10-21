/* 11/1/08: doing event name maintenance for consistency and for
querying based on major flag */

-- to distinguish this one-time major from the 1974 version by same name 
select * from results where event='Chicago Open' and season ='2004-5';

update results set event='2004 Chicago Open' where event='Chicago Open' and season ='2004-5';
update tourneys set event='2004 Chicago Open' where event='Chicago Open' and season ='2004-5';