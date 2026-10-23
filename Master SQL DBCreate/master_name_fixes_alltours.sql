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
Oct 2017	tboss	updated with some fixes stemming from IRF, Amateur entries.

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
create table player_profile_20170117 as select * from player_profreyile;


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

call sp_fixname('Brumfield, Charlie','Brumfield, Charles');
call sp_fixname('Brumfield, Charlie','Brumfeld, Charlie');

call sp_fixname('Bustillos, Luis','Busillos, Luis');

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
call sp_fixname('May, Shane','May,S');
call sp_fixname('May, Shane','May, S');

call sp_fixname('Fitzpatrick, Gene','Fitzpatrick,G');
call sp_fixname('Fitzpatrick, Gene','Fitzpatrick, Eugene');

-- probably a mistake here: Meyers,L == Larry Meyers.
-- call sp_fixname('Myers, Lindsay','Meyers,L');
-- call sp_fixname('Myers, Lindsay','Meyers,L');

-- one T in harnett's name

call sp_fixname('Harnett, Bret','Harnett, Brett');

call sp_fixname('Myers, Lindsay','Meyers, Lindsay');
call sp_fixname('Myers, Lindsay','Meyers, Lindsey');
call sp_fixname('Myers, Lindsay','Myers, Lindsey');

call sp_fixname('Negrete, J','Negrete,J');

call sp_fixname('Niederhoffer, Victor','Niederhoffer,Vic');
call sp_fixname('Niederhoffer, Victor','Neiderhoffer,Vic');
call sp_fixname('Niederhoffer, Victor','Neiderhoffer, Victor');

call sp_fixname('Palazzo, Joe','Palozzi, Joe');
call sp_fixname('Plazak, Jeff','Plazak,J');
call sp_fixname('Richards, Torrey','Richards, torrey');
call sp_fixname('Roberts, Andy','Rob');
call sp_fixname('Rodriguez, Bobby','Rodriguez,B');

call sp_fixname('Sacco, Joey','Sacco,J');
call sp_fixname('Simonette, Dave','Simonette,D');

call sp_fixname('Thoerner, Jason','Thoerner');
call sp_fixname('Thoerner, Jason','Thorner, Jason');

call sp_fixname('?','Unknown');
call sp_fixname('Waggoner, Jason','Wagonner,J');

call sp_fixname('Wetherbee, John','Wetherbe, John');
call sp_fixname('Wetherbee, John','Weatherbee, John');

call sp_fixname('Winterton, Jim','Winterton,J');

/* later on name fixing */
call sp_fixname('Cohen, Doug','Cohen,D');
call sp_fixname('Koltun, Ben','Koltun,B');
call sp_fixname('Champagne, Bo','Champagne,B');

-- 8/5/19: Gordon Kelly per a Hogan article; also noted that Kelly, results from 1977 have to be him too
call sp_fixname('Kelly, Gordon','Kelly,G');
call sp_fixname('Kelly, Gordon','Kelly, Gordon');
call sp_fixname('Kelly, Gordon','Kelly,');



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
call sp_fixname('Campbell, Darin','Campbell,D');

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
call sp_fixname('De Los Rios, Gil','De Los Rios, Gilberto');

-- wow, had this wrong for years
call sp_fixname('Desrochers, Eric','Derouchers, Eric');
call sp_fixname('Desrochers, Eric','Derochers, Eric');
call sp_fixname('Desrochers, Eric','Desrochers, Eric');
call sp_fixname('Desrochers, Eric','Derocheres, Eric');
call sp_fixname('Desrochers, Eric','Derocheres, Eric');




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
call sp_fixname('Funatani, Sadao','Funatini, Sadeo');
call sp_fixname('Funatani, Sadao','Funatani, Sadeo');

call sp_fixname('Furhmann, Tom','Furhman, Tom');

call sp_fixname('Ghafarshad, Dawoud','Ghafarshad, Dawould');

-- all Polo.  Full proper name = Leopoldo Gutierrez Sortes

call sp_fixname('Gutierrez, Polo','Guitierrez, Polo');
call sp_fixname('Gutierrez, Polo','Guitierrez, Leopolo');
call sp_fixname('Gutierrez, Polo','Gutierrez, Leopolo');
call sp_fixname('Gutierrez, Polo','Gutierrez, Leo');
call sp_fixname('Gutierrez, Polo','Guitterez, Leo');
call sp_fixname('Gutierrez, Polo','Gutierrez, Leopoldo');
call sp_fixname('Gutierrez, Polo','Gutierrez, Polito');
call sp_fixname('Gutierrez, Polo','Gutierrez Sortes, Polo');
call sp_fixname('Gutierrez, Polo','Gutierrez Sortes, Leopolo');
call sp_fixname('Gutierrez, Polo','Guitierrez, Leopoldo');

call sp_fixname('Husulak, Nathaniel','Husalak, Nathaniel');
call sp_fixname('Husulak, Nathaniel','Husucak, Nathaniel');
call sp_fixname('Husulak, Nathaniel','Husalak, Nathaniel');
call sp_fixname('Husulak, Nathaniel','Husulack, Nathaniel');
call sp_fixname('Husulak, Nathaniel','Husalak, Nataniel');

call sp_fixname('Husulak, Barrett','Husulak, Barret');
call sp_fixname('Husulak, Barrett','Husalak, Barrett');
call sp_fixname('Husulak, Barrett','Husulack, Barret');


-- call sp_fixname('KMessier, Matthieu','Messier, Matthew');
call sp_fixname('Messier, Matthieu','Messier, Matthew');
call sp_fixname('Messier, Matthieu','KMessier, Matthieu');


call sp_fixname('Kono, Michimune','Kono, Michimine');
call sp_fixname('Kono, Michimune','Michimune');
call sp_fixname('Kono, Michimune','Kono, Michimue');

call sp_fixname('Miller, Darrell','Miller, Darrel');

call sp_fixname('Moccia, Mark','Moccia, Marc');

call sp_fixname('Patendue, Patrick','Patenadue, Patrick');

call sp_fixname('Peinada, Daniel','Peinado, Daniel');
call sp_fixname('Peinada, Daniel','Peinada, Darie');

call sp_fixname('Perdomo, Simon','Perdoma, Simon');

call sp_fixname('Ramirez, Tony','Rameriz, Tony');


call sp_fixname('Schraeder, Caleb','Schrader, Caleb');


-- full name: Juan Carlos Torres Honoj ; standardizing on Juan Carlos Torres

call sp_fixname('Torres, Juan Carlos','Torres, Juan');
call sp_fixname('Torres, Juan Carlos','Honoj, Juan carlos');
call sp_fixname('Torres, Juan Carlos','Honoj, Juan Carlos');
call sp_fixname('Torres, Juan Carlos','Honoj, Juan Carlos Torres');


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
call sp_fixname('OBrien, Tom','O''Brien, Tom');
call sp_fixname('OBrien,?','O''Brien,?');

call sp_fixname('OConnor,J','O''Connor,J');
call sp_fixname('OConnor,J','O''Connor,J');

call sp_fixname('ONeil, Todd','O''Neil, Todd');
call sp_fixname('ONeil, Todd','O''Neil, Todd');
call sp_fixname('ONeil, Todd','Oneil,T');
call sp_fixname('ONeil, Todd','Oneil, Todd');
call sp_fixname('ONeil, Todd','O''Neil,T');
call sp_fixname('ONeil, Todd','O''Neil, Todd');

-- D'Ambrogia, James
call sp_fixname('D''Ambrogia, James','Dambrogia, James');
call sp_fixname('D''Ambrogia, James','DAmbrogia, James');


call sp_fixname('OCallaghan, Noel','O''Callaghan, Noel');

call sp_fixname('OLoan, Stephen','O''Loan, Stephen');



/* 10/7/08: fixing minor name issue found doing name research */

call sp_fixname('Rodriguez, Manuel','Rodriquez, ?');

call sp_fixname('Sutherland, Bill','Sutherland, ?');


/* 10/8/08: Marty Hogan recalls many older players w/o first names */

call sp_fixname('Alder, Dan','Alder,D');
call sp_fixname('Bolan, Bobby','Bolan,B');
call sp_fixname('Bowes, Wayne','Bowes,W');
call sp_fixname('Britos, John','Britos,J');
call sp_fixname('Britos, Peter','Britos,P');

/* Apr 2024: Canadian pros from Chelsea George */
call sp_fixname('Daku, Bob','Daku,B');
call sp_fixname('Hadikin, Wes','Hadikin,W');
call sp_fixname('Kruger, Brad','Kruger,B');
call sp_fixname('Suffron, Ken','Sufforn,K');


-- Feb 2021 definitely eric with a C from his FB page
-- call sp_fixname('Campbell, Erik','Campbell, Eric');
call sp_fixname('Campbell, Erik','Campbell,E');
call sp_fixname('Campbell, Erik','Campbell, E');
call sp_fixname('Campbell, Eric','Campbell, Erik');


call sp_fixname('Campbell, Mitch','Campbell,M');
call sp_fixname('Campbell, Mitch','Campbell, M');
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
call sp_fixname('Martino, Mark','Martino, M');
call sp_fixname('Matthews, Matt','Matthews,M');
call sp_fixname('Mondry, Steve','Mondry,S');
call sp_fixname('Navarro, Ray','Navarro,R');
call sp_fixname('Porco, Ken','Porco,K');
call sp_fixname('Roderick, Myron','Roderick,M');

call sp_fixname('Romano, Mike','Romano,M');
call sp_fixname('Romano, Mike','Romano, M');

call sp_fixname('Rubenstein, Ron','Rubenstein,R');
call sp_fixname('Sulli, Steve','Sully,S');
call sp_fixname('Terry, Evan','Terry,E');
call sp_fixname('Vantrease, Kelvin','Vantrease,K');
call sp_fixname('VanTrease, Kelvin','Vantrease, Kelvin');
call sp_fixname('Wong, Kenny','Wong,K');
call sp_fixname('Wright, Pete','Wright,P');
call sp_fixname('Zetrouer, Gary','Zetrouer,G');

call sp_fixname('Alder, Dan','Alder, D');
call sp_fixname('Bolan, Bobby','Bolan, B');
call sp_fixname('Bowes, Wayne','Bowes, W');
call sp_fixname('Britos, John','Britos, J');
call sp_fixname('Britos, Peter','Britos, P');

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

call sp_fixname('Matthews, Matt','Matthews, M');
call sp_fixname('Mondry, Steve','Mondry, S');
call sp_fixname('Navarro, Ray','Navarro, R');
call sp_fixname('Porco, Ken','Porco, K');
call sp_fixname('Roderick, Myron','Roderick, M');

call sp_fixname('Rubenstein, Ron','Rubenstein, R');
call sp_fixname('Sulli, Steve','Sully, S');
call sp_fixname('Terry, Evan','Terry, E');
call sp_fixname('Vantrease, Kelvin','Vantrease, K');
call sp_fixname('Wong, Kenny','Wong, K');
call sp_fixname('Wright, Pete','Wright, P');
call sp_fixname('Zetrouer, Gary','Zetrouer, G');

call sp_fixname('Rudysz, George','Rudysz, G');
call sp_fixname('Rudysz, George','Rudysz,G');
call sp_fixname('Rudysz, George','Rudusz, George');

call sp_fixname('Garfinkel, Charlie','Garfinkel, Charles');

call sp_fixname('Stead, T','Stead,');



-- memory of Scott Oliver/Gerry Price
call sp_fixname('Ferrin, Rick','Ferrin,R');
call sp_fixname('Hildebrand, Bill','Hildebrand,B');
call sp_fixname('Plotkin, Mark','Plotkin,M');
call sp_fixname('Laughter, Brian','Laughter,B');
call sp_fixname('Fitzpatrick, Shawn','Fitzpatrick,S');
call sp_fixname('Romo, Mike','Romo,M');
call sp_fixname('Botello, Joe','Botello,J');
call sp_fixname('St. Onge, Scott','St. Onge,S');



-- ira dallas 75 old school fixes from shari Copeland bracket scan Nov 2020
call sp_fixname('Concha, Lou','Concha,L');
call sp_fixname('Lampley, Bob','Lampley,B');
call sp_fixname('Sellars, Bill','Sellars,B');
call sp_fixname('Jordan, Jim','Jordan,J');
call sp_fixname('Bernstein, Luther','Bernstein,L');
call sp_fixname('Starkman, Ron','Starkman,R');
call sp_fixname('Clegg, Mike','Clegg,M');
call sp_fixname('Treat, Rolie','Treat,R');
call sp_fixname('Smith, Steve','Smith,S');
call sp_fixname('McKie, Tom','McKie, T');






/* 10/14/08: more name fixing */

-- Mike Pawka eznoh@niceup.com says Green,D is Dolwain Green

call sp_fixname('Green, Dolwain','Green,D');
call sp_fixname('Green, Dolwain','Green, Dolwayne');


/* More analysis by sorting all names */

call sp_fixname('Berklehamer, Brian','Berkelhamer, Brian');
call sp_fixname('Hernandez, Allen','Hernandez, Alan');
call sp_fixname('Hernandez, Allen','Hernandez, Allan');
call sp_fixname('Eichenberg, Steve','Eichenberger, Steve');


call sp_fixname('Hirsekom, Jorge','Hirsekorn, Jorge');
call sp_fixname('Hirsekom, Jorge','Hirsekomn, Jorge');


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


