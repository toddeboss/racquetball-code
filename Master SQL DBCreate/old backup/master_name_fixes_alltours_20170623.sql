/* 
filename: master_name_cleanup_alltours.sql
purpose: SQL to clean up the IRT player names in all relevant tables

modification history
when		who	what
10/14/08	tboss	creation
4/20/11	tboss	major update more data.
12/2/16	tboss	put in some more fixes post big rankings update
12/9/16	tboss	migrating to use sp_fixname
1/17/17	tboss	modified to combine all three files; IRT, WRT, LPRT into one big file.

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

Remember: usage of sp_fixname: call sp_fixname('Correct Name','Incorrect Data to fix');

*/


/* Master Name fixing file */

/* created  from all the name patching done over the years */

/* Updated here and there: can do spot checks by running code below and eyeballing the results

-- use wwwbossconsultingcom;
-- use cp30725_men;
-- May have to just use the right database manually.

SET SQL_SAFE_UPDATES = 0;

create table results_20170117 as select * from results;
create table seedings_20170117 as select * from seedings;
create table rankings_20170117 as select * from rankings;
create table player_profile_20170117 as select * from player_profile;


select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;

/*

-- 4/20/11: doing more fixes; below is diagnostic code being used...

create table all_players as
select distinct(winner) from results
union
select distinct(loser) from results

select distinct(winner) from all_players 

select loser, count(*) from results where loser in ('Vogel, Louis','Vogel, Luis') group by loser;

select * from results where winner in ('Ghafarshad, Dawoud','Garfarshod, Dawoud')
union
select * from results where loser in ('Ghafarshad, Dawoud','Garfarshod, Dawoud')
order by tmp_date,round desc;


*/




/* ------------------------------------------------------------------------------------------------- */
/* IRT primary data first */
/* ------------------------------------------------------------------------------------------------- */


/* 10/14/08 Post Initial db creation fixes*/

call sp_fixname('Amatulli, John','Amatuli, John');
call sp_fixname('Amatulli, John','Amatulli,J');
call sp_fixname('Amatulli, John','Amatuli, John');

call sp_fixname('Bronfeld, Michael','Bronfeld, Mike');
call sp_fixname('Bronfeld, Michael','Bronfeld,M');

call sp_fixname('Bustillos, Luis','Busillos, Luis');
call sp_fixname('Campbell, Darin','Campbell,D');
call sp_fixname('Cherry, Chad','Cherry, ?');
call sp_fixname('Conine, Jeff','Conine,J');
call sp_fixname('Cullins, Scott','Cullins,S');
call sp_fixname('DeJesus, Rob','De Jesus, Rob');
call sp_fixname('DiGiacomo, Ron','Dijacamo,R');
call sp_fixname('Drake, Charlie','Drake,C');
call sp_fixname('Eagle, Doug','Eagle,D');
call sp_fixname('Embry, Aaron','Embry,A');
call sp_fixname('Evans, Jeff','Evans,J');
call sp_fixname('Foley, Eric','Foley,E');
call sp_fixname('Gelhaus, Kelly','Gelhouse, Kelly');
call sp_fixname('Gibbs, Joe','Gibbs,');
call sp_fixname('Gilliam, Lance','Gillian, Lance');
call sp_fixname('Gonzalez, Ruben','Gonzales, Ruben');
call sp_fixname('Graham, Sean','Graham,S');
call sp_fixname('Gutierrez, Polo','Guitierrez, Polo');
call sp_fixname('Karmelin, Shane','Karmelin');
call sp_fixname('Liparelli, Scott','Lipparelli, Scott');
call sp_fixname('Kasay, J','Kasay,');
call sp_fixname('Kasay, J','Kasay,J');
call sp_fixname('Marcus, Hank','Marcus,H');
call sp_fixname('McCunniff, Brad','McCuniff, Brad');
call sp_fixname('McAuliffe, ?','Mcauliffe,');
call sp_fixname('McCormick,B','Mccormick,B');
call sp_fixname('McDonough, M','Mcdonough,M');
call sp_fixname('McDouwell, ?','Mcdowell,');
call sp_fixname('McDouwell, D','Mcdowell,D');
call sp_fixname('McGlone, ?','Mcglone,');
call sp_fixname('McKie, T','Mckie,T');
call sp_fixname('McKinney, B','Mckinney,B');
call sp_fixname('McQuarrie, D','Mcquarrie,D');
call sp_fixname('Menache, Sammy','Menache, Sam');

-- probably a mistake here: Meyers,L == Larry Meyers.
-- call sp_fixname('Myers, Lindsay','Meyers,L');
-- call sp_fixname('Myers, Lindsay','Meyers,L');

call sp_fixname('Negrete, J','Negrete,J');
call sp_fixname('Niederhoffer, Victor','Niederhoffer,Vic');

call sp_fixname('Palazzo, Joe','Palozzi, Joe');
call sp_fixname('Plazak, Jeff','Plazak,J');
call sp_fixname('Richards, Torrey','Richards, torrey');
call sp_fixname('Roberts, Andy','Rob');
call sp_fixname('Rodriguez, Bobby','Rodriguez,B');

call sp_fixname('Sacco, Joey','Sacco,J');
call sp_fixname('Simonette, Dave','Simonette,D');
call sp_fixname('Thoerner, Jason','Thoerner');
call sp_fixname('?','Unknown');
call sp_fixname('Waggoner, Jason','Wagonner,J');

call sp_fixname('Wetherbee, John','Wetherbe, John');
call sp_fixname('Wetherbee, John','Weatherbee, John');

call sp_fixname('Winterton, Jim','Winterton,J');

/* later on name fixing */
call sp_fixname('Cohen, Doug','Cohen,D');
call sp_fixname('Koltun, Ben','Koltun,B');
call sp_fixname('Champagne, Bo','Champagne,B');

-- call sp_fixname('O''Connor, J','O''connor,J');

call sp_fixname('Tristan, Agustin','Tristan, Augusin');

/* Fixes from Jaime Arroyave 4/6/04 */

call sp_fixname('Arroyave, Jaime','Arroyave, ?');
call sp_fixname('Satawa, Brian','Satawa, ?');
call sp_fixname('Bhuta, Jed','Bhuta, ?');


/* 7/14/06: Quick fixes for Mercante */

call sp_fixname('Mercante, John','Mercante,J');
call sp_fixname('Evans, Jeff','Evans, ?');
call sp_fixname('Campbell, Darin','Campbell, ?');

/* 10/6/06: fixed name quick for Crockett */

call sp_fixname('Crockett, Christopher','Crockett, Christpher');

/* 10/15/06: heard from Sean Moskwa, fixed his name */
call sp_fixname('Moskwa, Sean','Moskwa,S');


/* 10/15/07: some name cleanup from recent events..  Man we've got a mess of name updates to do... */

call sp_fixname('Landa, Roman','Landa, Romon');

call sp_fixname('Landa, Alejandro','Landa, Alex');
call sp_fixname('Landa, Alejandro','Landa, Alejandro ');


call sp_fixname('Anderson, Michael','Anderson, Mike');

call sp_fixname('Burruel, Arturo','Burrell, Arturo');

call sp_fixname('Crockett, Allan','Crockett, Alan');

call sp_fixname('De Los Rios, Juan','De Los Rios Mendoza, Juan');

call sp_fixname('De Los Rios, Gil','Rios, Gil De Lo');

call sp_fixname('Derocheres, Eric','Derouchers, Eric');
call sp_fixname('Derocheres, Eric','Derochers, Eric');
call sp_fixname('Derocheres, Eric','Desrochers, Eric');


call sp_fixname('Entricken, Todd','Entriken, Tod');

call sp_fixname('Filippini, Rafael','Fillipini, Rafael');
call sp_fixname('Filippini, Rafael','Filippini, Rafael');
call sp_fixname('Filippini, Rafael','Fillipini, Raphael');
call sp_fixname('Filippini, Rafael','Fillippini, Rafael');
call sp_fixname('Filippini, Rafael','Fillipini, Rafael');

call sp_fixname('Fredenberg, Brian','Fredenburg, Brian');
call sp_fixname('Fredenberg, Brian','Fredenburg, Brian');

call sp_fixname('Funatani, Sadao','Futami, Sadao');
call sp_fixname('Funatani, Sadao','Funatini, Sadao');

call sp_fixname('Furhmann, Tom','Furhman, Tom');

call sp_fixname('Ghafarshad, Dawoud','Ghafarshad, Dawould');

call sp_fixname('Gutierrez, Polo','Guitierrez, Polo');

call sp_fixname('Husalak, Nathaniel','Husulak, Nathaniel');
call sp_fixname('Husalak, Nathaniel','Husucak, Nathaniel');
call sp_fixname('Husulak, Nathaniel','Husalak, Nathaniel');

-- call sp_fixname('KMessier, Matthieu','Messier, Matthew');
call sp_fixname('Messier, Matthieu','Messier, Matthew');
call sp_fixname('Messier, Matthieu','KMessier, Matthieu');

