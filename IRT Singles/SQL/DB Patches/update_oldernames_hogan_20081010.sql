/* 10/8/08: Marty Hogan recalls many older players w/o first names

Dan Alder
Bobby Bolan
Wayne Bowes
John Britos
Peter Britos
Erik Campbell
Steve chase
Dave Charleston
Rick Dern
Keith Dunlap
Bill Dunn
Dan Factor
Terry Fancher
Larry Fox
Mike Griffith
Ross Harvey
Scott Hawkins
Mark Martino
Matt Matthews
Steve Mondry
Ray Navarro
Ken Porco
Myron Roderick
Mike Romano
Ron Rubenstein
Steve Sulli
Evan Terry
Kelvin Vantrease
Kenny Wong
Pete Wright
Gary Zetrouer
*/

create table results_prehoganwork as select * from results;

update results set winner='Alder, Dan' where winner='Alder,D';
update results set winner='Bolan, Bobby' where winner='Bolan,B';
update results set winner='Bowes, Wayne' where winner='Bowes,W';
update results set winner='Britos, John' where winner='Britos,J';
update results set winner='Britos, Peter' where winner='Britos,P';
update results set winner='Campbell, Erik' where winner='Campbell,E';
update results set winner='Chase, Steve' where winner='Chase,S';
update results set winner='Charleston, Dave' where winner='Charleston,D';
update results set winner='Dern, Rick' where winner='Dern,R';
update results set winner='Dunlap, Keith' where winner='Dunlap,K';
update results set winner='Dunn, Bill' where winner='Dunn,B';
update results set winner='Factor, Dan' where winner='Factor,D';
update results set winner='Fancher, Terry' where winner='Fancher,T';
update results set winner='Fox, Larry' where winner='Fox,L';
update results set winner='Griffith, Mike' where winner='Griffith,M';
update results set winner='Harvey, Ross' where winner='Harvey,R';
update results set winner='Hawkins, Scott' where winner='Hawkins,S';
update results set winner='Martino, Mark' where winner='Martino,M';
update results set winner='Matthews, Matt' where winner='Matthews,M';
update results set winner='Mondry, Steve' where winner='Mondry,S';
update results set winner='Navarro, Ray' where winner='Navarro,R';
update results set winner='Porco, Ken' where winner='Porco,K';
update results set winner='Roderick, Myron' where winner='Roderick,M';
update results set winner='Romano, Mike' where winner='Romano,M';
update results set winner='Rubenstein, Ron' where winner='Rubenstein,R';
update results set winner='Sulli, Steve' where winner='Sully,S';
update results set winner='Terry, Evan' where winner='Terry,E';
update results set winner='Vantrease, Kelvin' where winner='Vantrease,K';
update results set winner='Wong, Kenny' where winner='Wong,K';
update results set winner='Wright, Pete' where winner='Wright,P';
update results set winner='Zetrouer, Gary' where winner='Zetrouer,G';

update results set loser='Alder, Dan' where loser='Alder,D';
update results set loser='Bolan, Bobby' where loser='Bolan,B';
update results set loser='Bowes, Wayne' where loser='Bowes,W';
update results set loser='Britos, John' where loser='Britos,J';
update results set loser='Britos, Peter' where loser='Britos,P';
update results set loser='Campbell, Erik' where loser='Campbell,E';
update results set loser='Chase, Steve' where loser='Chase,S';
update results set loser='Charleston, Dave' where loser='Charleston,D';
update results set loser='Dern, Rick' where loser='Dern,R';
update results set loser='Dunlap, Keith' where loser='Dunlap,K';
update results set loser='Dunn, Bill' where loser='Dunn,B';
update results set loser='Factor, Dan' where loser='Factor,D';
update results set loser='Fancher, Terry' where loser='Fancher,T';
update results set loser='Fox, Larry' where loser='Fox,L';
update results set loser='Griffith, Mike' where loser='Griffith,M';
update results set loser='Harvey, Ross' where loser='Harvey,R';
update results set loser='Hawkins, Scott' where loser='Hawkins,S';
update results set loser='Martino, Mark' where loser='Martino,M';
update results set loser='Matthews, Matt' where loser='Matthews,M';
update results set loser='Mondry, Steve' where loser='Mondry,S';
update results set loser='Navarro, Ray' where loser='Navarro,R';
update results set loser='Porco, Ken' where loser='Porco,K';
update results set loser='Roderick, Myron' where loser='Roderick,M';
update results set loser='Romano, Mike' where loser='Romano,M';
update results set loser='Rubenstein, Ron' where loser='Rubenstein,R';
update results set loser='Sulli, Steve' where loser='Sully,S';
update results set loser='Terry, Evan' where loser='Terry,E';
update results set loser='Vantrease, Kelvin' where loser='Vantrease,K';
update results set loser='Wong, Kenny' where loser='Wong,K';
update results set loser='Wright, Pete' where loser='Wright,P';
update results set loser='Zetrouer, Gary' where loser='Zetrouer,G';
