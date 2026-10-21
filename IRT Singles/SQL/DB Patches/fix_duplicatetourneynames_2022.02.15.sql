-- Fixing all duplicate event names in the database.

SET SQL_SAFE_UPDATES = 0;

select event,count(*) from tourneys group by event having count(*) > 1;

select * from tourneys where event='APH Service Pro-Am';

update tourneys set event='APH Service Pro-Am 97' where event='APH Service Pro-Am' and date='12/14/1997';
update tourneys set event='APH Service Pro-Am 98' where event='APH Service Pro-Am' and date='12/13/1998';
update results set event='APH Service Pro-Am 97' where event='APH Service Pro-Am' and date='12/14/1997';
update results set event='APH Service Pro-Am 98' where event='APH Service Pro-Am' and date='12/13/1998';


select * from tourneys where event='Arizona Pro-Am';

update tourneys set event='Arizona Pro-Am 85' where event='Arizona Pro-Am' and date='1/27/1985';
update tourneys set event='Arizona Pro-Am 86' where event='Arizona Pro-Am' and date='1/1/1986';
update results set event='Arizona Pro-Am 85' where event='Arizona Pro-Am' and date='1/27/1985';
update results set event='Arizona Pro-Am 86' where event='Arizona Pro-Am' and date='1/1/1986';


select * from tourneys where event='Cameco Classic';

update tourneys set event='Cameco Classic 94' where event='Cameco Classic' and date='3/6/1994';
update tourneys set event='Cameco Classic 95' where event='Cameco Classic' and date='4/23/1995';
update results set event='Cameco Classic 94' where event='Cameco Classic' and date='3/6/1994';
update results set event='Cameco Classic 95' where event='Cameco Classic' and date='4/23/1995';


select * from tourneys where event='Catalina #1';

update tourneys set event='1981 Catalina #1' where event='Catalina #1' and date='10/1/1981';
update tourneys set event='1982 Catalina #1' where event='Catalina #1' and date='10/1/1982';
update results set event='1981 Catalina #1' where event='Catalina #1' and date='10/1/1981';
update results set event='1982 Catalina #1' where event='Catalina #1' and date='10/1/1982';


select * from tourneys where event='Catalina #2';
update tourneys set event='1981 Catalina #2' where event='Catalina #2' and date='10/20/1981';
update tourneys set event='1982 Catalina #2' where event='Catalina #2' and date='10/15/1982';
update results set event='1981 Catalina #2' where event='Catalina #2' and date='10/20/1981';
update results set event='1982 Catalina #2' where event='Catalina #2' and date='10/15/1982';


select * from tourneys where event='Catalina #3';
update tourneys set event='1981 Catalina #3' where event='Catalina #3' and date='11/1/1981';
update tourneys set event='1982 Catalina #3' where event='Catalina #3' and date='11/1/1982';
update results set event='1981 Catalina #3' where event='Catalina #3' and date='11/1/1981';
update results set event='1982 Catalina #3' where event='Catalina #3' and date='11/1/1982';



select * from tourneys where event='Catalina #4';
update tourneys set event='1981 Catalina #4' where event='Catalina #4' and date='1/17/1982';
update tourneys set event='1982 Catalina #4' where event='Catalina #4' and date='1/1/1983';
update results set event='1981 Catalina #4' where event='Catalina #4' and date='1/17/1982';
update results set event='1982 Catalina #4' where event='Catalina #4' and date='1/1/1983';

-- whoops, got years wrong
select * from tourneys where event like '%Catalina #4%';

update tourneys set event='1982 Catalina #4' where event='1981 Catalina #4' and date='1/17/1982';
update tourneys set event='1983 Catalina #4' where event='1982 Catalina #4' and date='1/1/1983';
update results set event='1982 Catalina #4' where event='1981 Catalina #4' and date='1/17/1982';
update results set event='1983 Catalina #4' where event='1982 Catalina #4' and date='1/1/1983';



select * from tourneys where event='Catalina #5';
update tourneys set event='1981 Catalina #5' where event='Catalina #5' and date='2/21/1982';
update tourneys set event='1982 Catalina #5' where event='Catalina #5' and date='2/1/1983';
update results set event='1981 Catalina #5' where event='Catalina #5' and date='2/21/1982';
update results set event='1982 Catalina #5' where event='Catalina #5' and date='2/1/1983';

