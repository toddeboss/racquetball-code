/* 11/20/07: patched results to expand event name */

alter table results_staging modify event varchar(255);

alter table results modify event varchar(255);