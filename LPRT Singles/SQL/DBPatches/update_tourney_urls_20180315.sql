SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180315 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- LPRT links for 2017-18 season

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/254353421772212' where event='2018 LPRT Peachtree Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/256084944932393' where event='2018 LPRT Peachtree Open';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/240897889784432' where event='2018 LPRT Sweet Caroline Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/241915149682706' where event='2018 LPRT Sweet Caroline Open';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/224385228102365' where event='26th Annual LPRT Christmas Classic Pro-AM';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/225802994627255' where event='26th Annual LPRT Christmas Classic Pro-AM';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/10/2017-lprt-boston-open-preview.html' where event='2017 Boston Open LPRT Stop';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/10/longoria-wins-twice-at-2017-lprt-boston.html' where event='2017 Boston Open LPRT Stop';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/10/2017-unitedhealthcare-us-open-lprt-draws.html' where event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/10/longoria-defeats-lambert-for-8th-title.html' where event='2017 22nd UnitedHealthcare US OPEN Racquetball Championships';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/08/2017-lprt-torneo-milenio-preview.html' where event='Torneo Milenio LPRT 2017 Raquetbol';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/08/longoria-wins-singles-herrera-mendez.html' where event='Torneo Milenio LPRT 2017 Raquetbol';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/08/2017-lprt-paola-longoria-experience.html' where event='2017 LPRT Paola Longoria Experience';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/08/longoria-defeats-parrilla-to-win-2017.html' where event='2017 LPRT Paola Longoria Experience';

update tourneys set preview_url='' where event='';
update tourneys set wrapup_url='' where event='';

commit;