-- first version is how his name appears in all IRT standings and in r2sports


call sp_fixname('Carson, Rocky','Carson I I I, Rocky');
call sp_fixname('Carson, Rocky','Carson III, Rocky');

-- RO is NOT Rocky!  oh no.  how many results did I corrupt doing this??
-- call sp_fixname('Carson, Rocky','Carson, R.O.');
-- call sp_fixname('Carson, Rocky','Carson III, R.O.');

/* 4/20/11: doing some more cleanup with newer players. */

-- Decided that it is Tony Carson, not Anthony Carson
call sp_fixname('Carson, Tony','Carson, Anthony');
call sp_fixname('Ackermann, Alex','Ackerman, Alex');
call sp_fixname('Crockett, Allan','Crockett, Allen');

call sp_fixname('Lavely, Danny','Lavely, Dan');
call sp_fixname('Leetch, Erik','Leetch, Eric');
call sp_fixname('Ortega, Eduardo Avila','Ortega, Eduardo');

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

call sp_fixname('Adler, Joel','Adler, Joe');

call sp_fixname('Alvidez, Javier','Alvidrez, Javier');
call sp_fixname('Barton, Christopher','Barton, Chris');
call sp_fixname('Bermudez, Armando','Bermutez, Armondo');
call sp_fixname('Bousquet, Nicolas','Bousquet, Nicholas');
call sp_fixname('Casalvolone, Bruno','Casalvolve, Bruno');
call sp_fixname('Chisholm, John-Craig','Chisholm, John Craig');
call sp_fixname('Crockett, Allan','Crockett, Allen');
call sp_fixname('Cubillos, Set','Cubillos, Seb');

-- deciding that Jose Flores is Jose Flores Jr.
call sp_fixname('Flores Jr., Jose','Flores, Jose');
call sp_fixname('Flores Jr., Jose','Flores, Jr. Jose ');
call sp_fixname('Flores Jr., Jose','Flores, Jose Jr');
call sp_fixname('Flores Jr., Jose','Flores Jr. Jose');
call sp_fixname('Flores Jr., Jose','Flores Jr, Jose');
call sp_fixname('Flores Jr., Jose','Flores, Jr., Jose');

call sp_fixname('Flores, Ramon','Florez, Ramon');

-- Sept 2026: how did they misspell Jhonathan flores in the SA games??
call sp_fixname('Flores, Jhonatan','Flores, Jonathan');
call sp_fixname('Flores, Jhonatan','Flores, Jhonathan');



call sp_fixname('Funatani, Sadao','Funati, Sadeo');

call sp_fixname('Gutierrez, Reydecel','Gutierrez, Rey');
call sp_fixname('Gutierrez, Reydecel','Guiterrez, Reydecel');



call sp_fixname('Hernandez, Allen','Hernandez, Allan');

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

-- Ortiz, Sal Sr. same as Ortiz, Salvador?  Maybe

call sp_fixname('Partovich, Roby','Partovich, Robby');
call sp_fixname('Partovich, Roby','Partovich, Toby');
call sp_fixname('Partovich, Roby','Partrovich, Roby');

call sp_fixname('Patendue, Patrick','Pataniuda, Patrick');
call sp_fixname('Rhodes, John Lee','Rhodes, John');


call sp_fixname('Rojas, Steven','Rojas, Steve');

-- Got the goahead Nov 2016 to always call Mauro Rojas "David"
-- Actually, its "Daniel" ... made a mistake earlier.

call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Mauro');
call sp_fixname('Rojas, Daniel (Mauro)','Rojas, Daniel');
call sp_fixname('Rojas, Daniel (Mauro)','Daniel, Mauro');

-- Antonio Rojas goes by Tatoe
call sp_fixname('Rojas, Antonio','Rojas, Tatoe');



call sp_fixname('Saito, Keichiro','Saito, Keiichiro');

call sp_fixname('Schmeiser, Arthur','Schmeser, Arthur');

-- Serrano, Jose versus Serrento, Jose?  

call sp_fixname('Sierra, Fernando','Siera, Fernando');
call sp_fixname('Torres, Jared','Torres, Jarred');




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
call sp_fixname('Bacmeister, Carlos','Bacmeister P, Carlos');

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

call sp_fixname('Campo, Luis Fernando','Campo, Luis');

call sp_fixname('Cardenas, Abe','Cardenas, Abraham');
call sp_fixname('Cardenas, Abe','Cardenas, Abraham1');

call sp_fixname('Carlson, Glenn','Carlson, Glen');

call sp_fixname('Carrillo, Cesar','Carrillo, Ceasar');

call sp_fixname('Carter, Cris','Carter, Chris');

-- no, confirmed this is Rich, NOT rick 
call sp_fixname('Carver, Rich','Carver, Rick');

call sp_fixname('Case, Dan','Case, Daniel');

call sp_fixname('Cerreto, Neil','Cerruto, Neil');
call sp_fixname('Cerreto, Neil','Cerruto, Neil');

-- all over the road with this guy; believe it should be Cocco Hayes
call sp_fixname('Cocco Hayes, Alexi David','Coco Hayes, Alexi David');
call sp_fixname('Cocco Hayes, Alexi David','Cocco, Alexi');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alexi David Cocco');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alexi David Coco');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alex David Cocco');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alex David Coco');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alexi David Coccco');
call sp_fixname('Cocco Hayes, Alexi David','Hayes, Alexi David Cocco');


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


-- is this right?
call sp_fixname('Fontana, Matthew','Fontana, Matt');

-- is this right??
call sp_fixname('Franks, Michael ray','Franks, Michael Ray');

call sp_fixname('Fuhrmann, Thomas','Fuhrman, Tom');
call sp_fixname('Fuhrmann, Thomas','Furhmann, Tom');
call sp_fixname('Fuhrmann, Thomas','Fuhrman, Thomas');


-- i'm assuming the non A/P is the A version.
-- Is there also an H?  Fumero (H), Teobaldo?  always seems to refer to Adams version

call sp_fixname('Fumero Adams, Teobaldo','Fumero Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero a., Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero A., Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero, Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero (A), Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero Jr., Teo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero (H), Teobaldo');
call sp_fixname('Fumero Adams, Teobaldo','Fumero, Teobaldo Adams');

-- P seems to be the senior, A the junior
call sp_fixname('Fumero Patino, Teobaldo','Fumero p., Teobaldo');
call sp_fixname('Fumero Patino, Teobaldo','Fumero P., Teobaldo');
call sp_fixname('Fumero Patino, Teobaldo','Fumoero, Teobaldo Patino');
call sp_fixname('Fumero Patino, Teobaldo','Fumero, Teobaldo Patino');
call sp_fixname('Fumero Patino, Teobaldo','Fumero, Teobaldo Sr.');




-- are Gale, Andrew and Gale, Andres different?  

call sp_fixname('Garay, Eduardo','Garay, Edwardo');

-- Noslen Jimenez Garcia: cuban player now living in Florida: standardizing on Jimenez, Noslen
call sp_fixname('Jimenez, Noslen','Garcia, Nolsen Jimenez');
call sp_fixname('Jimenez, Noslen','Garcia, Nolsen');
call sp_fixname('Jimenez, Noslen','Jimenez Noslen Garcia');
call sp_fixname('Jimenez, Noslen','Garcia, Noslen Jimenez');
call sp_fixname('Jimenez, Noslen','Jimenez, Nolsen');
call sp_fixname('Jimenez, Noslen','Jimenez, Nolson');


call sp_fixname('Garner, Jeff','Garner, Jeffrey');

call sp_fixname('Garrow, William','Garrow, Will');

call sp_fixname('Garzon, Juan Felipe','Garzon, Juan');

call sp_fixname('Gerhardt, Thomas','Gerhardt, Tommy');

call sp_fixname('Gillespie, Michael','Gillespie, Mike');

call sp_fixname('Giunta, Nick','Giunta, Nicholas');
call sp_fixname('Giunta, Nick','Guinta, Nick');

call sp_fixname('Green Jr., Kenny','Green, Kenny');
call sp_fixname('Green Jr., Kenny','Green Jr, Kenny');

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

-- The Herreras
-- Alejandro represents Columbia, lives in Miami
-- Andres represents Columbia, lives in California
-- Juan represents Columbia, lives in Chicago.  Juan Sebastian
-- Anthony represents USA, from Colorado, lives in Arizona
-- Anthony F. ??  Same as Anthony?

-- German played limited IRT events in early 2000s ... lives in Florida?  Same as Alejandro?  
-- Daniel == Daniel Herrera Maldanado, junior player in Mexico

call sp_fixname('Herrera, Alejandro','Herera, Alejandro');
call sp_fixname('Herrera, Andres','Herera, Andres');
call sp_fixname('Herrera, Anthony','Herera, Anthony');
call sp_fixname('Herrera, Anthony F.','Herera, Anthony F.');
call sp_fixname('Herrera, German','Herera, German');
call sp_fixname('Herrera, Juan','Herrera, Juan Sebastian');

-- Standardizing on Daniel Maldonado, as per his FB page.
-- also different from Dany Maldonado

call sp_fixname('Maldonado, Daniel','Herrera Maldonado, Daniel');
call sp_fixname('Maldonado, Daniel','Herrera, Daniel');
call sp_fixname('Maldonado, Daniel','Maldonado, Daniel Herrera');



call sp_fixname('Hernandez, Jorge Ivan','Hernandez, Jorge ivan');

-- Hernandez Jr., Vicente  same as Hernandez, Vicente?



call sp_fixname('Hugo, Isaac','Hugo, Issac');

call sp_fixname('Humiston, Scott','Humiston, R. scott');

-- same as Hunt, Steven?
call sp_fixname('Hunt-Marriott, Stephen','Hunt-marriott, Stephen');



call sp_fixname('Isley, Tripp','Isley, Trip');

call sp_fixname('Iwaasa, Coby','Iwassa, Coby');

-- is it "Jeon, Seung Jun" or "Jun, Jeon Seung?" 
call sp_fixname('Jeon, Seung Jun','Jeon, Jun');
call sp_fixname('Jeon, Seung Jun','Jun, Jeon Seung');



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

--- hmm; should these be the same person?

call sp_fixname('Lawrence, Gregory','Lawerenz, Gregory');
call sp_fixname('Lewerenz, Gregory','Lewerenz, Greg');
call sp_fixname('Lewerenz, Fred','Lewerenz,F');

call sp_fixname('Lawrence, Paul','Lawrence, P');
call sp_fixname('Lawrence, Paul','Lawrence,P');
call sp_fixname('Lawrence, Paul','Lawrence, P.');


call sp_fixname('Lee, Vinny','Lee, Vinnie');

call sp_fixname('Levitsky, Ronald','Levitskiy, Ronald');



call sp_fixname('Leyva, Guillermo','Leyva, Guiellermo');

call sp_fixname('Llerena, Estuardo Wer','Llerena, Estuardo');

call sp_fixname('Lloyd, Sawyer','Lloyd, Swyer');

call sp_fixname('Loiaza, Enrique','Loaizza, Enrique');

call sp_fixname('Loiaza, Enrique','Loaizza, ?');

call sp_fixname('Longoria, Christian','Longoria, Cristian');
call sp_fixname('Longoria, Christian','Longoria, Cristain');
call sp_fixname('Longoria, Christian','Longoria, Cristain');

call sp_fixname('Maldonado, Alvaro','Maldonaldo, Alvaro');

call sp_fixname('Mancebo, A. Hector','Mancede, A. Hector');

call sp_fixname('Martin, Arturo','Martin, Artvaro');

-- Also Juan Martinez w/o III? nope; confirmed w/ Jauan himself
call sp_fixname('Martinez III, Juan','Martinez iii, Juan');
call sp_fixname('Martinez III, Juan','Martinez I I I, Juan ');
call sp_fixname('Martinez III, Juan','Martinez, Juan III');
call sp_fixname('Martinez III, Juan','Martinez, Juan');



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
call sp_fixname('Nunez Jr., Miguel','Nunez, Miguel Jr');
call sp_fixname('Nunez Jr., Miguel','Nunez, Miguel Jr.');

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
call sp_fixname('Parrilla, Andree','Parilla, Andree');

-- Full name: Fabian Armando Parrilla Araujo


call sp_fixname('Polo Jr, Luis','Polo, Luis jr');

call sp_fixname('Purcell, Alex','Purcell, Alexxander');

call sp_fixname('Raby, Burgess','Raby, Bur');

call sp_fixname('Rahn, David','Rahn, Dave');

call sp_fixname('Ramos Jr., Jorge','Ramos jr, Jorge');

call sp_fixname('Randalls, Darren','Randalls, Darrin');
call sp_fixname('Randalls, Darren','Randles, Darin');

call sp_fixname('Reinhard, Ralf','Reinhardt, Ralf');

call sp_fixname('Riffel, Nicholas','Riffel, Nick');

call sp_fixname('Rivera, Fernando Javier','Rivera, Fernando');

call sp_fixname('Rodriguez, Humberto','Rodriquez, Humberto');

-- no, its Bradly, must fix
call sp_fixname('Rogers, Bradly','Rodgers, Brad');
call sp_fixname('Rogers, Bradly','Rodgers, Bradly');
call sp_fixname('Rogers, Bradly','Rogers, Brad');
call sp_fixname('Rogers, Bradly','Rogers, Bradley');

