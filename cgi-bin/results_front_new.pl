#!/usr/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: results_front_new.pl
# file location: C:\Dropbox\z rball\www.proracquetballstats.com\cgi-bin
# Purpose: Front-end to results database 
#
# Dependencies: DBI, MySQL being up and available.
# Todo
#
# Modification History
# Date          who	What
# 03/17/04      TBoss   creation (adapted from old Corrivo code, from papa code)
# 4/5/04	TBoss	... continual addition of queries...
# 12/10/04	tboss	adding a couple new queries, cleaning up front end.
# 5/5/05	tboss	adding new w/l percentage query
# 5/31/05	tboss	added best_season, twinkies
# 9/5/07	tboss	discovered that apostrophes in names screws up print_results...
# 5/23/08	tboss	Put in Steve Szabo suggestion for all player season summaries
# 10/21/08	tboss	Started programming for Marty Hogan suggestion; tourney wins by season
# 			Also put in Head-to-Head for last 2 years query
# 11/4/08	tboss	Put in simple player_profile query
# 11/7/08	tboss	Put in tour_winners_age now that I have decently accurate birthdays.
# 11/10/09	tboss	Building Games won/lost, match_win_streak.
# 11/13/09	tboss	Creating nontriv_head_to_head_withresults suggestion from Jim Trammell
# 5/18/11	tboss	First cut at putting in per-season rankings, player_rankings
# 9/25/11	tboss	put in player_wins, player_losses
# 10/28/11	tboss	Added non-forfeit, non-tourney skipping 
# 11/3/11	tboss	adding all_negative query
# 1/8/13	tboss	adding most match-ups
# 7/17/13	tboss	Migrated to new host, new db name and new user
# 5/8/14	tboss	draft of "tour depth" query started...
# 5/12/14	tboss	oldest player to ... query working.  Also did Youngest to... while I was at it.
# 7/18/14	tboss	Beta of "ages of tour winners" table
# 8/5/14	tboss	addition of head-to-head total; sorting head to head records by ttl.
# 9/29/14	tboss	beta starting of Season Abstract
# 5/19/15	tboss	beta of "highest seeds to..." report.
# 6/18/15	tboss	re-ordered the per-player queries to put the best ones at the top
# 6/28/15	tboss	Beta of seed report per season
# 11/16/16	tboss	Modified to take incoming tour parameter and connect accordingly, cleaned up interface by
#                   removing all the added dates.  put in quick fix to longest matches code.
# 12/8/16	tboss	Built WRT player profile data, put back in ability to do those reports
# 12/19/16 tboss	commented out OT games for WRT tour; makes no sense since they play IRF/USAR rules.  Added caveat for OT 
#                 Games for LPRT.  Also commented out 5-game matches for WRT.  Adjusted text to this end.
# 12/28/16	tboss	put in longest_game fixes for LPRT rally scoring era
# 1/16/17	tboss	working on seeding report and cross-season season query
# 1/19/17	tboss	 Put in per-event seed report, showing all upsets for the tourney.
# 1/20/17	tboss	working on "most dominant" tourney win report.
# 7/10/17	tboss	working on US Open report
# 9/7/17	tboss	Putting in draw size report per tourney and per season
# 9/24/17	tboss	Putting in US Open draw size report historically plus Q/S/F report
# 9/25/17	tboss	Putting in US Open only Season summary report
# 10/9/17	tboss	Developed Top-10 matrix to show all top-10 seeded players across history in one view.
# 10/11/17	tboss	Put in beginnings of IRF queries.  Put in a ton of if-then-else to limit what shows with IRF
# 10/13/17	tboss	moved IRF data into its own database, tested new login, changing text and removing unneeded queries for IRF
# 10/14/17	tboss	Significant tweaking of all per-tour queries to account for IRF data
# 10/17/17	tboss	Put in placeholders to query amateur data, fixed all the if/then/else code based on tour name, 
#                     put in accounting for 3rd place matches
# 10/19/17	tboss	Filled in the rest of the IRF Summary singles reports, worked on all the doubles reporting to finish it off.
# 10/21/17	tboss Began to put in IRT doubles code logic.
# 10/23/17		tboss	 put in Cross-tour h2h query
# 10/28/17	tboss	put in Amateur category-wide queries.
# 11/1/17	tboss	Put in "frequent player profile" query since now there's so many player profile records
# 11/2/17	tboss	Put in IRF category-wide queries similar to Amateur.
# 11/3/17	tboss	most points in a loss query
# 11/15/17		tboss	Added Juniors, added a number of different ways to slice the Juniors categories
# 11/17/17		tboss	Added more amateur categories.
# 11/18/17	tboss	put in all forfeit query as a result of two straight weeks of forfeits on IRT semis/finals.
# 11/27/17		tboss	putting in Html5/Bootstrap implementation details
# 12/5/17	tboss	Created if-then-else at bottom to display tour-specific links
# 12/7/17	tboss	cleaned up dbconnect error messaging, fixed script to read pwds from outside file.
# 12/7/17		tboss	reading master_navigation code form outside file for consistency.
# 12/12/17	tboss	added in LPRTdbls logic, added in doubles W/L per player logic
# 12/16/17 tboss	added in WRTdbls 
# 12/21/17 tboss	Added in Doubles match history
# 1/2/18	tboss	Adding in Season_summary_all for doubles players.
# 1/3/18	tboss	Finally!! fixed the non-forfeit match winning streak query.  Put in placeholders for new 15point IRT games.
# 1/3/18	tboss	Writing highest seeds in semis query
# 1/4/18	tboss	followed this up with highest seeds in a final, qsf
# 1/6/18	tboss	Added most wins, most losses and enabled these in all singles tours
# 1/8/18	tboss	created reverse of highest seed queries; lowest combined seed queries.
# 1/10/18	tboss	put in google analytics code
# 1/17/18	tboss	put in placeholder for WOR for now
# 1/18/18	tboss	put in quick num_events query to show # of events per season.
# 1/19/18	tboss	appearance_streak query
# 1/21/18	tboss	putting in WOR logic and logins.
# 1/21/18	tboss	put in q/s/f country of origin query
# 1/23/18	tboss	changed buffer-in logic to allow for both existing functionality plus url-based variable passing
# 2/13/18	tboss	adding all finals query for quick reporting.
# 2/18/18	tboss	Putting in AMATEURdbls logic
# 3/7/18	tboss	head to Head matrix coding.
# 3/13/18	tboss	Seeding per event report created
# 3/19/18	tboss	consecutive_distinct_winners
# 6/22/18	tboss	added new IRF tourney categories after loading all the continental tourneys.
# 7/2/18	tboss	Also added World Games and added "tournament of the americas" to the Pan Am championships pulldown
# 7/3/18	tboss	Put in IRFmatchdbls logic.  Cleaned up bad dbls logic in singles-only clause.
# 7/14/18	tboss	Adding IRF tourney summary queries.
# 7/18/18	tboss	Added in WORdbls categories
# 9/9/18	tboss	adding best w/l pct in 16s onward
# 9/12/18	tboss	changed form method from POST to GET to print the direct URLs in the browser window
# 9/12/18	tboss	Putting in draw size report for all time
# 10/22/18	tboss	Making player_history_alltours
# 11/12/18	tboss	Adding in USA champs, younger age groups, for all of history, also working on all_winners_junior_matrix
# 11/15/18 	tboss	all_titles_us_open added
# 11/21/18	tboss	Adding some IRF Team queries
# 12/11/18	tboss	Adding whole-tour misc tour stats query.
# 12/31/18	tboss	added more Team queries
# 1/3/19	tboss	player_profiles_per_event
# 1/7/19	tboss	most_tourney_finals
# 1/29/19	tboss	Added scoring changes static links for IRT, LPRT
# 2/11/19	tboss	Added career_best_ranking, career_best_seeding, player_profile_individual
# 2/26/19	tboss	most_matches
# 3/20/19	tboss	moved h2h matrix to bottom, added direct link to tale of the tape
# 4/29/19	tboss	Added in more junior categories as select options, for all and for Canada.  also added 10Udb as official category for Canada.
# 5/9/19	tboss	Adding WOR categories to singles reporting
# 5/22/19	tboss	Adding player_profiles_per_season
# 5/31/19	tboss	Adding worst Career W/L pct... wl_pct_all_worst
# 7/17/19	tboss	Added q/s/f to WOR queries (not sure why not included before), changed category names
# 8/14/19	tboss	Adding in LPRT reports for longest games/points related to scoring changes.  Also threw in all_matches_per_season but commented out.
# 8/15/19	tboss	Adding IRF individual result summary report per country; country_individual_results
# 9/26/19	tboss	Creating player_wl_usopen
# 10/2/19	tboss	added player_history_us_open
# 10/3/19	tboss	player_wl_split
# 10/25/19	tboss	changed all PRS links to use https://
# 10/31/19	tboss	Added third pulldown category for current season players.
# 2/15/20	tboss	Turned off some reports for Amateur DB that didn't make sense (season_seed_report)
# 2/16/20	tboss	Adding categories to account for Qualifying events in Amateur
# 2/16/20	tboss	Adding additional "Most tourney wins" reports for Amateur now that we're loading qualifiers
# 2/17/20	tboss	Added more categories for just Qualifiers while we're at it.
# 3/25/20	tboss	rankings_matrix() development
# 4/6/20	tboss	Reorganized front page, adding Junior doubles, adding more IRF junior categories plus mixed for jrs.
# 4/9/20	tboss	Fixed bugs in junior categories that were switched between label and description, breaking the reports 
# 5/23/20	tboss	created age_of_winner
# 5/26/20	tboss	removed alltours and us_open match result queries from view for WOR data
# 9/23/20	tboss	Added in propickleballstats.com support
# 9/26/20	tboss	added in doubles head-to-head report support.  Added Q/S/F for doubles
# 9/28/20	tboss	Adding Gold/Silver/Bronze for pickleball
# 9/30/20	tboss	Adding Pickleball categories
# 9/30/20	tboss	renaming all "by" routines to be "per" routine names: example: qsf_by_season becoming qsf_per_season to be consistent
# 10/2/20	tboss	Added google analytics for PPS
# 10/14/20	tboss	Added more Categories for Beach Bash, Vegas to split out mens, womens, mixed
# 10/21/20	tboss	Added triple_crown reports for WOR
# 3/15/21	tboss	Changed WOR to go from season-based to year-based
# 4/30/21	tboss	Created country-entrant breakdown queries per event, per season, per tour
# 6/11/21	tboss	Adding sth error handling to every sth->execute line
# 11/15/21	tboss	Adding report to show debutants at US Open per Dean Baer suggestion us_open_debuts()
# 12/24/21	tboss	created career_best_win()
# 3/20/22	tboss	created oldest_final and youngest_final() 
# 4/3/22	tboss	Adding in mixed doubles now that that's a thing
# 6/27/22	tboss	Modified to handle new 21U junior divisions.
# 10/2/22	tboss	forgot to increment the seasons in this script!  updated for IRT and LPRT and re-deployed
# 1/18/24	tboss	Adding new query: tourney results per player with seeding.  tourney_results_summary()
# 1/18/24	tboss	Also testing with winscp versus filezilla b/c of dos2unix issues.
# 8/1/24	tboss	Added Distinct season appearances report for the various orgs.
# 8/12/24	tboss	change "PPA" to "PPS" for generic ProPickleballStats work
# 8/16/24	tboss	all_matches_per_event_maindrawonly() to show just winner's bracket/main draw of PB tourneys
# 8/16/24	tboss	added gender and mixed filters on player_history queries
# 8/17/24	tboss	Experimenting with new pull-downs for Pickleball; tour_filter and doubles_filter.
# 8/25/24	tboss	Adding tour filter to singles side too
# 8/26/24   tboss	Modifying event selection list for MLP 
# 9/18/24	tboss	Adding donut, twinkie count report for doubles.
# 6/30/25	tboss	Adding Mixed to Junior Doubles pulldowns
# 9/9/25	tboss	Adapting tour_regulars_age from tour_winners_age per Baghurst suggestion
# 10/29/25	tboss	Adding in two more Most Appearances queries for Manilla
# 10/29/25	tboss	Adding the rest of Mixed to Junior Doubles pulldowns for USA, IRF, etc.  wasn't complete in June 2025
# 3/3/26	tboss	Adding donuts_finals logic
# 3/18/26	tboss	Creating First time tour winner query to show each of the (now) 47 first time winners with information.  first_time_tour_winners()
# 3/24/26	tboss	Creating two Hall of Fame reports, joining to Hof_roster table
# 3/25/26	tboss	Changing HOF reports to use tourney_winners_age as a base, wrote new report.
# 9/28/26	tboss	Print out of all players who have switched countries; JTrball request.


#---------------------------------------------------------------

# Read in database connectivity library 
use DBI;

# set unbuffered i/o for STDOUT (probably not needed)
select((select(STDOUT), $|=1)[$[]);

# Debug flag: if set to 1, debugging info prints
$debug=0;

# Set important directories
#$cgibin_dir="/cgibin";
#$js_dir="/javascript";

#---------------------------------------------------------------
# Main

&get_form_values;
&populate_pws;
&make_form;


#---------------------------------------------------------------
# Subroutine Defn's

#---------------------------------------------------------------
sub get_form_values {

   # Print out a content-type for HTTP/1.0 compatibility
   print "Content-type: text/html\n\n";
   
   # Print out updated HTML5 tag
   print "<!DOCTYPE html>\n";   
   print "<html lang=\"en\">";
   
   
# 9/22/20: put in PPS vs PRS logic.

   if ($ENV{'SERVER_NAME'} eq 'www.proracquetballstats.com') {
      print "<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-112282142-1\"></script>
    <script>
       window.dataLayer = window.dataLayer || [];
       function gtag(){dataLayer.push(arguments);}
       gtag('js', new Date());

       gtag('config', 'UA-112282142-1');
    </script>

    <meta charset=\"utf-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\" />
    <meta name=\"description\" content=\"\">
    <meta name=\"author\" content=\"\">

    <title>Pro Racquetball Stats Query Selection Page</title>

    <!-- Bootstrap core CSS -->
    <link href=\"/bootstrap/bootstrap.min.css\" rel=\"stylesheet\" />
    <!-- Custom styles for this template -->
    <style>
      body {
        padding-top: 54px;
      }
      \@media (min-width: 992px) {
        body {
          padding-top: 56px;
        }
      }
	  \@media (max-width: 415px) {
		.container_results_table {
			margin:0px !important;
			padding:0px !important;
		}
		.display-4 {
			font-size: 1.7rem;
			font-weight: bold;
			line-height: 1.3;
		}
	  }
    </style>
   </head>";
   
   }
   elsif ($ENV{'SERVER_NAME'} eq 'www.propickleballstats.com') {
      print "<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-112282142-4\"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'UA-112282142-4');
    </script>	

    <meta charset=\"utf-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\" />
    <meta name=\"description\" content=\"\">
    <meta name=\"author\" content=\"\">

    <title>Pro Pickleball Stats Query Selection Page</title>

    <!-- Bootstrap core CSS -->
    <link href=\"/bootstrap/bootstrap.min.css\" rel=\"stylesheet\" />
    <!-- Custom styles for this template -->
    <style>
      body {
        padding-top: 54px;
      }
      \@media (min-width: 992px) {
        body {
          padding-top: 56px;
        }
      }
	  \@media (max-width: 415px) {
		.container_results_table {
			margin:0px !important;
			padding:0px !important;
		}
		.display-4 {
			font-size: 1.7rem;
			font-weight: bold;
			line-height: 1.3;
		}
	  }
    </style>
   </head>";	   

   }
   elsif ($ENV{'SERVER_NAME'} eq '') {
      printf "Hopefully you're calling this from your local computer because the ENV{'SERVER_NAME'} is blank ";
   }
   else {
      printf "Error: results_front_new.pl being called from an unknown hostname ~~~$ENV{'SERVER_NAME'}~~~.  Exiting";
      exit;
   }
   
   print "<body>";
   
   # 12/7/17: reading in master navigation from a file instead of hard-coding here
   # open the file, read through it line by line and print it
   open(my $fh, '<:encoding(UTF-8)', "../bootstrap/master_navigation.html") or die "Could not open file master navigation file $!";
   while (my $row = <$fh>) {
      chomp $row;
	  print "$row\n"
   }  
   
   print "<div style=\"padding: 0 1%;\">";      
	
   printf "<b>NOTE!  If you see this text the code is in debug mode!</b><br>  Please don't be alarmed, i'm trying to fix a code problem.  Your query 
   results will be at the very bottom as expected<p><p>" if $debug;

# Get the input from the previous form submission
# 1/23/18: changing this to allow url based values!
   $buffer = $ENV{'QUERY_STRING'} ;
   if ($buffer eq '') {
      read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
   }
   
# Split the name-value pairs
   @pairs = split(/&/, $buffer);

   &dump_array(@pairs) if $debug;

   foreach $pair (@pairs)
   {
      ($name, $value) = split(/=/, $pair);

       # Un-Webify plus signs and %-encoding
       $value =~ tr/+/ /;
       $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

       # Stop people from using subshells to execute commands
       # Not a big deal when using sendmail, but very important
       # when using UCB mail (aka mailx).
       # $value =~ s/~!/ ~!/g; 

       print "<p>Setting $name to $value<P>" if $debug;

       $form{$name} = $value;

   }
   
# Current Season Variable populating: putting this here so you don't have to hard code it elsewhere.
# 10/31/19; copied this from print_results_new.pl, primarily for the current season list of players.
# 3/15/21: changing WOR to be year based

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'IRTdbls') {
      $current_season='2023';
      $prior_season='2022';	  
   }
   elsif ($form{'tour'} eq 'LPRT' || $form{'tour'} eq 'LPRTdbls') {
      $current_season='2022-23';
      $prior_season='2021-22';	 
   }
   elsif ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
      $current_season='2021';
      $prior_season='2020';	 	  
   }
   # WRT now obsolete; leaving this going forward.
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'WRTdbls') {
      $current_season='2019';
      $prior_season='2018';	 	  
   }
   elsif ($form{'tour'} eq 'PPS' || $form{'tour'} eq 'PPSdbls') {
      $current_season='2024';
      $prior_season='2023';	 	  
   }
   elsif ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || 
          $form{'tour'} eq 'AMATEURdbls' || $form{'tour'} eq 'IRFmatchdbls' || $form{'tour'} eq 'JUNIORdbls') {
      # Amateurs, Juniors and IRF has no seasons
   }
   elsif ($form{'tour'} eq 'CROSS') {
      # do nothing; no season here.
   }  
   else {
      printf "Invalid Tour $tour selected in get_form_values; you should never get here";
   }
   
}

