/* 10/15/06: heard from Sean Moskwa, fixed his name */

update results set winner='Moskwa, Sean' where winner='Moskwa,S';
update results set loser='Moskwa, Sean' where loser='Moskwa,S';
commit;