call sp_fixname('Rodgers, Ryan','Rogers, Ryan');

call sp_fixname('Romo Garcia, Alejandro','Romo, Alejandro');

call sp_fixname('Ryder, Tim','Ryder, Tom');

call sp_fixname('Sabalesky, Dave','Sable (sabalesky), David');

call sp_fixname('Salamone, Danny','Salamone, Dan');



call sp_fixname('Sandoval, Erick','Sandavol, Eric');

call sp_fixname('Santana Jr, Fausto','Santana Fausto');

call sp_fixname('Schonberger, Anthony','Schongerger, Anthony');

call sp_fixname('Schrack, Jonathan','Schrack, Jonathon');

call sp_fixname('Schwent, David','Schwent, Dave');

call sp_fixname('Sengal, Frank','Senger, Frank');

call sp_fixname('Shepley, William','Shepley, Bill');
call sp_fixname('Shepley, William','Shepley, Billy');

call sp_fixname('Shimizu, Hisao','Shimizo, Hisao');

call sp_fixname('Shimizu, Hiroshi','Shimzu, Hiroshi');



call sp_fixname('Shnurman, Sampson','Shnruman, Sampson');

call sp_fixname('Schopieray, Brad','Shopieray, Brad');

call sp_fixname('Simpson, Steve','Simpson, Steven');

-- perhaps also Rich Sledzik, Rich Sledzik Jr, Ricky Sledzik?
-- In Juniors all of Richard Sledzik is actually Richard Sledzik jr.
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

-- full name Ubilla, Jose Eduardo

call sp_fixname('Ubilla, Jose','Ubilla, Jose E');
call sp_fixname('Ubilla, Jose','Ubilla, Jose Eduardo');

call sp_fixname('Uriostegui Jr., Vicente','Uriostegui jr, Vicente');
call sp_fixname('Uriostegui Jr., Vicente','Uriostegui, Vicente');

call sp_fixname('Van Valkenburg, Jesse','Van valkenburg, Jesse');

call sp_fixname('Varela, Jacob','Vareia, Jacob');

call sp_fixname('Vargas, Hugo','Vargas, Hogo');

call sp_fixname('Vesely, Filip','Vesily, Filip');

call sp_fixname('Villacreces, Mario','Villacreses, Mario');

call sp_fixname('Von Kaenel, Jason','Von kaenel, Jason');


-- Wagner Jr, Rich and Wagner, Rich: same?  No, they're not.
-- Rich Wagner = Richard Wagner.
-- Rich Wagner Jr = Rickie, Richie and Rick; Wagner's son, lives in AZ plays lots of outdoor

call sp_fixname('Wagner, Rich','Wagner, Richard');

call sp_fixname('Wagner Jr., Rich','Wagner, Richie');
call sp_fixname('Wagner Jr., Rich','Wagner, Rick');
call sp_fixname('Wagner Jr., Rich','Wagner, Rickie');
call sp_fixname('Wagner Jr., Rich','Wagner Jr, Rich');
call sp_fixname('Wagner Jr., Rich','Wagner Jr, Richie');


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


call sp_fixname('Kruger, John','Kruger,');
call sp_fixname('Kruger, John','Kruger,J');

call sp_fixname('Yurgaitis, David','Yurgaitis,');

call sp_fixname('Rudich, Matt','Rudich,M');

call sp_fixname('Lowe, Mike','Lowe,M');

call sp_fixname('Gillooly, John','Gillooly,?');
call sp_fixname('Gillooly, John','Gillooly, ?');

call sp_fixname('Isley, Mark','Isley,M');

call sp_fixname('Vasquez, Leo','Vazquez, Leo');

-- Standardizing on Charlie
call sp_fixname('Pratt, Charlie','Pratt, Charles');

-- Long standing older canadian found during Canadian doubles entry
call sp_fixname('Gervais, Martin','Gervais, M');
call sp_fixname('Gervais, Martin','Gervais,M');
call sp_fixname('Gervais, Martin','Gervais, M.');


call sp_fixname('Ponce, Jamie Maldonado','Ponce, Jamie Maldonaldo');

-- somehow DLR's names not standardized throughout
call sp_fixname('De La Rosa, Daniel','De la rosa, Daniel');

-- bungled Kachtik's name during data entry
call sp_fixname('Kachtik, Drew','Katchtik, Drew');
call sp_fixname('Kachtik, Drew','Katchtick, Drew');
call sp_fixname('Kachtik, Drew','Katchtik, Doug');
call sp_fixname('Kachtik, Drew','Kachtik, Doug');


call sp_fixname('Winter, Curtis','Winters, Curtis');
call sp_fixname('Winter, Curtis','Winter, ?');

call sp_fixname('Matmatamoros, David','Matramoros, ?'); 

-- Fixing the cuban's many iterations of names; going with Maikel Mollet (Suarez).
-- IRF lists him as Maikel Moyet

call sp_fixname('Mollet, Maikel','Suarez, Maykel Moyet'); 
call sp_fixname('Mollet, Maikel','Mollet, Maykel');
call sp_fixname('Mollet, Maikel','Mollet Suarez, Maikel');
call sp_fixname('Mollet, Maikel','Mollet, Maikel (Suarez)');
call sp_fixname('Mollet, Maikel','Mollett, Maikel');
call sp_fixname('Mollet, Maikel','Moyet, Maikel');

-- Cuba #2 similarly all over the road: Chacon Gomez, Enier
call sp_fixname('Chacon, Enier','Chacon Gomez, Enier');


call sp_fixname('Morales, Gustavo','Morales, G');

call sp_fixname('Nasser, Roberto','Nasser, Robert');

call sp_fixname('Hernandez, Hemhil','Hernandez, Hemil');

-- Enson Inoue = Egan's brother.
call sp_fixname('Inoue, Enson','Inoue, En');
call sp_fixname('Inoue, Enson','Inoue,En');


-- end of 2018-19 name fixes
call sp_fixname('Oata, Sebastian','Oana, Sebastian');

call sp_fixname('Medrano Michel, Gustavo','Michel, Gustavo Medrano');

call sp_fixname('Echalar, Erick Ramiro','Echalar Orihuela, Erick Ramiro');

call sp_fixname('Delgadillo, Sergio Victor','Delgadillo Galvain, Sergio Victor');

-- Arteaga Guzman, Miguel Angel
call sp_fixname('Arteaga, Miguel Angel','Arteaga Guzman, Miguel Angel');
call sp_fixname('Arteaga, Miguel Angel','Arteaga G, Miguel Angel');


-- standardizing on simpler name: Francisco Gomez Reyes is full name (Colombian representative)
-- full name Francisco Javier Gomez Reyes
call sp_fixname('Gomez, Francisco','Reyes, Francisco');
call sp_fixname('Gomez, Francisco','Gomez Reyes, Francisco');
call sp_fixname('Gomez, Francisco','Reyes, Francisco Gomez');
call sp_fixname('Gomez, Francisco','Reyes, Francisco');
call sp_fixname('Gomez, Francisco','Reyes, Francisco Javier');
call sp_fixname('Gomez, Francisco','Gomez, Francisco Javier');


-- Hosman Andres Gomez 
call sp_fixname('Gomez, Andres','Gomez, Hosman Andres');

call sp_fixname('Mendoza, Geovani','Mendoza, Jeovany');

call sp_fixname('Mendoza, Erik','Mendoza, Erick');

-- Vladimir Fernando Siles Gonzales; bolivian player at 2019 US Open
call sp_fixname('Siles, Vladimir','Siles, Vladimir Fernando');
call sp_fixname('Siles, Vladimir','Siles Gonzales, Vladimir Fernando');



call sp_fixname('Chynoweth, Tracy','Chynoweith, Tracy');


-- Bolivian Marcello Vargas Aguilar; standardizing on shorter versio
call sp_fixname('Vargas, Marcello','Aguilar, Marcello Vargas');
call sp_fixname('Vargas, Marcelo','Aguilar, Marcelo Vargas');


call sp_fixname('Alcala, Juan','Alcala, ?');

call sp_fixname('Harding, Mark','Harding, Mike');


call sp_fixname('De Witt, Shane','Dewitt, Shane');
call sp_fixname('De Witt, Shane','DeWitt, Shane');
call sp_fixname('De Witt, Shane','De witt, Shane');






/* ------------------------------------------------------------------------------------------------- */
/* WRT/IRF data now: some duplicates from above */
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

-- Victor Alfonso Camacho Gutierrez
call sp_fixname('Camacho, Vicente','Camacho, Victor');
call sp_fixname('Camacho, Vicente','Alfonso, Victor');
call sp_fixname('Camacho, Victor Alfonso','Camacho, Victor Alfanso');

call sp_fixname('Camacho, Felipe','Camacho, Felie');

-- select * from results where season='2016-17' and loser like '%Martel%';
-- select * from rankings where player like '%Martel%';

-- Jaime Martell Neri
call sp_fixname('Martell, Jaime','Martell, Jamie');
call sp_fixname('Martell, Jaime','Martel, Jamie');
call sp_fixname('Martell, Jaime','Martell Neri, Jaime');


--  Jose Daniel Ugalde Albornoz
call sp_fixname('Ugalde, Jose Daniel','Ugalde, Josaniel');
call sp_fixname('Ugalde, Jose Daniel','Ugaldo, Jose Daniel');


call sp_fixname('Almada, Alejandro','Almada, Alex');
call sp_fixname('Almada, Alejandro','Almada Felix, Alejandro');


call sp_fixname('Chavez, Loupe','Chavez, Loup');

-- Antone, Wayne -> Antone, Wayne IV?

call sp_fixname('Burruel, Arturo','Burrell, Arturo');



-- Definitely Erik, not Erick
-- Definitely Erik, not Erick
call sp_fixname('Garcia, Erik','Garcia, Eric');
call sp_fixname('Garcia, Erik','Garcia, Erick');

call sp_fixname('Imhausen, Jared','Imhausen, Jered');

call sp_fixname('Meeks, Kamyron','Meedks, Kamyron');


-- Is Munoz, Luis Felipe same as Munoz, Felipe?  yes believe so
-- Munoz, Felipe == Munoz Jr, Felipe What about Jr??
-- Luis Felipe Munoz Torrontegui

call sp_fixname('Munoz, Felipe','Munoz, Luis Felipe');
call sp_fixname('Munoz, Felipe','Munoz Jr, Felipe');
call sp_fixname('Munoz, Felipe','Munoz, Felipe');



call sp_fixname('Rodriguez Jr., Miguel','Rodriguez, Miguel Jr.');
call sp_fixname('Rodriguez Jr., Miguel','Rodriguez Jr. Miguel');
call sp_fixname('Rodriguez Jr., Miguel','Rodriguez Jr, Miguel');

call sp_fixname('Rodriguez Jr., Miguel','Rodriguez, Miguel');


-- Salgado, Rodrigo == Salgado Jr, Rodrigo?  Yes I think so.  Yes confirmed


call sp_fixname('Smith Jr, Ross','Smith, Ross Jr.');

call sp_fixname('Aldana Jr., Ismael','Aldana, Isamel');
call sp_fixname('Aldana Jr., Ismael','Aldana Jr, Ismael');
call sp_fixname('Aldana Jr., Ismael','Aldana, Ismael');


call sp_fixname('Garcia, German','Gracia, German');


call sp_fixname('Garuea, Miguel','Gardea, Miguel');

call sp_fixname('Kiil, Paul','Kill, Paul');

-- Perea, Miguel == Perea, Mike?

call sp_fixname('Sada, Eddie','Sala, Eddie');


-- Diaz, Jose same as Diaz, Jose Daniel Rodriguez?
-- Jose Diaz is also a Junior in some junior data

call sp_fixname('Diaz, Jose','Diaz, jose');

call sp_fixname('Diaz, Rioardo','Diaz, Ricky');

-- Hanzel Martinez Perez; standardizing on Hanzel Martinez
call sp_fixname('Martinez, Hanzel','Martinez Perez Hanzel');
call sp_fixname('Martinez, Hanzel','Martinez Perez, Hanzel');
call sp_fixname('Martinez, Hanzel','Perez, Hanzel Martinez');


call sp_fixname('Perez, Luis','Perez, Louis');
call sp_fixname('Perez, Luis','Perez, LUis');
call sp_fixname('Perez, Luis','Perez, luis');


-- Samson, Ferd is correct, btw.
call sp_fixname('Samson, Ferd','Samson, Fred');

-- full name Carlos Keller Vargas
call sp_fixname('Keller, Carlos','Vargas, Carlos Keller');
call sp_fixname('Keller, Carlos','Keller Vargas, Carlos');

call sp_fixname('Bolyard, Andrew','Bolyard, Andres');

call sp_fixname('Kurzbard, Fernando','Kurzbad, Fernando');

call sp_fixname('Leyes Jr., Roberto','Leyes Jr, Roberto');

call sp_fixname('Natera, Humberto','Natera, Huberto');

-- Mar, Javier full name is Francisco Javier Mar Garcia

-- Montoya, Rodrigo is Rodrigo Montoya Solis


-- Alan Natera Chavez
call sp_fixname('Natera, Alan','Natera Chavez, Alan');
call sp_fixname('Natera, Alan','Chavez, Alan Natera');

