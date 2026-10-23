-- post posting 1980 data fixes
-- RO not Rocky, Olson not Olsen (fixed with spfixname), Genevay not dave but mike.

update results_doubles set loser_p2='Carson, Jim' where loser_p2='Carson, Rocky' and event='1980 7th Outdoor National Championships - Mens Three Wall';

-- whoops that was wrong; this was supposed to be RO
update results_doubles set loser_p2='Carson, R.O.' where loser_p2='Carson, Jim' and event='1980 7th Outdoor National Championships - Mens Three Wall'
and round=32;



select * from results where event='1980 7th Outdoor National Championships - Mens Three Wall';

update results set winner='Genevay, Mike' where winner='Genevay, Dave'
and event='1980 7th Outdoor National Championships - Mens Three Wall';

update results set loser='Genevay, Mike' where loser='Genevay, Dave'
and event='1980 7th Outdoor National Championships - Mens Three Wall';


commit;