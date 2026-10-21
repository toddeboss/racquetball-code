/* 
filename: tour_name_cleanup_20160909.sql
purpose: SQL to clean up the tour names

modification history
when	who	what
9/9/16	tboss	creation

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- working sql here: change as needed

use cp30725_men;

SET SQL_SAFE_UPDATES = 0;

create table results_20160909 as select * from results;

select tour, count(*) from results group by tour order by tour;

select * from results where tour like 'IRA%' and tour not in ('IRA');

select * from results where tour = 'USRA';

/* --------------- */

update results set event='IRA Louisville 74', tour='IRA' where tour='IRA-1';

update results set event='IRA San Carlos 74', tour='IRA' where tour='IRA-2';

update results set event='IRA Tanner Pro-Am 74', tour='IRA' where tour='IRA-3';

update results set event='IRA Dallas 75', tour='IRA' where tour='IRA-4';

update results set event='IRA Houston 75', tour='IRA' where tour='IRA-5';

update results set event='IRA Nationals 75', tour='IRA' where tour='IRA-6';

update results set event='IRA Tanner Pro-Am 75', tour='IRA' where tour='IRA-7';

update results set event='IRA San Antonio 76', tour='IRA' where tour='IRA-8';

update results set tour='IRT' where tour='z';

update results set tour='NRC' where tour='NRC-COL';

update results set tour='NRC' where tour='NRC-COLGAT';


