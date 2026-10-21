-- 12/5/16: need to fix rankings and seedings too.

-- create table rankings_prenamefix20161205 as select * from rankings;

-- Decided that it is Tony Carson, not Anthony Carson
update rankings set player='Carson, Tony' where player='Carson, Anthony';
update rankings set player='Carson, Tony' where player='Carson, Anthony';

update rankings set player='Ackermann, Alex' where player='Ackerman, Alex';
update rankings set player='Ackermann, Alex' where player='Ackerman, Alex';

update rankings set player='Crockett, Allan' where player='Crockett, Allen';
update rankings set player='Crockett, Allan' where player='Crockett, Allen';

update rankings set player='Emmel, Matthew' where player='Emmell, Matt';
update rankings set player='Emmel, Matthew' where player='Emmell, Matt';

update rankings set player='Flores Jr. Jose' where player='Flores, Jose';
update rankings set player='Flores Jr. Jose' where player='Flores, Jose';

update rankings set player='Lavely, Danny' where player='Lavely, Dan';
update rankings set player='Lavely, Danny' where player='Lavely, Dan';

update rankings set player='Leetch, Erik' where player='Leetch, Eric';
update rankings set player='Leetch, Erik' where player='Leetch, Eric';

update rankings set player='Ortega, Eduardo Avila' where player='Ortega, Eduardo';
update rankings set player='Ortega, Eduardo Avila' where player='Ortega, Eduardo';

update rankings set player='Rogers, Bradley' where player='Rogers, Brad';
update rankings set player='Rogers, Bradley' where player='Rogers, Brad';

update rankings set player='Serrento, Jose' where player='Serrano, Jose';
update rankings set player='Serrento, Jose' where player='Serrano, Jose';

update rankings set player='Slamko, Jamie' where player='Slamko, James';
update rankings set player='Slamko, Jamie' where player='Slamko, James';

-- how was this wrong all this time??
update rankings set player='Vogel, Louis' where player='Vogel, Luis';
update rankings set player='Vogel, Louis' where player='Vogel, Luis';

update rankings set player='Austin, David' where player='Austin, Dave';
update rankings set player='Austin, David' where player='Austin, Dave';

update rankings set player='Baricuatro, Darryl' where player='Baricautro, Daniel';
update rankings set player='Baricuatro, Darryl' where player='Baricautro, Daniel';
update rankings set player='Baricuatro, Darryl' where player='Baricuarto, Darrell';
update rankings set player='Baricuatro, Darryl' where player='Baricuarto, Darrell';
update rankings set player='Baricuatro, Darryl' where player='Baricuatro, Darrell';
update rankings set player='Baricuatro, Darryl' where player='Baricuatro, Darrell';

update rankings set player='Brannigan, Erin' where player='Brannagan, Erin';
update rankings set player='Brannigan, Erin' where player='Brannagan, Erin';

update rankings set player='Chisholm, John-Craig' where player='Chisholm, John';
update rankings set player='Chisholm, John-Craig' where player='Chisholm, John';

update rankings set player='Creazzo, Vinny' where player='Creazzo, Vince';
update rankings set player='Creazzo, Vinny' where player='Creazzo, Vince';

update rankings set player='Ghafarshad, Dawoud' where player='Garfarshod, Dawoud';
update rankings set player='Ghafarshad, Dawoud' where player='Garfarshod, Dawoud';






commit;


-- 5/17/11: found some older names while going through late 70s/early 80s rankings...

update rankings set player='Kamalu, Kyle' where player='Kamalu,K';
update rankings set player='Kamalu, Kyle' where player='Kamalu,K';

update rankings set player='Davidson, Craig' where player='Davidson,C';
update rankings set player='Davidson, Craig' where player='Davidson,C';

update rankings set player='Perry, Scott' where player='Perry,S';
update rankings set player='Perry, Scott' where player='Perry,S';

update rankings set player='Antes, Mark' where player='Antes,M';
update rankings set player='Antes, Mark' where player='Antes,M';

update rankings set player='Hackbarth, Ralph' where player='Hackbarth,R';
update rankings set player='Hackbarth, Ralph' where player='Hackbarth,R';

update rankings set player='Lee, Allen' where player='Lee,A';
update rankings set player='Lee, Allen' where player='Lee,A';

update rankings set player='Lynch, John' where player='Lynch,J';
update rankings set player='Lynch, John' where player='Lynch,J';

update rankings set player='Nolan, Jack' where player='Nolan,J';
update rankings set player='Nolan, Jack' where player='Nolan,J';

update rankings set player='Rish, Charlie' where player='Rish,C';
update rankings set player='Rish, Charlie' where player='Rish,C';

