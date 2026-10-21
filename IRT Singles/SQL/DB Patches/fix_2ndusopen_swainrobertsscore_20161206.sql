-- Fixing 2nd US OPen score from watching TV broadcast.

select * from results where event='Promus Hotel 2nd US Open';

-- semis: swain d roberst (8),5,9,5


update results set score='(8),5,9,5' where event='Promus Hotel 2nd US Open' and round=4 and winner='Swain, Cliff';

commit;