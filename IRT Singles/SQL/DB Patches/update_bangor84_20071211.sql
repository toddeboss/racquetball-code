/* 12/11/07: update of a record from emailer


> =20
>
> Mark LaBelle | Senior Account Executive
>
> mark.labelle@fullscope.com | Direct: 734-667-1204 | Mobile: 734-612-1751


*/

select * from results where event='Bangor 84';
update results set loser='LaBelle, Mark', score='3,4,1' where winner='Swain, Cliff' and round=32 and event='Bangor 84';
