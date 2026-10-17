-- older Canada tourney fixing

SET SQL_SAFE_UPDATES = 0;


select * from results order by tmp_date;

update results set tmp_date=STR_TO_DATE(date, '%m/%d/%Y') where tmp_date is null;


select * from results where event='2006 Canada Racquetball National Singles Championships - Mens Open';

-- cleaning up 2006, 2005
delete from results where event='2006 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2006 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2006 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2006 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='2005 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2005 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2005 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2005 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='2004 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2004 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2004 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2004 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='2003 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2003 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2003 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2003 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='2002 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2002 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2002 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2002 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='2001 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2001 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2001 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2001 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='2000 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='2000 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='2000 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='2000 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1999 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1999 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1999 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1999 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1998 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1998 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1998 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1998 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1997 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1997 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1997 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1997 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1996 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1996 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1996 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1996 Canada Racquetball National Singles Championships - Womens Open';



delete from results where event='1995 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1995 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1995 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1995 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='1994 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1994 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1994 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1994 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='1993 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1993 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1993 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1993 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='1992 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1992 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1992 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1992 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='1991 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1991 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1991 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1991 Canada Racquetball National Singles Championships - Womens Open';


delete from results where event='1990 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1990 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1990 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1990 Canada Racquetball National Singles Championships - Womens Open';

---
delete from results where event='1989 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1989 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1989 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1989 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1988 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1988 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1988 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1988 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1987 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1987 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1987 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1987 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1986 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1986 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1986 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1986 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1985 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1985 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1985 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1985 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1984 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1984 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1984 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1984 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1983 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1983 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1983 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1983 Canada Racquetball National Singles Championships - Womens Open';

delete from results where event='1981 Canada Racquetball National Singles Championships - Mens Open';
delete from tourneys where event='1981 Canada Racquetball National Singles Championships - Mens Open';
delete from results where event='1981 Canada Racquetball National Singles Championships - Womens Open';
delete from tourneys where event='1981 Canada Racquetball National Singles Championships - Womens Open';





