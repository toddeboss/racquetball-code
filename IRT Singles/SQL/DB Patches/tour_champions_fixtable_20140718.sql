/* Adding column to tour_champions so that we can join to the database properly */

use cp30725_men;

show tables;

select * from tour_champions order by player;

select distinct(player) from tour_champions order by player;

desc tour_champions;

alter table tour_champions add player_dbname varchar(50);

update tour_champions set player_dbname='Brumfield, Charlie' where player='Charlie Brumfield';
update tour_champions set player_dbname='Swain, Cliff' where player='Cliff Swain';
update tour_champions set player_dbname='Peck, Dave' where player='Dave Peck';
update tour_champions set player_dbname='Bledsoe, Davey' where player='Davey Bledsoe';
update tour_champions set player_dbname='Katchtik, Drew' where player='Drew Katchtik';
update tour_champions set player_dbname='Huczek, Jack' where player='Jack Huczek';
update tour_champions set player_dbname='Mannino, Jason' where player='Jason Mannino';
update tour_champions set player_dbname='Waselenchuk, Kane' where player='Kane Waselenchuk';
update tour_champions set player_dbname='Hogan, Marty' where player='Marty Hogan';
update tour_champions set player_dbname='Ray, Mike' where player='Mike Ray';
update tour_champions set player_dbname='Yellen, Mike' where player='Mike Yellen';
update tour_champions set player_dbname='Carson, Rocky' where player='Rocky Carson';
update tour_champions set player_dbname='Gonzalez, Ruben' where player='Ruben Gonzalez';
update tour_champions set player_dbname='Monchik, Sudsy' where player='Sudsy Monchik';
