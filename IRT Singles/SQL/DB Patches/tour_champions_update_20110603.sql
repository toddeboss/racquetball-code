use cp30725_men;


/* 5/11/09: populating the tour_champions at end of season */
select * from tour_champions;

-- don't forget to update code to set "none declared yet" season



/* 9/20/10: populating the tour_champions at end of 2010 season */
select * from tour_champions;
insert into tour_champions values ('2009-10','Kane Waselenchuk');

-- don't forget to update code to set "none declared yet" season





/* 6/3/11: populating the tour_champions at end of 2010-11 season */
select * from tour_champions order by season desc;

insert into tour_champions values ('2010-11','Kane Waselenchuk');
commit;

/* 6/3/11: populating the tour_champions at end of 2010-11 season */
select * from tour_champions order by season desc;

insert into tour_champions values ('2011-12','Kane Waselenchuk');
commit;



insert into tour_champions values ('2012-13','Kane Waselenchuk');
commit;


select * from tour_champions order by season desc;

insert into tour_champions values ('2014-15','Kane Waselenchuk','Waselenchuk, Kane');
commit;

-- don't forget to update code to set "none declared yet" season


insert into tour_champions values ('2015-16','None Declared Yet','None Declared Yet');
commit;