-- fixing all the Pan American event names

SET SQL_SAFE_UPDATES = 0;


create table results_20180622 as select * from results;

create table tourneys_20180622 as select * from tourneys;

create table seedings_20180622 as select * from seedings;

update results set event='2018 Pan American Championships XXXI - Womens Open' where event='2018 Pan American Championships - Womens Open';
update results set event='2018 Pan American Championships XXXI - Mens Open' where event='2018 Pan American Championships - Mens Open';
update results set event='2017 Pan American Championships XXX - Mens Open' where event='2017 Pan American Racquetball Championships - Mens Open';
update results set event='2017 Pan American Championships XXX - Womens Open' where event='2017 Pan American Racquetball Championships - Womens Open';
update results set event='2016 Pan American Championships XXIX - Womens Open' where event='2016 Pan American Racquetball Championships - Womens Open';
update results set event='2016 Pan American Championships XXIX - Mens Open' where event='2016 Pan American Racquetball Championships - Mens Open';
update results set event='2015 Pan American Championships XXVIII - Mens Open' where event='2015 Pan American Racquetball Championships - Mens Open';
update results set event='2015 Pan American Championships XXVIII - Womens Open' where event='2015 Pan American Racquetball Championships - Womens Open';
update results set event='2014 Pan American Championships XXVII - Mens Open' where event='2014 Pan American Championships - Mens Open';
update results set event='2014 Pan American Championships XXVII - Womens Open' where event='2014 Pan American Championships - Womens Open';
update results set event='2013 Pan American Championships XXVI - Mens Open' where event='2013 Pan American Championships - Mens Open';
update results set event='2013 Pan American Championships XXVI - Womens Open' where event='2013 Pan American Championships - Womens Open';
update results set event='2012 Pan American Championships XXV - Womens Open' where event='2012 Pan American Championships - Womens Open';
update results set event='2012 Pan American Championships XXV - Mens Open' where event='2012 Pan American Championships - Mens Open';
update results set event='2011 Pan American Championships XXIV - Womens Open' where event='2011 Pan American Championships - Womens Open';
update results set event='2011 Pan American Championships XXIV - Mens Open' where event='2011 Pan American Championships - Mens Open';
update results set event='2010 Pan American Championships XXIII - Womens Open' where event='2010 Pan American Championships - Womens Open';
update results set event='2010 Pan American Championships XXIII - Mens Open' where event='2010 Pan American Championships - Mens Open';
update results set event='2009 Pan American Championships XXII - Mens Open' where event='2009 Pan American Championships - Mens Open';
update results set event='2009 Pan American Championships XXII - Womens Open' where event='2009 Pan American Championships - Womens Open';
update results set event='2008 Pan American Championships XXI - Mens Open' where event='2008 Pan American Championships - Mens Open';
update results set event='2008 Pan American Championships XXI - Womens Open' where event='2008 Pan American Championships - Womens Open';
update results set event='2007 Pan American Championships XX - Mens Open' where event='2007 Pan American Championships - Mens Open';
update results set event='2007 Pan American Championships XX - Womens Open' where event='2007 Pan American Championships - Womens Open';