-- full name: Eduardo Portillo Torres, nickname Lalo
call sp_fixname('Portillo, Eduardo','Portilo, Eduardo');
call sp_fixname('Portillo, Eduardo','Portillo Torres, Eduardo');
call sp_fixname('Portillo, Eduardo','Portilo, Lalo');
call sp_fixname('Portillo, Eduardo','Portillo T, Eduardo');



-- is it Garcia, Osvaldo or Ozvaldo?

-- Dany Magi = Daniel Maggi
call sp_fixname('Maggi, Dany','Maggi, Daniel');
call sp_fixname('Maggi, Dany','Maggi, Danny');


-- Raymundo Garcia or Reymundo Garcia?  Keep seeing it either way, standardizing on reymundo; might be wrong.
-- also .. assuming that Jr is the same.

call sp_fixname('Garcia, Reymundo','Garcia, Raymundo');
call sp_fixname('Garcia, Reymundo','Garcia Jr., Raymundo');
call sp_fixname('Garcia, Reymundo','Garcia, Reymondo');


call sp_fixname('Alvarez, Jose Daniel','Alvarez, Jose');

call sp_fixname('Anderson, Matthew','Anderson, M.');

call sp_fixname('Ane, Jung Eun','Anh, Jung Eun');

call sp_fixname('Harshavat, Sid','Harashart, S.');

-- maybe: 2004 Worlds IRF data was S. and assume its Santiago
call sp_fixname('Ugalde, Santiago','Ugalde, S.');

call sp_fixname('Varadarajan, Rajiv','Varadhrajan, Rajiv');

-- full name: Luis Conrrado Moscoso Serrudo
call sp_fixname('Moscoso, Conrrado','Moscoso, Conrado');
call sp_fixname('Moscoso, Conrrado','Moscosco, Conrrado');
call sp_fixname('Moscoso, Conrrado','Moscoso, Conrado Kevin');
call sp_fixname('Moscoso, Conrrado','Moscoso Serrudo, Luis Conrrado');

call sp_fixname('Threlfall, Richard','Threlfall, Rich');

call sp_fixname('Viens, Francois','Viens, Fran?ois');

-- might be backwards.
call sp_fixname('Walia, Manu','Waila, Manu');

call sp_fixname('Zuckerman, Jerry','Zukerman, Jerry');

call sp_fixname('McLean, Michael','Mclean, Michael');

call sp_fixname('Terrabain, Danny','Tarrabain, Danny');

call sp_fixname('Yager, J.D.','Yager, J.d.');

call sp_fixname('Carrasco, Kadim','Kadim, Carrasco');


-- was tacking on  his "2nd" name Fernandez, Erick Cuevas; should I change this?  Yes; on FB he's just Erick Cuevas
-- Erick Gerardo Cuevas Fernandez

call sp_fixname('Cuevas, Erick','Cuevas Fernandez, Erick');
call sp_fixname('Cuevas, Erick','Cuevas, Erick');
call sp_fixname('Cuevas, Erick','Fernandez, Erick');
call sp_fixname('Cuevas, Erick','Fernandez, Erick Cuevas');
call sp_fixname('Cuevas, Erick','Cuevas F, Erick');


-- full name: Antonio Joaquin Fernandez
call sp_fixname('Fernandez, A.J.','Fernandez, A.j.');

call sp_fixname('Cueva, Juan Francisco','Francisco, Juan');


--- Lots of IRF loading mid 2018

-- Fernando Rios is actually Fernando Rios Samaniego?  mot correcting.

-- Miranda Martinez, Gerson proper full name
call sp_fixname('Miranda, Gerson','Miranda Martinez, Gerson');

-- Note: Juan Rivas is from Mass, Juan Pablo Rivas is from Cali, Columbia

call sp_fixname('Wer, Christian','Wer Llernea, Christian');
call sp_fixname('Wer, Christian','Wer Llerena, Christian');


call sp_fixname('Maldonado Gutierrez, Daniel','Gutierrez, Daniel Maldonado');

call sp_fixname('Andrade, Alejandro Martinez','Martinez Andrade, Alejandro');

-- are we sure this is right??
call sp_fixname('Dominguez, German Garcia','Gracia Dominguez, German');
call sp_fixname('Dominguez, German Garcia','Garcia Dominguez, German');
call sp_fixname('Dominguez, German Garcia','Garcia, German');

-- noticed this during searching for Steves.  Might be the other way around
call sp_fixname('Golis, Steve','Guils, Steve');

