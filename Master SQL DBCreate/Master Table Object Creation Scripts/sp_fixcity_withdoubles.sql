/* 
filename: sp_fixcity.sql
purpose: SQL to clean up all city names in results and tourneys tables

modification history
when	who	what
12/6/18	tboss	creation, adapted from sp_fixnames.

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- this version goes in IRT, LPRT, WRT
-- needs singles, doubles and rankings


-- full ddl
USE `cp30725_men`;
DROP procedure IF EXISTS `sp_fixcity`;

DELIMITER $$
USE `cp30725_men`$$

CREATE PROCEDURE `sp_fixcity` (in newcity varchar(100), in oldcity varchar(100))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set city=newcity where city=oldcity;
   update tourneys set city=newcity where city=oldcity;
   update results_doubles set city=newcity where city=oldcity;
   update tourneys_doubles set city=newcity where city=oldcity;
 
END$$

DELIMITER ;

