/* 11/17/16: adapted from IRT banner table.  10/5/13 banner table 
1012/17: adapted from WRT for irf*/

use cp30725_irf;

drop table banner;

create table banner
( banner_text varchar(250),
  last_update_date varchar(20));

 
delete from banner;

insert into banner values ('IRF Initial data load ongoing; we are working backwards from 2017 Intl events','10/12/17');
commit;

select * from banner;