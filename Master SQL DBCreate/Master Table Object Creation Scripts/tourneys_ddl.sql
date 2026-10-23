/* tourneys table, dating back to 2004 initially */

create table tourneys
(tourney_pk integer,
 city varchar(30),
 event varchar(255),
 date varchar(20),
 tmp_date date,
 season varchar(10),
 major_flag varchar(1));
 
-- 3/15/18: adding pre and post game wrap up URL fields

alter table tourneys add preview_url varchar(200);
alter table tourneys add wrapup_url varchar(200);

-- 8/1/24: adding fields for pickleball

alter table tourneys add event_orig varchar(255);
alter table tourneys add tier varchar(10);



-- 8/12/24: adding scoring format and lookup table to start being able to describe the scoring format.

select * from tourneys;

alter table tourneys drop scoring_desc;
alter table tourneys drop scoring_system_desc;

alter table tourneys add scoring_system_id integer;




