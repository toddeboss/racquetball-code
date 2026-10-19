select * from results where tmp_date='2017-06-10';

update results set event='2017 Torneo Internacional Canels WRT' where tmp_date='2017-06-10';

select * from seedings where event like '%Canel%';

update seedings set event='2017 Torneo Internacional Canels WRT' where event like '%Canel%';

select * from tourneys where event like '%Canel%';

update tourneys set event='2017 Torneo Internacional Canels WRT' where event like '%Canel%';

commit;