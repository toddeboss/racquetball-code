-- wor_court import to postgres

drop table wor_courts;

create table wor_courts
(Site varchar(255),
Address varchar(255),
City varchar(255),
Zip varchar(20),
County varchar(50),
State varchar(2),
Contact varchar(255),
Site_View varchar(20),
Goodforevent_flag varchar(1),
WOR_Event_flag varchar(1),
num_Courts integer,
Court_Type varchar(50),
Width varchar(10),
Length varchar(10),
Short_Line varchar(10),
Back_Line_Rm varchar(50),
Ceiling_flag varchar(10),
Lights_flag varchar(1),
Last_Updated varchar(10)
);


load data local infile 'E:/Dropbox/z rball/WOR/Court List/courtlist.csv' into table wor_courts
fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;

-- run this command line
-- psql -h localhost -U postgres -d postgres -p 5432

\COPY wor_courts FROM 'E:/Dropbox/z rball/WOR/Court List/courtlist.csv' DELIMITER ',' CSV HEADER;

------------

-- sql to do analysis

select * from wor_courts;

select site,count(*) from wor_courts group by site having count(*) > 1;


select * from wor_courts where state='MN';

select count(*) from wor_courts;

select state,count(*) from wor_courts group by state order by 2 desc;




