-- 8/12/19 code expects Pan American spelled out; quick fix post data insertion

-- 8/16/19: forgot to fix doubles too.


use cp30725_irf;

SET SQL_SAFE_UPDATES = 0;

update team_results set event='2019 Pan American Games XVIII - Team Men' where event='2019 Pan Am Games XVIII - Team Men';

update team_results set event='2019 Pan American Games XVIII - Team Women' where event='2019 Pan Am Games XVIII - Team Women';

select * from results where event like '2019 Pan Am%';

update results set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update results set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';

update seedings set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update seedings set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';

update tourneys set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update tourneys set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';


-- also fixing doubles

update results_doubles set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update results_doubles set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';

update seedings_doubles set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update seedings_doubles set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';

update tourneys_doubles set event='2019 Pan American Games XVIII - Mens Open' where event='2019 Pan Am Games XVIII - Mens Open';
update tourneys_doubles set event='2019 Pan American Games XVIII - Womens Open' where event='2019 Pan Am Games XVIII - Womens Open';