-- whoops, got years wrong
select * from tourneys where event like '%Catalina #5%';
update tourneys set event='1982 Catalina #5' where event='1981 Catalina #5' and date='2/21/1982';
update tourneys set event='1983 Catalina #5' where event='1982 Catalina #5' and date='2/1/1983';
update results set event='1982 Catalina #5' where event='1981 Catalina #5' and date='2/21/1982';
update results set event='1983 Catalina #5' where event='1982 Catalina #5' and date='2/1/1983';

select * from tourneys where event='Catalina #6';

update tourneys set event='1982 Catalina #6' where event='Catalina #6' and date='3/15/1982';
update tourneys set event='1983 Catalina #6' where event='Catalina #6' and date='3/1/1983';
update results set event='1982 Catalina #6' where event='Catalina #6' and date='3/15/1982';
update results set event='1983 Catalina #6' where event='Catalina #6' and date='3/1/1983';


select * from tourneys where event='Catalina Nationals';
update tourneys set event='1982 Catalina Nationals' where event='Catalina Nationals' and date='5/23/1982';
update results set event='1982 Catalina Nationals' where event='Catalina Nationals' and date='5/23/1982';
update tourneys set event='1983 Catalina Nationals' where event='Catalina Nationals' and date='6/1/1983';
update results set event='1983 Catalina Nationals' where event='Catalina Nationals' and date='6/1/1983';

select * from tourneys where event='Catalina #7';
update tourneys set event='1983 Catalina #7' where event='Catalina #7' and date='4/1/1983';
update results set event='1983 Catalina #7' where event='Catalina #7' and date='4/1/1983';

commit;

select * from tourneys where event='CityFed Grand Nationals';

update tourneys set event='1988 CityFed Grand Nationals' where event='CityFed Grand Nationals' and date='5/1/1988';
update results set event='1988 CityFed Grand Nationals' where event='CityFed Grand Nationals' and date='5/1/1988';
update tourneys set event='1989 CityFed Grand Nationals' where event='CityFed Grand Nationals' and date='6/26/1989';
update results set event='1989 CityFed Grand Nationals' where event='CityFed Grand Nationals' and date='6/26/1989';


select * from tourneys where event='Cleveland Open';

update tourneys set event='2003 Cleveland Open' where event='Cleveland Open' and date='1/12/2003';
update results set event='2003 Cleveland Open' where event='Cleveland Open' and date='1/12/2003';
update tourneys set event='2004 Cleveland Open' where event='Cleveland Open' and date='1/11/2004';
update results set event='2004 Cleveland Open' where event='Cleveland Open' and date='1/11/2004';


select * from tourneys where event='DP Nationals';

update tourneys set event='1985 DP Nationals' where event='DP Nationals' and date='6/1/1985';
update results set event='1985 DP Nationals' where event='DP Nationals' and date='6/1/1985';
update tourneys set event='1986 DP Nationals' where event='DP Nationals' and date='6/1/1986';
update results set event='1986 DP Nationals' where event='DP Nationals' and date='6/1/1986';


select * from tourneys where event='DP/Leach Nationals';

update tourneys set event='1982 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/26/1982';
update results set event='1982 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/26/1982';
update tourneys set event='1983 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/15/1983';
update results set event='1983 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/15/1983';
update tourneys set event='1984 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/1/1984';
update results set event='1984 DP/Leach Nationals' where event='DP/Leach Nationals' and date='6/1/1984';


select * from tourneys where event='Ektelon Nationals';

update tourneys set event='1983 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1983';
update results set event='1983 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1983';
update tourneys set event='1984 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1984';
update results set event='1984 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1984';
update tourneys set event='1986 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1986';
update results set event='1986 Ektelon Nationals' where event='Ektelon Nationals' and date='5/1/1986';



select * from tourneys where event='Elmwood Summer Cooler';

update tourneys set event='1992 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler' and date='8/23/1992';
update results set event='1992 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler' and date='8/23/1992';
update tourneys set event='1998 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler' and date='8/9/1998';
update results set event='1998 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler' and date='8/9/1998';


select * from tourneys where event='Elmwood Summer Cooler Pro-Am';

update tourneys set event='1994 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1994';
update results set event='1994 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1994';
update tourneys set event='1995 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/13/1995';
update results set event='1995 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/13/1995';
update tourneys set event='1996 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/11/1996';
update results set event='1996 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/11/1996';
update tourneys set event='1997 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/10/1997';
update results set event='1997 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/10/1997';
update tourneys set event='1999 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1999';
update results set event='1999 Elmwood Summer Cooler Pro-Am' where event='Elmwood Summer Cooler Pro-Am' and date='8/8/1999';


