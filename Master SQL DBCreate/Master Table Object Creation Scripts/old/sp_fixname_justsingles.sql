/* 
filename: sp_fixname.sql
purpose: SQL to clean up all player names in all four major tables.

modification history
when	who	what
12/9/16	tboss	created, implemented in all three pro databases

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- raw code
CREATE PROCEDURE `sp_fixname` (in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set winner=newname where winner=oldname;
   update results set loser=newname where loser=oldname;
   update seedings set player=newname where player=oldname;
   update rankings set player=newname where player=oldname;
   update player_profile set player=newname where player=oldname;
END

-- converted by mysql code
CREATE DEFINER=`cp30725_lprt`@`173.227.253.204` PROCEDURE `sp_fixname`(in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set winner=newname where winner=oldname;
   update results set loser=newname where loser=oldname;
   update seedings set player=newname where player=oldname;
   update rankings set player=newname where player=oldname;
   update player_profile set player=newname where player=oldname;
END


-- full ddl
USE `cp30725_wrt`;
DROP procedure IF EXISTS `sp_fixname`;

DELIMITER $$
USE `cp30725_wrt`$$
CREATE PROCEDURE `sp_fixname` (in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set winner=newname where winner=oldname;
   update results set loser=newname where loser=oldname;
   update seedings set player=newname where player=oldname;
   update rankings set player=newname where player=oldname;
   update player_profile set player=newname where player=oldname;
END$$

DELIMITER ;