-- standardizing on shorter name; wait, is this irght??
-- Both Juan Jose and Jose Julian are Guatemalan ... are they the same player?
-- call sp_fixname('Salvatierra, Jose Julian',

call sp_fixname('Salvatierra, Juan','Salvatierra, Juan Jose');




-- Luiz or Luis?
call sp_fixname('Homem, Luiz','Homem, Luis');

-- Is it Vincent or Vineet?  commenting out for now
-- call sp_fixname('Kapur, Vineet','Kapur, Vincent');

-- Is it O'Callahan or O'Callagran?
call sp_fixname('OCallaghan, Noel','OCallagran, Noel');

-- Doezum, Richard might be Van Doezum, Richard
-- Van Der Doezum, R I believe is the same guy
call sp_fixname('Van Doezum, Richard','Doezum, Richard');
call sp_fixname('Van Doezum, Richard','Van Der Doezum, R');


-- name backwards in transcription
call sp_fixname('Canedo, Santiago','Caneda, Santiago');
call sp_fixname('Canedo, Santiago','Santiago, Canedo');
call sp_fixname('Canedo, Santiago','Candeo, Santiago');


call sp_fixname('Bagley, Robert','Bagley, B.');
call sp_fixname('Bagley, Robert','Bagley, Bob');


call sp_fixname('Troncoso, Francisco','Troncoso, Fransico');

call sp_fixname('Osagi, Sunny','Osagie, Sunny');


-- Edson's full name
call sp_fixname('Martinez, Edson','Martinez Morales, Edson');


call sp_fixname('Carrion, Oscar','Carrion Navarro, Oscar');

call sp_fixname('Cruz, Selvin','Cruz, Servin');

call sp_fixname('Cueva, Jose Luis','Cueva, J.L.');

-- might be backwards
call sp_fixname('Deboutte, Niklaas','Deboute, Niklaas');


call sp_fixname('Galvez, Juan Luis','Galvez, Juan');
call sp_fixname('Galvez, Juan Luis','Galvez, J.L.');

call sp_fixname ('Doniego, Benjamin','Doniego, B.');

call sp_fixname ('Edwards, Jonathan','Edwards, John');

call sp_fixname ('Farrell, Gustavo','Farell, Gustavo');
call sp_fixname ('Farrell, Gustavo','Farrell, Gus');



call sp_fixname ('Gutierrez, Raul Martinez','Gutierrez, Raul');

-- is this right?  not sure
-- call sp_fixname ('Hanley, Patrick','Hanley, Pan');

call sp_fixname ('Hashimoto, Itayo','Hashimoto, I');

call sp_fixname ('Isaias, Yamil','Isaias, Y.');




call sp_fixname ('Horn, David','Horn, Bobby');

call sp_fixname ('Collins, Robert','Collins, Robbie');

call sp_fixname ('Goth, John','Goff, John');

-- full name: Garcia Quispe, Diego
call sp_fixname ('Garcia, Diego','Garcia, David');
call sp_fixname ('Garcia, Diego','Garcia Quispe, Diego');

-- Full name: Roberto Arellano Choque; Bolivian junior
call sp_fixname ('Arellano, Roberto','Arellano Choque, Roberto');







-- fixing up some WOR outdoor guys
call sp_fixname ('Ramirez, Freddy','Ramirez, Fred');

call sp_fixname ('Lane, Craig "Clubber"','Lane, Craig');

call sp_fixname ('Koll, Rick "Soda Man"','Koll, Rick');
call sp_fixname ('Koll, Rick "Soda Man"','Koll, Rick Soda Man');
call sp_fixname ('Koll, Rick "Soda Man"','Soda Man Koll, Rick');



call sp_fixname ('Salamone, Joey','Salmone, Joey');


call sp_fixname ('Cardona, Alejandro','Cardona, Alex');

call sp_fixname ('Zelada, Mauricio','Zelada, Momo');
call sp_fixname ('Zelada, Mauricio','Zelada, MoMo');


call sp_fixname ('Apperson, Zach','Apperson, Zachary');
call sp_fixname ('Apperson, Zach','Apperson, Zack');


call sp_fixname ('Adam Jr., Bob','Adam Jr, Bob');




call sp_fixname ('Ghatate, Ariaan-Thor','Ghatate, Ariaan-thor');

call sp_fixname ('Huczek, Jack','Huzcek, Jack');

-- why did I think this is right?  Consistently Luis Renteria.  Believe errors from 207 worlds
-- full name: Luis Alberto Renteria Perea
call sp_fixname ('Renteria, Luis','Rentaria, Luis');
call sp_fixname ('Renteria, Luis','Rentaria, Luis Alberto');
call sp_fixname ('Renteria, Luis','Renteria, Luis Alberto');

-- Eder Gael Renteria Perea; standardizing on Eder Renteria
call sp_fixname ('Renteria, Eder','Rentaria, Eder');

-- Mexican 18U champ.  Full name: Angela Veronica Ortega Sabido
call sp_fixname ('Ortega, Angela Veronica','Ortega, Angela');

call sp_fixname ('Engel, Allan','Engel, Alan');

-- Note: manually fixed these records to distinguish between Jose Ramos and Jose Carlos Ramos.  Do not run 
-- call sp_fixname ('Ramos, Jose','Ramos, Jose Carlos');

-- full name: Jose Carlos Ramos Martinez; in Worlds 21 he went by Pepe??  No that's not right;
-- in Mexican nationals there was both a pepe and a jose carlos.  ugh.  Need to go back and fix Worlds21

-- Note: all 2010 and before are Jose Ramos, all after are Jose Carlos Ramos.  Manually fixed in IRT database.

-- call sp_fixname ('Ramos, Jose Carlos','Ramos, Pepe');



call sp_fixname ('Estrada, Ruben','Estrada, Reuben');

call sp_fixname ('Landeryou, James','Landeryou, Jamie');
call sp_fixname ('Landeryou, James','Landeryou, Jim');

call sp_fixname ('Gose, Gabe','Gose, Gabriel');

call sp_fixname ('Pocsai, Asher','Pocsal, Asher');

-- full name: Oscar Elias Nieto Valadez; standardizing on first name and father/family name
-- also known as Elias Nieto Zedalav
-- has been put into the DB as Elias Nieto.
-- Per his father on FB (also called Oscar Nieto) these are the same people
-- 2021 mexican nationals; definitely Elias Nieto, changing from oscar
call sp_fixname ('Nieto, Elias','Nieto Valadez, Oscar');
call sp_fixname ('Nieto, Elias','Valadez, Oscar Nieto');
call sp_fixname ('Nieto, Elias','Nieto Valadez, Oscar Elias');
call sp_fixname ('Nieto, Elias','Nieeto Zedalav, Elias');
call sp_fixname ('Nieto, Elias','Nieeto, Oscar');
call sp_fixname ('Nieto, Elias','Nieeto, Oscar');
call sp_fixname ('Nieto, Elias','Nieto, Oscar');

-- Giselle Nieto; sister?
call sp_fixname ('Nieto, Giselle','Nieto, Gisele');

-- Junior from Tijuana
call sp_fixname ('Ortega Jr., Guillermo','Ortega, Guillermo Jesus');
call sp_fixname ('Ortega Jr., Guillermo','Ortega Jr, Guillermo Jesus');
call sp_fixname ('Ortega Jr., Guillermo','Jesus Ortega Jr, Guillermo');
call sp_fixname ('Ortega Jr., Guillermo','Jesus Ortega Jr., Guillermo');
call sp_fixname ('Ortega Jr., Guillermo','Ortega Jr., Guillermo Jesus');
call sp_fixname ('Ortega Jr., Guillermo','Ortega, Guillermo De Jesus');
call sp_fixname ('Ortega Jr., Guillermo','Ortega, Guillermo De Jesus');



-- Ortega, Guillermo De Jesus: same guy?  Where is this name?  not in irt or juniors.


call sp_fixname ('Barker, Rich','Barker, Richard');

call sp_fixname ('Beaudry, Danny','Beaudry, Dan');
call sp_fixname ('Beaudry, Danny','Beaudy, Danny');
call sp_fixname ('Beaudry, Danny','Beaudy, Dan');

call sp_fixname ('Harripersad, Roger','Harrispersad, Roger');

call sp_fixname ('Mejia, Gilberto','Mejia, Gil');

call sp_fixname ('McGlothin, Jeremy','McGlothing, Jeremy');

call sp_fixname ('McCarthy, Nicolas','Mc Carthy, Nicolas');

call sp_fixname ('Schmidtke, Bill','Schmidtke, William');
call sp_fixname ('Schmidtke, Bill','Schmidke, Bill');

call sp_fixname ('Sawyer, Buz','Sawyer, Buzz');
call sp_fixname ('Satawa, Bryan','Satawa, Brian');


call sp_fixname ('Guillemette, Francis','Guilllemette, Francis');

call sp_fixname ('Honingsfeld, Evan','Honigsfeld, Evan');

call sp_fixname ('Warigon, Troy','Warigon, Tory');

call sp_fixname ('Kwon, Dae Yong','Kwon, Daeyong');	

call sp_fixname ('Manzuri, Shai','Mazuri, Shai');

-- bolivian HSer who is somewhere in the US?
call sp_fixname ('Arellano, Robert','Areliano, Robert');


call sp_fixname ('Bredenbeck, Jake','Bredenbeck, Jacob');
call sp_fixname ('Bredenbeck, Sam','Bredenbeck, Sam ');
call sp_fixname ('Bredenbeck, Sam','Bredenbeck,Sam');

-- Jordy Alonso Hernandez
call sp_fixname ('Alonso, Jordy','Alonso Hernandez, Jordy');
call sp_fixname ('Alonso, Jordy','Alonso, Jordi');

-- Juan Pablo Rodriguez Castrillon; 2019 columbian junior player
call sp_fixname ('Rodriguez, Juan Pablo','Castrillon, Juan Pablo');
call sp_fixname ('Rodriguez, Juan Pablo','Rodriguez, Juan');

-- Mario Osvaldo Mercado Valenzuela
call sp_fixname ('Mercado, Mario','Osvaldo, Mario');

-- Mario Osvaldo Mercado Valenzuela
call sp_fixname ('Oviedo, Carlos','Oveido, Carlos');

call sp_fixname ('Meinerz, Lee','Mienerz, Lee');

call sp_fixname ('Kelley, Sam','Kelley, Samuel');

-- Daly is Jim Daly, but not Jimmy Daly from Boston
call sp_fixname ('Daly, Jim','Daly,');
call sp_fixname ('Daly, Jim','Daly, ');


-- Mexican Junior Jorge Gutierrez Ortiz; standardizing on first and last name
call sp_fixname ('Gutierrez, Jorge','Gutierrez Ortiz, Jorge');
call sp_fixname ('Gutierrez, Jorge','Ortiz, Jorge Gutierrez');

call sp_fixname ('Trujillo, Erick','Trujilo, Erick');


call sp_fixname ('Pellowski, Zach','Pellowski, Zachary');
call sp_fixname ('Pellowski, Zach','Pellowski, Zack');

-- I keep mis-typing his name.
call sp_fixname ('Sutherland, Gatlin','Sunderland, Gatlin');


call sp_fixname ('Morissette, Samuel','Morrissette, Samuel');
call sp_fixname ('Morissette, Samuel','Morrisette, Samuel');

call sp_fixname ('Bugarin, Luis Daniel','Bugarin, Daniel');

call sp_fixname ('Perez, Cristian','Perez, Christian');

call sp_fixname ('Gonzalez Jr., Enrique','Gonzalez, Enrique Jr');

call sp_fixname ('Espinal, Ignacio','Espinal, Egnacio');


-- Late 2020; Arterburn transitioned; actually commenting this out and treating htem as two people
-- call sp_fixname ('Arterburn, Sunshine','Arterburn, Michael');


-- fixing some WOR players.
call sp_fixname ('Medina, Gabe','Medina, Gabriel');
call sp_fixname ('Medina, Gabe','Medina, Gabrial');

call sp_fixname ('Martin, Blake','Martin, Blake Joseph');

call sp_fixname ('Felton, Rod','Felton, Rodney');

call sp_fixname ('Bernstein, Mike','Bernstein, Michael');

call sp_fixname ('Martinez, Rob','Martinez, Robert');

call sp_fixname ('Jaldin, Adrian','Jaldin Lobo, Adrian Mauricio');
call sp_fixname ('Jaldin, Adrian','Jaldin Lobo, Adrian');

-- Juan José Tapia Zúñiga
call sp_fixname ('Tapia, Juan Jose','Tapia, Zuniga, Juan Jose');
call sp_fixname ('Tapia, Juan Jose','Tapia Zúñiga, Juan José');

call sp_fixname ('Purcell, Alexxander','Purcell, Alex');

-- Unsure of real name; initially Jeovany but Geovani in 2021?
call sp_fixname ('Mendoza, Geovani','Mendoza, Jeovany');
call sp_fixname ('Mendoza, Geovani','Mendoza, Geovany');
call sp_fixname ('Mendoza, Geovani','Mendoza, Goovany');


call sp_fixname ('Goldenberg, Benny','Goldenberg, Ben');

call sp_fixname ('Mendoza, D.J.','Mendoza, DJ');


call sp_fixname ('Bowens, Kevin','Bowens Jr., Kevin');

call sp_fixname ('Barrett, Michael','Barrett, Michael Andrew');

-- Mexican juniors
call sp_fixname ('Martinez, Andrea','Zermeno, Andrea Martinez');

call sp_fixname ('Martinez, Alejandro','Zermeno, Alejandro Martinez');

call sp_fixname ('Galindo, Nicolas','Galindo, Nicholas');

call sp_fixname('Romano, Diego','Vazquez, Diego Romano');

-- Hermann Gracia Castro
call sp_fixname ('Gracia, Hermann','Castro, Hermann Gracia');
call sp_fixname ('Gracia, Hermann','Garcia, Hermann');

-- Kerman_Damian_Gracia_Castro
call sp_fixname ('Gracia, Kerman','Castro, Kerman Damian Gracia');

call sp_fixname ('Winings, John','Whimmings, John');

call sp_fixname ('Sanchez, Alex','Sanchez, Axel');

-- Standardizing on Walter Ramos without Junior
call sp_fixname('Ramos, Walter','Ramos Jr., Walter');

call sp_fixname('Young, Stacey','Young, Stacey (sly)');

call sp_fixname('Sosa, David Lopez','Lopez Sosa Erikson, David');

call sp_fixname('Levine, Brad','Levine, Bradley');

-- Luis Antonio Aguilar
call sp_fixname('Aguilar, Luis Antonio','Aguilar, Luis');
call sp_fixname('Aguilar, Luis Antonio','Aguilar, Louis');
call sp_fixname('Aguilar, Luis Antonio','Agular, Luis');

-- Mexican junior Jose Luis De Alba Cardenas; going with Jose Luis De Alba but sometimes entered just Jose De Alba
call sp_fixname('De Alba, Jose Luis','De Alba, Jose');
call sp_fixname('De Alba, Jose Luis','De Alba Cardenas, Jose Luis');

-- Mexican 18U Cristhian Sanchez Rico.  Cristhian Sã¡nchez Rico

call sp_fixname('Sanchez, Cristhian','Rico, Cristhian Sanchez');
call sp_fixname('Sanchez, Cristhian','Sanchez, Cristian');
call sp_fixname('Sanchez, Cristhian','Rico Sanchez, Cristhian');


-- Another mexican junior Ruelas Reza, Sebastian A.
call sp_fixname('Ruelas, Sebastian Alejandro','Ruelas Reza, Sebastian A.');
call sp_fixname('Ruelas, Sebastian Alejandro','Ruelas Reza, Sebastian');
call sp_fixname('Ruelas, Sebastian Alejandro','Ruelas Reza, Sebastian Alejandro');


-- Samuel Lopez Kim; standardizing on simpler name
call sp_fixname('Lopez, Samuel','Lopez Kim, Samuel');
call sp_fixname('Lopez, Samuel','Lopez, Sam');

-- 	Sanchez, Sebastian Chevaile or Chevaile S,, Sebastian
call sp_fixname('Chevaile, Sebastian','Chevaile Sanchez, Sebastian');
call sp_fixname('Chevaile, Sebastian','Sanchez, Sebastian Chevaile');
call sp_fixname('Chevaile, Sebastian','Chevaile S,, Sebastian');
call sp_fixname('Chevaile, Sebastian','Chevaile S, Sebastian');


-- 2024 PARC, 2023 Worlds name fixes
call sp_fixname('Gatica, Rafael','Gatica,Rafael');

-- 2024 usa juniors
call sp_fixname('Ali, Eshan','Eli, Eshan');

call sp_fixname('Pimentel, Diego','Pimental, Diego');

-- 2024 irt season ending work
call sp_fixname('Rocabado, Leonardo','Rocobado, Leonardo');

-- IRT touring pro Carlos Ramirez in database with full name Ramirez, Carlos Alberto
call sp_fixname('Ramirez, Carlos','Ramirez, Carlos Alberto');


-- 16U bolivian titlist in 2025: standardizing on simple version of name
call sp_fixname('Borja, Santiago','Borja, Alfredo Santiago');


-- Huyke Brothers: Colombian juniors 2026
call sp_fixname('Huyke, Orlando Josue','Huyke, Orlando Josu');
call sp_fixname('Huyke, Orlando Josue','Huyke, Orlando Josua');
call sp_fixname('Huyke, Orlando Josue','Huyke, Orlando');

call sp_fixname('Huyke, Mario Andres','Huyke, Mario');

-- Jesús	Roberto	Jacquez	Anchondo: removing just last name
call sp_fixname('Jacquez, Jesus Roberto','Jacquez Anchodo, Jesus Roberto');

-- Einer	Andrã©	Loza	Mercado: standardizing on Einer Loza
-- Jose	Luis	De	Alba	Cardenas: standardizing on Jose Luis De Alba

-- Bolivian u21 champ: Jhoel Alexis Acha
call sp_fixname('Acha, Jhoel Alexis','Acha, Joel');
call sp_fixname('Acha, Jhoel Alexis','Acha, Jhoel');

-- Ortega Jr., Guillermo: standardizing and correcting when appears w/o Jr.

call sp_fixname('Ortega Jr., Guillermo','Ortega, Guillermo');

-- typo in mexican junior
call sp_fixname('Sanchez, Marcelo Garcia','Sanchez, Marcelo Garcaa');

call sp_fixname('Haacke, Scott','Haake, Scott');


-- zzz


/*
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings union
select player from player_profile
order by 1;
*/




/* ------------------------------------------------------------------------------------------------- */
/* LPRT/Ladies data last  */
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


-- Married: was Susana Acosta, now Susana Acosta Mendoza.  Still going by maiden name
call sp_fixname ('Acosta, Susana','Acosta, Susy');
call sp_fixname ('Acosta, Susana','Acosta-Mendoza, Susy');
call sp_fixname ('Acosta, Susana','Acosta Mendoza, Susy');

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

-- This might be the same person as Veronique.  Very likely actually.

call sp_fixname ('Guillemette, Lucia','Guillemette, Lucie');
call sp_fixname ('Guillemette, Lucia','Guilllemette, Lucie');

call sp_fixname ('Kwon, Marie Malhee','Kwon, Malhee');
call sp_fixname ('Kwon, Marie Malhee','Kwon, Mahlee');

call sp_fixname ('Loredo, Arantza','Lored, Arantza');

call sp_fixname ('Pimentelli, Devon','Pinentelli, Devon');

-- 2017; married again, now changing to use Larssen hyphenated
-- also changed to Jacqueline from Jackie?  no using commonly used name
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso-Gibson, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Gibson, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Rice, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso Rice, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso-Rice, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Rice, Jackie Paraiso');
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso, Jackie');
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso-Larsson, Jacqueline');
call sp_fixname ('Paraiso-Larsson, Jackie','Paraiso, Jacqueline');


-- Joy = Jackie's twin sister
call sp_fixname ('Paraiso-MacKenzie, Joy','Paraiso, Joy');
call sp_fixname ('Paraiso-MacKenzie, Joy','MacKenzie, Joy');


-- Not bothering with this one since she retired before marrying?  Should probably fix.
call sp_fixname ('Waselenchuk (Russell), Kim','Russell, Kim');
call sp_fixname ('Waselenchuk (Russell), Kim','Waselenchuk, Kim');

-- going with Samantha Salas; that's what LPRT site says
-- Samantha Violenta Salas

call sp_fixname ('Salas, Samantha','Solis, Samantha Salas');
call sp_fixname ('Salas, Samantha','Salas, Samantha Violenta');
call sp_fixname ('Salas, Samantha','Salas Solis, Samantha');


-- She played before and after marriage, so fix.
call sp_fixname ('Huczek (Van Hees), Christie','Van Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Huczek, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van-Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van-Hees, Christie');
call sp_fixname ('Huczek (Van Hees), Christie','Van Hess, Kristi');
call sp_fixname ('Huczek (Van Hees), Christie','Van Hees, Kristi');
call sp_fixname ('Huczek (Van Hees), Christie','Van Hees, Christine');


call sp_fixname ('Wachtel (Stoffregen), Kerri','Wachtel, Kerri');
call sp_fixname ('Wachtel (Stoffregen), Kerri','Stoffregen, Kerri');
call sp_fixname ('Wachtel (Stoffregen), Kerri','Stoffregen Wachtel, Kerri');

call sp_fixname ('Warhftig, Sarah','Warhaftig, Sarah');

call sp_fixname ('Lucas (Wiragh), Michelle','Wiragh, Michelle');
call sp_fixname ('Lucas (Wiragh), Michelle','Lucas, Michelle');

-- Leaving out maiden name since she retired before marrying
call sp_fixname ('Wright, Shannon','Wright-Hamilton, Shannon');

-- was married and was Aimee Ruiz, now divorced and back to her maiden name
call sp_fixname ('Roehler, Aimee','Roehler, Aime');
call sp_fixname ('Roehler, Aimee','Roehler, Amy');
call sp_fixname ('Roehler, Aimee','Ruiz, Aimee');
call sp_fixname ('Roehler, Aimee','Ruiz (Roehler), Aimee');


-- Not using her married name; played before got married.  2018 now going by a dash'd name
call sp_fixname ('Tisinger-Ledkins, Janel','Take (Tisinger), Janel');
call sp_fixname ('Tisinger-Ledkins, Janel','Take, Janel');
call sp_fixname ('Tisinger-Ledkins, Janel', 'Tisinger, Janel');
call sp_fixname ('Tisinger-Ledkins, Janel', 'Ledkins, Janel');

call sp_fixname ('Tisinger-Moore, Debbie','Tisinger, Debbie');


call sp_fixname ('Bellows (Walsh), Kristen','Walsh, Kristen');
call sp_fixname ('Bellows (Walsh), Kristen','Bellows, Kristen');
call sp_fixname ('Bellows (Walsh), Kristen','Walsh, Kristin');


call sp_fixname ('Gould (Gilman), Michelle','Gould, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman-Gould, Michelle');
call sp_fixname ('Gould (Gilman), Michelle','Gilman Gould, Michelle');

-- Not bothering with this one since she retired before marrying?  Nope; amateurs need fixing
call sp_fixname ('Conine (Doyle), Cindy','Doyle, Cindy');
call sp_fixname ('Conine (Doyle), Cindy','Doyle, Cynthia');


-- Bailey, Malia from  Malia Kamahoahoa Bailey
call sp_fixname ('Bailey (Kamahoahoa), Malia','Bailey Kamahoahoa, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Bailey, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Kamahoahoa, Malia');
call sp_fixname ('Bailey (Kamahoahoa), Malia','Kamahohoa, Malia');


-- Kelani got married Aug 2018; Kelani Bailey maiden name, now Kelani Lawrence
call sp_fixname ('Lawrence (Bailey), Kelani','Bailey, Kelani');
call sp_fixname ('Lawrence (Bailey), Kelani','Lawrence, Kelani');
call sp_fixname ('Lawrence (Bailey), Kelani','Lawence (Bailey), Kelani');
call sp_fixname ('Lawrence (Bailey), Kelani','Bailey Lawence, Kelani');
call sp_fixname ('Lawrence (Bailey), Kelani','Bailey Lawrence, Kelani');
call sp_fixname ('Lawrence (Bailey), Kelani','Lawence	(Bailey), Kelani');





call sp_fixname ('Kelly (Fischl), Dottie','Fischl, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Kelly, Dottie');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl, Dot');
call sp_fixname ('Kelly (Fischl), Dottie','Fischl, ?');
call sp_fixname ('Kelly (Fischl), Dottie','Fishl, Dottie');

call sp_fixname ('Pritchard, Dina','Pritchard, ?');



-- married dec 2014
call sp_fixname ('Thomas (Irons), Kimberly','Irons, Kimberly');
call sp_fixname ('Thomas (Irons), Kimberly','Thomas, Kim');
call sp_fixname ('Thomas (Irons), Kimberly','Irons, Kim');
call sp_fixname ('Thomas (Irons), Kimberly','Thomas, Kimberly');

-- married Mar2014; no this is wrong; these are two people  eliminate this.
-- call sp_fixname ('Soley (Rascon), Sofia','Rascon, Sofia');
-- call sp_fixname ('Soley (Rascon), Sofia','Soley, Sofia');

call sp_fixname ('Rascon, Sofia','Rason, Sofia');
call sp_fixname ('Rascon, Sofia','Rascon , Sofia');



-- married as of mid 2013
call sp_fixname ('Kirch (OBrien), Aubrey','O''Brien, Aubrey');
call sp_fixname ('Kirch (OBrien), Aubrey','OBrien, Aubrey');
call sp_fixname ('Kirch (OBrien), Aubrey','Kirch, Aubrey');

call sp_fixname ('Lee, Young Ock','Lee, Youngock');
call sp_fixname ('Lee, Young Ock','Youngcock, Lee');
call sp_fixname ('Lee, Young Ock','Lee, Young-Ock');

call sp_fixname ('Young-Mi, Lee','Young, Milee');

-- Married and then not
call sp_fixname ('Feaster, Shannon','Feaster-Stewart, Shannon');
call sp_fixname ('Feaster, Shannon','Feaster Stewart, Shannon');
call sp_fixname ('Feaster, Shannon','Stewart, Shannon');

call sp_fixname ('Feaster, Alexys','Feaster, Alexis');

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

-- Cristina Amaya Cassino
call sp_fixname ('Amaya, Cristina','Amaya, Christina');

call sp_fixname ('Barriga, Loreto','Barriga, Loreta');

-- Maria Jose Vargas Parada
call sp_fixname ('Vargas, Maria Jose','Vargas, Maria');
call sp_fixname ('Vargas, Maria Jose','Jose Maria, Vargas');
call sp_fixname ('Vargas, Maria Jose','Vargas Maria Jose');

-- Natalia Mendez Erlwein
call sp_fixname ('Mendez, Natalia','Mendez, Natalie');
call sp_fixname ('Mendez, Natalia','Mendez Erlwein, Natalia');

-- New Bolivian junior also named Natalia Mendez; will have to add her middle name to distinguish
-- Natalia Carolina Mendez Veizaga 

call sp_fixname ('Mendez, Natalia Carolina','Mendez (Bol), Natalia');
call sp_fixname ('Mendez, Natalia Carolina','Mendez, Natalia (Bol)');



-- NOT THE SAME person
-- call sp_fixname ('Nunez, Ana Paola','Nunez, Paola');
-- call sp_fixname ('Nunez, Ana Paola','Nunez, Ana');


-- Keri Allen vs Kerri Allen: went with Kerri
call sp_fixname ('Allen, Kerri','Allen, Keri');

-- Is this right??
-- eventually gets married I believe: Dana Sibell-Anderson
call sp_fixname ('Sibell-Anderson, Dana','Anderson, Dyan');
call sp_fixname ('Sibell-Anderson, Dana','Anderson, Dana');


-- believe these are the same
call sp_fixname ('Andrade, Claudia','Andrade, Claudio');
call sp_fixname ('Andrade, Claudia','Andrade, Maria Claudia');

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
call sp_fixname ('Daza, Jenny','Navia, Jenny');

call sp_fixname ('Deutsch, Lauren','Deutsch. Lauren');

-- No, its Aguilar; had this wrong for a while.
call sp_fixname ('Aguilar, Diana','Diana Acquilar');
call sp_fixname ('Aguilar, Diana','Diana Aquilar');
call sp_fixname ('Aguilar, Diana','Acquilar, Diana');
call sp_fixname ('Aguilar, Diana','Aquilar, Diana');
call sp_fixname ('Aguilar, Diana','Acuilar, Diana');

call sp_fixname ('Holtslander, Khanh','Holtslander, Khahn');


call sp_fixname ('Gremley, Kelly','Kelly Gremley');



-- Luque is now Rivera; married/changed mid 2016-17 season
call sp_fixname ('Luque, Carolina','Luque Carolina');
call sp_fixname ('Luque, Carolina','Carolina Luque');
call sp_fixname ('Rivera (Luque), Carolina','Luque, Carolina');
call sp_fixname ('Rivera (Luque), Carolina','Rivera Luque, Carolina');
call sp_fixname ('Rivera (Luque), Carolina','Rivera, Carolina');



call sp_fixname ('Maldonado, Anita','Maldonaldo, Anita');
call sp_fixname ('Maldonado, Jessica','Maldonaldo, Jessica');

-- Denisse Maldonado Munoz
call sp_fixname ('Maldonado, Denisse','Maldondo, Denisse');
call sp_fixname ('Maldonado, Denisse','Maldonado, Danisse');
call sp_fixname ('Maldonado, Denisse','Maldonado, Denisse');

call sp_fixname ('DelliSanti, Maria','Maria DelliSanti');
call sp_fixname ('Delli-Santi, Maria','DelliSanti, Maria');

call sp_fixname ('McElfresh, Melissa','McElfrish, Melissa');

-- Daniela Molina Nevarez
call sp_fixname ('Molina, Daniela','Molina, Damiela');

call sp_fixname ('Morton, Karen','Mortom, Karon');
call sp_fixname ('Morton, Karen','Morton, Karon');
call sp_fixname ('Morton, Karen','Morton, karen');


-- Maria Pazita Muñoz Albornoz full name.
call sp_fixname ('Munoz, Maria Paz','Paz Munoz, Maria');
call sp_fixname ('Munoz, Maria Paz','Munoz Albornoz, Maria Paz');
call sp_fixname ('Munoz, Maria Paz','Munoz Alboroz, Maria Paz');


call sp_fixname ('Rivera, Joanna','Rivera, Jhoana');
call sp_fixname ('Rivera, Joanna','Rivera, Johanna');
call sp_fixname ('Rivera, Joanna','Rivera, Johana');


-- New married Name 2025: Maria Renee Rodriguez Josey
-- still going to standardize on old name for now; discussed on FB July 2025 and she wants to go by Josey so we'll use Rodriguez in parenthesis)
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez, Maria');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez, Ma Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez, Marie Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez Sarmiento, Marie Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez Josey, Maria Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Josey, Maria Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Rodriguez, Maria Renee');
call sp_fixname ('Josey (Rodriguez), Maria Renee','Josey  (Rodriguez), Maria Renee');



