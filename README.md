This is a centralized git repository of all the code that runs Pro Racquetball Stats.  

For nearly 20 years, these files were spread around a local Windows filesystem drive, divided up by the nature of the underlying data, when it dawned on me that it'd make a 
ton more sense to centralize into one Git repo that could be shared in the event that I got hit by a truck.

Pro Racquetball Stats is an online historical reference site and match database for professional and major amateur tours. Started in 2000, it tracks professional racquetball matches 
dating to the early 1970s and contains nearly 54,000 match results across more than 3,100 tournaments and counting.  

The website supports more than 160 different reports that query this data, enabling a rich and comprehensive data analysis of match statistical data.

We have singles and doubles data for IRT, LPRT, WRT, IRF, WOR, Juniors, and Amateur nationals results for the major racquetball playing countries.   These results are stored
 in 15 separate databases in a MySQL database hosted at 3Essentials.  The front end code is a set of 3 Perl scripts comprising more than 40,000 lines of code and 150+ reports.
