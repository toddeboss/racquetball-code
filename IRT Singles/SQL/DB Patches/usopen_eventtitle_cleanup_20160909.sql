/* 
filename: usopen_eventtitle_cleanup_20160909.sql
purpose: SQL to clean up the tour names for US Opens

modification history
when	who	what
9/9/16	tboss	creation

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/


-- Cleaning up US Open titles.

select distinct(event) from results where city='Memphis, TN' order by 1;

select * from results where event like '%US Open%' order by tmp_date asc;

select * from results where event='4th US Open';

update results set event='Choice Hotels 10th US Open' where event='10th Choice Hotels US Open';

update results set event='Choice Hotels 11th US Open' where event='11th Choice Hotels US Open';

update results set event='Choice Hotels 12th US Open' where event='2007 Choice Hotels US Open';

update results set event='United Healthcare 17th US Open' where event='2012 United Healthcare US Open';

update results set event='United Healthcare 18th US Open' where event='2013 United Healthcare US Open';

update results set event='United Healthcare 19th US Open' where event='2014 United Healthcare US Open';