call sp_fixname ('Sato, Maiko','Satou, Maiko');
call sp_fixname ('Sato, Maiko','Satoh, Maiko');

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

-- Married Mid 2022, now Danielle Ramsey zzz
call sp_fixname ('Ramsay (Drury), Danielle','Drury, Daniele');
call sp_fixname ('Ramsay (Drury), Danielle','Drury, Danielle');
call sp_fixname ('Ramsay (Drury), Danielle','Ramsay, Danielle');

call sp_fixname ('Ferina, Kimberly','Ferina, Kimi');
call sp_fixname ('Ferina, Kimberly','Ferina, Kim');

call sp_fixname ('Friedman, Randy','Freidman, Randi');
call sp_fixname ('Friedman, Randy','Freidman, Randy');
call sp_fixname ('Friedman, Randy','Freidman, Randi');
call sp_fixname ('Friedman, Randy','Friedman, Randi');


call sp_fixname ('Gluvna-Isett, Kathy','Glavine-iset, Kathy');

call sp_fixname ('Guzman Velgis, Eleni','Guzman, Eleni');
call sp_fixname ('Guzman Velgis, Eleni','Guzman, Eleny');
call sp_fixname ('Guzman Velgis, Eleni','Guzman Velgis, Eleni');
call sp_fixname ('Guzman Velgis, Eleni','Guzman, Eleni Velgis');



call sp_fixname ('Hamilton, Karina','Hamilton, karina');

-- The Herreras:
call sp_fixname ('Herrera, Alexandra','Herrera, Alexandria');
call sp_fixname ('Herrera, Alexandra','Herrera, Alexa');

call sp_fixname ('Herrera Cristina, Daniela','Herrera, Daniela');



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
call sp_fixname ('Marriott, Janell','Marriott, Janelle');


-- wrong 100% of the time in data entry but fixed here.  Full name: Ana Gabriela Martinez Gonzalez
-- May want to be "Gaby Martinez"
call sp_fixname ('Martinez, Ana Gabriela','Martinez, Gabriella');
call sp_fixname ('Martinez, Ana Gabriela','Martinez, Gabriela');
call sp_fixname ('Martinez, Ana Gabriela','Martinez, Gabriele');
call sp_fixname ('Martinez, Ana Gabriela','Martinez, Gabrielle');
call sp_fixname ('Martinez, Ana Gabriela','Martinez, Gaby');

call sp_fixname ('Morissette, Michele','Morisette, Michelle');
call sp_fixname ('Morissette, Michele','Morissette, Michelle');
call sp_fixname ('Morissette, Michele','Morrissette, Michelle');


call sp_fixname ('Noda, Etsuko','Noda, Estuko');
call sp_fixname ('Noda, Etsuko','Noda, Etuko');

call sp_fixname ('Noller, Cristie','Noller, Christee');

call sp_fixname ('Odegard, Karina','Odegaard, Karina');

call sp_fixname ('Parrilla, Jessica','Parilla, Jessica');

call sp_fixname ('Perrin, Robyn','Perrin, Robin');
call sp_fixname ('Perrin, Robyn','Perren, Robin');
call sp_fixname ('Perrin, Robyn','Perren, Robyn');

-- is this the former Orozco, Cecilia?  yes
-- Ana Cecilia Pratt Orozco 

call sp_fixname ('Pratt (Orozco), Cecilia','Orozco,  Cecilia');
call sp_fixname ('Pratt (Orozco), Cecilia','Pratt, Ceci');
call sp_fixname ('Pratt (Orozco), Cecilia','Pratt, Cecilia');
call sp_fixname ('Pratt (Orozco), Cecilia','Orozco, Cecilia');

call sp_fixname ('Rehling, Roxanne','Rehling, Rozanne');

-- What was Holly Remen's maiden name?  Was it Gray?  I believe so; leave it Gray?
-- call sp_fixname ('Remen (Gray), Holly','Gray, Holly');



-- Is Rivera, Anna == Rivera, Ana Kristin ?  Great question; still need to resolve.  Tim thinks so, going with it.
-- one thing for sure: its definitely Kristin in r2sports, not Kristina
-- is this also Anna Kristyn Rivera Droves??  Might be; this was the name used in 2015 Mexico jr nationals.  may have to clean up.

