--- 10/10/17 simple table to hold top ten matrix data

drop table top_ten_matrix_rpt;

create table top_ten_matrix_rpt (
player varchar(50),
alltoptens integer,
allnumberones integer,
allnumbertwos integer,
allnumberthrees integer,
allnumberfours integer,
allnumberfives integer,
allnumbersixes integer,
allnumbersevens integer,
allnumbereights integer,
allnumbernines integer,
allnumbertens integer,
outsidetopten integer);