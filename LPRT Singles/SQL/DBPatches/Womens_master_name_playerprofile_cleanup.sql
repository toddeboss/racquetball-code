/* 
filename: Womens_master_name_playerprofile_cleanup.sql
purpose: SQL to clean up the womens names in player_profile

modification history
when	who	what
12/1/16	tboss	creation, adapted from master results names cleanup.
12/8/16: tboss	putting all name cleanup commands in ONE place.  Results, rankings, seedings, player_profile.

12/9/16: this is now obsolete.


Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/


-- LPRT master name cleanup

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

-- create table player_profile_prenamecleanup_20161202 as select * from player_profile;





update player_profile set player='Carpio, Ivonne' where player='Carplo, Jvonne';

update player_profile set player='Haynes (Fisher), Adrienne' where player='Fisher, Adrienne';

update player_profile set player='Haynes (Fisher), Adrienne' where player='Haynes, Adrienne';

update player_profile set player='Drexler (Greer), Marci' where player='Greer, Marci';

update player_profile set player='Drexler (Greer), Marci' where player='Drexler, Marci';

update player_profile set player='Gudinas, Cheryl' where player='Gudinas Holmes, Cheryl';

update player_profile set player='Gudinas, Cheryl' where player='Gudinas-Holmes, Cheryl';

update player_profile set player='Guillemette, Veronique' where player='Guillemette, Vernoique';

update player_profile set player='Kwon, Marie Malhee' where player='Kwon, Malhee';

update player_profile set player='Loredo, Arantza' where player='Lored, Arantza';

update player_profile set player='Pimentelli, Devon' where player='Pinentelli, Devon';


update player_profile set player='Paraiso, Jackie' where player='Paraiso-Gibson, Jackie';

update player_profile set player='Paraiso, Jackie' where player='Gibson, Jackie';

update player_profile set player='Paraiso, Jackie' where player='Rice, Jackie';

update player_profile set player='Paraiso, Jackie' where player='Paraiso Rice, Jackie';

update player_profile set player='Paraiso, Jackie' where player='Paraiso-Rice, Jackie';

update player_profile set player='Paraiso, Jackie' where player='Rice, Jackie Paraiso';





-- Not bothering with this one since she retired before marrying?  Should probably fix.
-- update player_profile set player='Waselenchuk (Russell), Kim' where player='Russell, Kim';
-- update player_profile set player='Waselenchuk (Russell), Kim' where player='Waselenchuk, Kim';

update player_profile set player='Russell, Kim' where player='Waselenchuk, Kim';

update player_profile set player='Solis, Samantha Salas' where player='Salas, Samantha';

update player_profile set player='Solis, Samantha Salas' where player='Solis, Samantha Salis';


-- She played before and after marriage, so fix.
-- update player_profile set player='Van Hees, Christie' where player='Huczek, Christie';

update player_profile set player='Huczek (Van Hees), Christie' where player='Van Hees, Christie';
update player_profile set player='Huczek (Van Hees), Christie' where player='Huczek, Christie';
update player_profile set player='Huczek (Van Hees), Christie' where player='Van Hees, Christie';



update player_profile set player='Van Hees, Christie' where player='Van, Christie';

update player_profile set player='Van Hees, Christie' where player='Van-Hees, Christie';

update player_profile set player='Wachtel (Stoffregen), Kerri' where player='Wachtel, Kerri';

update player_profile set player='Wachtel (Stoffregen), Kerri' where player='Stoffregen, Kerri';

update player_profile set player='Warhftig, Sarah' where player='Warhaftig, Sarah';


update player_profile set player='Lucas (Wiragh), Michelle' where player='Wiragh, Michelle';

update player_profile set player='Lucas (Wiragh), Michelle' where player='Lucas, Michelle';

update player_profile set player='Wright-Hamilton, Shannon' where player='Wright, Shannon';

update player_profile set player='Ruiz (Roehler), Aimee' where player='Roehler, Aimee';

update player_profile set player='Ruiz (Roehler), Aimee' where player='Ruiz, Aimee';

update player_profile set player='Take (Tisinger), Janel' where player='Tisinger, Janel';

update player_profile set player='Bellows (Walsh), Kristen' where player='Walsh, Kristen';

update player_profile set player='Bellows (Walsh), Kristen' where player='Bellows, Kristen';

update player_profile set player='Bellows (Walsh), Kristen' where player='Walsh, Kristin';



update player_profile set player='Gould (Gilman), Michelle' where player='Gould, Michelle';

update player_profile set player='Gould (Gilman), Michelle' where player='Gilman, Michelle';

update player_profile set player='Gould (Gilman), Michelle' where player='Gilman-Gould, Michelle';

update player_profile set player='Gould (Gilman), Michelle' where player='Gilman Gould, Michelle';

-- Not bothering with this one since she retired before marrying?
-- update player_profile set player='Conine (Doyle), Cindy' where player='Doyle, Cindy';

-- Bailey, Malia from  Malia Kamahoahoa Bailey
update player_profile set player='Bailey, Malia' where player='Bailey Kamahoahoa, Malia';

update player_profile set player='Kelly (Fischl), Dottie' where player='Fischl, Dottie';

update player_profile set player='Kelly (Fischl), Dottie' where player='Fischl Kelly, Dottie';

update player_profile set player='Kelly (Fischl), Dottie' where player='Kelly, Dottie';

-- married dec 2014
update player_profile set player='Thomas (Irons), Kimberly' where player='Irons, Kimberly';

-- married Mar2014?
update player_profile set player='Soley (Rascon), Sofia' where player='Rascon, Sofia';

update player_profile set player='Soley (Rascon), Sofia' where player='Soley, Sofia';


-- married as of mid 2013
update player_profile set player='Kirch (OBrien), Aubrey' where player='O''Brien, Aubrey';

update player_profile set player='Kirch (OBrien), Aubrey' where player='OBrien, Aubrey';

update player_profile set player='Kirch (OBrien), Aubrey' where player='Kirch, Aubrey';


update player_profile set player='Lee, Young Ock' where player='Lee, Youngock';

update player_profile set player='Lee, Young Ock' where player='Youngcock, Lee';


update player_profile set player='Feaster, Shannon' where player='Feaster-Stewart, Shannon';

update player_profile set player='Shattuck, Jo' where player='Shattuck, Johanna';

-- Hostovich, Candi: not updating since played before marriage; now is Candi Linkous

update player_profile set player='Lambert, Frederique' where player='Lambert, Frederique T.';


-- Lots of variations for Kristen Fritz

update player_profile set player='Jones (Fritz), Kristen' where player='Fritz, Kristen';

update player_profile set player='Jones (Fritz), Kristen' where player='Junkin, Kristen';

update player_profile set player='Jones (Fritz), Kristen' where player='Fritz Junkin, Kristen';

update player_profile set player='Jones (Fritz), Kristen' where player='Junkin (Fritz), Kristen';

update player_profile set player='Jones (Fritz), Kristen' where player='Junkin Jones, Kristen';


update player_profile set player='Amaya, Cristina' where player='Amaya, Christina';

update player_profile set player='Barriga, Loreto' where player='Barriga, Loreta';

update player_profile set player='Vargas, Maria Jose' where player='Vargas, Maria';

update player_profile set player='Vargas, Maria Jose' where player='Jose Maria, Vargas';

update player_profile set player='Vargas, Maria Jose' where player='Jose Maria, Vargas';


update player_profile set player='Nunez, Ana Paola' where player='Nunez, Paola';

update player_profile set player='Nunez, Ana Paola' where player='Nunez, Ana';


-- Keri Allen vs Kerri Allen: went iwth Kerri
update player_profile set player='Allen, Kerri' where player='Allen, Keri';

update player_profile set player='Anderson, Dana' where player='Anderson, Dyan';

update player_profile set player='Andrade, Claudia' where player='Andrade, Claudio';

update player_profile set player='Beltranena, Elissa' where player='Beltranena, Alissa';


-- run from here; below here are NOT in master results database
update player_profile set player='Bevelock, Toni' where player='Bevelock, Tony';

update player_profile set player='Boyea, Sherron' where player='Boyea, Sharron';

update player_profile set player='Brodeur, Genevieve' where player='Brodeur, Genevive';

update player_profile set player='Brodeur, Genevieve' where player='Brodeur,Genevieve Ste-Rosalie';

update player_profile set player='Brown, Tammy' where player='Brown, Tamy';

update player_profile set player='Carbajal, Jessie' where player='Carbajal, Jesse';

update player_profile set player='Cardoza, Paola' where player='Cardozo, Paola';

update player_profile set player='Orozco, Cecilia' where player='Cecilia Orozco';

update player_profile set player='Collins, Wanda' where player='Colins, Wanda';

update player_profile set player='Csuk, Krystal' where player='Csuk, Crystal';

update player_profile set player='Daza, Jenny' where player='Daza Navia Jenny';

update player_profile set player='Deutsch, Lauren' where player='Deutsch. Lauren';

update player_profile set player='Acquilar, Diana' where player='Diana Acquilar';

update player_profile set player='Haynes (Fisher), Adrienne' where player='Fisher Haynes, Adrienne';

update player_profile set player='Holtslander, Khanh' where player='Holtslander, Khahn';

update player_profile set player='Jacobson-Prentice, Brandi' where player='Jacobson, Brandi';

update player_profile set player='Saunders, Jennifer' where player='Jennifer Saunders';

update player_profile set player='Gremley, Kelly' where player='Kelly Gremley';

update player_profile set player='Kwon, Marie Malhee' where player='Kwon, Mahlee';

update player_profile set player='Luque, Carolina' where player='Luque Carolina';

update player_profile set player='Maldonado, Anita' where player='Maldonaldo, Anita';

update player_profile set player='Maldonado, Jessica' where player='Maldonaldo, Jessica';

update player_profile set player='DelliSanti, Maria' where player='Maria DelliSanti';

update player_profile set player='McElfresh, Melissa' where player='McElfrish, Melissa';

update player_profile set player='Molina, Daniela' where player='Molina, Damiela';

update player_profile set player='Morton, Karen' where player='Mortom, Karon';

update player_profile set player='Orozco, Cecilia' where player='Orozco,  Cecilia';

update player_profile set player='Parades Guillen, Islhey' where player='Parades Guillen,';

update player_profile set player='Parades Guillen, Islhey' where player='Parades, Islhey';

update player_profile set player='Munoz, Maria Paz' where player='Paz Munoz, Maria';

update player_profile set player='Soley (Rascon), Sofia' where player='Rason, Sofia';

update player_profile set player='Rivera, Joanna' where player='Rivera, Jhoana';

update player_profile set player='Rivera, Joanna' where player='Rivera, Johanna';

update player_profile set player='Rodriguez, Maria Renee' where player='Rodriguez, Maria';

update player_profile set player='Sato, Maiko' where player='Satou, Maiko';

update player_profile set player='Schlichemeyer, Alison' where player='Schlichemeyer, Allison';

update player_profile set player='Thomas (Irons), Kimberly' where player='Thomas, Kim';

update player_profile set player='Trachsel, Jamie' where player='Trachsel. Jamie';

update player_profile set player='Turgeon, Chantal' where player='Turgeon, Shantal';

update player_profile set player='Washington, Genevieve' where player='Washington, Ginny';





commit;