-- call sp_fixname ('Rivera, Ana Kristin','Rivera, Anna');
call sp_fixname ('Rivera, Ana Kristin','Rivera, Ana Kristina');
call sp_fixname ('Rivera, Ana Kristin','Rivera, Ana Cristina');
call sp_fixname ('Rivera, Ana Kristin','Rivera, Anna');
call sp_fixname ('Rivera, Ana Kristin','Rivera, Anna Kristyn');


call sp_fixname ('Saunders, Jennifer','Jennifer Saunders');
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

-- Married mid 90s, changed name.
call sp_fixname ('Dunn (MacDonald), Amanda','Dunn, Amanda MacDonald');
call sp_fixname ('Dunn (MacDonald), Amanda','MacDonald, Amanda');
call sp_fixname ('Dunn (MacDonald), Amanda','Dunn (MacDonald)');
call sp_fixname ('Dunn (MacDonald), Amanda','Dunn, Amanda');
call sp_fixname ('Dunn (MacDonald), Amanda','McDonald, Amanda');

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
-- is Ana Laura Flores same as Anakaren?  Do not believe so

-- is this right?  believe so.
-- full name: Ana Laura Flores Saavedra
call sp_fixname ('Flores, Ana Laura', 'Flores, Ana');
call sp_fixname ('Flores, Ana Laura', 'Flores, Laura');

call sp_fixname ('Gonzalez, Andrea Martinez','Martinez, Andrea');	

call sp_fixname ('Guzman Velgis, Eleni','Velgis, Eleni Guzman');	

call sp_fixname ('Del Granado Revollo, Gabriela','Revollo, Gabriela');	

-- is this right?
call sp_fixname ('Gordon, Mariana Tobon','Tobon, Marianna');	
call sp_fixname ('Gordon, Mariana Tobon','Tobon, Mariana');	

-- was Key, then Michelle De La Rosa, now Feb 2023 going back to key.  FEb 2026 married now Anderson
call sp_fixname ('Anderson (Key), Michelle','Ke, Michelle');	
call sp_fixname ('Anderson (Key), Michelle','Key, Michele');	
call sp_fixname ('Anderson (Key), Michelle','De La Rosa, Michelle');	
call sp_fixname ('Anderson (Key), Michelle','De La Rosa (Key), Michelle');	
call sp_fixname ('Anderson (Key), Michelle','Key, Michelle');	


-- was just Key now Maddox
call sp_fixname ('Maddux (Key), Danielle','Key, Danielle');	
call sp_fixname ('Maddux (Key), Danielle','Maddox, Danielle');	
call sp_fixname ('Maddux (Key), Danielle','Maddux, Danielle');	

-- Sharon Jackson went to Sharon Fox, now back to Sharon Jackson
call sp_fixname ('Jackson, Sharon','Fox, Sharon');	

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

-- elder Parent; now has two daughers who play
call sp_fixname ('Parent, Monique','Parent, ?');
call sp_fixname ('Parent, Monique','Parent, Michelle');

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

-- might be backwards; no think we have this right.
call sp_fixname ('Wojeck, Lynn','Wojcik, Lynn');
call sp_fixname ('Wojeck, Lynn','Wojek, Lyn');





call sp_fixname ('Chin-Varon, Mae','Chin, Mae');

call sp_fixname ('Dee-Jolly, Mary','Dee-Jolly, ?');
call sp_fixname ('Dee-Jolly, Mary','Dee, Mary');

call sp_fixname ('Erardi, Denny','Erardi, Denni');

call sp_fixname ('Olson, Roz','Olsen, Roz');

call sp_fixname ('Olson, Paul','Olsen, Paul');

call sp_fixname ('Risch, Jennifer (JJ)','Risch, ?');

call sp_fixname ('Supanick, Bev','Supanick, Beverly');
call sp_fixname ('Supanick, Bev','Supanik, Bev');

call sp_fixname ('Hartstein, Mindy','Hartsteain, Mindy');

call sp_fixname ('Barron, Marie','Baron, Marie');

call sp_fixname ('Bessent, Stephanie','Bessenet, Stephanie');

-- what are the odds that Kippi Bishop <> Kipie Boatright?

-- Is Lynn Cherry == Chad Cherry?

call sp_fixname ('Gopie, Jacqueline','Gopie, Jackie');


-- 2016-17 rankings fixes
call sp_fixname ('Enriquez, Nancy','Nancy Enriquez');

call sp_fixname ('Rivera, Carolina','Carolina Rivera');




call sp_fixname ('Hallett, Sandy','Sally Hallett');
call sp_fixname ('Hallett, Sandy','Sandy Hallett');
call sp_fixname ('Hallett, Sandy','Hallett, Sally');
call sp_fixname ('Hallett, Sandy','Hallet, Sally');
call sp_fixname ('Hallett, Sandy','Hallet, Sandy');

call sp_fixname ('Jungeon, Ana','Ana Jungeon');

call sp_fixname ('Seok, Jin Young','Jin Young Seok');


call sp_fixname ('Sauma Masis, Melania','Sauma, Melania');

-- Laura Fenton now Laura Fenton Kovanda; now fixing b/c she's competing in amateurs again
call sp_fixname ('Kovanda (Fenton), Laura','Fenton, Laura');

-- Keely Franks now Keely Franks Kennedy; not bothering to fix.

-- Angela Grisar is techncially Angela Grisar Martinez

-- Cristina Cordova == Maria Cristina Cordova?  I think so; otherwise we have serious data entry issues in IRF data  pretty sure this is iright.
call sp_fixname ('Cordova, Cristina','Cordova, Maria Cristina');

-- Munoz, Carla is Munoz Montesinos, Carla
call sp_fixname ('Munoz, Carla','Munoz Montesinos, Carla');

call sp_fixname ('Machiran, Kim','Machrian, Kim');

-- Int'l player believe this is right.
call sp_fixname ('Paredes, Islhey Mariana','Paredes, Mariana');

-- same person?  Is this spelled right?  Are these the same person?  Might have an issue here.
call sp_fixname ('Parades Guillen, Islhey','Parades Guillen,');
call sp_fixname ('Parades Guillen, Islhey','Parades, Islhey');


call sp_fixname('Kattan, Karen','Katan, Karen');

-- This is Montserrat Perez, with the T.  
call sp_fixname ('Perez, Montserrat','Perez, Montse');
call sp_fixname ('Perez, Montserrat','Perez, Monserrat');

-- Monserrat Mejia is WITHOUT the T.
call sp_fixname('Mejia, Monserrat','Mejia, Monserratt');
call sp_fixname('Mejia, Monserrat','Mejia, Montse');
call sp_fixname('Mejia, Monserrat','Mejia, Monste');
call sp_fixname('Mejia, Monserrat','Mejia, Montserrat');
call sp_fixname('Mejia, Monserrat','Mejia, Monserrate');
call sp_fixname('Mejia, Monserrat','Mejia, Monserrat');

call sp_fixname('Sauve, Jewel','Sauv?, Jewel');

-- Just leaving this at simple name, not full name.
-- full name: Lucia Fernandez Gonzalez Rodriguez
call sp_fixname('Gonzalez, Lucia','Gonzalez, Lucia Fernandex');
call sp_fixname('Gonzalez, Lucia','Gonzalez, Lucia Fernandez');

call sp_fixname('Bernard, Natalie','Bernard, Nathalie');

call sp_fixname('Pfaler (Morgan), Susan','Pfaler, Susan');
call sp_fixname('Pfaler (Morgan), Susan','Pfaler Morgan, Susan');
call sp_fixname('Pfaler (Morgan), Susan','Pfaler, Susan Morgan');
call sp_fixname('Pfaler (Morgan), Susan','Morgan Pfaler, Susan');

call sp_fixname('Franck, Carol','Franck, carol');

call sp_fixname('DiTommaso, Joanne','Ditommaso, Joanne');
call sp_fixname('DiTommaso, Joanne','Ditommaso,  Joanne');

-- Not entirely sure about this while doing Canada data entry so leaving commented out.  No, this is right.
call sp_fixname('Shanks (Brown), Vicki','Brown, Vicki');
call sp_fixname('Shanks (Brown), Vicki','Shanks, Vicki');

-- Debbie Ward got married; or is Hope just her last name?
call sp_fixname('Ward (Hope), Debbie','Ward, Debbie');
call sp_fixname('Ward (Hope), Debbie','Ward, Deborah');


call sp_fixname('McTaggart, Cindy','McTaggert, Cindy');

call sp_fixname('Lee, Cassandra','Lee, Cassi');
call sp_fixname('Lee, Cassandra','Lee, Casandra');


-- Is Yazmine Sabja == Jasmine Sabja??  Yes I believe it is and on FB she calls herself Yazmine so changing it
-- full name Yazmine Sabja Aliss
call sp_fixname('Sabja, Yazmine','Sabja, Jasmine');
call sp_fixname('Sabja, Yazmine','Sabja, Yasmine');


-- Erin Groves is now Erin (Groves) Rivera; married/changed names 2017 timeframe
-- wait ... is this right?? She's in 18U; did she really get married??  Yeah believe so.
-- Erin Marcela Rivera Groves

call sp_fixname('Rivera (Groves), Erin','Rivera, Erin');
call sp_fixname('Rivera (Groves), Erin','Groves, Erin');
call sp_fixname('Rivera (Groves), Erin','Rivera, Marcela');



call sp_fixname('Bendfeldt, Jennifer','Bendfeldt, J.');
call sp_fixname('Bendfeldt, Jennifer','Benfeldt, Jennifer');
call sp_fixname('Bendfeldt, Jennifer','Benfelt, Jennifer');
call sp_fixname('Bendfeldt, Jennifer','Bendfelt, Jennifer');

call sp_fixname('Bendfeldt, Manolo','Bendfelt, Manolo');
call sp_fixname('Bendfeldt, Manolo','Bendfelt, Manola');
call sp_fixname('Bendfeldt, Manolo','Bendfeldt, Monola');

-- Was Stefanny in 2017, now just Angelica in 2018.  goes by Angie?
call sp_fixname('Barrios, Angelica','Barrios, Steffany');
call sp_fixname('Barrios, Angelica','Barrios, Stefanny');
call sp_fixname('Barrios, Angelica','Barrios, Stefanny Angelica');
call sp_fixname('Barrios, Angelica','Barrios, Stefanny Angelica');
call sp_fixname('Barrios, Angelica','Barrios, Angela');

call sp_fixname('Bolanos, Diana','Bolanos, ?');

call sp_fixname('Cambra, Michelle','Cambra, Michel');

call sp_fixname('Viera Gonzalez, Maria Regla','Viera, Maria Regla');

call sp_fixname('Zachrisson, Karen','Zachrison, Karen');

-- might be Lucy de Zachrisson; leaving w/o the de for now

call sp_fixname('Zachrisson, Lucy','Zachrison, Lucy');
call sp_fixname('Zachrisson, Lucy','Zachrisson, L.');
call sp_fixname('Zachrisson, Lucy','de Zachrisson, Lucy');


-- should we change name to Kessler Payne?
call sp_fixname('Kessler, Deborah','Kessler, Debbie');
call sp_fixname('Kessler, Deborah','Kessler, Debora');
call sp_fixname('Kessler, Deborah','Kessler Payne, Debora');

-- relationship to Deborah Kessler?
call sp_fixname ('Sasso Kessler, Naomi','Sasso, Naomi');


-- this is IRF name assumption
call sp_fixname ('Consegal, Elisabet','Consegal, Bet');

-- Merynanyelly Delgado Araujo full name: standardizing on full name
call sp_fixname ('Delgado Araujo, Merynanyelly','Delgado, Marynanyelly');
call sp_fixname ('Delgado Araujo, Merynanyelly','Delgado, Meryanyelly');
call sp_fixname ('Delgado Araujo, Merynanyelly','Delgado, Merynanyelly');
call sp_fixname ('Delgado Araujo, Merynanyelly','Delgado, Mary');
call sp_fixname ('Delgado Araujo, Merynanyelly','Delgado, Mery');



call sp_fixname ('Dong-Yong, Kim','Dongyoun, Kim');

call sp_fixname ('Geyer, Lily','Geyer, L.');

call sp_fixname ('Gomez, Rosa Amelia','Gomez, Rosa');

call sp_fixname ('Haverty, Majella','Haventry, Majella');

call sp_fixname ('Jimenez, Alejandra','Jimenez, Alenandra');


call sp_fixname ('Huynh, Lan','Huynh, L.');
call sp_fixname ('Huynh, Lan','Huynh, L');
call sp_fixname ('Huynh, Lan','Hyunh, Lan');

call sp_fixname ('Jarrin, Martha','Jarrin, M.');

call sp_fixname ('Pfahler (Morgan), Susan','Morgan, Susan');
call sp_fixname ('Pfahler (Morgan), Susan','Morgan-Phaler, Susan');
call sp_fixname ('Pfahler (Morgan), Susan','Morgan-Pfhaler, Susan');


-- WOR hall of fame player; married to Greg McDonald
-- Nee Martha Byrd

call sp_fixname ('McDonald (Byrd), Martha','Byrd, Martha');
call sp_fixname ('McDonald (Byrd), Martha','McDonald, Martha');

-- Lynn Adams married Rich Clay post-career; should we change to Clay (Adams), Lynn?  nah.

-- Mary Lyon Gansville

