/* 11/17/16: adapted from IRT banner table.  10/5/13 banner table */

use cp30725_wrt;

drop table banner;

create table banner
( banner_text varchar(250),
  last_update_date varchar(20));

 
insert into banner values ('WRT initial data load ongoing, we are mid- 2016-17 season!','11/17/16');
commit;

select * from banner;