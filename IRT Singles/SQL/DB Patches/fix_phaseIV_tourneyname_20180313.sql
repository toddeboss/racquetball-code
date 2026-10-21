-- quick fix for tourney name early 2017-18 season: the "&" corrupted the URLs

SET SQL_SAFE_UPDATES = 0;

update tourneys set event='2017 IRT Phase IV Scientific Health and Performance Pro-Am'
where event='2017 IRT Phase IV Scientific Health & Performance Pro-Am';

update results set event='2017 IRT Phase IV Scientific Health and Performance Pro-Am'
where event='2017 IRT Phase IV Scientific Health & Performance Pro-Am';

update seedings set event='2017 IRT Phase IV Scientific Health and Performance Pro-Am'
where event='2017 IRT Phase IV Scientific Health & Performance Pro-Am';

commit;