call sp_fixname('Kono, Michimune','Kono, Michimine');
call sp_fixname('Kono, Michimune','Michimune');

call sp_fixname('Miller, Darrell','Miller, Darrel');

call sp_fixname('Moccia, Mark','Moccia, Marc');

call sp_fixname('Patendue, Patrick','Patenadue, Patrick');

call sp_fixname('Peinada, Daniel','Peinado, Daniel');
call sp_fixname('Peinada, Daniel','Peinada, Darie');

call sp_fixname('Perdomo, Simon','Perdoma, Simon');

call sp_fixname('Ramirez, Tony','Rameriz, Tony');

call sp_fixname('Rojas, Steven','Rojas, Steve');

call sp_fixname('Schraeder, Caleb','Schrader, Caleb');

call sp_fixname('Torres, Juan Carlos','Torres, Juan');

call sp_fixname('Ulliman, Pete','Ulliman, Peter');

call sp_fixname('Wojonoski, Ron','Wojnoski, Ron');
call sp_fixname('Wojonoski, Ron','WWojonski, Ron');



/* 1/18/08: quick fix for NYC player names */

call sp_fixname('Emmel, Matthew','Emmel, Matt');
call sp_fixname('Emmel, Matthew','Emmell, Matt');

/* 2/15/08: fixing Dave Sable/Sabeleski results per email from Steve Szabo */

call sp_fixname('Sabalesky, Dave','Sabelski, Dave');
call sp_fixname('Sabalesky, Dave','Sable, Dave');
call sp_fixname('Sabalesky, Dave','Sabelski, Dave');
call sp_fixname('Sabalesky, Dave','Sabelesky, Dave');


/* 2008/10/02 removing apostrophes */

call sp_fixname('OBrien, Tom','O''Brien, Tom');
call sp_fixname('OBrien,?','O''Brien,?');
call sp_fixname('OConnor,J','O''Connor,J');
call sp_fixname('ONeil, Todd','O''Neil, Todd');

call sp_fixname('OBrien, Tom','O''Brien, Tom');
call sp_fixname('OBrien,?','O''Brien,?');
call sp_fixname('OConnor,J','O''Connor,J');
call sp_fixname('ONeil, Todd','O''Neil, Todd');

call sp_fixname('ONeil, Todd','Oneil,T');
call sp_fixname('ONeil, Todd','O''Neil,T');
call sp_fixname('ONeil, Todd','O''Neil, Todd');


/* 10/7/08: fixing minor name issue found doing name research */

call sp_fixname('Rodriguez, Manuel','Rodriquez, ?');

call sp_fixname('Sutherland, Bill','Sutherland, ?');


/* 10/8/08: Marty Hogan recalls many older players w/o first names */

call sp_fixname('Alder, Dan','Alder,D');
call sp_fixname('Bolan, Bobby','Bolan,B');
call sp_fixname('Bowes, Wayne','Bowes,W');
call sp_fixname('Britos, John','Britos,J');
call sp_fixname('Britos, Peter','Britos,P');
call sp_fixname('Campbell, Erik','Campbell,E');
call sp_fixname('Chase, Steve','Chase,S');
call sp_fixname('Charleston, Dave','Charleston,D');
call sp_fixname('Dern, Rick','Dern,R');
call sp_fixname('Dunlap, Keith','Dunlap,K');
call sp_fixname('Dunn, Bill','Dunn,B');
call sp_fixname('Factor, Dan','Factor,D');
call sp_fixname('Fancher, Terry','Fancher,T');
call sp_fixname('Fox, Larry','Fox,L');
call sp_fixname('Griffith, Mike','Griffith,M');
call sp_fixname('Harvey, Ross','Harvey,R');
call sp_fixname('Hawkins, Scott','Hawkins,S');
call sp_fixname('Martino, Mark','Martino,M');
call sp_fixname('Matthews, Matt','Matthews,M');
call sp_fixname('Mondry, Steve','Mondry,S');
call sp_fixname('Navarro, Ray','Navarro,R');
call sp_fixname('Porco, Ken','Porco,K');
call sp_fixname('Roderick, Myron','Roderick,M');
call sp_fixname('Romano, Mike','Romano,M');
call sp_fixname('Rubenstein, Ron','Rubenstein,R');
call sp_fixname('Sulli, Steve','Sully,S');
call sp_fixname('Terry, Evan','Terry,E');
call sp_fixname('Vantrease, Kelvin','Vantrease,K');
call sp_fixname('Wong, Kenny','Wong,K');
call sp_fixname('Wright, Pete','Wright,P');
call sp_fixname('Zetrouer, Gary','Zetrouer,G');

call sp_fixname('Alder, Dan','Alder, D');
call sp_fixname('Bolan, Bobby','Bolan, B');
call sp_fixname('Bowes, Wayne','Bowes, W');
call sp_fixname('Britos, John','Britos, J');
call sp_fixname('Britos, Peter','Britos, P');
call sp_fixname('Campbell, Erik','Campbell, E');
call sp_fixname('Chase, Steve','Chase, S');
call sp_fixname('Charleston, Dave','Charleston, D');
call sp_fixname('Dern, Rick','Dern, R');
call sp_fixname('Dunlap, Keith','Dunlap, K');
call sp_fixname('Dunn, Bill','Dunn, B');
call sp_fixname('Factor, Dan','Factor, D');
call sp_fixname('Fancher, Terry','Fancher, T');
call sp_fixname('Fox, Larry','Fox, L');
call sp_fixname('Griffith, Mike','Griffith, M');
call sp_fixname('Harvey, Ross','Harvey, R');
call sp_fixname('Hawkins, Scott','Hawkins, S');
call sp_fixname('Martino, Mark','Martino, M');
call sp_fixname('Matthews, Matt','Matthews, M');
call sp_fixname('Mondry, Steve','Mondry, S');
call sp_fixname('Navarro, Ray','Navarro, R');
call sp_fixname('Porco, Ken','Porco, K');
call sp_fixname('Roderick, Myron','Roderick, M');
call sp_fixname('Romano, Mike','Romano, M');
call sp_fixname('Rubenstein, Ron','Rubenstein, R');
call sp_fixname('Sulli, Steve','Sully, S');
call sp_fixname('Terry, Evan','Terry, E');
call sp_fixname('Vantrease, Kelvin','Vantrease, K');
call sp_fixname('Wong, Kenny','Wong, K');
call sp_fixname('Wright, Pete','Wright, P');
call sp_fixname('Zetrouer, Gary','Zetrouer, G');



/* 10/14/08: more name fixing */

-- Mike Pawka eznoh@niceup.com says Green,D is Dolwain Green

call sp_fixname('Green, Dolwain','Green,D');
call sp_fixname('Green, Dolwain','Green, Dolwayne');


/* More analysis by sorting all names */

call sp_fixname('Berklehamer, Brian','Berkelhamer, Brian');
call sp_fixname('Hernandez, Allen','Hernandez, Alan');
call sp_fixname('Eichenberg, Steve','Eichenberger, Steve');
call sp_fixname('Hirsekom, Jorge','Hirsekorn, Jorge');
call sp_fixname('Husulak, Nathaniel','Husalak, Nataniel');

call sp_fixname('Jammal, Tony','Jammal Tony');
call sp_fixname('Jammal, Tony','Jamal, Tony');

call sp_fixname('Kelley, Vince','Kelly, Vince');
call sp_fixname('Loiaza, Enrique','Loizza, Enrique');

call sp_fixname('Masxner, Matthew','Majxner, Matthew');
call sp_fixname('Milakovich, Bryce','Milakovic, Bryce');
call sp_fixname('Miller, Darrell','Miller, Darrel');
call sp_fixname('Perdomo, Simon','Perdoma, Simon');



/* 11/1/08: Morrow,M is Mark */

call sp_fixname('Morrow, Mark','Morrow,M');
call sp_fixname('Morrow, Mark','Morrow, M');

/* 11/6/08: Stephens,G is Gary */

call sp_fixname('Stephens, Gary','Stephens,G');
call sp_fixname('Stephens, Gary','Stephens, G');


/* 4/20/11: doing some more cleanup with newer players. */


-- Decided that it is Tony Carson, not Anthony Carson
call sp_fixname('Carson, Tony','Carson, Anthony');
call sp_fixname('Ackermann, Alex','Ackerman, Alex');
call sp_fixname('Crockett, Allan','Crockett, Allen');
call sp_fixname('Flores Jr. Jose','Flores, Jose');
call sp_fixname('Lavely, Danny','Lavely, Dan');
call sp_fixname('Leetch, Erik','Leetch, Eric');
call sp_fixname('Ortega, Eduardo Avila','Ortega, Eduardo');
call sp_fixname('Rogers, Bradley','Rogers, Brad');
call sp_fixname('Serrento, Jose','Serrano, Jose');
call sp_fixname('Slamko, Jamie','Slamko, James');
call sp_fixname('Vogel, Louis','Vogel, Luis');
call sp_fixname('Austin, David','Austin, Dave');

