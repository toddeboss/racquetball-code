-- IRF Results Database Main table




drop table irf_main;

create table irf_main (
Tournament_Name	varchar(100),
Year varchar(4),
Location varchar(50),
gender_combined_flg varchar(10),
team_flag varchar(4),
Division_flag varchar(4),
WC_flag	varchar(1),
Age_Bracket	varchar(5),
First_Place_First_Name	varchar(30),
First_Place_Last_Name	varchar(30),
First_place_Country_1	varchar(10),
First_Place_First_Name_Doubles		varchar(30),
First_Place_Last_Name_Doubles		varchar(30),
First_Place_Country_2	varchar(10),
Second_Place_First_Name		varchar(30),
Second_Place_Last_Name		varchar(30),
Second_Place_Country_1	varchar(10),
Second_Place_First_Name_Doubles		varchar(30),
Second_Place_Last_Name_Doubles		varchar(30),
Second_Place_Country2	varchar(10),
Third_Place_First_Name_1		varchar(30),
Third_Place_Last_Name_1		varchar(30),
Third_Place_Country_11	varchar(10),
Third_Place_First_Name_1_Doubles		varchar(30),
Third_Place_Last_Name_1_Doubles		varchar(30),
Third_Place_Country_12	varchar(10),
Third_Place_First_Name_2		varchar(30),
Third_Place_Last_Name_2		varchar(30),
Third_Place_Country_21	varchar(10),
Third_Place_First_Name_2_Doubles		varchar(30),
Third_Place_Last_Name_2_Doubles		varchar(30),
Third_Place_Country_22 varchar(10)
);
