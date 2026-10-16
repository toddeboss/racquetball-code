select * from tourneys;

SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180518 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- Amateur links on-hand
update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/249638358910385' where event='2018 Campeonato Nacional Selectivo FMR - Mens Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/251295432078011' where event='2018 Campeonato Nacional Selectivo FMR - Mens Open';

update tourneys set preview_url='https://www.facebook.com/prorballstats/posts/249952205545667' where event='2018 Campeonato Nacional Selectivo FMR - Womens Open';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/251384185402469' where event='2018 Campeonato Nacional Selectivo FMR - Womens Open';




commit;