call sp_fixname('Baricuatro, Darryl','Baricautro, Daniel');
call sp_fixname('Baricuatro, Darryl','Baricuarto, Darrell');

call sp_fixname('Brannigan, Erin','Brannagan, Erin');
call sp_fixname('Chisholm, John-Craig','Chisholm, John');

call sp_fixname('Creazzo, Vinny','Creazzo, Vince');
call sp_fixname('Ghafarshad, Dawoud','Garfarshod, Dawoud');


-- 5/17/11: found some older names while going through late 70s/early 80s rankings...

call sp_fixname('Kamalu, Kyle','Kamalu,K');
call sp_fixname('Davidson, Craig','Davidson,C');
call sp_fixname('Perry, Scott','Perry,S');
call sp_fixname('Antes, Mark','Antes,M');
call sp_fixname('Hackbarth, Ralph','Hackbarth,R');
call sp_fixname('Lee, Allen','Lee,A');
call sp_fixname('Lynch, John','Lynch,J');
call sp_fixname('Nolan, Jack','Nolan,J');
call sp_fixname('Rish, Charlie','Rish,C');
call sp_fixname('Texiera, Guy','Texeria,G');
call sp_fixname('Valin, Brian','Valin,B');
call sp_fixname('Christensen, Bruce','Christensen,B');

-- 6/13/11: Steve "Bo" Keely helps with some more names
call sp_fixname('Bowman, Jeff','Bowman,J');
call sp_fixname('Ikier, Paul','Ikier,P');
call sp_fixname('Strom, Ron','Strom,R');
call sp_fixname('Thurman, Bill','Thurman,B');

-- 12/2/16: noticing some data entry errors: putting in more.

call sp_fixname('Majxner, Matthew','Masxner, Matthew');
call sp_fixname('Martell, Jaime','Martel, Jamie');
call sp_fixname('Adler, Joel','Adler, Joe');
call sp_fixname('Aldana, Ismael','Aldana, Isamel');
call sp_fixname('Alvidez, Javier','Alvidrez, Javier');
call sp_fixname('Barton, Christopher','Barton, Chris');
call sp_fixname('Bermudez, Armando','Bermutez, Armondo');
call sp_fixname('Bousquet, Nicolas','Bousquet, Nicholas');
call sp_fixname('Casalvolone, Bruno','Casalvolve, Bruno');
call sp_fixname('Chisholm, John-Craig','Chisholm, John Craig');
call sp_fixname('Crockett, Allan','Crockett, Allen');
call sp_fixname('Cubillos, Set','Cubillos, Seb');
call sp_fixname('Flores, Ramon','Florez, Ramon');
call sp_fixname('Funatani, Sadao','Funati, Sadeo');

call sp_fixname('Gutierrez, Reydecel','Gutierrez, Rey');
call sp_fixname('Gutierrez, Reydecel','Guiterrez, Reydecel');

-- Guitierrez, Leopoldo and Guitterez, Leo: unknown); last name misspelled?

call sp_fixname('Hernandez, Allen','Hernandez, Allan');
call sp_fixname('Husulak, Barret','Husulack, Barret');
call sp_fixname('Jasso, Jesus Alberto','Jasso, Jesus');
call sp_fixname('Jentsch, Neal','Jentsch, Neale');
call sp_fixname('Lavely, Danny','Lavely, Dan');
call sp_fixname('Lejia, Missael','Leija, Missael');
call sp_fixname('Leone, Jim','Leone, James');
call sp_fixname('Lesieur, Brian','Lesuir, Brian');
call sp_fixname('Maestas, Raymond','Maestas, Ray');
call sp_fixname('Mayorga, Jeff','Mayorga, Jeffrey');
call sp_fixname('Mendieta, Fabian','Mendietta, Fabian');
call sp_fixname('Mettenbrink, Travis','Mettinbrink, Travis');
call sp_fixname('Minardo, Hank','Mindardo, Hank');
call sp_fixname('Molinari, Johnnie','Molinari, John');
call sp_fixname('Montalbano, Nick','Montabano, Nick');

-- Morales, Alejandro versus Morales, Alex: hmm.

-- Is Munoz, Luis Felipe same as Munoz, Felipe?  don't htink so

-- Ortiz, Sal Sr. same as Ortiz, Salvador?  Maybe

call sp_fixname('Partovich, Roby','Partovich, Robby');
call sp_fixname('Partovich, Roby','Partovich, Toby');
call sp_fixname('Partovich, Roby','Partrovich, Roby');

call sp_fixname('Patendue, Patrick','Pataniuda, Patrick');
call sp_fixname('Rhodes, John Lee','Rhodes, John');

-- Got the goahead Nov 2016 to always call Mauro Rojas "David"
-- Actually, its "Daniel" ... made a mistake earlier.

call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Mauro');
call sp_fixname('Rojas, Daniel (Mauro)','Rojas, David');
call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Daniel');

call sp_fixname('Saito, Keichiro','Saito, Keiichiro');

call sp_fixname('Schmeiser, Arthur','Schmeser, Arthur');

-- Serrano, Jose versus Serrento, Jose?  

call sp_fixname('Sierra, Fernando','Siera, Fernando');
call sp_fixname('Torres, Jared','Torres, Jarred');
call sp_fixname('Ugalde, Jose Daniel','Ugalde, Josaniel');


-- Wagner Jr, Rich and Wagner, Rich: same?

call sp_fixname('Wolfe, Clint','Wolff, Clint');

call sp_fixname('Yamashiro, Herbert','Yamashiro, Herb');
call sp_fixname('Yamashiro, Herbert','Yashimiro, Herb');

-- 12/9/16: running through the data once again post big rankings insert.

call sp_fixname('Ackerman, Michael','Ackerman, Mike');

call sp_fixname('Antone IV, Wayne','Antone Iv, Wayne ');
call sp_fixname('Antone IV, Wayne','Antone Iv, Wayne');
call sp_fixname('Antone IV, Wayne','Antone Wayne');
call sp_fixname('Antone IV, Wayne','Antone, Wayne');
call sp_fixname('Antone IV, Wayne','Antone, Wayne IV');
call sp_fixname('Antone IV, Wayne','Antone, Wayne');

call sp_fixname('Appel, Peter','Appel, Pete');

call sp_fixname('Avila, Eduardo','Avila, Edwardo');

call sp_fixname('Babinchack, Andy','Babinchak, Andy');

call sp_fixname('Bacmeister, Carlos','Backmeister, Carlos');
call sp_fixname('Bacmeister, Carlos','Bacmesiter, Carlos');

call sp_fixname('Baker, Robert','Baker, Robert (dan) ');
call sp_fixname('Baker, Robert','Baker, Robert (dan)');

call sp_fixname('Balderrama, Emanuel','Balderrama, Emmanuel');
call sp_fixname('Balderrama, Emanuel','Balderrama, Emanuel ');

call sp_fixname('Barrett, John','Barret, John');

-- might have this one backwards.
call sp_fixname('Bartewski, Kam','Barteski, Cam');

-- is this also Bates, Alex?
call sp_fixname('Bates, AC','Bates, A.c.');

call sp_fixname('Batistasos, Angelo','Batistatos, Angelo');

call sp_fixname('Bayley, Matthew','Bayley, Matt');

-- might hvae this backwards
call sp_fixname('Beauchemin, Jamie','Beauchern, Jamie');

call sp_fixname('Beaudry, Dan','Beaudry, Danny');

call sp_fixname('Blood, Erik','Blood, Eric');

-- Bolyard, Andrew == Bolyard, Andres?

call sp_fixname('Boris, Darryl','Boris, Daryl');

call sp_fixname('Bremner, Parker','Bremmer, Parker');

call sp_fixname('Bruns, Russ','Bruns, Russell');

call sp_fixname('Buchanan, Dave','Buchannon, Dave');

call sp_fixname('Burgess, Michael','Burgess, Mike');

call sp_fixname('Campbell, Erik','Campbell, Eric');

call sp_fixname('Campo, Luis Fernando','Campo, Luis');

call sp_fixname('Cardenas, Abe','Cardenas, Abraham');
call sp_fixname('Cardenas, Abe','Cardenas, Abraham1');

call sp_fixname('Carlson, Glenn','Carlson, Glen');

call sp_fixname('Carrillo, Cesar','Carrillo, Ceasar');

call sp_fixname('Carter, Cris','Carter, Chris');

call sp_fixname('Carver, Rick','Carver, Rich');

call sp_fixname('Case, Dan','Case, Daniel');

call sp_fixname('Cerreto, Neil','Cerruto, Neil');

call sp_fixname('Cerreto, Neil','Cerruto, Neil');

-- all over the road with this guy
call sp_fixname('Hayes, Alexi David Cocco','Cocco Hayes, Alexi David');
call sp_fixname('Hayes, Alexi David Cocco','Cocco, Alexi');

call sp_fixname('Coe, H.R.','Coe, Hr');

call sp_fixname('Cole, Christopher','Cole, Chris');

call sp_fixname('Corbridge, Ric','Corbidge, Ric');

call sp_fixname('Davis, John W.','Davis, John');