update rankings set player='Texiera, Guy' where player='Texeria,G';
update rankings set player='Texiera, Guy' where player='Texeria,G';

update rankings set player='Valin, Brian' where player='Valin,B';
update rankings set player='Valin, Brian' where player='Valin,B';

update rankings set player='Christensen, Bruce' where player='Christensen,B';
update rankings set player='Christensen, Bruce' where player='Christensen,B';

-- 6/13/11: Steve "Bo" Keely helps with some more names
update rankings set player='Bowman, Jeff' where player='Bowman,J';
update rankings set player='Bowman, Jeff' where player='Bowman,J';

update rankings set player='Ikier, Paul' where player='Ikier,P';
update rankings set player='Ikier, Paul' where player='Ikier,P';

update rankings set player='Strom, Ron' where player='Strom,R';
update rankings set player='Strom, Ron' where player='Strom,R';

update rankings set player='Thurman, Bill' where player='Thurman,B';
update rankings set player='Thurman, Bill' where player='Thurman,B';

-- 12/2/16: noticing some data entry errors: putting in more.


update rankings set player='Majxner, Matthew' where player='Masxner, Matthew';
update rankings set player='Majxner, Matthew' where player='Masxner, Matthew';

update rankings set player='Martell, Jaime' where player='Martel, Jamie';
update rankings set player='Martell, Jaime' where player='Martel, Jamie';

update rankings set player='Adler, Joel' where player='Adler, Joe';
update rankings set player='Adler, Joel' where player='Adler, Joe';

update rankings set player='Aldana, Ismael' where player='Aldana, Isamel';
update rankings set player='Aldana, Ismael' where player='Aldana, Isamel';

update rankings set player='Alvidez, Javier' where player='Alvidrez, Javier';
update rankings set player='Alvidez, Javier' where player='Alvidrez, Javier';

update rankings set player='Baricuatro, Darryl' where player='Baricuarto, Darrell';
update rankings set player='Baricuatro, Darryl' where player='Baricuarto, Darrell';

update rankings set player='Barton, Christopher' where player='Barton, Chris';
update rankings set player='Barton, Christopher' where player='Barton, Chris';

update rankings set player='Bermudez, Armando' where player='Bermutez, Armondo';
update rankings set player='Bermudez, Armando' where player='Bermutez, Armondo';

update rankings set player='Bousquet, Nicolas' where player='Bousquet, Nicholas';
update rankings set player='Bousquet, Nicolas' where player='Bousquet, Nicholas';

update rankings set player='Casalvolone, Bruno' where player='Casalvolve, Bruno';
update rankings set player='Casalvolone, Bruno' where player='Casalvolve, Bruno';

update rankings set player='Chisholm, John-Craig' where player='Chisholm, John Craig';
update rankings set player='Chisholm, John-Craig' where player='Chisholm, John Craig';

update rankings set player='Crockett, Allan' where player='Crockett, Allen';
update rankings set player='Crockett, Allan' where player='Crockett, Allen';

update rankings set player='Cubillos, Set' where player='Cubillos, Seb';
update rankings set player='Cubillos, Set' where player='Cubillos, Seb';

update rankings set player='Derocheres, Eric' where player='Desrochers, Eric';
update rankings set player='Derocheres, Eric' where player='Desrochers, Eric';

update rankings set player='Flores, Ramon' where player='Florez, Ramon';
update rankings set player='Flores, Ramon' where player='Florez, Ramon';

update rankings set player='Funatani, Sadao' where player='Funati, Sadeo';
update rankings set player='Funatani, Sadao' where player='Funati, Sadeo';

update rankings set player='Gutierrez, Reydecel' where player='Gutierrez, Rey';
update rankings set player='Gutierrez, Reydecel' where player='Gutierrez, Rey';

update rankings set player='Gutierrez, Reydecel' where player='Guiterrez, Reydecel';
update rankings set player='Gutierrez, Reydecel' where player='Guiterrez, Reydecel';

-- Guitierrez, Leopoldo and Guitterez, Leo: unknown; last name misspelled?

update rankings set player='Hernandez, Allen' where player='Hernandez, Allan';
update rankings set player='Hernandez, Allen' where player='Hernandez, Allan';


update rankings set player='Husulak, Barret' where player='Husulack, Barret';
update rankings set player='Husulak, Barret' where player='Husulack, Barret';

update rankings set player='Jasso, Jesus Alberto' where player='Jasso, Jesus';
update rankings set player='Jasso, Jesus Alberto' where player='Jasso, Jesus';

update rankings set player='Jentsch, Neal' where player='Jentsch, Neale';
update rankings set player='Jentsch, Neal' where player='Jentsch, Neale';

