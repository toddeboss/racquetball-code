SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180315 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- WRT links for 2018 and last half of 2017 season

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/235073190366902' where event='2018 Longhorn Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/236879243519630' where event='2018 Longhorn Open';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/222003201673901' where event='2017 WRT Alamo City Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/223003378240550' where event='2017 WRT Alamo City Open';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/10/2017-wrt-rocky-mountain-open-preview.html' where event='2017 WRT Rocky Mountain Open';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/10/horn-defeats-bredenbeck-to-win-2017-wrt.html' where event='2017 WRT Rocky Mountain Open';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/10/2017-wrt-casino-racquetball-open-preview.html' where event='WRT Casino Racquetball Open 2017';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/10/parrilla-defeats-beltran-to-win-2017.html' where event='WRT Casino Racquetball Open 2017';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/09/preview-2017-wrt-grace-warrior.html' where event='2017 Grace Warrior Ministries WRT Atlanta Open';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/09/horn-wins-singles-rios-ugalde-doubles.html' where event='2017 Grace Warrior Ministries WRT Atlanta Open';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/08/2017-wrt-la-loma-open-early-round.html' where event='WRT La Loma Open 2017';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/08/mar-wins-wrt-la-loma-open-defeating.html' where event='WRT La Loma Open 2017';

update tourneys set preview_url='http://theracquetballblog.blogspot.com/2017/08/2017-wrt-life-time-denver-open-round-of.html' where event='WRT Life Time Denver Open 2017';
update tourneys set wrapup_url='http://theracquetballblog.blogspot.com/2017/08/bredenbeck-wins-2017-wrt-life-time.html' where event='WRT Life Time Denver Open 2017';

commit;