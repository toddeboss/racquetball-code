create table results_20190704 as select * from results;

SET SQL_SAFE_UPDATES = 0;

-- fixing possible spaces in the results;

update results set season='2019' where season like '2019%';
update results set season='2018' where season like '2018%';
update results set season='2017' where season like '2017%';
update results set season='2016' where season like '2016%';
update results set season='2015' where season like '2015%';
update results set season='2014' where season like '2014%';
update results set season='2013' where season like '2013%';
update results set season='2012' where season like '2012%';
update results set season='2011' where season like '2011%';
update results set season='2010' where season like '2010%';
update results set season='2009' where season like '2009%';
update results set season='2008' where season like '2008%';
update results set season='2007' where season like '2007%';
update results set season='2006' where season like '2006%';
update results set season='2005' where season like '2005%';
update results set season='2004' where season like '2004%';
update results set season='2003' where season like '2003%';
update results set season='2002' where season like '2002%';
update results set season='2001' where season like '2001%';
update results set season='2000' where season like '2000%';
update results set season='1999' where season like '1999%';
update results set season='1998' where season like '1998%';
update results set season='1997' where season like '1997%';
update results set season='1996' where season like '1996%';
update results set season='1995' where season like '1995%';
update results set season='1994' where season like '1994%';
update results set season='1993' where season like '1993%';
update results set season='1992' where season like '1992%';
update results set season='1991' where season like '1991%';
update results set season='1990' where season like '1990%';
update results set season='1989' where season like '1989%';
update results set season='1988' where season like '1988%';
update results set season='1987' where season like '1987%';
update results set season='1986' where season like '1986%';
update results set season='1985' where season like '1985%';
update results set season='1984' where season like '1984%';
update results set season='1983' where season like '1983%';
update results set season='1982' where season like '1982%';
update results set season='1981' where season like '1981%';
update results set season='1980' where season like '1980%';
update results set season='1979' where season like '1979%';
update results set season='1978' where season like '1978%';
update results set season='1977' where season like '1977%';
update results set season='1976' where season like '1976%';
update results set season='1975' where season like '1975%';
update results set season='1974' where season like '1974%';
update results set season='1973' where season like '1973%';
update results set season='1972' where season like '1972%';
update results set season='1971' where season like '1971%';
update results set season='1970' where season like '1970%';
update results set season='1969' where season like '1969%';
update results set season='1968' where season like '1968%';




select event,date,city,season,tour from results where round='2' order by tmp_date desc,event;

update results set tmp_date=STR_TO_DATE(date, '%m/%d/%Y');

commit;