/* 10/7/08: fixing minor name issue found doing name research */

update results set winner='Rodriguez, Manuel' where winner='Rodriquez, ?';

update results set winner='Sutherland, Bill' where winner='Sutherland, ?';
update results set loser='Sutherland, Bill' where loser='Sutherland, ?';