-- discovered in 2018 has married name; changing to be consistent with her FB presence
-- might be 1996 pro natioanls discrepancy but doubtful
call sp_fixname ('Mayadas-Dering, Jennifer','Dering, Jen');
call sp_fixname ('Mayadas-Dering, Jennifer','Dering, Jennifer');
call sp_fixname ('Mayadas-Dering, Jennifer','Mayades-Dering, Jennifer');
call sp_fixname ('Mayadas-Dering, Jennifer','Mayadas, Jennifer');
call sp_fixname ('Mayadas-Dering, Jennifer','Mayades, Jennifer');


call sp_fixname ('Franco, Regina','Franco, Ma Regina');
call sp_fixname ('Franco, Regina','Franco, Maria Regina');


call sp_fixname ('Scott, Hollie','Scott, Holly');

call sp_fixname ('Cooperrider, Jordan','Cooperider, Jordan');

-- 
call sp_fixname ('Griffen, Guadalupe','Griffen Guadalupe');
call sp_fixname ('Griffen, Guadalupe','Griffin, Guadalupe');

-- full name Valeria Centellas Claros
call sp_fixname ('Centellas, Valeria','Centellas, Valerie');
call sp_fixname ('Centellas, Valeria','Centellas Claros, Valeria');


call sp_fixname ('Gates, Dawn Marie','Gates, Dawn');

call sp_fixname ('Willhite, Ashley','White, Ashley');
call sp_fixname ('Willhite, Ashley','Wilhite, Ashley');


-- this is an assumption
call sp_fixname ('Rodriguez, Monserrat','Rodriguez, Monsserratt');
call sp_fixname ('Rodriguez, Monserrat','Rodriguez, Montserrat');
call sp_fixname ('Rodriguez, Monserrat','Rodriguez, Montserrate');
call sp_fixname ('Rodriguez, Monserrat','Rodriguez, Monserrate');
call sp_fixname ('Rodriguez, Monserrat','Rodriguez, Montserrat');

-- shortening this for space
call sp_fixname ('Cuellar, Estefania del Carmen','Cuellar Iglesias, Estefania del Carmen');

-- standardizing on shortened name
call sp_fixname ('Laime, Brenda','Laime Jalil, Brenda Raquel');
call sp_fixname ('Laime, Brenda','Brenda Laime Jalil');
call sp_fixname ('Laime, Brenda','Laime Jalil, Brenda');
call sp_fixname ('Laime, Brenda','Jalil, Brenda Laime');

call sp_fixname ('Manilla, Erika','Manilla, Erica');

call sp_fixname ('Kuhfeld, Kaye','Kuhfield, Kaye');

call sp_fixname ('Meneses, Micaela','Meneses, Micaela');
call sp_fixname ('Meneses, Micaela','Menses, Micaela');
call sp_fixname ('Meneses, Micaela','Meneses Cuellar, Micaela');

-- full name: Masiel Simone Rivera Oporto
call sp_fixname ('Rivera, Masiel','Rivera Oporto, Masiel Simone');

call sp_fixname ('Duffie, Elyse','Duffy, Elyse');

-- full name: Daniela Edith Rico Segura
call sp_fixname ('Rico, Daniela','Rico Segura, Daniela');
call sp_fixname ('Rico, Daniela','Rico Segura, Daniela Edith');


-- 2018-19 lprt fixes

call sp_fixname ('Neils, Katharine','Neils, Katherine');
call sp_fixname ('Neils, Katharine','Neils. Katherine');
call sp_fixname ('Neils, Katharine','Neils, Katie');
call sp_fixname ('Neils, Katharine','Niels, Katherine');
call sp_fixname ('Neils, Katharine','Niels, Katie');


call sp_fixname ('Quiroga, Andrea Michelle','Quiroga, Andrea');

call sp_fixname ('Del Granado, Gabriela','Del Granado Revollo, Gabriela');
call sp_fixname ('Rivero, Camila', 'Rivero, Camilla');

call sp_fixname ('Mazuelos, Melissa Edith','Mazuelos, Melissa');

call sp_fixname ('Garcia, Andrea','Garcaa, Andrea');

-- Jessica Balderrama Perez; Mexicanjunior
call sp_fixname ('Balderrama, Jessica','Perez, Jessica Balderamma');
call sp_fixname ('Balderrama, Jessica','Perez, Jessica Balderrama');
call sp_fixname ('Balderrama, Jessica','Balderamma, Jessica');


-- Trujillo, Mariafernanda was jammed together.  This is correct; seen in additional years.  Change to be together.

call sp_fixname ('Trujillo, Mariafernanda','Trujillo, Maria fernanda');
call sp_fixname ('Trujillo, Mariafernanda','Trujillo, Maria Fernanda');


-- Is Ximena Barraza the same as Zara Barraza??  Does not seem so; two different cities.

call sp_fixname ('Dupuy, Carol','Dupay, Carol');

call sp_fixname ('Frenck, Carol','French, Carol');

-- full name: Cynthia Araceli Gutierrez Ceja; mexican junior
call sp_fixname ('Gutierrez, Cynthia','Gutierrez, Cynthia Araceli');


call sp_fixname ('Sarmiento, Ana Lucia','Sarmiento, Ana');

-- mexican junior
-- Maria Fernanda Gutierrez Ceja 
call sp_fixname ('Gutierrez, Maria','Gutierrez, Mariafer');
call sp_fixname ('Gutierrez, Maria','Gutierrez, Marifer');
call sp_fixname ('Gutierrez, Maria','Gutierrez, Maria Fernanda');
call sp_fixname ('Gutierrez, Maria','Gutierrez, Mariafernanda');
call sp_fixname ('Gutierrez, Maria','Gutierrez, Marifernandez');

call sp_fixname ('Gutierrez, Maria','Gutierrez, Mafer');

-- 
call sp_fixname ('Guillen, Natalia','Guillen, Nathalia');

call sp_fixname ('Shetty, Sonya','Shetty, Sonia');

call sp_fixname ('Mancilla, Nicol','Mancilla, Nicole');

call sp_fixname ('Sacristan, Abril','Sacristan, Abril Daniela');
call sp_fixname ('Sacristan, Abril','Sacrisan, Abril');

-- Ecuadorian Maria Jose Munoz Albornoz
call sp_fixname ('Munoz, Maria Jose','Munoz Albornoz, Maria Jose');

-- Mexican Maria Munoz from Chihuahua


-- Bolivian Krystin Salinas Vazquez
call sp_fixname ('Salinas, Krystin','Salinas, Kristin');
call sp_fixname ('Salinas, Krystin','Vazquez, Krystin Salinas');




call sp_fixname ('Le, Thao','Le, T.');
call sp_fixname ('Le, Thao','Le,T.');


call sp_fixname ('Wargo, Graciana','Wargo, Graci');

-- player from early 70s on pro tour and WOR
call sp_fixname ('Gick, Nancy','Gick, ?');
call sp_fixname ('Gick, Nancy','Glick, ?');
call sp_fixname ('Gick, Nancy','Glick, Nancy');

call sp_fixname ('Heims, Diane','Hiems, Diane');
call sp_fixname ('Heims, Diane','Heims, ?');


-- Canadian junior fixes
call sp_fixname ('Leggett, Brittany','Legget, Brittany');
call sp_fixname ('Leggett, Ashley','Legget, Ashley');

call sp_fixname ('Murray, Alexandra','Murray, Alex');
call sp_fixname ('Murray, Alexandra','Murray, Alexandria');

call sp_fixname ('Nelson, Brittany','Nelson, Brittney');



call sp_fixname ('Ramirez, Katya','Ramirez, Katia');


call sp_fixname ('Sauser, Jean','Saucer, Jean');

call sp_fixname ('Weed, Betty','Weed, Bette');

call sp_fixname ('Harding, Jennifer','Harding, Jenny');

-- Christine Richardson married now Christine Keay
call sp_fixname ('Keay (Richardson), Christine','Richardson, Christine');
call sp_fixname ('Keay (Richardson), Christine','Keay, Christine');

-- Jasmine Suarez; as per her twitter, not Jazmine or w hatever
-- Suarez, Jasmine India also losing middle name

call sp_fixname ('Suarez, Jasmine','Suarez, Jazmine');
call sp_fixname ('Suarez, Jasmine','Suarez, Jasmine India');


-- guatemalan player 2022: Andrea Gabriela Reyes Perez; going by Reyes, Andrea using 

call sp_fixname ('Reyes, Andrea','Reyes, Andrea Gabriela');




call sp_fixname ('Riquelme, Maria Paz','Riquelme, Maria');
call sp_fixname ('Riquelme, Maria Paz','Paz, Maria');

call sp_fixname ('Riveros, Adriana','Riveros, Adrianna');


call sp_fixname ('Jansz, Carlee','Janz, Carlee');

call sp_fixname ('Katz, Martina','Martina, Katz');


-- Multiple fixes for the Perez-Picon sisters
call sp_fixname ('Perez-Picon, Estefania','Perez, Estefania');
call sp_fixname ('Perez-Picon, Estefania','Picon, Estefania Perez');

call sp_fixname ('Perez-Picon, Andrea','Perez, Andrea');
call sp_fixname ('Perez-Picon, Andrea','Picon, Andrea Perez');


-- Guatemalan player Jazmin Elizabeth Aguilar Salvatierra

call sp_fixname ('Aguilar, Jazmin Elizabeth','Aguilar, Jasmin');
call sp_fixname ('Aguilar, Jazmin Elizabeth','Aguilar, Jazmin');
call sp_fixname ('Aguilar, Jazmin Elizabeth','Aguilar, Jasmin Elizabeth');
call sp_fixname ('Aguilar, Jazmin Elizabeth','Aguilar Salvatierra, Jasmin');
call sp_fixname ('Aguilar, Jazmin Elizabeth','Aguilar Salvatierra, Jazmin');

-- Guatemalan Aguilar: Anna Paul Aguilar Salvatierra, somtimes goes as Paula Aguilar.  Fix this to be Paula, not Paul
call sp_fixname ('Aguilar, Anna Paula','Aguilar, Paula');
call sp_fixname ('Aguilar, Anna Paula','Aguilar, Paul');



-- Andrea Martínez Zermeño

call sp_fixname ('Martinez, Andrea','Aguilar, Jasmin');

-- we have 2 victoria rodriguezes: manually cleaned and will update as such going forward.
-- Rodriguez, Victoria (Mex)
-- Rodriguez, Victoria (USA)



-- 2024 PARC, 2023 Worlds name fixes

-- Samira Ferrer Marcilli; cuban; standardizing on just first last
call sp_fixname('Ferrer, Samira','Marcilli, Samira Ferrer');
call sp_fixname('Ferrer, Samira','Ferrer Marcilli, Samira');


-- 2024 junior fix
call sp_fixname('Rai, Sasha','Rai, Sashi');

-- Annie Roberts gets married 2024.
call sp_fixname('Sanchez-Roberts, Annie','Roberts, Annie');
call sp_fixname('Sanchez-Roberts, Annie','Sanchez (Roberts), Annie');
call sp_fixname('Sanchez-Roberts, Annie','Sanchez, Annie');


-- Guatemalan junior Jazmin Elizabeth Aguilar Salvatierra: will standardize on Aguilar, Jazmin Elizabeth
call sp_fixname('Aguilar, Jazmin Elizabeth','Salvatierra, Jazmin');
call sp_fixname('Aguilar, Jazmin Elizabeth','Aguilar Salvatierra, Jazmin');
call sp_fixname('Aguilar, Jazmin Elizabeth','Aguilar, Jazmin');
call sp_fixname('Aguilar, Jazmin Elizabeth','Aguilar, Jasmin Elizabeth');

-- Mexican junior: Alondra Yanez: have it backwards all over the place.

call sp_fixname('Yanez, Alondra','Allondra, Yanez');
call sp_fixname('Yanez, Alondra','Alondra, Yanez');
call sp_fixname('Yanez, Alondra','Yanez, Allondra');


-- Multiple names for Lily Farias; lets standardize
call sp_fixname('Farias, Lily','Farias, Lilia');
call sp_fixname('Farias, Lily','Farias, Lillia');



-- Standardizing on Fatima Sanchez Garcia
call sp_fixname('Garcia, Fatima Sanchez','Sanchez, Fatima');
call sp_fixname('Garcia, Fatima Sanchez','Garcia, Fatima');





commit;





-- zzz


/* ------------------------------------------------------------------------------------------------- */
/* Pickleball!  

removed all PB and put into scraipet_process.py 8/30/24

*/
/* ------------------------------------------------------------------------------------------------- */




/*

-- IRT/WRT version
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings 
union select player from cp30725_prs.player_profile where gender='M'
order by 1;



-- LPRT version
select distinct winner as name from results union
select distinct loser as name from results union
select distinct player from rankings union
select distinct player from seedings 
union select player from cp30725_prs.player_profile where gender='F'
order by 1;


-- IRF/Amateur version
select distinct winner as name from results union
select distinct loser as name from results union
-- select distinct player from rankings union
select distinct player from seedings 
union select player from cp30725_prs.player_profile
order by 1;


-- irf version with doubles.
select winner from (
select distinct winner from results
union 
select distinct loser from results
union 
select distinct player from seedings
union
select distinct winner_p1 from results_doubles
union 
select distinct winner_p2 from results_doubles
union
select distinct loser_p1 from results_doubles
union 
select distinct loser_p2 from results_doubles) w
order by 1;

*/