#---------------------------------------------------------------
sub populate_pws {

# 7/17/12: removed mysql.bossconsulting.com directed hostname.
# 7/18/13: migrated to 3essentials, using new db setup
# 11/16/16: put in if then else with differing logins.
# 12/7/17; moved pwds to external file, just reading in filename here.

   print "<p>tour is $form{'tour'}, logging into $form{'tour'} database<P>" if $debug;

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'IRTdbls') {
      $pwdfilename = 'cp30725_men.txt';
   }
   elsif ($form{'tour'} eq 'LPRT' || $form{'tour'} eq 'LPRTdbls') {
      $pwdfilename = 'cp30725_women.txt';
   }
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'WRTdbls') {
      $pwdfilename = 'cp30725_wrt.txt';
   }
   elsif ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'IRFmatchdbls') {
      $pwdfilename = 'cp30725_irf.txt';
   }   
   elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'AMATEURdbls') {
      $pwdfilename = 'cp30725_amateur.txt';
   }  
   elsif ($form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'JUNIORdbls') {
      $pwdfilename = 'cp30725_junior.txt';
   }  
   elsif ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
      # 1/17/18: placeholder
	#  printf "World Outdoor Racquetball (WOR) data has not yet been loaded into the database.  <p><p>We are discussing/considering what tournaments
	#  and what data may make sense to include here at this time.  Please hit the 'Home' button to return to the tour select page.<br>";

      $pwdfilename = 'cp30725_wor.txt';
   }  
   elsif ($form{'tour'} eq 'PPS' || $form{'tour'} eq 'PPSdbls') {
      $pwdfilename = 'cp30725_pps.txt'; 	  
   }   
   elsif ($form{'tour'} eq 'CROSS') {
      # do nothing for now; will do logins elsewhere.
	  printf "Cross database will do logins at the time of player pulldown population, not at the top<br>" if $debug;
   }  
   else {
      printf "Invalid Tour selected (Did you forget to select a Tour to run?)<p>";
      printf "Please hit the back button and pick a tour.";
   }
   
   unless ($form{'tour'} eq 'CROSS') {
      #printf "Password file selected is $pwdfilename<br>" if $debug;

      # open the file, populate the pwds
      open(my $fh, '<:encoding(UTF-8)', $pwdfilename) or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
         if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value; }		 
      }   
	  
      #printf "db_connect is $db_connect<br>" if $debug;
      #printf "db_user is $db_user<br>" if $debug;
      #printf "db_password is $db_password<br>" if $debug;   
    }
	
    #print "Tour Selected is $form{'tour'} <select name='tour' value='$form{'tour'}'></select>";


}


#---------------------------------------------------------------
# 10/24/17: adding big if-then-else to control the cross-tour queries.

sub make_form
{

   if ($form{'tour'} eq 'CROSS') {
      # eventually just h2h queries and separate logins.


#-------------
# By Player
#-------------
      # Print out a content-type for HTTP/1.0 compatibility
      #print "Content-type: text/html\n\n";

      # Print out updated HTML5 tag
      #print "<!DOCTYPE html>\n";   
      print "<html lang=\"en\">\n<body>\n<title>Pro Results Query Page</title>\n";
      print "<img src=\"../logos/PRS_logo.png\" width=250><font size=+3><font color=\"#3333FF\">";   

      print "&nbsp &nbsp Pro Results Query Page</font></font></center></p>\n";
      print "<form name=\"coupon_send\" ACTION=\"print_results_new.pl\" METHOD=\"GET\"";


      print "<p><b>Tour Selected</b>: <select name=\"tour\">";
      print "<option selected value='$form{'tour'}'>$form{'tour'}";
      print "</select> (Hit Back to select a different tour or <a href=\"https://$ENV{'SERVER_NAME'}/cgi-bin/choose_tour.pl\">Click Here</a>)<p>";

      print "<p><b>Page Instructions</b>: Select just ONE of the players from the various pulldowns.  To un-select a player from one list, select '(none)'
              and then make another selection.";

      print "<p><b>If more than one player is selected</b>, then the program will run Head-to-Head Reports for the FIRST player selected top to bottom.";

      print "<hr>";
	  
	  # Log into IRT database first
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_men.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  
	  
     # printf "db_connect is $db_connect<br>" if $debug;
      #printf "db_user is $db_user<br>" if $debug;
      #printf "db_password is $db_password<br>" if $debug; 	  
	  
      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "Select from All IRT Players: ";
      print "<select name=\"irtplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select><p>";

	  # Now get WRT players
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_wrt.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  

      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "<p>Select from All WRT Players: ";
      print "<select name=\"wrtplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select>\n";

	  
	  # Now get IRF players
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_irf.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  

      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "<p>Select from All IRF Players (Men and Women): ";
      print "<select name=\"irfplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select>\n";

	  # Now get Amateurs players
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_amateur.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  

      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "<p>Select from All Amateur Nationals Players (Men and Women): ";
      print "<select name=\"amateurplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select>\n";
	  
	  
	  # Now get Juniors players
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_junior.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  
	  

      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "<p>Select from All Junior Nationals Players (Boys and Girls): ";
      print "<select name=\"juniorplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select>\n";	  


	  # Now get LPRT players
      open(my $fh, '<:encoding(UTF-8)', 'cp30725_women.txt') or die "Could not open file '$pwdfilename' $!";
      while (my $row = <$fh>) {
         chomp $row;
         ($fvariable,$fvariable_value) = split(/=/, $row);
         #print "$row<br>" if $debug;
	     if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	     if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	     if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
      }  

      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      print "<p>Select from All LPRT Players: ";
      print "<select name=\"lprtplayer\">";
      print "<option selected value=0>(none)";
         
      $sql = "select distinct winner as name from results \
              union \
              select distinct loser as name from results order by name";         
 
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      while (@row = $sth->fetchrow_array) {
         $name=$row[0];
         $displayname=$name;
      
         # 9/5/07: discovered that apostrophes in names screws up print_results...
         if ($name =~ /\'/) {
            $name =~ s/\'/''/g;
         }
         #printf "name is $name, displayname is $displayname" if $debug;
         print "<option value=\"$name\">$displayname";
      }
      print "</select>\n";
	  
	  print "<hr>";

      # Cross tour Head to Head options
      print "<p><input type='radio' name='query' value='head_to_head_cross'><b>Player Head-to-Head Record Alphabetically, Across tours</b>: This will list 
	  a matrix of the player's head to head record w/ every other player in the DB, sorted by player name, across all available tours.";
      
      print "<br><input type='radio' name='query' value='head_to_head_cross_ttl'><b>Player Head-to-Head Record Ordered by most Matchups</b>: This will list a 
	  matrix of the player's head to head record w/ every other player in the DB, sorted by the number of times they've met from most to least";
      
      print "<br><input type='radio' name='query' value='head_to_head_cross_3yr'><b>Player Head-to-Head Records in last 3 years </b>: To gauge more recent head-to-head 
	  records, this limits the search to the last three years for active players";
      
      print "<br><input type='radio' name='query' value='nontriv_head_to_head_cross'><b>Non-Trivial Player Head-to-Head Record</b>: This is head-to-head among the more 
	  regular tour members (eliminates all matchups where there have been less than 2 meetings)";
      
      #print "<br><input type='radio' name='query' value='nontriv_head_to_head_withresults_cross'><b>Non-Trivial Player Head-to-Head Records With Results</b>: Shows 
	  #non-trivial head-to-head records for players on tour, with the results.";




      print "<P>";
   
      print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
      print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";  
	  
	  
   }  
   else { 
      # Log into Mysql
      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      # Print out a content-type for HTTP/1.0 compatibility
      #print "Content-type: text/html\n\n";
	  
      # Print out updated HTML5 tag
      #print "<!DOCTYPE html>\n";   
      print "<html lang=\"en\">\n<body>\n<title>Pro Results Query Page</title>\n";
      if ($form{'tour'} eq 'PPS' || $form{'tour'} eq 'PPSdbls') { 
         print "<img src=\"../logos/PPS_logo_placeholder.JPG\" width=250><font size=+3><font color=\"#3333FF\">";
      }
      else {	  
         print "<img src=\"../logos/PRS_logo.png\" width=250><font size=+3><font color=\"#3333FF\">";
	  }   

      print "&nbsp &nbsp Pro Results Query Page</font></font></center></p>\n";
      print "<form name=\"coupon_send\" ACTION=\"print_results_new.pl\" METHOD=\"GET\"";
   
      $tour=$form{'tour'};
   
      if ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'IRFmatchdbls') {
         $tour='IRF';
      }
   
      if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'IRTdbls') {
         $tour='IRT';
      }

      if ($form{'tour'} eq 'LPRT' || $form{'tour'} eq 'LPRTdbls') {
         $tour='LPRT';
      }

      if ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'WRTdbls') {
         $tour='WRT';
      }

      if ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
         $tour='WOR';
      }	  
      if ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'AMATEURdbls') {
         $tour='AMATEUR';
      }	 
      if ($form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'JUNIORdbls') {
         $tour='JUNIOR';
      }	 	
	  if ($form{'tour'} eq 'PPS' || $form{'tour'} eq 'PPSdbls') { 
         $tour='PPS';
      }

	  
	  
      #print "<p><b>Tour Selected<b>: $tour<p>";
   
      print "<p><b>Tour Selected</b>: <select name=\"tour\">";
      print "<option selected value='$form{'tour'}'>$form{'tour'}";
      print "</select> (Hit Back to select a different tour or <a href=\"https://$ENV{'SERVER_NAME'}/cgi-bin/choose_tour.pl\">Click Here</a>)<p>";
   
      # 10/4/13: putting in banner selection text instead of depending on hand-editing perl files every update.
      $sql = "select last_update_date,banner_text from banner"; 
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
   
      while (@row = $sth->fetchrow_array) {
         $lastupdatedate=$row[0];
         $bannertext=$row[1];
      }
    
      print "<b>$tour Database Last Updated $lastupdatedate</b>: $bannertext<br>";
   
      print "<p><b>Page Instructions</b>: Click on one of the pre-built queries to ";
      print "run the selection.  If any box is selected, any 'Submit Form' button will work.";
   
   
#--------------------------------------------------------------------------------------------------
# IRF Summary Data
# this entire section just works on the IRF summary data tables.
#--------------------------------------------------------------------------------------------------
  
   
# moved summary IRF summary data to top of code.
   
      if ($form{'tour'} eq 'IRFsumm') {

#-------------
# IRF Summary data By Event
#------------- 
   
         print "<hr>";
         $sql = "select distinct year,tournament_name, location from irf_main order by year desc, tournament_name;"; 
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         print "<b>IRF Event Summary Data: 1st, 2nd and 3rd place finishers per event, Singles and Doubles</b><p>";
         print "Select Individual IRF Event: <select name=\"sum_event\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $year=$row[0];
            $event=$row[1];
            $location =$row[2];
            print "<option value='$year~$event'>$year &nbsp $event &nbsp $location";
         }
         print "</select>\n";
      
         print "<p><input type='radio' name='query' value='irf_all_results_per_event'><b>All Finalists per event</b>: This query lists 
   	  the Team, Singles and Doubles finishers of all competitions for this Event.";
         print "<br><input type='radio' name='query' value='irf_team_results_per_event'><b>Team Finalists per event</b>: This query lists 
   	  the Team/Country Champions, Runners-Up and 3rd Place finishers of all competitions for this Event.";
         print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_event'><b>All Singles Finalists per event</b>: This query lists 
   	  the Champions, Runners-Up and 3rd Place finishers of all Singles competitions for this Event.";
         print "<br><input type='radio' name='query' value='irf_all_doubles_matches_per_event'><b>All Doubles Finalists per event</b>: This query lists 
   	  the Champions, Runners-Up and 3rd Place finishers of all Doubles competitions for this Event.";
         
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
   	  
   	  print "<hr>";
   	  print "<hr>";	  
   


#-------------
# IRF Summary data By Age Group
#------------- 
   
         $sql = "select distinct(ifnull(age_bracket,'Open')) from irf_main order by ifnull(age_bracket,'Open');"; 
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         print "<b>IRF Division Summary Data: 1st, 2nd and 3rd place finishers by Division across all IRF Events.</b><p>";
   
         print "Select IRF Age Category/Division: <select name=\"division\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $division=$row[0];
            print "<option value='$division'>$division";
         }
         print "</select>\n";
   
   
         print "<p><input type='radio' name='query' value='irf_all_team'><b>All Team Finalists</b>: This query lists the Champions, Runners-Up and 3rd Place 
   	     team finishers of competitions throughout history (ignores the age pull down)";	  
         print "<p><input type='radio' name='query' value='irf_all_singles_matches_per_division_male'><b>All Male Singles Finalists per Division </b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of all Mens/Boys Singles competitions for this Division throughout history";
         print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_division_female'><b>All Female Singles Finalists per Division </b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of all Womens/Girls Singles competitions for this Division throughout history";
   
         print "<br><input type='radio' name='query' value='irf_all_doubles_matches_per_division_male'><b>All Male Doubles Finalists per Division </b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of all Mens/Boys Doubles competitions for this Division throughout history";
         print "<br><input type='radio' name='query' value='irf_all_doubles_matches_per_division_female'><b>All Female Doubles Finalists per Division </b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of all Womens/Girls Doubles competitions for this Division throughout history";
   		
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
   
   	  print "<hr>";
   	  print "<hr>";	  

#-------------
# IRF Summary data per player
#------------- 

# right now this is just singles participants; should augment to get all names.
#      $sql = "select distinct(concat(first_place_last_name, ', ',first_place_first_name)) from irf_main where division_flag='S' \
#              union \
#              select distinct(concat(second_place_last_name, ', ',second_place_first_name)) from irf_main  where division_flag='S' \
#              union \
#              select distinct(concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) from irf_main  where division_flag='S' \
#              union \
#              select distinct(concat(third_place_last_name_2, ', ',third_place_first_name_2)) from irf_main  where division_flag='S' \
#              order by 1;"; 

# this version gets all singles and doubles names and is 2x as large as the singles pulldown.			  
         $sql="select distinct(concat(first_place_last_name, ', ',first_place_first_name)) from irf_main 
              union 
              select distinct(concat(first_place_last_name_doubles, ', ',first_place_first_name_doubles)) from irf_main  
              union
              select distinct(concat(second_place_last_name, ', ',second_place_first_name)) from irf_main 
              union
              select distinct(concat(second_place_last_name_doubles, ', ',second_place_first_name_doubles)) from irf_main 
              union 
              select distinct(concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) from irf_main  
              union 
              select distinct(concat(Third_Place_Last_Name_1_doubles, ', ',Third_Place_First_Name_1_doubles)) from irf_main  
              union 
              select distinct(concat(third_place_last_name_2, ', ',third_place_first_name_2)) from irf_main  
              union 
              select distinct(concat(third_place_last_name_2_doubles, ', ',third_place_first_name_2_doubles)) from irf_main 
              order by 1;";
			  
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
   
         print "<b>IRF Per Player Summary Data</b><p>";
   
         print "Select IRF Player: <select name=\"player\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $player=$row[0];
            print "<option value='$player'>$player";
         }
         print "</select>\n";
   
         print "or Select Frequent International player: <select name=\"player2\">";
         print "<option selected value=0>(none)";

# this query does a group by and gets all players who have more than 5 appearances in the data	 
# singles version here commented out to use version that gets all of doubles too 
#      $sql = "select p.player from (
#                 select (concat(first_place_last_name, ', ',first_place_first_name)) as player from irf_main where division_flag='S' 
#                 union all 
#                 select (concat(second_place_last_name, ', ',second_place_first_name)) as player from irf_main  where division_flag='S' 
#                 union all
#                 select (concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) as player from irf_main  where division_flag='S' 
#                 union all
#                 select (concat(third_place_last_name_2, ', ',third_place_first_name_2)) as player from irf_main  where division_flag='S' 
#                 order by player
#              ) p where p.player is not null group by p.player having count(*) > 5 order by p.player;"; 

# this version gets all singles and doubles names and is 2x as large as the singles pulldown.			  
         $sql="select p.player from (              
              select (concat(first_place_last_name, ', ',first_place_first_name)) as player from irf_main 
              union all
              select (concat(first_place_last_name_doubles, ', ',first_place_first_name_doubles)) as player from irf_main  
              union all
              select (concat(second_place_last_name, ', ',second_place_first_name)) as player from irf_main 
              union all
              select (concat(second_place_last_name_doubles, ', ',second_place_first_name_doubles)) as player from irf_main 
              union all
              select (concat(Third_Place_Last_Name_1, ', ',Third_Place_First_Name_1)) as player from irf_main  
              union all
              select (concat(Third_Place_Last_Name_1_doubles, ', ',Third_Place_First_Name_1_doubles)) as player from irf_main  
              union all
              select (concat(third_place_last_name_2, ', ',third_place_first_name_2)) as player from irf_main  
              union all
              select (concat(third_place_last_name_2_doubles, ', ',third_place_first_name_2_doubles)) as player from irf_main 
              order by player
              ) p where p.player is not null group by p.player having count(*) > 10 order by p.player;"	;
   			  
         printf "$sql<br>" if $debug;
            $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;	  
   
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            $displayname=$name;
      
            # 9/5/07: discovered that apostrophes in names screws up print_results...
            if ($name =~ /\'/) {
               $name =~ s/\'/''/g;
            }
            #printf "name is $name, displayname is $displayname" if $debug;
            print "<option value=\"$name\">$displayname";
         }
         print "</select>\n";
         print "<br>(choose (none) for the first pull down from All Players if you're selecting a \"Frequent player\".  ";
      	  
   	  
         print "<p><input type='radio' name='query' value='irf_all_player_results_singles'><b>All Singles Results per player</b>: This 
           query lists all the results for this player across all singles divisions (Adult and Junior), all competitions for all Intl history";
         print "<br><input type='radio' name='query' value='irf_all_player_results_doubles'><b>All Doubles Results per player</b>: This 
           query lists all the results for this player across all doubles divisions (Adult and Junior), all competitions for all Intl history (along with their partners)";
   		
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
   
         print "<hr>";
         print "<hr>";	  
   	

#-------------
# IRF Summary data By Category of Event
#------------- 

         $sql = "select distinct(tournament_name) from irf_main order by 1;"; 
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         print "<b>IRF Tournament Category Summary Data: 1st, 2nd and 3rd place finishers per type of IRF Event.</b><p>";
   
         print "<B>Note</b>: if you select a Tournament category that does not have the divisions you then run a report for, no results will show.  
   	  For example; if you pick Junior Worlds, there won't be Mens or Womens open.  <p>";
   	  
         print "Select IRF Tournament Category: <select name=\"category\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $category=$row[0];
            print "<option value='$category'>$category";
         }
         print "</select>\n";
   
      
         print "<p><input type='radio' name='query' value='irf_all_singles_matches_per_category'><b>All Singles Finalists per Tournament Category</b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of all Singles competitions for this Tournament category throughout history";
         print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mensopen'><b>Just Mens Open for the Tournament Category</b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens Open for this Tournament category throughout history";
         print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womensopen'><b>Just Womens Open per Tournament Category</b>: This 
           query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens Open for this Tournament category throughout history";
   	  print "<br>";
		
