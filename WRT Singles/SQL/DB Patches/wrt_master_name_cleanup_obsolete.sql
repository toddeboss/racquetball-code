/* 
filename: wrt_master_name_cleanup.sql
purpose: SQL to clean up the WRT player names in all relevant tables

modification history
when	who	what
12/1/16	tboss	creation, adapted from master results names cleanup.
12/8/16	tboss	putting all name cleanup commands in ONE place.  Results, rankings, seedings, player_profile.
12/9/16	tboss migrated to use sp_fixname
12/21/16	tboss	putting in a slew of fixes after loading up year end rankings.

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

-- master WRT name cleanup; put results, seedings, rankings in one file.

use cp30725_wrt;

SET SQL_SAFE_UPDATES = 0;

/*
create table results_20161221 as select * from results;
create table seedings_20161221 as select * from seedings;
create table rankings_20161221 as select * from rankings;
create table player_profile_20161221 as select * from player_profile;

*/

call sp_fixname('Camacho, Vicente','Camacho, Victor');
call sp_fixname('Martell, Jaime','Martell, Jamie');
call sp_fixname('Ugalde, Jose Daniel','Ugaldo, Jose Daniel');
call sp_fixname('Almada, Alejandro','Almada, Alex');
call sp_fixname('Chavez, Loupe','Chavez, Loup');

-- Antone, Wayne -> Antone, Wayne IV?

call sp_fixname('Burruel, Arturo','Burrell, Arturo');

-- Diaz, Jose same as Diaz, Jose Daniel Rodriguez?

call sp_fixname('Garcia, Erick','Garcia, Erik');

call sp_fixname('Imhausen, Jared','Imhausen, Jered');

call sp_fixname('Iwassa, Coby','Iwaasa, Coby');

call sp_fixname('Longoria, Christian','Longoria, Cristian');

call sp_fixname('Meeks, Kamyron','Meedks, Kamyron');

-- Munoz, Felipe == Munoz Jr, Felipe ?
-- Munoz, Felipe == Munoz, Luis Felipe ?

call sp_fixname('Rodriguez Jr, Miguel','Rodriguez, Miguel Jr.');

call sp_fixname('Rojas, Daniel','Rojas, Mauro');

-- Salgado, Rodrigo == Salgado Jr, Rodrigo?

call sp_fixname('Smith Jr, Ross','Smith, Ross Jr.');

call sp_fixname('Aldana Jr., Ismael','Aldana Jr, Ismael');

call sp_fixname('Garcia, German','Gracia, German');

-- all over the road with this guy
call sp_fixname('Hayes, Alexi David Cocco','Cocco Hayes, Alexi David');
call sp_fixname('Hayes, Alexi David Cocco','Cocco, Alexi');
call sp_fixname('Hayes, Alexi David Cocco','Hayes, Alexi David Coccco');

call sp_fixname('Canedo, Santiago','Caneda, Santiago');

-- i'm assuming the non A/P is the A version.
call sp_fixname('Fumero A., Teobaldo','Fumero Teobaldo');
call sp_fixname('Fumero A., Teobaldo','Fumero a., Teobaldo');
call sp_fixname('Fumero A., Teobaldo','Fumero, Teobaldo');

call sp_fixname('Garuea, Miguel','Gardea, Miguel');

call sp_fixname('Kiil, Paul','Kill, Paul');

-- Perea, Miguel == Perea, Mike?

call sp_fixname('Sada, Eddie','Sala, Eddie');

call sp_fixname('Diaz, Jose','Diaz, jose');


/*
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;
*/