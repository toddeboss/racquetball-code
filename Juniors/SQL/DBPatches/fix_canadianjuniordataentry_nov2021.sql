-- Canadian manual data entry special character fixing 11/8/21


select * from results where winner like 'Haynes%';

update results set winner='Murray, Samuel' where winner='Murray, ÿSamuel';

update results set winner='Harb, Sami' where winner='Harb, ÿSami';

update results set winner='Barclay, Sean' where winner='Barclay, ÿSean';

update results set winner='Slamko, Jamie' where winner='Slamko, ÿJamie';

update results set winner='Viens, Francois' where winner='Viens, Fran‡ois';

update results set winner='Collins, Tim' where winner='Collins, ÿTim';

update results set winner='Haynes, Denise' where winner='Haynes, ÿDenise';

update results set winner='Swartz, Brian' where winner='Swartz, ÿBrian';

update results set winner='Morissette, Michele' where winner='Morissette, ÿMichŠle';

update results set winner='Lambert, Frederique' where winner='Lambert, ÿFrederique';


update results set winner='Guillemette, Veronique' where winner='Guillemette, V‚ronique';

update results set winner='McFetridge, Carol' where winner='McFetridge, ÿCarol';