# Decided to comment these all out: much easier to get them from the Division summary page and these just clutter up the reporting front end page...
	
# Logic built into print_results_new.pl to handle them if we return.
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens30'><b>Just Mens 30+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 30+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens30'><b>Just Womens 30+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 30+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens35'><b>Just Mens 35+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 35+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens35'><b>Just Womens 35+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 35+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens40'><b>Just Mens 40+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 40+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens40'><b>Just Womens 40+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 40+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens45'><b>Just Mens 45+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 45+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens45'><b>Just Womens 45+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 45+ for this Tournament category throughout history";		
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens50'><b>Just Mens 50+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 50+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens50'><b>Just Womens 50+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 50+ for this Tournament category throughout history";		
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens55'><b>Just Mens 55+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 55+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens55'><b>Just Womens 55+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 55+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens60'><b>Just Mens 60+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 60+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens60'><b>Just Womens 60+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 60+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens65'><b>Just Mens 65+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 65+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens65'><b>Just Womens 65+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 65+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens70'><b>Just Mens 70+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 70+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens70'><b>Just Womens 70+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 70+ for this Tournament category throughout history";		
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens75'><b>Just Mens 75+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 75+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens75'><b>Just Womens 75+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 75+ for this Tournament category throughout history";				
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens80'><b>Just Mens 80+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 80+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens80'><b>Just Womens 80+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 80+ for this Tournament category throughout history";	
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens85'><b>Just Mens 85+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 85+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens85'><b>Just Womens 85+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 85+ for this Tournament category throughout history";	
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_mens90'><b>Just Mens 90+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Mens 90+ for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_womens90'><b>Just Womens 90+ per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Womens 90+ for this Tournament category throughout history";	
		
#	  print "<br>";		

#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys18u'><b>Just Boys 18U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 18U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls18u'><b>Just Girls 18U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 18U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys16u'><b>Just Boys 16U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 16U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls16u'><b>Just Girls 16U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 16U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys14u'><b>Just Boys 14U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 14U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls14u'><b>Just Girls 14U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 14U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys12u'><b>Just Boys 12U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 12U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls12u'><b>Just Girls 12U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 12U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys10u'><b>Just Boys 10U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 10U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls10u'><b>Just Girls 10U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 10U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys8u'><b>Just Boys 8U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 8U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls8u'><b>Just Girls 8U per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 8U for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys8umb'><b>Just Boys 8U Multi Bounce per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 8U Multi Bounce for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls8umb'><b>Just Girls 8U Multi Bounce per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 8U Multi Bounce for this Tournament category throughout history";		
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_boys6umb'><b>Just Boys 6U Multi Bounce per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Boys 6U Multi Bounce for this Tournament category throughout history";
#      print "<br><input type='radio' name='query' value='irf_all_singles_matches_per_category_girls6umb'><b>Just Girls 6U Multi Bounce per Tournament Category</b>: This 
#        query lists the Champions, Runners-Up and 3rd Place finishers of just the Girls 6U Multi Bounce for this Tournament category throughout history";		


		
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
   
   	  print "<hr>";	
   	  print "<hr>";	  
   
      }   # if ($form{'tour'} eq 'IRFsumm') big if-then clause
   

   
   
   

#--------------------------------------------------------------------------------------------------
# Doubles Match Results
# decided to put in very limited doubles match queries for now b/c of difficulties in coding up these reports.
#--------------------------------------------------------------------------------------------------

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'WORdbls' || 
	      $form{'tour'} eq 'AMATEURdbls' || $form{'tour'} eq 'IRFmatchdbls' || $form{'tour'} eq 'JUNIORdbls' || $form{'tour'} eq 'PPSdbls') {
         print "<hr>";
	  
#-------------
# Doubles By Event
#-------------	  

         # 8/26/24: b/c of MLP not having finals ... have to modify this query for Pickleball.  we'll do a union on event name
         if ($form{'tour'} eq 'PPSdbls') {  
            $sql="select event,date,city,season,tour,tmp_date from results_doubles where round='2' 
                  union 
                  select distinct SUBSTRING_INDEX(event, ' - ', 1) ,date,city,season,substring_index(tour, ' - ',1),tmp_date 
                    from results_doubles where tour like 'MLP%' and tour not like '%DreamBreaker'
                  order by tmp_date desc;"
         }
         else {
            $sql = "select event,date,city,season,tour from results_doubles where round='2' order by tmp_date desc"; 

         }
		 
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         print "<b>$tour Doubles Match Results Data: match by match Results database</b><p>";
   
         print "Select Event: <select name=\"event\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $event=$row[0];
            $date=$row[1];
            $city =$row[2];
            $season =$row[3];
            $tour=$row[4];
            print "<option value='$event~$date'>$season &nbsp $tour &nbsp $city &nbsp $event &nbsp ($date)";
         }
         print "</select><p>";
   	  
         if ($form{'tour'} eq 'PPSdbls') {
            print "<input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred 
		           at the tourney.  It will include Qualifying, Winners and Losers bracket, Points draws, and bonus draws. ";	   	  
         }
		 else { 	  
            print "<input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred 
		           at the tourney.  All known qualifiers are included. ";	
		 }


         # 8/16/24: Putting in Main draw-only pickleball query that eliminates qualifiers, bonus draw results,  points draw results.
         if ($form{'tour'} eq 'PPSdbls') {
            print "<br><input type='radio' name='query' value='all_matches_per_event_maindrawonly'><b>All matches per Event, Main Draw only</b>: Main/Winner's bracket draw only.";	   	  
         }

         if ($form{'tour'} eq 'PPSdbls') {
            print "<br><input type='radio' name='query' value='gsb_per_event'><b>Gold, Silver and Bronze Medalists per Event</b>: Top 3 finishers for an event";	   	  
         }
		 else {
            print "<br><input type='radio' name='query' value='qsf_per_event'><b>Quarters, Semis and Final per Event</b>: top 8 finishers for an event";	   	  
		 }
         
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";	  
	  
#-------------
# Doubles By Season/Year
#-------------
      
         print "<hr>";
         print "Select Season: ";
   
         print "<select name=\"season\">";
         print "<option selected value=0>(none)";
         
         $sql = "select distinct season from results_doubles order by season desc"; 
   	  
         printf "<br>$sql\n" if $debug;      
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            print "<option value='$name'>$name";
         }
         print "</select><p>";
   
   	  
         print "<input type='radio' name='query' value='finals_per_season'><b>Finals by Season</b>: This query will list the finals of every tourney for the selected season";	
		 
         if ($form{'tour'} eq 'PPSdbls') {
            print "<br><input type='radio' name='query' value='gsb_per_season_doubles'><b>Gold, Silver and Bronze Medalists per Season</b>: Top 3 finishers for each event for the season";	   	  
         }
		 else {
            print "<br><input type='radio' name='query' value='qsf_per_season_doubles'><b>Quarters, Semis and Final per Season</b>: top 8 finishers in each event for the season";	   	  
		 }		 
		 
	 
   	  
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";	
		 
