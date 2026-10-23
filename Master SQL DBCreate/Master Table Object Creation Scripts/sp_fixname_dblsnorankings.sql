-- this version goes in WOR, Amateur
-- singles, doubles no rankings

-- full ddl
USE `cp30725_wor`;
DROP procedure IF EXISTS `sp_fixname`;

DELIMITER $$
USE `cp30725_wor`$$

CREATE PROCEDURE `sp_fixname` (in newname varchar(50), in oldname varchar(50))
BEGIN
   SET SQL_SAFE_UPDATES = 0;
   update results set winner=newname where winner=oldname;
   update results set loser=newname where loser=oldname;
   update seedings set player=newname where player=oldname;
   -- update rankings set player=newname where player=oldname;
   update cp30725_prs.player_profile set player=newname where player=oldname;
   update results_doubles set winner_p1=newname where winner_p1=oldname;   
   update results_doubles set winner_p2=newname where winner_p2=oldname;   
   update results_doubles set loser_p1=newname where loser_p1=oldname;   
   update results_doubles set loser_p2=newname where  loser_p2=oldname;      
   update seedings_doubles set player1=newname where player1=oldname;
   update seedings_doubles set player2=newname where player2=oldname;  
END$$

DELIMITER ;

