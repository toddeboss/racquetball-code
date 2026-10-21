
-- fixing screwup where I updatated every Swain semi win score to the same score 7,(5),2,7

SET SQL_SAFE_UPDATES = 0;

select * from results where winner='Swain, Cliff' and round=4 and score='7,(5),2,7' order by tmp_date;

select * from results where winner='Swain, Cliff' and round=4 order by tmp_date;

select * from results where score='7,(5),2,7';



update results set score='7,(5),(1),8,10' where winner='Swain, Cliff' and round=4 and event='Tulsa Open 85' and date='2/10/1985';
update results set score='3,(7),2,(6),3' where winner='Swain, Cliff' and round=4 and event='Ektelon Nationals' and date='5/1/1985';
update results set score='6,7,(0),(10),3' where winner='Swain, Cliff' and round=4 and event='Tulsa Open 86' and date='2/1/1986';
update results set score='4,(8),10,5' where winner='Swain, Cliff' and round=4 and event='4th Stockton Pro-Am' and date='8/1/1986';
update results set score='(8),9,9,(8),9' where winner='Swain, Cliff' and round=4 and event='Vancouver 86' and date='10/1/1986';
update results set score='(6),2,0,(4),8' where winner='Swain, Cliff' and round=4 and event='Dallas 86' and date='11/1/1986';
update results set score='5,(8),6,5' where winner='Swain, Cliff' and round=4 and event='10th  Lewerenz Sports Clinic Open' and date='9/1/1987';
update results set score='(10),6,4,2' where winner='Swain, Cliff' and round=4 and event='M-PACT Open' and date='3/1/1988';
update results set score='(3),7,8,(10),0' where winner='Swain, Cliff' and round=4 and event='Arnie May Canadian Open Pro-Am' and date='3/10/1988';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='VCI Challenger Cup Series #3' and date='6/21/1992';
update results set score='6,3,2' where winner='Swain, Cliff' and round=4 and event='4th Campbells Healthy Request Pro-Am' and date='11/15/1992';
update results set score='(6),10,9,5' where winner='Swain, Cliff' and round=4 and event='Vancouver Pro-Am' and date='12/13/1992';
update results set score='9,5,(3),6' where winner='Swain, Cliff' and round=4 and event='VCI Pro-Am Classic' and date='3/7/1993';
update results set score='11,(7),7,9' where winner='Swain, Cliff' and round=4 and event='Hamilton Inn Pro Classic' and date='4/4/1993';
update results set score='8,8,11' where winner='Swain, Cliff' and round=4 and event='VCI Challenger Cup Series #4' and date='4/25/1993';
update results set score='(8),6,4,3' where winner='Swain, Cliff' and round=4 and event='TransCoastal Grand Nationals' and date='5/16/1993';
update results set score='4,0,9' where winner='Swain, Cliff' and round=4 and event='Summer Cooler Pro-Am' and date='8/8/1993';
update results set score='2,(9),5,(5),7' where winner='Swain, Cliff' and round=4 and event='South of the border' and date='8/29/1993';
update results set score='10,(7),5,(5),9' where winner='Swain, Cliff' and round=4 and event='11th Stockton Pro-Am' and date='9/6/1993';
update results set score='5,9,5' where winner='Swain, Cliff' and round=4 and event='VCI Challenge Cup Series #2' and date='11/7/1993';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='5th Campbells Healthy Request Pro-Am' and date='11/14/1993';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='Coca Cola Holiday Pro-Am' and date='12/5/1993';
update results set score='4,9,5' where winner='Swain, Cliff' and round=4 and event='VCI Challenge Cup Series #3' and date='12/13/1993';
update results set score='5,7,(8),8' where winner='Swain, Cliff' and round=4 and event='Hampton Inn Pro Classic' and date='1/23/1994';
update results set score='4,(8),5,5' where winner='Swain, Cliff' and round=4 and event='Cameco Classic' and date='3/6/1994';
update results set score='10,5,(4),(4),3' where winner='Swain, Cliff' and round=4 and event='Crohns & Colitis Foundation ProAm' and date='3/13/1994';
update results set score='(10),6,(9),1,2' where winner='Swain, Cliff' and round=4 and event='VCI Challenge Cup Series #5' and date='3/20/1994';
update results set score='5,4,3' where winner='Swain, Cliff' and round=4 and event='Las Vegas Pro-Am' and date='4/17/1994';
update results set score='8,(5),(8),2,7' where winner='Swain, Cliff' and round=4 and event='VCI Championship' and date='5/8/1994';
update results set score='2,6,(10),7' where winner='Swain, Cliff' and round=4 and event='Elmwood Summer Cooler Pro-Am' and date='8/8/1994';
update results set score='8,(8),(8),1,7' where winner='Swain, Cliff' and round=4 and event='12th Coors Light Pro-Am' and date='9/5/1994';
update results set score='(3),4,4,5' where winner='Swain, Cliff' and round=4 and event='Crystal City Pro-Am' and date='9/10/1994';
update results set score='2,3,8' where winner='Swain, Cliff' and round=4 and event='VCI Challenger Cup #4' and date='2/5/1995';
update results set score='7,(9),8,0' where winner='Swain, Cliff' and round=4 and event='VCI #6/VCI World Champs.' and date='5/14/1995';
update results set score='6,6,4' where winner='Swain, Cliff' and round=4 and event='Tournament of Champions' and date='6/11/1995';
update results set score='8,9,8' where winner='Swain, Cliff' and round=4 and event='Elmwood Summer Cooler Pro-Am' and date='8/13/1995';
update results set score='10,10,4' where winner='Swain, Cliff' and round=4 and event='VCI Challenge Cup Series #1' and date='10/22/1995';
update results set score='5,5,3' where winner='Swain, Cliff' and round=4 and event='Strong Funds Pro-Am' and date='11/5/1995';
update results set score='(10),4,8,9' where winner='Swain, Cliff' and round=4 and event='VCI Challenge Cup Series #2' and date='11/12/1995';
update results set score='3,7,(5),7' where winner='Swain, Cliff' and round=4 and event='Promus Hotels Pro Classic' and date='1/21/1996';
update results set score='6,2,4' where winner='Swain, Cliff' and round=4 and event='Pittsburgh Pro-Am' and date='2/18/1996';
update results set score='0,7,1' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro Nationals' and date='4/28/1996';
update results set score='5,7,4' where winner='Swain, Cliff' and round=4 and event='14th Coors Light Pro-Am' and date='9/2/1996';
update results set score='2,7,7' where winner='Swain, Cliff' and round=4 and event='11th Halloween Classic Pro Am' and date='10/27/1996';
update results set score='2,2,1' where winner='Swain, Cliff' and round=4 and event='Strong Funds Pro-Am' and date='11/3/1996';
update results set score='0,8,1' where winner='Swain, Cliff' and round=4 and event='Lakewood Holiday Pro-Am' and date='12/15/1996';
update results set score='6,(3),3,6' where winner='Swain, Cliff' and round=4 and event='Ralph Schomp Automotive Invitational' and date='1/19/1997';
update results set score='7,6,4' where winner='Swain, Cliff' and round=4 and event='VCI Atlanta Pro-Am' and date='2/15/1997';
update results set score='(10),7,7,(5),2' where winner='Swain, Cliff' and round=4 and event='Future Cellular Pro-Am' and date='2/23/1997';
update results set score='12,5,7' where winner='Swain, Cliff' and round=4 and event='Tony Filippini Real Estate Pro-Am' and date='5/4/1997';
update results set score='8,3,8' where winner='Swain, Cliff' and round=4 and event='IRT Phoenix Pro-Am' and date='5/11/1997';
update results set score='3,(8),(5),10,4' where winner='Swain, Cliff' and round=4 and event='Bay101 IRT World Championships' and date='5/18/1997';
update results set score='7,9, inj fft' where winner='Swain, Cliff' and round=4 and event='Elmwood Summer Cooler Pro-Am' and date='8/10/1997';
update results set score='10,4,5' where winner='Swain, Cliff' and round=4 and event='15th Coors Light Pro-Am' and date='9/1/1997';
update results set score='9,(8),(7),3,4' where winner='Swain, Cliff' and round=4 and event='Ralphs Grocery Pro-Am' and date='9/28/1997';
update results set score='4,3,9' where winner='Swain, Cliff' and round=4 and event='12th Halloween Pro-Am' and date='11/2/1997';
update results set score='6,8,2' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro-Am 97' and date='11/23/1997';
update results set score='(5),8,8,10' where winner='Swain, Cliff' and round=4 and event='APH Service Pro-Am' and date='12/14/1997';
update results set score='2,(8),4,2' where winner='Swain, Cliff' and round=4 and event='Laundry Land Pro-Am' and date='2/1/1998';
update results set score='5,4,6' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro-Am NJ' and date='2/22/1998';
update results set score='(10),7,7,(9),8' where winner='Swain, Cliff' and round=4 and event='March Madness Pro-Am' and date='3/29/1998';
update results set score='0,(3),9,2' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro Nationals' and date='4/26/1998';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='Elmwood Summer Cooler' and date='8/9/1998';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='16th Coors Light Pro-Am' and date='9/7/1998';
update results set score='7,8,8' where winner='Swain, Cliff' and round=4 and event='Magic City Classic Pro-Am' and date='10/4/1998';
update results set score='(7),5,5,4' where winner='Swain, Cliff' and round=4 and event='Ralphs Pro-Am' and date='10/11/1998';
update results set score='9,5,6' where winner='Swain, Cliff' and round=4 and event='Promus Hotels 3rd US Open' and date='11/15/1998';
update results set score='4,3,13' where winner='Swain, Cliff' and round=4 and event='APH Service Pro-Am' and date='12/13/1998';
update results set score='8,7,2' where winner='Swain, Cliff' and round=4 and event='Ralph Schomp Pro-Am' and date='1/17/1999';
update results set score='5,2,6' where winner='Swain, Cliff' and round=4 and event='Bud Light Pro Nationals' and date='4/25/1999';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='Elmwood Summer Cooler Pro-Am' and date='8/8/1999';
update results set score='(9),(1),10,4,6' where winner='Swain, Cliff' and round=4 and event='Summer Cooler Pro-Am' and date='8/6/2000';
update results set score='8,3,(8),7' where winner='Swain, Cliff' and round=4 and event='Halloween Classic 00' and date='10/29/2000';
update results set score='11,4,7' where winner='Swain, Cliff' and round=4 and event='Hilton 5th US Open' and date='11/19/2000';
update results set score='1,3,1' where winner='Swain, Cliff' and round=4 and event='Coca Cola Pro-Am' and date='12/10/2000';
update results set score='10,(8),2,9' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro-Am 01' and date='2/4/2001';
update results set score='8,4,3' where winner='Swain, Cliff' and round=4 and event='New Jersey Pro-Am' and date='2/12/2001';
update results set score='8,6,(6),(7),3' where winner='Swain, Cliff' and round=4 and event='San Diego Pro-Am' and date='4/29/2001';
update results set score='12,4,11' where winner='Swain, Cliff' and round=4 and event='Tournament of Champions' and date='6/3/2001';
update results set score='(3),9,7,10' where winner='Swain, Cliff' and round=4 and event='Summer Cooler Pro-Am' and date='8/12/2001';
update results set score='8,5,6' where winner='Swain, Cliff' and round=4 and event='Hilton 6th US Open' and date='11/20/2001';
update results set score='8,1,8' where winner='Swain, Cliff' and round=4 and event='12th Annual Holiday Pro-Am' and date='12/9/2001';
update results set score='8,11,(9),3' where winner='Swain, Cliff' and round=4 and event='Foxwoods Pro-Am 02' and date='1/27/2002';
update results set score='1,9,2' where winner='Swain, Cliff' and round=4 and event='San Diego Open' and date='3/3/2002';
update results set score='(5),7,9,4' where winner='Swain, Cliff' and round=4 and event='NC Open' and date='4/14/2002';
update results set score='9,9,7' where winner='Swain, Cliff' and round=4 and event='Choice Hotels 7th US Open' and date='11/24/2002';
update results set score='(12),9,(10),7,3' where winner='Swain, Cliff' and round=4 and event='San Diego Open' and date='3/2/2003';
update results set score='4,0,4' where winner='Swain, Cliff' and round=4 and event='2nd Team ED Pro-Am' and date='10/12/2003';
update results set score='10,(7),5,(9),1' where winner='Swain, Cliff' and round=4 and event='Cleveland Open' and date='1/11/2004';
update results set score='(3),5,0,inj fft' where winner='Swain, Cliff' and round=4 and event='22nd George Spanos Stockton Pro-Am' and date='9/12/2004';
update results set score='1,4,1' where winner='Swain, Cliff' and round=4 and event='Masters Spa Pro-Am' and date='10/31/2004';
update results set score='4,(9),4,(6),9' where winner='Swain, Cliff' and round=4 and event='Choice Hotels 9th US Open' and date='11/21/2004';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='Spalding IRT Tournament of Champions' and date='6/8/1997';
update results set score=' ' where winner='Swain, Cliff' and round=4 and event='2005 San Diego Open' and date='2/27/2005';
update results set score='9,(8),3,9' where winner='Swain, Cliff' and round=4 and event='VCI Challenger Cup #1' and date='10/23/1994';
update results set score='?,2,3' where winner='Swain, Cliff' and round=4 and event='VCI Challenger Cup #2' and date='11/6/1994';
update results set score='2,0,3' where winner='Swain, Cliff' and round=4 and event='Samba Pro-Am' and date='4/2/1995';
update results set score='8,5,(6),8' where winner='Swain, Cliff' and round=4 and event='Cameco Classic' and date='4/23/1995';