#-------------
# Doubles By Tournament Category for Amateurs/IRF
#-------------		 
		 
		 
        if ($form{'tour'} eq 'AMATEURdbls' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='USA Mens Open'>USA Mens Open";
            print "<option value='USA Womens Open'>USA Womens Open";
            print "<option value='USA Mixed Open'>USA Mixed Open";
            print "<option value='Mexico Mens Open'>Mexico Mens Open";
            print "<option value='Mexico Womens Open'>Mexico Womens Open";
            print "<option value='Mexico Mixed Open'>Mexico Mixed Open";
            print "<option value='Canada Mens Open'>Canada Mens Open";
            print "<option value='Canada Womens Open'>Canada Womens Open";
            print "<option value='Canada Mixed Open'>Canada Mixed Open";
            print "<option value='---------'>---------";				
            print "<option value='USA All'>All USA Mens and Womens Events";
            print "<option value='Mexico All'>All Mexico Mens and Womens Events";		
            print "<option value='Canada All'>All Canadian Mens and Womens Events";
            print "<option value='All Men'>All Mens Events for all Countries";
            print "<option value='All Women'>All Womens Events for all Countries";		

            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category_doubles'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }
		 

        if ($form{'tour'} eq 'IRFmatchdbls' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='IRF All Men'>All Mens Open, across IRF events";
            print "<option value='IRF All Women'>All Womens Open, across IRF events";
            print "<option value='IRF All Mixed'>All Mixed Open, across IRF events";
			print "<option value='All Majors - Mens Open'>All Majors (Worlds, Pan Ams) Mens Open";
			print "<option value='All Majors - Womens Open'>All Majors (Worlds, Pan Ams) Womens Open";
			print "<option value='All Majors - Mixed Open'>All Majors (Worlds, Pan Ams) Mixed Open";
			print "<option value='All NonMajors - Mens Open'>All Non-Majors (Continental championships) Mens Open";
			print "<option value='All NonMajors - Womens Open'>All Non-Majors (Continental championships) Womens Open";			
			#print "<option value='All NonMajors - Mixed Open'>All Non-Majors (Continental championships) Mixed Open";	
            print "<option value='World Championships - Mens Open'>World Championships Mens Open";
            print "<option value='World Championships - Womens Open'>World Championships Womens Open";
            #print "<option value='World Championships - Mixed Open'>World Championships Mixed Open";
            print "<option value='Pan American Championships - Mens Open'>Pan American Championships/Tournament of the Americas Mens Open";
            print "<option value='Pan American Championships - Womens Open'>Pan American Championships/Tournament of the Americas Womens Open";
            print "<option value='Pan American Championships - Mixed Open'>Pan American Championships/Tournament of the Americas Mixed Open";
			print "<option value='Pan American Games - Mens Open'>Pan American Games Mens Open";
            print "<option value='Pan American Games - Womens Open'>Pan American Games Womens Open";
            #print "<option value='Pan American Games - Mixed Open'>Pan American Games Mixed Open";
			print "<option value='Pan American Sports Festival - Mens Open'>Pan American Sports Festival Mens Open";
            print "<option value='Pan American Sports Festival - Womens Open'>Pan American Sports Festival Womens Open";
            #print "<option value='Pan American Sports Festival - Mixed Open'>Pan American Sports Festival Mixed Open";
			print "<option value='World Games - Mens Open'>World Games Mens Open";
            print "<option value='World Games - Womens Open'>World Games Womens Open";
            #print "<option value='World Games - Mixed Open'>World Games Mixed Open";
			print "<option value='South American Games - Mens Open'>South American Games Mens Open";
			print "<option value='South American Games - Womens Open'>South American Games Womens Open";
			#print "<option value='South American Games - Mixed Open'>South American Games Mixed Open";
			print "<option value='Bolivarian Games - Mens Open'>Bolivarian Games Mens Open";
			print "<option value='Bolivarian Games - Womens Open'>Bolivarian Games Womens Open";
			#print "<option value='Bolivarian Games - Mixed Open'>Bolivarian Games Mixed Open";
			print "<option value='Central American Caribbean Games - Mens Open'>Central American Caribbean Games Mens Open";
			print "<option value='Central American Caribbean Games - Womens Open'>Central American Caribbean Games Womens Open";
			#print "<option value='Central American Caribbean Games - Mixed Open'>Central American Caribbean Games Mixed Open";
			print "<option value='Central American Games - Mens Open'>Central American Games Mens Open";
			print "<option value='Central American Games - Womens Open'>Central American Games Womens Open";
			print "<option value='Central American Games - Mixed Open'>Central American Games Mixed Open";
			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category_doubles'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
			print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
         }
		 
		 
		# WOR Doubles categories: Men's women's and Mixed Pro doubles
		# Find the WOR Singles categories too
        if ($form{'tour'} eq 'WORdbls' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
   
            print "<option value='Mens Doubles'>All Mens Doubles";
            print "<option value='Womens Doubles'>All Womens Doubles";
            print "<option value='Mixed Doubles'>All Mixed Doubles";
            print "<option value='One Wall'>One Wall Only";
            print "<option value='Three Wall'>Three Wall Only";
            print "<option value='One Wall Mens'>One Wall only, Mens Only";
            print "<option value='One Wall Womens'>One Wall only, Womens Only";			
            print "<option value='One Wall Mixed'>One Wall only, Mixed Only";					
            print "<option value='Three Wall Mens'>Three Wall Only, Mens Only";
            print "<option value='Three Wall Womens'>Three Wall Only, Womens Only";			
            print "<option value='Three Wall Mixed'>Three Wall Only, Mixed Only";	

# Note: this is called "California" despite it occuring in Florida one year			
# this was "california" but changed to Outdoor nationals
            #print "<option value='California'>Just Huntington Beach Outdoor Championships";	
            #print "<option value='California Mens'>Huntington Beach Outdoor Championships, Mens Only";
            #print "<option value='California Womens'>Huntington Beach Outdoor Championships Womens Only";
            #print "<option value='California Mixed'>Huntington Beach Outdoor Championships, Mixed Only";
            #print "<option value='Beach Bash'>Just Florida Beach Bash One Wall Championships";
            #print "<option value='Vegas'>Just Las Vegas Three-Wall Championships";
		
            print "<option value='Outdoor Nationals'>All Huntington Beach Outdoor Championships (Mens, Womens, Mixed)";	
            print "<option value='Outdoor Nationals Mens'>Huntington Beach Outdoor Championships, Mens Only";
            print "<option value='Outdoor Nationals Womens'>Huntington Beach Outdoor Championships Womens Only";
            print "<option value='Outdoor Nationals Mixed'>Huntington Beach Outdoor Championships Mixed Only";
			
            print "<option value='Beach Bash'>All Florida Beach Bash One Wall Championships (Mens, Womens, Mixed)";
            print "<option value='Beach Bash Mens'>Just Florida Beach Bash One Wall Championships Mens Only";
            print "<option value='Beach Bash Womens'>Just Florida Beach Bash One Wall Championships Womens Only";			
            print "<option value='Beach Bash Mixed'>Just Florida Beach Bash One Wall Championships Mixed only";				
			
			print "<option value='Vegas'>All Las Vegas 3WallBall Championships Events (One-Wall and Three-Wall, Mens, Womens, Mixed)";    
			print "<option value='Vegas All 3Wall'>All Las Vegas 3WallBall Three Wall Championships Events (Mens, Womens, Mixed)";     
			print "<option value='Vegas All 1Wall'>All Las Vegas 3WallBall One Wall Championships Events (Mens, Womens, Mixed)";  
			print "<option value='Vegas 3Wall Mens'>Las Vegas 3WallBall Three Wall Championships Events, Mens Only";  			
			print "<option value='Vegas 3Wall Womens'>Las Vegas 3WallBall Three Wall Championships Events, Womens Only";  
			print "<option value='Vegas 3Wall Mixed'>Las Vegas 3WallBall Three Wall Championships Events, Mixed Only";  			
			print "<option value='Vegas 1Wall Mens'>Las Vegas 3WallBall One Wall Championships Events, Mens Only";
			print "<option value='Vegas 1Wall Womens'>Las Vegas 3WallBall One Wall Championships Events, Womens Only";
			print "<option value='Vegas 1Wall Mixed'>Las Vegas 3WallBall One Wall Championships Events, Mixed Only";
			
			print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category_doubles'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }		 
		 
		 # 4/6/20: putting in Junior Doubles categories
		 # adapting from Junior categories: removing all groups younger than 10 and adding mixed
		 # note; commented out categories here are wrong anyway and need to be fixed but not likely to be adding
		 # 8u junior doubles any time soon...
         # 6/27/22: adding in 21U divisions
         # 10/29/25: adding in USA Mixed, All Mixed
		 
		 if ($form{'tour'} eq 'JUNIORdbls') {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";

            print "<option value='All Boys 21U'>All Boys 21U competitions, across all federations";
            print "<option value='All Boys 18U'>All Boys 18U competitions, across all federations";
            print "<option value='All Boys 16U'>All Boys 16U competitions, across all federations";
            print "<option value='All Boys 14U'>All Boys 14U competitions, across all federations";			
            print "<option value='All Boys 12U'>All Boys 12U competitions, across all federations";
            print "<option value='All Boys 10U'>All Boys 10U competitions, across all federations";
            #print "<option value='All Boys 10Udb'>All Boys 10Udb competitions, across all federations";
            #print "<option value='All Boys 8U'>All Boys 8U competitions, across all federations";
            #print "<option value='All Boys 8Umb'>All Boys 8Umb competitions, across all federations";
            #print "<option value='All Boys 6Umb'>All Boys 6Umb competitions, across all federations";
			
            print "<option value='---------'>---------";	

            print "<option value='All Girls 21U'>All Girls 21U competitions, across all federations";			
            print "<option value='All Girls 18U'>All Girls 18U competitions, across all federations";
            print "<option value='All Girls 16U'>All Girls 16U competitions, across all federations";	
            print "<option value='All Girls 14U'>All Girls 14U competitions, across all federations";			
            print "<option value='All Girls 12U'>All Girls 12U competitions, across all federations";
            print "<option value='All Girls 10U'>All Girls 10U competitions, across all federations";
            #print "<option value='All Girls 10Udb'>All Girls 10Udb competitions, across all federations";
            #print "<option value='All Girls 8U'>All Girls 8U competitions, across all federations";
            #print "<option value='All Girls 8Umb'>All Girls 8Umb competitions, across all federations";
            #print "<option value='All Girls 6Umb'>All Girls 6Umb competitions, across all federations";

            print "<option value='---------'>---------";	

            print "<option value='All Mixed 21U'>All Mixed 21U competitions, across all federations";			
            print "<option value='All Mixed 18U'>All Mixed 18U competitions, across all federations";
            print "<option value='All Mixed 16U'>All Mixed 16U competitions, across all federations";	
            print "<option value='All Mixed 14U'>All Mixed 14U competitions, across all federations";			
            print "<option value='All Mixed 12U'>All Mixed 12U competitions, across all federations";
            print "<option value='All Mixed 10U'>All Mixed 10U competitions, across all federations";
            #print "<option value='All Mixed 10Udb'>All Mixed 10Udb competitions, across all federations";
            #print "<option value='All Mixed 8U'>All Mixed 8U competitions, across all federations";
            #print "<option value='All Mixed 8Umb'>All Mixed 8Umb competitions, across all federations";
            #print "<option value='All Mixed 6Umb'>All Mixed 6Umb competitions, across all federations";
			
			
            print "<option value='---------'>---------";				
            print "<option value='All IRF'>All IRF Junior competitions, Boys and Girls";
            print "<option value='All USA'>All USA competitions, Boys and Girls";
            print "<option value='All Mexico'>All Mexican competitions, Boys and Girls";
            print "<option value='All Canada'>All Canadian competitions, Boys and Girls";
            print "<option value='---------'>---------";				
            print "<option value='All IRF Boys'>All IRF Junior competitions, Boys only";
            print "<option value='All USA Boys'>All USA competitions, Boys only";
            print "<option value='All Mexico Boys'>All Mexican competitions, Boys only";
            print "<option value='All Canada Boys'>All Canadian competitions, Boys only";
            print "<option value='---------'>---------";				
            print "<option value='All IRF Girls'>All IRF Junior competitions, Girls only";
            print "<option value='All USA Girls'>All USA competitions, Girls only";
            print "<option value='All Mexico Girls'>All Mexican competitions, Girls only";
            print "<option value='All Canada Girls'>All Canadian competitions, Girls only";
            print "<option value='---------'>---------";
            print "<option value='All IRF Mixed'>All IRF Junior competitions, Mixed only";
            print "<option value='All USA Mixed'>All USA competitions, Mixed only";
            print "<option value='All Mexico Mixed'>All Mexican competitions, Mixed only";
            print "<option value='All Canada Mixed'>All Canadian competitions, Mixed only";

            print "<option value='---------'>---------";			
            print "<option value='IRF Boys 21U'>IRF Boys 21U";
            print "<option value='IRF Boys 18U'>IRF Boys 18U";
            print "<option value='IRF Boys 16U'>IRF Boys 16U";
            print "<option value='IRF Boys 14U'>IRF Boys 14U";			
            print "<option value='IRF Boys 12U'>IRF Boys 12U";
            print "<option value='IRF Boys 10U'>IRF Boys 10U";			
            print "<option value='---------'>---------";	
            print "<option value='IRF Girls 21U'>IRF Girls 21U";
            print "<option value='IRF Girls 18U'>IRF Girls 18U";
            print "<option value='IRF Girls 16U'>IRF Girls 16U";
            print "<option value='IRF Girls 14U'>IRF Girls 14U";
			print "<option value='IRF Girls 12U'>IRF Girls 12U";
            print "<option value='IRF Girls 10U'>IRF Girls 10U";						
            print "<option value='---------'>---------";	
            print "<option value='IRF Mixed 21U'>IRF Mixed 21U";
            print "<option value='IRF Mixed 18U'>IRF Mixed 18U";
            print "<option value='IRF Mixed 16U'>IRF Mixed 16U";
            print "<option value='IRF Mixed 14U'>IRF Mixed 14U";
            print "<option value='IRF Mixed 12U'>IRF Mixed 12U";
            print "<option value='IRF Mixed 10U'>IRF Mixed 10U";
			
            print "<option value='---------'>---------";	
			
            print "<option value='USA Boys 21U'>USA Boys 21U";
            print "<option value='USA Boys 18U'>USA Boys 18U";
            print "<option value='USA Boys 16U'>USA Boys 16U";
            print "<option value='USA Boys 14U'>USA Boys 14U";			
            print "<option value='USA Boys 12U'>USA Boys 12U";			
            print "<option value='USA Boys 10U'>USA Boys 10U";			
            #print "<option value='USA Boys 10U Double Bounce'>USA Boys 10Udb";				
            #print "<option value='USA Boys 8U'>USA Boys 8U";	
            #print "<option value='USA Boys 8U Multi Bounce'>USA Boys 8Umb";	
            #print "<option value='USA Boys 6U Multi Bounce'>USA Boys 6Umb";				
            print "<option value='---------'>---------";				
            print "<option value='USA Girls 21U'>USA Girls 21U";
            print "<option value='USA Girls 18U'>USA Girls 18U";
            print "<option value='USA Girls 16U'>USA Girls 16U";
            print "<option value='USA Girls 14U'>USA Girls 14U";	
            print "<option value='USA Girls 12U'>USA Girls 12U";			
            print "<option value='USA Girls 10U'>USA Girls 10U";			
            #print "<option value='USA Girls 10U Double Bounce'>USA Girls 10Udb";				
            #print "<option value='USA Girls 8U'>USA Girls 8U";	
            #print "<option value='USA Girls 8U Multi Bounce'>USA Girls 8Umb";	
            #print "<option value='USA Girls 6U Multi Bounce'>USA Girls 6Umb";	
            print "<option value='---------'>---------";				
            print "<option value='USA Mixed 21U'>USA Mixed 21U";
            print "<option value='USA Mixed 18U'>USA Mixed 18U";
            print "<option value='USA Mixed 16U'>USA Mixed 16U";
            print "<option value='USA Mixed 14U'>USA Mixed 14U";	
            print "<option value='USA Mixed 12U'>USA Mixed 12U";			
            print "<option value='USA Mixed 10U'>USA Mixed 10U";			
            #print "<option value='USA Mixed 10U Double Bounce'>USA Mixed 10Udb";				
            #print "<option value='USA Mixed 8U'>USA Mixed 8U";	
            #print "<option value='USA Mixed 8U Multi Bounce'>USA Mixed 8Umb";	
            #print "<option value='USA Mixed 6U Multi Bounce'>USA Mixed 6Umb";		
            print "<option value='---------'>---------";	
			
            print "<option value='Mexico Boys 21U'>Mexico Boys 21U";
            print "<option value='Mexico Boys 18U'>Mexico Boys 18U";
            print "<option value='Mexico Boys 16U'>Mexico Boys 16U";
            print "<option value='Mexico Boys 14U'>Mexico Boys 14U";
            print "<option value='Mexico Boys 12U'>Mexico Boys 12U";
            print "<option value='Mexico Boys 10U'>Mexico Boys 10U";			
            print "<option value='---------'>---------";
            print "<option value='Mexico Girls 21U'>Mexico Girls 21U";
            print "<option value='Mexico Girls 18U'>Mexico Girls 18U";
            print "<option value='Mexico Girls 16U'>Mexico Girls 16U";
            print "<option value='Mexico Girls 14U'>Mexico Girls 14U";
            print "<option value='Mexico Girls 12U'>Mexico Girls 12U";
            print "<option value='Mexico Girls 10U'>Mexico Girls 10U";
			
            print "<option value='---------'>---------";				
            print "<option value='Canada Boys 21U'>Canada Boys 21U";
            print "<option value='Canada Boys 18U'>Canada Boys 18U";
            print "<option value='Canada Boys 16U'>Canada Boys 16U";
            print "<option value='Canada Boys 14U'>Canada Boys 14U";			
            print "<option value='Canada Boys 12U'>Canada Boys 12U";			
            print "<option value='Canada Boys 10U'>Canada Boys 10U";			
            #print "<option value='Canada Boys 10U Double Bounce'>Canada Boys 10Udb";				
            #print "<option value='Canada Boys 8U'>Canada Boys 8U";	
            #print "<option value='Canada Boys 8U Multi Bounce'>Canada Boys 8Umb";	
            #print "<option value='Canada Boys 6U Multi Bounce'>Canada Boys 6Umb";				
            print "<option value='---------'>---------";				
            print "<option value='Canada Girls 21U'>Canada Girls 21U";
            print "<option value='Canada Girls 18U'>Canada Girls 18U";
            print "<option value='Canada Girls 16U'>Canada Girls 16U";
            print "<option value='Canada Girls 14U'>Canada Girls 14U";			
            print "<option value='Canada Girls 12U'>Canada Girls 12U";			
            print "<option value='Canada Girls 10U'>Canada Girls 10U";			
            #print "<option value='Canada Girls 10U Double Bounce'>Canada Girls 10Udb";				
            #print "<option value='Canada Girls 8U'>Canada Girls 8U";	
            #print "<option value='Canada Girls 8U Multi Bounce'>Canada Girls 8Umb";	
            #print "<option value='Canada Girls 6U Multi Bounce'>Canada Girls 6Umb";				
			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category_doubles'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
		
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";		


         }

# 9/30/20: Pickleball categories; real simple: mens womens mixed         
        if ($form{'tour'} eq 'PPSdbls' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='Mens Doubles'>All Mens Doubles";
            print "<option value='Womens Doubles'>All Womens Doubles";
            print "<option value='Mixed Doubles'>All Mixed Doubles";	
            print "</select>\n";			

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='gsb_per_category_doubles'><b>Gold, Silver and Bronze Medalists per Category</b>: Top 3 finishers for each event per Category";	   	  
	

            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";				 
		 }
		 

		 
#-------------
# Doubles By Player
#-------------


         print "<hr>";

         if ($form{'tour'} eq 'PPSdbls') {
            print "You must select all three filters below or the Query will not work.  The query defaults to All Pro Data and Any Doubles results<p>";
         }
         print "Select from All Doubles Players: ";
         print "<select name=\"player\">";
         print "<option selected value=0>(none)";
         
        $sql = "select distinct winner_p1 as name from results_doubles 
	           union 
		       select distinct winner_p2 as name from results_doubles 
	           union
		       select distinct loser_p1 as name from results_doubles 
		       union 
	           select distinct loser_p2 as name from results_doubles
		       order by name;";  
   
         printf "$sql\n" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            $displayname=$name;
      
            # 9/5/07: discovered that apostrophes in names screws up print_results...
            if ($name =~ /\'/) {
               $name =~ s/\'/''/g;
            }
            #printf "name is $name, displayname is $displayname" if $debug;
            print "<option value=\"$name\">$displayname";
         }
         print "</select>";		

         # 8/17/24: putting in two new selectors to give downstream filtering.
         if ($form{'tour'} eq 'PPSdbls') {

            print " Select Tour filter: <select name=\"tour_filter\">";
            #print "<option selected value=0>(none)";
            print "<option selected value=\"Any Pro\">Any Pro Result";
            print "<option value=\"PPA\">PPA Data Only";
            print "<option value=\"APP\">APP Data Only";
            print "<option value=\"PPA and APP\">PPA and APP Data Only";
            print "<option value=\"MLP\">MLP Data Only";
            print "<option value=\"USAP\">USAP Nationals Data Only";
            print "<option value=\"USO\">US Open Data Only";
            print "<option value=\"NS\">Non Sanctioned Data Only";
            print "</select>\n";

            print " Select Doubles filter: <select name=\"doubles_filter\">";
            #print "<option selected value=0>(none)";
            print "<option selected value=\"All Doubles\">Any Doubles Data";
            print "<option value=\"Mens Doubles Only\">Mens Doubles Only";
            print "<option value=\"Womens Doubles Only\">Womens Doubles Only";
            print "<option value=\"Mixed Doubles Only\">Mixed Doubles Only";
            print "</select>\n";

         }

         print "<br>";
  

         print "<input type='radio' name='query' value='player_wl_dbls'><b>Player Overall W-L record</b>: This will list the player's Won-Lost record, overall and by season ";

         # 8/16/24: adding gender and mixed doubles filters
         # 8/17/24: obsoleting these with introduction of fitlers.
		 #if ($form{'tour'} eq 'PPSdbls') {
		 #   print "<br><input type='radio' name='query' value='player_wl_dbls_gender'><b>Player Overall W-L record, Gender Doubles Only</b>: This will list the player's Won-Lost record, overall and by season for Gender doubles only";
		 #   print "<br><input type='radio' name='query' value='player_wl_dbls_mixed'><b>Player Overall W-L record, Mixed Doubles Only</b>: This will list the player's Won-Lost record, overall and by season for Mixed doubles only";
         #}
  
		 print "<br><input type='radio' name='query' value='player_wl_bypartner'><b>Player W-L record by partner</b>: This will list the player's Won-Lost record, 
		 in the whole database grouped by partner";
		 
         if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls') {
		    print "<br><input type='radio' name='query' value='player_wl_us_open'><b>Player W-L record in US Open</b>: This will list the player's Won-Loss record just at the US Open";
		 }
		 
         print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  John Doe: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";	 
		 
         # 8/16/24: adding gender and mixed doubles filters
         # 8/18/24 backing them out with introduction of filters.
		 #if ($form{'tour'} eq 'PPSdbls') {
         #   print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically, Gender and Mixed</b>: This query will list every match that the player has in the doubles DB, earliest to latest/Ascending";
		 #	print "<br><input type='radio' name='query' value='player_history_gender'><b>Complete player match history chronologically, Gender Doubles Only</b>: This query will list every match that the player has in the doubles DB, earliest to latest/Ascending";
         #   print "<br><input type='radio' name='query' value='player_history_mixed'><b>Complete player match history chronologically, Mixed Doubles Only</b>: This query will list every match that the player has in the doubles DB, earliest to latest/Ascending";
         #   print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history, Gender and Mixed</b>: This query will list every match that the player has in the doubles DB, latest to earliest/Descending";
         #   print "<br><input type='radio' name='query' value='player_history_desc_gender'><b>Complete player match history, Gender Doubles Only</b>: This query will list every match that the player has in the doubles DB, latest to earliest/Descending";
         #   print "<br><input type='radio' name='query' value='player_history_desc_mixed'><b>Complete player match history, Mixed Doubles Only</b>: This query will list every match that the player has in the doubles DB, latest to earliest/Descending";   
         #}
		 #else {
         #   print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically</b>: This query will list every match that the player has in the DB, earliest to latest/Ascending";
         #   print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";
         #}

         print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically</b>: This query will list every match that the player has in the DB, earliest to latest/Ascending";
         print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";


 
		 if ($form{'tour'} eq 'WORdbls' || $form{'tour'} eq 'PPSdbls') {
		    # do nothing
         }
		 else {
		    print "<br><input type='radio' name='query' value='player_history_alltours'><b>Complete player match history, All tours</b>: This query will list every match that the player has across ALL tours, earliest to latest/Ascending";
            print "<br><input type='radio' name='query' value='player_history_us_open'><b>Complete player match history, US Open Only</b>: This query will list every match that the player has played at all US Opens";
         }       

# Doubles head-to-head queries
         print "<br><input type='radio' name='query' value='head_to_head'><b>Doubles Player Head-to-Head Record Alphabetically</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by player name";
         print "<br><input type='radio' name='query' value='head_to_head_ttl'><b>Doubles Player Head-to-Head Record Ordered by most Matchups</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by the number of times they've met from most to least";
         print "<br><input type='radio' name='query' value='head_to_head_3yr'><b>Doubles Player Head-to-Head Records in last 3 years </b>: To gauge more recent head-to-head records, this limits the search to the last three years for active players";      
         print "<br><input type='radio' name='query' value='nontriv_head_to_head'><b>Doubles Non-Trivial Player Head-to-Head Record</b>: This is head-to-head among the more regular tour members (eliminates all matchups where there have been less than 2 meetings)";
         print "<br><input type='radio' name='query' value='nontriv_head_to_head_withresults'><b>Doubles Non-Trivial Player Head-to-Head Records With Results</b>: Shows non-trivial head-to-head records for players on tour, with the results.";
  		 

         print "<br><input type='radio' name='query' value='donuts'><b>Donut Counts</b>: Given and received";
         print "<br><input type='radio' name='query' value='twinkies'><b>'Twinkie' Counts</b>: (11-1 or 1-11 games), Given and received (inspired by the IRT stats page)";
   
         
		 print "<br><input type='radio' name='query' value='all_titles'><b>All Titles</b>: Lists all Titles won by the player.";		 
		 
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";		
		 
		 
#-------------
# Doubles Misc tour stats
#-------------

         print "<hr>";
		 
         print "<p><input type='radio' name='query' value='all_finals'><b>All Finals</b>: This query will list all the finals of every tourney 
		 in the database";	
		 
         if ($form{'tour'} eq 'WORdbls') {
            print "<br><input type='radio' name='query' value='triple_crown_men'><b>Triple Crown Winners - Mens Doubles</b>: Winners of all 3 outdoor 'majors' by year, Mens Doubles";
            print "<br><input type='radio' name='query' value='triple_crown_women'><b>Triple Crown Winners - Womens Doubles</b>: Winners of all 3 outdoor 'majors' by year, Womens Doubles";
            print "<br><input type='radio' name='query' value='triple_crown_mixed'><b>Triple Crown Winners - Mixed Doubles</b>: Winners of all 3 outdoor 'majors' by year, Mixed Doubles";

         }			 
		 
		 if ($form{'tour'} eq 'PPSdbls') {
		    # do nothing; the season summary doesn't work yet for pickleball
         }
		 else {
            print "<br><input type='radio' name='query' value='season_summary_all'><b>Career Season Summaries</b>:  This will list the \"Season Summary\" career totals for all players in the database (15 second query).";		 	
         } 		 
		 
 
         if ($form{'tour'} eq 'IRFmatchdbls')  {
            print "<br><input type='radio' name='query' value='irf_tourney_summary_player'><b>IRF Tournament Summary by Player</b>: A list of the leading IRF tourney winners by player";
            print "<br><input type='radio' name='query' value='irf_tourney_summary_country'><b>IRF Tournament Summary by country</b>: A list of the leading IRF tourney winners by country";
         }
		 
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			 
		 
   	  
      } # if ($form{'tour'} eq Doubles): just limited doubles queries for now, may incorporate back in below later.







#--------------------------------------------------------------------------------------------------
# Singles Match Results
#--------------------------------------------------------------------------------------------------


#-------------
# Singles By Event
#-------------