select * from tourneys where event='Foxwoods Pro Nationals';

update tourneys set event='1996 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/28/1996';
update results set event='1996 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/28/1996';
update tourneys set event='1997 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/27/1997';
update results set event='1997 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/27/1997';
update tourneys set event='1998 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/26/1998';
update results set event='1998 Foxwoods Pro Nationals' where event='Foxwoods Pro Nationals' and date='4/26/1998';


select * from tourneys where event='Hampton Inn Pro Classic';

update tourneys set event='1994 Hampton Inn Pro Classic' where event='Hampton Inn Pro Classic' and date='1/23/1994';
update results set event='1994 Hampton Inn Pro Classic' where event='Hampton Inn Pro Classic' and date='1/23/1994';
update tourneys set event='1995 Hampton Inn Pro Classic' where event='Hampton Inn Pro Classic' and date='1/22/1995';
update results set event='1995 Hampton Inn Pro Classic' where event='Hampton Inn Pro Classic' and date='1/22/1995';


select * from tourneys where event='Kentucky Pro-Am';

update tourneys set event='2004 Kentucky Pro-Am' where event='Kentucky Pro-Am' and date='3/7/2004';
update results set event='2004 Kentucky Pro-Am' where event='Kentucky Pro-Am' and date='3/7/2004';
update tourneys set event='2009 Kentucky Pro-Am' where event='Kentucky Pro-Am' and date='10/12/2009';
update results set event='2009 Kentucky Pro-Am' where event='Kentucky Pro-Am' and date='10/12/2009';

select * from tourneys where event='Kunnan/Kennex Tournament of Champions';

update tourneys set event='1979 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='1/1/1979';
update results set event='1979 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='1/1/1979';
update tourneys set event='1980 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='2/2/1980';
update results set event='1980 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='2/2/1980';
update tourneys set event='1981 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='3/22/1981';
update results set event='1981 Kunnan/Kennex Tournament of Champions' where event='Kunnan/Kennex Tournament of Champions' and date='3/22/1981';


select * from tourneys where event='Labatts Pro-Am';

update tourneys set event='1974 Labatts Pro-Am' where event='Labatts Pro-Am' and date='10/1/1974';
update results set event='1974 Labatts Pro-Am' where event='Labatts Pro-Am' and date='10/1/1974';
update tourneys set event='1985 Labatts Pro-Am' where event='Labatts Pro-Am' and date='3/1/1985';
update results set event='1985 Labatts Pro-Am' where event='Labatts Pro-Am' and date='3/1/1985';


select * from tourneys where event='NC Open';

update tourneys set event='2002 NC Open' where event='NC Open' and date='4/14/2002';
update results set event='2002 NC Open' where event='NC Open' and date='4/14/2002';
update tourneys set event='2003 NC Open' where event='NC Open' and date='3/30/2003';
update results set event='2003 NC Open' where event='NC Open' and date='3/30/2003';
update tourneys set event='2004 NC Open' where event='NC Open' and date='3/21/2004';
update results set event='2004 NC Open' where event='NC Open' and date='3/21/2004';


select * from tourneys where event='New Jersey Pro-Am';

update tourneys set event='2001 New Jersey Pro-Am' where event='New Jersey Pro-Am' and date='2/12/2001';
update results set event='2001 New Jersey Pro-Am' where event='New Jersey Pro-Am' and date='2/12/2001';
update tourneys set event='2000 New Jersey Pro-Am' where event='New Jersey Pro-Am' and date='2/13/2000';
update results set event='2000 New Jersey Pro-Am' where event='New Jersey Pro-Am' and date='2/13/2000';



select * from tourneys where event='NRC DP/Leach Nationals';

update tourneys set event='1975 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='4/1/1975';
update results set event='1975 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='4/1/1975';
update tourneys set event='1976 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1976';
update results set event='1976 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1976';
update tourneys set event='1977 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1977';
update results set event='1977 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1977';
update tourneys set event='1978 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1978';
update results set event='1978 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/1/1978';
update tourneys set event='1979 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='5/1/1979';
update results set event='1979 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='5/1/1979';
update tourneys set event='1980 NRC DP/Leach Nationals' where event='Leach National Pro-Am Championship' and date='6/7/1980';
update results set event='1980 NRC DP/Leach Nationals' where event='Leach National Pro-Am Championship' and date='6/7/1980';
update tourneys set event='1981 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/13/1981';
update results set event='1981 NRC DP/Leach Nationals' where event='NRC DP/Leach Nationals' and date='6/13/1981';


