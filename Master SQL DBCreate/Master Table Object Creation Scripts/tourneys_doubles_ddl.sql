/* tourneys_doubles table: unknown original creation */

drop table tourneys_doubles;

create table tourneys_doubles
(tourney_pk integer,
 city varchar(30),
 event varchar(255),
 date varchar(20),
 tmp_date date,
 season varchar(10),
 major_flag varchar(1));



-- 8/1/24: adding fields for pickleball

alter table tourneys_doubles add event_orig varchar(255);
alter table tourneys_doubles add tier varchar(10);
alter table tourneys_doubles add scoring_system_id integer;


-- 9/6/24: expanding tier to hold MLP data
alter table tourneys_doubles modify column tier varchar(30);