# 10/11/17: created this huge if-then-else so that we could call different IRF queries
      if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' 
	   || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'WOR' || $form{'tour'} eq 'PPS') {
         print "<hr>";
   
         $sql = "select event,date,city,season,tour from results where round='2' order by tmp_date desc,event;"; 
   
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      

         print "<b>$tour Singles Match Results Data: Singles only match by match Results database</b><p>";
   
         print "Select Event: <select name=\"event\">";
         print "<option selected value=0>(none)";
         
         while (@row = $sth->fetchrow_array) {
            $event=$row[0];
            $date=$row[1];
            $city =$row[2];
            $season =$row[3];
            $tour=$row[4];
            print "<option value='$event~$date'>$season &nbsp $tour &nbsp $city &nbsp $event &nbsp ($date)";
         }
         print "</select>\n";

         # 8/16/24: splitting this out to change verbage on screen for PPS
         if ($form{'tour'} eq 'PPS') {
            print "<p><input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred 
		           at the tourney.  It will include Qualifying, Winners and Losers bracket, Points draws, and bonus draws. ";	   	  
         }
		 else { 	  
            print "<p><input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred at the tourney.  All known qualifiers are included. ";
		 }


         # 8/16/24: Putting in Main draw-only pickleball query that eliminates qualifiers, bonus draw results,  points draw results.
         if ($form{'tour'} eq 'PPS') {
            print "<br><input type='radio' name='query' value='all_matches_per_event_maindrawonly'><b>All matches per Event Main Draw Only</b>: Main/Winners bracket draw only.";	   	  
         }
        
         if ($form{'tour'} eq 'PPS') {
            print "<br><input type='radio' name='query' value='gsb_per_event'><b>Gold, Silver and Bronze Medalists per Event</b>: Top 3 finishers for an event";	   	  
         }
		 else {
            print "<br><input type='radio' name='query' value='qsf_per_event'><b>Quarters, Semis and Final per Event</b>: top 8 finishers for an event";	   	  
		 }		 


         print "<br><input type='radio' name='query' value='seed_report_per_event'><b>Seed Report per Event</b>: Lists the Seeding for an event.  Caveat; seeding only guaranteed to be populated from 2010 onwards.";
         print "<br><input type='radio' name='query' value='seed_upset_report_per_event'><b>Upsets by Seed Report per Event</b>: Lists all upsets by seeding for the event.  Caveat; seeding only guaranteed to be populated from 2010 onwards.";
        
         print "<br><input type='radio' name='query' value='draw_size_per_event'><b>Draw Size per Event</b>: Gives the size of the draw per Event.";
         print "<br><input type='radio' name='query' value='player_profiles_per_event'><b>Player Profiles for all Entrants</b>: Player Profile data for all tourney entrants, including age at the time of the event";		 	 
         print "<br><input type='radio' name='query' value='player_countries_per_event'><b>Player Country Breakdown for all Entrants</b>: Player Country Report for all entrants of this event";		 
         
		 if ($form{'tour'} eq 'IRFmatch') {
            print "<br><input type='radio' name='query' value='team_results'><b>Team Results per Event</b>: Prints out The team results (Men, Women, Combined)";	    
         }
		 
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";


#-------------
# Singles By Season/Year
#-------------
      
         print "<hr>";
   
         if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
            print "Select Year: ";
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "Select Season/Year: ";
         }
         else {
            print "Select Season: ";
         }
   
         print "<select name=\"season\">";
         print "<option selected value=0>(none)";
         
         $sql = "select distinct season from results order by season desc"; 
         
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            print "<option value='$name'>$name";
         }
         print "</select>\n";
         printf "<br>$sql\n" if $debug;
      
         if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR'|| $form{'tour'} eq 'WOR') {
            print "<p><input type='radio' name='query' value='finals_per_season'><b>Finals by Year</b>: This query will list the finals of every tourney for the selected year";
            print "<br><input type='radio' name='query' value='qsf_per_season'><b>Quarters, Semis, Final by Year</b>: Quarters, Semis and Finals for a Year";
         }
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'PPS') {
            print "<p><input type='radio' name='query' value='finals_per_season'><b>Finals by Season</b>: This query will list the finals of every tourney for the selected season";

            if ($form{'tour'} eq 'PPS') {
               print "<br><input type='radio' name='query' value='gsb_per_season'><b>Gold, Silver and Bronze Medalists per Season</b>: Top 3 finishers for each event for the season";	   	  
            }
		    else {
               print "<br><input type='radio' name='query' value='qsf_per_season'><b>Quarters, Semis and Final per Season</b>: top 8 finishers in each event for the season";	   	  
		    }					 
		 
            #print "<br><input type='radio' name='query' value='all_matches_per_season'><b>All Matches Per Season</b>: Lists All the matches for an entire Season";            
			print "<br><input type='radio' name='query' value='distinct_winners'><b>Distinct Winners per Season</b>: Number of distinct Tourney winners in a season";
            print "<br><input type='radio' name='query' value='season_ending_rankings'><b>Season-Ending Rankings</b>: Season Ending Rankings per season";
            print "<br><input type='radio' name='query' value='season_summary_allplayers'><b>Season Summaries for all Players</b>:  This will list the \"Season Summary\" totals for all players who appeared in a season.";
      
            print "<br><input type='radio' name='query' value='statistical_abstract_byseason'><b>Statistical Abstract Stats for the Season</b>: Evan Prichard's Statistical Abstracts (<b>beta</b>)";
      
            print "<br><input type='radio' name='query' value='highest_seeds'><b>Highest Seeds to...</b>: Highest Seeds to win, make a final, etc.  
			Data for the chosen season only (see below for same report for the whole database). Fyi: Seeding data only guaranteed to be available 
			starting with the 2010-11 season; data is spotty prior to that.";   
 
			}

		 
         print "<br><input type='radio' name='query' value='draw_size_per_season'><b>Draw Size per Event for Season</b>: Gives the size of the draw in all events for the Season.";
		 
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {      
            print "<br><input type='radio' name='query' value='season_seed_report'><b>Season Seed Report</b>: Lists all the leading players and their seed per event for a season. Fyi: Seeding data only available starting with the 2010-11 season";
         }
		 print "<br><input type='radio' name='query' value='player_profiles_per_season'><b>Player Profiles for All Players per Season</b>: Player Profile data for all tourney entrants, including age at the time of the event, for any player who appeared in a season";		 
         print "<br><input type='radio' name='query' value='player_countries_per_season'><b>Player Country Breakdown for players per Season</b>: Player Country Report for all players this season";		 

      
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";



#-------------
# Singles By Tourney Category for Amateur/IRF/Junior/WOR/Pickleball events
#-------------


         if ($form{'tour'} eq 'AMATEUR' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='USA Mens Open'>USA Mens Open - Nationals only";
            print "<option value='USA Womens Open'>USA Womens Open - Nationals only";
            print "<option value='Mexico Mens Open'>Mexico Mens Open - Nationals only";
            print "<option value='Mexico Womens Open'>Mexico Womens Open - Nationals only";
            print "<option value='Canada Mens Open'>Canada Mens Open - Nationals only";
            print "<option value='Canada Womens Open'>Canada Womens Open - Nationals only";
            print "<option value='---------'>---------";					
            print "<option value='USA Mens Open All'>USA Mens Open - Nationals and Qualifiers";
            print "<option value='USA Womens Open All'>USA Womens Open - Nationals and Qualifiers";
            print "<option value='Mexico Mens Open All'>Mexico Mens Open - Nationals and Qualifiers";
            print "<option value='Mexico Womens Open All'>Mexico Womens Open - Nationals and Qualifiers";
            print "<option value='Canada Mens Open All'>Canada Mens Open - Nationals and Qualifiers";
            print "<option value='Canada Womens Open All'>Canada Womens Open - Nationals and Qualifiers";
            print "<option value='---------'>---------";		
            print "<option value='USA Mens Open Qual'>USA Mens Open - Qualifiers Only";
            print "<option value='USA Womens Open Qual'>USA Womens Open - Qualifiers Only";
            print "<option value='Mexico Mens Open Qual'>Mexico Mens Open - Qualifiers Only";
            print "<option value='Mexico Womens Open Qual'>Mexico Womens Open - Qualifiers Only";
            print "<option value='Canada Mens Open Qual'>Canada Mens Open - Qualifiers Only";
            print "<option value='Canada Womens Open Qual'>Canada Womens Open - Qualifiers Only";
            print "<option value='---------'>---------";					
            print "<option value='USA All'>All USA Mens and Womens Events";
            print "<option value='Mexico All'>All Mexico Mens and Womens Events";		
            print "<option value='Canada All'>All Canadian Mens and Womens Events";
            print "<option value='All Men'>All Mens Events for all Countries";
            print "<option value='All Women'>All Womens Events for all Countries";		

            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";
            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
            print "<br><input type='radio' name='query' value='age_of_winner'><b>Age of Winners</b>: Prints the age of the winner at the time of the event";
				
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }
		 
	   if ($form{'tour'} eq 'IRFmatch' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='IRF All Men'>All Mens Open, across IRF events";
            print "<option value='IRF All Women'>All Womens Open, across IRF events";
            print "<option value='---------'>---------";				
			print "<option value='All Majors - Mens Open'>All Majors (Worlds, Pan Ams) Mens Open";
			print "<option value='All Majors - Womens Open'>All Majors (Worlds, Pan Ams) Womens Open";
			print "<option value='All NonMajors - Mens Open'>All Non-Majors (Continental championships) Mens Open";
			print "<option value='All NonMajors - Womens Open'>All Non-Majors (Continental championships) Womens Open";		
            print "<option value='---------'>---------";				
            print "<option value='World Championships - Mens Open'>World Championships Mens Open";
            print "<option value='World Championships - Womens Open'>World Championships Womens Open";
            print "<option value='---------'>---------";				
            print "<option value='Pan American Championships - Mens Open'>Pan American Championships/Tournament of the Americas Mens Open";
            print "<option value='Pan American Championships - Womens Open'>Pan American Championships/Tournament of the Americas Womens Open";
            print "<option value='---------'>---------";				
			print "<option value='Pan American Games - Mens Open'>Pan American Games Mens Open";
            print "<option value='Pan American Games - Womens Open'>Pan American Games Womens Open";
			print "<option value='Pan American Sports Festival - Mens Open'>Pan American Sports Festival Mens Open";
            print "<option value='Pan American Sports Festival - Womens Open'>Pan American Sports Festival Womens Open";
			print "<option value='World Games - Mens Open'>World Games Mens Open";
            print "<option value='World Games - Womens Open'>World Games Womens Open";
            print "<option value='---------'>---------";				
			print "<option value='South American Games - Mens Open'>South American Games Mens Open";
			print "<option value='South American Games - Womens Open'>South American Games Womens Open";
			print "<option value='Bolivarian Games - Mens Open'>Bolivarian Games Mens Open";
			print "<option value='Bolivarian Games - Womens Open'>Bolivarian Games Womens Open";
			print "<option value='Central American Caribbean Games - Mens Open'>Central American Caribbean Games Mens Open";
			print "<option value='Central American Caribbean Games - Womens Open'>Central American Caribbean Games Womens Open";
			print "<option value='Central American Games - Mens Open'>Central American Games Mens Open";
			print "<option value='Central American Games - Womens Open'>Central American Games Womens Open";

			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
			print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
         }

         # 6/27/22: added in 21U divisions everywhere here
         if ($form{'tour'} eq 'JUNIOR' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";

            print "<option value='All Boys 21U'>All Boys 21U competitions, across all federations";
            print "<option value='All Boys 18U'>All Boys 18U competitions, across all federations";
            print "<option value='All Boys 16U'>All Boys 16U competitions, across all federations";
            print "<option value='All Boys 14U'>All Boys 14U competitions, across all federations";			
            print "<option value='All Boys 12U'>All Boys 12U competitions, across all federations";
            print "<option value='All Boys 10U'>All Boys 10U competitions, across all federations";
            print "<option value='All Boys 10Udb'>All Boys 10Udb competitions, across all federations";
            print "<option value='All Boys 8U'>All Boys 8U competitions, across all federations";
            print "<option value='All Boys 8Umb'>All Boys 8Umb competitions, across all federations";
            print "<option value='All Boys 6Umb'>All Boys 6Umb competitions, across all federations";
			
            print "<option value='---------'>---------";	
			
            print "<option value='All Girls 21U'>All Girls 21U competitions, across all federations";
            print "<option value='All Girls 18U'>All Girls 18U competitions, across all federations";
            print "<option value='All Girls 16U'>All Girls 16U competitions, across all federations";	
            print "<option value='All Girls 14U'>All Girls 14U competitions, across all federations";			
            print "<option value='All Girls 12U'>All Girls 12U competitions, across all federations";
            print "<option value='All Girls 10U'>All Girls 10U competitions, across all federations";
            print "<option value='All Girls 10Udb'>All Girls 10Udb competitions, across all federations";
            print "<option value='All Girls 8U'>All Girls 8U competitions, across all federations";
            print "<option value='All Girls 8Umb'>All Girls 8Umb competitions, across all federations";
            print "<option value='All Girls 6Umb'>All Girls 6Umb competitions, across all federations";
			
            print "<option value='---------'>---------";				
            print "<option value='All IRF'>All IRF Junior competitions, Boys and Girls";
            print "<option value='All USA'>All USA competitions, Boys and Girls";
            print "<option value='All Mexico'>All Mexican competitions, Boys and Girls";
            print "<option value='All Canada'>All Canadian competitions, Boys and Girls";
            print "<option value='---------'>---------";				
            print "<option value='All IRF Boys'>All IRF Junior competitions, Boys only";
            print "<option value='All USA Boys'>All USA competitions, Boys only";
            print "<option value='All Mexico Boys'>All Mexican competitions, Boys only";
            print "<option value='All Canada Boys'>All Canadian competitions, Boys only";
            print "<option value='---------'>---------";				
            print "<option value='All IRF Girls'>All IRF Junior competitions, Girls only";
            print "<option value='All USA Girls'>All USA competitions, Girls only";
            print "<option value='All Mexico Girls'>All Mexican competitions, Girls only";
            print "<option value='All Canada Girls'>All Canadian competitions, Girls only";
            print "<option value='---------'>---------";	
			
            print "<option value='IRF Boys 21U'>IRF Boys 21U";
            print "<option value='IRF Boys 18U'>IRF Boys 18U";
            print "<option value='IRF Boys 16U'>IRF Boys 16U";
            print "<option value='IRF Boys 14U'>IRF Boys 14U";
            print "<option value='IRF Boys 12U'>IRF Boys 12U";
            print "<option value='IRF Boys 10U'>IRF Boys 10U";
            print "<option value='IRF Girls 21U'>IRF Girls 121U";
            print "<option value='IRF Girls 18U'>IRF Girls 18U";
            print "<option value='IRF Girls 16U'>IRF Girls 16U";
            print "<option value='IRF Girls 14U'>IRF Girls 14U";
            print "<option value='IRF Girls 12U'>IRF Girls 12U";
            print "<option value='IRF Girls 10U'>IRF Girls 10U";

            print "<option value='---------'>---------";				
            print "<option value='USA Boys 21U'>USA Boys 21U";
            print "<option value='USA Boys 18U'>USA Boys 18U";
            print "<option value='USA Boys 16U'>USA Boys 16U";
            print "<option value='USA Boys 14U'>USA Boys 14U";			
            print "<option value='USA Boys 12U'>USA Boys 12U";			
            print "<option value='USA Boys 10U'>USA Boys 10U";			
            print "<option value='USA Boys 10Udb'>USA Boys 10U Double Bounce";				
            print "<option value='USA Boys 8U'>USA Boys 8U";	
            print "<option value='USA Boys 8Umb'>USA Boys 8U Multi Bounce";	
            print "<option value='USA Boys 6Umb'>USA Boys 6U Multi Bounce";				
            print "<option value='---------'>---------";				
            print "<option value='USA Girls 21U'>USA Girls 21U";
            print "<option value='USA Girls 18U'>USA Girls 18U";
            print "<option value='USA Girls 16U'>USA Girls 16U";
            print "<option value='USA Girls 14U'>USA Girls 14U";	
            print "<option value='USA Girls 12U'>USA Girls 12U";			
            print "<option value='USA Girls 10U'>USA Girls 10U";			
            print "<option value='USA Girls 10Udb'>USA Girls 10U Double Bounce";				
            print "<option value='USA Girls 8U'>USA Girls 8U";	
            print "<option value='USA Girls 8Umb'>USA Girls 8U Multi Bounce";	
            print "<option value='USA Girls 6Umb'>USA Girls 6U Multi Bounce";		
            print "<option value='---------'>---------";				
            print "<option value='Mexico Boys 21U'>Mexico Boys 21U";
            print "<option value='Mexico Boys 18U'>Mexico Boys 18U";
            print "<option value='Mexico Boys 16U'>Mexico Boys 16U";
            print "<option value='Mexico Boys 14U'>Mexico Boys 14U";
            print "<option value='Mexico Boys 12U'>Mexico Boys 12U";
            print "<option value='Mexico Boys 10U'>Mexico Boys 10U";
            print "<option value='Mexico Girls 21U'>Mexico Girls 21U";
            print "<option value='Mexico Girls 18U'>Mexico Girls 18U";
            print "<option value='Mexico Girls 16U'>Mexico Girls 16U";
            print "<option value='Mexico Girls 14U'>Mexico Girls 14U";
            print "<option value='Mexico Girls 12U'>Mexico Girls 12U";
            print "<option value='Mexico Girls 10U'>Mexico Girls 10U";
            print "<option value='---------'>---------";				
            print "<option value='Canada Boys 21U'>Canada Boys 21U";
            print "<option value='Canada Boys 18U'>Canada Boys 18U";
            print "<option value='Canada Boys 16U'>Canada Boys 16U";
            print "<option value='Canada Boys 14U'>Canada Boys 14U";			
            print "<option value='Canada Boys 12U'>Canada Boys 12U";			
            print "<option value='Canada Boys 10U'>Canada Boys 10U";			
            print "<option value='Canada Boys 10Udb'>Canada Boys 10U Double Bounce";				
            print "<option value='Canada Boys 8U'>Canada Boys 8U";	
            print "<option value='Canada Boys 8Umb'>Canada Boys 8U Multi Bounce";	
            print "<option value='Canada Boys 6Umb'>Canada Boys 6U Multi Bounce";				
            print "<option value='---------'>---------";				
            print "<option value='Canada Girls 21U'>Canada Girls 21U";
            print "<option value='Canada Girls 18U'>Canada Girls 18U";
            print "<option value='Canada Girls 16U'>Canada Girls 16U";
            print "<option value='Canada Girls 14U'>Canada Girls 14U";			
            print "<option value='Canada Girls 12U'>Canada Girls 12U";			
            print "<option value='Canada Girls 10U'>Canada Girls 10U";			
            print "<option value='Canada Girls 10Udb'>Canada Girls 10U Double Bounce";				
            print "<option value='Canada Girls 8U'>Canada Girls 8U";	
            print "<option value='Canada Girls 8Umb'>Canada Girls 8U Multi Bounce";	
            print "<option value='Canada Girls 6Umb'>Canada Girls 6U Multi Bounce";				
			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
		
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }	
		 
		 
		# WOR Singles categories: adding 5/9/19
		# These are similar to the WOR doubles categories above.

        if ($form{'tour'} eq 'WOR' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='Mens Singles'>All Mens Singles";
            print "<option value='Womens Singles'>All Womens Singles";

            print "<option value='One Wall'>One Wall Only";
            print "<option value='Three Wall'>Three Wall Only";
			
            print "<option value='One Wall Mens'>One Wall only, Mens Only";
            print "<option value='One Wall Womens'>One Wall only, Womens Only";			
				
            print "<option value='Three Wall Mens'>Three Wall Only, Mens Only";
            print "<option value='Three Wall Womens'>Three Wall Only, Womens Only";			

			
			# this was "california" but changed to Outdoor nationals
            print "<option value='Outdoor Nationals'>Just Huntington Beach Outdoor Championships (Men and Women)";	
            print "<option value='Outdoor Nationals Mens'>Huntington Beach Outdoor Championships, Mens Only";
            print "<option value='Outdoor Nationals Womens'>Huntington Beach Outdoor Championships Womens Only";
			
            print "<option value='Beach Bash'>All Florida Beach Bash One Wall Championships (Mens and Womens)";
            print "<option value='Beach Bash Mens'>Florida Beach Bash One Wall Championships Mens Only";
            print "<option value='Beach Bash Womens'>Just Florida Beach Bash One Wall Championships Womens Only";			
		
			
			print "<option value='Vegas'>All Las Vegas 3WallBall Championships Events (One-Wall and Three-Wall, Mens and Women)";    
			print "<option value='Vegas All 3Wall'>All Las Vegas 3WallBall Three Wall Championships Events (Mens, Womens)";     
			print "<option value='Vegas All 1Wall'>All Las Vegas 3WallBall One Wall Championships Events (Mens, Womens)";  
			print "<option value='Vegas 3Wall Mens'>Las Vegas 3WallBall Three Wall Championships Events, Mens Only";  			
			print "<option value='Vegas 3Wall Womens'>Las Vegas 3WallBall Three Wall Championships Events, Womens Only";  
			# no one-wall singles offered at 3WallBall; doubles only.  
			#print "<option value='Vegas 1Wall Mens'>Las Vegas 3WallBall One Wall Championships Events, Mens Only";
			#print "<option value='Vegas 1Wall Womens'>Las Vegas 3WallBall One Wall Championships Events, Womens Only";

			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }		 

		 
		 