select * from tourneys where event='Piehler Motors Pro-Am';

update tourneys set event='1997 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='3/2/1997';
update results set event='1997 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='3/2/1997';
update tourneys set event='1998 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='3/1/1998';
update results set event='1998 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='3/1/1998';
update tourneys set event='1999 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='2/28/1999';
update results set event='1999 Piehler Motors Pro-Am' where event='Piehler Motors Pro-Am' and date='2/28/1999';

select * from tourneys where event='Pro Nationals';

update tourneys set event='2001 IRT Pro Nationals' where event='Pro Nationals' and date='5/6/2001';
update results set event='2001 IRT Pro Nationals' where event='Pro Nationals' and date='5/6/2001';
update tourneys set event='2002 IRT Pro Nationals' where event='Pro Nationals' and date='5/12/2002';
update results set event='2002 IRT Pro Nationals' where event='Pro Nationals' and date='5/12/2002';
update tourneys set event='2003 IRT Pro Nationals' where event='Pro Nationals' and date='5/4/2003';
update results set event='2003 IRT Pro Nationals' where event='Pro Nationals' and date='5/4/2003';

select * from tourneys where event='San Diego Open';

update tourneys set event='2002 San Diego Open' where event='San Diego Open' and date='3/3/2002';
update results set event='2002 San Diego Open' where event='San Diego Open' and date='3/3/2002';
update tourneys set event='2003 San Diego Open' where event='San Diego Open' and date='3/2/2003';
update results set event='2003 San Diego Open' where event='San Diego Open' and date='3/2/2003';
update tourneys set event='2004 San Diego Open' where event='San Diego Open' and date='2/29/2004';
update results set event='2004 San Diego Open' where event='San Diego Open' and date='2/29/2004';

select * from tourneys where event='Seamco Classic';

update tourneys set event='1980 Seamco Classic' where event='Seamco Classic' and date='4/20/1980';
update results set event='1980 Seamco Classic' where event='Seamco Classic' and date='4/20/1980';
update tourneys set event='1981 Seamco Classic' where event='Seamco Classic' and date='4/12/1981';
update results set event='1981 Seamco Classic' where event='Seamco Classic' and date='4/12/1981';

select * from tourneys where event='Shop n Save Pro-Am';

update tourneys set event='1991 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/1/1991';
update results set event='1991 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/1/1991';
update tourneys set event='1992 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/23/1992';
update results set event='1992 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/23/1992';
update tourneys set event='1993 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/21/1993';
update results set event='1993 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/21/1993';
update tourneys set event='1994 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/20/1994';
update results set event='1994 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/20/1994';
update tourneys set event='1995 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/19/1995';
update results set event='1995 Shop n Save Pro-Am' where event='Shop n Save Pro-Am' and date='2/19/1995';


select * from tourneys where event='Spalding Tournament of Champions';

update tourneys set event='1996 Spalding Tournament of Champions' where event='Spalding Tournament of Champions' and date='6/9/1996';
update results set event='1996 Spalding Tournament of Champions' where event='Spalding Tournament of Champions' and date='6/9/1996';
update tourneys set event='1998 Spalding Tournament of Champions' where event='Spalding Tournament of Champions' and date='6/7/1998';
update results set event='1998 Spalding Tournament of Champions' where event='Spalding Tournament of Champions' and date='6/7/1998';


select * from tourneys where event='Stockton Pro-Am';

update tourneys set event='1992 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/6/1992';
update results set event='1992 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/6/1992';
update tourneys set event='2000 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/3/2000';
update results set event='2000 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/3/2000';
update tourneys set event='2001 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/3/2001';
update results set event='2001 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/3/2001';
update tourneys set event='2002 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/8/2002';
update results set event='2002 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/8/2002';
update tourneys set event='2003 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/1/2003';
update results set event='2003 Stockton Pro-Am' where event='Stockton Pro-Am' and date='9/1/2003';


select * from tourneys where event='Strong Funds Pro-Am';

update tourneys set event='1995 Strong Funds Pro-Am' where event='Strong Funds Pro-Am' and date='11/5/1995';
update results set event='1995 Strong Funds Pro-Am' where event='Strong Funds Pro-Am' and date='11/5/1995';
update tourneys set event='1996 Strong Funds Pro-Am' where event='Strong Funds Pro-Am' and date='11/3/1996';
update results set event='1996 Strong Funds Pro-Am' where event='Strong Funds Pro-Am' and date='11/3/1996';


