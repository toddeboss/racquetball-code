-- had to fix event name for St.L event; embedded apostrophe causing sql issues elsewhere.

use cp30725_men;

select * from results where winner='Carson, Rocky' and round='2' order by tmp_date desc;

select winner from results where season='2014-15' and event='2014 Pete Pierce''s Party with the Pros' and round=2;

select * from results where tmp_date='2014-10-18';

update results set event='2014 Pete Pierces Party with the Pros' where tmp_date='2014-10-18';