/* 12/11/07: full reload of data from working spreadsheet */

delete from results;
delete from results_staging;
commit;

load data local infile 'D:/rball/IRT/results_online.csv' into table results_staging
fields terminated by ',' enclosed by '"' lines terminated by '\n';

insert into results select * from results_staging;

select count(*) from results;

-- last step; fix the tmp_date .. run fix_tmp_date.pl