update tourneys set event='2018 Pan American Championships XXXI - Womens Open' where event='2018 Pan American Championships - Womens Open';
update tourneys set event='2018 Pan American Championships XXXI - Mens Open' where event='2018 Pan American Championships - Mens Open';
update tourneys set event='2017 Pan American Championships XXX - Mens Open' where event='2017 Pan American Racquetball Championships - Mens Open';
update tourneys set event='2017 Pan American Championships XXX - Womens Open' where event='2017 Pan American Racquetball Championships - Womens Open';
update tourneys set event='2016 Pan American Championships XXIX - Womens Open' where event='2016 Pan American Racquetball Championships - Womens Open';
update tourneys set event='2016 Pan American Championships XXIX - Mens Open' where event='2016 Pan American Racquetball Championships - Mens Open';
update tourneys set event='2015 Pan American Championships XXVIII - Mens Open' where event='2015 Pan American Racquetball Championships - Mens Open';
update tourneys set event='2015 Pan American Championships XXVIII - Womens Open' where event='2015 Pan American Racquetball Championships - Womens Open';
update tourneys set event='2014 Pan American Championships XXVII - Mens Open' where event='2014 Pan American Championships - Mens Open';
update tourneys set event='2014 Pan American Championships XXVII - Womens Open' where event='2014 Pan American Championships - Womens Open';
update tourneys set event='2013 Pan American Championships XXVI - Mens Open' where event='2013 Pan American Championships - Mens Open';
update tourneys set event='2013 Pan American Championships XXVI - Womens Open' where event='2013 Pan American Championships - Womens Open';
update tourneys set event='2012 Pan American Championships XXV - Womens Open' where event='2012 Pan American Championships - Womens Open';
update tourneys set event='2012 Pan American Championships XXV - Mens Open' where event='2012 Pan American Championships - Mens Open';
update tourneys set event='2011 Pan American Championships XXIV - Womens Open' where event='2011 Pan American Championships - Womens Open';
update tourneys set event='2011 Pan American Championships XXIV - Mens Open' where event='2011 Pan American Championships - Mens Open';
update tourneys set event='2010 Pan American Championships XXIII - Womens Open' where event='2010 Pan American Championships - Womens Open';
update tourneys set event='2010 Pan American Championships XXIII - Mens Open' where event='2010 Pan American Championships - Mens Open';
update tourneys set event='2009 Pan American Championships XXII - Mens Open' where event='2009 Pan American Championships - Mens Open';
update tourneys set event='2009 Pan American Championships XXII - Womens Open' where event='2009 Pan American Championships - Womens Open';
update tourneys set event='2008 Pan American Championships XXI - Mens Open' where event='2008 Pan American Championships - Mens Open';
update tourneys set event='2008 Pan American Championships XXI - Womens Open' where event='2008 Pan American Championships - Womens Open';
update tourneys set event='2007 Pan American Championships XX - Mens Open' where event='2007 Pan American Championships - Mens Open';
update tourneys set event='2007 Pan American Championships XX - Womens Open' where event='2007 Pan American Championships - Womens Open';



update seedings set event='2018 Pan American Championships XXXI - Womens Open' where event='2018 Pan American Championships - Womens Open';
update seedings set event='2018 Pan American Championships XXXI - Mens Open' where event='2018 Pan American Championships - Mens Open';
update seedings set event='2017 Pan American Championships XXX - Mens Open' where event='2017 Pan American Racquetball Championships - Mens Open';
update seedings set event='2017 Pan American Championships XXX - Womens Open' where event='2017 Pan American Racquetball Championships - Womens Open';
update seedings set event='2016 Pan American Championships XXIX - Womens Open' where event='2016 Pan American Racquetball Championships - Womens Open';
update seedings set event='2016 Pan American Championships XXIX - Mens Open' where event='2016 Pan American Racquetball Championships - Mens Open';
update seedings set event='2015 Pan American Championships XXVIII - Mens Open' where event='2015 Pan American Racquetball Championships - Mens Open';
update seedings set event='2015 Pan American Championships XXVIII - Womens Open' where event='2015 Pan American Racquetball Championships - Womens Open';
update seedings set event='2014 Pan American Championships XXVII - Mens Open' where event='2014 Pan American Championships - Mens Open';
update seedings set event='2014 Pan American Championships XXVII - Womens Open' where event='2014 Pan American Championships - Womens Open';
update seedings set event='2013 Pan American Championships XXVI - Mens Open' where event='2013 Pan American Championships - Mens Open';
update seedings set event='2013 Pan American Championships XXVI - Womens Open' where event='2013 Pan American Championships - Womens Open';
update seedings set event='2012 Pan American Championships XXV - Womens Open' where event='2012 Pan American Championships - Womens Open';
update seedings set event='2012 Pan American Championships XXV - Mens Open' where event='2012 Pan American Championships - Mens Open';
update seedings set event='2011 Pan American Championships XXIV - Womens Open' where event='2011 Pan American Championships - Womens Open';
update seedings set event='2011 Pan American Championships XXIV - Mens Open' where event='2011 Pan American Championships - Mens Open';
update seedings set event='2010 Pan American Championships XXIII - Womens Open' where event='2010 Pan American Championships - Womens Open';
update seedings set event='2010 Pan American Championships XXIII - Mens Open' where event='2010 Pan American Championships - Mens Open';
update seedings set event='2009 Pan American Championships XXII - Mens Open' where event='2009 Pan American Championships - Mens Open';
update seedings set event='2009 Pan American Championships XXII - Womens Open' where event='2009 Pan American Championships - Womens Open';
update seedings set event='2008 Pan American Championships XXI - Mens Open' where event='2008 Pan American Championships - Mens Open';
update seedings set event='2008 Pan American Championships XXI - Womens Open' where event='2008 Pan American Championships - Womens Open';
update seedings set event='2007 Pan American Championships XX - Mens Open' where event='2007 Pan American Championships - Mens Open';
update seedings set event='2007 Pan American Championships XX - Womens Open' where event='2007 Pan American Championships - Womens Open';
