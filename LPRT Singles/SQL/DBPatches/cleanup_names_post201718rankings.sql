 -- name cleanup 2017-18 post-rankings load



select * from results where winner like '%Carolina%';

select * from results where loser like '%Carolina%';

select * from seedings where player like '%Carolina%';

select * from rankings where player like '%Carolina%';


update results set winner='Barrios, Angelica' where winner='Barrios, Stefanny';

update results set loser='Barrios, Angelica' where loser='Barrios, Stefanny';

update seedings set player='Barrios, Angelica' where player='Barrios, Stefanny';

commit;


call sp_fixname('Sabja, Yazmine','Sabja, Jasmine');

call sp_fixname('Lee, Cassandra','Lee, Casandra');


call sp_fixname('Rivera (Groves), Erin','Rivera, Erin');

call sp_fixname('Rivera (Groves), Erin','Groves, Erin');

call sp_fixname ('Rivera (Luque), Carolina','Luque, Carolina');

call sp_fixname ('Rivera (Luque), Carolina','Rivera Luque, Carolina');

call sp_fixname ('Rivera (Luque), Carolina','Rivera, Carolina');