# putting in second high level pull-down to get Junior Matrix values.		 
         if ($form{'tour'} eq 'JUNIOR' ) {
            print "<hr>";
   
            print "Select Category for All Results Matrix: ";

            print "<select name=\"category2\">";
            print "<option selected value=0>(none)";	
			
            print "<option value='All IRF Boys'>All IRF Junior competitions, Boys only";
            print "<option value='All USA Boys'>All USA competitions, Boys only";
            print "<option value='All Mexico Boys'>All Mexican competitions, Boys only";
            print "<option value='All Canada Boys'>All Canadian competitions, Boys only";
            print "<option value='---------'>---------";				
            print "<option value='All IRF Girls'>All IRF Junior competitions, Girls only";
            print "<option value='All USA Girls'>All USA competitions, Girls only";
            print "<option value='All Mexico Girls'>All Mexican competitions, Girls only";
            print "<option value='All Canada Girls'>All Canadian competitions, Girls only";			

            print "</select>\n";
			
            print "<br><input type='radio' name='query' value='all_winners_junior_matrix'><b>Matrix of All Winners, all Years</b>: Gives a quick Matrix of all winners, all years for specific categories";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";					
         }

# putting in second high level pull-down to get IRFMatch team	
# 12/29/18: removing Juniors from IRFmatch, commenting out here will include later
 
         if ($form{'tour'} eq 'IRFmatch' ) {
            print "<hr>";
   
            print "Select Team Category: ";

            print "<select name=\"category2\">";
            print "<option selected value=0>(none)";	

            print "<option value='All Team Results'>All Team Results, all competitions";
            print "<option value='---------'>---------";			
            #print "<option value='All Combined Team'>All IRF Team Competitions, Combined Adults and Juniors";
            print "<option value='All Combined Adult Team'>All IRF Adult Competitions, Combined Team Results";
            #print "<option value='All Combined Junior Team'>All IRF Junior Competitions, Combined Team Results";
            #print "<option value='---------'>---------";		
            #print "<option value='All Male Team'>All IRF Competitions, Men or Boys, Adult and Junior";
            print "<option value='All Men Team'>All IRF Competitions, Adult Men Team only";
            #print "<option value='All Boys Team'>All IRF Junior Competitions, Junior Boys Team only";	
            #print "<option value='---------'>---------";					
            #print "<option value='All Female Team'>All IRF Competitions, Women or Girls, Adult and Junior";	
            print "<option value='All Women Team'>All IRF Competitions, Adult Women Team only";			
            #print "<option value='All Girls Team'>All IRF Junior Competitions, Junior Girls Team only";			
            print "<option value='---------'>---------";	
            print "<option value='All Combined Team Worlds'>World Championships, Combined Team only";
            print "<option value='All Men Team Worlds'>World Championships, Adult Men Team only";
            print "<option value='All Women Team Worlds'>World Championships, Adult Women Team only";
            print "<option value='---------'>---------";	
            print "<option value='All Combined Team PARC'>Pan American Championships/Tournament of the Americas, Combined Team only";
            print "<option value='All Men Team PARC'>Pan American Championships/Tournament of the Americas, Adult Men Team only";
            print "<option value='All Women Team PARC'>Pan American Championships/Tournament of the Americas, Adult Women Team only";
            print "<option value='---------'>---------";				
			print "<option value='All Combined Team PanAm'>Pan American Games Combined Team";
			print "<option value='All Men Team PanAm'>Pan American Games Adult Men Team";
            print "<option value='All Women Team PanAm'>Pan American Games Adult Women Team";
			
			print "<option value='Pan American Sports Festival - Combined'>Pan American Sports Festival Combined Team";
			print "<option value='Pan American Sports Festival - Mens Team'>Pan American Sports Festival Mens Team";
            print "<option value='Pan American Sports Festival - Womens Team'>Pan American Sports Festival Womens Team";
			print "<option value='World Games - Conbined'>World Games Combined Team";
			print "<option value='World Games - Mens Team'>World Games Mens Team";
            print "<option value='World Games - Womens Team'>World Games Womens Team";
            print "<option value='---------'>---------";				
			print "<option value='South American Games - Combined'>South American Games Combined Team";			
			print "<option value='South American Games - Mens Team'>South American Games Mens Team";
			print "<option value='South American Games - Womens Team'>South American Games Womens Team";
			print "<option value='Bolivarian Games - Combined'>Bolivarian Games Combined Team";
			print "<option value='Bolivarian Games - Mens Team'>Bolivarian Games Mens Team";
			print "<option value='Bolivarian Games - Womens Team'>Bolivarian Games Womens Team";
			print "<option value='Central American Caribbean Games - Combined'>Central American Caribbean Games Combined Team";
			print "<option value='Central American Caribbean Games - Mens Team'>Central American Caribbean Games Mens Team";
			print "<option value='Central American Caribbean Games - Womens Team'>Central American Caribbean Games Womens Team";
			print "<option value='Central American Games - Combined'>Central American Games Combined Team";
			print "<option value='Central American Games - Mens Team'>Central American Games Mens Team";
			print "<option value='Central American Games - Womens Team'>Central American Games Womens Team";			
	

            print "</select>\n";
			
            print "<br><input type='radio' name='query' value='all_team_winners'><b>All Team Winners</b>: Just Team winners per category through out time.";		
            print "<br><input type='radio' name='query' value='most_team_winners'><b>Most Team Winners</b>: Lists the most Team Winners per category in order.";		
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";					
         }
		 
# 12/31/18: separate section for Matrix queries since they don't work for the "All" categories above

         if ($form{'tour'} eq 'IRFmatch' ) {
            print "<hr>";
   
            print "Select Team Category for Matrix Report: ";

            print "<select name=\"category3\">";
            print "<option selected value=0>(none)";	

            print "<option value='All Combined Team Worlds'>World Championships, Combined Team only";
            print "<option value='All Men Team Worlds'>World Championships, Adult Men Team only";
            print "<option value='All Women Team Worlds'>World Championships, Adult Women Team only";
            print "<option value='---------'>---------";	
            print "<option value='All Combined Team PARC'>Pan American Championships/Tournament of the Americas, Combined Team only";
            print "<option value='All Men Team PARC'>Pan American Championships/Tournament of the Americas, Adult Men Team only";
            print "<option value='All Women Team PARC'>Pan American Championships/Tournament of the Americas, Adult Women Team only";
            print "<option value='---------'>---------";				
			print "<option value='All Combined Team PanAm'>Pan American Games Combined Team";
			print "<option value='All Men Team PanAm'>Pan American Games Adult Men Team";
            print "<option value='All Women Team PanAm'>Pan American Games Adult Women Team";
            print "<option value='---------'>---------";				
			print "<option value='Pan American Sports Festival - Combined'>Pan American Sports Festival Combined Team";
			print "<option value='Pan American Sports Festival - Mens Team'>Pan American Sports Festival Mens Team";
            print "<option value='Pan American Sports Festival - Womens Team'>Pan American Sports Festival Womens Team";
			print "<option value='World Games - Conbined'>World Games Combined Team";
			print "<option value='World Games - Mens Team'>World Games Mens Team";
            print "<option value='World Games - Womens Team'>World Games Womens Team";
            print "<option value='---------'>---------";				
			print "<option value='South American Games - Combined'>South American Games Combined Team";			
			print "<option value='South American Games - Mens Team'>South American Games Mens Team";
			print "<option value='South American Games - Womens Team'>South American Games Womens Team";
			print "<option value='Bolivarian Games - Combined'>Bolivarian Games Combined Team";
			print "<option value='Bolivarian Games - Mens Team'>Bolivarian Games Mens Team";
			print "<option value='Bolivarian Games - Womens Team'>Bolivarian Games Womens Team";
			print "<option value='Central American Caribbean Games - Combined'>Central American Caribbean Games Combined Team";
			print "<option value='Central American Caribbean Games - Mens Team'>Central American Caribbean Games Mens Team";
			print "<option value='Central American Caribbean Games - Womens Team'>Central American Caribbean Games Womens Team";
			print "<option value='Central American Games - Combined'>Central American Games Combined Team";
			print "<option value='Central American Games - Mens Team'>Central American Games Mens Team";
			print "<option value='Central American Games - Womens Team'>Central American Games Womens Team";			
	
            print "</select>\n";
			
            print "<br><input type='radio' name='query' value='all_irf_team_matrix'><b>Full Team Results Matrix</b>: All known Team Finishers per category through out time.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";					
         }
		 
# putting in second high level pull-down to	 get IRFMatch team	 
         if ($form{'tour'} eq 'IRFmatch' ) {
            print "<hr>";
   
            print "Select Country: ";

            print "<select name=\"country\">";
            print "<option selected value=0>(none)";
			
			# consider hard coding 3-4 most popular countries here?
         
            $sql = "select distinct(country) from team_results order by 1;";         
  
            printf "$sql\n" if $debug;
            $sth = $dbh->prepare($sql);
            $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
            while (@row = $sth->fetchrow_array) {
               $name=$row[0];
               $displayname=$name;
      
               # 9/5/07: discovered that apostrophes in names screws up print_results...
               if ($name =~ /\'/) {
                  $name =~ s/\'/''/g;
               }
               #printf "name is $name, displayname is $displayname" if $debug;
               print "<option value=\"$name\">$displayname";
            }
            print "</select>\n";
			
            print "<br><input type='radio' name='query' value='all_team_results'><b>All Country Results</b>: Lists all TEAM Results for each country in the database by Category (Combined, Men, Women)";			
            print "<br><input type='radio' name='query' value='team_country_best_finish'><b>Best Country Finish</b>: Best ever IRF TEAM finish for the Country in each Category (Combined, Men, Women)";
            print "<br><input type='radio' name='query' value='country_individual_results'><b>Country Individual Results</b>: IRF Country Individual Result summary per Event; this shows how the country's participants in Singles and Doubles fared per event with an average result";
			
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";					
         }		 

		# Pickleball Singles categories: adding 9/30/20
        if ($form{'tour'} eq 'PPS' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='Mens Singles'>All Mens Singles";
            print "<option value='Womens Singles'>All Womens Singles";

            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='gsb_per_category'><b>Gold, Silver and Bronze Medalists per Category</b>: Top 3 finishers for each event per Category";	   	  
			
            #print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }		 

		 
#-------------
# Singles By Player
#-------------

         print "<hr>";

         if ($form{'tour'} eq 'PPS') {
            print "You must select all both the player and the tour filter or the Query will not work.  The query defaults to All Pro Data.<p>";
         }
         print "Select from All Players: ";
         print "<select name=\"player\">";
         print "<option selected value=0>(none)";
         
         $sql = "select distinct winner as name from results \
                    union \
                    select distinct loser as name from results order by name";         
  
   
         printf "$sql\n" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            $displayname=$name;
      
            # 9/5/07: discovered that apostrophes in names screws up print_results...
            if ($name =~ /\'/) {
               $name =~ s/\'/''/g;
            }
            #printf "name is $name, displayname is $displayname" if $debug;
            print "<option value=\"$name\">$displayname";
         }
         print "</select>\n";

         # 8/22/24: putting in two new selectors to give downstream filtering. 
         if ($form{'tour'} eq 'PPS') {

            print " Select Tour filter: <select name=\"tour_filter\">";
            #print "<option selected value=0>(none)";
            print "<option selected value=\"Any Pro\">Any Pro Result";
            print "<option value=\"PPA\">PPA Data Only";
            print "<option value=\"APP\">APP Data Only";
            print "<option value=\"PPA and APP\">PPA and APP Data Only";
            print "<option value=\"MLP\">MLP Data Only";
            print "<option value=\"USAP\">USAP Nationals Data Only";
            print "<option value=\"USO\">US Open Data Only";
            print "<option value=\"NS\">Non Sanctioned Data Only";
            print "</select>\n";
         }

         # 8/22/24: making the historical and current season player just for Rball for now.
         unless ($form{'tour'} eq 'PPS') {
            print "or Select Historical tour player: <select name=\"player2\">";
            print "<option selected value=0>(none)";
      
            if ($form{'tour'} eq 'IRT') {
               $sql = "select winner from wins where wins > 50 order by winner";
            }
            elsif ($form{'tour'} eq 'LPRT') {
               $sql = "select winner from wins where wins > 30 order by winner";
            }
            elsif ($form{'tour'} eq 'WRT') {
               $sql = "select winner from wins where wins > 15 order by winner";
            }
            elsif ($form{'tour'} eq 'IRFmatch') {
               $sql = "select winner from wins where wins > 5 order by winner";
            }
            elsif ($form{'tour'} eq 'AMATEUR') {
               $sql = "select winner from wins where wins > 5 order by winner";
             }
            elsif ($form{'tour'} eq 'JUNIOR') {
               $sql = "select winner from wins where wins > 9 order by winner";
            }
            elsif ($form{'tour'} eq 'WOR') {
               $sql = "select winner from wins where wins > 5 order by winner";
            }   
            elsif ($form{'tour'} eq 'PPS') {
               $sql = "select winner from wins where wins > 0 order by winner";
            }  
            else {
               printf "Invalid Tour selected; you should never get here";
            }	 
		 
            printf "<br>$sql\n" if $debug;       
            $sth = $dbh->prepare($sql);
            $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
            while (@row = $sth->fetchrow_array) {
               $name=$row[0];
               $displayname=$name;
      
               # 9/5/07: discovered that apostrophes in names screws up print_results...
               if ($name =~ /\'/) {
                  $name =~ s/\'/''/g;
               }
               #printf "name is $name, displayname is $displayname" if $debug;
               print "<option value=\"$name\">$displayname";
            }
            print "</select>\n";	
 
            # 10/31/19: adding in current season players. 
		 
            print "or Select Current Season tour player: <select name=\"player3\">";
            print "<option selected value=0>(none)";		

            $sql = "select distinct winner as name from results where season='$current_season'
		            union
		            select distinct loser as name from results where season='$current_season'
		            order by name;"; 
  
            printf "$sql\n" if $debug;
            $sth = $dbh->prepare($sql);
            $sth->execute or print "SQL execute failed, Error from DB is: $DBI::errstr<br>";;
      
            while (@row = $sth->fetchrow_array) {
               $name=$row[0];
               $displayname=$name;
      
               # 9/5/07: discovered that apostrophes in names screws up print_results...
               if ($name =~ /\'/) {
                  $name =~ s/\'/''/g;
               }
               #printf "name is $name, displayname is $displayname" if $debug;
               print "<option value=\"$name\">$displayname";
            }
            print "</select>\n";
		 
            print "<br>Choose (none) for the non-selected player pulldowns. ";
    
            if ($form{'tour'} eq 'IRT') {
               print "Historical tour player defined as having more than 50 wins ever on tour.  ";
            }
            elsif ($form{'tour'} eq 'LPRT') {
               print "Historical tour player defined as having more than 30 wins ever on tour.  ";
            }
            elsif ($form{'tour'} eq 'WRT') {
               print "Historical tour player defined as having more than 15 wins ever on tour.  ";
            }
            elsif ($form{'tour'} eq 'IRFmatch') {
               print "Historical Intl player defined as having more than 3 wins ever in all International events.  ";
            }
            elsif ($form{'tour'} eq 'AMATEUR') {
               print "Historical Nationals player defined as having more than 5 wins ever in all Amateur events.  ";
            }
            elsif ($form{'tour'} eq 'JUNIOR') {
               print "Historical Junior Nationals player defined as having more than 10 wins in all Junior competitions.  ";
            }	
            elsif ($form{'tour'} eq 'WOR') {
               print "Historical WOR player defined as having more than 5 wins in all Outdoor competitions.  ";
            }
            # 8/20/24 commenting this out as not used for PPS/pickleball right now	 
            #elsif ($form{'tour'} eq 'PPS') {
            #   print "Historical PPS player defined as having more than 0 wins in all competitions.  ";
            #}
            else {
               printf "Invalid Tour selected; you should never get here";
            }
		 
            #printf "Current season is any player who has appeared this season. <br>";
            printf "If more than one player is selected, the left-most player is passed to the report.<br>";		 

		 # end of if clause for the multiple pull downs
         }
		 
         if ($form{'tour'} eq 'IRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Cliff Swain: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Paola Longoria: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Alejandro Cardona: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'PPS') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Ben Johns: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'WOR') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Rocky Carson: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }

         print "<br><input type='radio' name='query' value='player_profile_individual'><b>Player Profile</b>: Player Profile Information: picture, Demographics, Social Media links, etc";
		 
         print "<br><input type='radio' name='query' value='player_wl'><b>Player Overall W-L record</b>: This will list the player's Won-Lost record, overall and by season ";
		 
         print "<br><input type='radio' name='query' value='player_wl_split'><b>Player Overall W-L record Lefty/Righty split</b>: This will list the player's Won-Lost record, overall and by season, with Lefty/Righty splits (suggested by Brian Pineda)";
      
	  
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='player_rankings'><b>Season Ending Rankings Per Player</b>: by season";
         }
      
         # 1/18/24: new report tourney_results_summary
         print "<br><input type='radio' name='query' value='tourney_results_summary'><b>Player Tourney Results Summary with Seeding</b>: this shows every tourney a player has entered, their seed, and their result";

         print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically</b>: This query will list every match that the player has in the DB, earliest to latest/Ascending";
         print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";


		 # all tours and US Open queries don't work for WOR or PPS
		 if ($form{'tour'} eq 'WOR') {
		    # do nothing
         }
         elsif ($form{'tour'} eq 'PPS') {
            # do nothing
         }		 
		 else {
		    print "<br><input type='radio' name='query' value='player_history_alltours'><b>Complete player match history, All tours</b>: This query will list every match that the player has across ALL tours, earliest to latest/Ascending";
            print "<br><input type='radio' name='query' value='player_history_us_open'><b>Complete player match history, US Open Only</b>: This query will list every match that the player has played at all US Opens";
         }
 
         print "<br><input type='radio' name='query' value='player_wins'><b>Player Wins</b>: This will list the all the players Wins chronologically";
         print "<br><input type='radio' name='query' value='player_losses'><b>Player Losses</b>: This will list all the players Losses chronologically";
      
         print "<br><input type='radio' name='query' value='player_games_wl'><b>Player Games and W-L record</b>: This will list the player's Won-Lost record, including Games won/lost, overall and by season";
      