-- Deaton, Stevan == Deason, Steve?

call sp_fixname('Eckly, Chad','Eckley, Chad');

call sp_fixname('Entricken, Todd','Entriken, Todd');

call sp_fixname('Ericson, Edward','Ericson, Ed');

call sp_fixname('Estrada, Ruben','Esrada, Ruben');

call sp_fixname('Everhart, Destry','Everhart, Desty');

-- might have this backwards
call sp_fixname('Falvery, Brad','Falvey, Brad');

call sp_fixname('Ferreiri, Bobby','Ferreira, Bobby');

call sp_fixname('Flores Jr. Jose','Flores, Jr., Jose ');

call sp_fixname('Fontana, Matthew','Fontana, Matt');

call sp_fixname('Franks, Michael ray','Franks, Michael Ray');

call sp_fixname('Fuhrmann, Thomas','Fuhrman, Tom');
call sp_fixname('Fuhrmann, Thomas','Furhmann, Tom');

-- i'm assuming the non A/P is the A version.
call sp_fixname('Fumero A., Teobaldo','Fumero Teobaldo');
call sp_fixname('Fumero P., Teobaldo','Fumero p., Teobaldo');
call sp_fixname('Fumero A., Teobaldo','Fumero a., Teobaldo');

-- are Gale, Andrew and Gale, Andres different?

call sp_fixname('Garay, Eduardo','Garay, Edwardo');

call sp_fixname('Garcia, Noslen Jimenez','Garcia, Nolsen Jimenez');
call sp_fixname('Garcia, Noslen Jimenez','Garcia, Nolsen');

call sp_fixname('Garner, Jeff','Garner, Jeffrey');

call sp_fixname('Garrow, William','Garrow, Will');

call sp_fixname('Garzon, Juan Felipe','Garzon, Juan');

call sp_fixname('Gerhardt, Thomas','Gerhardt, Tommy');

call sp_fixname('Gillespie, Michael','Gillespie, Mike');

call sp_fixname('Giunta, Nick','Giunta, Nicholas');
call sp_fixname('Giunta, Nick','Guinta, Nick');

call sp_fixname('Green Jr., Kenny','Green, Kenny');

call sp_fixname('Greenfeld, Sherman','Greenfield, Sherman');

call sp_fixname('Gross, Tanner','Gross, Atanner');

call sp_fixname('Guentert, David','Guentert, Dave');
call sp_fixname('Guentert, David','Guennert, David');

call sp_fixname('Guevara, Gerardo','Guevera, Gerardo');

call sp_fixname('Guillen, Eduardo','Guillen, Edwardo');

call sp_fixname('Guitierrez, Leopoldo','Guitterez, Leo');

-- might be wrong on this one.
call sp_fixname('Gutierrez, Juan Manuel','Gutierrez, Juan');

call sp_fixname('Haines, David','Haines, Dave');

call sp_fixname('Haines, David','Haines, Dave');

call sp_fixname('Halsey, Ross','Halsey, Rosco');

-- is this the same as Harmon, Scott?
call sp_fixname('Hamon, Scott','Hamon, R. scott');

call sp_fixname('Hardin, Mitchell','Harden, Mitchell');

call sp_fixname('Hardin, Mitchell','Harden, Mitchell');


call sp_fixname('Herrera, Alejandro','Herera, Alejandro');
call sp_fixname('Herrera, Andres','Herera, Andres');
call sp_fixname('Herrera, Anthony','Herera, Anthony');
call sp_fixname('Herrera, Anthony F.','Herera, Anthony F.');
call sp_fixname('Herrera, German','Herera, German');

call sp_fixname('Hernandez, Jorge Ivan','Hernandez, Jorge ivan');

-- Hernandez Jr., Vicente  same as Hernandez, Vicente?

call sp_fixname('Honoj, Juan Carlos Torres','Honoj, Juan carlos');

call sp_fixname('Hugo, Isaac','Hugo, Issac');

call sp_fixname('Humiston, Scott','Humiston, R. scott');

-- same as Hunt, Steven?
call sp_fixname('Hunt-Marriott, Stephen','Hunt-marriott, Stephen');

call sp_fixname('Husulak, Barrett','Husulak, Barret');
call sp_fixname('Husulak, Barrett','Husalak, Barrett');

call sp_fixname('Isley, Tripp','Isley, Trip');

call sp_fixname('Iwaasa, Coby','Iwassa, Coby');

call sp_fixname('Jeon, Seung Jun','Jeon, Jun');
call sp_fixname('Jeon, Seung Jun','Jun, Jeon Seung');

call sp_fixname('Jimenez Garcia, Nolsen','Jimenez Noslen Garcia');

call sp_fixname('Jimenez-Guerra, Andres','Jimenez, Andres');

call sp_fixname('Juteau, Sebastian','Juteau, Sebastien');

call sp_fixname('Kaihlanen, Ken','Kaihlanen,K');

call sp_fixname('Kamahara, Ryoki','Kamahara, Kyoki');

call sp_fixname('Katsanevas, Pete','Katsanezas, Pete');

call sp_fixname('Kazuhshuge, Oikawa','Kazuhshige, Oikawa');

call sp_fixname('Keil, Joshua','Keil, Josh');

call sp_fixname('Kinselberg, Gary','Kinzelerg, Gary');

call sp_fixname('Kirch, Bradley','Kirch, Brad');

call sp_fixname('Kirch, Timothy','Kirch, Tim');

call sp_fixname('Klingman, Sean','Klingaman, Sean');

call sp_fixname('Kost, Mitch','Kost, Micth');

call sp_fixname('Lawrence, Gregory','Lawerenz, Gregory');

call sp_fixname('Lee, Vinny','Lee, Vinnie');

call sp_fixname('Levitsky, Ronald','Levitskiy, Ronald');

call sp_fixname('Lewerenz, Gregory','Lewerenz, Greg');

call sp_fixname('Leyva, Guillermo','Leyva, Guiellermo');

call sp_fixname('Llerena, Estuardo Wer','Llerena, Estuardo');

call sp_fixname('Lloyd, Sawyer','Lloyd, Swyer');

call sp_fixname('Loiaza, Enrique','Loaizza, Enrique');

call sp_fixname('Loiaza, Enrique','Loaizza, ?');

call sp_fixname('Longoria, Christian','Longoria, Cristian');

call sp_fixname('Maldonado, Alvaro','Maldonaldo, Alvaro');

call sp_fixname('Mancebo, A. Hector','Mancede, A. Hector');

call sp_fixname('Martin, Arturo','Martin, Artvaro');

-- Also Juan Martinez w/o III?
call sp_fixname('Martinez III, Juan','Martinez iii, Juan');
call sp_fixname('Martinez III, Juan','Martinez I I I, Juan ');

call sp_fixname('Martinez III, Juan','Martinez, Juan III');

call sp_fixname('Mcavoy, Kyle','McAvoy, Kyle');

call sp_fixname('McClintock, Mark','Mcclintock, Mark');

call sp_fixname('McConnon, Martin','Mcconnon, Martin');

call sp_fixname('McCormack, Alex','Mccormack, Alex');

call sp_fixname('McCormick, Don','Mccormick, Don');

call sp_fixname('McCroskey, Richard','Mccroskey, Richard');

call sp_fixname('McCunniff, Brad','McCunnif, Brad');

call sp_fixname('McDugal, Shane','Mcdugal, Shane');

call sp_fixname('McElhiney, Matt','Mcellhiney, Matt');

call sp_fixname('McGuffey, Chad','Mcguffey, Chad');

call sp_fixname('McKinley, Glen','Mckinley, Glen');

call sp_fixname('McKinney, Rick','Mckinney, Rick');

call sp_fixname('McKinnis, Matthew','Mckinnis, Matthew');

call sp_fixname('McLain, Kerry','Mclain, Kerry');

call sp_fixname('McSwane, Wesley','Mcswane, Wesley');

call sp_fixname('Mehta, Clinton','Mehta, Clint');

call sp_fixname('Meredith, Chuck','Meredith, Charles');

call sp_fixname('Michel, Jorge Luis','Michel, Jorge luis');
call sp_fixname('Michel, Jorge Luis','Michel, Jorge, Luis');

call sp_fixname('Min-Soo, Park','Min-soo, Park');
call sp_fixname('Min-Soo, Park','Minsoo, Park');

call sp_fixname('Minkel, Jim','Minkiel, Jim');

call sp_fixname('Miramontes, Nicolai','Miramontes, Nico');

-- Mora, Fabian == Mora, Fabrizio?

call sp_fixname('Mykalclo, Steve','Mykalcio, Steve');

call sp_fixname('Narvarte, T.J.','Narvarte, TJ');

call sp_fixname('Nunez Jr., Miguel','Nunez Jr, Miguel');

call sp_fixname('OBrien, Mike','Obrien, Mike');

call sp_fixname('OCallaghan, Noel','Ocallaghan, Noel');

call sp_fixname('OConnor, Roger','Oconnor, Roger');

