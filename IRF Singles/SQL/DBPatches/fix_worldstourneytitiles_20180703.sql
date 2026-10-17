-- fixing Worlds tourney names

SET SQL_SAFE_UPDATES = 0;

update results set event='2018 World Championships XIX - Mens Open' where event='2018 World Championships - Mens Open';
update results set event='2016 World Championships XVIII - Mens Open' where event='2016 World Championships - Mens Open';
update results set event='2014 World Championships XVII - Mens Open' where event='2014 World Championships - Mens Open';
update results set event='2012 World Championships XVI - Mens Open' where event='2012 World Championships - Mens Open';
update results set event='2010 World Championships XV - Mens Open' where event='2010 World Championships - Mens Open';
update results set event='2008 World Championships XIV - Mens Open' where event='2008 World Championships - Mens Open';
update results set event='2006 World Championships XIII - Mens Open' where event='2006 World Championships - Mens Open';
update results set event='2004 World Championships XII - Mens Open' where event='2004 World Championships - Mens Open';

update results set event='2018 World Championships XIX - Womens Open' where event='2018 World Championships - Womens Open';
update results set event='2016 World Championships XVIII - Womens Open' where event='2016 World Championships - Womens Open';
update results set event='2014 World Championships XVII - Womens Open' where event='2014 World Championships - Womens Open';
update results set event='2012 World Championships XVI - Womens Open' where event='2012 World Championships - Womens Open';
update results set event='2010 World Championships XV - Womens Open' where event='2010 World Championships - Womens Open';
update results set event='2008 World Championships XIV - Womens Open' where event='2008 World Championships - Womens Open';
update results set event='2006 World Championships XIII - Womens Open' where event='2006 World Championships - Womens Open';
update results set event='2004 World Championships XII - Womens Open' where event='2004 World Championships - Womens Open';

update tourneys set event='2018 World Championships XIX - Mens Open' where event='2018 World Championships - Mens Open';
update tourneys set event='2016 World Championships XVIII - Mens Open' where event='2016 World Championships - Mens Open';
update tourneys set event='2014 World Championships XVII - Mens Open' where event='2014 World Championships - Mens Open';
update tourneys set event='2012 World Championships XVI - Mens Open' where event='2012 World Championships - Mens Open';
update tourneys set event='2010 World Championships XV - Mens Open' where event='2010 World Championships - Mens Open';
update tourneys set event='2008 World Championships XIV - Mens Open' where event='2008 World Championships - Mens Open';
update tourneys set event='2006 World Championships XIII - Mens Open' where event='2006 World Championships - Mens Open';
update tourneys set event='2004 World Championships XII - Mens Open' where event='2004 World Championships - Mens Open';

update tourneys set event='2018 World Championships XIX - Womens Open' where event='2018 World Championships - Womens Open';
update tourneys set event='2016 World Championships XVIII - Womens Open' where event='2016 World Championships - Womens Open';
update tourneys set event='2014 World Championships XVII - Womens Open' where event='2014 World Championships - Womens Open';
update tourneys set event='2012 World Championships XVI - Womens Open' where event='2012 World Championships - Womens Open';
update tourneys set event='2010 World Championships XV - Womens Open' where event='2010 World Championships - Womens Open';
update tourneys set event='2008 World Championships XIV - Womens Open' where event='2008 World Championships - Womens Open';
update tourneys set event='2006 World Championships XIII - Womens Open' where event='2006 World Championships - Womens Open';
update tourneys set event='2004 World Championships XII - Womens Open' where event='2004 World Championships - Womens Open';

update seedings set event='2018 World Championships XIX - Mens Open' where event='2018 World Championships - Mens Open';
update seedings set event='2016 World Championships XVIII - Mens Open' where event='2016 World Championships - Mens Open';
update seedings set event='2014 World Championships XVII - Mens Open' where event='2014 World Championships - Mens Open';
update seedings set event='2012 World Championships XVI - Mens Open' where event='2012 World Championships - Mens Open';
update seedings set event='2010 World Championships XV - Mens Open' where event='2010 World Championships - Mens Open';
update seedings set event='2008 World Championships XIV - Mens Open' where event='2008 World Championships - Mens Open';
update seedings set event='2006 World Championships XIII - Mens Open' where event='2006 World Championships - Mens Open';
update seedings set event='2004 World Championships XII - Mens Open' where event='2004 World Championships - Mens Open';

update seedings set event='2018 World Championships XIX - Womens Open' where event='2018 World Championships - Womens Open';
update seedings set event='2016 World Championships XVIII - Womens Open' where event='2016 World Championships - Womens Open';
update seedings set event='2014 World Championships XVII - Womens Open' where event='2014 World Championships - Womens Open';
update seedings set event='2012 World Championships XVI - Womens Open' where event='2012 World Championships - Womens Open';
update seedings set event='2010 World Championships XV - Womens Open' where event='2010 World Championships - Womens Open';
update seedings set event='2008 World Championships XIV - Womens Open' where event='2008 World Championships - Womens Open';
update seedings set event='2006 World Championships XIII - Womens Open' where event='2006 World Championships - Womens Open';
update seedings set event='2004 World Championships XII - Womens Open' where event='2004 World Championships - Womens Open';

commit;