# head-to-head queries      
         print "<br><input type='radio' name='query' value='head_to_head'><b>Player Head-to-Head Record Alphabetically</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by player name";
         print "<br><input type='radio' name='query' value='head_to_head_ttl'><b>Player Head-to-Head Record Ordered by most Matchups</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by the number of times they've met from most to least";
         print "<br><input type='radio' name='query' value='head_to_head_3yr'><b>Player Head-to-Head Records in last 3 years </b>: To gauge more recent head-to-head records, this limits the search to the last three years for active players";      
         print "<br><input type='radio' name='query' value='nontriv_head_to_head'><b>Non-Trivial Player Head-to-Head Record</b>: This is head-to-head among the more regular tour members (eliminates all matchups where there have been less than 2 meetings)";
         print "<br><input type='radio' name='query' value='nontriv_head_to_head_withresults'><b>Non-Trivial Player Head-to-Head Records With Results</b>: Shows non-trivial head-to-head records for players on tour, with the results.";

      
         print "<br><input type='radio' name='query' value='career_best_win'><b>Career Best Win </b>: Shows a player's best win on tour, based on their seeding at the time";

         print "<br><input type='radio' name='query' value='career_best'><b>Career Best Showing </b>: Shows a player's best showing on tour";
         print "<br><input type='radio' name='query' value='career_best_ranking'><b>Career Best Ranking </b>: Shows a player's best season-ending Ranking on tour";
         print "<br><input type='radio' name='query' value='career_best_seeding'><b>Career Best Seeding </b>: Shows a player's best seeding on tour (2009 and onward)";
		 
         print "<br><input type='radio' name='query' value='record_by_city'><b>Player Record by City</b>: Do players do better in particular cities?";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='player_record_5th'><b>Player record in 5-game matches</b>: 5-game match records by player ";
         }
         else {
            # do nothing: WRT and IRF play best of 3.  Same with IRT dbls, Amateurs, Juniors, WOR (which has weird scoring sometimes), PPS
         }
      
      
         print "<br><input type='radio' name='query' value='donuts'><b>Donut Counts</b>: Given and received";
         print "<br><input type='radio' name='query' value='donuts_finals'><b>Donut Counts in Finals</b>: Given and received just limited to Finals";
         print "<br><input type='radio' name='query' value='twinkies'><b>'Twinkie' Counts</b>: (11-1 or 1-11 games), Given and received (inspired by the IRT stats page)";
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='ot_games'><b>OT Games</b>: What is a player's record in \"OT\" Games (games that go to super tiebreaker, or 12-10 or longer)";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='ot_games'><b>OT Games</b>: What is a player's record in \"OT\" Games (games that go to super tiebreaker, or 12-10 or longer): Note that this query won't make a ton of sense for now with the varying scoring over the years.";
         }
         else {
            # Do nothing: no "Overtime" games in the WRT/IRF since it is USAR scoring.  Same with IRTdbls, Amateurs, Juniors, WOR
         }
      
      
      
         print "<br><input type='radio' name='query' value='tourney_pct'><b>Tournament Winning Percentage</b>: Percentage of Tournaments won when entered.";
         print "<br><input type='radio' name='query' value='tourney_final_pct'><b>Finals Percentage</b>: Percentage of Tournaments reaching the Final";
         print "<br><input type='radio' name='query' value='all_titles'><b>All Titles</b>: Lists all Titles won by the player.";
       
         print "<br><input type='radio' name='query' value='player_wl_finals'><b>Player W-L record in Finals</b>: This will list the player's Won-Lost record in finals only, overall and by season";
         print "<br><input type='radio' name='query' value='player_wl_semis'><b>Player W-L record in Semis</b>";
         print "<br><input type='radio' name='query' value='player_wl_qtrs'><b>Player W-L record in Quarters</b>";
         print "<br><input type='radio' name='query' value='player_wl_16s'><b>Player W-L record in 16s</b>";
         print "<br><input type='radio' name='query' value='player_wl_early'><b>Player W-L record in Early rounds</b>: not as meaningful for 90s players b/c records are spotty for round of 32";
         print "<br><input type='radio' name='query' value='player_wl_us_open'><b>Player W-L in US Open</b>: Player W/L Record just in the US Open";
			 
      
         print "<br><input type='radio' name='query' value='first_tour'><b>Player \"Firsts\"</b>: Prints a player's first Tour Event Appearance, First Tour Win, and the Number of Tourneys it took to win their first";
         print "<br><input type='radio' name='query' value='last_tour'><b>Player \"Lasts\"</b>: Prints a player's last Tour Event Appearance, Last Tour Win";
      
         print "<br><input type='radio' name='query' value='misc_player_stats'><b>Misc Player Stats</b>: How does a player fare when losing the first game?  When winning the first game?  etc";
           
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";

#-------------
# Singles Misc/Tour Wide
#-------------
         print "<hr><b>Miscellaneous Tour Statistics</b>";

	 


		 
		 
         if ($form{'tour'} eq 'AMATEUR') {
            print "<p><input type='radio' name='query' value='most_tourney_wins_natsonly'><b>Most Tourney Wins, Nationals Only</b>: This query will list the number of National titles in the database by player.";
            print "<br><input type='radio' name='query' value='most_tourney_wins_natsandqualifiers'><b>Most Tourney Wins, Nationals and Qualifiers</b>: This query will list the number of National-level tourney wins in the database by player, Qualifiers and Nationals";
         }
		 
         else {
            print "<p><input type='radio' name='query' value='most_tourney_wins'><b>Most Tourney Wins</b>: This query will list the number of tourney wins in the database by player.";
         }		 
		 
         print "<br><input type='radio' name='query' value='most_tourney_finals'><b>Most Tourney Finals</b>: This query will list the number of tourney finals in the database by player.";

         if ($form{'tour'} eq 'WOR') {
            print "<br><input type='radio' name='query' value='triple_crown_men'><b>Triple Crown Winners - Mens Singles</b>: Winners of all 3 outdoor 'majors' by year, Mens Singles";
            print "<br><input type='radio' name='query' value='triple_crown_women'><b>Triple Crown Winners - Womens Singles</b>: Winners of all 3 outdoor 'majors' by year, Womens Singles";
         }

	 
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='best_season'><b>Best Seasons</b>: This query will print a list of the best player performances in a single season (by winning pct).";
         }
   
         print "<br><input type='radio' name='query' value='wl_pct_all'><b>Best Career Won/Loss Percentages</b>: This query will list all the Regular tour players (20+ wins) by their career W/L percentages.";
         print "<br><input type='radio' name='query' value='wl_pct_all_worst'><b>Worst Career Won/Loss Percentages</b>: This query will list the worst Career W/L pcts for semi-regular players (20+ appearances) by their career W/L percentages.";
         print "<br><input type='radio' name='query' value='wl_pct_all_16sonward'><b>Best Career Won/Loss Percentages, main draws only</b>: This query will list the best career W/L percentages excluding qualifying rounds";
         print "<br><input type='radio' name='query' value='season_summary_all'><b>Career Season Summaries</b>:  This will list the \"Season Summary\" career totals for all players in the database (15 second query).";

         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'WOR') {
            print "<br><input type='radio' name='query' value='hof_roster'><b>Hall of Fame Roster</b>: Career Season Summaries for all Hall of Famers";
            print "<br><input type='radio' name='query' value='hof_roster_potential'><b>Hall of Fame Potentials</b>: Career Season Summaries for all current non-Hall of Famers worthy of consideration";
	     }
	
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRFmatch' 
		 || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'WOR' || $form{'tour'} eq 'PPS') {
            print "<br><input type='radio' name='query' value='most_seasons'><b>Most Seasons on Tour</b>: This query will list the players with the most seasons with at least one appearance on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_appearances'><b>Most Appearances on Tour</b>: This query will list every player in the database and the number of times they played a tournament on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_appearances_since_covid'><b>Most Appearances on Tour Since Covid</b>: This query will list every player in the database and the number of times they played a tournament on the $form{'tour'} tour since Covid";
            print "<br><input type='radio' name='query' value='most_appearances_last10yrs'><b>Most Appearances on Tour, Last 10 years</b>: This query will list every player in the database and the number of times they played a tournament on the $form{'tour'} tour in the last 10 years";
            print "<br><input type='radio' name='query' value='longest_appearance_streak'><b>Longest Tourney Appearance Streaks</b>: Longest consecutive tournament Appearance Streaks in tour history.  (longer running query, be patient)</b>";	
            print "<br><input type='radio' name='query' value='most_wins'><b>Most Wins on Tour</b>: This query will list every player in the database and the number of Wins they have on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_losses'><b>Most Losses on Tour</b>: This query will list every player in the database and the number of Losses they have on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_matches'><b>Most Matches on Tour</b>: This query will list every player in the database and the number of Total Matches they have on the $form{'tour'} tour.";
			
         }

   
   
         print "<br><input type='radio' name='query' value='all_finals'><b>All Finals</b>: This query will list the results of every Final in the database.";
         print "<br><input type='radio' name='query' value='all_qsf'><b>All Quarters/Semis/Finals</b>: This query will list all the Q/S/F of every tourney in the database";	
         print "<br><input type='radio' name='query' value='all_qsf_country'><b>Quarters, Semis and Final Country Of Origin</b>: country of Origin for the 
		     Q/S/F players for every tourney (longer running query; be patient)";

         print "<br><input type='radio' name='query' value='player_countries_per_all'><b>Player Country Breakdown for all Players</b>: Player Country Report for all players of all time";		 
         print "<br><input type='radio' name='query' value='player_countries_per_all_by_season_cnt'><b>Player Country Breakdown for all Players by Season: Counts</b>: Player Country Report for all players of all time, Season by Season progression showing counts (longer running query; be patient)";		 
         print "<br><input type='radio' name='query' value='player_countries_per_all_by_season_pct'><b>Player Country Breakdown for all Players by Season: Percentages</b>: Player Country Report for all players of all time, Season by Season progression showing percentages (longer running query; be patient)";		 
      
	     #zzz  9/28/26: Print out of all players who have switched countries; JTrball request.
         print "<br><input type='radio' name='query' value='players_switching_countries'><b>Players who have Switched Countries</b>: Lists all players who have changed The countries they represent, with start/end dates";		 
		 
	  
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WOR' || $form{'tour'} eq 'PPS') {
            print "<br><input type='radio' name='query' value='all_major_finals'><b>All Major Finals</b>: All Major Finals through the years.";
         }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
            # do nothing; no majors in the WRT as of 2016; may adjust this later on
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         print "<br><input type='radio' name='query' value='longest_games'><b>Longest Games</b>: Matches with the longest single games in the 11-point win by 2 game era";
         print "<br><input type='radio' name='query' value='worst_defeats'><b>Worst Defeats</b>: Most one-sided matches in the database (note: most of these are qualifying rounds)";
         print "<br><input type='radio' name='query' value='qsf_worst_defeats'><b>Worst Defeats In Quarters/Semis/Finals</b>: Most one-sided matches in Quarters/Semis/Finals";
         print "<br><input type='radio' name='query' value='f_worst_defeats'><b>Worst Defeats In Finals</b>: Most one-sided matches in Finals";
      
         # 1/19/17: putting in a "dominant" tourney report
         print "<br><input type='radio' name='query' value='most_dominant_tourneys'><b>Most Dominant Tourney Wins</b>: Ranking of the most dominant tourney wins in history; fewest games dropped, fewest points allowed, etc";
      
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='longest_matches_pre'><b>Longest Matches (21 point Game Era 1973-1981)</b>: Most points scored in a match, 1974-1981 (games best 2 of 3 to 21)";
            print "<br><input type='radio' name='query' value='longest_matches_post'><b>Longest Matches (11 point game Era 1981-2017)</b>: Most points scored in a match, 1981-2017 (games 3 out of 5 to 11)";
            print "<br><input type='radio' name='query' value='longest_matches_2018'><b>Longest Matches (15 point game Era 2018-present)</b>: Most points scored in a match, 2018-present (2 games to 15, tiebreaker to 11)";			
            print "<br><input type='radio' name='query' value='most_points_win_pre'><b>Most Points in a Win (21 point Game Era 1973-1981)</b>: Most points scored in a match, 1974-1981 (games best 2 of 3 to 21) by someone who won the match.";	
            print "<br><input type='radio' name='query' value='most_points_win_post'><b>Most Points in a Win (11 point game Era 1981-2017)</b>: Most points scored in a match, 1981-2017 (games 3 out of 5 to 11) by someone who won the match.";	
            print "<br><input type='radio' name='query' value='most_points_win_2018'><b>Most Points in a Win (15 point game Era 2018-present)</b>: Most points scored in a match, 1981-2017 (2 games to 15, tiebreaker to 11) by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss_pre'><b>Most Points in a Loss (21 point Game Era 1973-1981)</b>: Most points scored in a match, 1974-1981 (games best 2 of 3 to 21) by someone who lost the match.";	
            print "<br><input type='radio' name='query' value='most_points_loss_post'><b>Most Points in a Loss (11 point game Era 1981-2017)</b>: Most points scored in a match, 1981-2017 (games 3 out of 5 to 11) by someone who lost the match.";			
            print "<br><input type='radio' name='query' value='most_points_loss_2018'><b>Most Points in a Loss (15 point game Era 2018-present)</b>: Most points scored in a match, 1981-2017 (2 games to 15, tiebreaker to 11) by someone who lost the match.";			

			
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='longest_matches_rally'><b>Longest Matches (Rally Scoring) </b>: Most points scored in a match under Rally Scoring rules (Rally Scoring Seasons: 1980-86, plus the 2000-02 seasons)";
            print "<br><input type='radio' name='query' value='longest_matches_nonrally_old'><b>Longest Matches (Non-Rally Scoring), Old Scoring Method </b>: Most points scored in a match under non-rally, games-to-21 scoring rules.  This includes games to 21 from 1974-80.";
            print "<br><input type='radio' name='query' value='longest_matches_nonrally_new'><b>Longest Matches (Non-Rally Scoring), New Scoring Method </b>: Most points scored in a match under non-rally, games-to-11 scoring rules.  Non-Rally games to 11 started in 1986 with exception of 2000-2002";
            print "<br><input type='radio' name='query' value='longest_matches_2018'><b>Longest Matches (15 point game Era Aug 2019-present)</b>: Most points scored in a match, Aug 2019-present (2 games to 15, tiebreaker to 11)";			
            print "<br><input type='radio' name='query' value='most_points_win_2018'><b>Most Points in a Win (15 point game Era 2019-present)</b>: Most points scored in a match, Aug 2019-present (2 games to 15, tiebreaker to 11) by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss_2018'><b>Most Points in a Loss (15 point game Era 2019-present)</b>: Most points scored in a match, Aug 2019-present (2 games to 15, tiebreaker to 11) by someone who lost the match.";			
			
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.  Note: WRT games are scored by USA-R amateur rules: 2 games to 15, tiebreaker to 11, so the max longest game is 15-14, 14-15, 11-10";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";	
         }

         # elsif for WOR: not sure how to do WOR since the scoring varies even intra-tournament. 

         elsif ($form{'tour'} eq 'IRFmatch') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.  Note: IRF games are scored by International scoring rules: 2 games to 15, tiebreaker to 11, so the max longest game is 15-14, 14-15, 11-10";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";
         }
         elsif ($form{'tour'} eq 'AMATEUR') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.  Note: Amateur games are scored by 
			International/Amateur scoring rules: 2 games to 15, tiebreaker to 11, so the max longest game is 15-14, 14-15, 11-10.  
   		    Canada has slightly altered this to have all games be win by two, so you may see 16-14 or 12-10 games.";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";
         }
         elsif ($form{'tour'} eq 'JUNIOR') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.  Note: Junior matches are scored by 
			International/Amateur scoring rules: 2 games to 15, tiebreaker to 11, so the max longest game is 15-14, 14-15, 11-10.  
   		    Canada has slightly altered this to have all games be win by two, so you may see 16-14 or 12-10 games.";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";
         }
         elsif ($form{'tour'} eq 'PPS') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='longest_fifth'><b>Longest 5th game</b>: Matches with longest 5th game/Super Tiebreaker.";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='longest_fifth'><b>Longest 5th game</b>: Matches with longest 5th game/Super Tiebreaker.  Includes rally and non-rally seasons.";
         }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'PPS') {
           # do nothing; no 5th games on WRT
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         print "<br><input type='radio' name='query' value='all_negative'><b>All Negative Score Games</b>: A list of all matches with negative scores on tour.";
         print "<br><input type='radio' name='query' value='all_forfeits'><b>All Forfeit Score Games</b>: A list of all matches with forfeit scores on tour.";
         print "<br><input type='radio' name='query' value='all_forfeits_qsf'><b>All Forfeit Score Games in Q/S/F</b>: A list of all matches with forfeit scores on tour that occurred in the Quarters/Semis/Finals (this strips away most of the FFTs show in the above query because many happen in early rounds.";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'WOR') {
            print "<br><input type='radio' name='query' value='season_tourney_wins'><b>Season by Season Tourney Wins/Distinct Winners per Season</b>: Marty Hogan suggested List of Tourney Winners by season; Provides an interesting look at year-end winner versus who won the most tourneys. ";
            print "<br><input type='radio' name='query' value='num_events'><b>Number of Events per Season</b>: Quick count of events per season for the entirety of the tour.";
            print "<br><input type='radio' name='query' value='draw_size_per_event_alltime'><b>Draw Size per Event, all Time</b>: Gives the size of the draw per Event for every event on tour";			
            print "<br><input type='radio' name='query' value='consecutive_distinct_winners'><b>Most Consecutive Distinct Winners</b>: Report showing the most consecutive Distinct tourney winners in Tour history.";
			
         }
      

         print "<br><input type='radio' name='query' value='longest_game_streak'><b>Longest Game Winning Streaks</b>: Longest Individual Game Winning Streaks.  Note that this report will skip forfeits only if they resulted in no on-court play.";
      
         print "<br><input type='radio' name='query' value='longest_match_streak'><b>Longest Match Winning Streaks</b>: Longest individual Match Winning Streaks.  Note: ffts break winning streaks in this report; we are working on a non-fft win streak version";
      
         print "<br><input type='radio' name='query' value='longest_match_streak_nofft'><b>Longest Match Winning Streaks, no Ffts</b>: Longest Match Winning Streaks not counting Ffts.";
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'WOR') {  
            print "<br><input type='radio' name='query' value='longest_tourney_streak'><b>Longest Tourney Winning Streaks</b>: Longest tourney Winning Streaks.  Note: missed tournaments break winning streaks in this report; we are working on a non-missed tourney win streak version";
         }
   	  
         print "<br><input type='radio' name='query' value='longest_tourney_streak_nofft'><b>Longest Tourney Winning Streaks, No FFts/Missed tourneys</b>: 
		 Longest tourney Winning Streaks, accounting for missed tourneys.</b>";

	 
		 
      
         print "<br><input type='radio' name='query' value='most_matchups'><b>Most Matchups</b>: What two players have played the most on tour?";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {
     	    print "<br><input type='radio' name='query' value='tour_depth'><b>Tour Depth Report</b>: A report that shows the 'depth' of the tour by season.  Longer query; 10-15 seconds to run";
            print "<br><input type='radio' name='query' value='all_top_tens'><b>All Season Top 10 Lists</b>: This will show the top 10 for every season on tour. Still needs some work on the older tournaments";
            print "<br><input type='radio' name='query' value='all_top_ten_matrix'><b>Matrix of all Top 10 Finishes</b>: This prints a matrix of every player who has finished a season ranked in the top 10 with counts by finish.";
         }
   
         print "<br><input type='radio' name='query' value='player_profiles'><b>Player Profiles - All</b>: List of All Player Profiles, including hometown, current residence, height/weight, sponsors, birthday.";
         print "<br><input type='radio' name='query' value='player_profiles_regular'><b>Player Profiles - Regular</b>: List of Regular Player Profiles, including hometown, current residence, height/weight, sponsors, birthday. ";
   
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {   
            print "<br><input type='radio' name='query' value='first_time_tour_winners'><b>First Time Tour Winners</b>: Information about each Tier 1 winner's first time winning a tournament";
            print "<br><input type='radio' name='query' value='tour_winners_age'><b>Ages of Tourney Winners</b>: A list of every tourney winner on tour, their age at first tour win, first appearance, last tour win, etc.";
            print "<br><input type='radio' name='query' value='tour_regulars_age'><b>Ages of Tourney Regulars</b>: A list of every tourney regular on tour (25+ wins), their age at first tour win, first appearance, last tour win, etc.";

         }  
    
         print "<br><input type='radio' name='query' value='oldest_player_to'><b>Oldest Players to...</b>:  Oldest player to win a tourney, make a final, etc.  ";
         print "<br><input type='radio' name='query' value='youngest_player_to'><b>Youngest Players to...</b>:  Youngest player to win a tourney, make a final, etc. ";

         print "<br><input type='radio' name='query' value='oldest_final'><b>Highest Combined Age in a Final</b>:  This shows the highest combined age between two finalists in tour history (Cary Slade suggestion)";
         print "<br><input type='radio' name='query' value='youngest_final'><b>Lowest Combined Age in a Final</b>:  This shows the lowest combined age between two finalists in tour history (Cary Slade suggestion)";
 
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {  
            print "<br><input type='radio' name='query' value='tour_champ_age'><b>Ages of All Tour Champs</b>: A report that shows the age of each season tour winner at season end.";
         }

         if ($form{'tour'} eq 'PPS') {
			 # do nothing; no seeding yet in PPS
	     }
         else {		 
            print "<br><input type='radio' name='query' value='highest_seeds_all'><b>Highest Seeds to...</b>: Highest Seeds to win, make a final, etc.  Reports across all available data, though the seeding is really only guaranteed to be available starting in the 2010-11 season for all tours ";
            print "<br><input type='radio' name='query' value='highest_seeds_f'><b>Highest Combined Seeds in Finals</b>: Highest Combined Seeds to comprise a Final (rpts suggested by Evan Pritchard).  ";   
            print "<br><input type='radio' name='query' value='highest_seeds_sf'><b>Highest Combined Seeds in Semis</b>: Highest Combined Seeds to comprise a Semis field.  ";   
            print "<br><input type='radio' name='query' value='highest_seeds_qsf'><b>Highest Combined Seeds in Qtrs/Semis/Final</b>: Highest Combined Seeds to comprise the Qtrs/Semis/Finals field. ";   

            print "<br><input type='radio' name='query' value='lowest_seeds_f'><b>Lowest Combined Seeds in Finals</b>: Lowest Combined Seeds to comprise a Final";   
            print "<br><input type='radio' name='query' value='lowest_seeds_sf'><b>Lowest Combined Seeds in Semis</b>: Lowest Combined Seeds to comprise a Semis field.  ";   
            print "<br><input type='radio' name='query' value='lowest_seeds_qsf'><b>Lowest Combined Seeds in Qtrs/Semis/Final</b>: Lowest Combined Seeds to comprise the Qtrs/Semis/Finals field.  ";   
         }

		 
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='us_open'><b>US Open Participation Summary</b>: Historical summary of all Participants in the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='us_open_drawsizes'><b>US Open Draw Sizes</b>: Draw Sizes for the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='us_open_qsf'><b>US Open Tourney Qtrs/Semis/Finals historically</b>: Historical summary of Q/S/F  Participants in the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='season_summary_us_open'><b>US Open Results Summary</b>: Summary of US Open-only finishes, all players.";
            print "<br><input type='radio' name='query' value='all_titles_us_open'><b>Ages of all US Open Winners</b>: All US Open Winners with Age of winner";			
            print "<br><input type='radio' name='query' value='us_open_debuts'><b>US Open Debuts</b>: All players who debuted on tour at the US Open (report suggestion by Dean Baer)";	
      	  }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'PPS') {
         # US Open queries not applicable to WRT, IRF, Amateurs, Juniors, WOR
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
		 
         if ($form{'tour'} eq 'IRFmatch')  {
            print "<br><input type='radio' name='query' value='irf_tourney_summary_player'><b>IRF Tournament Summary by Player</b>: A list of the leading IRF tourney winners by player";
            print "<br><input type='radio' name='query' value='irf_tourney_summary_country'><b>IRF Tournament Summary by Country</b>: A list of the leading IRF tourney winners by country";
         }

         print "<br><input type='radio' name='query' value='misc_tour_stats'><b>Misc Match Stats</b>: For the whole tour and all of time, How does a player fare when 
		       losing the first game?  When winning the first game?  etc";
			   
		
			   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {			   
            print "<br><input type='radio' name='query' value='rankings_matrix'><b>Year End Ranking Matrix</b>: Year End Ranking Matrix all-time 
			   of any player who has appeared in the top 20.";
         }	
		 
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {			   
            print "<br><input type='radio' name='query' value='head_to_head_matrix'><b>Head to Head Matrix</b>: Head to Head Matrix all-time of top 20 players on tour (using previous season's rankings)";
            print "<p><a href=\"https://$ENV{'SERVER_NAME'}/cgi-bin/tale_of_the_tape.pl?tour=$form{'tour'}\">Tale of the Tape</a>: Direct link to Tale of the Tape report, where you can select any 2 players for a custom Tale of the Tape!";
         }			   

		 
		 
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
      
      
      } # if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR')
	     # this is end of very large if then else starting at line 680 or so to show all singles match queries.

   }  # else clause of if ($form{'tour'} eq 'CROSS') ... if clause is just showing h2h records.
   
  
   print "</form>\n";


