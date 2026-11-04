select * from rankings order by season, rank;

create table rankings_20161201 as select * from rankings;

delete from rankings where season='1998-99' and player='Paraiso, Jackie';

insert into rankings (season, rank, player, points, record) values ('1998-99','1','Paraiso, Jackie','1245','27-1');

select * from rankings where season='2000-01' order by rank;

delete from rankings where season='2000-01';

insert into rankings (season, rank, player, points) values ('2000-01','1','Gudinas, Cheryl',662.5);
insert into rankings (season, rank, player, points) values ('2000-01','2','Paraiso, Jackie',512.5);
insert into rankings (season, rank, player, points) values ('2000-01','3','Rajsich, Rhonda',222.5);
insert into rankings (season, rank, player, points) values ('2000-01','4','Fenton, Laura',196.25);
insert into rankings (season, rank, player, points) values ('2000-01','5','Hallander, Kersten',146.25);
insert into rankings (season, rank, player, points) values ('2000-01','6','Acosta, Susana',98.75);
insert into rankings (season, rank, player, points) values ('2000-01','7','Fowler, Doreen',74.75);
insert into rankings (season, rank, player, points) values ('2000-01','8','Stoffregen, Kerri',71.75);
insert into rankings (season, rank, player, points) values ('2000-01','9','Powell, Lori-Jane',65.75);
insert into rankings (season, rank, player, points) values ('2000-01','10','Machiran, Kim',62.25);
insert into rankings (season, rank, player, points) values ('2000-01','11','Lucas, Michelle',61.75);
insert into rankings (season, rank, player, points) values ('2000-01','12','Myers, Janet',58.75);
insert into rankings (season, rank, player, points) values ('2000-01','13','Shattuck, Johanna',40.75);
insert into rankings (season, rank, player, points) values ('2000-01','14','Walsh, Kristen',33.75);
insert into rankings (season, rank, player, points) values ('2000-01','15','Mock, Denise',33.5);
insert into rankings (season, rank, player, points) values ('2000-01','16','Russell, Kim',30);
insert into rankings (season, rank, player, points) values ('2000-01','17','Evon, Chris',26.25);
insert into rankings (season, rank, player, points) values ('2000-01','18','GrandMaitre, Josee',20);
insert into rankings (season, rank, player, points) values ('2000-01','19','Gellman, Rachel',18.75);
insert into rankings (season, rank, player, points) values ('2000-01','19','Moreland, Dina',18.75);
insert into rankings (season, rank, player, points) values ('2000-01','21','Jennifer Saunders',17.5);
insert into rankings (season, rank, player, points) values ('2000-01','22','Burth, Angela',16.75);
insert into rankings (season, rank, player, points) values ('2000-01','23','Moore, Linda',15.5);
insert into rankings (season, rank, player, points) values ('2000-01','24','Fisher, Adrienne',13.75);
insert into rankings (season, rank, player, points) values ('2000-01','25','Sanders, Lourdes',12.75);
insert into rankings (season, rank, player, points) values ('2000-01','26','McDonough, Kari',10.1);
insert into rankings (season, rank, player, points) values ('2000-01','27','Carbajal, Jessie',10);
insert into rankings (season, rank, player, points) values ('2000-01','27','Grisar, Angela',10);
insert into rankings (season, rank, player, points) values ('2000-01','29','Salazar-Leveque, Cinyta',8);
insert into rankings (season, rank, player, points) values ('2000-01','30','Morris, Phyllis',6.75);
insert into rankings (season, rank, player, points) values ('2000-01','30','Csuk, Krystal',6.75);
insert into rankings (season, rank, player, points) values ('2000-01','30','Munger, Stephanie',6.75);
insert into rankings (season, rank, player, points) values ('2000-01','30','Feaster-Stewart, Shannon',6.75);
insert into rankings (season, rank, player, points) values ('2000-01','34','Vonondarza, Ramona',6.5);
insert into rankings (season, rank, player, points) values ('2000-01','35','Odegard, Karina',6.1);
insert into rankings (season, rank, player, points) values ('2000-01','36','Barriga, Loreto',6);
insert into rankings (season, rank, player, points) values ('2000-01','36','Maldonado, Anita',6);
insert into rankings (season, rank, player, points) values ('2000-01','38','Dering, Jennifer',5.75);
insert into rankings (season, rank, player, points) values ('2000-01','39','Stephens, Peggy',5.1);
insert into rankings (season, rank, player, points) values ('2000-01','40','Hjelm, Lisa',5);
insert into rankings (season, rank, player, points) values ('2000-01','40','Richards, Marcia',5);
insert into rankings (season, rank, player, points) values ('2000-01','42','Richer, Mickey',4.75);
insert into rankings (season, rank, player, points) values ('2000-01','43','Turgeon, Chantal',2.75);
insert into rankings (season, rank, player, points) values ('2000-01','43','Galloway, Lorraine',2.75);
insert into rankings (season, rank, player, points) values ('2000-01','45','Rivera, Joanna',2.5);
insert into rankings (season, rank, player, points) values ('2000-01','46','Gillhouse, Annette',2);
insert into rankings (season, rank, player, points) values ('2000-01','46','Anderson, Dana',2);
insert into rankings (season, rank, player, points) values ('2000-01','48','Corpi, Claudia',1.5);
insert into rankings (season, rank, player, points) values ('2000-01','49','Evans, Cyd',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Blaakman, Alicia',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Goddard, Kelly',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Torres, Lupita',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Crawford, Brooke',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Aquiano, Tonya',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Trachsel. Jamie',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Krieger, Carol',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Trachsel, Jill',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Perrault, Vallana',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Prentice, Brandi',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Perrin, Robyn',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Vincent, Julie',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Bunker, Diane',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Moore, Diane',1);
insert into rankings (season, rank, player, points) values ('2000-01','49','Beltranena, Alissa',1);
insert into rankings (season, rank, player, points) values ('2000-01','65','Enriquez, Nancy',0.5);
insert into rankings (season, rank, player, points) values ('2000-01','65','Lepow, Lori',0.5);
insert into rankings (season, rank, player, points) values ('2000-01','65','Wapola, Kimberly',0.5);
insert into rankings (season, rank, player, points) values ('2000-01','65','Neubauer, Julie',0.5);


commit;