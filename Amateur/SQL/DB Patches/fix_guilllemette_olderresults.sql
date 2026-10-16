-- mistakenly entered Francis for Veronique

select * from results_doubles where tour='CAN Womens Open'
and (winner_p2 like 'Guillemette, Francis' or loser_p2 like 'Guillemette, Francis') order by tmp_date desc, round desc;

create table results_20190824 as select * from results;

update results set winner='Guillemette, Veronique' where winner='Guillemette, Francis' and season in ('2007','2008');

update results set loser='Guillemette, Veronique' where loser='Guillemette, Francis' and season in ('2007','2008');

