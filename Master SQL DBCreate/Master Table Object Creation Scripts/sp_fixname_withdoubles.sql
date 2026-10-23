/* 
filename: sp_fixname.sql
purpose: SQL to clean up all player names in all four major tables.

modification history
when	who	what
12/9/16	tboss	created, implemented in all three pro databases
10/23/17 tboss	created IRF version, which comments out rankings.

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- this version goes in IRT, LPRT, WRT
-- needs singles, doubles and rankings


-- full ddl
USE `cp30725_men`;
DROP procedure IF EXISTS `sp_fixname`;

DELIMITER $$
USE `cp30725_men`$$

CREATE PROCEDURE `sp_fixname` (in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set winner=newname where winner=oldname;
   update results set loser=newname where loser=oldname;
   update seedings set player=newname where player=oldname;
   update rankings set player=newname where player=oldname;
   update cp30725_prs.player_profile set player=newname where player=oldname;
   update results_doubles set winner_p1=newname where winner_p1=oldname;   
   update results_doubles set winner_p2=newname where winner_p2=oldname;   
   update results_doubles set loser_p1=newname where loser_p1=oldname;   
   update results_doubles set loser_p2=newname where  loser_p2=oldname;      
   update seedings_doubles set player1=newname where player1=oldname;
   update seedings_doubles set player2=newname where player2=oldname;  
END$$

DELIMITER ;