call sp_fixname('OHara, Pat','Ohara, Pat');

call sp_fixname('ONeil, Eddie','Oneil, Eddie');

-- the non jr/sr is definitely jr based on results and ranking
call sp_fixname('Ortiz Sr., Sal','Ortiz sr, Sal');
call sp_fixname('Ortiz Sr., Sal','Ortiz, Sal Sr.');
call sp_fixname('Ortiz Jr., Salvador','Ortiz, Salvador');

call sp_fixname('Paez, Ezequiel','Paez, Ezequial');

call sp_fixname('Palazzo, Joe','Palazzo, Joseph ');

call sp_fixname('Palmer, James','Palmer, Jamis');

call sp_fixname('Paraiso, Joey','Paraiso, Joe');

call sp_fixname('Parrilla, Andree','Parrilla, Andre');

call sp_fixname('Polo Jr, Luis','Polo, Luis jr');

call sp_fixname('Purcell, Alex','Purcell, Alexxander');

call sp_fixname('Raby, Burgess','Raby, Bur');

call sp_fixname('Rahn, David','Rahn, Dave');

call sp_fixname('Ramos Jr., Jorge','Ramos jr, Jorge');

call sp_fixname('Randalls, Darren','Randalls, Darrin');
call sp_fixname('Randalls, Darren','Randles, Darin');

call sp_fixname('Reinhard, Ralf','Reinhardt, Ralf');

call sp_fixname('Reyes, Francisco Gomez','Reyes, Francisco');

call sp_fixname('Riffel, Nicholas','Riffel, Nick');

call sp_fixname('Rivera, Fernando Javier','Rivera, Fernando');

call sp_fixname('Rodriguez, Humberto','Rodriquez, Humberto');

call sp_fixname('Rogers, Bradley','Rogers, Bradly');
call sp_fixname('Rogers, Bradley','Rodgers, Bradly');

call sp_fixname('Romo Garcia, Alejandro','Romo, Alejandro');

call sp_fixname('Ryder, Tim','Ryder, Tom');

call sp_fixname('Sabalesky, Dave','Sable (sabalesky), David');

call sp_fixname('Salamone, Danny','Salamone, Dan');

-- Samson, Ferd is correct, btw.

call sp_fixname('Sandoval, Erick','Sandavol, Eric');

call sp_fixname('Santana Jr, Fausto','Santana Fausto');

call sp_fixname('Schonberger, Anthony','Schongerger, Anthony');

call sp_fixname('Schrack, Jonathan','Schrack, Jonathon');

call sp_fixname('Schwent, David','Schwent, Dave');

call sp_fixname('Sengal, Frank','Senger, Frank');

call sp_fixname('Shepley, William','Shepley, Bill');
call sp_fixname('Shepley, William','Shepley, Billy');

call sp_fixname('Shimizu, Hisao','Shimizo, Hisao');

call sp_fixname('Shnurman, Sampson','Shnruman, Sampson');

call sp_fixname('Schopieray, Brad','Shopieray, Brad');

call sp_fixname('Simpson, Steve','Simpson, Steven');

call sp_fixname('Sledzik Jr., Richard','Sledzick jr., Richard');

call sp_fixname('Slutsky, Ethan','Slutzky, Ethan');

-- Dan and Danny Smith definitely different people

call sp_fixname('Soltren, Luciano','Soltren, Luciano (pete)');
call sp_fixname('Soltren, Luciano','Soltren, Pete');

call sp_fixname('Songkeen, Tim','Songksen, Tim');

call sp_fixname('St. Pierre, Dan','St. peirre, Dan');

call sp_fixname('St. Pierre, Toby','St. peirre, Toby');

call sp_fixname('Stamborski, Matt','Stamborsky, Matt');

call sp_fixname('Stivinson, Chuck','Stivison, Chuck');

call sp_fixname('Thielen, Tyler','Theilen, Tyler');
call sp_fixname('Thielen, Tyler','Thellan, Tyler');
call sp_fixname('Thielen, Tyler','Thielen,T');

call sp_fixname('Thomas, Darryl','Thomas, Daryl');

call sp_fixname('Thomas, Jorge Carlos','Thomas, Jorge carlos');
call sp_fixname('Thomas, Jorge Carlos','Thomas, Jorge');

-- might be backwards
call sp_fixname('Thorson, John','Thorsen, John');

call sp_fixname('Tipton, Jeff','Tipton, Jeffery');

call sp_fixname('Torres, Fabian','Torrez, Fabian');

-- Turley II, Jerry seems different from Turley, Jerry and Turley, ?

call sp_fixname('Ubilla, Jose','Ubilla, Jose E');

call sp_fixname('Uriostegui Jr., Vicente','Uriostegui jr, Vicente');
call sp_fixname('Uriostegui Jr., Vicente','Uriostegui, Vicente');

call sp_fixname('Van Valkenburg, Jesse','Van valkenburg, Jesse');

call sp_fixname('Varela, Jacob','Vareia, Jacob');

call sp_fixname('Vargas, Hugo','Vargas, Hogo');

call sp_fixname('Vesely, Filip','Vesily, Filip');

call sp_fixname('Villacreces, Mario','Villacreses, Mario');

call sp_fixname('Von Kaenel, Jason','Von kaenel, Jason');

-- Rich Wagner = Richard Wagner.
-- Rich Wagner Jr = Rickie, Richie and Rick

call sp_fixname('Wagner, Rich','Wagner, Richard');
call sp_fixname('Wagner Jr, Rich','Wagner, Richie');
call sp_fixname('Wagner Jr, Rich','Wagner, Rick');
call sp_fixname('Wagner Jr, Rich','Wagner, Rickie');

call sp_fixname('Westwood, Chad','Westwood, Chadd');

call sp_fixname('Willis II, Ed','Willis, Ed II');
call sp_fixname('Willis II, Ed','Willis, Ed');

-- Chris <> Christopher Wright fyi.

-- Dayan and Daniel Yami different

call sp_fixname('Zachery, Brian','Zachry, Brian');

call sp_fixname('Zalegowski, Chris','Zagelgowski, Chris');

call sp_fixname('Zera, Blase','Zera, Blasé');
call sp_fixname('Zera, Blase','Zera, Blas?');

call sp_fixname('Ziolo, Michael','Ziolo, Mike');


select * from results where loser like 'Yurg%';

call sp_fixname('Kruger, John','Kruger,');
call sp_fixname('Kruger, John','Kruger,J');

call sp_fixname('Yurgaitis, David','Yurgaitis,');

call sp_fixname('Rudich, Matt','Rudich,M');

call sp_fixname('Lowe, Mike','Lowe,M');

call sp_fixname('Gillooly, John','Gillooly,?');
call sp_fixname('Gillooly, John','Gillooly, ?');

call sp_fixname('Isley, Mark','Isley,M');









/* ------------------------------------------------------------------------------------------------- */
/* WRT data now: some duplicates from above */
/* ------------------------------------------------------------------------------------------------- */


-- master WRT name cleanup; put results, seedings, rankings in one file.

-- use cp30725_wrt;

-- SET SQL_SAFE_UPDATES = 0;

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


-- select * from results where season='2016-17' and loser like '%Martel%';

-- select * from rankings where player like '%Martel%';

call sp_fixname('Perez, Hanzel Martinez','Martinez Perez Hanzel');

call sp_fixname('Samson, Fred','Samson, Ferd');





/*
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;
*/










/* ------------------------------------------------------------------------------------------------- */
/* LPRT data last  */
/* ------------------------------------------------------------------------------------------------- */


-- LPRT master name cleanup

-- use cp30725_women;

-- SET SQL_SAFE_UPDATES = 0;

-- LPRT master name cleanup


/*
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;

create table results_prenamefix_20162210 as select * from results;

select * from results where winner='Carplo, Jvonne' or loser='Carplo, Jvonne';
select * from results where winner='Carpio, Ivonne' or loser='Carpio, Ivonne';
*/

-- Fixes:

-- Apostrophe names to address:

-- Davis, D'amonique
-- Grand'Maitre, Josee
-- O'Brien, Molly

call sp_fixname ('OBrien, Molly','O''Brien, Molly');
call sp_fixname ('OBrien, Molly','O''brien, Molly');
call sp_fixname ('OBrien, Molly','Obrien, Molly');

call sp_fixname ('Davis, Damonique','Davis, D''amonique');
call sp_fixname ('Davis, Damonique','Davis, Da''monique');

call sp_fixname ('GrandMaitre, Josee','Grand''Maitre, Josee');
call sp_fixname ('GrandMaitre, Josee','Grand Maitre, Josee');
call sp_fixname ('GrandMaitre, Josee','Grand''MaŒtre, Jos‚e');

----

call sp_fixname ('Acosta, Susana','Acosta, Susy');
call sp_fixname ('Acosta, Susana','Acosta-Mendoza, Susy');

call sp_fixname ('Carpio, Ivonne','Carplo, Jvonne');
call sp_fixname ('Carpio, Ivonne','Carplo, Ivonne');


