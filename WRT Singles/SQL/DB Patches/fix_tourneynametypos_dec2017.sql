-- fixing typos in WRT tourney names

select count(*) from tourneys;

select * from results where event like '%Worrior%';

SET SQL_SAFE_UPDATES = 0;

update results set event='2017 WRT Grace Warrior Ministries Georgia Open' where event='2017 WRT Grace Worrior Ministries Georgia Open';

update seedings set event='2017 WRT Grace Warrior Ministries Georgia Open' where event='2017 WRT Grace Worrior Ministries Georgia Open';

update tourneys set event='2017 WRT Grace Warrior Ministries Georgia Open' where event='2017 WRT Grace Worrior Ministries Georgia Open';


select * from results where event like '%Longhorm%';

update results set event='2016 Longhorn Open' where event='2016 Longhorm Open';

update seedings set event='2016 Longhorn Open' where event='2016 Longhorm Open';

update tourneys set event='2016 Longhorn Open' where event='2016 Longhorm Open';
