-- changing datatype for round to handle L32, L16 loer bracket matches.

-- 9/21/20: for PPS we have to add loser brackets, which means the round cannot be an integer

alter table results modify round varchar(5);


-- 9/21/20: for PPS we have to add loser brackets, which means the round cannot be an integer

alter table results_staging modify round varchar(5);

alter table results_doubles modify round varchar(5);

alter table results_doubles_staging modify round varchar(5);



truncate table results;

truncate table results_doubles;