call sp_fixname ('Haynes (Fisher), Adrienne','Fisher, Adrienne');
call sp_fixname ('Haynes (Fisher), Adrienne','Haynes, Adrienne');
call sp_fixname ('Haynes (Fisher), Adrienne','Fisher Haynes, Adrienne');
call sp_fixname ('Haynes (Fisher), Adrienne','Fisher Haynes');

call sp_fixname ('Fisher, Kelley','Fisher, Kelly');

-- this is wrong!  Had to do major clean up here.
-- call sp_fixname ('Drexler (Greer), Marci','Greer, Marci');
-- call sp_fixname ('Drexler (Greer), Marci','Drexler, Marci');

call sp_fixname ('Gudinas, Cheryl','Gudinas Holmes, Cheryl');
call sp_fixname ('Gudinas, Cheryl','Gudinas-Holmes, Cheryl');

call sp_fixname ('Guillemette, Veronique','Guillemette, Vernoique');
call sp_fixname ('Guillemette, Veronique','Guillimette, Veronique');
call sp_fixname ('Guillemette, Veronique','Guillimette, Veronica');
call sp_fixname ('Guillemette, Veronique','Guillemette, Veronica');
call sp_fixname ('Guillemette, Veronique','Guillemette, V‚ronique');


call sp_fixname ('Kwon, Marie Malhee','Kwon, Malhee');

call sp_fixname ('Loredo, Arantza','Lored, Arantza');

call sp_fixname ('Pimentelli, Devon','Pinentelli, Devon');

call sp_fixname ('Paraiso, Jackie','Paraiso-Gibson, Jackie');
call sp_fixname ('Paraiso, Jackie','Gibson, Jackie');
call sp_fixname ('Paraiso, Jackie','Rice, Jackie');
call sp_fixname ('Paraiso, Jackie','Paraiso Rice, Jackie');
call sp_fixname ('Paraiso, Jackie','Paraiso-Rice, Jackie');
call sp_fixname ('Paraiso, Jackie','Rice, Jackie Paraiso');

-- Joy = Jackie's twin sister
call sp_fixname ('Paraiso-MacKenzie, Joy','Paraiso, Joy');
call sp_fixname ('Paraiso-MacKenzie, Joy','MacKenzie, Joy');


-- Not bothering with this one since she retired before marrying?  Should probably fix.
call sp_fixname ('Waselenchuk (Russell), Kim','Russell, Kim');
call sp_fixname ('Waselenchuk (Russell), Kim','Waselenchuk, Kim');

call sp_fixname ('Solis, Samantha Salas','Salas, Samantha');

-- She played before and after marriage, so fix.
call sp_fixname ('Huczek (Van Hees), Christie','Van Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Huczek, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van-Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van-Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van Hess, Kristi');
call sp_fixname ('Huczek (Van Hees), Christie','Van Hees, Kristi');

call sp_fixname ('Wachtel (Stoffregen), Kerri','Wachtel, Kerri');
call sp_fixname ('Wachtel (Stoffregen), Kerri','Stoffregen, Kerri');
call sp_fixname ('Wachtel (Stoffregen), Kerri','Stoffregen Wachtel, Kerri');

call sp_fixname ('Warhftig, Sarah','Warhaftig, Sarah');

call sp_fixname ('Lucas (Wiragh), Michelle','Wiragh, Michelle');
call sp_fixname ('Lucas (Wiragh), Michelle','Lucas, Michelle');

-- Leaving out maiden name since she retired before marrying
call sp_fixname ('Wright, Shannon','Wright-Hamilton, Shannon');

call sp_fixname ('Ruiz (Roehler), Aimee','Roehler, Aimee');
call sp_fixname ('Ruiz (Roehler), Aimee','Ruiz, Aimee');

-- Not using her married name; played before got married
call sp_fixname ('Tisinger, Janel','Take (Tisinger), Janel');
call sp_fixname ('Tisinger, Janel','Take, Janel');

call sp_fixname ('Tisinger-Moore, Debbie','Tisinger, Debbie');


call sp_fixname ('Bellows (Walsh), Kristen','Walsh, Kristen');
call sp_fixname ('Bellows (Walsh), Kristen','Bellows, Kristen');
call sp_fixname ('Bellows (Walsh), Kristen','Walsh, Kristin');


call sp_fixname ('Gould (Gilman), Michelle','Gould, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman-Gould, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman Gould, Michelle');

-- Not bothering with this one since she retired before marrying?
-- call sp_fixname ('Conine (Doyle), Cindy','Doyle, Cindy');
-- call sp_fixname ('Conine (Doyle), Cindy','Doyle, Cindy');
-- call sp_fixname ('Conine (Doyle), Cindy','Doyle, Cindy');


-- Bailey, Malia from  Malia Kamahoahoa Bailey
call sp_fixname ('Bailey (Kamahoahoa), Malia','Bailey Kamahoahoa, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Bailey, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Kamahoahoa, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Kamahohoa, Malia');

call sp_fixname ('Kelly (Fischl), Dottie','Fischl, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl, Dot');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl, ?');
call sp_fixname ('Kelly (Fischl), Dottie','Fishl, Dottie');


-- married dec 2014
call sp_fixname ('Thomas (Irons), Kimberly','Irons, Kimberly');
call sp_fixname ('Thomas (Irons), Kimberly','Thomas, Kim');
call sp_fixname ('Thomas (Irons), Kimberly','Irons, Kim');
call sp_fixname ('Thomas (Irons), Kimberly','Thomas, Kimberly');

-- married Mar2014?
call sp_fixname ('Soley (Rascon), Sofia','Rascon, Sofia');
call sp_fixname ('Soley (Rascon), Sofia','Soley, Sofia');
call sp_fixname ('Soley (Rascon), Sofia','Rason, Sofia');


-- married as of mid 2013
call sp_fixname ('Kirch (OBrien), Aubrey','O''Brien, Aubrey');
call sp_fixname ('Kirch (OBrien), Aubrey','OBrien, Aubrey');
call sp_fixname ('Kirch (OBrien), Aubrey','Kirch, Aubrey');

call sp_fixname ('Lee, Young Ock','Lee, Youngock');
call sp_fixname ('Lee, Young Ock','Youngcock, Lee');

call sp_fixname ('Young-Mi, Lee','Young, Milee');

-- Married and then not
call sp_fixname ('Feaster, Shannon','Feaster-Stewart, Shannon');
call sp_fixname ('Feaster, Shannon','Feaster Stewart, Shannon');
call sp_fixname ('Feaster, Shannon','Stewart, Shannon');


-- Seemed to go by Jo, not proper Johanna
call sp_fixname ('Shattuck, Jo','Shattuck, Johanna');
call sp_fixname ('Shattuck, Jo','Shattuk, Jo');

-- Hostovich, Candi: not updating since played before marriage; now is Candi Linkous
call sp_fixname ('Linkous (Hostovich), Candi','Hostovich, Candi');
call sp_fixname ('Linkous (Hostovich), Candi','Linkous, Candi');
call sp_fixname ('Linkous (Hostovich), Candi','Linkous-Hostovich, Candi');

-- somehow kept inserting with the trailing "T." ... removing everywhere.
call sp_fixname ('Lambert, Frederique','Lambert, Frederique T.');
call sp_fixname ('Lambert, Frederique','Lambert, Fr‚d‚rique');

-- Lots of variations for Kristen Fritz

call sp_fixname ('Jones (Fritz), Kristen','Fritz, Kristen');
call sp_fixname ('Jones (Fritz), Kristen','Fritz, Kristin');
call sp_fixname ('Jones (Fritz), Kristen','Junkin, Kristen');
call sp_fixname ('Jones (Fritz), Kristen','Fritz Junkin, Kristen');
call sp_fixname ('Jones (Fritz), Kristen','Junkin (Fritz), Kristen');
call sp_fixname ('Jones (Fritz), Kristen','Junkin Jones, Kristen');

call sp_fixname ('Amaya, Cristina','Amaya, Christina');
call sp_fixname ('Barriga, Loreto','Barriga, Loreta');

call sp_fixname ('Vargas, Maria Jose','Vargas, Maria');
call sp_fixname ('Vargas, Maria Jose','Jose Maria, Vargas');

call sp_fixname ('Nunez, Ana Paola','Nunez, Paola');
call sp_fixname ('Nunez, Ana Paola','Nunez, Ana');


-- Keri Allen vs Kerri Allen: went with Kerri
call sp_fixname ('Allen, Kerri','Allen, Keri');

-- Is this right??
-- eventually gets married I believe: Dana Sibell-Anderson
call sp_fixname ('Sibell-Anderson, Dana','Anderson, Dyan');
call sp_fixname ('Sibell-Anderson, Dana','Anderson, Dana');



call sp_fixname ('Andrade, Claudia','Andrade, Claudio');

-- Seen this three different ways: Alissa, Alyssa, Elissa.  Going with Elissa but coudl be wrong
call sp_fixname ('Beltranena, Elissa','Beltranena, Alissa');
call sp_fixname ('Beltranena, Elissa','Beltranena, Alyssa');

