

/* 3/10/19: row-count tracking sql */



select count(*) from results;

select count(*) from tourneys;

select * from banner;

select count(*) from results_doubles;

select count(*) from tourneys_doubles;

select max(tmp_date) from tourneys_doubles;


-- just irfsumm

select * from irf_main order by year desc;

select count(*) from irf_main;

select distinct tournament_name,year from irf_main;





