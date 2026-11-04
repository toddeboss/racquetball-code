/* 5/18/11: rankings sources table

9/19/12: fixed this for 2012-13

12/6/16: added in some additional rankings points.

*/

----------------------------------------------------------------------------------

use wwwbossconsultingcom;

drop table rankings_source;

create table rankings_source
(season varchar(10),
source varchar(1000));

----------------------------------------------------------------------------------
-- insert statements: generated from concatenate command in irt_season_standings.xls

-- After 2013-14 season; done per season within those SQLs...

-- running this 9/13/13
insert into rankings_source (season,source) values ('2013-14','Season not complete ... no final rankings yet');

delete from rankings_source where season='2012-13';
insert into rankings_source (season,source) values ('2012-13','IRT website 5/24/13');

delete from rankings_source where season='2011-12';
insert into rankings_source (season,source) values ('2011-12','IRT website 6/22/12');

delete from rankings_source where season='2010-11';
insert into rankings_source (season,source) values ('2010-11','IRT website 6/13/11');

insert into rankings_source (season,source) values ('2009-10','IRT website 5/19/10 and full PDF courtesy of Jason Mannino');
insert into rankings_source (season,source) values ('2008-9','IRT website 5/19/09, RM v20n3 Summer2009, full rankings XLS courtesy of ? source');
insert into rankings_source (season,source) values ('2007-8','IRT website 5/9/08, archive.org IRT website printout dated 4/28/08');

delete from rankings_source where season='2006-7';
insert into rankings_source (season,source) values ('2006-7','IRT website printout 6/11/07 via archive.org.  fixes done 10/11/09: corrected points, added top 20 from archive.org.  12/6/16 added entire rankings from archive.org file');

delete from rankings_source where season='2005-6';
insert into rankings_source (season,source) values ('2005-6','IRT Website 5/1/06.  Augmented 10/11/09 from archive.org, 12/6/16 put in top 50 from archive.org');

insert into rankings_source (season,source) values ('2004-5','IRT Website 5/5/05');

delete from rankings_source where season='2003-4';
insert into rankings_source (season,source) values ('2003-4','IRT website 5/2/04, augmented 10/11/09 from archive.org.  Updated full rankings 12/6/16 from archive.org');


delete from rankings_source where season='2002-3';
insert into rankings_source (season,source) values ('2002-3','Confirmed per IRT website May 2003.  Augmented 10/11/09 from archive.org.  12/6/16: uploaded full rankings from archive.org');


insert into rankings_source (season,source) values ('2001-2','Confirmed per IRT website May 2002');

delete from rankings_source where season='2000-1';
insert into rankings_source (season,source) values ('2000-1','Corrected per RM July/August 2001, Augmented 10/11/09 archive.org w/ points, top 20.  12/6/16 uploaded full rankings from archive.org');



delete from rankings_source where season='1999-00';
insert into rankings_source (season,source) values ('1999-00','Confirmed per RM July/August 2000, Augmented 10/10/09 archive.org to top 20, uploaded full rankings 12/6/16 from archive.org');


insert into rankings_source (season,source) values ('1998-9','Confirmed per RM jul/aug 99, 10/12/09 filled out to top 50');

delete from rankings_source where season='1997-8';
insert into rankings_source (season,source) values ('1997-8','Confirmed per RM jul/aug 98,  10/12/09 filled out to top 50.  12/6/16 added full rankings from archive.org');


insert into rankings_source (season,source) values ('1996-7','Confirmed per LM, RM jul/aug 97');
insert into rankings_source (season,source) values ('1995-6','Confirmed per ? Source (probably RM Jul/Aug 1996)');
insert into rankings_source (season,source) values ('1994-5','Confirmed per LM via RM sept/oct 1995');
insert into rankings_source (season,source) values ('1993-4','Believed correct; from summer 94 Killshot, Jul/Aug 94 RM');
insert into rankings_source (season,source) values ('1992-3','Confirmed per LM, ? Source');
insert into rankings_source (season,source) values ('1991-2','Accurate from Killshot Sept/Oct 92 v2n2, RM v3n4');
insert into rankings_source (season,source) values ('1990-1','Believed accurate: Killshot Sept 91, seedings at ToC');
insert into rankings_source (season,source) values ('1989-90','No source; #1,#2 drawn from inferences about the season.');
insert into rankings_source (season,source) values ('1988-9','NR 7/21/89 standings');
insert into rankings_source (season,source) values ('1987-8','Confirmed from NR July 88');
insert into rankings_source (season,source) values ('1986-7','Confirmed from NR Aug 87 issue');
insert into rankings_source (season,source) values ('1985-6','Confirmed from NR Aug 86 issue');
insert into rankings_source (season,source) values ('1984-5','Per NR Sept 85 v14 n9');
insert into rankings_source (season,source) values ('1983-4','Top 3 from NR Aug84 v13 n8, complete rankings from IR Summer 84 v2n6');
insert into rankings_source (season,source) values ('1982-3','Estimated from NR July 83, v12n7 pg 33 by using the rankings pre-Nationals.  Confirmed from Intl Racquetball July/Aug 1983 v1n2)  1st points is IRA computer points, 2nd is Catalina points');
insert into rankings_source (season,source) values ('1981-2','per NR 8/82 v11 n8');
insert into rankings_source (season,source) values ('1980-1','Results at NRC DP Nationals through quarterfinals');
insert into rankings_source (season,source) values ('1979-80','NRC "Rankings" based on prize money from NR 8/80 v9n8');

delete from rankings_source where season='1978-9';
insert into rankings_source (season,source) values ('1978-9','12/6/16 replaced DP qtrs results with top 20 from NR mid 1979');

insert into rankings_source (season,source) values ('1977-8','Results at NRC DP Nationals through quarterfinals');
insert into rankings_source (season,source) values ('1976-7','NR July 1977 v5n4 pg 131');
insert into rankings_source (season,source) values ('1975-6','Results at NRC DP Nationals through quarterfinals');
insert into rankings_source (season,source) values ('1974-5','Results at NRC DP Nationals through quarterfinals');



commit;

-- qa
select * from rankings_source order by season desc;