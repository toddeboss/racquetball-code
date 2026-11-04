-- player_profile_submit creation
use cp30725_prs;

drop table contact_form_info;

create table contact_form_info
(id integer not null auto_increment,
name varchar(100),
email varchar(100),
phone varchar(25),
comments varchar(255),
created_date timestamp default now(),
primary key (id)
);

select * from contact_form_info;

select sysdate();


select * from player_profile;

drop table player_profile_submit;

create table player_profile_submit
( id integer not null auto_increment,
 player varchar(50),
 picture_flag varchar(10),
 twitter varchar(100),
 facebook varchar(100),
 instagram varchar(100), 
 rydf_flag varchar(10),
 gender varchar(1),
 tourney_winner_flag varchar(10),
 active_flag varchar(10),
 country varchar(100),
 hometown varchar(100),
 current_residence varchar(100),
 height varchar(10),
 weight varchar(4),
 college varchar(50),
 sponsor varchar(50),
 dob varchar(10),
 l_r_flag varchar(1),
 current_age integer,
 notes varchar(255),
 tmp_dob date,
 email varchar(100),
 phone varchar(100),
 created_date timestamp default now(),
primary key (id));
 

 
 select * from player_profile_submit;