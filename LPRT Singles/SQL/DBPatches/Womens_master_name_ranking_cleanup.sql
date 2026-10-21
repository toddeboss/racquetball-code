/* 
filename: Womens_master_name_ranking_cleanup.sql
purpose: SQL to clean up the womens names in results

modification history
when	who	what
10/22/16	tboss	creation
12/1/16 tboss	saving more cleanup

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/


-- LPRT master name cleanup in rankings table

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;


-- also need to clean up rankings...

select * from rankings



