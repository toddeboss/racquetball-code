select * from results order by tmp_date desc;

load data local infile 'c:/temp/lprt_major_catchup.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

select * from results_staging

select distinct(date) from results_staging;

update results_staging set tmp_date='2010-8-29' where date='8/29/2010';
update results_staging set tmp_date='2010-9-19' where date='9/19/2010';
update results_staging set tmp_date='2010-10-25' where date='10/25/2010';
update results_staging set tmp_date='2010-11-21' where date='11/21/2010';
update results_staging set tmp_date='2010-12-10' where date='12/10/2010';
update results_staging set tmp_date='2011-1-9' where date='1/9/2011';
update results_staging set tmp_date='2011-2-27' where date='2/27/2011';
update results_staging set tmp_date='2011-3-20' where date='3/20/2011';
update results_staging set tmp_date='2011-5-1' where date='5/1/2011';
update results_staging set tmp_date='2011-5-15' where date='5/15/2011';
update results_staging set tmp_date='2011-8-28' where date='8/28/2011';
update results_staging set tmp_date='2011-10-9' where date='10/9/2011';
update results_staging set tmp_date='2011-11-20' where date='11/20/2011';
update results_staging set tmp_date='2011-12-11' where date='12/11/2011';
update results_staging set tmp_date='2012-1-9' where date='1/9/2012';
update results_staging set tmp_date='2012-3-11' where date='3/11/2012';
update results_staging set tmp_date='2012-4-22' where date='4/22/2012';
update results_staging set tmp_date='2012-5-6' where date='5/6/2012';
update results_staging set tmp_date='2012-8-26' where date='8/26/2012';
update results_staging set tmp_date='2012-10-7' where date='10/7/2012';
update results_staging set tmp_date='2012-11-4' where date='11/4/2012';
update results_staging set tmp_date='2012-11-18' where date='11/18/2012';
update results_staging set tmp_date='2012-12-9' where date='12/9/2012';
update results_staging set tmp_date='2013-1-27' where date='1/27/2013';
update results_staging set tmp_date='2013-2-24' where date='2/24/2013';
update results_staging set tmp_date='2013-4-14' where date='4/14/2013';
update results_staging set tmp_date='2013-4-28' where date='4/28/2013';
update results_staging set tmp_date='2013-5-5' where date='5/5/2013';
update results_staging set tmp_date='2013-5-19' where date='5/19/2013';
update results_staging set tmp_date='2013-9-1' where date='9/1/2013';
update results_staging set tmp_date='2013-9-22' where date='9/22/2013';
update results_staging set tmp_date='2013-10-7' where date='10/7/2013';
update results_staging set tmp_date='2013-12-8' where date='12/8/2013';
update results_staging set tmp_date='2013-12-15' where date='12/15/2013';
update results_staging set tmp_date='2014-1-26' where date='1/26/2014';
update results_staging set tmp_date='2014-2-23' where date='2/23/2014';
update results_staging set tmp_date='2014-3-9' where date='3/9/2014';
update results_staging set tmp_date='2014-3-23' where date='3/23/2014';
update results_staging set tmp_date='2014-3-30' where date='3/30/2014';
update results_staging set tmp_date='2014-4-27' where date='4/27/2014';
update results_staging set tmp_date='2014-5-18' where date='5/18/2014';
update results_staging set tmp_date='2014-8-17' where date='8/17/2014';
update results_staging set tmp_date='2014-9-21' where date='9/21/2014';
update results_staging set tmp_date='2014-10-12' where date='10/12/2014';
update results_staging set tmp_date='2014-10-19' where date='10/19/2014';
update results_staging set tmp_date='2014-12-7' where date='12/7/2014';
update results_staging set tmp_date='2014-12-14' where date='12/14/2014';
update results_staging set tmp_date='2015-1-25' where date='1/25/2015';
update results_staging set tmp_date='2015-2-22' where date='2/22/2015';
update results_staging set tmp_date='2015-3-8' where date='3/8/2015';
update results_staging set tmp_date='2015-3-22' where date='3/22/2015';
update results_staging set tmp_date='2015-4-19' where date='4/19/2015';
update results_staging set tmp_date='2015-4-26' where date='4/26/2015';
update results_staging set tmp_date='2015-5-17' where date='5/17/2015';
update results_staging set tmp_date='2015-8-30' where date='8/30/2015';
update results_staging set tmp_date='2015-10-11' where date='10/11/2015';
update results_staging set tmp_date='2015-11-1' where date='11/1/2015';
update results_staging set tmp_date='2015-11-15' where date='11/15/2015';
update results_staging set tmp_date='2015-12-13' where date='12/13/2015';
update results_staging set tmp_date='2016-1-31' where date='1/31/2016';
update results_staging set tmp_date='2015-2-21' where date='2/21/2015';
update results_staging set tmp_date='2016-3-6' where date='3/6/2016';
update results_staging set tmp_date='2016-4-24' where date='4/24/2016';
update results_staging set tmp_date='2016-5-15' where date='5/15/2016';
update results_staging set tmp_date='2016-6-11' where date='6/11/2016';
update results_staging set tmp_date='2016-8-14' where date='8/14/2016';
update results_staging set tmp_date='2016-9-4' where date='9/4/2016';
update results_staging set tmp_date='2016-9-11' where date='9/11/2016';

select * from results_staging where tmp_date is null;


select * from tourneys;