call sp_fixname ('Jacobson-Prentice, Brandi','Jacobson, Brandi');
call sp_fixname ('Jacobson-Prentice, Brandi','Jacobson Prentice, Brandi');
call sp_fixname ('Jacobson-Prentice, Brandi','Prentice, Brandi');
call sp_fixname ('Jacobson-Prentice, Brandi','prentice, Brandi Jacobson');

call sp_fixname ('Bevelock, Toni','Bevelock, Tony');

call sp_fixname ('Boyea, Sherron','Boyea, Sharron');

call sp_fixname ('Brodeur, Genevieve','Brodeur, Genevive');
call sp_fixname ('Brodeur, Genevieve','Brodeur,Genevieve Ste-Rosalie');
call sp_fixname ('Brodeur, Genevieve','Brodeour, Genevieve');

-- Nee  Tammy Rae Brockbank
-- married as Brown, since divorced and now Tammy Brockbank Uriguen; Tammy Brockbank-Uriguen
-- going with older married name since retired before remarried

call sp_fixname ('Brown (Brockbank), Tammy','Brown, Tamy');
call sp_fixname ('Brown (Brockbank), Tammy','Brockbank Brown, Tammy');
call sp_fixname ('Brown (Brockbank), Tammy','Brockbank, Tammy');
call sp_fixname ('Brown (Brockbank), Tammy','Brown, Tammy');






call sp_fixname ('Carbajal, Jessie','Carbajal, Jesse');

call sp_fixname ('Cardoza, Paola','Cardozo, Paola');
call sp_fixname ('Cardoza, Paola','Cardoza, Paola Nunez');

call sp_fixname ('Orozco, Cecilia','Cecilia Orozco');

call sp_fixname ('Collins, Wanda','Colins, Wanda');

call sp_fixname ('Csuk, Krystal','Csuk, Crystal');
call sp_fixname ('Csuk, Krystal','Czuk, Krystal');

-- May want to put her full name in?
call sp_fixname ('Daza, Jenny','Daza Navia Jenny');
call sp_fixname ('Daza, Jenny','Navia, Jenny Daza');

call sp_fixname ('Deutsch, Lauren','Deutsch. Lauren');

call sp_fixname ('Acquilar, Diana','Diana Acquilar');
call sp_fixname ('Acquilar, Diana','Aguilar, Diana');

call sp_fixname ('Holtslander, Khanh','Holtslander, Khahn');

call sp_fixname ('Saunders, Jennifer','Jennifer Saunders');

call sp_fixname ('Gremley, Kelly','Kelly Gremley');

call sp_fixname ('Kwon, Marie Malhee','Kwon, Mahlee');

call sp_fixname ('Luque, Carolina','Luque Carolina');
call sp_fixname ('Luque, Carolina','Carolina Luque');

call sp_fixname ('Maldonado, Anita','Maldonaldo, Anita');

call sp_fixname ('Maldonado, Jessica','Maldonaldo, Jessica');

call sp_fixname ('DelliSanti, Maria','Maria DelliSanti');
call sp_fixname ('Delli-Santi, Maria','DelliSanti, Maria');

call sp_fixname ('McElfresh, Melissa','McElfrish, Melissa');

call sp_fixname ('Molina, Daniela','Molina, Damiela');

call sp_fixname ('Morton, Karen','Mortom, Karon');
call sp_fixname ('Morton, Karen','Morton, Karon');
call sp_fixname ('Morton, Karen','Morton, karen');



call sp_fixname ('Parades Guillen, Islhey','Parades Guillen,');

call sp_fixname ('Parades Guillen, Islhey','Parades, Islhey');

call sp_fixname ('Munoz, Maria Paz','Paz Munoz, Maria');

call sp_fixname ('Rivera, Joanna','Rivera, Jhoana');
call sp_fixname ('Rivera, Joanna','Rivera, Johanna');
call sp_fixname ('Rivera, Joanna','Rivera, Johana');



call sp_fixname ('Rodriguez, Maria Renee','Rodriguez, Maria');

call sp_fixname ('Sato, Maiko','Satou, Maiko');

call sp_fixname ('Schlichemeyer, Alison','Schlichemeyer, Allison');

call sp_fixname ('Trachsel, Jamie','Trachsel. Jamie');

call sp_fixname ('Turgeon, Chantal','Turgeon, Shantal');

call sp_fixname ('Washington, Genevieve','Washington, Ginny');

-- Krystal Csuk formerly?
call sp_fixname ('Ackermann, Krystal','Ackerman, Krystal');

call sp_fixname ('Aldrede, Luisa','Aldrete, Luisa');

call sp_fixname ('Anguiano, Tania','Aquiano, Tonya');
call sp_fixname ('Anguiano, Tania','Aguiano, Tonya');




call sp_fixname ('Blaakman, Alicia','Blaakman, Ali');

call sp_fixname ('Brewer, Amie','Brewer, Aime');

-- Should we standardize on Fran or Francine Davis?
call sp_fixname ('Davis, Fran','Davis, Francine');
call sp_fixname ('Davis, Fran','Davis, Fransine');

call sp_fixname ('Drury, Danielle','Drury, Daniele');

call sp_fixname ('Ferina, Kimberly','Ferina, Kimi');
call sp_fixname ('Ferina, Kimberly','Ferina, Kim');

call sp_fixname ('Friedman, Randy','Freidman, Randi');
call sp_fixname ('Friedman, Randy','Freidman, Randy');
call sp_fixname ('Friedman, Randy','Freidman, Randi');
call sp_fixname ('Friedman, Randy','Friedman, Randi');


call sp_fixname ('Gluvna-Isett, Kathy','Glavine-iset, Kathy');

call sp_fixname ('Guzman Velgis, Eleni','Guzman, Eleni');
call sp_fixname ('Guzman Velgis, Eleni','Guzman, Eleny');

call sp_fixname ('Hamilton, Karina','Hamilton, karina');

call sp_fixname ('Herrera, Alexandra','Herrera, Alexandria');

-- definitely with an e, not an I
call sp_fixname ('Hettesheimer, Holly','Hettisheimer, Holly');
call sp_fixname ('Hettesheimer, Sarah','Hettisheimer, Sarah');

call sp_fixname ('Kreigler, Carol','Krieger, Carol');

-- Should we put in her maiden Salazar?
call sp_fixname ('Leveque (Salazar), Cintya','Leveque, Cintya');
call sp_fixname ('Leveque (Salazar), Cintya','Leveque Salazar, Cintya');
call sp_fixname ('Leveque (Salazar), Cintya','Salazar-Leveque, Cinyta');

call sp_fixname ('Marriott, Janell','Marriott, Janel');
call sp_fixname ('Marriott, Janell','Marriot, Janelle');
call sp_fixname ('Marriott, Janell','Marriott, Jannell');
call sp_fixname ('Marriott, Janell','Marriott, J');

call sp_fixname ('Martinez, Gabriela','Martinez, Gabriella');

call sp_fixname ('Morissette, Michele','Morisette, Michelle');

call sp_fixname ('Noda, Etsuko','Noda, Estuko');

call sp_fixname ('Noller, Cristie','Noller, Christee');

call sp_fixname ('Odegard, Karina','Odegaard, Karina');

call sp_fixname ('Parrilla, Jessica','Parilla, Jessica');

call sp_fixname ('Perez, Montserrat','Perez, Montse');

call sp_fixname ('Perrin, Robyn','Perrin, Robin');
call sp_fixname ('Perrin, Robyn','Perren, Robin');
call sp_fixname ('Perrin, Robyn','Perren, Robyn');

-- is this the former Orozco, Cecilia?  yes
call sp_fixname ('Orozco, Cecilia','Orozco,  Cecilia');
call sp_fixname ('Pratt (Orozco), Cecilia','Pratt, Ceci');
call sp_fixname ('Pratt (Orozco), Cecilia','Pratt, Cecilia');
call sp_fixname ('Pratt (Orozco), Cecilia','Orozco, Cecilia');

call sp_fixname ('Rehling, Roxanne','Rehling, Rozanne');

-- What was Holly Remen's maiden name?  Was it Gray?  I believe so; leave it Gray?
-- call sp_fixname ('Remen (Gray), Holly','Gray, Holly');



-- Is Rivera, Anna == Rivera, Ana Kristin ? 



call sp_fixname ('Saunders, Jennifer','Saunders, Jen');

-- Leaving out maiden name since she retired before marrying
call sp_fixname ('Walton, Karin','Walton-Trent, Karin');

call sp_fixname ('Kubany, Sandy','Kubany, Sandra');

call sp_fixname ('Crawford, Ellen','Crawford, Elaine');

call sp_fixname ('Sanders, Lourdes','Sanders Garcia, Lourdes');
call sp_fixname ('Sanders, Lourdes','Sanders, Lourdes Garcia');

call sp_fixname ('Foster, Amy','Foster, Amy Kilbane');
call sp_fixname ('Foster, Amy','Kilbane Foster, Amy');