select * from tourneys where event='Summer Cooler';

update tourneys set event='2004 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler' and date='8/29/2004';
update results set event='2004 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler' and date='8/29/2004';
update tourneys set event='2005 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler' and date='8/29/2005';
update results set event='2005 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler' and date='8/29/2005';

select * from tourneys where event='Summer Cooler Pro-Am';

update tourneys set event='1993 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/8/1993';
update results set event='1993 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/8/1993';
update tourneys set event='2000 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/6/2000';
update results set event='2000 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/6/2000';
update tourneys set event='2001 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/12/2001';
update results set event='2001 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/12/2001';
update tourneys set event='2002 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/25/2002';
update results set event='2002 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/25/2002';
update tourneys set event='2003 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/24/2003';
update results set event='2003 Elmwood Summer Cooler Pro-Am' where event='Summer Cooler Pro-Am' and date='8/24/2003';



select * from tourneys where event='Tournament of Champions';

update tourneys set event='1991 Tournament of Champions' where event='Tournament of Champions' and date='6/8/1991';
update results set event='1991 Tournament of Champions' where event='Tournament of Champions' and date='6/8/1991';
update tourneys set event='1995 Tournament of Champions' where event='Tournament of Champions' and date='6/11/1995';
update results set event='1995 Tournament of Champions' where event='Tournament of Champions' and date='6/11/1995';
update tourneys set event='2001 Tournament of Champions' where event='Tournament of Champions' and date='6/3/2001';
update results set event='2001 Tournament of Champions' where event='Tournament of Champions' and date='6/3/2001';
update tourneys set event='2000 Tournament of Champions' where event='Tournament of Champions' and date='6/4/2000';
update results set event='2000 Tournament of Champions' where event='Tournament of Champions' and date='6/4/2000';



select * from tourneys where event='TransCoastal Grand Nationals';

update tourneys set event='1991 TransCoastal Grand Nationals' where event='TransCoastal Grand Nationals' and date='5/19/1991';
update results set event='1991 TransCoastal Grand Nationals' where event='TransCoastal Grand Nationals' and date='5/19/1991';
update tourneys set event='1993 TransCoastal Grand Nationals' where event='TransCoastal Grand Nationals' and date='5/16/1993';
update results set event='1993 TransCoastal Grand Nationals' where event='TransCoastal Grand Nationals' and date='5/16/1993';


select * from tourneys where event='VCI Challenge Cup Series #1';

update tourneys set event='1993 VCI Challenge Cup Series #1' where event='VCI Challenge Cup Series #1' and date='10/17/1993';
update results set event='1993 VCI Challenge Cup Series #1' where event='VCI Challenge Cup Series #1' and date='10/17/1993';
update tourneys set event='1995 VCI Challenge Cup Series #1' where event='VCI Challenge Cup Series #1' and date='10/22/1995';
update results set event='1995 VCI Challenge Cup Series #1' where event='VCI Challenge Cup Series #1' and date='10/22/1995';


select * from tourneys where event='VCI Challenge Cup Series #3';

update tourneys set event='1993 VCI Challenge Cup Series #3' where event='VCI Challenge Cup Series #3' and date='12/13/1993';
update results set event='1993 VCI Challenge Cup Series #3' where event='VCI Challenge Cup Series #3' and date='12/13/1993';
update tourneys set event='1996 VCI Challenge Cup Series #3' where event='VCI Challenge Cup Series #3' and date='2/4/1996';
update results set event='1996 VCI Challenge Cup Series #3' where event='VCI Challenge Cup Series #3' and date='2/4/1996';


select * from tourneys where event='Woodfield Halloween Classic';


update tourneys set event='1993 Woodfield Halloween Classic' where event='Woodfield Halloween Classic' and date='10/31/1993';
update results set event='1993 Woodfield Halloween Classic' where event='Woodfield Halloween Classic' and date='10/31/1993';
update tourneys set event='1994 Woodfield Halloween Classic' where event='Woodfield Halloween Classic' and date='10/30/1994';
update results set event='1994 Woodfield Halloween Classic' where event='Woodfield Halloween Classic' and date='10/30/1994';



commit;

-- confirming; any dups remaining??

select event,count(*) from tourneys group by event having count(*) > 1;
