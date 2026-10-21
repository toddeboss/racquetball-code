/* 4/20/11: finally putting in my own results to the database */

use wwwbossconsultingcom;

select * from results where event='Choice Hotels 7th US Open';

insert into results values ('Casillas, Arturo','Boss, Todd',128,'','IRT','Memphis, TN',
'Hilton 6th US Open','11/20/2001','Todd Boss recollection','2001-2','','2001-11-20');

insert into results values ('Gagnon, Vincent','Boss, Todd',64,'','IRT','McLean, VA',
'1st Team ED Pro-Am','10/13/2002','Todd Boss recollection','2002-3','','2002-10-13');
insert into results values ('Carson, Rocky','Gagnon, Vincent',32,'','IRT','McLean, VA',
'1st Team ED Pro-Am','10/13/2002','Todd Boss recollection','2002-3','','2002-10-13');

insert into results values ('Ganim, Doug','Boss, Todd',128,'2,3,2','IRT','Memphis, TN',
'Choice Hotels 7th US Open','11/24/2002','Todd Boss recollection','2002-3','','2002-11-24');


commit;