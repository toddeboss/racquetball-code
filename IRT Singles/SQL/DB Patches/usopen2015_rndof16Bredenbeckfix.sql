/* 
filename: usopen2015_rndof16Bredenbeckfix.sql
purpose: sql to fix a bad result in the database for the 2015 US OPen

modification history
when		who	what
8/2/16	tboss	creation and patched in database.


Usage: n/a: onetime run of script into MySQL database

Prerequisites to run: none

Other notes: from conversation with Felipe Mercado on facebook 6/1/16

*/

use cp30725_men;

create table results_20160802 as select * from results;

select * from results where event='20th United Healthcare US Open' and round=16;

update results set winner='Rojas, Marco' where event='20th United Healthcare US Open' and round=16 and winner='Bredenbeck, Jake';

update results set loser='Bredenbeck, Jake' where event='20th United Healthcare US Open' and round=16 and loser='Rojas, Marco';