SET SQL_SAFE_UPDATES = 0;

select * from tourneys order by tmp_date desc;

create table tourneys_20180401 as select * from tourneys;

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);



commit;