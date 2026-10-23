
SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180315 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- WOR links for 2018 events covered

update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/261395607734660' where event='2018 Mass Mutual Life Ins Beach Bash, presented by Splathead - Womens One Wall';
update tourneys set wrapup_url='https://www.facebook.com/prorballstats/posts/261395607734660' where event='2018 Mass Mutual Life Ins Beach Bash, presented by Splathead - Mens One Wall';


commit;