update rankings set player='Jentsch, Neal' where player='Jentsch, Neale';
update rankings set player='Jentsch, Neal' where player='Jentsch, Neale';

-- run from here

update rankings set player='Lavely, Danny' where player='Lavely, Dan';
update rankings set player='Lavely, Danny' where player='Lavely, Dan';

update rankings set player='Lejia, Missael' where player='Leija, Missael';
update rankings set player='Lejia, Missael' where player='Leija, Missael';

update rankings set player='Leone, Jim' where player='Leone, James';
update rankings set player='Leone, Jim' where player='Leone, James';

update rankings set player='Lesieur, Brian' where player='Lesuir, Brian';
update rankings set player='Lesieur, Brian' where player='Lesuir, Brian';

update rankings set player='Maestas, Raymond' where player='Maestas, Ray';
update rankings set player='Maestas, Raymond' where player='Maestas, Ray';

update rankings set player='Mayorga, Jeff' where player='Mayorga, Jeffrey';
update rankings set player='Mayorga, Jeff' where player='Mayorga, Jeffrey';

update rankings set player='Mendieta, Fabian' where player='Mendietta, Fabian';
update rankings set player='Mendieta, Fabian' where player='Mendietta, Fabian';

update rankings set player='Mettenbrink, Travis' where player='Mettinbrink, Travis';
update rankings set player='Mettenbrink, Travis' where player='Mettinbrink, Travis';

update rankings set player='Minardo, Hank' where player='Mindardo, Hank';
update rankings set player='Minardo, Hank' where player='Mindardo, Hank';

update rankings set player='Molinari, Johnnie' where player='Molinari, John';
update rankings set player='Molinari, Johnnie' where player='Molinari, John';

update rankings set player='Montalbano, Nick' where player='Montabano, Nick';
update rankings set player='Montalbano, Nick' where player='Montabano, Nick';

-- Morales, Alejandro versus Morales, Alex: hmm.

-- Is Munoz, Luis Felipe same as Munoz, Felipe?  don't htink so

-- Ortiz, Sal Sr. same as Ortiz, Salvador?  Maybe

update rankings set player='Partovich, Roby' where player='Partovich, Robby';
update rankings set player='Partovich, Roby' where player='Partovich, Robby';

update rankings set player='Partovich, Roby' where player='Partovich, Toby';
update rankings set player='Partovich, Roby' where player='Partovich, Toby';

update rankings set player='Partovich, Roby' where player='Partrovich, Roby';
update rankings set player='Partovich, Roby' where player='Partrovich, Roby';

update rankings set player='Patendue, Patrick' where player='Pataniuda, Patrick';
update rankings set player='Patendue, Patrick' where player='Pataniuda, Patrick';

update rankings set player='Rhodes, John Lee' where player='Rhodes, John';
update rankings set player='Rhodes, John Lee' where player='Rhodes, John';

update rankings set player='Rojas, David' where player='Rojas, Mauro';
update rankings set player='Rojas, David' where player='Rojas, Mauro';

update rankings set player='Saito, Keichiro' where player='Saito, Keiichiro';
update rankings set player='Saito, Keichiro' where player='Saito, Keiichiro';

update rankings set player='Schmeiser, Arthur' where player='Schmeser, Arthur';
update rankings set player='Schmeiser, Arthur' where player='Schmeser, Arthur';

-- Serrano, Jose versus Serrento, Jose?  

update rankings set player='Sierra, Fernando' where player='Siera, Fernando';
update rankings set player='Sierra, Fernando' where player='Siera, Fernando';

update rankings set player='Torres, Jared' where player='Torres, Jarred';
update rankings set player='Torres, Jared' where player='Torres, Jarred';

update rankings set player='Ugalde, Jose Daniel' where player='Ugalde, Josaniel';
update rankings set player='Ugalde, Jose Daniel' where player='Ugalde, Josaniel';


-- Wagner Jr, Rich and Wagner, Rich: same?

update rankings set player='Wolfe, Clint' where player='Wolff, Clint';
update rankings set player='Wolfe, Clint' where player='Wolff, Clint';

update rankings set player='Yamashiro, Herbert' where player='Yamashiro, Herb';
update rankings set player='Yamashiro, Herbert' where player='Yamashiro, Herb';

update rankings set player='Yamashiro, Herbert' where player='Yashimiro, Herb';
update rankings set player='Yamashiro, Herbert' where player='Yashimiro, Herb';

update rankings set player='Yamashiro, Herbert' where player='Yashimiro, Herb';
update rankings set player='Yamashiro, Herbert' where player='Yashimiro, Herb';


commit;

