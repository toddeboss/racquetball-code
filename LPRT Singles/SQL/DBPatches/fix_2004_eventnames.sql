-- fixing some 2004 event names per may/june 2004

SET SQL_SAFE_UPDATES = 0;

select * from results where event='Nashville 04';

update results set event='2004 LPRA Slamrock Shootout' where event='Nashville 04';

update tourneys set event='2004 LPRA Slamrock Shootout' where event='Nashville 04';

update seedings set event='2004 LPRA Slamrock Shootout' where event='Nashville 04';

commit;
 
update results set event='2004 LPRA Pro Nationals' where event='Tempe 04';

update tourneys set event='2004 LPRA Pro Nationals' where event='Tempe 04';

update seedings set event='2004 LPRA Pro Nationals' where event='Tempe 04'; 

commit;