call sp_fixname ('Powell, Lori-Jane','Powell, L.J.');
call sp_fixname ('Powell, Lori-Jane','Powell, Lori');
call sp_fixname ('Powell, Lori-Jane','Powell, Lori Jane');


call sp_fixname ('Dunn (MacDonald), Amanda','Dunn, Amanda MacDonald');
call sp_fixname ('Dunn (MacDonald), Amanda','MacDonald, Amanda');
call sp_fixname ('Dunn (MacDonald), Amanda','Dunn (MacDonald)');
call sp_fixname ('Dunn (MacDonald), Amanda','Dunn, Amanda');

call sp_fixname ('Lynch, Marcy','Lynch, Marci');

call sp_fixname ('Coburn, Lynne','Coburne, Lynne');
call sp_fixname ('Coburn, Lynne','Coburn, Lynn');

call sp_fixname ('Torres, Rosy','Torres, Rosie');

call sp_fixname ('Ferriera-Worth, Dee','Worth, Dee');
call sp_fixname ('Ferriera-Worth, Dee','Ferriera, Dee');
call sp_fixname ('Ferriera-Worth, Dee','Ferriera-Worth');
call sp_fixname ('Ferriera-Worth, Dee','Ferreira, Dee');
call sp_fixname ('Ferriera-Worth, Dee','Ferreria, Dee');


call sp_fixname ('Aguilar, Vicki','Aquilar, Vicki');

-- New name for Cathy Nichols
call sp_fixname ('Nichols, Cathy','Nichols-dickinson, Catherine');
call sp_fixname ('Nichols, Cathy','Nichols, Catherine');
call sp_fixname ('Nichols, Cathy','Nichols-Dickinson, Catherine');	
call sp_fixname ('Nichols, Cathy','Nichols Dickinson, Catherine');	
call sp_fixname ('Nichols, Cathy','Nicholls, Cathy');

-- No, this is wrong
call sp_fixname ('von Ondarza, Ramona','Vonondarza, Ramona');
call sp_fixname ('von Ondarza, Ramona','Von Ordaraza, Ramona');

call sp_fixname ('Flores Segovia, Anakaren','Segovia, Anakaren Flores');	

call sp_fixname ('Gonzalez, Andrea Martinez','Martinez, Andrea');	

call sp_fixname ('Guzman Velgis, Eleni','Velgis, Eleni Guzman');	

call sp_fixname ('Del Granado Revollo, Gabriela','Revollo, Gabriela');	

call sp_fixname ('Gordon, Mariana Tobon','Tobon, Marianna');	
call sp_fixname ('Gordon, Mariana Tobon','Tobon, Mariana');	

-- now Michelle De La Rosa.  Keep an eye out.
call sp_fixname ('Key, Michelle','Ke, Michelle');	

-- Sharon Jackson went to Sharon Fox, now back to Sharon Jackson

call sp_fixname ('Bryant, Debbie','Bryant, Debra');	

call sp_fixname ('Earl, Michele','Earl, Michelle');	

-- not sure which is right
call sp_fixname ('Florentino, Lorrissa','Florentia, Larissa');	

call sp_fixname ('Gillhouse, Annette','Gillhouse, Annete');	

call sp_fixname ('Youko, Makai','Youko, Makni');	

-- Rita Hoff married; now Rita Hoff Scott.

call sp_fixname ('Hoff-Scott, Rita','Hoff, Rita');
call sp_fixname ('Hoff-Scott, Rita','Hoff-Scott, ?');
call sp_fixname ('Hoff-Scott, Rita','Scott, Rita');


call sp_fixname ('Bertucci, Catherine','Bertucci, Cathy');

call sp_fixname ('Borgwhat, Melissa','Borgwat, Melissa');

call sp_fixname ('Dugan, Susie','Dugan, ?');

call sp_fixname ('Farmer, Lynn','Farmer, ?');
call sp_fixname ('Farmer, Lynn','Farmer, Lynne');

call sp_fixname ('Faulkenberry, Barbara','Faulkenberry, Barb');

call sp_fixname ('Gerou, Nancy','Gerou, ?');

call sp_fixname ('Gluvna-Isett, Kathy','Gluvna, ?');

call sp_fixname ('Healy-Avergis, Carrie','Healy, ?');

call sp_fixname ('Jeffers, Brenda','Jeffers, ?');

call sp_fixname ('Matthews, Jan','Matthews, ?');

call sp_fixname ('McCarthy, Camille','McCarthy, ?');

call sp_fixname ('Moore, Alicia','Moore, ?');

call sp_fixname ('Murphy, Sally','Murphy, ?');

call sp_fixname ('Myer, Donna','Myer, ?');

call sp_fixname ('Oeschger, Jean','Oeschger, ?');

call sp_fixname ('Parent, Monique','Parent, ?');

-- Married in the 83-84 timeframe.
call sp_fixname ('Poe-Barrett, Brenda','Poe, Brenda');

call sp_fixname ('Rassenti, Dena','Rasseni, Dena');

call sp_fixname ('Rumler, Alison','Rumler, Allison');

call sp_fixname ('Schmidt, Pat','Schmidt, ?');

-- not sure which way is correct; going with one, could be the other
call sp_fixname ('Segal, Janis','Seagal, Jancie');

call sp_fixname ('Tennesson, Barb','Tennessen, ?');

call sp_fixname ('Weisbach, Hope','Weisbach, ?');

call sp_fixname ('Carow, Sue','Carow, ?');

call sp_fixname ('Fredrickson, Cathie','Fredericksen, ?');

call sp_fixname ('Low, Tamara','Low, ?');

call sp_fixname ('Paese, Val','Paese, ?');
call sp_fixname ('Paese, Val','Pease, Val');

-- Pritchard == Pritchett?  i dunno

call sp_fixname ('Riley, Elaine','Riley, ?');

call sp_fixname ('Robson, Sandy','Robson, ?');

call sp_fixname ('Steere, Janet','Steere, ?');

call sp_fixname ('Bell, Babette','Bell, ?');

call sp_fixname ('Cherry, Lynn','Cherry, ?');

call sp_fixname ('Latham, Terry','Latham, ?');

call sp_fixname ('Laursen, Pam','Lauresen, ?');

call sp_fixname ('Morris, Mary Pat','Morris, ?');

call sp_fixname ('Petrocy, Tina','Petracy, Tina');

call sp_fixname ('Rasmussen, Trina','Rasmussen, ?');
call sp_fixname ('Rasmussen, Trina','Rassmussen, Trina');

call sp_fixname ('Reyes, Diana','Reyes, ?');

call sp_fixname ('Sklenka, Mary Pat','Sklenka, ?');

call sp_fixname ('Burton, Donna','Burton, ?');

-- Faulkenberg, Barb same as Faulkenberry, Barbara ??

call sp_fixname ('Hammock, Lydia','Hammock, ?');

call sp_fixname ('King, Melissa','King, ?');

call sp_fixname ('Lockey, Renee','Lockey, ?');

call sp_fixname ('Shields, Colleen','Shields, ?');

call sp_fixname ('Whitmore, Robin','Whitmore, ?');
call sp_fixname ('Whitmore, Robin','Whitmire, Robin');

-- might be backwards
call sp_fixname ('Wojeck, Lynn','Wojcik, Lynn');

call sp_fixname ('Chin-Varon, Mae','Chin, Mae');

call sp_fixname ('Dee-Jolly, Mary','Dee-Jolly, ?');
call sp_fixname ('Dee-Jolly, Mary','Dee, Mary');

call sp_fixname ('Erardi, Denny','Erardi, Denni');

call sp_fixname ('Olson, Roz','Olsen, Roz');

call sp_fixname ('Risch, Jennifer (JJ)','Risch, ?');

call sp_fixname ('Supanick, Bev','Supanick, Beverly');

call sp_fixname ('Barron, Marie','Baron, Marie');

call sp_fixname ('Bessent, Stephanie','Bessenet, Stephanie');

-- what are the odds that Kippi Bishop <> Kipie Boatright?

-- Is Lynn Cherry == Chad Cherry?

call sp_fixname ('Gopie, Jacqueline','Gopie, Jackie');


-- 2016-17 rankings fixes
call sp_fixname ('Enriquez, Nancy','Nancy Enriquez');

call sp_fixname ('Carolina Rivera','Rivera, Carolina');

call sp_fixname ('Maldonado, Denisse','Maldonado, Danisse');

call sp_fixname ('Rivera, Ana Kristina','Rivera, Ana Kristin');

call sp_fixname ('Herrera Cristina, Daniela','Herrera, Daniela');

call sp_fixname ('Hallett, Sandy','Sally Hallett');
call sp_fixname ('Hallett, Sandy','Sandy Hallett');
call sp_fixname ('Hallett, Sandy','Hallett, Sally');
call sp_fixname ('Hallett, Sandy','Hallet, Sally');
call sp_fixname ('Hallett, Sandy','Hallet, Sandy');

call sp_fixname ('Jungeon, Ana','Ana Jungeon');

call sp_fixname ('Seok, Jin Young','Jin Young Seok');


commit;


select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;






