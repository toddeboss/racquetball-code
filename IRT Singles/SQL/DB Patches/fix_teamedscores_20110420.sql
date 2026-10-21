/* 4/20/11: saw some issues in the scores for Team Ed event */

update results set score = '(9),3,(7),5, 3' where score='(9) 3 (7) 5, 3';

update results set score = '6,(7),6, 1' where score = '6 (7) 6, 1';

update results set score='(10),(7),9, 2, 5' where score = '(10) (7) 9, 2, 5';

commit;