/* 
filename: sp_fixname.sql
purpose: SQL to clean up all player names in all four major tables.

modification history
when	who	what
12/9/16	tboss	created, implemented in all three pro databases
10/23/17 tboss	created IRF version, which comments out rankings.
10/10/18 tboss	just the rydf version

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- this version goes in IRF, Amateur, Juniors
-- singles only, no rankings



-- full ddl
USE `cp30725_prs`;
DROP procedure IF EXISTS `sp_fixname`;

DELIMITER $$
USE `cp30725_prs`$$
CREATE PROCEDURE `sp_fixname` (in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   -- update results set winner=newname where winner=oldname;
   -- update results set loser=newname where loser=oldname;
   -- update seedings set player=newname where player=oldname;
   -- update rankings set player=newname where player=oldname;
   -- update cp30725_prs.player_profile set player=newname where player=oldname;
   update cp30725_prs.team_rydf set player=newname where player=oldname;
END$$

DELIMITER ;

