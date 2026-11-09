This is a centralized git repository of all the code that runs Pro Racquetball Stats.  

Pro Racquetball Stats is an online historical reference site and match database for professional and major amateur tours. Started in 2000, it tracks professional racquetball matches 
dating to the early 1970s and contains nearly 54,000 match results across more than 3,100 tournaments and counting.  

The website supports more than 160 different reports that query this data, enabling a rich and comprehensive data analysis of match statistical data.

We have singles and doubles data for IRT, LPRT, WRT, IRF, WOR, Juniors, and Amateur nationals results for the major racquetball playing countries.   These results are stored
 in 15 separate databases in a MySQL database hosted at 3Essentials.  The front end code is a set of 3 Perl scripts comprising more than 40,000 lines of code and 150+ reports.

For nearly 20 years, these files were spread around my local Windows filesystem drive, divided up by the nature of the underlying data, when it dawned on me that it'd make a 
ton more sense to centralize into one Git repo that could be shared in the event that I got hit by a truck.

Here's a quick guide to the top level of the Repo.  Singles and Doubles are divided into separate directories but discussed together below:

| Top Level Directory | Nature of Data |
| -------- | -------- | 
| Amateur | Amateur National events.  Presently, just USA, Mexico, and Canada have regular R2sports run National events that we enter.  USA now combines National Singles and Doubles into one event (National Indoors).  Canada has two qualifiers then Nationals in May.  Mexico generally has just one Nationals event in February, but sometimes has off-cycle qualifiers for big events like Worlds or the Pan Am Games |
| cgi-bin | The main perl code that runs out of the cgi-bin directory of the www.proracquetballstats.com website.  There's 5 main perl files that run together to support the site |
| IRF  | International Racquetball Federation.  These are any IRF run tournament, whether they’re regional (like South American Games), or Global (annual Pan American Racquetball championships, bi-annual Worlds, and every-4 years World Games and Pan Am Games). |
| IRT | The Men’s Pro tour.  Currently called the IRT, has been called other names in the past. |
| Juniors | All Junior Nationals and Junior worlds.  USA and Mexico have stand-alone Junior national events, Canada now holds Junior championships with its May national championships.  IRF Junior Worlds is in December. |
| LPRT | Ladies Pro Racquetball Tour; the Women’s pro tour.  Has been called other names in the past. |
| Master SQL DBCreate | These are the master DDL files that create the core table objects that run the solution.  Each of the main "tours" of data is a separate database/schema and has the same tables, so these are the core DDL files to recreate those tables. |
| Rankings | These are the final SQL files that update the Year End Rankings for the pro tours.  I used to keep these alongside the working XLS and PDF files that I use to scrape the results then turn them into SQL insert statements, but it made more sense to put thim into GIT |
| RYDF | Reach Your Dream Foundation code: this is the former player support brainchild of Michael Lippett, now defunct. |
| WOR Court List | This is a couple of SQL files to do data loading of the core WOR Court list into a table for further processing |
| WOR | World Outdoor Racquetball.  These are just the “major” WOR events; Beach Bash, Outdoor Nationals, and 3WallBall. |
| WRT | World Racquetball Tour.  The World Racquetball Tour ceased operations in 2019.  The data is still in the database and the results are still online, but no new data entry is documented below.  Only active entities are documented. |
