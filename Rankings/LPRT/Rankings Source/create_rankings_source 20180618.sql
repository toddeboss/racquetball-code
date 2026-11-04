-- creation of the rankings source table
 -- depends on fully populated season_ending_standings status xls
 
-- select * from rankings_source;
 
insert into rankings_source (season,source) values ('1975-76','no rankings exist');
insert into rankings_source (season,source) values ('1976-77','no rankings exist');
insert into rankings_source (season,source) values ('1977-78','no rankings exist');

delete from rankings_source where season='1978-79';
insert into rankings_source (season,source) values ('1978-79','NR Mid 1979 loaded top 16 12/6/16');

insert into rankings_source (season,source) values ('1979-80','no rankings exist');
insert into rankings_source (season,source) values ('1980-81','NR, Aug.81, lindamojer.com archives');
insert into rankings_source (season,source) values ('1981-82','NR, Sept.82, lindamojer.com archives');
insert into rankings_source (season,source) values ('1982-83','NR, Aug.83, lindamojer.com archives');
insert into rankings_source (season,source) values ('1983-84','NR, Aug.84, lindamojer.com archives');
insert into rankings_source (season,source) values ('1984-85','NR, Sept.85, lindamojer.com archives');
insert into rankings_source (season,source) values ('1985-86','NR, Dec.86, lindamojer.com archives');
insert into rankings_source (season,source) values ('1986-87','NR, Sept.87, lindamojer.com archives');
insert into rankings_source (season,source) values ('1987-88','NR, Aug.88, lindamojer.com archives');
insert into rankings_source (season,source) values ('1988-89','NR, Sept.89, lindamojer.com archives');
insert into rankings_source (season,source) values ('1989-90','RB, Sept/Oct 90, lindamojer.com archives');
insert into rankings_source (season,source) values ('1990-91','RB, July/Aug 91, lindamojer.com archives');
insert into rankings_source (season,source) values ('1991-92','lindamojer.com archives');
insert into rankings_source (season,source) values ('1992-93','lindamojer.com archives');
insert into rankings_source (season,source) values ('1993-94','lindamojer.com archives');
insert into rankings_source (season,source) values ('1994-95','lindamojer.com archives');
insert into rankings_source (season,source) values ('1995-96','lindamojer.com archives');
insert into rankings_source (season,source) values ('1996-97','lindamojer.com archives');
insert into rankings_source (season,source) values ('1997-98','RM july-aug 1999; populated from "last year" ranking, enhanced from lindamojer.com archives');
insert into rankings_source (season,source) values ('1998-99','RM july-aug 1999');
insert into rankings_source (season,source) values ('1999-00','RM july-aug 2000');
insert into rankings_source (season,source) values ('2000-01','lindamojer.com archives, archive.org, ladiesproracquetball.com as of 6/4/01');
insert into rankings_source (season,source) values ('2001-02','lindamojer.com archives, archive.org, ladiesproracquetball.com as of 5/18/02');
insert into rankings_source (season,source) values ('2002-03','lindamojer.com archives, archive.org, ladiesproracquetball.com as of 5/7/03');
insert into rankings_source (season,source) values ('2003-04','Wikipedia LPRT home page');
insert into rankings_source (season,source) values ('2004-05','archive.org, ladiesproracquetball.com as of Aug 2005');
insert into rankings_source (season,source) values ('2005-06','archive.org, ladiesproracquetball.com as of 5/17/06');
insert into rankings_source (season,source) values ('2006-07','archive.org, ladiesproracquetball.com as of 5/7/07');
insert into rankings_source (season,source) values ('2007-08','archive.org, wpro-tour.com as of 4/29/08');
insert into rankings_source (season,source) values ('2008-09','archive.org, wpro-tour.com as of 7/21/09');
insert into rankings_source (season,source) values ('2009-10','wpro-tour.com data capture as of 5/9/10');
insert into rankings_source (season,source) values ('2010-11','wpro-tour.com data capture as of 5/20/11');
insert into rankings_source (season,source) values ('2011-12','wpro-tour.com data capture as of 6/19/12');
insert into rankings_source (season,source) values ('2012-13','lprtour.com data capture as of 5/20/13');
insert into rankings_source (season,source) values ('2013-14','lprtour.com data capture as of 5/20/14');
insert into rankings_source (season,source) values ('2014-15','lprtour.com data capture as of 5/20/14');
insert into rankings_source (season,source) values ('2015-16','lprtour.com data capture as of 6/21/16');
insert into rankings_source (season,source) values ('2016-17','current season');

update rankings_source set source='lprtour.com as of 6/22/17 post LPRT announcement of year end rankings release' where season='2016-17';

insert into rankings_source (season,source) values ('2017-18','current season');

update rankings_source set source='lprtour.com as of 6/11/18 as of end of final event' where season='2017-18';

insert into rankings_source (season,source) values ('2018-19','current season');





commit;

select * from rankings_source order by season