#----------------------------------------------------------------------------------------
# Static Links for all tours
#----------------------------------------------------------------------------------------

# 12/5/17: movement of all static links from former front-page to here.

   printf "<hr>";
   
   if ($form{'tour'} eq 'IRT') {

      print "<b>IRT Men's Pro Tour History Pages</b>
             <p>
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/tour_history.html\">Tour History</a>: a bullet-point history of the Pro Tour since inception, with major events, rule changes, 
			 etc (this is a highlight list; obviously the events of the early 80s could really fill a book).  
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/rule_changes.html\">Major Rule Change History</a>: History of major rule changes on tour (scoring and how to determine the year 
			 end champ).  Last Updated Sept 2019 with new season refereeing clarifications from tour ref Scott McClellan.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/scoring_changes.html\">Scoring System Change History</a>: History of scoring systems in use on the Men's tour. 
			    Last Updated Dec 2017 with change to go to amateur/international scoring.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/tour_name.html\">Tour Name History</a>: A history of the name of the Pro Tour.  Created/last updated Mar 2004.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/commissioners.html\">Commissioner History</a>: A history of the Pro Tour Commissioners.  Last Updated Mid 2017 with Kulbeck's 
			 appointment as new commissioner.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/cpro.html\">Canadian Professional Racquetball Organization History</a>: During the early 80s, the Catalina tour creation 
			 forced non-invitees off the pro tour, including Canadians, who formed their own tour.  Last updated July 2006 with some input from Mike 
			 Ceresia on tour winners/participants.
  
             <hr>
			 
             <b>IRT Men's Tour Player History Pages</b>
             <p>
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/year_end_titles.html\">Year End Title Winners</a> 1968-present.  
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/year_end_summaries.html\">Year End Summaries</a> Year-long season narratives providing an editorial \"summary\" of each season.  
			 Summaries are written through out the year and are perpetually updated to the website.
             <li>Season End Standings by year: This data has been loaded into the database and is no longer maintained in a static file here; use season-specific queries to see all the rankings per year, 
			 get rankings per player or use the \"all top 10\" to get the top 10 for every season.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/number_ones.html\">#1 Ranking holders who never won a title</a>: a list of players who have, at some point in their career, been #1 
			 but who do not have a year end title.  Last updated Nov 2010, with Ben Croft getting a #1 seed when Kane skipped a tourney and Dec 2017 with some
			 new research uncovering the fact that Inoue was ranked #1 for a time during the early 1990s.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/top_players.html\">Top Players never to have finished #1</a>: a subjective list of top players of the eras of racquetball who never 
			 finished on top.  These are players who routinely were in the Top 8 rankings but who never made their way to the top.  Last updated Dec 2017 to
			 put in some new player detail from the 1990s and update current players.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/number_of_titles.html\">Number of overall Titles</a>: A list of players and the number of titles they earned.  Last updated May 2017 with 
			 Kane's 12th title.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/major_titles.html\">Major Championship Titles</a>: A list of the Major Title winners, by tournament.  \"Major\" titles are/were the 
			 \"Grand Slams\" of the day, equivalent of the US Open now, and includes the US Open, Tournament of Champions, Pro Nationals/Grand Nationals, 
			 Ektelon Nationals, Catalina Nationals, DP/Leach Nationals and the IRA Nationals.  Last updated Oct 2017 with Kane's unprecidented 13th US Open title.  Note; 
			 you can also run the above report calld 'All Major Finals' to get a list of all Major winners.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/poty.html\">Player of the Year</a>: Player of the Year honors (data very spotty).  Also includes Rookie of the Year, Comeback Player of 
			 the Year winners (if known).  Last updated 11/19/07 with awards given post US Open banquet; I've never had good data here.
             <li>Number of Distinct Winners by year: replaced this static HTML page with the 'Distinct Winners Per Season' report per season, or the 'Season by Season Wins/Distinct Winners' report for the entirety of the tour.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/greatest_upsets.html\">Greatest Upsets in tour History</a>: inspired by a meetandplay.com forum conversation in August, 2004.  
			 A list of great upsets and great runs in Pro Racquetball history.  Last updated 1/17/09 to add in Jose Rojas' California Open play, Dec 2017
			 to describe Pratt's improbable win.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/best_never_heardof.html\">The Best Players you've never heard of</a>: inspired by a meetandplay.com forum conversation in September 
			 2008, this lists players who demonstrated real talent on tour but who didn't play full time, quit early or who had other reasons not to play.  Last 
			 updated 1/17/09 with more musings post NYC 09 event, Dec 2017 to add in some names.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/keeley_goat.html\">Bo Keeley's Greatest of All Time Article</a>: Published in Feb 2013, Keeley discusses the four eras of Racquetball, 
			 the best player from each era, and talks about determining the G.O.A.T.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/irt/what_happened_to.html\">Where are they Now?</a>: Here's a quick update on where some of the IRT's former touring pros are now.  
	<hr>";
			 
   }
   
   if ($form{'tour'} eq 'LPRT') {
   
      print "<b>LPRT Women's Pro tour History Pages</b>
             <p>
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_tour_history.html\">LPRT Tour History</a>: A brief overview of known Women's pro tour 
			 changes; needs more detail from those involved over the years.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_rule_changes.html\">LPRT Major Rule Change History</a>: mostly capturing the various 
			 scoring changes that have occurred over the years.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_scoring_changes.html\">Scoring System Change History</a>: History of scoring systems in use on the 
			    Women's tour.  Last Updated 2002 with abandonment of rally scoring experiment and return to conventional pro scoring.			 
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_tour_name.html\">LPRT Tour Name History</a>: as it has changed over the years.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_commissioner.html\">LPRT Commissioner History</a>: very spotty with lots of turnover 
			 over the years.
			 <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_never_numberones.html\">LPRT Best Players never to finish #1</a>A list of players by era never to have finished number one.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_summary_2017.html\">2017 LPRT Stat Summary</a>: 12/27/17 published LPRT 2017 Statistical 'year in review' summary

             
             <hr>
             <b>LPRT Women's Tour Player History Pages</b>
             <p>
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_year_end_titles.html\">Women's Year End Title Winners</a> 1970-present.  Also includes a 
			 summary of # of overall titles
             <li>Season End Standings by year: Loaded in Database: see Match Results Database and run the \"All Season Top 10 Lists\" report.
             <li>Major Championship Titles: Loaded into database; see Match Results Database and run the \"All Major Finals\" report.
             <li>Year End Summaries: tbd; may need some research
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_best_never_heardof.html\">Top Players never to have finished #1</a>: Also includes 
			 discussions on the best players who never won a tourney and a list of some of the better players from yesteryear.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/lprt/lprt_greatest_upsets.html\">Greatest Upsets in tour History</a>: a non-complete list that 
			 I've compiled as I've gone through some of the data entry cataloging great runs and big upsets.
       <hr>";

   
   }
   if ($form{'tour'} eq 'WRT') {
      print "<b>WRT Pro tour History Pages</b>
             <p>
             <li><a href=\"https://$ENV{'SERVER_NAME'}/wrt/wrt_tour_history.html\">WRT Tour History</a>: A brief overview of the WRT, which started in late 2012 but began \"touring\" in earnest in 2013.
             <li>WRT Major Rule Change History: no real rule changes thus far to document.  WRT plays by IRF/Amateur scoring rules (2 games to 15, tiebreaker to 11, win by one).
             <li><a href=\"https://$ENV{'SERVER_NAME'}/wrt/wrt_tour_name.html\">WRT Tour Name History</a>: No changes to document.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/wrt/wrt_commissioner.html\">WRT Commissioner History</a>: Overview of the WRT management.
             <hr>
			 
             <b>WRT Tour Player History Pages</b>
             <p>
             <li>WRT Year End Title Winners: 2013 to present; see seedings or POTY links.
             <li><a href=\"https://$ENV{'SERVER_NAME'}/wrt/wrt_poty.html\">WRT Players of the Year</a>: Poty, Rookie of the Year, Sportsmanship, Most Improved and \"Fan Favorites.\"  Have 2015, 2016, waiting for older data.
             <li>Season End Standings by year: Loaded in Database: see Match Results Database and run the \"All Season Top 10 Lists\" report.  More data needed.
             <li>Major Championship Titles: No WRT Majors as of yet.
             <li>Year End Summaries: tbd
             <li>Top Players never to have finished #1: tbd
             <li>Greatest Upsets in tour History: tbd
       <hr>"; 
   }   

   # if clause for WOR: pending


   
   # Nicer link set and sources 
   printf "<div class=\"row\">
			<div class=\"col-lg-1\"></div>
			<div class=\"card\">
				<div class=\"card-header\">
					Data Sources
				</div>
				<div class=\"card-body\">
					<p class=\"card-text\">
						All data here was compiled by Todd Boss, by entering data published in Magazines, on r2sports.com or at National sites.  If there are 
   errors within, they may be because of publishing errors or incomplete online data, or due to data entry errors on my part. 
						If you have additions, corrections or comments, please direct them to me, at <a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>	.
					</p>";
					
# 1/18/18: commenting out these links here; they just don't look right
#   printf "			<hr />
#					<ul class=\"footer-nav-links\">
#						<li><a href=\"https://www.irt-tour.com\" target=\"_blank\">IRT</a> &bull;</li>
#						<li><a href=\"https://www.lprt.com\" target=\"_blank\">LPRT</a> &bull;</li>
#						<li><a href=\"https://www.worldracquetballtour.com/\" target=\"_blank\">WRT</a> &bull;</li>
#						<li><a href=\"https://worldoutdoorracquetball.net/\" target=\"_blank\">WOR</a> &bull;</li>						
#						<li><a href=\"https://www.internationalracquetball.com\" target=\"_blank\">IRF</a> &bull;</li>
#						<li><a href=\"https://www.teamusa.org/USA-Racquetball\" target=\"_blank\">USA-Racquetball</a> &bull;</li>
#						<li><a href=\"https://www.racquetball.ca/racquetball.asp?languageID=1\" target=\"_blank\">Racquetball Canada</a> &bull;</li>
#						<li><a href=\"https://www.fmr.mx\" target=\"_blank\">Federacion Mexicana de Raquetbol</a></li>
#					</ul>";
					
   printf "		</div>
			</div>
			<div class=\"col-lg-1\"></div>
		</div>
   </div>"; 
   

   print "</body></html>";
   
   $sth->finish;
   $dbh->disconnect;
}
   
#--------------------------------------------------------------------------------
# Debugging routine that dumps out an array 

sub dump_array() {
   my @array = @_;
   
   foreach $line (@array) {
      printf "$line|~|";
   }
   printf "\n";
}

