use cp30725_prs;

drop table rpt_tracking;

create table rpt_tracking (
rpt_date datetime,
tour varchar(10),
query varchar(100),
sum_event varchar(255),
division varchar(100),
category varchar(100),
player varchar(50),
event varchar(255),
season varchar(10),
subroutine varchar(100));

-- 7/18/21 got a warning that I was overloading tour

alter table rpt_tracking modify tour varchar(25);