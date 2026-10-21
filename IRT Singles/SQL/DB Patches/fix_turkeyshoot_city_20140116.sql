/* 1/16/14: had the wrong city for the 23rd Annual Turkey shoot; thanks to Jen Johnson at
IRT-tour.com for emailing me the fix */

select * from results where event like '%Turkey%';

update results set city='Garden City, KS' where event='23rd Annual Turkey Shoot';