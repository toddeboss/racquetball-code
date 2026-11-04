#!/usr/local/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: print_results_new.pl
# Purpose: Takes form data from results_front.pl, puts on screen
#
# Dependencies: DBI, MySQL being up and available
#
# Modification History
# Date          who     What
# 03/17/04      TBoss   creation: all_matches, all_finals player_history added
# 03/19/04      TBoss   added finals_by_season, W-L record, head-to-head queries
# 03/21/04      TBoss   added qsf_by_season query
# 03/22/04      TBoss   added career_best
# 03/23/04      TBoss   added distinct_winners
# 03/24/04	TBoss	added longest_games, record_by_city, worst_defeats, 
#                 longest_matches, longest_5th, donuts, player_summary,
#                 tourney_pct
# 4/4/04	TBoss	lots of data fixing post 1974-1999 data loading,
#  			added longest_matches_pre and _post.  Fixed player_wl
#                 and others to suppress empty results.  Fixed bug in
#                 player_summary, added ot_games, fixed sorting in &donut
# 			after_first
# 9/17/04	TBoss	put in last_tour.
# 12/10/04	tboss	put in most_wins, most_appearances, cleaned up some explanatory
#                 text in some result screens
# 3/2/05	tboss	slight fix to order qsf_by_season properly by tmp_date
# 5/5/05	tboss	added wl_pct_all
# 10/19/05	tboss	added shading to head-to-head matrixes to highlight losing records
# 5/31/06	tboss	added best_season, twinkies
# 4/16/07	tboss	fixed bug in worst_defeats that was printing blank scores
# 9/5/07    tboss discovered that apostrophes in names screws up print_results...
# 5/23/08	tboss	Fix player_summary to also have Career Summary numbers at bottom.
# 5/27/08	tboss	put in season_summary_all to have career summaries for all players 
# 10/2/08	tboss	Updated database, removed all apostrophes for events and players
#                 to get around weird data issues.
# 10/21/08	tboss	Added season_tourney_wins, head_to_head_3yr
# 11/4/08	tboss	Put in player_profiles
# 11/7/08   tboss Put in tour_winners_age now that I have decently accurate birthdays.
# 11/9/08	tboss	added in Ages of Tour Winners, added ages to first and last queries,
#                 added join to tourneys to get majors for winners by season
# 9/2/09	tboss	Put in bold tag to Tourney Winner Ages to indicate active players
# 11/10/09	tboss	Putting in player_games_wl, to count games won/lost.  Also put in
#                 and made work the longest_match_streak
# 11/13/09	tboss	Creating nontriv_head_to_head_withresults
# 10/1/10	tboss	Added rankings table and begain modifying sql to account for rankings detail.  
# 			Modified all_matches_per_event
# 10/15/10	tboss	Added "total tourneys" column to season summary query.
# 11/6/10	tboss	Added in rankings to overall w/l query...
# 1/1/11	tboss	Added in statistical_abstract_byseason
# 4/7/11	tboss	Added in player_history_desc
# 5/17/11	tboss	putting in season_ending_rankings, player_rankings
# 5/17/11	tboss	putting in player_wins, player_losses
# 10/26/11	tboss	Added career W/L to several reports where it makes sense.
# 10/28/11	tboss	Adding longest_match_streak_nofft
# 11/3/11	tboss	Adding all_negative
# 1/8/13	tboss	adding Most Matchups
# 7/17/13	tboss	Migrated to new host, new db name and new user
# 1/31/14	tboss	Fixing Quarters/Semis/Finals by season to get first initials of players in qsf_by_season
# 5/8/14	tboss	draft of "tour depth" query started...
# 5/9/14	tboss	Also fixing gen_season_summary to get round of 256s as well for subsequent queries.
# 5/12/14	tboss	Coded oldest player to... query to list oldest tour winner, oldest finalist, etc.  
#                 Code also easily allowed Youngest Player To... report to be added by just reversing array.
# 5/13/14	tboss	continuing to work on Most Matchups, tweaks to tour_depth display
# 7/18/14	tboss	Beta of "ages of tour winners" table
# 8/5/14	tboss	cleaned up ages of tour winners.  added head to head total routine.  Re-sorting age of tour champs
# 9/30/14	tboss	continued work on Statistical Abstract ...
# 5/19/15	tboss	beta of "highest seeds to..." report.
# 5/30/15	tboss	player_games_wl: fixed bug over-counting games w/l
# 6/18/15	tboss	Adding season ending rank to Season Summary, changed rank logic in W-L record to use utility function
# 6/18/15	tboss	Added in all_top_tens
# 6/28/15	tboss	Beta of seed report per season
# 5/23/16	tboss	updated code for end of 2015-16 season
# 11/16/16	tboss	mods to do per-tour reporting, put in quick fix to longest matches code.
# 12/5/16	tboss	slight mod to season summaries to order the winners for presentation.  Also added age to season summary
# 12/21/16	tboss	adjust WRT specific text in code based on recent fixes.
# 12/28/16	tboss	put in longest_game fixes for LPRT rally scoring era
# 1/16/17	tboss	working on seeding report bugs and cross-season season query.  
# 1/17/17	tboss	Put in current_season variable, fixed distributed logic and fixed Season Summary bug
# 1/19/17	tboss	Put in per-event seed report, showing all upsets for the tourney.
# 1/20/17	tboss	working on "most dominant" tourney win report.
# 1/20/17:  tboss	changed all_finals to sort latest to earliest.
# 1/22/17	tboss	added quick additional misc player stat; record when winning first two games.  
#                 changed function name too to be more descriptive, and adapted to work for WRT
# 1/25/17	tboss	fixed bugs in Season summary showing incorrect rankings for past seasons, put in better printing logic
#                 for seasons w/o rankings in the database.
# 2/21/17	tboss	fixed num distinct winners query to not subtract 1 from winners total for non-IRT tours.
# 3/25/17	tboss	added record when losing first two games to misc stats.
# 5/2/17	tboss	Updated IRT current season to next year given end of current season.
# 6/23/17	tboss	Updated LPRT current season to next year given end of current season.
# 7/10/17	tboss	working on US Open report
# 9/7/17	tboss	Putting in draw size report per tourney and per season
# 9/24/17	tboss	Putting in US Open draw size report historically plus Q/S/F report
# 9/24/17	tboss	Added Franco to Carson/Rojas initial logic thanks to both Sebastian and Gerardo competing; eventually stopped tracking this.
# 9/25/17 	tboss	Put in static variable to hold the US Open tourney names.  Also put in static variable to hold the duplicate last name guys
# 9/25/17	tboss	Putting in US Open only Season summary report
# 10/8/17	tboss	Working on Game streak logic in the wake of Kane's game streak ending.
# 10/9/17	tboss	Developed Top-10 matrix to show all top-10 seeded players across history in one view.
# 10/10/17	tboss	Also fixed dup records issue in the "Oldest player to" and "Youngest player to" reports.
# 10/11/17	tboss	Developed first IRF queries
# 10/13/17	tboss	moved IRF data into its own database, tested new login, changing text and removing unneeded queries for IRF
# 10/14/17	tboss	Significant tweaking of all per-tour queries to account for IRF data
# 10/15/17	tboss	split up IRFsumm and IRFmain and fixed all code herein
# 10/16/17	tboss	put in code to only read player profile data as found when going to a master player profile table.
# 10/18/17 	tboss	put in all code in if/then/elses to handle Amateur data.
# 10/19/17	tboss	Filled in the rest of the IRF Summary singles reports, worked on all the doubles reporting to finish it off.
# 10/21/17	tboss Began to put in IRT doubles code logic.
# 10/25/17	tboss	Coded up the cross-tour head to head queries and made it work.
# 10/28/17	tboss	put in Amateur category-wide queries by adapting existing all_finals, qsf_per_season, draw_size queries.
# 11/1/17	tboss	Put in "frequent player profile" query since now there's so many player profile records
# 11/2/17	tboss	Put in IRF category-wide queries similar to Amateur.
# 11/3/17	tboss	most points in a win/loss query. 
# 11/4/17	tboss	fixed/corrected longest match query to also count winning scores to get true total points
# 11/15/17		tboss	Added Juniors and more categories
# 11/17/17		tboss	Added more amateur categories.
# 11/18/17	tboss	Added all_forfeits
# 11/20/17	tboss	modified all_finals to show doubles data
# 11/22/17	tboss	Modified all Amateur queries to have 2006 Canadian Open Mens final explanation of Kane's being stripped of title.
# 11/24/17	tboss	 Added in country for certain IRFmatch queries (all finals mostly)
# 11/27/17		tboss	putting in Html5/Bootstrap implementation details
# 12/7/17	tboss	cleaned up dbconnect error messaging, fixed script to read pwds from outside file.
# 12/7/17		tboss	reading master_navigation code form outside file for consistency.
# 12/12/17	tboss	added in LPRTdbls logic, added in doubles W/L per player logic
# 12/15/17	tboss	minor bug fixes noticed: wrong date in LPRT longest games, fixing score display in fft reports, missing categories in IRF queries.
# 12/16/17 tboss	added in WRTdbls 
# 12/21/17 tboss	Added in Doubles match history to player_history routines
# 1/2/18	tboss	Adding in Season_summary_all for doubles players.
# 1/3/18	tboss	Finally!! fixed the non-forfeit match winning streak query.  Put in placeholders for new 15point IRT games.
# 1/3/18	tboss	Writing highest seeds in semis query
# 1/4/18	tboss	followed this up with highest seeds in a final, qsf
# 1/5/18	tboss	Finally fixed non-forfeit tourney win streak query.  Fixed bug in string comparison logic to correct dominant tourney query
# 1/6/18	tboss	Added most wins, most losses and enabled these in all singles tours
# 1/8/18	tboss	created reverse of highest seed queries; lowest combined seed queries.
# 1/10/18	tboss	put in google analytics code
# 1/18/18	tboss	put in quick num_events query to show # of events per season.
# 1/19/18	tboss	appearance_streak query
# 1/21/18	tboss	putting in WOR logic and logins.
# 1/21/18	tboss	put in q/s/f country of origin query, slight fixes to country lookup functions for Unknowns, ? and Australia
# 1/23/18	tboss	changed buffer-in logic to allow for both existing functionality plus url-based variable passing
# 1/23/18	tboss	Put "back" link in every report now that we can pass parameters to a URL.




#---------------------------------------------------------------

# Read in database connectivity library 
use DBI;

# set unbuffered i/o for STDOUT (probably not needed)
select((select(STDOUT), $|=1)[$[]);

# De-bug flag: if set to 1, De-bugging info appears on screen.
$debug=0;

# define vars for mail
$mailprog="/usr/sbin/sendmail";
$webmaster="webmaster\@bossconsulting.com";

# Duplicate last name string
# 10/18/17: added in canadian brothers Landeryou and Murray who compete.  Also added in Walters brothers.
# 10/26/17: have added in a number of additional names while doing international updates.
# May have eventual issue with Herreras: Anthony, Andres, Alejandro. 
$dup_last_names="Carson|Rojas|Franco|Landeryou|Murray|Walters|Maldonado|Ortega|Rodriguez|Alonso|Gonzalez|Kurzbard|Munoz|Bredenbeck|Ortiz|Longoria|Fernandez|Garay|Iwaasa|Manilla|Herrera";

#---------------------------------------------------------------
# Main

&get_form_values;
&populate_pws;
&call_query;

# close db connection after we're done.
$sth->finish;
$dbh->disconnect;


#---------------------------------------------------------------
# Subroutine Defn's


#---------------------------------------------------------------
sub get_form_values {

   # Print out a content-type for HTTP/1.0 compatibility
   
   print "Content-type: text/html\n\n";
   
   # Print out updated HTML5 tag
   print "<!DOCTYPE html>\n";   
   
   print "<html lang=\"en\">";
   
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

    <title>Pro Racquetball Stats</title>

    <!-- Bootstrap core CSS -->
    <link href=\"/bootstrap/bootstrap.min.css\" rel=\"stylesheet\" />
    <!-- Custom styles for this template -->
    <style>
      body {
        padding-top: 54px;
      }
      @media (min-width: 992px) {
        body {
          padding-top: 56px;
        }
      }
	  @media (max-width: 415px) {
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
   
   print "<body>";
   
   # 12/7/17: reading in master navigation from a file instead of hard-coding here
   # open the file, read through it line by line and print it
   open(my $fh, '<:encoding(UTF-8)', "../bootstrap/master_navigation.html") or die "Could not open file master navigation file $!";
   while (my $row = <$fh>) {
      chomp $row;
	  print "$row\n"
   }  
   
   print "<div style=\"padding: 0 1%;\">";   
   
   

   printf "<b>NOTE!  If you see this text the code is in debug mode!</b><br>  Please don't be alarmed, i'm trying to fix a code problem.  Your query results will be at the very bottom as expected<p><p>" if $debug;

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
   if ($form{'player'} eq "0") {
      $form{'player'} = $form{'player2'};
   }

# Current Season Variable populating: putting this here so you don't have to hard code it elsewhere.

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'IRTdbls') {
      $current_season='2017-18';
   }
   elsif ($form{'tour'} eq 'LPRT' || $form{'tour'} eq 'LPRTdbls') {
      $current_season='2017-18';
   }
   elsif ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
      $current_season='2017-18';
   }
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'WRTdbls') {
      $current_season='2018';
   }
   elsif ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      # IRF has no seasons
   }
   elsif ($form{'tour'} eq 'CROSS') {
      # do nothing; no season here.
   }  
   else {
      printf "Invalid Tour selected; you should never get here";
   }

# 9/25/17: creating hard-coded list of US Open tourney names so we don't have to repeat it throughout the code

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'IRTdbls' ) {
      $us_open_tourney_list="
'2017 22nd UnitedHealthcare US OPEN Racquetball Championships',
'21st United Healthcare US Open',
'20th United Healthcare US Open',
'United Healthcare 19th US Open',
'United Healthcare 18th US Open',
'United Healthcare 17th US Open',
'16th US Open',
'15th Annual US Open',
'14th Annual US Open',
'13th US Open Racquetball Championships',
'Choice Hotels 12th US Open',
'Choice Hotels 11th US Open',
'Choice Hotels 10th US Open',
'Choice Hotels 9th US Open',
'Choice Hotels 8th US Open',
'Choice Hotels 7th US Open',
'Hilton 6th US Open',
'Hilton 5th US Open',
'1999 Promus 4th US Open',
'Promus Hotels 3rd US Open',
'Promus Hotel 2nd US Open',
'Promus Hotels 1st US Open'";
   }
   elsif ($form{'tour'} eq 'LPRT' || $form{'tour'} eq 'LPRTdbls') {
      $us_open_tourney_list="
'2017 22nd UnitedHealthcare US OPEN Racquetball Championships',
'21st United Healthcare US Open',
'20th United Healthcare US Open',
'2014 United Healthcare US Open',
'2013 United Healthcare US Open',
'2012 United Healthcare US Open',
'16th US Open',
'15th Annual US Open',
'14th Annual US Open',
'13th US Open Racquetball Championships 08',
'Choice Hotels 12th US Open 07',
'Choice Hotels 11th US Open',
'Choice Hotels 10th US Open 05',
'Choice Hotels 9th US Open 04',
'Choice Hotels 8th US Open 03',
'Choice Hotels 7th US Open 02',
'Hilton 6th US Open 01',
'2000 Hilton 5th US Open',
'1999 Promus 4th US Open',
'Promus Hotels 3rd US Open 98',
'Promus Hotel 2nd US Open 97',
'1st US Open 96'";
   }
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'CROSS' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'WOR') {
      # WRT, IRF, Amateurs, Juniors have no US Open pro tourney, CROSS is for cross-tour queries only.
      # do nothing for other tours.
   } 
   else {
      printf "Invalid Tour selected; you should never get here";
   }

   
}

#---------------------------------------------------------------
# 7/17/12: removed mysql.bossconsulting.com directed hostname.
# 7/18/13: migrated to 3essentials, using new db setup
# 11/16/16: put in if then else with differing logins.
# 12/7/17; moved pwds to external file, just reading in filename here.

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
   elsif ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch') {
      $pwdfilename = 'cp30725_irf.txt';
   }   
   elsif ($form{'tour'} eq 'AMATEUR') {
      $pwdfilename = 'cp30725_amateur.txt';
   } 
   elsif ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
      $pwdfilename = 'cp30725_wor.txt';
   }   
   elsif ($form{'tour'} eq 'JUNIOR') {
      $pwdfilename = 'cp30725_junior.txt';
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
# call the correct subroutine, based on the query selected

sub call_query {

   if ($form{'tour'} eq 'CROSS') {

      if ($form{'query'} eq 'head_to_head_cross') {
         &head_to_head_cross_main;
      }
      if ($form{'query'} eq 'head_to_head_cross_ttl') {
         &head_to_head_cross_main;
      }	  
      if ($form{'query'} eq 'head_to_head_cross_3yr') {
         &head_to_head_cross_main;
      }	  
      if ($form{'query'} eq 'nontriv_head_to_head_cross') {
         &head_to_head_cross_main;
      }	  	  
   }
   else {

      # Log into Mysql
      $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;


   if ($form{'query'} eq 'all_matches_per_event') {
      &all_matches_per_event
   }
   elsif ($form{'query'} eq 'qsf_per_event') {
      &qsf_per_event_new;
   }
   elsif ($form{'query'} eq 'seed_report_per_event') {
      &seed_report_per_event;
   }
   elsif ($form{'query'} eq 'player_history') {
      &player_history;
   }
   elsif ($form{'query'} eq 'player_history_desc') {
      &player_history;
   }
   elsif ($form{'query'} eq 'player_wl') {
      &player_wl_new;
   }
   elsif ($form{'query'} eq 'player_wl_dbls') {
      &player_wl;
   }
   elsif ($form{'query'} eq 'player_wl_bypartner') {
      &player_wl_bypartner;
   }
   elsif ($form{'query'} eq 'player_wins') {
      &player_wins;
   }
   elsif ($form{'query'} eq 'player_losses') {
      &player_losses;
   }
   elsif ($form{'query'} eq 'player_games_wl') {
      &player_games_wl;
   }
   elsif ($form{'query'} eq 'player_wl_finals') {
      &player_wl_round;
   }
   elsif ($form{'query'} eq 'player_wl_semis') {
      &player_wl_round;
   }
   elsif ($form{'query'} eq 'player_wl_qtrs') {
      &player_wl_round;
   }
   elsif ($form{'query'} eq 'player_wl_16s') {
      &player_wl_round;
   }
   elsif ($form{'query'} eq 'player_wl_early') {
      &player_wl_round;
   }
   elsif ($form{'query'} eq 'all_finals') {
      &all_finals;
   }
   elsif ($form{'query'} eq 'all_qsf') {
      &qsf_by_season;
   }
   elsif ($form{'query'} eq 'all_qsf_country') {
      &all_qsf_country;
   }
   elsif ($form{'query'} eq 'all_major_finals') {
      &all_major_finals;
   }
   elsif ($form{'query'} eq 'finals_by_season') {
      &finals_by_season;
   }
   elsif ($form{'query'} eq 'head_to_head') {
      &head_to_head;
   }

# new 8/5/14
   elsif ($form{'query'} eq 'head_to_head_ttl') {
      &head_to_head_ttl;
   }
   elsif ($form{'query'} eq 'head_to_head_3yr') {
      &head_to_head_3yr;
   }
   elsif ($form{'query'} eq 'nontriv_head_to_head') {
      &nontriv_head_to_head;
   }
   elsif ($form{'query'} eq 'nontriv_head_to_head_withresults') {
      &nontriv_head_to_head_withresults;
   }
   elsif ($form{'query'} eq 'qsf_by_season') {
      &qsf_by_season;
   }
   elsif ($form{'query'} eq 'career_best') {
      &career_best;
   }
   elsif ($form{'query'} eq 'distinct_winners') {
      &distinct_winners;
   }
   elsif ($form{'query'} eq 'longest_games') {
      &longest_games;
   }
   elsif ($form{'query'} eq 'record_by_city') {
      &record_by_city;
   }
   elsif ($form{'query'} eq 'worst_defeats') {
      &worst_defeats;
   }
   elsif ($form{'query'} eq 'qsf_worst_defeats') {
      &worst_defeats;
   }
   elsif ($form{'query'} eq 'f_worst_defeats') {
      &worst_defeats;
   }
   elsif ($form{'query'} eq 'most_dominant_tourneys') {
      &most_dominant_tourneys;
   }
   elsif ($form{'query'} eq 'longest_matches_pre') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'longest_matches_post') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'longest_matches_2018') {
      &longest_matches;
   }   
   
# 11/17/16: adding non-date driven version
   elsif ($form{'query'} eq 'longest_matches_all') {
      &longest_matches;
   }
# 12/27/16: adding in rally and non-rally scoring versions for LPRT
# 1/17/17: added in logic to split out old and new scoring methods, plus exact rally seasons
   elsif ($form{'query'} eq 'longest_matches_rally') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'longest_matches_nonrally_old') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'longest_matches_nonrally_new') {
      &longest_matches;
   }

   # 11/3/17: most points in a loss
   elsif ($form{'query'} eq 'most_points_win') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'most_points_win_post') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'most_points_win_pre') {
      &longest_matches;
   }   
   elsif ($form{'query'} eq 'most_points_win_2018') {
      &longest_matches;
   }   
   
   elsif ($form{'query'} eq 'most_points_loss') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'most_points_loss_pre') {
      &longest_matches;
   }
   elsif ($form{'query'} eq 'most_points_loss_post') {
      &longest_matches;
   }   
   elsif ($form{'query'} eq 'most_points_loss_2018') {
      &longest_matches;
   }  
   
   
   elsif ($form{'query'} eq 'longest_fifth') {
      &longest_fifth;
   }
   elsif ($form{'query'} eq 'all_negative') {
      &all_negative;
   }
   elsif ($form{'query'} eq 'all_forfeits') {
      &all_forfeits;
   }
   elsif ($form{'query'} eq 'all_forfeits_qsf') {
      &all_forfeits;
   }
   elsif ($form{'query'} eq 'player_record_5th') {
      &player_record_5th;
   }
   elsif ($form{'query'} eq 'donuts') {
      &donuts;
   }
   elsif ($form{'query'} eq 'twinkies') {
      &twinkies;
   }
   elsif ($form{'query'} eq 'ot_games') {
      &ot_games;
   }
   elsif ($form{'query'} eq 'player_summary') {
      &player_summary;
   }
   elsif ($form{'query'} eq 'tourney_pct') {
      &tourney_pct;
   }
   elsif ($form{'query'} eq 'tourney_final_pct') {
      &tourney_pct;
   }
   elsif ($form{'query'} eq 'first_tour') {
      &first_tour;
   }
   elsif ($form{'query'} eq 'last_tour') {
      &last_tour;
   }
   elsif ($form{'query'} eq 'misc_player_stats') {
      &misc_player_stats;
   }
   elsif ($form{'query'} eq 'most_tourney_wins') {
      &most_tourney_wins;
   }
   elsif ($form{'query'} eq 'most_appearances') {
      &most_appearances;
   }
# put these into most_appearances instead of writing new
   elsif ($form{'query'} eq 'most_wins') {
      &most_appearances;
   }
   elsif ($form{'query'} eq 'most_losses') {
      &most_appearances;
   }

   elsif ($form{'query'} eq 'longest_appearance_streak') {
      &longest_appearance_streak;
   }
   
   elsif ($form{'query'} eq 'wl_pct_all') {
      &wl_pct_all;
   }
   elsif ($form{'query'} eq 'best_season') {
      &best_season;
   }
   elsif ($form{'query'} eq 'season_summary_all') {
      &season_summary_all;
   }
   elsif ($form{'query'} eq 'season_summary_allplayers') {
      &season_summary_allplayers;
   }
   elsif ($form{'query'} eq 'season_tourney_wins') {
      &season_tourney_wins;
   }
   elsif ($form{'query'} eq 'num_events') {
      &num_events;
   }
   elsif ($form{'query'} eq 'player_profiles') {
      &player_profiles;
   }
   elsif ($form{'query'} eq 'player_profiles_regular') {
      &player_profiles;
   }
   elsif ($form{'query'} eq 'tour_winners_age') {
      &tour_winners_age;
   }
   elsif ($form{'query'} eq 'oldest_player_to') {
      &oldest_player_to;
   }
   elsif ($form{'query'} eq 'youngest_player_to') {
      &youngest_player_to;
   }
   elsif ($form{'query'} eq 'longest_game_streak') {
      &longest_game_streak;
   }
   elsif ($form{'query'} eq 'longest_match_streak') {
      &longest_match_streak;
   }
   elsif ($form{'query'} eq 'longest_match_streak_nofft') {
      &longest_match_streak_nofft;
   }
   elsif ($form{'query'} eq 'longest_tourney_streak') {
      &longest_tourney_streak;
   }
   elsif ($form{'query'} eq 'longest_tourney_streak_nofft') {
      &longest_tourney_streak_nofft;
   }
   elsif ($form{'query'} eq 'statistical_abstract_byseason') {
      &statistical_abstract_byseason;
   }
   elsif ($form{'query'} eq 'highest_seeds') {
      &highest_seeds;
   }
   elsif ($form{'query'} eq 'highest_seeds_all') {
      &highest_seeds_all;
   }
   elsif ($form{'query'} eq 'highest_seeds_f') {
      &highest_seeds_f;
   }
   elsif ($form{'query'} eq 'highest_seeds_sf') {
      &highest_seeds_sf;
   }
   elsif ($form{'query'} eq 'highest_seeds_qsf') {
      &highest_seeds_qsf;
   }

   # 1/8/18: putting these into highest seed logic and just changing query
   elsif ($form{'query'} eq 'lowest_seeds_f') {
      &highest_seeds_f;
   }
   elsif ($form{'query'} eq 'lowest_seeds_sf') {
      &highest_seeds_sf;
   }
   elsif ($form{'query'} eq 'lowest_seeds_qsf') {
      &highest_seeds_qsf;
   }

   elsif ($form{'query'} eq 'season_ending_rankings') {
      &season_ending_rankings;
   }
   elsif ($form{'query'} eq 'player_rankings') {
      &player_rankings;
   }
   elsif ($form{'query'} eq 'most_matchups') {
      &most_matchups;
   }
   elsif ($form{'query'} eq 'tour_depth') {
      &tour_depth;
   }
   elsif ($form{'query'} eq 'tour_champ_age') {
      &tour_champ_age;
   }
   elsif ($form{'query'} eq 'all_top_tens') {
      &all_top_tens;
   }
   elsif ($form{'query'} eq 'all_top_ten_matrix') {
      &all_top_ten_matrix;
   }
   elsif ($form{'query'} eq 'season_seed_report') {
      &season_seed_report;
   }
   elsif ($form{'query'} eq 'us_open') {
      &us_open;
   }
   elsif ($form{'query'} eq 'draw_size_per_event') {
      &draw_size_per_event;
   }
   elsif ($form{'query'} eq 'draw_size_per_season') {
      &draw_size_per_season;
   }
   elsif ($form{'query'} eq 'us_open_drawsizes') {
      &us_open_drawsizes;
   }
   elsif ($form{'query'} eq 'us_open_qsf') {
      &us_open_qsf;
   }
   elsif ($form{'query'} eq 'season_summary_us_open') {
      &season_summary_us_open;
   }   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_event') {
      &irf_all_singles_matches_per_event ;
   }      
   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category') {
      &irf_all_singles_matches_main ;
   }     
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_mensopen') {
      &irf_all_singles_matches_main;
   }   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_womensopen') {
      &irf_all_singles_matches_main ;
   }   
   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_mens30') {
      &irf_all_singles_matches_main;
   }   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_womens30') {
      &irf_all_singles_matches_main ;
   }      
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_mens35') {
      &irf_all_singles_matches_main;
   }   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_womens35') {
      &irf_all_singles_matches_main ;
   }       
   
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys18u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls18u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys16u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls16u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys14u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls14u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys12u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls12u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys10u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls10u') {
      &irf_all_singles_matches_main ;
   }     
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys8u') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls8u') {
      &irf_all_singles_matches_main ;
   }     
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys8umb') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls8umb') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_boys6umb') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_category_girls6umb') {
      &irf_all_singles_matches_main ;
   }     

   elsif ($form{'query'} eq 'irf_all_team') {
      &irf_all_team ;
   }    
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_division_male') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_singles_matches_per_division_female') {
      &irf_all_singles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_doubles_matches_per_division_male') {
      &irf_all_doubles_matches_main ;
   }  
   elsif ($form{'query'} eq 'irf_all_doubles_matches_per_division_female') {
      &irf_all_doubles_matches_main ;
   }  
   
   
   elsif ($form{'query'} eq 'irf_all_doubles_matches_per_event') {
      &irf_all_doubles_matches_main  ;
   }    
   elsif ($form{'query'} eq 'irf_team_results_per_event') {
      &irf_team_results_per_event;
   }       
   elsif ($form{'query'} eq 'irf_all_results_per_event') {
      &irf_all_results_per_event;
   }   

   elsif ($form{'query'} eq 'irf_all_player_results_singles') {
      &irf_all_player_results_main;
   }   
   elsif ($form{'query'} eq 'irf_all_player_results_doubles') {
      &irf_all_player_results_main;
   }    

   elsif ($form{'query'} eq 'finals_per_category') {
      &all_finals;
   }    
   elsif ($form{'query'} eq 'qsf_per_category') {
      &qsf_by_season;
   }    
   elsif ($form{'query'} eq 'draw_size_per_category') {
      &draw_size_per_season;
   }    


   else {
      printf "Invalid event selected (Did you forget to select a query to run?)<p>";
      printf "Please hit the back link below and pick a Query and/or an Event/Season/Player to go with it.";
      &print_back_link;	  
      printf "</body></html>";	  
   }

   }
}





#--------------------------------------------------------------------------------
# Beginning of individual queries
# 

sub all_matches_per_event() {

   printf "Entering all matches per event<br>" if $debug;
   
   if ($form{'event'} eq "0") {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
	  next;
   }   

   ($event,$date)=split(/~/,$form{'event'});

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select tour,city,date,source,season from results_doubles where event='$event' and round='2' and date='$date'"; 
   }
   else {
      $sql = "select tour,city,date,source,season from results where event='$event' and round='2' and date='$date'"; 
   }

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($event eq '2006 Canadian National Racquetball Championships - Mens Open') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $tour=$row[0];
      $city=$row[1];
      $date=$row[2];
      $source=$row[3];
      $season=$row[4];
   }

   if ($form{'tour'} eq 'IRFmatch') {
      printf "<p>tour is $tour from database<p>" if $debug;

      $division=$tour;

      $division =~ s/IRF //g;

      print "<p>Full Results for <b>$event, $division division</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      print "<p>Note: RR = Round Robin matches.  Seeding not determined until after the Round Robin matches.<br>";
      print "(results source: $source)<hr>";
   }	  
   elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' ) {
      print "<p>Full Results for <b>$event, $division division</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      print "<p>Note: Some amateur associations play a 3rd place game; if those results are known, it is shown.<br>";
      print "(results source: $source)<hr>";   
   }
   else {
      print "<p>Full Results for <b>$event</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      print "(results source: $source)<hr>";
   }
   
   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      print "<table border><tr>\n";
      print "<td><b>Round</b></td>
             <td><b>Winning Team</b></td>
		     <td><b>Losing Team</b></td>
		     <td><b>Score</b></td></tr>\n";  
   }
   else {
      print "<table border><tr>\n";
      print "<td><b>Round</b></td>
             <td><b>Winner</b></td>
		     <td><b>Loser</b></td>
		     <td><b>Score</b></td></tr>\n";  
   }   
 
   #$sql = "select winner,loser,round,score from results where event='$event' and date='$date' \
   #        order by tmp_date,round desc";

   # 10/3/10: trying new seeding-join to display seeds
   #$sql = "select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
   #        from results r, seedings s1, seedings s2
   #        where r.winner = s1.player
   #        and r.loser = s2.player
   #        and s1.event=r.event
   #        and s2.event=r.event
   #        and r.event='$event' and r.date='$date' order by r.tmp_date,r.round desc";

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed,
      loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed,
	  round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event            
           where r.event='$event'
           and r.date='$date'
           order by r.tmp_date,r.round desc;"; 
   }
   else {
      $sql = "select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.date='$date'
           order by r.tmp_date,r.round desc";
   }
   
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   	   
   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      while (@row = $sth->fetchrow_array) {
         $winner_p1=$row[0];
         $winner_p2=$row[1];		 
         $winner_p1_seed=$row[2];
         $winner_p2_seed=$row[3];		 
         $loser_p1=$row[4];
         $loser_p2=$row[5];		 
         $loser_p1_seed=$row[6];
         $loser_p2_seed=$row[7];		 
         $round=$row[8];
         $score=$row[9];

         $new_round=&fix_round($round);
		 
	     $winnerstring="#$winner_p1_seed $winner_p1 / $winner_p2";	 
	     $loserstring="#$loser_p1_seed $loser_p1 / $loser_p2";	 	
						 
		 # 10/23/17: assuming no missing seeds for now.... may need to do if/then/else in here.
         # 10/3/10: putting this code in to account for missing seed info.
         printf "<tr><td>$new_round</td>
		         <td>$winnerstring</td>
				 <td>$loserstring</td>
				 <td>$score</td> </tr>\n";

      } 
   }
   else {
      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $winner_seed=$row[1];
         $loser=$row[2];
         $loser_seed=$row[3];
         $round=$row[4];
         $score=$row[5];

         $new_round=&fix_round($round);

         # 10/3/10: putting this code in to account for missing seed info.
         if ($winner_seed eq '' && $loser_seed eq '') {
            printf "<tr> <td>$new_round</td> <td>$winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
         }
         elsif ($winner_seed eq '' && $loser_seed ne '') {
            printf "<tr> <td>$new_round</td> <td>$winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
         }
         elsif ($winner_seed ne '' && $loser_seed eq '') {
            printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
         }
         else {
            printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
         }
      }

   }


   print "</table>\n";
   &print_back_link;
   printf "</body></html>";	   

}

#--------------------------------------------------------------------------------
# 

sub qsf_per_event() {

   printf "Entering all matches per event\n" if $debug;
   
   if ($form{'event'} eq "0") {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
	  next;
   }   


   ($event,$date)=split(/~/,$form{'event'});

   $sql = "select tour,city,date,source,season from results where event='$event' and round='2' and date='$date'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $tour=$row[0];
      $city=$row[1];
      $date=$row[2];
      $source=$row[3];
      $season=$row[4];
   }

   print "<p>Quarters, Semis and Final for <b>$event</b>, <b>$tour</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
  
   if ($form{'tour'} eq 'AMATEUR') {
      print "<p>Note: Some amateur associations play a 3rd place game; if those results are known, it is shown.<br>";
      #print "(results source: $source)<hr>";   
   }   
   else {
      #print "(results source: $source)<p>";
   }

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($event eq '2006 Canadian National Racquetball Championships - Mens Open') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   print "<table border><tr>\n";
   print "<td><b>Round</b></td><td><b>Winner</b></td><td><b>Loser</b></td><td><b>Score</b></td></tr>\n";

	
   #$sql = "select winner,loser,round,score from results where event='$event' and date='$date' \
   #        and round in (8,4,2) order by round desc";
   $sql = "select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.date='$date'
           and round in (8,4,3,2) order by round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $winner_seed=$row[1];
      $loser=$row[2];
      $loser_seed=$row[3];
      $round=$row[4];
      $score=$row[5];

      $new_round=&fix_round($round);

      #printf "<tr> <td>$new_round</td> <td>$winner</td> <td>$loser</td> <td>$score</td> </tr>\n";

      # 10/28/10: putting this code in to account for missing seed info.
      if ($winner_seed eq '' && $loser_seed eq '') {
         printf "<tr> <td>$new_round</td> <td>$winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
      }
      elsif ($winner_seed eq '' && $loser_seed ne '') {
         printf "<tr> <td>$new_round</td> <td>$winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
      }
      elsif ($winner_seed ne '' && $loser_seed eq '') {
         printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
      }
      else {
        printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
      }

   }
  

   print "</table>\n";

   &print_back_link;	
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# this version has the new presentation format
# zzz

sub qsf_per_event_new() {

   printf "Entering all matches per event\n" if $debug;

   # bootstrap code can't handle the $form variables for some reason.
   $tour=${form{'tour'};
   
   if ($form{'event'} eq "0") {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
	next;
   }   

   ($event,$date)=split(/~/,$form{'event'});

   $sql = "select city,date,source,season from results where event='$event' and round='2' and date='$date'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $city=$row[0];
      $date=$row[1];
      $source=$row[2];
      $season=$row[3];
   }

   # get the winner for the image.
   $sql = "select winner from results where event='$event' and round='2' and date='$date'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
   }

   print "<div class=\"jumbotron\"> 
  		<div class=\"container\"> 
  			<h1 class=\"display-4\"><img src=\"http://www.proracquetballstats.com/logos/$tour}_logo.jpg\" align=\"left\" width=\"150\">$tour $event
                  <img src=\"http://www.proracquetballstats.com/images/$winner.jpg\" align=\"right\" width=\"150\"></h1> 
  			<p>Quarters, Semis and Final &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 
  			<p><a class=\"btn btn-primary btn-lg\" href=\"http://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=$tour&season=$season&query=qsf_by_season\" role=\"button\">$tour $season</a></p> 
  		</div> 
  	</div>";
   
   if ($form{'tour'} eq 'AMATEUR') {
      print "<p>Note: Some amateur associations play a 3rd place game; if those results are known, it is shown.<br>";
      #print "(results source: $source)<hr>";   
   }   
   else {
      #print "(results source: $source)<p>";
   }

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($event eq '2006 Canadian National Racquetball Championships - Mens Open') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   #print "<table border><tr>\n";
   #print "<td><b>Round</b></td><td><b>Winner</b></td><td><b>Loser</b></td><td><b>Score</b></td></tr>\n";

    printf "<!-- Page Content -->
    <div class=\"container container_results_table table-responsive\">
		<table class=\"table table-striped table-bordered table-hover table-scrollable\">
			<tr>
				<td><b>Round</b></td>
				<td><b>Winner</b></td>
				<td><b>Loser</b></td>
				<td><b>Score</b></td>
			</tr>";
			

	
   #$sql = "select winner,loser,round,score from results where event='$event' and date='$date' \
   #        and round in (8,4,2) order by round desc";
   $sql = "select winner, s1.seeding as winner_seed,loser, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.date='$date'
           and round in (8,4,3,2) order by round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $winner_seed=$row[1];
      $loser=$row[2];
      $loser_seed=$row[3];
      $round=$row[4];
      $score=$row[5];

      $new_round=&fix_round($round);

      #printf "<tr> <td>$new_round</td> <td>$winner</td> <td>$loser</td> <td>$score</td> </tr>\n";

      # 10/28/10: putting this code in to account for missing seed info.
      if ($winner_seed eq '' && $loser_seed eq '') {
         printf "<tr> <td>$new_round</td> <td>$winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
      }
      elsif ($winner_seed eq '' && $loser_seed ne '') {
         printf "<tr> <td>$new_round</td> <td>$winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
      }
      elsif ($winner_seed ne '' && $loser_seed eq '') {
         printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>$loser</td> <td>$score</td> </tr>\n";
      }
      else {
        printf "<tr> <td>$new_round</td> <td>#$winner_seed $winner</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
      }

   }
  

   print "</table>\n";
   print "</div>\n";
   
   printf "<!-- Bootstrap core JavaScript -->
    <script src=\"/bootstrap/jquery.min.js\"></script>
    <script src=\"/bootstrap/bootstrap.bundle.min.js\"></script>";

   &print_back_link;	
   printf "</body></html>";	      

}




#--------------------------------------------------------------------------------
# 12/19/17: making this work for doubles...
# 12/19/17: obsoleting player_history_desc; same exact query as this one just with a "desc" clause at the end of the sql.

sub player_history() {

   printf "Entering player history for $form{'query'}, $form{'tour'}<p>" if $debug;

   if ($form{'query'} eq 'player_history') {
      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select winner_p1,winner_p2,loser_p1,loser_p2,round,score,tour,city,event,date,season,notes \
           from results_doubles where \
           winner_p1='$form{'player'}' or winner_p2='$form{'player'}' or \
		   loser_p1='$form{'player'}' or loser_p2='$form{'player'}' order by tmp_date,event,round desc";
      }
      else {
         $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where \
           winner='$form{'player'}' or loser='$form{'player'}' order by tmp_date,event,round desc";
      }
   }

   if ($form{'query'} eq 'player_history_desc') {
      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select winner_p1,winner_p2,loser_p1,loser_p2,round,score,tour,city,event,date,season,notes \
           from results_doubles where \
           winner_p1='$form{'player'}' or winner_p2='$form{'player'}' or \
		   loser_p1='$form{'player'}' or loser_p2='$form{'player'}' order by tmp_date desc,event,round desc";
      }
      else {
         $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where \
           winner='$form{'player'}' or loser='$form{'player'}' order by tmp_date desc,event,round desc";
      }
   }   
   
   
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      print "<p>Full Doubles Results for <b>$form{'player'}</b> Chronologically earliest to latest<br>";

      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winning Team</b></td>
		  <td><b>Losing Team</b></td>
          <td><b>Score</b></td>
          </tr>\n";

      while (@row = $sth->fetchrow_array) {
         $winner_p1=$row[0];
         $winner_p2=$row[1];		 
         $loser_p1=$row[2];
         $loser_p2=$row[3];		 
         $round=$row[4];
         $score=$row[5];
         $tour=$row[6];
         $city=$row[7];
         $event=$row[8];
         $date=$row[9];
         $season=$row[10];
         $notes=$row[11];
   
         $new_round=&fix_round($round);
   
         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
	         <td>$winner_p1 / $winner_p2</td>	 
	         <td>$loser_p1 / $loser_p2</td>	 			 
             <td>$score</td>
             </tr>";
      }      
   }
   else {
      print "<p>Full Singles Results for <b>$form{'player'}</b> Chronologically earliest to latest<br>";

      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $loser=$row[1];
         $round=$row[2];
         $score=$row[3];
         $tour=$row[4];
         $city=$row[5];
         $event=$row[6];
         $date=$row[7];
         $season=$row[8];
         $notes=$row[9];
   
         $new_round=&fix_round($round);
   
         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
      }   
   }   


   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 12/21/17: obsoleted this subroutine by changing the call to use player_history; leaving in code

sub player_history_desc() {

   printf "Entering player history sorted desc\n" if $debug;

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where \
           winner='$form{'player'}' or loser='$form{'player'}' order by tmp_date desc, event ,round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   print "<p>Full Results for <b>$form{'player'}</b> starting with most recent <br>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";
   &print_back_link;
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 12/13/17 adding in doubles W/L logic.

sub player_wl() {

   printf "Entering player_wl(), tour is $form{'tour'} and player is $form{'player'} \n" if $debug;

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select count(*) from results_doubles 
	          where winner_p1='$form{'player'}' or winner_p2='$form{'player'}'";
   }
   else {
      $sql = "select count(*) from results where winner='$form{'player'}'";
   }
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }	  

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select count(*) from results_doubles 
	          where loser_p1='$form{'player'}' or loser_p2='$form{'player'}'";
   }
   else {
      $sql = "select count(*) from results where loser='$form{'player'}'";
   }	  

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }

   print "<p>Won-Loss Record for <b>$form{'player'}</b><p>";

   if ($form{'tour'} eq 'IRFmatch') {
      printf "Overall record in Intl Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "Overall record in National Team Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'JUNIOR') {
      printf "Overall record in Junior Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      printf "Overall record in Doubles Events: $overall_wins - $overall_losses<br>\n";
   }
   else {
      printf "Overall record on tour: $overall_wins - $overall_losses<br>\n";
   }

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
 
   printf "Overall Winning percentage: $winning_pct<br>\n";

   #printf "<br><b>Note</b>: As of Sept 2004 almost all missing round-of-32 records have been \
   #   entered into the database.  We're still missing some results most of the 94-95 and \
   #   the 99-00 seasons, so these W/L percentages will be off.  We're working to rectify \
   #   the situation.";

   # don't print rankings column if IRF/Amateur/Juniors
   # 12/13/17: don't print rankings for now for Doubles either

   if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      printf "<p>Year-by-Year Results:<br>";
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>Percentage</b></td>
          </tr>\n";
   }
   else {
      printf "<p>Season-by-season Results:<br>";
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b><center>Season <br>Ending <br>Rank</center></b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>Percentage</b></td>
          </tr>\n";
   }

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      $sql = "select distinct(season) from results_doubles order by season desc";
   }
   else {
      $sql = "select distinct(season) from results order by season desc";   
   }
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {
      printf "calculating win/loss for $season<br>" if $debug;

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select count(*) from results_doubles 
	          where (winner_p1='$form{'player'}' or winner_p2='$form{'player'}')
			  and season='$season'";
      }
      else {
         $sql = "select count(*) from results where winner='$form{'player'}' \
              and season='$season'";
      }
      	  
      $sth = $dbh->prepare($sql);
      $sth->execute;
         @rows = $sth->fetchrow_array;
         #&dump_array(@rows) if $debug;
         #printf "$wins\n" if $debug;
         $wins=$rows[0];

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select count(*) from results_doubles 
	          where (loser_p1='$form{'player'}' or loser_p2='$form{'player'}')
			  and season='$season'";
      }
      else {
         $sql = "select count(*) from results where loser='$form{'player'}' \
              and season='$season'";
      }		 
	  
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $losses=$rows[0];
         #printf "$losses[0]\n" if $debug;
      }

# 6/18/15: replacing rank obtainment logic
# 12/13/17; no doubles rankings for now; may change this later.

      unless ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $tmp_rank = &gen_player_ranking($season,$form{'player'});
      
	     printf "$tmp_rank\n" if $debug;

         ($rank,$points,$prizemoney) = split(/,/, $tmp_rank);
         printf "rank is $rank,points are $points,money is $prizemoney\n" if $debug;

         if ($rank eq "no results") {
            undef $rank;
            $comments = "No Results on tour";
         }
      }

      $season_winning_pct = "0.000";
      printf "wins are $wins, losses are $losses\n<br>" if $debug;

      # don't print rank column if IRF/Amateur
      if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
	     printf "entering IRFMatch/Amateur/Junior/Dbls clause<br>" if $debug;
	     if ($wins+$losses > 0) { 
            print "<tr><td>$season</td>";
            print "<td><center>$wins</center></td>";
            print "<td><center>$losses</center></td>";
            $season_winning_pct = ($wins/($wins+$losses));
            $season_winning_pct = sprintf("%.03f", $season_winning_pct);
            print "<td><center>$season_winning_pct</center></td>";
            print "</tr>";
         }
         else {
            next;
         }
      }
      else {
	     printf "entering non IRFMatch/Amateur/Junior/Dbls clause<br>" if $debug;
         if ($wins+$losses > 0) { 
            print "<tr><td>$season</td>";
            print "<td><center>$rank</center></td>";
            print "<td><center>$wins</center></td>";
            print "<td><center>$losses</center></td>";
            $season_winning_pct = ($wins/($wins+$losses));
            $season_winning_pct = sprintf("%.03f", $season_winning_pct);
            print "<td><center>$season_winning_pct</center></td>";
            print "</tr>";
         }
         else {
            next;
         }

      }

      undef $rank;
      undef $tmp_rank;
   }
      
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      


}


#--------------------------------------------------------------------------------
# 12/13/17 adding in doubles W/L logic.
# 1/27/18; formatting with new format, graphics
# zzz

sub player_wl_new() {

   printf "Entering player_wl(), tour is $form{'tour'} and player is $form{'player'} \n" if $debug;

   # for some reason can't pass the form values into the bootstrap code.
   $tour=$form{'tour'};

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select count(*) from results_doubles 
	          where winner_p1='$form{'player'}' or winner_p2='$form{'player'}'";
   }
   else {
      $sql = "select count(*) from results where winner='$form{'player'}'";
   }
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }	  

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $sql = "select count(*) from results_doubles 
	          where loser_p1='$form{'player'}' or loser_p2='$form{'player'}'";
   }
   else {
      $sql = "select count(*) from results where loser='$form{'player'}'";
   }	  

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }

   #print "<p>Won-Loss Record for <b>$form{'player'}</b><p>";

   print "<div class=\"jumbotron\"> 
  		<div class=\"container\"> 
  			<h1 class=\"display-4\"><img src=\"http://www.proracquetballstats.com/logos/${tour}_logo.png\" align=\"left\" width=\"150\">
                  <img src=\"http://www.proracquetballstats.com/images/$form{'player'}.jpg\" align=\"right\" width=\"150\"></h1> 
  			<p>Won-Loss Record for <b>$form{'player'}</b>: Per season and Career</p> 

  		</div> 
  	</div>";

   if ($form{'tour'} eq 'IRFmatch') {
      printf "Overall record in Intl Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "Overall record in National Team Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'JUNIOR') {
      printf "Overall record in Junior Events: $overall_wins - $overall_losses<br>\n";
   }
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      printf "Overall record in Doubles Events: $overall_wins - $overall_losses<br>\n";
   }
   else {
      printf "Overall record on tour: $overall_wins - $overall_losses<br>\n";
   }

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
 
   printf "Overall Winning percentage: $winning_pct<br>\n";

   #printf "<br><b>Note</b>: As of Sept 2004 almost all missing round-of-32 records have been \
   #   entered into the database.  We're still missing some results most of the 94-95 and \
   #   the 99-00 seasons, so these W/L percentages will be off.  We're working to rectify \
   #   the situation.";

   # don't print rankings column if IRF/Amateur/Juniors
   # 12/13/17: don't print rankings for now for Doubles either


   if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      #printf "<p>Year-by-Year Results:<br>";
      printf "<!-- Page Content -->
         <div class=\"container container_results_table table-responsive\">
         <table class=\"table table-striped table-bordered table-hover table-scrollable\">
         <tr>
            <td><b>Season</b></td>
            <td><b>Wins</b></td>
            <td><b>Losses</b></td>
            <td><b>Percentage</b></td>
	   </tr>";
   }
   else {
      #printf "<p>Season-by-season Results:<br>";
      printf "<!-- Page Content -->
         <div class=\"container container_results_table table-responsive\">
         <table class=\"table table-striped table-bordered table-hover table-scrollable\">
         <tr>
            <td><b>Season</b></td>
            <td><b><center>Season <br>Ending <br>Rank</center></b></td>
            <td><b>Wins</b></td>
            <td><b>Losses</b></td>
            <td><b>Percentage</b></td>
	   </tr>";
   }

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      $sql = "select distinct(season) from results_doubles order by season desc";
   }
   else {
      $sql = "select distinct(season) from results order by season desc";   
   }
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {
      printf "calculating win/loss for $season<br>" if $debug;

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select count(*) from results_doubles 
	          where (winner_p1='$form{'player'}' or winner_p2='$form{'player'}')
			  and season='$season'";
      }
      else {
         $sql = "select count(*) from results where winner='$form{'player'}' \
              and season='$season'";
      }
      	  
      $sth = $dbh->prepare($sql);
      $sth->execute;
         @rows = $sth->fetchrow_array;
         #&dump_array(@rows) if $debug;
         #printf "$wins\n" if $debug;
         $wins=$rows[0];

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $sql = "select count(*) from results_doubles 
	          where (loser_p1='$form{'player'}' or loser_p2='$form{'player'}')
			  and season='$season'";
      }
      else {
         $sql = "select count(*) from results where loser='$form{'player'}' \
              and season='$season'";
      }		 
	  
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $losses=$rows[0];
         #printf "$losses[0]\n" if $debug;
      }

# 6/18/15: replacing rank obtainment logic
# 12/13/17; no doubles rankings for now; may change this later.

      unless ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         $tmp_rank = &gen_player_ranking($season,$form{'player'});
      
	     printf "$tmp_rank\n" if $debug;

         ($rank,$points,$prizemoney) = split(/,/, $tmp_rank);
         printf "rank is $rank,points are $points,money is $prizemoney\n" if $debug;

         if ($rank eq "no results") {
            undef $rank;
            $comments = "No Results on tour";
         }
      }

      $season_winning_pct = "0.000";
      printf "wins are $wins, losses are $losses\n<br>" if $debug;

      # don't print rank column if IRF/Amateur
      if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
	     printf "entering IRFMatch/Amateur/Junior/Dbls clause<br>" if $debug;
	     if ($wins+$losses > 0) { 
            print "<tr><td>$season</td>";
            print "<td><center>$wins</center></td>";
            print "<td><center>$losses</center></td>";
            $season_winning_pct = ($wins/($wins+$losses));
            $season_winning_pct = sprintf("%.03f", $season_winning_pct);
            print "<td><center>$season_winning_pct</center></td>";
            print "</tr>";
         }
         else {
            next;
         }
      }
      else {
	     printf "entering non IRFMatch/Amateur/Junior/Dbls clause<br>" if $debug;
         if ($wins+$losses > 0) { 
            print "<tr><td>$season</td>";
            print "<td><center>$rank</center></td>";
            print "<td><center>$wins</center></td>";
            print "<td><center>$losses</center></td>";
            $season_winning_pct = ($wins/($wins+$losses));
            $season_winning_pct = sprintf("%.03f", $season_winning_pct);
            print "<td><center>$season_winning_pct</center></td>";
            print "</tr>";
         }
         else {
            next;
         }

      }

      undef $rank;
      undef $tmp_rank;
   }
      
   print "</table>";

   printf "<!-- Bootstrap core JavaScript -->
    <script src=\"/bootstrap/jquery.min.js\"></script>
    <script src=\"/bootstrap/bootstrap.bundle.min.js\"></script>";

   &print_back_link;   
   printf "</body></html>";	      


}



#--------------------------------------------------------------------------------
# 12/13/17: doubles W/L by partner


sub player_wl_bypartner() {

# note; not bothering with if/then/else by tour; you only enter this via doubles queries.

# first, get overall W/L borrowing from W/L query to print at the top.

   $sql = "select count(*) from results_doubles 
	          where winner_p1='$form{'player'}' or winner_p2='$form{'player'}'"; 
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }	  

   $sql = "select count(*) from results_doubles 
	          where loser_p1='$form{'player'}' or loser_p2='$form{'player'}'";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }


   # will print this later.   
   
   

   # first, clear out the partner_wl_rpt table
   $sql = "truncate table partner_wl_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;   
   

   printf "Entering player_wl_bypartner(), tour is $form{'tour'} and player is $form{'player'} <p>" if $debug;

   $sql = "select winner_p2,count(*) from results_doubles 
           where winner_p1='$form{'player'}' group by winner_p2";
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $partner=$row[0];
	  $partner_wins=$row[1];

      $sql = "insert into partner_wl_rpt values ('$partner',$partner_wins,null)";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;
   }

   $sql = "select winner_p1,count(*) from results_doubles 
           where winner_p2='$form{'player'}' group by winner_p1";
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $partner=$row[0];
	  $partner_wins=$row[1];

	  $sql = "insert into partner_wl_rpt values ('$partner',$partner_wins,null)";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

   }   
 
   $sql = "select loser_p2,count(*) from results_doubles 
           where loser_p1='$form{'player'}' group by loser_p2";
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $partner=$row[0];
	  $partner_losses=$row[1];
	  
      $sql = "insert into partner_wl_rpt values ('$partner',null, $partner_losses)";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;
   }   

    
   $sql = "select loser_p1,count(*) from results_doubles 
           where loser_p2='$form{'player'}' group by loser_p1";
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $partner=$row[0];
	  $partner_losses=$row[1];
	  
      $sql = "insert into partner_wl_rpt values ('$partner',null, $partner_losses)";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;
   }  
   
   printf "<p>Partner by Partner Results for <b>$form{'player'}</b> (Alphabetically by partner last name):<p>";
   
   printf "Overall record in Doubles Events: $overall_wins - $overall_losses<br>\n";

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
 
   printf "Overall Winning percentage: $winning_pct<br>\n";   
   
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Partner</b></td>
	      <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          </tr>\n";   
   
   $sql = "select partner,ifnull(sum(wins),0),ifnull(sum(losses),0) from partner_wl_rpt group by partner order by partner";
   
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $partner=$row[0];
	  $partner_ttl_wins=$row[1];
	  $partner_ttl_losses=$row[2];	 

      print "<tr><td>$form{'player'}</td>
	         <td>$partner</b></td>
			 <td><center>$partner_ttl_wins</center></td>
			 <td><center>$partner_ttl_losses</center></td>
			 </tr>\n";
   }
	
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	  
   
}
   


#--------------------------------------------------------------------------------
# 9/25/11: adding player wins, player losses adapted from player_history
#  should be the exact same code just with there where clause modified

sub player_wins() {

   printf "Entering player wins\n" if $debug;

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where \
           winner='$form{'player'}' order by tmp_date,event,round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   print "<p>All Wins in the DB for <b>$form{'player'}</b> Chronologically earliest to latest<br>";

# 10/25/11 adding in overall w/l on tour
      
   ($overall_wins,$overall_losses,$overall_pct)=&gen_wl($form{'player'});
      
   printf "<b>Overall W/L on tour</b>: $overall_wins - $overall_losses<br>";              
   printf "<b>Overall W/L Percentage</b>: $overall_pct<p>"; 

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 9/25/11: adding player wins, player losses adapted from player_history
#  should be the exact same code just with there where clause modified

sub player_losses() {

   printf "Entering player losses\n" if $debug;

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where \
           loser='$form{'player'}' order by tmp_date,event,round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   print "<p>All Losses in the DB for <b>$form{'player'}</b> Chronologically earliest to latest<br>";

# 10/25/11 adding in overall w/l on tour
      
   ($overall_wins,$overall_losses,$overall_pct)=&gen_wl($form{'player'});
      
   printf "<b>Overall W/L on tour</b>: $overall_wins - $overall_losses<br>";              
   printf "<b>Overall W/L Percentage</b>: $overall_pct<p>"; 

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 11/10/09: adding games won/lost queries
# 

sub player_games_wl() {

   printf "Entering player games wl\n" if $debug;

   $sql = "select count(*) from results where winner='$form{'player'}'";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }

   $sql = "select count(*) from results where loser='$form{'player'}'";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }

# moved printing of match w/l to bottom

   print "<p>Match and Games Won-Loss Record for <b>$form{'player'}</b><br>";

   print "<p>Note: this query skips ? scores, blank scores, and forfeit scores<br>";

   if ($form{'player'} eq 'Waselenchuk, Kane') {
      print "<p>Note about Kane's 2016-17 season: this query lists his match record at 29-0 but his game record at 85-0.  29 matches * 3 games each = 87 games.  
	  So why does the report list 85 games instead of 87?  Because in one of his tournaments, Kane won a final over DLR 11-0, inj-fft.  The report counts this as 
	  just one game won instead of three, and thus gives him 85 games instead of 87 on the season.  This is in contrast/disagreement to the way that Kane's 
	  undefeated game-season was reported by USRA and others, who attributed him to have won 87 games.  This report counts solely those games that were competed 
	  on the court and had a result and does not attempt to give game win credit for forfeits.";
   }

   printf "<p>Season-by-season Results:<br>";
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Match Wins</b></td>
          <td><b>Match Losses</b></td>
          <td><b>Match W/L Percentage</b></td>
          <td><b>Games Won</b></td>
          <td><b>Games Lost</b></td>
          <td><b>Games W/L Lost</b></td>
          </tr>\n";

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   # initialize overall games w/l variables
   $overall_games_won=0;
   $overall_games_lost=0;

   for $season (@seasons) {
      printf "calculating win/loss for $season<br>" if $debug;

      $sql = "select count(*) from results where winner='$form{'player'}' \
              and season='$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
         @rows = $sth->fetchrow_array;
         #&dump_array(@rows) if $debug;
         #printf "$wins\n" if $debug;
         $wins=$rows[0];

      $sql = "select count(*) from results where loser='$form{'player'}' \
              and season='$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $losses=$rows[0];
         #printf "$losses[0]\n" if $debug;
      }

      $season_winning_pct = "0.000";
      printf "wins are $wins, losses are $losses\n<br>" if $debug;
      if ($wins+$losses > 0) { 
         print "<tr><td>$season</td>";
         print "<td>$wins</td>";
         print "<td>$losses</td>";
         $season_winning_pct = ($wins/($wins+$losses));
         $season_winning_pct = sprintf("%.03f", $season_winning_pct);
         print "<td>$season_winning_pct</td>";

         # initialize games counts
         $season_games_won=0;
         $season_games_lost=0;

         # count of games when won
         $sql = "select score from results where winner='$form{'player'}' \
                 and season='$season'";
         $sth = $dbh->prepare($sql);
         $sth->execute;

         while (@score = $sth->fetchrow_array) {
            #next if $score[0] == '';
            printf "score is $score[0]\n" if $debug;

            $score=$score[0];

            # Data entry errors cause some scores to have commas, others spaces separating
            # game scores.  Must stript them
            if ($score =~ /\,/) {
               $score =~ s/\,/ /g;
               #@points=split(/\,/,$score);
            }
   
            # clean Extra spaces in scores
            $score=~ s/  */ /g;

            @points=split(/ /,$score);
   
# 5/30/15: put in next clause so we don't count inj fft results as "games" won or lost...
            foreach $ttl (@points) {
               next if ($ttl =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
               if ($ttl =~ /\(/) {
                  $season_games_lost++;
                  $overall_games_lost++;
               }
               else {
                  $season_games_won++;
                  $overall_games_won++;
               }
            }
         }

         # count of games when losing
         $sql = "select score from results where loser='$form{'player'}' \
                 and season='$season'";
         $sth = $dbh->prepare($sql);
         $sth->execute;

         while (@score = $sth->fetchrow_array) {
            printf "score is $score[0]\n" if $debug;

            $score=$score[0];

            # Data entry errors cause some scores to have commas, others spaces separating
            # game scores.  Must stript them
            if ($score =~ /\,/) {
               $score =~ s/\,/ /g;
               #@points=split(/\,/,$score);
            }
   
            # clean Extra spaces in scores
            $score=~ s/  */ /g;

            @points=split(/ /,$score);

# 5/30/15: put in next clause so we don't count inj fft results as "games" won or lost...   
            foreach $ttl (@points) {
               next if ($ttl =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
               if ($ttl =~ /\(/) {
                  $season_games_won++;
                  $overall_games_won++;
               }
               else {
                  $season_games_lost++;
                  $overall_games_lost++;
               }
            }
         }

         print "<td>$season_games_won</td>";
         print "<td>$season_games_lost</td>";

         if ($season_games_won+$season_games_lost == 0) {
            #$season_game_winning_pct = sprintf("%.03f", "0.000");
            $season_game_winning_pct = '0.000';
         }
         else {
            $season_game_winning_pct = ($season_games_won/($season_games_won+$season_games_lost));
            $season_game_winning_pct = sprintf("%.03f", $season_game_winning_pct);
         }
         print "<td>$season_game_winning_pct</td>";
         print "</tr>";
      }
      else {
         next;
      }


   }
      
   print "</table>";

   print "<p>Match Won-Loss Record for <b>$form{'player'}</b><br>";
   printf "Overall record on tour: $overall_wins - $overall_losses<br>\n";

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
 
   printf "Overall Winning percentage: $winning_pct<br>\n";

   print "<p>Games Won-Loss Record for <b>$form{'player'}</b><br>";

   printf "Overall Games W/L on tour: $overall_games_won - $overall_games_lost<br>\n";

   if ($overall_games_won+$overall_games_lost > 0) { 
      $winning_pct = ($overall_games_won/($overall_games_won+$overall_games_lost));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
 
   printf "Overall Games W/L percentage: $winning_pct<br>\n";

   &print_back_link;   
   printf "</body></html>";	      

}


#--------------------------------------------------------------------------------
# 1/20/17: changed this to sort latest to earliest.
# 10/28/17 modified to take the category field for Amateur
# 11/2/17: added in IRF categories
# 11/20/17: added in doubles logic.
# 1/22/18: fixing this to show countries for all pros, not just IRFmatch


sub all_finals() {

   printf "Entering all finals per event for $form{'tour'}\n" if $debug;

   if ($form{'query'} eq 'finals_per_category') {
      printf "<B>All Finals</b> for $form{'category'}<p>";
   }
   else {
      printf "<B>All Finals</b><p>";
   }

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada

   if ($form{'tour'} eq 'AMATEUR' && $form{'category'} eq 'Canada Mens Open') {
      printf "A note about the Canadian Men's Open tournaments: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 title, awarding
it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with this explanation; when
running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winning Team</b></td>
          <td><b>Losing Team</b></td>
          <td><b>Score</b></td>
          </tr>\n";

      $sql = "select winner_p1, winner_p2,loser_p1, loser_p2,score,city,event,date,season from results_doubles 
           where round='2' order by tmp_date desc;";
   }   
   else {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b><center>Winner Country</center></b></td>
          <td><b>Winner</b></td>
          <td><b><center>Loser Country</center></b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

      if ($form{'query'} eq 'finals_per_category') {
         if ($form{'category'} eq 'USA Mens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Mens%'"; }
         elsif ($form{'category'} eq 'USA Womens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Womens%'"; }
         elsif ($form{'category'} eq 'Mexico Mens Open') { $clause="city like '%MEX' and event like '%- Mens%'"; }   
         elsif ($form{'category'} eq 'Mexico Womens Open') { $clause="city like '%MEX' and event like '%- Womens%'"; }
         elsif ($form{'category'} eq 'Canada Mens Open') { $clause="city like '%CAN' and event like '%- Mens%'"; }
         elsif ($form{'category'} eq 'Canada Womens Open') { $clause="city like '%CAN' and event like '%- Womens%'"; } 
   	     # 11/17/17 added more Amateur categories
         elsif ($form{'category'} eq 'USA All') { $clause="(city not like '%MEX' and city not like '%CAN')"; } 
         elsif ($form{'category'} eq 'Mexico All') { $clause="city like '%MEX'"; } 
         elsif ($form{'category'} eq 'Canada All') { $clause="city like '%CAN'"; } 
         elsif ($form{'category'} eq 'All Men') { $clause="event like '%- Mens%'"; } 
         elsif ($form{'category'} eq 'All Women') { $clause="event like '%- Womens%'"; } 	  
   	  
         # 11/2/17; put in IRF categories	  
         elsif ($form{'category'} eq 'IRF All Men') { $clause="event like '% - Mens Open%'"; } 
         elsif ($form{'category'} eq 'IRF All Women') { $clause="event like '% - Womens Open%'"; } 
         elsif ($form{'category'} eq 'Pan American Championships - Mens Open') { $clause="(event like '%Pan American Championships%' 
   	                                                                                   or event like '%Pan American Racquetball Championships%')
   																					   and event like '% - Mens Open%'"; } 	  
         elsif ($form{'category'} eq 'Pan American Championships - Womens Open') { $clause="(event like '%Pan American Championships%' 
   	                                                                                   or event like '%Pan American Racquetball Championships%')
   																					   and event like '% - Womens Open%'"; } 	  																					   
         elsif ($form{'category'} eq 'World Championships - Mens Open') { $clause="(event like '%World Championships%' 
   	                                                                           or event like '%World Racquetball Championship%')
   																			   and event like '% - Mens Open%'"; }         
         elsif ($form{'category'} eq 'World Championships - Womens Open') { $clause="(event like '%World Championships%' 
   	                                                                           or event like '%World Racquetball Championship%')
   																			   and event like '% - Womens Open%'"; }      
         elsif ($form{'category'} eq 'Pan American Games - Mens Open') { $clause="(event like '%Pan American Games%')
   																			   and event like '% - Mens Open%'"; }   
         elsif ($form{'category'} eq 'Pan American Games - Womens Open') { $clause="(event like '%Pan American Games%')
   																			   and event like '% - Womens Open%'"; }   																			   
         elsif ($form{'category'} eq 'Pan American Sports Festival - Mens Open') { $clause="(event like '%Pan American Sports Festival%')
   																			   and event like '% - Mens Open%'"; }   
         elsif ($form{'category'} eq 'Pan American Sports Festival - Womens Open') { $clause="(event like '%Pan American Sports Festival%')
   																			   and event like '% - Womens Open%'"; }   	
   																			   
         # 11/15/17: put in Junior categories
         # Note the use of "Canad" instead of Canada or Canadian
         elsif ($form{'category'} eq 'All Boys 18U') { $clause="event like '%- Boys 18U%'"; } 	
         elsif ($form{'category'} eq 'All Boys 16U') { $clause="event like '%- Boys 16U%'"; } 	
         elsif ($form{'category'} eq 'All Girls 18U') { $clause="event like '%- Girls 18U%'"; } 	
         elsif ($form{'category'} eq 'All Girls 16U') { $clause="event like '%- Girls 16U%'"; } 	
         elsif ($form{'category'} eq 'All IRF') { $clause="event like '%World%'"; } 	
         elsif ($form{'category'} eq 'All USA') { $clause="event like '%USA%'"; } 	
         elsif ($form{'category'} eq 'All Mexico') { $clause="event like '%Mexico%'"; } 	
         elsif ($form{'category'} eq 'All Canada') { $clause="event like '%Canad%'"; } 	
         elsif ($form{'category'} eq 'All IRF Boys') { $clause="(event like '%World%' and event like '%Boys%')"; } 	
         elsif ($form{'category'} eq 'All USA Boys') { $clause="(event like '%USA%' and event like '%Boys%')"; } 	
         elsif ($form{'category'} eq 'All Mexico Boys') { $clause="(event like '%Mexico%' and event like '%Boys%')"; } 	
         elsif ($form{'category'} eq 'All Canada Boys') { $clause="(event like '%Canad%' and event like '%Boys%')"; } 
         elsif ($form{'category'} eq 'All IRF Girls') { $clause="(event like '%World%' and event like '%Girls%')"; } 	
         elsif ($form{'category'} eq 'All USA Girls') { $clause="(event like '%USA%' and event like '%Girls%')"; } 	
         elsif ($form{'category'} eq 'All Mexico Girls') { $clause="(event like '%Mexico%' and event like '%Girls%')"; } 	
         elsif ($form{'category'} eq 'All Canada Girls') { $clause="(event like '%Canad%' and event like '%Girls%')"; } 
         elsif ($form{'category'} eq 'IRF Boys 18U') { $clause="event like '%Junior World Championships - Boys 18U%'"; } 	
         elsif ($form{'category'} eq 'IRF Boys 16U') { $clause="event like '%Junior World Championships - Boys 16U%'"; } 		
         elsif ($form{'category'} eq 'IRF Girls 18U') { $clause="event like '%Junior World Championships - Girls 18U%'"; } 	
         elsif ($form{'category'} eq 'IRF Girls 16U') { $clause="event like '%Junior World Championships - Girls 16U%'"; } 	
         elsif ($form{'category'} eq 'USA Boys 18U') { $clause="event like '%USA Junior Nationals - Boys 18U%'"; } 	
         elsif ($form{'category'} eq 'USA Boys 16U') { $clause="event like '%USA Junior Nationals - Boys 16U%'"; } 		
         elsif ($form{'category'} eq 'USA Girls 18U') { $clause="event like '%USA Junior Nationals - Girls 18U%'"; } 	
         elsif ($form{'category'} eq 'USA Girls 16U') { $clause="event like '%USA Junior Nationals - Girls 16U%'"; } 	
         elsif ($form{'category'} eq 'Mexico Boys 18U') { $clause="event like '%Mexico Junior Nationals - Boys 18U%'"; } 	
         elsif ($form{'category'} eq 'Mexico Boys 16U') { $clause="event like '%Mexico Junior Nationals - Boys 16U%'"; } 		
         elsif ($form{'category'} eq 'Mexico Girls 18U') { $clause="event like '%Mexico Junior Nationals - Girls 18U%'"; } 	
         elsif ($form{'category'} eq 'Mexico Girls 16U') { $clause="event like '%Mexico Junior Nationals - Girls 16U%'"; } 	  
         elsif ($form{'category'} eq 'Canada Boys 18U') { $clause="event like '%Canada Junior Nationals - Boys 18U%'"; } 	
         elsif ($form{'category'} eq 'Canada Boys 16U') { $clause="event like '%Canada Junior Nationals - Boys 16U%'"; } 		
         elsif ($form{'category'} eq 'Canada Girls 18U') { $clause="event like '%Canada Junior Nationals - Girls 18U%'"; } 	
         elsif ($form{'category'} eq 'Canada Girls 16U') { $clause="event like '%Canada Junior Nationals - Girls 16U%'"; } 
   	  
         else {
            printf "Invalid form category passed $form{'category'}<P>";
         }
   
         $sql = "select winner,loser,score,city,event,date,season from results 
              where round='2' and $clause order by season desc, tmp_date desc, event asc;";
   		   
      } 
      else {
         $sql = "select winner,loser,score,city,event,date,season from results \
              where round='2' order by season desc, tmp_date desc, event asc;";
      }
   } # else non-IRT doubles query

   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      while (@row = $sth->fetchrow_array) {
         $winner_p1=$row[0];
         $winner_p2=$row[1];	  
         $loser_p1=$row[2];
         $loser_p2=$row[3];	  
         $score=$row[4];
         $city=$row[5];
         $event=$row[6];
         $date=$row[7];
         $season=$row[8];

         print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>F</td>
          <td>$winner_p1 / $winner_p2</td>
          <td>$loser_p1 / $loser_p2</td>
          <td>$score</td></tr>";
      }
   }
   else {
      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $loser=$row[1];
         $score=$row[2];
         $city=$row[3];
         $event=$row[4];
         $date=$row[5];
         $season=$row[6];

         # Capture countries for players

         $sql = "select country from player_profile where player='$winner';";
         printf "$sql" if $debug;
         $sth2 = $dbh->prepare($sql);
         $sth2->execute;
         while (@row2 = $sth2->fetchrow_array) {
            $winner_country=$row2[0];
         }

         $winner_country_code=&country_abbr($winner_country);

         $sql = "select country from player_profile where player='$loser';";
         printf "$sql" if $debug;
         $sth2 = $dbh->prepare($sql);
         $sth2->execute;
         while (@row2 = $sth2->fetchrow_array) {
            $loser_country=$row2[0];
         }

         $loser_country_code=&country_abbr($loser_country);

         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td><center>F</center></td>
             <td><center>$winner_country_code</center></td>
             <td>$winner</td>
             <td><center>$loser_country_code</center></td>
             <td>$loser</td>
             <td>$score</td></tr>";   
      }
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
sub all_major_finals() {

   printf "Entering all finals per event\n" if $debug;

   printf "All Major Finals<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   $sql = "select r.winner,r.loser,r.score,r.city,r.event,r.date,r.season \
           from results r, tourneys t \
           where r.event = t.event \
           and r.date = t.date \
           and r.round='2' \
           and t.major_flag='Y' \
           order by r.season desc, r.tmp_date desc";

   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $score=$row[2];
      $city=$row[3];
      $event=$row[4];
      $date=$row[5];
      $season=$row[6];

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>F</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td></tr>";
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 1/22/18: fixing this to get countries for all, not just IRFmatch

sub finals_by_season() {

   printf "Entering finals by season \n" if $debug;

   printf "<b>All Finals in $form{'season'}</b><p>";

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($form{'tour'} eq 'AMATEUR' && $form{'season'} eq '2006') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winning Team</b></td>
          <td><b>Losing Team</b></td>
          <td><b>Score</b></td>
          </tr>\n";

      $sql = "select winner_p1, winner_p2,loser_p1, loser_p2,score,city,event,date,season from results_doubles 
           where round='2' and season='$form{'season'}' order by tmp_date asc, event asc;";
   }
   else {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner Country</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser Country</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";
		  
      $sql = "select winner,loser,score,city,event,date,season from results \
           where round='2' and season='$form{'season'}' order by tmp_date asc, event asc";
   }   

   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {   
      while (@row = $sth->fetchrow_array) {
         $winner_p1=$row[0];
         $winner_p2=$row[1];	  
         $loser_p1=$row[2];
         $loser_p2=$row[3];	  
         $score=$row[4];
         $city=$row[5];
         $event=$row[6];
         $date=$row[7];
         $season=$row[8];

         print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>F</td>
          <td>$winner_p1 / $winner_p2</td>
          <td>$loser_p1 / $loser_p2</td>
          <td>$score</td></tr>";
      }
   }
   else {
      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $loser=$row[1];
         $score=$row[2];
         $city=$row[3];
         $event=$row[4];
         $date=$row[5];
         $season=$row[6];

         # Capture countries for players for IRF events and pro events.

         $sql = "select country from player_profile where player='$winner';";
         printf "$sql" if $debug;
         $sth2 = $dbh->prepare($sql);
         $sth2->execute;
         while (@row2 = $sth2->fetchrow_array) {
            $winner_country=$row2[0];
         }

         $winner_country_code=&country_abbr($winner_country);

         $sql = "select country from player_profile where player='$loser';";
         printf "$sql" if $debug;
         $sth2 = $dbh->prepare($sql);
         $sth2->execute;
         while (@row2 = $sth2->fetchrow_array) {
            $loser_country=$row2[0];
         }

         $loser_country_code=&country_abbr($loser_country);
			
         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td><center>F</center></td>
             <td><center>$winner_country_code</center></td>
             <td>$winner</td>
             <td><center>$loser_country_code</center></td>
             <td>$loser</td>
             <td>$score</td></tr>";  
      }
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
sub player_wl_round() {

   printf "Entering player_wl_round() \n" if $debug;

   if ($form{'query'} eq 'player_wl_finals') { 
      $round="=2"; 
      printf "Finals ";
   }
   elsif ($form{'query'} eq 'player_wl_semis') { 
      $round="=4"; 
      printf "Semis ";
   }
   elsif ($form{'query'} eq 'player_wl_qtrs') { 
      $round="=8"; 
      printf "Quarters ";
   }
   elsif ($form{'query'} eq 'player_wl_16s') { 
      $round="=16"; 
      printf "Round of 16 ";
   }
   elsif ($form{'query'} eq 'player_wl_early') { 
      $round=">16"; 
      printf "Early Rounds (32s, 64s, 128s and Round Robins for Intl Events) ";
   }
   else { 
      printf "we should never get here<br>"; 
   }

   $sql = "select count(*) from results where winner='$form{'player'}' and round $round";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }

   $sql = "select count(*) from results where loser='$form{'player'}' and round $round";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }

   print "Won-Loss Record for <b>$form{'player'}</b><br>";

   printf "Overall: $overall_wins - $overall_losses<br>\n";

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
   printf "Winning pct: $winning_pct<br>\n";
   ($junk,$junk,$overall_pct)=&gen_wl($form{'player'});
   printf "(Overall Winning pct on tour: $overall_pct)<br>\n";

   printf "<p>Season-by-season Results:<br>";
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>Percentage</b></td>
          </tr>\n";

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {
      printf "calculating win/loss for $season<br>" if $debug;

      $sql = "select count(*) from results where winner='$form{'player'}' \
              and season='$season' and round $round";
      $sth = $dbh->prepare($sql);
      $sth->execute;
         @rows = $sth->fetchrow_array;
         #&dump_array(@rows) if $debug;
         #printf "$wins\n" if $debug;
         $wins=$rows[0];

      $sql = "select count(*) from results where loser='$form{'player'}' \
              and season='$season' and round $round";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $losses=$rows[0];
         #printf "$losses[0]\n" if $debug;
      }

      if ($wins+$losses > 0) { 
         print "<tr><td>$season</td>";
         print "<td>$wins</td>";
         print "<td>$losses</td>";
         $season_winning_pct = ($wins/($wins+$losses));
         $season_winning_pct = sprintf("%.03f", $season_winning_pct);
      }
      else {
         next;
         $season_winning_pct = "0.000";
      }

      print "<td>$season_winning_pct</td>";
      
      print "</tr>";

   }
      
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	   
   

}

#--------------------------------------------------------------------------------
sub head_to_head() {

   $sql="select loser, count(loser) from results \
         where winner='$form{'player'}' group by loser";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $matrix{$player}="$losses-0";
   }

   $sql="select winner, count(winner) from results \
         where loser='$form{'player'}' group by winner";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, wins is $wins<br>\n";

      ($mwins,$mlosses) = split(/-/,$matrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $matrix{$player}="$mwins-$wins";
   }

   print "Head-to-Head Matrix for <b>$form{'player'}</b><br>";
   print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Won-Loss Against</b></td>
          </tr>\n";

   foreach $key ( sort keys %matrix ) {
      print "$key=$matrix{$key}<br>" if $debug;
      $losing_record="false";

      ($W,$L) = split(/-/,$matrix{$key});
      print "wins are $W, losses are $L<br>" if $debug;
     
      if ($L > $W) {
         $losing_record="true";
      }

      if ($losing_record eq "true") {
         print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$matrix{$key}</td></tr>";
      }
      else {
         print "<tr><td>$key</td><td align=center>$matrix{$key}</td></tr>";   
      }
      $losing_record="false";

      #print "wins are $matrix{$key}{wins}<br>";
      #print "losses are $matrix{$key}{losses}<br>";
      #foreach $key2 ( keys $matrix{$key} ) {
      #   print "$key2=$matrix{$key}{$key2}<br>";
      #}
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	   
   
}



#--------------------------------------------------------------------------------
# 10/24/17: head to head across tours.  Made this main to control multiple iterations of the query.
# 

sub head_to_head_cross_main() {

   printf "Entering head_to_head_main(), called by $form{'query'} <p>" if $debug;
    
   # Figure out which name is populated from the incoming form
   
   if ($form{'irtplayer'} ne '0') {
      $plyr=$form{'irtplayer'};
   }
   elsif ($form{'wrtplayer'} ne '0') {
      $plyr=$form{'wrtplayer'};
   }
   elsif ($form{'irfplayer'} ne '0') {
      $plyr=$form{'irfplayer'};
   }
   elsif ($form{'amateurplayer'} ne '0') {
      $plyr=$form{'amateurplayer'};
   }   
   elsif ($form{'juniorplayer'} ne '0') {
      $plyr=$form{'juniorplayer'};
   }   
   elsif ($form{'lprtplayer'} ne '0') {
      $plyr=$form{'lprtplayer'};
   }
   else {
      printf "<b>No player selected</b>; please hit back and select at least one player<p>";
   }
   
   printf "Player if-then-else completed: player selected is $plyr<p>" if $debug;   
   
   printf "<b>Consolidated Head to Head records</b> for <b>$plyr</b><p>";   
   
  

   #--------------------------------------------------------------------------------
   # IRT first

   open(my $fh, '<:encoding(UTF-8)', 'cp30725_men.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }     

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;
   
   # this gets 3 years prior to today out of the database, which we'll use just for the last 3 years query
   # we only need this once; its used throughout the rest.
   $sql="SELECT DATE_SUB(curdate(), INTERVAL 3 YEAR) from dual";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $dateprior=$row[0];
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	   
	  
   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $irtmatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   
   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$irtmatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $irtmatrix{$player}="$mwins-$wins";
   }
   
# commenting out the printing of intermediate tables.   
#   $count=%irtmatrix;
#   printf "count of records in irtmatrix is $count<p>" if $debug;     
#
#   if ($count eq '0') {
#      printf "<hr>No Match Records on the <b>IRT</b><br>";
#   }
#   else {
#      print "<hr>Head-to-Head Matrix on the <b>IRT</b> for <b>$plyr</b><br>";
#      print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";
#   
#      print "<table border><tr>\n";
#      print "<td><b>Player</b></td>
#             <td><b>Won-Loss Against</b></td>
#             </tr>\n";
#   
#      foreach $key ( sort keys %irtmatrix ) {
#         print "$key=$irtmatrix{$key}<br>" if $debug;
#         $losing_record="false";
#   
#         ($W,$L) = split(/-/,$irtmatrix{$key});
#         print "wins are $W, losses are $L<br>" if $debug;
#        
#         if ($L > $W) {
#            $losing_record="true";
#         }
#   
#         if ($losing_record eq "true") {
#            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$irtmatrix{$key}</td></tr>";
#         }
#         else {
#            print "<tr><td>$key</td><td align=center>$irtmatrix{$key}</td></tr>";   
#         }
#         $losing_record="false";
#      }
#   
#      print "</table>";
#   }
   
   #--------------------------------------------------------------------------------
   # WRT now

   $dbh->disconnect;
   
   open(my $fh, '<:encoding(UTF-8)', 'cp30725_wrt.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }   

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $wrtmatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$wrtmatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $wrtmatrix{$player}="$mwins-$wins";
   }

# commenting out the printing of intermediate tables. 
#   $count=%wrtmatrix;
#   printf "count of records in wrtmatrix is $count<p>" if $debug;  
#   
#   if ($count eq '0') {
#      printf "<hr>No Match Records on the <b>WRT</b><br>";
#   }
#   else {   
#      
#      print "<hr>Head-to-Head Matrix on the <b>WRT</b> for <b>$plyr</b><br>";
#      print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";
#   
#      print "<table border><tr>\n";
#      print "<td><b>Player</b></td>
#             <td><b>Won-Loss Against</b></td>
#             </tr>\n";
#   
#      foreach $key ( sort keys %wrtmatrix ) {
#         print "$key=$wrtmatrix{$key}<br>" if $debug;
#         $losing_record="false";
#   
#         ($W,$L) = split(/-/,$wrtmatrix{$key});
#         print "wins are $W, losses are $L<br>" if $debug;
#        
#         if ($L > $W) {
#            $losing_record="true";
#         }
#   
#         if ($losing_record eq "true") {
#            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$wrtmatrix{$key}</td></tr>";
#         }
#         else {
#            print "<tr><td>$key</td><td align=center>$wrtmatrix{$key}</td></tr>";   
#         }
#         $losing_record="false";
#      }
#   
#      print "</table>";   
#   }
   
   #--------------------------------------------------------------------------------
   # IRF now

   $dbh->disconnect;

   open(my $fh, '<:encoding(UTF-8)', 'cp30725_irf.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }      

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $irfmatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$irfmatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $irfmatrix{$player}="$mwins-$wins";
   }
   
# commenting out the printing of intermediate tables.    
#   $count=%irfmatrix;
#   printf "count of records in irfmatrix is $count<p>" if $debug;  
#
#   if ($count eq '0') {
#      printf "<hr>No Match Records on in the <b>IRF</b> database<br>";
#   }
#   else {
#   
#      print "<hr>Head-to-Head Matrix in <b>IRF Events</b> for <b>$plyr</b><br>";
#      print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";
#   
#      print "<table border><tr>\n";
#      print "<td><b>Player</b></td>
#             <td><b>Won-Loss Against</b></td>
#             </tr>\n";
#   
#      foreach $key ( sort keys %irfmatrix ) {
#         print "$key=$irfmatrix{$key}<br>" if $debug;
#         $losing_record="false";
#   
#         ($W,$L) = split(/-/,$irfmatrix{$key});
#         print "wins are $W, losses are $L<br>" if $debug;
#        
#         if ($L > $W) {
#            $losing_record="true";
#         }
#   
#         if ($losing_record eq "true") {
#            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$irfmatrix{$key}</td></tr>";
#         }
#         else {
#            print "<tr><td>$key</td><td align=center>$irfmatrix{$key}</td></tr>";   
#         }
#         $losing_record="false";
#      }
#   
#      print "</table>"; 
#   }

   #--------------------------------------------------------------------------------
   # Amateurs now
   
   $dbh->disconnect;

   open(my $fh, '<:encoding(UTF-8)', 'cp30725_amateur.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }      

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	 	 

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $amateurmatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$amateurmatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $amateurmatrix{$player}="$mwins-$wins";
   }
   
# commenting out the printing of intermediate tables.    
#   $count=%amateurmatrix;
#   printf "count of records in amateurmatrix is $count<p>" if $debug;   
#   
#   if ($count eq '0') {
#      printf "<hr>No Match Records in the <b>Amateur</b> database<br>";
#   }
#   else {   
#   
#      print "<hr>Head-to-Head Matrix in <b>Amateur Events</b> for <b>$plyr</b><br>";
#      print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";
#   
#      print "<table border><tr>\n";
#      print "<td><b>Player</b></td>
#             <td><b>Won-Loss Against</b></td>
#             </tr>\n";
#   
#      foreach $key ( sort keys %amateurmatrix ) {
#         print "$key=$amateurmatrix{$key}<br>" if $debug;
#         $losing_record="false";
#   
#         ($W,$L) = split(/-/,$amateurmatrix{$key});
#         print "wins are $W, losses are $L<br>" if $debug;
#        
#         if ($L > $W) {
#            $losing_record="true";
#         }
#   
#         if ($losing_record eq "true") {
#            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$amateurmatrix{$key}</td></tr>";
#         }
#         else {
#            print "<tr><td>$key</td><td align=center>$amateurmatrix{$key}</td></tr>";   
#         }
#         $losing_record="false";
#      }
#   
#      print "</table>";  
#   }

   #--------------------------------------------------------------------------------
   # Now Juniors now
   
   $dbh->disconnect;
   
   open(my $fh, '<:encoding(UTF-8)', 'cp30725_junior.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }   

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	 	 

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $juniormatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$juniormatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $juniormatrix{$player}="$mwins-$wins";
   }
   
   
   
   #--------------------------------------------------------------------------------
   # LPRT lastly now

   $dbh->disconnect;   

   open(my $fh, '<:encoding(UTF-8)', 'cp30725_women.txt') or die "Could not open file '$pwdfilename' $!";
   while (my $row = <$fh>) {
      chomp $row;
      ($fvariable,$fvariable_value) = split(/=/, $row);
      #print "$row<br>" if $debug;
      if ($fvariable =~ /^db_connect/) { $db_connect=$fvariable_value; }
	  if ($fvariable =~ /^db_user/) { $db_user=$fvariable_value; }
	  if ($fvariable =~ /^db_password/) {$db_password=$fvariable_value;}		 
   }      

   $dbh = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select loser, count(loser) from results where winner='$plyr' and tmp_date > '$dateprior' group by loser";
   }	 
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select loser, count(loser) from results where winner='$plyr' group by loser";
   }	 

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $lprtmatrix{$player}="$losses-0";
   }

   # logic to differentiate between all and last 3 years
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }	  
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select winner, count(winner) from results where loser='$plyr' and tmp_date > '$dateprior' group by winner";
   }	   
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select winner, count(winner) from results where loser='$plyr' group by winner";
   }

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);

      ($mwins,$mlosses) = split(/-/,$lprtmatrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $lprtmatrix{$player}="$mwins-$wins";
   }

## commenting out the printing of intermediate tables.  
#   $count=%lprtmatrix;
#   printf "count of records in lprtmatrix is $count<p>" if $debug;
#   
#   if ($count eq '0') {
#      printf "<hr>No Match Records on the <b>LPRT</b><br>";
#   }
#   else {   
#      
#      print "<hr>Head-to-Head Matrix on the <b>LPRT</b> for <b>$plyr</b><br>";
#      print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";
#   
#      print "<table border><tr>\n";
#      print "<td><b>Player</b></td>
#             <td><b>Won-Loss Against</b></td>
#             </tr>\n";
#   
#      foreach $key ( sort keys %lprtmatrix ) {
#         print "$key=$lprtmatrix{$key}<br>" if $debug;
#         $losing_record="false";
#   
#         ($W,$L) = split(/-/,$lprtmatrix{$key});
#         print "wins are $W, losses are $L<br>" if $debug;
#        
#         if ($L > $W) {
#            $losing_record="true";
#         }
#   
#         if ($losing_record eq "true") {
#            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$lprtmatrix{$key}</td></tr>";
#         }
#         else {
#            print "<tr><td>$key</td><td align=center>$lprtmatrix{$key}</td></tr>";   
#         }
#         $losing_record="false";
#      }
#   
#      print "</table>";   
#   }
   
#--------------------------------------------------------------------------------
   
   printf "This table shows the master matrix of Head to Head results across all available data in all six databases.  The data is 
   limited to more recent data in some years in some tours (IRF/Amateur/Juniors in particular).  The columns represent Won/Loss records per tour.<p>";
   
   printf "At the bottom of the H2H matrix is a summary of the player's W/L records across all tours and overall.<p>";
   
   print "<table border><tr>\n";
   
   print "<td><b>Player</b></td>
             <td><b>IRT W/L</b></td>
             <td><b>WRT W/L</b></td>
             <td><b>IRF W/L</b></td>
             <td><b>Amateur W/L</b></td>
             <td><b>Junior W/L</b></td>			 
             <td><b>LPRT W/L</b></td>	
             <td><b>Total Matchups</b></td>			 
             <td><b>Total W/L</b></td>			 
             </tr>\n";   
			 
   foreach $key ( sort keys %irtmatrix ) {
      print "IRTMatrix: $key=$irtmatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~IRT~$irtmatrix{$key}");
   }
   foreach $key ( sort keys %wrtmatrix ) {
      print "WRTMatrix: $key=$wrtmatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~WRT~$wrtmatrix{$key}");
   }	  
   foreach $key ( sort keys %irfmatrix ) {
      print "IRFMatrix: $key=$irfmatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~IRF~$irfmatrix{$key}");
   }	
   foreach $key ( sort keys %amateurmatrix ) {
      print "AmateurMatrix: $key=$amateurmatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~Amateur~$amateurmatrix{$key}");
   }	
   foreach $key ( sort keys %juniormatrix ) {
      print "JuniorMatrix: $key=$juniormatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~Junior~$juniormatrix{$key}");
   }	
   foreach $key ( sort keys %lprtmatrix ) {
      print "LPRTMatrix: $key=$lprtmatrix{$key}<br>" if $debug;
      push (@masterarray,"$key~LPRT~$lprtmatrix{$key}");
   }	

   #$sort_field=0;
   #@masterarray=&schwartzian_sort($sort_field,\@masterarray);

   @masterarray=sort(@masterarray);
   
   # Sort sorts ascending.  we want descending, from longest game to shortest.
   # @masterarray=&reverse_array(@masterarray);
   
   &dump_array(@masterarray) if $debug;
   
   # clean out hhmatrix table we're going to use.
   $sql="truncate table hhmatrix;";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;		   
   

   for $masterarraypossible (@masterarray) {  
      ($player,$tour,$record)=split(/~/,$masterarraypossible);   

      # we're still logged into the LPRT database, so use it's hhmatrix table to assist.

      $sql="select count(1) from hhmatrix where player='$player';";

      printf "$sql<br>" if $debug;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         ($tablecount)=($row[0]);
      }
	
      if ($tablecount eq '0') {
	     # new record
		 printf "Entering new record logic<p>" if $debug;
		 if ($tour eq 'IRT') { $sql="insert into hhmatrix (player,irt) values ('$player','$record')"; }
		 elsif ($tour eq 'WRT') { $sql="insert into hhmatrix (player,wrt) values ('$player','$record')"; }
		 elsif ($tour eq 'IRF') { $sql="insert into hhmatrix (player,irf) values ('$player','$record')"; }
		 elsif ($tour eq 'Amateur') { $sql="insert into hhmatrix (player,amateur) values ('$player','$record')"; }
		 elsif ($tour eq 'Junior') { $sql="insert into hhmatrix (player,junior) values ('$player','$record')"; }
		 elsif ($tour eq 'LPRT') { $sql="insert into hhmatrix (player,lprt) values ('$player','$record')"; }
		 else { 
		    printf "Invalid tour code $tour; You should never get here<p>"; 
	     }	
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;		 
	  }
	  else {
	     # existing record, we do updates
		 printf "Entering update record logic<p>" if $debug;
		 if ($tour eq 'IRT') { $sql="update hhmatrix set irt='$record' where player='$player'"; }
		 elsif ($tour eq 'WRT') { $sql="update hhmatrix set wrt='$record' where player='$player'"; }
		 elsif ($tour eq 'IRF') { $sql="update hhmatrix set irf='$record' where player='$player'"; }
		 elsif ($tour eq 'Amateur') { $sql="update hhmatrix set amateur='$record' where player='$player'"; }
		 elsif ($tour eq 'Junior') { $sql="update hhmatrix set junior='$record' where player='$player'"; }
		 elsif ($tour eq 'LPRT') { $sql="update hhmatrix set lprt='$record' where player='$player'"; }		 
		 else { 
		    printf "Invalid tour code $tour; You should never get here<p>"; 
	     }	
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;		
	  }
   }   
   
   # this updates the total matches column in the database for further sorting
   
   $sql="update hhmatrix set total=(ifnull(substring_index(irt,'-',1),0) + ifnull(substring_index(irt,'-',-1),0) + 
                                    ifnull(substring_index(wrt,'-',1),0) + ifnull(substring_index(wrt,'-',-1),0) + 
									ifnull(substring_index(irf,'-',1),0) + ifnull(substring_index(irf,'-',-1),0) + 
									ifnull(substring_index(amateur,'-',1),0) + ifnull(substring_index(amateur,'-',-1),0) + 
									ifnull(substring_index(junior,'-',1),0) + ifnull(substring_index(junior,'-',-1),0) + 
									ifnull(substring_index(lprt,'-',1),0) + ifnull(substring_index(lprt,'-',-1),0));";   
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;	
									
   # control the order of the data depending on the query called ... one sorts alphabetically, the other by total desc
   if ($form{'query'} eq 'head_to_head_cross') {
      $sql="select player,irt,wrt,irf,amateur,junior,lprt,total from hhmatrix order by player asc;";
   }
   if ($form{'query'} eq 'head_to_head_cross_ttl') {
      $sql="select player,irt,wrt,irf,amateur,junior,lprt,total from hhmatrix order by total desc;";
   }	
   if ($form{'query'} eq 'head_to_head_cross_3yr') {
      $sql="select player,irt,wrt,irf,amateur,junior,lprt,total from hhmatrix order by player asc;";
   }							
   if ($form{'query'} eq 'nontriv_head_to_head_cross') {
      $sql="select player,irt,wrt,irf,amateur,junior,lprt,total from hhmatrix where total > 2 order by player asc;";
   }	

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;	

   # counters to keep track of all the wins/losses by tour
   $totalW=0;
   $totalL=0;
   $overallW=0;
   $overallL=0;
   $irtW=0;
   $irtL=0;
   $wrtW=0;
   $wrtL=0;
   $irfW=0;
   $irfL=0;
   $amateurW=0;
   $amateurL=0;
   $juniorW=0;
   $juniorL=0;
   $lprtW=0;
   $lprtL=0;
   
   
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
	  $irtrecord=$row[1];
	  $wrtrecord=$row[2];
	  $irfrecord=$row[3];
	  $amateurrecord=$row[4];
	  $juniorrecord=$row[5];	  
	  $lprtrecord=$row[6];
	  $totalmatches=$row[7];	  
	  
      ($W,$L) = split(/-/,$irtrecord);
	  $totalW+=$W;
	  $irtW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $irtL+=$L;
	  $overallL+=$L;	  
      if ($L > $W) { $irtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$irtrecord</td>" } else {$irtrecordstring="<td><center>$irtrecord</center></b></td>" }
	  
      ($W,$L) = split(/-/,$wrtrecord);
	  $totalW+=$W;
	  $wrtW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $wrtL+=$L;
	  $overallL+=$L; 	  
      if ($L > $W) { $wrtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$wrtrecord</td>" } else {$wrtrecordstring="<td><center>$wrtrecord</center></b></td>" }

	  ($W,$L) = split(/-/,$irfrecord);
	  $totalW+=$W;
	  $irfW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $irfL+=$L;
	  $overallL+=$L; 	  
      if ($L > $W) { $irfrecordstring="<td align=center bgcolor=\"#C0C0C0\">$irfrecord</td>" } else {$irfrecordstring="<td><center>$irfrecord</center></b></td>" }
	  
      ($W,$L) = split(/-/,$amateurrecord);
	  $totalW+=$W;
	  $amateurW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $amateurL+=$L;
	  $overallL+=$L; 	  
      if ($L > $W) { $amateurrecordstring="<td align=center bgcolor=\"#C0C0C0\">$amateurrecord</td>" } else {$amateurrecordstring="<td><center>$amateurrecord</center></b></td>" }

      ($W,$L) = split(/-/,$juniorrecord);
	  $totalW+=$W;
	  $juniorW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $juniorL+=$L;
	  $overallL+=$L; 	  
      if ($L > $W) { $juniorrecordstring="<td align=center bgcolor=\"#C0C0C0\">$juniorrecord</td>" } else {$juniorrecordstring="<td><center>$juniorrecord</center></b></td>" }
  
	  ($W,$L) = split(/-/,$lprtrecord);
	  $totalW+=$W;
	  $lprtW+=$W;
	  $overallW+=$W;
	  $totalL+=$L;	
	  $lprtL+=$L;
	  $overallL+=$L; 	  
      if ($L > $W) { $lprtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$lprtrecord</td>" } else {$lprtrecordstring="<td><center>$lprtrecord</center></b></td>" }
	  
	  if ($totalL > $totalW) { $ttlrecordstring="<td align=center bgcolor=\"#C0C0C0\">$totalW-$totalL</td>" } else {$ttlrecordstring="<td><center>$totalW-$totalL</center></b></td>" }
	 
      $totalmatchupstring="<td><center>$totalmatches</center></b></td>";
	  
	  print "<td><b>$player</b></td>
             $irtrecordstring
             $wrtrecordstring
             $irfrecordstring
             $amateurrecordstring
             $juniorrecordstring			 
             $lprtrecordstring	
             $totalmatchupstring			 
             $ttlrecordstring			 
             </tr>\n";   

   # reset the counters
   $totalW=0;
   $totalL=0;
 

   }
   
   print "</table>";     
   
   print "<p><b>Overall Records Summary</b>: this table summarizes JUST the head to head records shown above; if you have filtered for the past 3 years, or 
   filtered for just non-trivial matchups, then these are NOT career records on each tour or overall.  <p>";
   
   print "<table border><tr>\n";

   print "<td><b>Player</b></td>
             <td><b>IRT Overall W/L</b></td>
             <td><b>WRT Overall W/L</b></td>
             <td><b>IRF Overall W/L</b></td>
             <td><b>Amateur Overall W/L</b></td>
             <td><b>Junior Overall W/L</b></td>			 
             <td><b>LPRT Overall W/L</b></td>			 
             <td><b>Total Overall W/L</b></td>			 
             </tr>\n";    
   
   if ($irtL > $irtW) { $irtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$irtW-$irtL</td>" } 
   else {$irtrecordstring="<td><center>$irtW-$irtL</center></b></td>" }

   if ($wrtL > $wrtW) { $wrtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$wrtW-$wrtL</td>" } 
   else {$wrtrecordstring="<td><center>$wrtW-$wrtL</center></b></td>" }

   if ($irfL > $irfW) { $irfrecordstring="<td align=center bgcolor=\"#C0C0C0\">$irfW-$irfL</td>" } 
   else {$irfrecordstring="<td><center>$irfW-$irfL</center></b></td>" }

   if ($amateurL > $amateurW) { $amateurrecordstring="<td align=center bgcolor=\"#C0C0C0\">$amateurW-$amateurL</td>" } 
   else {$amateurrecordstring="<td><center>$amateurW-$amateurL</center></b></td>" }

   if ($juniorL > $juniorW) { $juniorrecordstring="<td align=center bgcolor=\"#C0C0C0\">$juniorW-$juniorL</td>" } 
   else {$juniorrecordstring="<td><center>$juniorW-$juniorL</center></b></td>" }
   
   if ($lprtL > $lprtW) { $lprtrecordstring="<td align=center bgcolor=\"#C0C0C0\">$lprtW-$lprtL</td>" } 
   else {$lprtrecordstring="<td><center>$lprtW-$lprtL</center></b></td>" }

   if ($overallL > $overallW) { $overallrecordstring="<td align=center bgcolor=\"#C0C0C0\">$overallW-$overallL</td>" } 
   else {$overallrecordstring="<td><center>$overallW-$overallL</center></b></td>" }
   
   print "<td><b>$plyr</b></td>
             $irtrecordstring
             $wrtrecordstring
             $irfrecordstring
             $amateurrecordstring
             $juniorrecordstring			 
             $lprtrecordstring		 
             $overallrecordstring			 
             </tr>\n";	 
			 
   print "</table>";    
   &print_back_link;   
   printf "</body></html>";	      
      
}





#--------------------------------------------------------------------------------
# 8/5/14 head to head sorted by ttl matchups

sub head_to_head_ttl() {

   $sql="select loser, count(loser) from results \
         where winner='$form{'player'}' group by loser";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $matrix{$player}="$losses-0";
   }

   $sql="select winner, count(winner) from results \
         where loser='$form{'player'}' group by winner";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, wins is $wins<br>\n";

      ($mwins,$mlosses) = split(/-/,$matrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $matrix{$player}="$mwins-$wins";
   }

   print "Head-to-Head Matrix for <b>$form{'player'}</b><br>";
   print "Sorted by opponent last name (shaded means the player has a losing record against the opponent)<br><br>";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Total Matchups</b></td>
          <td><b>Won-Loss Against</b></td>
          </tr>\n";

   foreach $key ( sort keys %matrix ) {
      ($W,$L) = split(/-/,$matrix{$key});
      $ttlmatches=$W+$L;
      
      $possible="$key~$W~$L~$ttlmatches";
      push (@possibles,$possible);
   }

   &dump_array(@possibles) if $debug;

   # Sort the possibles by the number of matchups
   $sort_field=3;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @possibles=&reverse_array(@possibles);

   foreach $line (@possibles) {
      printf "$line<br>" if $debug;

      ($opponent,$W,$L,$ttlmatches) = split(/~/,$line);
   
      if ($L > $W) {
         print "<tr><td bgcolor=\"#C0C0C0\">$opponent</td><td align=center bgcolor=\"#C0C0C0\">$ttlmatches</td><td align=center bgcolor=\"#C0C0C0\">$W-$L</td></tr>";
      }
      else {
         print "<tr><td>$opponent</td><td align=center>$ttlmatches</td><td align=center>$W-$L</td></tr>";   
      }
   }
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      
}



#--------------------------------------------------------------------------------
# added 10/21/08 to get more recent head to head records

sub head_to_head_3yr() {

   # this gets 3 years prior to today out of the database
   $sql="SELECT DATE_SUB(curdate(), INTERVAL 3 YEAR) from dual";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $dateprior=$row[0];
   }

   $sql="select loser, count(loser) from results \
         where winner='$form{'player'}' and tmp_date > '$dateprior' group by loser";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $matrix{$player}="$losses-0";
   }

   $sql="select winner, count(winner) from results \
         where loser='$form{'player'}' and tmp_date > '$dateprior' group by winner";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, wins is $wins<br>\n";

      ($mwins,$mlosses) = split(/-/,$matrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $matrix{$player}="$mwins-$wins";
   }

   print "Head-to-Head Matrix for <b>$form{'player'} From the past 3 calendar years</b><br>:";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Won-Loss Against</b></td>
          </tr>\n";

   foreach $key ( sort keys %matrix ) {
      print "$key=$matrix{$key}<br>" if $debug;
      $losing_record="false";

      ($W,$L) = split(/-/,$matrix{$key});
      print "wins are $W, losses are $L<br>" if $debug;
     
      if ($L > $W) {
         $losing_record="true";
      }

      if ($losing_record eq "true") {
         print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$matrix{$key}</td></tr>";
      }
      else {
         print "<tr><td>$key</td><td align=center>$matrix{$key}</td></tr>";   
      }
      $losing_record="false";

      #print "wins are $matrix{$key}{wins}<br>";
      #print "losses are $matrix{$key}{losses}<br>";
      #foreach $key2 ( keys $matrix{$key} ) {
      #   print "$key2=$matrix{$key}{$key2}<br>";
      #}
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      
}

#--------------------------------------------------------------------------------
sub nontriv_head_to_head() {

   $sql="select loser, count(loser) from results \
         where winner='$form{'player'}' group by loser";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $matrix{$player}="$losses-0";
   }

   $sql="select winner, count(winner) from results \
         where loser='$form{'player'}' group by winner";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, wins is $wins<br>\n";

      ($mwins,$mlosses) = split(/-/,$matrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $matrix{$player}="$mwins-$wins";
   }

   print "Frequently played Head-to-Head Matrix for <b>$form{'player'}</b>:<br>";

   printf "Note: only if players have played more than 2 times are the results listed here<p>";

   if ($form{'tour'} eq 'IRT') {   
      printf "Note: all unknown round-of-32 or earlier entries have been entered as Wins for the \
              player over opponent '?' hence the large number of ? records for some players.<p>";
   }

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Won-Loss Against</b></td>
          </tr>\n";

   foreach $key ( sort keys %matrix ) {
      print "$key=$matrix{$key}<br>" if $debug;

      $losing_record="false";

      ($W,$L) = split(/-/,$matrix{$key});
      
      $matches=($W+$L);
      if ($L > $W) {
         $losing_record="true";
      } 

      printf "wins are $W, losses are $L, matches is $matches<br>" if $debug;

      if ($matches > 2) {
         if ($losing_record eq "true") {
            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$matrix{$key}</td></tr>";
         }
         else {
            print "<tr><td>$key</td><td align=center>$matrix{$key}</td></tr>";
         }
      }
      $losing_record="false";

      #print "wins are $matrix{$key}{wins}<br>";
      #print "losses are $matrix{$key}{losses}<br>";
      #foreach $key2 ( keys $matrix{$key} ) {
      #   print "$key2=$matrix{$key}{$key2}<br>";
      #}
   }
   
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	      

}

#--------------------------------------------------------------------------------
# 11/13/09: adding in list of results, per request from User.
sub nontriv_head_to_head_withresults() {

   $sql="select loser, count(loser) from results \
         where winner='$form{'player'}' group by loser";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$losses)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, losses is $losses<br>\n";

      $matrix{$player}="$losses-0";
   }

   $sql="select winner, count(winner) from results \
         where loser='$form{'player'}' group by winner";

   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins)=($row[0],$row[1]);
      #&dump_array(@row) if $debug;
      #push (@losses,@row);

      #printf "player is $player, wins is $wins<br>\n";

      ($mwins,$mlosses) = split(/-/,$matrix{$player});

      if ($mwins eq '') {
         $mwins=0;
      }

      $matrix{$player}="$mwins-$wins";
   }

   print "Frequently played Head-to-Head Matrix for <b>$form{'player'}</b>:<p>";

   printf "Note: only if players have played more than 2 times are the results listed here<p>";

   if ($form{'tour'} eq 'IRT') {   
      printf "Note: all unknown round-of-32 or earlier entries have been entered as Wins for the \
              player over opponent '?' hence the large number of ? records for some players.<p>";
   }

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Won-Loss Against</b></td>
          </tr>\n";

   printf "*** about to loop through matrix<br>" if $debug;

   foreach $key ( sort keys %matrix ) {
      printf "within Matrix: $key=$matrix{$key}<br>" if $debug;

      $losing_record="false";

      ($W,$L) = split(/-/,$matrix{$key});
      
      $matches=($W+$L);
      if ($L > $W) {
         $losing_record="true";
      } 

      printf "wins are $W, losses are $L, matches is $matches<br>" if $debug;

      if ($matches > 2) {
         if ($losing_record eq "true") {
            print "<tr><td bgcolor=\"#C0C0C0\">$key</td><td align=center bgcolor=\"#C0C0C0\">$matrix{$key}</td></tr>";
         }
         else {
            print "<tr><td>$key</td><td align=center>$matrix{$key}</td></tr>";
         }
      }
      $losing_record="false";

      #print "wins are $matrix{$key}{wins}<br>";
      #print "losses are $matrix{$key}{losses}<br>";
      #foreach $key2 ( keys $matrix{$key} ) {
      #   print "$key2=$matrix{$key}{$key2}<br>";
      #}
   }

   print "</table>";

   printf "<p><b>Opponent-by-Opponent actual Results</b><p>";

   # Now, loop through to print actual head to head results.
   foreach $key ( sort keys %matrix ) {
      printf "within Matrix, 2nd time: $key=$matrix{$key}<br>" if $debug;

      ($W,$L) = split(/-/,$matrix{$key});
      
      $matches=($W+$L);

      printf "wins are $W, losses are $L, matches is $matches<br>" if $debug;

      if ($matches > 2) {
         $sql = "select winner,loser,round,score,city,event,tmp_date,season from results 
                    where winner='$key' and loser='$form{'player'}'
                 union
                 select winner,loser,round,score,city,event,tmp_date,season from results
                    where loser='$key' and winner='$form{'player'}'
                 order by tmp_date asc";
         printf "$sql\n" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;

         printf "<p><b>$form{'player'}</b> versus Opponent <b>$key</b>.  Record: $W-$L<br>";

         print "<table border><tr>\n";
         print "<td><b>Season</b></td>
                <td><b>Date</b></td>
                <td><b>City</b></td>
                <td><b>Event</b></td>
                <td><b>Round</b></td>
                <td><b>Winner</b></td>
                <td><b>Loser</b></td>
                <td><b>Score</b></td>
                </tr>\n";

         while (@row = $sth->fetchrow_array) {
            $winner=$row[0];
            $loser=$row[1];
            $round=$row[2];
            $score=$row[3];
            $city=$row[4];
            $event=$row[5];
            $date=$row[6];
            $season=$row[7];

            $new_round=&fix_round($round);

            print "<tr><td>$season</td>
                <td>$date</td>
                <td>$city</td>
                <td>$event</td>
                <td>$new_round</td>
                <td>$winner</td>
                <td>$loser</td>
                <td>$score</td>
                </tr>";

         }
         print "</table>\n";
   
      }
   } 
   
   &print_back_link;   
   printf "</body></html>";	
}


#--------------------------------------------------------------------------------
# 1/26/14: getting first initials of players to distinguish between Carsons, Rojas brothers
# so adding first inits throughout this entire subroutine.  If adding more names to use inits with,
# must add in several places in this routine.
# 10/14/17: added in event to this query as well; it was reporting duplicates for IRF data.
# 10/28/17: updated to handle the per-category logic for Amateur events
# 11/2/17: added in IRF categories
# 1/21/18: overloaded this with all_qsf


sub qsf_by_season() {

   printf "Entering quarters/semis/final by season \n" if $debug;

   if ($form{'query'} eq 'qsf_per_category') {
      printf "<b>Quarters/Semis/Finals for $form{'category'}</b><p>";
   }
   elsif ($form{'query'} eq 'all_qsf') {
      printf "<b>Quarters/Semis/Finals for All tournaments in the database</b><p>";
   }
   else {
      printf "<b>Quarters/Semis/Finals for season $form{'season'}</b><p>";
   }


   if ($form{'tour'} eq 'AMATEUR') {
      print "<p>Note: Some amateur associations play a 3rd place game; this query just shows semi finalists but does not show the 3rd place game results. 
	  To find those results, see the full match results for the tournament in question, where it is reported.<p>";
   }   

   if ($form{'tour'} eq 'JUNIOR') {
      print "<p>Note: Some Junior amateur associations play a 3rd place game; this query just shows semi finalists but does not show the 3rd place game results. 
	  To find those results, see the full match results for the tournament in question, where it is reported.<p>";
      print "<p>Note: Some Junior draws are small enough to be settled with round robins: if the table below does not show quarterfinalists and/or semi finalists, 
	  then it is likely the finishers were determined by Round Robin play.  We have put in a 'fake' final between the top two finishers to show the winner and
	  2nd place but have left the other matches as RR play.  See the full match results for the tournament in question to see these results.<p>";
   }   

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($form{'tour'} eq 'AMATEUR' && $form{'season'} eq '2006') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }

   print "<table border><tr>\n";
   print "<td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Final</b></td>
          <td><b>Semis</b></td>
          <td><b>Quarters</b></td>
          </tr>\n";

   if ($form{'query'} eq 'qsf_per_category') {
      if ($form{'category'} eq 'USA Mens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Mens%'"; }
      elsif ($form{'category'} eq 'USA Womens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Womens%'"; }
      elsif ($form{'category'} eq 'Mexico Mens Open') { $clause="city like '%MEX' and event like '%- Mens%'"; }   
      elsif ($form{'category'} eq 'Mexico Womens Open') { $clause="city like '%MEX' and event like '%- Womens%'"; }
      elsif ($form{'category'} eq 'Canada Mens Open') { $clause="city like '%CAN' and event like '%- Mens%'"; }
      elsif ($form{'category'} eq 'Canada Womens Open') { $clause="city like '%CAN' and event like '%- Womens%'"; }   
	  # 11/17/17 added more Amateur categories
      elsif ($form{'category'} eq 'USA All') { $clause="(city not like '%MEX' and city not like '%CAN')"; } 
      elsif ($form{'category'} eq 'Mexico All') { $clause="city like '%MEX'"; } 
      elsif ($form{'category'} eq 'Canada All') { $clause="city like '%CAN'"; } 
      elsif ($form{'category'} eq 'All Men') { $clause="event like '%- Mens%'"; } 
      elsif ($form{'category'} eq 'All Women') { $clause="event like '%- Womens%'"; } 	
	  
      # 11/2/17; put in IRF categories	  
      elsif ($form{'category'} eq 'IRF All Men') { $clause="event like '% - Mens Open%'"; } 
      elsif ($form{'category'} eq 'IRF All Women') { $clause="event like '% - Womens Open%'"; } 
      elsif ($form{'category'} eq 'Pan American Championships - Mens Open') { $clause="(event like '%Pan American Championships%' 
	                                                                                   or event like '%Pan American Racquetball Championships%')
																					   and event like '% - Mens Open%'"; } 	  
      elsif ($form{'category'} eq 'Pan American Championships - Womens Open') { $clause="(event like '%Pan American Championships%' 
	                                                                                   or event like '%Pan American Racquetball Championships%')
																					   and event like '% - Womens Open%'"; } 	  																					   
      elsif ($form{'category'} eq 'World Championships - Mens Open') { $clause="(event like '%World Championships%' 
	                                                                           or event like '%World Racquetball Championship%')
																			   and event like '% - Mens Open%'"; }         
      elsif ($form{'category'} eq 'World Championships - Womens Open') { $clause="(event like '%World Championships%' 
	                                                                           or event like '%World Racquetball Championship%')
																			   and event like '% - Womens Open%'"; }      
      elsif ($form{'category'} eq 'Pan American Games - Mens Open') { $clause="(event like '%Pan American Games%')
																			   and event like '% - Mens Open%'"; }   
      elsif ($form{'category'} eq 'Pan American Games - Womens Open') { $clause="(event like '%Pan American Games%')
																			   and event like '% - Womens Open%'"; }   																			   
      elsif ($form{'category'} eq 'Pan American Sports Festival - Mens Open') { $clause="(event like '%Pan American Sports Festival%')
																			   and event like '% - Mens Open%'"; }   
      elsif ($form{'category'} eq 'Pan American Sports Festival - Womens Open') { $clause="(event like '%Pan American Sports Festival%')
																			   and event like '% - Womens Open%'"; }  	

      # 11/15/17: put in Junior categories
      # Note the use of "Canad" instead of Canada or Canadian
      elsif ($form{'category'} eq 'All Boys 18U') { $clause="event like '%- Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'All Boys 16U') { $clause="event like '%- Boys 16U%'"; } 	
      elsif ($form{'category'} eq 'All Girls 18U') { $clause="event like '%- Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'All Girls 16U') { $clause="event like '%- Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'All IRF') { $clause="event like '%World%'"; } 	
      elsif ($form{'category'} eq 'All USA') { $clause="event like '%USA%'"; } 	
      elsif ($form{'category'} eq 'All Mexico') { $clause="event like '%Mexico%'"; } 	
      elsif ($form{'category'} eq 'All Canada') { $clause="event like '%Canad%'"; } 	
      elsif ($form{'category'} eq 'All IRF Boys') { $clause="(event like '%World%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All USA Boys') { $clause="(event like '%USA%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All Mexico Boys') { $clause="(event like '%Mexico%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All Canada Boys') { $clause="(event like '%Canad%' and event like '%Boys%')"; } 
      elsif ($form{'category'} eq 'All IRF Girls') { $clause="(event like '%World%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All USA Girls') { $clause="(event like '%USA%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All Mexico Girls') { $clause="(event like '%Mexico%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All Canada Girls') { $clause="(event like '%Canad%' and event like '%Girls%')"; } 
      elsif ($form{'category'} eq 'IRF Boys 18U') { $clause="event like '%Junior World Championships - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'IRF Boys 16U') { $clause="event like '%Junior World Championships - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'IRF Girls 18U') { $clause="event like '%Junior World Championships - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'IRF Girls 16U') { $clause="event like '%Junior World Championships - Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'USA Boys 18U') { $clause="event like '%USA Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'USA Boys 16U') { $clause="event like '%USA Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'USA Girls 18U') { $clause="event like '%USA Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'USA Girls 16U') { $clause="event like '%USA Junior Nationals - Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Boys 18U') { $clause="event like '%Mexico Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Boys 16U') { $clause="event like '%Mexico Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'Mexico Girls 18U') { $clause="event like '%Mexico Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Girls 16U') { $clause="event like '%Mexico Junior Nationals - Girls 16U%'"; } 	  
      elsif ($form{'category'} eq 'Canada Boys 18U') { $clause="event like '%Canada Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'Canada Boys 16U') { $clause="event like '%Canada Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'Canada Girls 18U') { $clause="event like '%Canada Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'Canada Girls 16U') { $clause="event like '%Canada Junior Nationals - Girls 16U%'"; } 
      else {
         printf "Invalid form category passed $form{'category'}<P>";
      }

      $sql = "select winner,loser,score,city,event,date,season from results 
           where round='2' and $clause order by season desc, tmp_date desc, event asc;";
   }
   elsif ($form{'query'} eq 'all_qsf') {
      $sql = "select winner,loser,score,city,event,date from results \
           where round='2' order by tmp_date desc";
   } 
   else {
      $sql = "select winner,loser,score,city,event,date from results \
           where round='2' and season='$form{'season'}' order by tmp_date";
   }


   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $score=$row[2];
      $city=$row[3];
      $event=$row[4];
      $date=$row[5];

      ($wlname,$wfname)=split(/,/,$winner);
      ($llname,$lfname)=split(/,/,$loser);

      # must trim leading spaces from the first names in order to get the first initial
      $wfname =~ s/^\s+//;
      $wfname =~ s/\s+$//;
      $lfname =~ s/^\s+//;
      $lfname =~ s/\s+$//;

      $firstinitwinner=substr($wfname,0,1);
      $firstinitloser=substr($lfname,0,1);
      
# First Initial Last Name logic using dup_last_name variable...
      if ($wlname =~ /$dup_last_names/) {
         $wlname="${firstinitwinner}.${wlname}";
      }
      if ($llname =~ /$dup_last_names/) {
         $llname="${firstinitloser}.${llname}";
      }

      printf "winner first name is $wfname, loser first name is $lfname <br>" if $debug;      
      printf "winner first init is $firstinitwinner , loser first init is $firstinitloser <br>" if $debug;      
 
# now this sql will print the first init/last name for Carson/Rojas/Franco but just last name for others.
      print "<td>$date</td>
       <td>$city</td>
       <td>$event</td>
       <td>${wlname} d ${llname} $score</td>";

      $sql = "select loser from results \
              where round='4' and event='$event' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($slname,$slfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $slfname=~ s/^\s+//;
          $slfname =~ s/\s+$//;
          $sfirstinit = substr($slfname, 0, 1);

# First Initial Last Name logic using dup_last_name variable...
          if ($slname =~ /$dup_last_names/) {
            $slname="${sfirstinit}.${slname}";
          }

          print "${slname}";
          print ", " if $i==0;
          $i++;
      }
      print "</td>";


      $sql = "select loser from results \
              where round='8' and event='$event' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($qlname,$qlfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $qlfname=~ s/^\s+//;
          $qlfname =~ s/\s+$//;
          $qfirstinit = substr($qlfname, 0, 1);

# First Initial Last Name logic using dup_last_name variable...
          if ($qlname =~ /$dup_last_names/) {
            $qlname="${qfirstinit}.${qlname}";
          }

          print "${qlname}";
          print ", " if $i<3;
          $i++;
      }
      print "</td></tr>";
         
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	
}




#--------------------------------------------------------------------------------
# 1/21/18: countries of origin
# 


sub all_qsf_country() {

   printf "Entering quarters/semis/final country of origin \n" if $debug;

   printf "<b>Quarters/Semis/Finals Country of Origin</b>: this only prints the country of origin for those making Qtrs/Semis/finals.  If the code is 'UNK' then
           we are missing the player profile data for that finisher.  If the field is blank, it means either the player is a '?' in the results or the
           finisher is flat out unknown.<p>";
 

   print "<table border><tr>\n";
   print "<td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Final Countries</b></td>
          <td><b>Semis Countries</b></td>
          <td><b>Quarters Countries</b></td>
          </tr>\n";

   # start with the finalists; we're assuming that all finalists have an entry in player_profile 
   $sql = "select r.winner,p1.country, r.loser,p2.country,r.score,r.city,r.event,r.date 
           from results r, player_profile p1, player_profile p2
           where r.winner = p1.player
           and r.loser = p2.player
           and r.round='2' order by r.tmp_date;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $winner_country=$row[1];
      $loser=$row[2];
      $loser_country=$row[3];
      $score=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];

      if ($winner_country eq '') { $winner_country="Unknown"; }
      if ($loser_country eq '') { $loser_country="Unknown"; }

      if ($winner eq '?') { $winner_country=''; }
      if ($loser eq '?') { $loser_country=''; }

      $winner_country_abbr=&country_abbr($winner_country);
      $loser_country_abbr=&country_abbr($loser_country);


      print "<td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$winner_country_abbr d $loser_country_abbr</td>";

      # Now get semis
      $sql = "select r.loser, p1.country 
              from results r left join player_profile p1 on r.loser = p1.player
              where r.round='4' and r.event='$event' and r.date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
         ($semis_loser)=$row2[0];
         ($semis_loser_country)=$row2[1];
         if ($semis_loser_country eq '') { $semis_loser_country="Unknown"; }
         if ($semis_loser eq '?') { $semis_loser_country=''; }

         $semis_loser_country_abbr=&country_abbr($semis_loser_country);

         print "${semis_loser_country_abbr}";
         print ", " if $i==0;
         $i++;
      }
      print "</td>";

      # now get quarters
      $sql = "select r.loser, p1.country 
              from results r left join player_profile p1 on r.loser = p1.player 
              where r.round='8' and r.event='$event' and r.date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
         ($qtrs_loser)=$row2[0];
         ($qtrs_loser_country)=$row2[1];
         if ($qtrs_loser_country eq '') { $qtrs_loser_country="Unknown"; }
         if ($qtrs_loser eq '?') { $qtrs_loser_country=''; }

         $qtrs_loser_country_abbr=&country_abbr($qtrs_loser_country);

          print "${qtrs_loser_country_abbr}";
          print ", " if $i<3;
          $i++;
      }
      print "</td></tr>";
         
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	
}







#--------------------------------------------------------------------------------
sub career_best() {

   printf "Entering player career best<br>" if $debug;

   $sql = "select min(round) from results 
           where loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $min_lost=$row[0];
   }
   $sql = "select min(round) from results 
           where winner='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $min_won=$row[0];
   }

   printf "min lost is $min_lost, min won is $min_won<br>" if $debug;

   if ($min_won eq "2") {
      $where_clause="winner='$form{'player'}' and round=2";
   }
   else {
      $where_clause="loser='$form{'player'}' and round=$min_lost";
   }

   print "<p>Best Career Results for <b>$form{'player'}</b><br>";
   
   if ($form{'tour'} eq 'AMATEUR') {
      print "Note: this query does not show 3rd place games, if they occurred.<p>"
   }

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where $where_clause";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	   

}

#--------------------------------------------------------------------------------
sub distinct_winners() {
   printf "Entering distinct winners<br>" if $debug;

   $sql = "select count(distinct(winner)) from results
           where round='2'
           and season='$form{'season'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $count_distinct=$row[0];
   }

   printf "<b>Distinct Winners</b> on tour for Season $form{'season'}: &nbsp&nbsp<b>$count_distinct</b>";
   printf "<p>Distinct Winners on tour:";
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Number of Wins</b></td></tr>";

   $sql = "select winner, count(winner) as count from results
           where round='2'
           and season='$form{'season'}'
           group by winner
           order by count desc";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$wins) = ($row[0],$row[1]);
      print "<tr><td>$player</td>
             <td align=center>$wins</td></tr>";
   }
   
   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	    
   
}

#--------------------------------------------------------------------------------
sub longest_games() {
   printf "Entering longest_games <br>" if $debug;
   printf "<b>Longest Games in recorded Pro Tour History</b>";

   if ($form{'tour'} eq 'IRT') {
      printf "<p>Note: this only takes into account matches from August 1991 to December 2018.  Aug 1991 was when the IRT ";
      printf "implemented the \"Win-by-2\" rule in all games, not just the 5th Super Tiebreaker.  And Dec 2018 was when the score format
              was converted to two games to 15, tiebreaker to 11.";
      printf "Matches in the 70s were played to 21 (win by one) and matches in the 80s were ";
      printf "played to 11, win by one.<p>  ";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "<p>Note: this query may look odd for LPRT, which has used multiple scoring systems over the years. ";
      printf "Once the database is fully loaded, we may add in additional reports to account for eras of scoring systems.";
   }
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch') {
      printf "<p>Note: In the WRT, Intl and Amateur events, the max score of a game is 15-14.  So this list shows a bunch of games won 15-14,
	  of which there have been many.  We have left it in since 15-14 games are still pretty exciting.<P>";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "<p>Note: USA and Mexico play IRF/Intl scoring, which is a max score of 15-14.  However, In the Canadian Nationals events, all games are
	  win by two.  So you might see 16-14 or 17-15 games here for specifically Canadian tournaments.<P>";
   }
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      printf "<p>Note: $tour doubles plays IRF/International scoring, which is max score of 15-14.";
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }


   # Anything longer than this value gets printed
   $longest_game=13;

   $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
           where season > '1990-1'";
           
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      $new_round=&fix_round($round);

      #printf "$score<br>";
      #&dump_array(@points);

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      @points=split(/ /,$score);

      foreach $ttl (@points) {
         $ttl =~ s/\(//;
         $ttl =~ s/\)//;
         if ($ttl > $longest_game) {
            printf "[$ttl] is long: " if $debug;
            &dump_array(@points) if $debug;
            #if ($ttl eq "11 10 9") { printf "@row<br>"; }
            $row[9]=$ttl;
            $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$ttl";
            push (@possibles,$possible);
         }
      }
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   @possibles=&strip_duplicate_in_array(@possibles);
   
   # Sort the possibles by the score of the longest game.
   $sort_field=9;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @possibles=&reverse_array(@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$highscore) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }
   
   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	  
}

#--------------------------------------------------------------------------------
sub record_by_city() {

   printf "Entering Player record by city<br>" if $debug;

   $sql = "select distinct(city) from results order by city";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      push(@cities,$row[0]);
   }

   printf "<p>City-by-City Record for <b>$form{'player'}</b><p>";
   print "<table border><tr>\n";
   print "<td><b>City</b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>Percentage</b></td>
          </tr>\n";

   &dump_array(@cities) if $debug;

   for $city (@cities) {
      printf "calculating city records for $city<br>" if $debug;


      $sql = "select count(*) from results where winner='$form{'player'}' \
              and city='$city'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
         @rows = $sth->fetchrow_array;
         #&dump_array(@rows) if $debug;
         #printf "$wins\n" if $debug;
         $wins=$rows[0];

      $sql = "select count(*) from results where loser='$form{'player'}' \
              and city='$city'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $losses=$rows[0];
         #printf "$losses[0]\n" if $debug;
      }

      printf "wins are $wins, losses are $losses\n<br>" if $debug;
      if ($wins+$losses > 0) { 
         print "<tr><td>$city</td>";
         print "<td>$wins</td>";
         print "<td>$losses</td>";
         $season_winning_pct = ($wins/($wins+$losses));
         $season_winning_pct = sprintf("%.03f", $season_winning_pct);
      }
      else {
         push (@neverplayed,$city);
         next;
         $season_winning_pct = "0.000";
      }

      print "<td>$season_winning_pct</td>";
      
      print "</tr>";

   }
      
   print "</table>";

   $count=@neverplayed;
   $i=1;
   printf "<p>Never played in: ";
   foreach $name (@neverplayed) {
      printf "$name";
      printf ", " unless ($i>=$count);
      $i++;
    
   }
   
   &print_back_link;   
   printf "</body></html>";	     

}

#--------------------------------------------------------------------------------
sub worst_defeats() {
   printf "Entering worst_defeats for $form{'query'}<br>" if $debug;
   printf "<b>Worst Defeats in recorded Pro Tour History</b>: ";

   # Anything more than this minimum score gets ignored

   if ($form{'query'} eq 'worst_defeats') {
      printf "All rounds<p>";
      $min_score=5;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results";
   }
   elsif ($form{'query'} eq 'qsf_worst_defeats') {
      printf "Quarters, Semis and Finals<p>";
      $min_score=11;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where round in (8,4,2)";
   }
   elsif ($form{'query'} eq 'f_worst_defeats') {
      printf "Finals Only<p>";
      $min_score=15;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where round='2'";
   }
   else {
      printf "Error: we should never get here<br>";
   }

   if ($form{'tour'} eq 'IRT') {
      printf "Note: this query does not distinguish between scoring eras.  Any match before Oct 1981 was played two games to 21.  Thus 21-0, 21-1 instead of " ;
      printf "11-0,11-0,11-1.  Any match after Dec 2017 was played two games to 15, so 15-0,15-1 e.g.  ";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "Ladies pro tour scoring has varied wildly over the years.  A 0,0,0 score could be 15-0, 21-0 or 11-0.";
   }
   elsif ($form{'tour'} eq 'WRT') {
      printf "WRT uses IRF/USAR amateur scoring, so 0,0 here is 15-0, 15-0.";
   }
   elsif ($form{'tour'} eq 'IRFmatch') {
      printf "IRF uses international scoring, so 0,0 here is 15-0, 15-0.";
   }
   elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      printf "Amateur events use international scoring, so 0,0 here is 15-0, 15-0.  Canada plays win-by-2, so you could have 16-14 for example.";
   }   
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' ) {
      printf "$tour Doubles use international scoring, so 0,0 here is 15-0, 15-0.";
   }   
   else {
      printf "Invalid Tour selected; you should never get here";
   }

           
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      # skips results if the score matches these strings
      # 11/20/07: added in wbf, ret, noshow results
      next if ($score =~ /inj|INJ|fft|\?|\(|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
      next if ($score eq '');
      next if ($score eq ' ');

      $new_round=&fix_round($round);

      #printf "$score<br>";
      #&dump_array(@points);

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      @points=split(/ /,$score);

      $game_count=@points;
      #if ($game_count eq "3") {
         $ttl_pts=$points[0] + $points[1] + $points[2];
         printf "@points, $ttl_pts<br>" if $debug;
         if ($ttl_pts < $min_score) {
            $row[9]=$ttl_pts;
            $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$ttl_pts";
            push (@possibles,$possible);
         }
      #}
      
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b>Total Pts</b></td>
          </tr>\n";

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   
   # Sort the possibles by the score of the longest game.
   $sort_field=9;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             <td align=center>$total</td>
             </tr>";
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	     

}

#--------------------------------------------------------------------------------
# 11/3/17; updates to put in most points scored while losing
# 1/3/18: added in 2018 IRT new scoring method.


sub longest_matches() {
   printf "Entering longest_matches for $form{'query'}<br>" if $debug;

   if ($form{'query'} eq 'longest_matches_pre') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", 1974-1981<p>";
      $min_score=106;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date < '1981-08-01'"; 
   }
   elsif ($form{'query'} eq 'longest_matches_post') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", 1981-2017<p>";
      $min_score=100;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '1981-08-01' and tmp_date < '2017-12-31'"; 
   }
   elsif ($form{'query'} eq 'longest_matches_2018') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", 2018-present<p>";
      $min_score=60;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '2017-12-31'"; 
   }
   # 12/28/16: added inversions for LPRT rally/non-rally scoring
   elsif ($form{'query'} eq 'longest_matches_rally') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", Rally-Scoring Era (1980-81 through 1985-86 seasons, 2000-01 season, 2001-02 season)<p>";
      $min_score=120;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where season in ('1980-81','1981-82','1982-83','1983-84','1984-85','1985-86','2000-01','2001-02')"; 
   }
   elsif ($form{'query'} eq 'longest_matches_nonrally_old') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", Non Rally-Scoring Era, old Scoring rules (games to 21).  Pre 1980.  Note that the format of the 3rd game varied; sometimes played to 21, sometimes to 15, sometimes to 11.<p>";
      $min_score=75;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date < '1980-08-01'"; 
   }
   elsif ($form{'query'} eq 'longest_matches_nonrally_new') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", Non Rally-Scoring Era, new Scoring rules (games to 11) Post 1986 with exception of 2000-01, 2001-02 seasons<p>";
      $min_score=75;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '1986-08-01' and season not in ('2000-01','2001-02')"; 
   }
   elsif ($form{'query'} eq 'longest_matches_all') {
      printf "<b>Longest Matches recorded Pro Tour History</b>: by total points";
      printf ", Entire history of tour<p>";
      $min_score=70;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results"; 
   }
   elsif ($form{'query'} eq 'most_points_win') {
      printf "<b>Most Points scored in a Win</b><p>";
	  $min_score=38;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results"; 
   }
   elsif ($form{'query'} eq 'most_points_win_pre') {
      printf "<b>Most Points scored in a Win</b>";
      printf ", 1974-1981<p>";
      $min_score=54;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date < '1981-08-01'"; 
   }
   elsif ($form{'query'} eq 'most_points_win_post') {
      printf "<b>Most Points scored in a Win</b>";
      printf ", 1981-2017<p>";
      $min_score=46;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '1981-08-01' and tmp_date < '2017-12-31'"; 
   }
   elsif ($form{'query'} eq 'most_points_win_2018') {
      printf "<b>Most Points scored in a Win</b>";
      printf ", 2018-present<p>";
      $min_score=36;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '2017-12-31'"; 
   }
   
   elsif ($form{'query'} eq 'most_points_loss') {
      printf "<b>Most Points scored in a Loss</b><p>";
      $min_score=36;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results"; 
   }
   elsif ($form{'query'} eq 'most_points_loss_pre') {
      printf "<b>Most Points scored in a Loss</b>";
      printf ", 1974-1981<p>";
      $min_score=46;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date < '1981-08-01'"; 
   }
   elsif ($form{'query'} eq 'most_points_loss_post') {
      printf "<b>Most Points scored in a Loss</b>";
      printf ", 1981-2017<p>";
      $min_score=46;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '1981-08-01' and tmp_date < '2017-12-31'"; 
   }
   elsif ($form{'query'} eq 'most_points_loss_2018') {
      printf "<b>Most Points scored in a Loss</b>";
      printf ", 2017-present<p>";
      $min_score=33;
      $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where tmp_date > '2017-12-31'"; 
   }
   
   
# testing clause...
# and score='(9),13,(9),7,18'
# where score='14,(14),10'

   else {
      printf "Invalid form query passed $form{'query'}, we should never get here\n";
   } 

   # define max points per game; here's where we delineate for the various tours the max scores
   # Borrowed from "dominant games query"

   if ($form{'tour'} eq 'IRT') {
      if ($form{'query'} eq 'most_points_loss_pre' || $form{'query'} eq 'most_points_win_pre' || $form{'query'} eq 'longest_matches_pre') {
         $max_points_per_game=21;
      }
      elsif ($form{'query'} eq 'most_points_loss_post' || $form{'query'} eq 'most_points_win_post' || $form{'query'} eq 'longest_matches_post') {
         $max_points_per_game=11;
      }
      elsif ($form{'query'} eq 'most_points_loss_2018' || $form{'query'} eq 'most_points_win_2018' || $form{'query'} eq 'longest_matches_2018') {
         $max_points_per_game=15;
      }
	  else {
	     # should never get here
         printf "Invalid form query passed $form{'query'}, we should never get here\n";
	  }
   }
   elsif ($form{'tour'} eq 'LPRT') {
      if ($tmp_date < '1986-08-01') { 
         $max_points_per_game=21;
      }
      elsif ($season eq '2000-01' || $season eq '2001-02') {
         $max_points_per_game=21;
      }
      else {
         $max_points_per_game=11;
      }         
   }
   # even though IRT is now games to 15 ... we process it above, not here.
   elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'JUNIOR') {
      $max_points_per_game=15;
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }

   printf "Exiting max points logic: maxpointspergame is $max_points_per_game<p>" if $debug;


   if ($form{'tour'} eq 'WRT') {
      if ($form{'query'} eq 'longest_matches_all') {
         printf "Since the WRT uses standard Amateur scoring, the longest possible match is 14,(14),10.  We have left in this query despite this fact since a 14,(14),10 match is the ultimate racquetball match and is worth reporting.<p>";
      }
   }

   if ($form{'tour'} eq 'IRFmatch') {
      if ($form{'query'} eq 'longest_matches_all') {
         printf "Since the IRF uses international scoring, the longest possible match is 14,(14),10.  We have left in this query despite this fact since a 14,(14),10 match is the ultimate racquetball match and is worth reporting.<p>";
      }
   }

   if ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      if ($form{'query'} eq 'longest_matches_all') {
         printf "Since Amateur/Junior tournaments use international scoring, the longest possible match is 14,(14),10.  We have left in this query despite this fact since a 14,(14),10 match is the ultimate racquetball match and is worth reporting.<p>";
      }
   }

   
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);
      $ttl_pts=0;

      # need a game counter for amateur matches tiebreaker to 11...
      $game_counter=0;

      &dump_array(@points) if $debug;

	# 11/3/17: fixing this to do just the counts of points for the loser
	if ($form{'query'} eq 'most_points_loss_post' || $form{'query'} eq 'most_points_loss_pre' || $form{'query'} eq 'most_points_loss' || $form{'query'} eq 'most_points_loss_2018') {
         printf "Entering $form{'query'} logic portion for some portion of most points lost<p>" if $debug;
         foreach $sc (@points) {
            $game_counter++;
            printf "game counter is now $game_counter<p>" if $debug;

            # all of these corrupt the logic and should be skipped.
            next if ($sc =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);

            if ($sc =~ /\(/) {
               printf "Score is negative $sc<p>" if $debug;
		   $sc =~ s/\(//g;
               $sc =~ s/\)//g;

		   #$ttl_pts+=$sc;
		   #$ttl_pts+=2;  # for two more points to win that game

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=($sc+2);
                  }
               }
               elsif ($max_points_per_game eq 15) {
                  if ($game_counter eq '3') {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=15;
                  }
               }
               elsif ($max_points_per_game eq 21) {
                  $ttl_pts+=21;
               }

            }
            else {
               printf "Score is positive $sc<p>" if $debug;
		   $ttl_pts+=$sc;			
	      }	
            printf "exiting loss foreach loop, gamecounter is $game_counter, ttl points is $ttl_pts<p>" if $debug;		
         }
      }

	# 11/3/17: fixing this to do just the counts of points for the winner, reversing the logic from the loser logic above
	elsif ($form{'query'} eq 'most_points_win_post' || $form{'query'} eq 'most_points_win_pre' || $form{'query'} eq 'most_points_win' || $form{'query'} eq 'most_points_win_2018') {
         printf "Entering $form{'query'} logic portion for some form of most points win<p>" if $debug;
         foreach $sc (@points) {
            $game_counter++;
            printf "game counter is now $game_counter<p>" if $debug;

            # all of these corrupt the logic and should be skipped.
            next if ($sc =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);

            if ($sc =~ /\(/) {
               printf "Score is negative $sc<p>" if $debug;
		   $sc =~ s/\(//g;
               $sc =~ s/\)//g;
		   $ttl_pts+=$sc;	
            }
            else {
               printf "Score is positive $sc<p>" if $debug;

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=($sc+2);
                  }
               }
               elsif ($max_points_per_game eq 15) {
                  if ($game_counter eq '3') {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=15;
                  }
               }
               elsif ($max_points_per_game eq 21) {
                  $ttl_pts+=21;
               }
	      }	

            printf "exiting win foreach loop, gamecounter is $game_counter,  ttl points is $ttl_pts<p>" if $debug;		
         }
      }

      # Else here its the conventional longest match logic...

	else {
         printf "Entering $form{'query'} conventional logic portion<p>" if $debug;
         foreach $sc (@points) {
            $game_counter++;
            # all of these corrupt the logic and should be skipped.
            next if ($sc =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);

            if ($sc =~ /\(/) {
               printf "Score is negative $sc<p>" if $debug;
		   $sc =~ s/\(//g;
               $sc =~ s/\)//g;
		   $ttl_pts+=$sc;	

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=($sc+2);
                  }
               }
               elsif ($max_points_per_game eq 15) {
                  if ($game_counter eq '3') {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=15;
                  }
               }
               elsif ($max_points_per_game eq 21) {
                  $ttl_pts+=21;
               }
            }
            else {
               printf "Score is positive $sc<p>" if $debug;

               $ttl_pts+=$sc;

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=($sc+2);
                  }
               }
               elsif ($max_points_per_game eq 15) {
                  if ($game_counter eq '3') {
                     $ttl_pts+=11;
                  }
                  else {
                     $ttl_pts+=15;
                  }
               }
               elsif ($max_points_per_game eq 21) {
                  $ttl_pts+=21;
               }
	      }	
         printf "exiting win foreach loop, gamecounter is $game_counter,  ttl points is $ttl_pts<p>" if $debug;		
         }	  
      }




      #$ttl_pts=$points[0] + $points[1] + $points[2] + $points[3] + $points[4];
      printf "@points, $ttl_pts<br>" if $debug;
      if ($ttl_pts > $min_score) {
         $row[9]=$ttl_pts;
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$ttl_pts";
         push (@possibles,$possible);
      }
      
   }

   #&dump_array(@possibles);

   if ($form{'query'} eq 'most_points_loss_post') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b><center>Loser Ttl Points</center></b></td>
          </tr>\n";
   }
   else {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b><center>Match Ttl Points</center></b></td>
          </tr>\n";   
   }

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   
   # Sort the possibles by the score of the longest game.
   $sort_field=9;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # reverse the array
   @possibles=&reverse_array(@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             <td align=center>$total</td>
             </tr>";
   }

   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	    
   
}


#--------------------------------------------------------------------------------
# 1/19/17: putting in a "dominant" tourney report
# 


sub most_dominant_tourneys() {
   printf "Entering Most Dominant Tourneys Report<br>" if $debug;
   printf "<b>Most Dominant tourney Wins in recorded History</b>: by games lost and total/average points per game given up<p>";

   printf "This report shows all tourney winners who did not drop a game in their tourney win, sorted by average number of points conceded per event.  This report skips tourneys where we do not have complete scores, or if scores are missing.  <p>";

   $sql = "select winner,loser,score,city,event,date,season,tmp_date from results \
           where round='2' order by tmp_date desc";
   printf "$sql<p>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $score=$row[2];
      $city=$row[3];
      $event=$row[4];
      $date=$row[5];
      $season=$row[6];
      $tmp_date=$row[7];
      push (@allfinals,"$winner~$event~$tmp_date");
   }

   &dump_array(@allfinals) if $debug;

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Winner</b></td>
          <td><b>Number of <br>Matches Played</b></td>
          <td><b>Number of <br>Games Played</b></td>
          <td><b>Number of <br>Games Won</b></td>
          <td><b>Number of <br>Games Lost</b></td>
          <td><b>Game Record<br>for Tourney</b></td>
          <td><b>Total Points <br>Scored</b></td>
          <td><b>Total Points <br>Conceded</b></td>
          <td><b>Max Points <br>conceded in <br>a Game</b></td>
          <td><b>Avg Points <br>conceded per Game</b></td>
          </tr>\n";

   for $final (@allfinals) {
      ($winner,$event,$tmp_date) = split(/~/,$final);
	  
	  printf "$winner,$event,$tmp_date<p>" if $debug;

      # skip the New Orleans event cancelled by Hurricane Katrina, or if the finals have a ? for the winner right now 
      next if ($winner eq '?');

      # define max points per game; here's where we delineate for the various tours the max scores

      if ($form{'tour'} eq 'IRT') {
         if ($tmp_date lt '1981-08-01') {
            $max_points_per_game=21;
         }
         elsif ($tmp_date gt '1981-08-01' && $tmp_date lt '2017-12-31') {
            $max_points_per_game=11;
         }
         elsif ($tmp_date gt '2017-12-31') {
            $max_points_per_game=15;
         }
		 else {
		    printf "You should never get here; tmp_date is $tmp_date<p>";
		 }
	     printf "tmp_date is $tmp_date, max points per game is $max_points_per_game<p>" if $debug;
      }
      elsif ($form{'tour'} eq 'LPRT') {
         if ($tmp_date lt '1986-08-01') { 
            $max_points_per_game=21;
         }
         elsif ($season eq '2000-01' || $season eq '2001-02') {
            $max_points_per_game=21;
         }
         else {
            $max_points_per_game=11;
         }         
      }
      elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'JUNIOR') {
         $max_points_per_game=15;
      }
      else {
         printf "Invalid Tour selected; you should never get here";
      }

      printf "tour is $form{'tour'} and max points per game is $max_points_per_game<br>" if $debug;

      $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
              from results where winner='$winner' and tmp_date='$tmp_date' and event='$event' \
              order by round desc";
      printf "$sql<p>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      # setup the counting variables to be used here:
      $total_matches=0;
      $total_games=0;
      $games_won=0;
      $games_lost=0;
      $total_points_scored=0;
      $total_points_conceded=0;
      $max_points_conceded=0;

      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $loser=$row[1]; 
         $round=$row[2];
         $score=$row[3];
         $tour=$row[4];
         $city=$row[5];
         $event=$row[6];
         $date=$row[7];  
         $season=$row[8];
         $notes=$row[8];

         $total_matches++;

         #printf "pre: $score <br>" if $debug;

         # Data entry errors cause some scores to have commas, others spaces separating
         # game scores.  Must stript them
         if ($score =~ /\,/) {
            $score =~ s/\,/ /g;
            #@points=split(/\,/,$score);
         }

         # clean Extra spaces in scores
         $score=~ s/  */ /g;

         #printf "post: $score <br>" if $debug;

         @points=split(/ /,$score);

         foreach $sc (@points) {
            printf "Working on score: $sc<br>" if $debug;

            # don't count any inj scores in this logic.
			next if ($sc =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
			
            $total_games++;
            if ($sc =~ /\(/) {
               printf "entering game lost logic<br>" if $debug;
               $games_lost++;

               # remove parentheses from score to do arithmetic
               $sc =~ s/\(//g;
               $sc =~ s/\)//g;
               $total_points_scored+=$sc;

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $total_points_conceded+=11;
                     if (11 > $max_points_conceded) {
                        $max_points_conceded=11;
                     } 
                     else {
                        if (($sc+2) > $max_points_conceded) {
                           $max_points_conceded=($sc+2);
                        }
                     } 
                  }
                  else {
                     $total_points_conceded+=($sc+2);
                  }
               }
               elsif ($max_points_per_game eq 15) {
                  $total_points_conceded+=15;
                  $max_points_conceded=15;
               }
               elsif ($max_points_per_game eq 21) {
                  $total_points_conceded+=21;
                  $max_points_conceded=21;
               }
            }
            else {
               printf "entering game won logic, total_points_scored is $total_points_scored<br>" if $debug;
               $games_won++;

               if ($max_points_per_game eq 11) {
                  if ($sc <= 9) {
                     $total_points_scored+=11;
                  }
                  else {
                     $total_points_scored+=($sc+2);
                  }
                  $total_points_conceded+=$sc;
                  if ($sc > $max_points_conceded) {
                     $max_points_conceded=$sc;
                  } 
               }
               elsif ($max_points_per_game eq 15) {
                  $total_points_scored+=15;
                  $total_points_conceded+=$sc;
                  if ($sc > $max_points_conceded) {
                     $max_points_conceded=$sc;
                  } 
               }
               elsif ($max_points_per_game eq 21) {
                  $total_points_scored+=21;
                  $total_points_conceded+=$sc;
                  if ($sc > $max_points_conceded) {
                     $max_points_conceded=$sc;
                  } 
               }
            }
         } #foreach point 
      } #while fetch

      if ($total_games > 0 ) {
         $avg_points_conceded = $total_points_conceded/$total_games;
      }
      else {
         $avg_points_conceded=0;
      }

      $avg_points_conceded_rnded = sprintf("%.2f", $avg_points_conceded);


# Only pushing data if zero games lost during the tourney.  Also assuming that at least 6 games were played, thus eliminating
# tourneys where limited scores exist...
      if ($games_lost < 1) {
         if ($total_games >= 6 ) {
            $possible="$season~$date~$city~$event~$winner~$total_matches~$total_games~$games_won~$games_lost~$games_won-$games_lost~$total_points_scored~$total_points_conceded~$max_points_conceded~$avg_points_conceded_rnded";
            push (@possibles,$possible);
         }   
      }

   } #foreach final

   &dump_array(@possibles) if $debug;

   # Sort the possibles by the number of matchups
   $sort_field=13;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   #@possibles=&reverse_array(@possibles);

   foreach $line (@possibles) {
      printf "$line<br>" if $debug;

      ($season,$date,$city,$event,$winner,$total_matches,$total_games,$games_won,$games_lost,$games_record,$total_points_scored,$total_points_conceded,$max_points_conceded,$avg_points_conceded_rnded) = split(/~/,$line);

      print "<tr>\n";
      print "<td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$winner</td>
          <td><center>$total_matches</center></td>
          <td><center>$total_games</center></td>
          <td><center>$games_won</center></td>
          <td><center>$games_lost</center></td>
          <td><center>$games_record</center></td>
          <td><center>$total_points_scored</center></td>
          <td><center>$total_points_conceded</center></td>
          <td><center>$max_points_conceded</center></td>
          <td><center>$avg_points_conceded_rnded</center></td>
          </tr>\n";
   }
   
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       

}






#--------------------------------------------------------------------------------
sub longest_fifth() {
   printf "Entering longest_fifth <br>" if $debug;

   printf "<b>Longest 5th Game</b>:<p>";

   if ($form{'tour'} eq 'IRT') {
      printf "Note, it is believed that the longest 5th game in pro history
actually occurred during a Baltimore event in the early 90s between Harnett-Kachtik.  However, the
database is missing results for this tourney.  I'm not sure if this is longer than the amazing 20-18 match listed here.  If you have this result, please let us know.<p>";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "<p>Note: this query may look odd for LPRT, which has used multiple scoring systems over the years.  Any score in the 2000-01 or 2001-02 season is rally scoring, while other seasons were to 11.";
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }


   # Anything more than this gets ignored
   $min_score=10;

   $sql = "select winner,loser,round,score,tour,city,event,date,season from results"; 
           
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      if ($points[4] > $min_score) {
         $row[9]=$points[4];
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$points[4]";
         push (@possibles,$possible);
      }
      
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b>Total Pts</b></td>
          </tr>\n";

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   
   # Sort the possibles by the score of the longest game.
   $sort_field=9;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # reverse the array
   @possibles=&reverse_array(@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             <td align=center>$total</td>
             </tr>";
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
sub all_negative() {
   printf "Entering all_negative <br>" if $debug;

   printf "<b>All Negative Match Scores</b>:<p> if a player is issued a technical in a game, then the possibility exists of having a negative game score.  This seems to happen more often later in the tour than earlier.  Some players get technicals for violating (mistakenly or otherwise) time-out rules, others get them for behavioral issues or delays of game, and some seem to purposely get technicals to avoid having donuts on their resume.<p>";

   # Anything shorter than this value gets printed
   $zero_game=0;

   $sql = "select winner,loser,round,score,tour,city,event,date,season,tmp_date from results";
           
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];

      $new_round=&fix_round($round);

      #printf "$score<br>";
      #&dump_array(@points);

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      @points=split(/ /,$score);

      foreach $ttl (@points) {
         $ttl =~ s/\(//;
         $ttl =~ s/\)//;
         if ($ttl < $zero_game) {
            printf "[$ttl] is long: " if $debug;
            &dump_array(@points) if $debug;
            #if ($ttl eq "11 10 9") { printf "@row<br>"; }
            $row[9]=$ttl;
            $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$ttl~$tmp_date";
            push (@possibles,$possible);
         }
      }
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   @possibles=&strip_duplicate_in_array(@possibles);
   
   # Sort the possibles by the score of the longest game.
   $sort_field=10;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   #@possibles=&reverse_array(@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$highscore,$tmpdate) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       

}




#--------------------------------------------------------------------------------
# all forfeits
# 

sub all_forfeits() {
   printf "Entering all_forfeits <br>" if $debug;

   if ($form{'query'} eq 'all_forfeits_qsf') {
      printf "<b>All Forfeit Match Scores</b>:<p>This query shows all games that were won/lost by way of forfeit in Quarters, Semis, Finals<p>";
      $sql = "select winner,loser,round,score,tour,city,event,date,season,tmp_date from results where round <=8";
   }
   else {
      printf "<b>All Forfeit Match Scores</b>:<p>This query shows all games that were won/lost by way of forfeit.<p>";
      $sql = "select winner,loser,round,score,tour,city,event,date,season,tmp_date from results";
   }        

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];

      $new_round=&fix_round($round);

      #printf "$score<br>";
      #&dump_array(@points);
     
	# save the orig format of the score for eventual display
	$orig_score=$score;

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      @points=split(/ /,$score);

      foreach $ttl (@points) {
         $ttl =~ s/\(//;
         $ttl =~ s/\)//;
         if ($ttl =~ /inj|INJ|fft|SNA|FORFEIT|FFT|def|DEFAULT|wbf|ret|noshow/) {
            printf "[$ttl] is candidate:<br>" if $debug;
            #&dump_array(@points) if $debug;
            $possible="$winner~$loser~$new_round~$orig_score~$tour~$city~$event~$date~$season~$ttl~$tmp_date";
            push (@possibles,$possible);

            printf "pushing this to possibles: $winner~$loser~$new_round~$orig_score~$tour~$city~$event~$date~$season~$ttl~$tmp_date<br>" if $debug;
         }
      }
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   # this removes duplicates
   @possibles=&strip_duplicate_in_array(@possibles);
   
   # Sort the possibles
   $sort_field=10;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want to sort latest to earliest
   @possibles=&reverse_array(@possibles);

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$orig_score,$tour,$city,$event,$date,$season,$highscore,$tmpdate) = split(/~/,$match);

      #$score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$orig_score</td>
             </tr>";
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       

}






#--------------------------------------------------------------------------------
sub player_record_5th() {

   printf "Entering player 5th\n" if $debug;

   $wins=0;
   $losses=0;

   $sql="select winner,loser,round,score,tour,city,event,date,season \
         from results where \
         winner='$form{'player'}' or loser='$form{'player'}' order by tmp_date";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      next if ($score =~ /inj|fft|wbf/);

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      # if this isn't blank, its a 5 game match
      if ($points[4] ne "") {
         if ($winner eq "$form{'player'}") {
            $wins++;
         }
         elsif ($loser eq "$form{'player'}") {
            $losses++;
         }
         else {
            printf "Error: we should never get here<br>";
         }
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season";
         push (@possibles,$possible);
      }
      
   }

   printf "Overall Record in 5-game matches: $wins - $losses<br>\n";

   if ($wins+$losses > 0) { 
      $winning_pct = ($wins/($wins+$losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }
   printf "Winning pct in 5-game matches: $winning_pct<br>\n";
   ($junk,$junk,$overall_pct)=&gen_wl($form{'player'});
   printf "(Overall Winning pct on tour: $overall_pct)<br>\n";

   #&dump_array(@possibles);

   printf "<p>5-game Match Summary: <p>";
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
sub donuts() {

   printf "Entering donuts\n" if $debug;

   $given=0;
   $taken=0;

   $sql="select winner,loser,round,score,tour,city,event,date,season,tmp_date \
         from results where \
         winner='$form{'player'}' or loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];

      #next if ($score =~ /inj|fft|wbf/);

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      foreach $pt (@points) {
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$tmp_date";
         if ($pt eq "0") {
            if ($winner eq "$form{'player'}") {
               $given++;
            }
            else {
               $taken++;
            }
            push (@possibles,$possible);
         }
         if ($pt eq "(0)") {
            if ($winner eq "$form{'player'}") {
               $taken++;
            }
            else {
               $given++;
            }
            push (@possibles,$possible);
         }
      }
   }

   #&dump_array(@possibles);
   @possibles=&strip_duplicate_in_array(@possibles); 
   @possibles=&schwartzian_sort(9,\@possibles);
   printf "Donut Count for $form{'player'}:<br><b>$given</b> Given, <b>$taken</b> Taken <p>\n";
   printf "<p>Donut Games";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
sub twinkies() {

   printf "Entering twinkies\n" if $debug;

   $given=0;
   $taken=0;

   $sql="select winner,loser,round,score,tour,city,event,date,season,tmp_date \
         from results where \
         winner='$form{'player'}' or loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];

      #next if ($score =~ /inj|fft|wbf/);

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      foreach $pt (@points) {
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$tmp_date";
         if ($pt eq "1") {
            if ($winner eq "$form{'player'}") {
               $given++;
            }
            else {
               $taken++;
            }
            push (@possibles,$possible);
         }
         if ($pt eq "(1)") {
            if ($winner eq "$form{'player'}") {
               $taken++;
            }
            else {
               $given++;
            }
            push (@possibles,$possible);
         }
      }
   }

   #&dump_array(@possibles);
   @possibles=&strip_duplicate_in_array(@possibles); 
   @possibles=&schwartzian_sort(9,\@possibles);
   printf "Twinkie Count for $form{'player'}:<br><b>$given</b> Given, <b>$taken</b> Taken <p>\n";
   printf "<p>Donut Games";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }

   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       
   

}


#--------------------------------------------------------------------------------
# 5/23/08: fix this to also have Career Summary numbers at bottom.
# 5/9/14: adding 256s as well.
# 6/18/15 adding season ending rankings too.
# 12/19/17: making this work for doubles...

sub player_summary() {

   printf "Entering player_summary for $form{'tour'}<p>" if $debug;

   $sql = "select distinct(season) from results order by season desc";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@seasons,$row);
   }

# first, get overall W/L for printing later

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {

      $sql = "select count(*) from results_doubles 
	             where winner_p1='$form{'player'}' or winner_p2='$form{'player'}'"; 
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $overall_wins=$row[0];
      }	  

      $sql = "select count(*) from results_doubles 
	             where loser_p1='$form{'player'}' or loser_p2='$form{'player'}'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $overall_losses=$row[0];
      }
	  
      if ($overall_wins+$overall_losses > 0) { 
         $overall_pct = ($overall_wins/($overall_wins+$overall_losses));
         $overall_pct = sprintf("%.03f", $overall_pct);
      }
      else {
         $overall_pct = "0.000";
      }	  	  
   }
   else {
      # 10/25/11 adding in overall w/l on tour; changed this to use gen_wl
      ($overall_wins,$overall_losses,$overall_pct)=&gen_wl($form{'player'});
   }
   
  

   if ($form{'tour'} eq 'IRFmatch') {
      printf "International Career Summary for <b>$form{'player'}</b><br>";
      printf "Note: if a player fails to advance to the knock-out rounds, their results are not listed in the summary tables.<p>";
      printf "<b>Overall W/L in International Events</b>: $overall_wins - $overall_losses<br>";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "Amateur Career Summary for <b>$form{'player'}</b><br>";
      printf "Note: 3rd place game results are not captured here, nor in W/L records.<p>";

# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
      if ($form{'tour'} eq 'AMATEUR' && ($form{'player'} eq 'Waselenchuk, Kane' || $form{'player'} eq 'Green, Mike')) {
         printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
      }

      printf "<b>Overall W/L in National Amateur Events</b>: $overall_wins - $overall_losses<br>";
   }
   elsif ($form{'tour'} eq 'JUNIOR') {
      printf "Junior Career Summary for <b>$form{'player'}</b><br>";
      printf "Note: 3rd place game results are not captured here, nor in W/L records.<p>";
      printf "<b>Overall W/L in Junior Events</b>: $overall_wins - $overall_losses<br>";
   }
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      printf "$tour Doubles Career Summary for <b>$form{'player'}</b><br>";
      printf "<b>Overall W/L in Doubles Events</b>: $overall_wins - $overall_losses<br>";
   }
   else {
      printf "<b>Season and Career Summary</b> for <b>$form{'player'}</b><p>";
      printf "<b>Overall W/L on tour</b>: $overall_wins - $overall_losses<br>";
   }

   printf "<b>Overall W/L Percentage</b>: $overall_pct<p>";

   
 # 12/19/17: no rankings in IRF 
   if ($form{'tour'} eq 'IRFmatch') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Wins</b></td>
          <td><b>Finals</b></td>
          <td><b>Semis</b></td>
          <td><b>Qtrs</b></td>
          <td><b>16s</b></td>
          <td><b>32s</b></td>
          <td><b>64s</b></td>
          <td><b>128s</b></td>
          <td><b>256s</b></td>
          <td><b>Missed</b></td>
          <td><b>Total Trnys</b></td>
          </tr>\n";
   }
   
   # 12/19/17: no rankings in doubles ... yet.  don't print that column for now
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Wins</b></td>
          <td><b>Finals</b></td>
          <td><b>Semis</b></td>
          <td><b>Qtrs</b></td>
          <td><b>16s</b></td>
          <td><b>32s</b></td>
          <td><b>64s</b></td>
          <td><b>128s</b></td>
          <td><b>256s</b></td>
          <td><b>Missed</b></td>
          <td><b>Total Trnys</b></td>
          </tr>\n";   
   }
   # For amateurs and Juniors; not listing "missed" events since they cannot play them all
   elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Wins</b></td>
          <td><b>Finals</b></td>
          <td><b>Semis</b></td>
          <td><b>Qtrs</b></td>
          <td><b>16s</b></td>
          <td><b>32s</b></td>
          <td><b>64s</b></td>
          <td><b>128s</b></td>
          <td><b>256s</b></td>
          </tr>\n";   
   }
   else {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
          <td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Wins</b></td>
          <td><b>Finals</b></td>
          <td><b>Semis</b></td>
          <td><b>Qtrs</b></td>
          <td><b>16s</b></td>
          <td><b>32s</b></td>
          <td><b>64s</b></td>
          <td><b>128s</b></td>
          <td><b>256s</b></td>
          <td><b>Missed</b></td>
          <td><b>Total Trnys</b></td>
          </tr>\n";
   }

   my $career_twofiftysixes=0;
   my $career_onetwentyeights=0;
   my $career_sixtyfours=0;
   my $career_thirtytwos=0;
   my $career_sixteens=0;
   my $career_quarters=0;
   my $career_semis=0;
   my $career_finals=0;
   my $career_wins=0;
   my $career_total_results=0;
   my $career_num_events=0;

   foreach $season (@seasons) {

      # clear these at the start not the end thanks to "next" logic.
      undef $rank;
      undef $tmp_rank;

      my $twofiftysixes=0;
      my $onetwentyeights=0;
      my $sixtyfours=0;
      my $thirtytwos=0;
      my $sixteens=0;
      my $quarters=0;
      my $semis=0;
      my $finals=0;
      my $wins=0;
      my $total_results=0;
      my $num_events=0;

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
         $sql="select count(distinct(event)) from results_doubles where season='$season'";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while ($row = $sth->fetchrow_array) {
            $num_events=$row;
         }
      }
      else {	  
         $sql="select count(distinct(event)) from results where season='$season'";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while ($row = $sth->fetchrow_array) {
            $num_events=$row;
         }
      }
	  
      $career_num_events=$career_num_events+$num_events;
    
# 6/18/15 adding rank to this table
# Note: if there's no ranking ... we don't need to do if/then/else here it just won't print.
   
      $tmp_rank = &gen_player_ranking($season,$form{'player'});
      printf "tmp_rank returned for season $season is $tmp_rank.  rank variable is now $rank<br>" if $debug;

      ($rank,$points,$prizemoney) = split(/,/, $tmp_rank);
      printf "rank is $rank,points are $points,money is $prizemoney\n" if $debug;

      if ($rank eq "no results") {
         undef $rank;
         undef $tmp_rank;
         $comments = "No Results on tour";
      }

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	  
         $sql="select event, min(round) from results_doubles where 
               (winner_p1='$form{'player'}' or winner_p2='$form{'player'}' or loser_p1='$form{'player'}' or loser_p2='$form{'player'}') 
               and season='$season' group by event";	   
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            ($event,$round)=($row[0],$row[1]);

            printf "$event and $round<br>" if $debug;

            if ($round eq "256") {
               $twofiftysixes++;
               $career_twofiftysixes++;
            }
            elsif ($round eq "128") {
               $onetwentyeights++;
               $career_onetwentyeights++;
            }
            elsif ($round eq "64") {
               $sixtyfours++;
               $career_sixtyfours++;
            }
            elsif ($round eq "32") {
               $thirtytwos++;
               $career_thirtytwos++;
            }
            elsif ($round eq "16") {
               $sixteens++;
               $career_sixteens++;
            }
            elsif ($round eq "8") {
               $quarters++;
               $career_quarters++;
            }
            elsif ($round eq "4") {
               $semis++;
               $career_semis++;
            }
            elsif ($round eq "3") {
               # 3rd place game: do nothing here
            }
            elsif ($round eq "2") {
               $sql2="select winner_p1, winner_p2 from results_doubles where season='$season' and event='$event' and round=2";
               printf "$sql2<br>" if $debug;
               $sth2 = $dbh->prepare($sql2);
               $sth2->execute;
               while (@row2 = $sth2->fetchrow_array) {
                  $winner_p1=$row2[0];
                  $winner_p2=$row2[1];				  
               }
               if ($winner_p1 eq "$form{'player'}" || $winner_p2 eq "$form{'player'}") {
                  $wins++;
                  $career_wins++;
               }
               else {
                  $finals++;
                  $career_finals++;
               }
            }
            else {
               printf "Invalid round in database; you should never see this";
            }
         }
      }
      else {
         $sql="select event, min(round) from results where \
               (winner='$form{'player'}' or loser='$form{'player'}') \
               and season='$season' group by event";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            ($event,$round)=($row[0],$row[1]);

            printf "$event and $round<br>" if $debug;

            if ($round eq "256") {
               $twofiftysixes++;
               $career_twofiftysixes++;
            }
            elsif ($round eq "128") {
               $onetwentyeights++;
               $career_onetwentyeights++;
            }
            elsif ($round eq "64") {
               $sixtyfours++;
               $career_sixtyfours++;
            }
            elsif ($round eq "32") {
               $thirtytwos++;
               $career_thirtytwos++;
            }
            elsif ($round eq "16") {
               $sixteens++;
               $career_sixteens++;
            }
            elsif ($round eq "8") {
               $quarters++;
               $career_quarters++;
            }
            elsif ($round eq "4") {
               $semis++;
               $career_semis++;
            }
            elsif ($round eq "3") {
               # 3rd place game: do nothing here
            }
            elsif ($round eq "2") {
               $sql2="select winner from results where season='$season' and event='$event' and round=2";
               printf "$sql2<br>" if $debug;
               $sth2 = $dbh->prepare($sql2);
               $sth2->execute;
               while (@row2 = $sth2->fetchrow_array) {
                  $winner=$row2[0];
               }
               if ($winner eq "$form{'player'}") {
                  $wins++;
                  $career_wins++;
               }
               else {
                  $finals++;
                  $career_finals++;
               }
            }
            else {
               printf "Invalid round in database; you should never see this";
            }
         }	  
	  
	  }	  
		 

      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
      $career_total_results=$career_total_results+$total_results;

      $others=$num_events-$total_results;
      $career_others=$career_others+$others;

      #$results_summary="$wins Wins, $finals Finals, $semis Semis, $quarters Quarters, $sixteens 16s, "; 
      #if ($thirtytwos > 0) { $results_summary = $results_summary . "$thirtytwos 32s, "; }
      #if ($sixtyfours > 0) { $results_summary = $results_summary . "$sixtyfours 64s, "; }
      #if ($onetwentyeights > 0) { $results_summary = $results_summary . "$onetwentyeights 128s, "; }
      #$results_summary = $results_summary . "($others/$num_events Missed Tourneys)";

      # this logic skips printing the row if the player did not appear on tour in the given season
      next if ($others eq $num_events);

      if ($form{'tour'} eq 'IRFmatch') {
         print "<td>$season</td>          
             <td>$form{'player'}</td> 
             <td align=center>$wins</td>
             <td align=center>$finals</td>
             <td align=center>$semis</td>
             <td align=center>$quarters</td>
             <td align=center>$sixteens</td>
             <td align=center>$thirtytwos</td>
             <td align=center>$sixtyfours</td>
             <td align=center>$onetwentyeights</td>
             <td align=center>$twofiftysixes</td>
             <td align=center>$others</td>
             <td align=center>$num_events</td></tr>";   
      }
      elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         print "<td>$season</td>          
             <td>$form{'player'}</td> 
             <td align=center>$wins</td>
             <td align=center>$finals</td>
             <td align=center>$semis</td>
             <td align=center>$quarters</td>
             <td align=center>$sixteens</td>
             <td align=center>$thirtytwos</td>
             <td align=center>$sixtyfours</td>
             <td align=center>$onetwentyeights</td>
             <td align=center>$twofiftysixes</td>
             <td align=center>$others</td>
             <td align=center>$num_events</td></tr>";   
      }
	  elsif ( $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
         print "<td>$season</td>          
             <td>$form{'player'}</td> 
             <td align=center>$wins</td>
             <td align=center>$finals</td>
             <td align=center>$semis</td>
             <td align=center>$quarters</td>
             <td align=center>$sixteens</td>
             <td align=center>$thirtytwos</td>
             <td align=center>$sixtyfours</td>
             <td align=center>$onetwentyeights</td>
             <td align=center>$twofiftysixes</td></tr>";   	  
	  }
      else {
         print "<td>$season</td>
             <td><center>${rank}</center></td>             
             <td>$form{'player'}</td> 
             <td align=center>$wins</td>
             <td align=center>$finals</td>
             <td align=center>$semis</td>
             <td align=center>$quarters</td>
             <td align=center>$sixteens</td>
             <td align=center>$thirtytwos</td>
             <td align=center>$sixtyfours</td>
             <td align=center>$onetwentyeights</td>
             <td align=center>$twofiftysixes</td>
             <td align=center>$others</td>
             <td align=center>$num_events</td></tr>";   
      }   
   }

   printf "</table><p>";

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      printf "<p>Career $tour Doubles Summary for <b>$form{'player'}</b><p>";
   }
   else {
      printf "<p>Career $tour Singles Summary for <b>$form{'player'}</b><p>";   
   }
   
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Career<br> Wins</b></td>
          <td><b>Career<br> Finals</b></td>
          <td><b>Career<br> Semis</b></td>
          <td><b>Career<br> Qtrs</b></td>
          <td><b>Career<br> 16s</b></td>
          <td><b>Career<br> 32s</b></td>
          <td><b>Career<br> 64s</b></td>
          <td><b>Career<br> 128s</b></td>
          <td><b>Career<br> 256s</b></td>
          <td><b>Career<br> Tourneys</b></td>
          </tr>\n";

   print "<td>$form{'player'}</td>
          <td align=center>$career_wins</td>
          <td align=center>$career_finals</td>
          <td align=center>$career_semis</td>
          <td align=center>$career_quarters</td>
          <td align=center>$career_sixteens</td>
          <td align=center>$career_thirtytwos</td>
          <td align=center>$career_sixtyfours</td>
          <td align=center>$career_onetwentyeights</td>
          <td align=center>$career_twofiftysixes</td>
          <td align=center>$career_total_results</td>
          </tr>";
   printf "</table>";

   #undef $tmp_rank;
   
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
sub tourney_pct() {

   if ($form{'query'} eq 'tourney_pct') {
      $sql = "select count(*) from results where round='2' and winner='$form{'player'}'";
   }
   elsif ($form{'query'} eq 'tourney_final_pct') {
      $sql = "select count(*) from results where round='2' and (winner='$form{'player'}' or loser='$form{'player'}')";
   }

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $tot_wins=$row[0];
   }

   $sql = "select count(distinct(date)) from results where (winner='$form{'player'}' or loser='$form{'player'}')";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $tot_entered=$row[0];
   }

   if ($tot_wins+$tot_entered > 0) {
      $winning_pct = ($tot_wins/$tot_entered);
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }

   if ($form{'query'} eq 'tourney_pct') {
      printf "Tourney Win Pct for <b>$form{'player'}</b><p>";
      printf "Tourneys Entered: <b>$tot_entered</b><br>";
      printf "Tourneys Won: <b>$tot_wins</b><br>";
      print "Overall Tourney Winning Pct: <b>$winning_pct</b><p>";  
   }
   elsif ($form{'query'} eq 'tourney_final_pct') {
      printf "Tourney Finals Made Pct for <b>$form{'player'}</b><p>";
      printf "Tourneys Entered: <b>$tot_entered</b><br>";
      printf "Tourneys Reaching Final: <b>$tot_wins</b><br>";
      print "Finals Reached Pct: <b>$winning_pct</b><p>";  
   }

   print "By Season:<p>";

   if ($form{'query'} eq 'tourney_pct') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
             <td><b>Player</b></td>
             <td><b>Tourney Wins</b></td>
             <td><b>Tourneys Entered</b></td>
             <td><b>Tourney Winning Pct</b></td>
             </tr>\n";
   }
   elsif ($form{'query'} eq 'tourney_final_pct') {
      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
             <td><b>Player</b></td>
             <td><b>Finals Made</b></td>
             <td><b>Tourneys Entered</b></td>
             <td><b>Finals Reached Pct</b></td>
             </tr>\n";
   }

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@seasons,$row);
   }

   foreach $season (@seasons) {
      if ($form{'query'} eq 'tourney_pct') {
         $sql = "select count(*) from results where round='2' and winner='$form{'player'}' and season='$season'";
      }
      elsif ($form{'query'} eq 'tourney_final_pct') {
         $sql = "select count(*) from results where round='2' and (winner='$form{'player'}' or loser='$form{'player'}') and season='$season'";
      }
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $tot_wins=$row[0];
      }

      $sql = "select count(distinct(date)) from results where (winner='$form{'player'}' or loser='$form{'player'}') and season = '$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $tot_entered=$row[0];
      }

      next if ($tot_entered eq "0");

      if ($tot_wins+$tot_entered > 0) {
         $winning_pct = ($tot_wins/$tot_entered);
         $winning_pct = sprintf("%.03f", $winning_pct);
      }
      else {
         $winning_pct = "0.000";
      }

      print "<td>$season</td>
          <td>$form{'player'}</td>
          <td align=center>$tot_wins</td>
          <td align=center>$tot_entered</td>
          <td align=center>$winning_pct</td>
          </tr>\n";
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	    
   
}


#--------------------------------------------------------------------------------
sub first_tour() {

   # This assumes that a player's first appearance on tour is a loss; I suppose in theory we should
   # change this logic to also capture if the person wins tehir first event ... but this is a minor coding bug.

   $sql = "select min(tmp_date) from results where loser='$form{'player'}'";
   print "<p>First Tour Appearance for <b>$form{'player'}</b><br>";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $tmp_date=$row[0];
   }

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where tmp_date='$tmp_date' and
           (winner='$form{'player'}' or loser='$form{'player'}') order by round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;


   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";

   $sql="select dob from player_profile where player='$form{'player'}'";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $dob=$row[0];
   }

   printf "$form{'player'} DOB on file is $dob<br>" if $debug;
   printf "date and tmp_date for first app are $tmp_date and $date<br>" if $debug;


# Now, get the first WIN on tour...

   $sql="select min(tmp_date) from results where winner='$form{'player'}' and round=2";
   print "<p>First Tour Win for <b>$form{'player'}</b><br>";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $tmp_date=$row[0];
   }

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where tmp_date='$tmp_date' and
           (winner='$form{'player'}' or loser='$form{'player'}') order by round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;


   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";

# this logic fails if the player has never lost ... a minor nit in the code.

   $sql="select count(*) from results where loser='$form{'player'}' and tmp_date <='$tmp_date'";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $number_events=$row[0];
   }

   if ($number_events > 0) {
      printf "<p><b>Number of events entered before winning first tourney</b>: $number_events";

      $x=$number_events+1;
      printf "<br>(in other words, he won his ${x}th pro event entered)";
   }
   else {
      printf "<p>No tourney wins";
   }

# 11/9/08: with player_profile table, get an estimate of age
# code borrowed from player_profile

   # gets DoB for player
   $sql = "select dob,tmp_dob from player_profile where player = '$form{'player'}";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;

      $dob=$row[0];
      $tmp_dob=$row[1];
   }


   # Tour Debut
   # Have to do this complicated sql basically to get the first winner on tour's logic correct (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT)
   #$sql = "select min(tmp_date) from results where loser='$form{'player'}'";
   $sql="select min(ldate) from (
             select min(tmp_date) as ldate from results where loser='$form{'player'}'
             union
             select min(tmp_date) as ldate from results where winner='$form{'player'}' and round=2) ldate_list";

   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $debut_date = $row[0];
   }

   $debut_date_varchar = &date_to_varchar($debut_date);
   ($debuty,$debutd)=&get_age($dob,$debut_date_varchar);

   printf "<p><b>Age of player at tour debut</b>: $debuty Years, $debutd days";
         
   # First Tour Win
   $sql = "select min(tmp_date) from results where winner='$form{'player'}' and round=2";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $firstwin_date = $row[0];
   }    
       
   $firstwin_date_varchar = &date_to_varchar($firstwin_date);
   ($firstwiny,$firstwind)=&get_age($dob,$firstwin_date_varchar);

   if ($number_events > 0) {
      printf "<br><b>Age of player at first tour win</b>: $firstwiny Years, $firstwind days";
   }
   
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
sub last_tour() {

   $sql="select max(tmp_date) from results where winner='$form{'player'}' and round=2";
   print "<p>Last Tour Win for <b>$form{'player'}</b><br>";

   # commented this out 7/14/15: can't replicate issue
   # print "<p>Note as of 11/1/11</b>: this query has a known bug related to Mysql's handling of dates with the 'max' function.  We are trying to figure out why it isn't showing the proper 'last' appearance dates for certain players<p>";

   print "<p>Last Tour Win for <b>$form{'player'}</b><br>";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $tmp_date=$row[0];
   }

   if ($tmp_date eq '') {
      printf "No wins on tour<br>"; 
   }
   else {

      $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
              from results where tmp_date='$tmp_date' and
              (winner='$form{'player'}' or loser='$form{'player'}') order by round desc";
      printf "$sql\n" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
             <td><b>Date</b></td>
             <td><b>City</b></td>
             <td><b>Event</b></td>
             <td><b>Round</b></td>
             <td><b>Winner</b></td>
             <td><b>Loser</b></td>
             <td><b>Score</b></td>
             </tr>\n";

         while (@row = $sth->fetchrow_array) {
            $winner=$row[0];
            $loser=$row[1];
            $round=$row[2];
            $score=$row[3];
            $tour=$row[4];
            $city=$row[5];
            $event=$row[6];
            $date=$row[7];
            $season=$row[8];
            $notes=$row[9];

            $new_round=&fix_round($round);

         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";

      }
      print "</table>\n";
   }

   print "<p>Last Tour Appearance for <b>$form{'player'}</b><br>";

   $sql = "select max(tmp_date) from results where loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $lastlossdate=$row[0];
   }
   $sql = "select max(tmp_date) from results where winner='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $lastwindate=$row[0];
   }

   printf "last loss date, last win date are  $lastlossdate, $lastwindate<br>" if $debug;
   if ($lastlossdate < $lastwindate) {
      $tmp_date=$lastwindate;
   }
   else {
      $tmp_date=$lastlossdate;
   }

   print "tmp_date returned is $tmp_date<br>" if $debug;

   $sql = "select winner,loser,round,score,tour,city,event,date,season,notes \
           from results where tmp_date='$tmp_date' and
           (winner='$form{'player'}' or loser='$form{'player'}') order by round desc";
   printf "$sql\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;


   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];
      $season=$row[8];
      $notes=$row[9];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td>$new_round</td>
          <td>$winner</td>
          <td>$loser</td>
          <td>$score</td>
          </tr>";

   }

   print "</table>\n";

# 11/9/08: with player_profile table, get an estimate of age
# code borrowed from player_profile

   # gets DoB for player
   $sql = "select dob,tmp_dob from player_profile where player = '$form{'player'}'";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;

      $dob=$row[0];
      $tmp_dob=$row[1];
   }

   # Last Tour Win
   $sql = "select max(tmp_date) from results where winner='$form{'player'}' and round=2";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $lastwin_date = $row[0];
   }

   $lastwin_date_varchar = &date_to_varchar($lastwin_date);
   ($lastwiny,$lastwind)=&get_age($dob,$lastwin_date_varchar);

   printf "<p><b>Age of player at last tour win</b>: $lastwiny Years, $lastwind days";

   # Last Tour Appearance
   # Have to do this complicated sql to get the guy who won the last tournament...
   #$sql = "select max(tmp_date) from results where loser='$form{'player'}'";
   $sql="select max(ldate) from (
           select max(tmp_date) as ldate from results where loser='$form{'player'}'
           union
           select max(tmp_date) as ldate from results where winner='$form{'player'}' and round=2) ldate_list";

   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $lastapp_date = $row[0];
   }

   $lastapp_date_varchar = &date_to_varchar($lastapp_date);
   ($lastappy,$lastappd)=&get_age($dob,$lastapp_date_varchar);

   printf "<p><b>Age of player at last appearance</b>: $lastappy Years, $lastappd days";

   &print_back_link;   
   printf "</body></html>";	    

}





#--------------------------------------------------------------------------------
sub ot_games() {

   printf "Entering ot_games\n" if $debug;

   $won=0;
   $lost=0;

   $sql="select winner,loser,round,score,tour,city,event,date,season,tmp_date \
         from results where \
         winner='$form{'player'}' or loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];
   
      next if ($score =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
      #next if ($score =~ /inj|fft|wbf/);

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);
      #&dump_array(@points);

      foreach $pt (@points) {
         $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$tmp_date";

         $stripped_pt=$pt;
         $stripped_pt =~ s/\(//;
         $stripped_pt =~ s/\)//;

         #printf "point is [$pt] stripped is [$stripped_pt]<br>" if $debug;

         if ($stripped_pt > "9") {
            if ($winner eq "$form{'player'}") {
               if ($pt =~ /\(/) {
                  $lost++;
               }
               else {
                  $won++;
               }
            }
            else {
               if ($pt =~ /\(/) {
                  $won++;
               }
               else {
                  $lost++;
               }
            }

            push (@possibles,$possible);
         }
      }
   }

   &dump_array(@possibles) if $debug;
   @possibles=&strip_duplicate_in_array(@possibles); 
   @possibles=&schwartzian_sort(9,\@possibles);
   printf "OT Games for $form{'player'}:<br><b>$won</b> Won, <b>$lost</b> Lost";

   if ($won+$lost > 0) {
      $winning_pct = ($won/($won+$lost));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {           
      $winning_pct = "0.000";
   }

   printf "<br>OT Game Winning pct: $winning_pct";
   ($junk,$junk,$overall_pct)=&gen_wl($form{'player'});
   printf "<br>(Overall Winning pct on tour: $overall_pct)<br>\n";

   printf "<p>OT Games";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total) = split(/~/,$match);

      $score=~ s/ /,/g;

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";
   }

   print "</table>";
   &print_back_link;
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
# Misc player stats
# formerly called after_first()


sub misc_player_stats() {

   printf "Entering Misc player Stats\n" if $debug;

   $wbf=0;
   $lbf=0;
   $w_no_score=0;
   $l_no_score=0;

# adding for WRT
   $two_game_wins=0;
   $two_game_losses=0;

   $three_game_wins=0;
   $three_game_losses=0;

   $four_game_wins=0;
   $won_losing_first_game=0;
   $won_winning_first_game=0;
   $won_splitting_first_two=0;
   $won_losing_third_of_four=0;

   $four_game_losses=0;
   $lost_winning_first_game=0;
   $lost_losing_first_game=0;
   $lost_losing_second_game=0;
   $lost_splitting_first_two=0;
   $lost_winning_third_of_four=0;

   $five_game_wins=0;
   #$won_losing_first_game=0;
   $won_losing_first_two=0;
   $won_splitting_first_two=0;
   $won_being_down_2to1=0;
   $won_being_up_2to1=0;
   #$won_winning_first_game=0;
   $won_splitting_first_two=0;
   $won_being_down_2to1=0;
   $won_being_up_2to1=0;
   $won_winning_first_two=0;
   $dropped_34=0;

   $five_game_losses=0;
   $lost_winning_first_game=0;
   $lost_winning_first_two=0;
   $lost_splitting_first_two=0;
   $lost_being_up_2to1=0; 
   $lost_being_down_2to1=0;
   $lost_losing_first_game=0;
   $lost_splitting_first_two=0;
   $lost_being_up_2to1=0; 
   $lost_being_down_2to1=0;
   $lost_losing_first_two=0;  
   $won_34=0;                

   $sql="select winner,loser,round,score,tour,city,event,date,season,tmp_date \
         from results where \
         winner='$form{'player'}' or loser='$form{'player'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];
      $tmp_date=$row[9];

      printf "$winner d $loser [$score]<br>" if $debug;

      if ($score =~ /inj|fft|ret|wbf|def|DEFAULT/) {
         if ($winner eq "$form{'player'}") {
            $wbf++;
         }
         else {
            $lbf++;
         }
         next;
      }

      if ($score eq "") {
         printf "entering no score logic<br>" if $debug;
         if ($winner eq "$form{'player'}") {
            $w_no_score++;
         }
         else {
            $l_no_score++;
         }
         next;
      }
         
      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      $game_count=@points;
	  $running_game_count+=$game_count;
	  	  
      #&dump_array(@points) if $debug;

	  
# inserting points logic created for most dominant tournament query here for later average point calculations...

      if ($form{'tour'} eq 'IRT') {
         if ($tmp_date lt '1981-08-01') {
            $max_points_per_game=21;
         }
         elsif ($tmp_date gt '1981-08-01' && $tmp_date lt '2017-12-31') {
            $max_points_per_game=11;
         }
         elsif ($tmp_date gt '2017-12-31') {
            $max_points_per_game=15;
         }
		 else {
		    printf "You should never get here; tmp_date is $tmp_date<p>";
		 }
      }
      elsif ($form{'tour'} eq 'LPRT') {
         if ($tmp_date lt '1986-08-01') { 
            $max_points_per_game=21;
         }
         elsif ($season eq '2000-01' || $season eq '2001-02') {
            $max_points_per_game=21;
         }
         else {
            $max_points_per_game=11;
         }         
      }
      elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'JUNIOR' ) {
         $max_points_per_game=15;
      }
      else {
         printf "Invalid Tour selected; you should never get here";
      }

      printf "tour is $form{'tour'} and max points per game is $max_points_per_game<br>" if $debug;

      foreach $sc (@points) {
         printf "Working on score: $sc<br>" if $debug;
         $total_games++;
         if ($sc =~ /\(/) {
            printf "entering game lost logic<br>" if $debug;
            $games_lost++;

            # remove parentheses from score to do arithmetic
            $sc =~ s/\(//g;
            $sc =~ s/\)//g;
            $total_points_scored+=$sc;

            if ($max_points_per_game eq 11) {
               if ($sc <= 9) {
                  $total_points_conceded+=11;
                  if (11 > $max_points_conceded) {
                     $max_points_conceded=11;
                  } 
                  else {
                     if (($sc+2) > $max_points_conceded) {
                        $max_points_conceded=($sc+2);
                     }
                  } 
               }
               else {
                  $total_points_conceded+=($sc+2);
               }
            }
            elsif ($max_points_per_game eq 15) {
               $total_points_conceded+=15;
               $max_points_conceded=15;
            }
            elsif ($max_points_per_game eq 21) {
               $total_points_conceded+=21;
               $max_points_conceded=21;
            }
         }
         else {
            printf "entering game won logic, total_points_scored is $total_points_scored<br>" if $debug;
            $games_won++;

            if ($max_points_per_game eq 11) {
               if ($sc <= 9) {
                  $total_points_scored+=11;
               }
               else {
                  $total_points_scored+=($sc+2);
               }
               $total_points_conceded+=$sc;
               if ($sc > $max_points_conceded) {
                  $max_points_conceded=$sc;
               } 
            }
            elsif ($max_points_per_game eq 15) {
               $total_points_scored+=15;
               $total_points_conceded+=$sc;
               if ($sc > $max_points_conceded) {
                  $max_points_conceded=$sc;
               } 
            }
            elsif ($max_points_per_game eq 21) {
               $total_points_scored+=21;
               $total_points_conceded+=$sc;
               if ($sc > $max_points_conceded) {
                  $max_points_conceded=$sc;
               } 
            }
         }
      } #foreach point 


      if ($total_games > 0 ) {
         $avg_points_conceded = $total_points_conceded/$total_games;
         $avg_points_scored = $total_points_scored/$total_games;
	  }
      else {
         $avg_points_scored=0;
         $avg_points_conceded=0;
	  }

      $avg_points_scored_rnded = sprintf("%.2f", $avg_points_scored);
      $avg_points_conceded_rnded = sprintf("%.2f", $avg_points_conceded);
	  
# Begining of per-game logic.


	 
      if ($game_count eq "2") {
         printf "entering 2-game score logic<br>" if $debug;
         if ($winner eq "$form{'player'}") {
            $two_game_wins++;
            $won_winning_first_game++;
         }
         else {
            $two_game_losses++;
            $lost_losing_first_game++;
         }
      }
      elsif ($game_count eq "3") {
         printf "entering 3-game score logic<br>" if $debug;
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {    
            if ($winner eq "$form{'player'}") {
               $three_game_wins++;
               $won_winning_first_game++;
            }
            else {
               $three_game_losses++;
               $lost_losing_first_game++;
            }
         }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch') {
            if ($winner eq "$form{'player'}") {
               $three_game_wins++;
               if ($points[0] =~ /\(/ ) {
                  $won_losing_first_game++;
               }
               if ($points[1] =~ /\(/ ) {
                  $won_winning_first_game++;
                  $won_losing_second_game++;
			   }
            }
            else { 
               $three_game_losses++;
               if ($points[0] =~ /\(/ ) {
                  $lost_winning_first_game++;
                  $lost_losing_second_game++;
               }
               if ($points[1] =~ /\(/ ) {
                  $lost_losing_first_game++;
               }
            }
         }
         else {
            # should never get here
         }

         printf "exiting 3-game score logic. three_game_wins is $three_game_wins, three_game_losses is $three_game_losses, won_winning_first_game is $won_winning_first_game, lost_losing_first_game is $lost_losing_first_game, lost_losing_second_game is $lost_losing_second_game, lost_losing_first_game is $lost_losing_first_game <br>" if $debug;

      }
      elsif ($game_count eq "4") {
         if ($winner eq "$form{'player'}") {
            $four_game_wins++;
            if ($points[0] =~ /\(/ ) {
               $won_losing_first_game++;
            }
            else {
               $won_winning_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $won_splitting_first_two++;
               }
               else {
                  $won_losing_third_of_four++;
               }
            }
         }
         else {
            $four_game_losses++;
            if ($points[0] =~ /\(/ ) {
               $lost_winning_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $lost_losing_first_two++;
               }
               else {
                  $lost_splitting_first_two++;
               }
            }
            else {
               $lost_losing_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $lost_splitting_first_two++;
               }
               else {
                  $lost_winning_third_of_four++;
               }
            }
         }
      }
      elsif ($game_count eq "5") {
         if ($winner eq "$form{'player'}") {
            $five_game_wins++;
            if ($points[0] =~ /\(/ ) {
               $won_losing_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $won_losing_first_two++;
               }
               else {
                  $won_splitting_first_two++;
                  if ($points[2] =~ /\(/ ) {
                     $won_being_down_2to1++;
                  }
                  else {
                     $won_being_up_2to1++;
                  }                      
               }
            }
            else {
               $won_winning_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $won_splitting_first_two++;
                  if ($points[2] =~ /\(/ ) {
                     $won_being_down_2to1++;
                  }
                  else {
                     $won_being_up_2to1++;
                  }                      

               }
               else {
                  $won_winning_first_two++;
                  $dropped_34++;
               }
            }
         }
         else {
            $five_game_losses++;
            if ($points[0] =~ /\(/ ) {
               $lost_winning_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $lost_winning_first_two++;
               }
               else {
                  $lost_splitting_first_two++;
                  if ($points[2] =~ /\(/ ) {
                     $lost_being_up_2to1++;
                  }
                  else {
                     $lost_being_down_2to1++;
                  }                      
               }
            }
            else {
               $lost_losing_first_game++;
               if ($points[1] =~ /\(/ ) {
                  $lost_splitting_first_two++;
                  if ($points[2] =~ /\(/ ) {
                     $lost_being_up_2to1++;
                  }
                  else {
                     $lost_being_down_2to1++;
                  }                      
               }
               else {
                  $lost_losing_first_two++;
                  $won_34++;
               }
            }
         }
      }
      else {
         if ($winner eq "$form{'player'}") {
            $w_no_score++;
         }
         else {
            $l_no_score++;
         }
      }
   }

   ($overall_wins,$overall_losses,$overall_pct)=&gen_wl($form{'player'});

# 1/22/17: adding in a quick additional stat; record after winning first two games.

   $won_winning_first_two_overall=$three_game_wins+$won_losing_third_of_four+$won_winning_first_two;


   printf "Statistics for <b>$form{'player'}</b><br>";


   print "<table border><tr>\n";
   print "<td><b>Statistic</b></td>            
          <td><b>Data</b></td></tr>\n";    
   

   printf "<tr><td>Overall W/L on tour</td><td>$overall_wins - $overall_losses</td></tr>";
   printf "<tr><td>Overall W/L Percentage</td><td>$overall_pct</td></tr>";

   if ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' ) {
      printf "<tr><td>2-game record</td> <td> $two_game_wins - $two_game_losses</td></tr>";
      printf "<tr><td>Tiebreaker record</td> <td> $three_game_wins - $three_game_losses</td></tr>";
   }

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') { 
      printf "<tr><td>3-game record</td> <td> $three_game_wins - $three_game_losses</td></tr>";
      printf "<tr><td>4-game record</td><td> $four_game_wins - $four_game_losses</td></tr>";
      printf "<tr><td>5-game record</td><td> $five_game_wins - $five_game_losses (see 5-game special link)</td></tr>";
   }
   printf "<tr><td>Wins - Losses with no score available</td><td>$w_no_score - $l_no_score</td></tr>";

   printf "<tr><td>Matches won and lost by forfeit</td><td>$wbf - $lbf</td></tr>";

   printf "<tr><td>Record When winning first game</td><td>$won_winning_first_game - $lost_winning_first_game</td></tr>";
   printf "<tr><td>Record When losing first game</td><td>$won_losing_first_game - $lost_losing_first_game</td></tr>";

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') { 
      printf "<tr><td>Record splitting first 2 games</td><td>$won_splitting_first_two - $lost_splitting_first_two</td></tr>";
      printf "<tr><td>Record winning first 2 games</td><td>$won_winning_first_two_overall - $lost_winning_first_two</td></tr>";

      $losses_losing_firsttwo = $three_game_losses + $lost_winning_third_of_four + $lost_losing_first_two;
      printf "<tr><td>Record losing first 2 games</td><td>$won_losing_first_two - $losses_losing_firsttwo</td></tr>";

      printf "<tr><td>Won in 4: dropped third game</td><td> $won_losing_third_of_four out of $four_game_wins total</td></tr>";
      printf "<tr><td>Lost in 4 but picked up 3rd game</td><td> $lost_winning_third_of_four out of $four_game_losses total</td></tr>";

      printf "<tr><td>5 game wins being down 2 games to 0</td><td> $won_losing_first_two (out of $five_game_wins total)</td></tr>";
      printf "<tr><td>5 game losses being two games up</td><td> $lost_winning_first_two (out of $five_game_losses total)</td></tr>";

      printf "<tr><td>5 game record after being up 2-1</td><td> $won_being_up_2to1 - $lost_being_up_2to1</td></tr>";
      printf "<tr><td>5 game record after being down 2-1</td><td> $won_being_down_2to1 - $lost_being_down_2to1</td></tr>";

      printf "<tr><td>5 game wins winning first two, dropping next two</td><td> $won_winning_first_two (out of $five_game_wins total)</td></tr>";
      printf "<tr><td>5 game losses losing first two, winning next two</td><td> $lost_losing_first_two (out of $five_game_losses total)</td></tr>";
   }
   
   printf "<tr><td>Total Games Played</td><td>$running_game_count</td></tr>";   
   
   $avg_games = ($running_game_count/($overall_wins + $overall_losses - $w_no_score - $l_no_score));
   $avg_games_fmt = sprintf("%.03f", $avg_games);
   printf "<tr><td>Average Games per Match</td><td>$avg_games_fmt</td></tr>";   
   
   $avg_games_in_wins = ((($two_game_wins*2) + ($three_game_wins*3) + ($four_game_wins*4) + ($five_game_wins*5))/
                        ($two_game_wins+$three_game_wins+$four_game_wins+$five_game_wins));
   $avg_games_in_wins_fmt = sprintf("%.03f", $avg_games_in_wins);
	  
   printf "<tr><td>Average Games per Match in Wins</td><td>$avg_games_in_wins_fmt</td></tr>";   

   $avg_games_in_losses = ((($two_game_losses*2) + ($three_game_losses*3) + ($four_game_losses*4) + ($five_game_losses*5))/
                        ($two_game_losses+$three_game_losses+$four_game_losses+$five_game_losses));
   $avg_games_in_losses_fmt = sprintf("%.03f", $avg_games_in_losses);

   printf "<tr><td>Average Games per Match in Losses</td><td>$avg_games_in_losses_fmt</td></tr>";   

   printf "<tr><td>Average Points Scored per Game</td><td>$avg_points_scored_rnded</td></tr>";   
   printf "<tr><td>Average Points Conceded per Game</td><td>$avg_points_conceded_rnded</td></tr>";  

   &print_back_link;   
   printf "</body></html>";	    
   
   
}

#--------------------------------------------------------------------------------
# 5/12/14: bug fix; had extra column in here.
# 1/6/18: renamed routine to not conflict with match wins query

sub most_tourney_wins() {

   $sql = "select count(distinct(winner)) from results where round=2;";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $numdistinct=$row[0];
   }


   if ($form{'tour'} eq 'IRT') {
      # This is numdistinct -1 because of the cancelled IRT 2005 New Orleans final, a ? in the database.
      $numdistinct=$numdistinct-1;

      printf "Number of distinct winners in Pro Tour history: <b>$numdistinct</b><p>";

      printf "Note: there are three notes to keep in mind while looking at these IRT tourney win counts:";
      printf "<li>In the late 70s/early 80s there were MANY \"unsanctioned\" tourneys won by \
           players of the era (Hogan mostly) that were not officially recorded into the \
           NRC match database.  We have no way of capturing these results.";
      printf "<li>One of Monchik's more dominant seasons still has missing results in the database.  We're \
           working to rectify the situation.";
      printf "<li>Much was made of Kane's 71'st victory, which put him over top of Swain for career wins.  However, Swain is missing a number of 
	       wins in the database from seasons in the early to mid 90s and has more than 70 tourney wins.  We have no way of knowing exactly how many 
		   more ... but it may be moot because Kane now has more than 100 career wins, well above where Hogan/Swain may have ever achieved.";
      printf "<li>One of Beltran's wins occurred during the 2002-3 season in an event in McLean, VA that awarded all qualifiers equal rankings 
	       points on account of poor court conditions.  The players continued to compete for additional prize money but curtailed their competitiveness 
		   to avoid injury.";
      printf "<li>The '?' winner is a placeholder for the final of the 2005 New Orleans tourney, cancelled by Hurricane Katrina.  
	       It won't ever be replayed.  This result is NOT included in the total number of distinct winners above.  De La Rosa is the 35th distinct 
		   player to win an event with his Dec 2014 tourney win in New Jersey, Charlie Pratt is the 36th ever winner by virtue of his Dec 2017 Portland win,
             and Alejandro Landa is the 37th ever distinct winner with his Sioux Falls 2018 win.";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "Number of distinct winners in Pro Tour history: <b>$numdistinct</b><p>";
 
      printf "Note: The Ladies pro tour database is not complete and we are missing many results.";
   }
   elsif ($form{'tour'} eq 'WRT') {
      printf "Number of distinct winners in Pro Tour history: <b>$numdistinct</b><p>";

      printf "Note: The WRT database is complete to its inception in Oct 2012.  We are missing full results for three events in 2013 (which have 
	  placeholders for the finals only) but otherwise the database is 100% accurate.  We are working on obtaining the missing results.";
   }
   elsif ($form{'tour'} eq 'IRFmatch') {
      printf "Number of distinct winners in IRF Tour history: <b>$numdistinct</b><p>";

      printf "Note: the IRF match database is only accurate to a few recent events; it may never be able to be completely populated given 
	  sparseness of available data dating to the early days of International events in the 1980s.  ";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "Number of distinct winners in Amateur National Association Tour history: <b>$numdistinct</b><p>";

      printf "Note: the Amateur National Championships match database is only accurate with full draws to the mid 2000s; it may never be able to be completely populated given 
	  sparseness of available data dating to the early days of Amateur events in the late 1960s.  I have also focused solely on the 3 largest countries; if National
      events occur in smaller countries, i do not have them.  At the very least I have the champions for USA to 1968 and Canada to 1975.";
   }   
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      printf "Number of distinct winners in $tour Doubles Pro tour history: <b>$numdistinct</b><p>";

      printf "Note: the $tour doubles is only built back to mid 2014, the starting point for seeding.  It is not a comprehensive list of the history of doubles.";
   }  
   else {
      printf "Invalid Tour selected; you should never get here";
   }


           
  
   printf "<p><b>Most Tourney Wins by Player</b><p>";
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Number of Wins</b></td>
          </tr>\n";

   $sql = "select winner,count(winner) as 'wins' from results where round=2 \
           group by winner order by wins desc;";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $numberwins=$row[1]; 

      print "<tr><td>$player</td>
             <td align=center>$numberwins</td></tr>";
 
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	    
   
}
#--------------------------------------------------------------------------------
# 1/6/18: overloading this with wins and losses
# 

sub most_appearances () {

   if ($form{'query'} eq 'most_appearances') {
      printf "<p><b>Most Appearances on Tour</b><p>";

      print "<table border><tr>\n";
      print "<td><b>Rank</b></td>
             <td><b>Player</b></td>
          <td><b>Number of Appearances</b></td>
          </tr>\n";
   }
   elsif ($form{'query'} eq 'most_wins') {
      printf "<p><b>Most Wins on Tour</b><p>";

      print "<table border><tr>\n";
      print "<td><b>Rank</b></td>
             <td><b>Player</b></td>
          <td><b>Number of Wins</b></td>
          </tr>\n";
   }
   elsif ($form{'query'} eq 'most_losses') {
      printf "<p><b>Most Losses on Tour</b><p>";

      print "<table border><tr>\n";
      print "<td><b>Rank</b></td>
             <td><b>Player</b></td>
          <td><b>Number of Losses</b></td>
          </tr>\n";
   }
   else {
      printf "You should never get here<p>";
   }

   # get distinct list of players for processing
   $sql = "select distinct winner as name from results \
           union \
           select distinct loser as name from results order by name";
   
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   #&dump_array(@players) if $debug;

   for $player (@players) {
      next if ($player =~ /\?/);
      #printf "working on [$player]<br>" if $debug;

      if ($form{'query'} eq 'most_appearances') {
         $sql = "select count(distinct(date)) from results where (winner='$player' or loser='$player')";
      }
      elsif ($form{'query'} eq 'most_wins') {
         $sql = "select count(*) from results where winner='$player'";
      }
      elsif ($form{'query'} eq 'most_losses') {
         $sql = "select count(*) from results where loser='$player'";
      }
      else {
         printf "You should never get here<p>";

      }

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while ($appearances = $sth->fetchrow_array) {
         push (@playerapp,"$player~$appearances");
      }
   }

   #&dump_array(@playerapp) if $debug;

   $sort_field=1;
   @playerapp=&schwartzian_sort($sort_field,\@playerapp);

   # Sort sorts ascending.  we want descending, from most to least
   @playerapp=&reverse_array(@playerapp);

   $counter=1;
   for $playerapp (@playerapp) {
      #printf "working on [$playerapp]<br>" if $debug;
      ($player,$apps)=split(/~/,$playerapp);
      print "<tr><td align=center>$counter</td>
             <td>$player</td>
             <td align=center>$apps</td></tr>";
      $counter++;
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       
   
}


#--------------------------------------------------------------------------------
# 1/19/18: new idea; longest appearance streak to highlight Rocky's amazing durability
# 

sub longest_appearance_streak () {

   printf "<p><b>Longest Tourney Appearance Streaks </b><p>";

   printf "Please Note: this is a very long query for the larger tours; please be patient as it has to scroll through every tournament for every player
             on record.<P>";

   printf "Note: in this report if a player misses/skips a tournament, the streak ends.  If a player enters a tourney but then withdraws with a forfeit loss,
           we still count it as an appearance.";

   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Date of First Tourney Appearance of streak</b></td>
          <td><b>Date of Last Tourney Appearance of streak</b></td>
          <td><b># Tourney Appearances in a row</b></td>
          </tr>\n";

   # get distinct list of players for processing; limit this to those who have more than a nominal amount of results since this is more of
   # a tour regular type query.
   #$sql = "select distinct winner as name from results \
   #        union \
   #        select distinct loser as name from results order by name";


   if ($form{'tour'} eq 'IRT') {
      $match_limit = 30;
      $streak_threshold = 30; 
   }
   elsif ($form{'tour'} eq 'LPRT') {
      $match_limit  = 30;
      $streak_threshold = 10; 
   }
   elsif ($form{'tour'} eq 'WRT' ) {
      $match_limit = 0;
      $streak_threshold = 1; 
   }
   
   $sql = "select winner from wins where wins >= $match_limit order by winner";
   
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   #&dump_array(@players) if $debug;

   # temporarily override @players for testing
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro','Carson, Rocky');

   
   # this gets a distinct list of tourneys to scroll through.
   $sql="select distinct(event),city,date,tmp_date from results order by tmp_date";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=1;
   
   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
      $city=$row[1];
      $date=$row[2];
      $tmp_date=$row[3];
	  
	  push (@tourneys,"$event~$tmp_date");
   }
   
   #&dump_array(@tourneys) if $debug;

   # This gets the latest date in the database, to set "current" in loop logic
   $sql = "select max(tmp_date) from results";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $max_tmp_date = $row[0];
   }

   printf "max date is $max_tmp_date<br>" if $debug;

   
   # now scroll through all players, and start calculating streaks.
   
   for $player (@players) {
      next if ($player =~ /\?/);
      #printf "working on [$player]<br>" if $debug;

      #initialize streak variables
	$appearance_streak=0;
      $streak_start_date='';
      $streak_end_date='';
   
      foreach $tourneyline (@tourneys) {
         ($event,$tmp_date) = split(/~/,$tourneyline);
	   #printf "$tourneyline<p>" if $debug;
	   printf "$event,$tmp_date<p>" if $debug;	  
		 
         $sql = "select count(*) from results where event='$event' and tmp_date='$tmp_date'
                 and (winner='$player' or loser='$player');";
     
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) { 
            $count=$row[0];
         }	

         printf "count returned and assigned to count var is $count<p>" if $debug;
		 
         # there's an appearance if there's any matches.
         if ($count > 0) {
            if ($tmp_date eq $max_tmp_date ) {
               # we've reached the latest tourney; need to push to the possibles
               $streak_end_date="current";
               if ($appearance_streak > $streak_threshold) {
                   $possible="$appearance_streak~$player~$streak_start_date~$streak_end_date";
                   push (@possibles,$possible);			   
		   }
            }
            else {
               # there's an active streak; extend it and set working end date to current date for next iteration.
               printf "appearance_streak is $appearance_streak, count is $count<p>" if $debug;
	         if ($appearance_streak > 0) {
                  printf "appearance_streak is > zero, incrementing it to $appearance_streak plus one, resetting streak end date to $tmp_date<p>" if $debug;
                  $appearance_streak++;		
		      $streak_end_date=$tmp_date;
		   }
		   # this is a new streak.
		   else {
                  printf "appearance_streak is zero, resetting streak start date to $tmp_date<p>" if $debug;
		      $appearance_streak++;
                  $streak_start_date=$tmp_date;						
		   }
            }
	    }
	    # streak ending; push the streak to the possibles
	    else {
             printf "count is zero, streak ending.  appearance_streak is $appearance_streak, count is $count<p>" if $debug;
             if ($appearance_streak > 30) {
                $possible="$appearance_streak~$player~$streak_start_date~$streak_end_date";
                push (@possibles,$possible);			   
		 }
			
		 #initialize streak variables
	       $appearance_streak=0;
             $streak_start_date='';
             $streak_end_date='';
	   }
      }
   }

   &dump_array(@possibles) if $debug;

   $sort_field=0;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from most to least
   @possibles=&reverse_array(@possibles);

   $counter=1;
   for $possible (@possibles) {
      #printf "working on [$[possible]<br>" if $debug;
      ($appearance_streak,$player,$streak_start_date,$streak_end_date)=split(/~/,$possible);
      print "<tr><td align=center>$counter</td>
             <td>$player</td>
             <td><center>$streak_start_date</center></td>
             <td><center>$streak_end_date</center></td>			 
             <td align=center>$appearance_streak</td></tr>";
      $counter++;
   }
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	     



}

#--------------------------------------------------------------------------------
sub wl_pct_all () {

   if ($form{'tour'} eq 'IRT') {
      $match_limit=20;
   }
   elsif ($form{'tour'} eq 'LPRT') {
      $match_limit=20;
   }
   elsif ($form{'tour'} eq 'WRT') {
      $match_limit=10;
   }
   elsif ($form{'tour'} eq 'IRFmatch') {
      $match_limit=1;
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      $match_limit=1;
   }   
   elsif ($form{'tour'} eq 'JUNIOR') {
      $match_limit=1;
   }  
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $match_limit=1;  
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }

   printf "<p><b>Best Overall W/L Percentages in History (players w/ at least $match_limit match wins)</b><p>";
   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>W/L Percentage</b></td>
          </tr>\n";

   $sql = "select winner from wins where wins >= $match_limit order by winner";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   &dump_array(@players) if $debug;

   for $plyr (@players) {
      next if ($plyr =~ /\?/);
      ($wins,$losses,$pct)=&gen_wl($plyr);

      push (@playerwl,"$plyr~$wins~$losses~$pct");
   }

   # Sort on w/l percentage
   # by sorting first on #wins, THEN on pct, it sorts properly on the page!
   @playerwl=&schwartzian_sort(1,\@playerwl);
   @playerwl=&schwartzian_sort(3,\@playerwl);
   
   # Sort sorts ascending to put best w/l pct first
   @playerwl=&reverse_array(@playerwl);

   $rank=0;

   for $plyr_wl (@playerwl) {
      ($player,$wins,$losses,$pct)=split(/~/,$plyr_wl);
      $rank++;
      
      print "<tr><td align=center><b>$rank</b></td>
             <td>$player</td>
             <td align=center>$wins</td>
             <td align=center>$losses</td>
             <td align=center>$pct</td></tr>";
   }
   
   print "</table>";
   &print_back_link;   
   printf "</body></html>";	       
}





#--------------------------------------------------------------------------------
sub best_season () {

   printf "<p><b>Best Season Winning Pcts of All time</b><p>";

   if ($form{'tour'} eq 'IRT') {
      printf "<p>(Be patient; this is a longer running query, and remember that the data in 1989-1990 and 1999-00 is incomplete in the DB)<p>";
   }

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Season</b></td>
          <td><b>Wins</b></td>
          <td><b>Losses</b></td>
          <td><b>W/L Percentage</b></td>
          </tr>\n";

   $sql = "select winner from wins where wins > 30 order by winner";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   &dump_array(@players) if $debug;

   #@players=('Swain, Cliff');
   #@players=('Hogan, Marty');
   #@players=('Monchik, Sudsy');
   #@players=("O'Neil, Todd");

   for $plyr (@players) {
      next if ($plyr =~ /\?/);
      $sql = "select distinct(season) from results where winner=\"$plyr\" order by 1";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while ($row = $sth->fetchrow_array) {
         push (@seasons,$row);
      }

      &dump_array(@seasons) if $debug;

      for $seasn (@seasons) {
         $sql = "select count(*) from results where winner=\"$plyr\" and season='$seasn'";
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            $season_wins=$row[0];
         }
   
         $sql = "select count(*) from results where loser=\"$plyr\" and season='$seasn'";
         $sth = $dbh->prepare($sql);  
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            $season_losses=$row[0];  
         }
      
         next if $season_wins+$season_losses == 0;
         next if $season_wins+$season_losses < 10;

         if ($season_wins+$season_losses > 0) {
            $season_winning_pct = ($season_wins/($season_wins+$season_losses));
            $season_winning_pct = sprintf("%.03f", $season_winning_pct);
         }
         else {
            $season_winning_pct = "0.000";
         }
   
         #printf "returning $seasn, $season_wins,$season_losses,$season_winning_pct for $plyr\n" if $debug;
         push (@seasonpct,"$seasn~$plyr~$season_wins~$season_losses~$season_winning_pct");
      }

      &dump_array(@seasonpct) if $debug;
   }

   # strip duplicates
   @seasonpct=&strip_duplicate_in_array(@seasonpct);

   # Sort on w/l percentage
   @seasonpct=&schwartzian_sort(4,\@seasonpct);
   
   # Sort sorts ascending to put best w/l pct first
   @seasonpct=&reverse_array(@seasonpct);
   
   $rank=0;
      
   for $plyr_wl (@seasonpct) {
      ($season,$player,$wins,$losses,$pct)=split(/~/,$plyr_wl);
      $rank++;
         
      print "<tr><td align=center><b>$rank</b></td>
             <td>$player</td>
             <td align=center>$season</td>
             <td align=center>$wins</td>
             <td align=center>$losses</td>
             <td align=center>$pct</td></tr>";
   }
   
   print "</table>";   
   &print_back_link;
   printf "</body></html>";	       
}

#--------------------------------------------------------------------------------
# 1/9/17: Longest Game Winning Streaks. 
#


sub longest_game_streak () {

   printf "<p><b>Longest Game Winning Streaks on tour</b><p>";

   printf "Note: This report skips games that are forfeits without having taken the court.<p>";

   if ($form{'tour'} eq 'IRT') {
      $streak_limit=20; 
      printf "I've set the cut-off for games streaks at $streak_limit for the IRT; which is not quite two straight tourney wins in straight games.  It is also worth noting that prior to 1982, the Mens pros only played best 2 of 3, so any pre-1982 streak represents a more difficult streak to achieve.  See Hogan's 27 game streak in his dominant 1977-78 season for example.<p>";

      print "<p>Note about Kane's 113 game streak: these reports calculate his 2016-17 seasonal match record at 29-0 but his game record at 85-0.  29 matches * 3 games each = 87 games.  So why does the report list 85 games instead of 87?  Because in one of his tournaments, Kane won a final over DLR 11-0, inj-fft.  The report counts this as just one game won instead of three, and thus gives him 85 games instead of 87 on that season.  This is in contrast/disagreement to the way that Kane's undefeated game-season was reported by USRA and others, who attributed him to have won 87 games.  This report counts solely those games that were competed on the court and had a result and does not attempt to give game win credit for forfeits.  This is how the report arrives at 113 games instead of 115 (were you to give Kane 87 game wins for his undefeated season) or 112 (were you to give him zero game
win credit for the 11-0,inj-fft result).";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      $streak_limit=25;
      printf "I've set the cut-off for games streaks at $streak_limit for the LPRT, which is a bit more than two straight tourney wins in straight games. The scoring has varied so much over the years in the Women's pro tour that it seems quite difficult for players of a certain era to ever show up in this report.<p>";

   }
   elsif ($form{'tour'} eq 'WRT') {
      $streak_limit=10;
      printf "I've set the cut-off for games streaks at $streak_limit for the WRT since the matches are two out of three.<p>";
   }
   elsif ($form{'tour'} eq 'IRFmatch') {
      $streak_limit=5;
      printf "I've set the cut-off for games streaks at $streak_limit for the IRF since the matches are two out of three and theres so few events for these players to play.<p>";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      $streak_limit=5;
      printf "I've set the cut-off for games streaks at $streak_limit for the Amateur matches since the matches are two out of three and theres so few events for these players to play.<p>";
   }   
   elsif ($form{'tour'} eq 'JUNIOR') {
      $streak_limit=5;
      printf "I've set the cut-off for games streaks at $streak_limit for the Amateur matches since the matches are two out of three and theres so few events for these players to play.<p>";
   } 
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      $streak_limit=3;
      printf "I've set the cut-off for games streaks at $streak_limit for the $tour doubles matches since the matches are two out of three and theres so few events for these players to play.<p>";
   }   
   else {
      printf "Invalid Tour selected; you should never get here";
   }



   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b># Games Won in a row</b></td>
          <td><b>Date of First Game Win of streak</b></td>
          <td><b>Date of Last Game Win of streak</b></td>
          </tr>\n";

   $sql = "select distinct winner as name from results \
           union \
           select distinct loser as name from results order by name";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   #&dump_array(@players) if $debug;

   # testing...
   #@players=('Swain, Cliff');
   #@players=('Hogan, Marty');
   #@players=('Mar, Javier');
   #@players=('Waselenchuk, Kane');

   #initialize game_streak variable
   $game_streak=0;
   $streak_start_date='';
   $streak_end_date='';
   
   for $plyr (@players) {
      next if ($plyr =~ /\?/);

      printf "Entering game streak logic for $plyr<p>" if $debug;

      $sql = "select winner,loser,round,score,tour,city,event,date,season \
              from results where \
              winner='$plyr' or loser='$plyr' order by tmp_date,round desc";
      printf "$sql<p>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
         $loser=$row[1];
         $round=$row[2];
         $score=$row[3];
         $tour=$row[4];
         $city=$row[5];
         $event=$row[6];
         $date=$row[7];
         $season=$row[8];
         $notes=$row[9];

         &dump_array(@row) if $debug;

         # if this is a new streak, capture the start date
         if ($game_streak eq 0) {
            printf "game_streak is zero, resetting streak start date to $date<p>" if $debug;
            $streak_start_date=$date;
         }   
      
         # Data entry errors cause some scores to have commas, others spaces separating
         # game scores.  Must stript them
         if ($score =~ /\,/) {
            $score =~ s/\,/ /g;
         }
   
         # clean Extra spaces in scores
         $score=~ s/  */ /g;

         @points=split(/ /,$score);

         &dump_array(@points) if $debug;
   
         if ($plyr eq $winner) {
            printf "Entering player is winner logic<p>" if $debug;
            foreach $ttl (@points) {
               next if ($ttl =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
               if ($ttl =~ /\(/) {
                  # current streak over
                  if ($game_streak >= $streak_limit) {
                     printf "Streak is over; ending at $game_streak, pushing to possibles<p>" if $debug;
                     $streak_end_date=$date;
                     $possible="$game_streak~$plyr~$streak_start_date~$streak_end_date";
                     push (@possibles,$possible);
                     $game_streak=0;
                     $streak_start_date='';
                     $streak_end_date='';
                     printf "game_streak is zero, resetting streak start date to $date<p>" if $debug;
                     $streak_start_date=$date;
                  } 
                  else {
                     printf "Streak is over; ending at $game_streak, not large enough to push so resetting<p>" if $debug;
                     $game_streak=0;
                     $streak_start_date='';
                     $streak_end_date='';
                     printf "game_streak is zero, resetting streak start date to $date<p>" if $debug;
                     $streak_start_date=$date;
                  }
               }
               else {
                  $game_streak++;
                  printf "Incrementing game_streak; it is now $game_streak<br>" if $debug;
               }
            }
         }
         elsif ($plyr eq $loser) {
            printf "Entering player is loser logic<p>" if $debug;
            foreach $ttl (@points) {
               next if ($ttl =~ /inj|INJ|fft|\?|SNA|FORFEIT|FFT|n\/a|N\/A|def|GAMES|DEFAULT|wbf|ret|noshow/);
               if ($ttl =~ /\(/) {
                  # lost this match but won the game, streak continues
                  $game_streak++;
                  printf "Incrementing game_streak; it is now $game_streak<br>" if $debug;
               }
               else {
                  # current streak over
                  if ($game_streak >= $streak_limit) {
                     printf "Streak is over; ending at $game_streak, pushing to possibles<p>" if $debug;
                     $streak_end_date=$date;
                     $possible="$game_streak~$plyr~$streak_start_date~$streak_end_date";
                     push (@possibles,$possible);
                     $game_streak=0;
                     $streak_start_date='';
                     $streak_end_date='';
                     printf "game_streak is zero, resetting streak start date to $date<p>" if $debug;
                     $streak_start_date=$date;
                  }
                  else {
                     printf "Streak is over; ending at $game_streak, not large enough to push so resetting<p>" if $debug;
                     $game_streak=0;
                     $streak_start_date='';
                     $streak_end_date='';
                     printf "game_streak is zero, resetting streak start date to $date<p>" if $debug;
                     $streak_start_date=$date;
                  }
               }
            }
         }
         else {
            # should never get here
         }
      }
   }

   print "dumping array of possibles now<p>" if $debug;
   &dump_array(@possibles) if $debug;

   # Sort the possibles by the number of matchups
   $sort_field=0;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @possibles=&reverse_array(@possibles);

   foreach $line (@possibles) {
      printf "$line<br>" if $debug;

      ($game_streak,$plyr,$streak_start_date,$streak_end_date) = split(/~/,$line);

       print "<tr><td>$plyr</td>
          <td><center>$game_streak</center></td>
          <td><center>$streak_start_date</center></td>
          <td><center>$streak_end_date</center></td>
          </tr>";

   }

   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       


}




#--------------------------------------------------------------------------------
# 11/10/09: Longest Match Winning Streaks. made this work.  

sub longest_match_streak () {

   printf "<p><b>Longest Match Winning Streaks on tour</b><p>";

   if ($form{'tour'} eq 'IRT') {
      printf "Some notes related to these streaks to keep in mind:<br>";
      printf "<li>Kane's 134-match winning streak is well known, achieved at the 2011 Salt Lake City event.  The query below counts forfeit losses as match losses, breaking streaks.  Therefore if you add up Kane's top two winning streaks of 81 and 53 (which was interupted by a forfeited match in January of 2012 in NYC) you get the 134 match winning streak 'on the court' that is oft-mentioned as Kane's big record.";
      printf "It has proven difficult to code a 'no forfeit winning streak' report to illustrate/demonstrate the Kane 134-match streak; we tried a draft version but it wouldn't work properly.  It is on our todo list.<br>";
      printf "<li>I've cut off the win streaks at 14, which would be basically 3 tourneys won in a row until the mid 90s and then 4+ tourneys today.  Otherwise there's just too many small winning streaks in the report to display.";
      printf "<li>Kane's streak from 4/30/06 to 1/11/09 includes time off for 2 year suspension, which looks odd in the report but he suffered no losses inbetween, so the streak is valid.";
      printf "<LI>Marty's late 1970s streaks do not include the many non-NRC sanctioned events that he presumably entered and won ... for the same reasons why they're not in the match database.  No official records.  So Marty's streak is probably a lot longer than listed here.</LI>";
      printf "<li>Sudsy's 1999 winning streak is actually a few games more than shown; because of missing tourney results for the time period he's missing many qualifier rounds.  Once all missing results are found, his winning streak will be in the mid 40s in terms of games.";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "The LPRT match win streak query will not be meaningful until Michelle (Gilman) Gould's complete career is put into the database.  She was just as dominant, if not moreso, than Longoria is in the current game.  We are working to capture the bulk of the 1990s era matches.";
   }

   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Date of First Win of streak</b></td>
          <td><b>Date of Last Win of streak</b></td>
          <td><b># Wins in a row</b></td>
          </tr>\n";


   # This gets the latest date in the database, to control the while loop
   $sql = "select max(tmp_date) from results";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $max_tmp_date = $row[0];
   }

   printf "max date is $max_tmp_date<br>" if $debug;

   # this gets the most recent tourney winner, the person with the most recent winning streak
   $sql = "select winner from results where round='2' and tmp_date = '$max_tmp_date'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player)=$row[0];
   }

   # this gets the last loss for the most recent tourney winner
   $sql="select max(tmp_date) from results where loser='$player' and tmp_date < '$max_tmp_date';";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $current_streak_last_loss_date = $row[0];
   }

   # This gets the number of wins in the most recent streak.
   $sql="select count(*) from results where tmp_date > '$current_streak_last_loss_date' 
            and tmp_date <= '$max_tmp_date' and winner='$player'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $wins_streak = $row[0];
   }

   # this gets the first date of the current win streak, to make the report correct.
   $sql="select min(tmp_date) from results where tmp_date > '$current_streak_last_loss_date'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $current_streak_firstwindate = $row[0];
   }

   # lastly, put this in the @streak array
   $streak="$player~$current_streak_firstwindate~Current~$wins_streak";
   push (@streak,$streak);

   # this gets the first tourney winner (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT), the first person w/ a winning streak.
   # we start the processing with them
   $sql = "select winner,tmp_date from results where round='2' and tmp_date in
             (select min(tmp_date) from results)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$tmp_date)=($row[0],$row[1]);
   }
   
   printf "first player is $player, $tmp_date<br>" if $debug;

   printf "loop counters are $tmp_date and $current_streak_last_loss_date<br>" if $debug;
   $loopcounter=0;
   while ($tmp_date <= $current_streak_last_loss_date) {

      # Get the next loss date for the player
      $sql="select min(tmp_date) from results where loser='$player' and tmp_date > '$tmp_date'" ;
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $next_loss_date = $row[0];
      }

      # This then gets the number of wins for that player between their last tourney win and
      # the loss...
      $sql="select count(*) from results where tmp_date between '$tmp_date' and '$next_loss_date'
               and winner='$player'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $wins_streak = $row[0];
      }

      printf "wins streak is $wins_streak<br>" if $debug;

      if ($form{'tour'} eq 'IRT') {
      # push it to the streak array, but only if its big enough (14 games for IRT)
         if ($wins_streak >= 14) {
            $streak="$player~$tmp_date~$next_loss_date~$wins_streak";
            push (@streak,$streak);
         }
      }
      elsif ($form{'tour'} eq 'LPRT') {
      # push it to the streak array, but only if its big enough (10 games for LPRT)
         if ($wins_streak >= 10) {
            $streak="$player~$tmp_date~$next_loss_date~$wins_streak";
            push (@streak,$streak);
         }
      }
      elsif ($form{'tour'} eq 'WRT') {
      # push it to the streak array, but only if its big enough (4 games for WRT)
         if ($wins_streak >= 4) {
            $streak="$player~$tmp_date~$next_loss_date~$wins_streak";
            push (@streak,$streak);
         }
      }
      elsif ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls' || $form{'tour'} eq 'JUNIOR') {
      # push it to the streak array, but only if its big enough (4 games for IRF/Amateur)
         if ($wins_streak >= 3) {
            $streak="$player~$tmp_date~$next_loss_date~$wins_streak";
            push (@streak,$streak);
         }
      }
      else {
         printf "Invalid Tour selected; you should never get here";
      }

      # this gets the tourney winner where the streak ended, to start a new streak...
      $sql = "select winner from results where round='2' and tmp_date = '$next_loss_date'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $player=$row[0];
      }

      # reset the tmp_date to be the next_loss_date, to control the loop flow...
      $tmp_date = $next_loss_date;
 

      printf "flow control: at bottom of loop tmp_date is $tmp_date, next_loss_date is $next_loss_date, max_tmp_date is $max_tmp_date, new winner is $player<br>" if $debug;

      $loopcounter++;
      if ($loopcounter==400) {
         # set to very large value to get loop to end 
         $tmp_date = '2999-12-31';
      }
   }

   #&dump_array(@streak) if $debug;

   # for some reason there's duplicates in the array...
   @streak=&strip_duplicate_in_array(@streak);

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @streak=&schwartzian_sort($sort_field,\@streak);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @streak=&reverse_array(@streak);

   $rank=0;
   foreach $streakline (@streak)
   {
      ($streakplayer, $begindate, $enddate, $wincount) = split(/~/,$streakline);
      $rank++;
         
      print "<tr><td align=center><b>$rank</b></td>
             <td>$streakplayer</td>
             <td align=center>$begindate</td>
             <td align=center>$enddate</td>
             <td align=center>$wincount</td></tr>";
   } 
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       
}

#--------------------------------------------------------------------------------
# 10/28/11: Longest Match Winning Streaks, not including Ffts.
# Much is being made of Kane's 130+ "on the court" match win streak.  This query captures it.
# 1/3/18: coming back to this; putting in hard coded total fft codes: score not in ('inj-fft','fft','wbf-inj','inj fft')
# may need to standardize these codes

sub longest_match_streak_nofft () {

   printf "<p><b>Longest On-Court Match Winning Streaks on tour</b><p>";

   printf "This query ignores outright forfeits when calculating winning streaks.  It also ignores skipped tournaments.  
   It basically measures 'On the Court' winning streaks and highlights Kane Waselenchuk's amazing accomplishment of 134 straight wins on tour.<p>";
   
   printf "Note: if the player takes the court and then forfeits ... it is counted as a loss in this query.  The match must be a complete,
   did not take the court forfeit in the data to be skipped here.";

   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Date of First Win of streak</b></td>
          <td><b>Date of Last Win of streak</b></td>
          <td><b># Wins in a row</b></td>
          </tr>\n";


   # This gets the latest date in the database, to control the while loop
   $sql = "select max(tmp_date) from results";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $max_tmp_date = $row[0];
   }

   printf "max date is $max_tmp_date<br>" if $debug;

   # this gets the most recent tourney winner, the person with the most recent winning streak
   $sql = "select winner from results where round='2' and tmp_date = '$max_tmp_date'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player)=$row[0];
   }

   # this gets the last loss for the most recent tourney winner
   $sql="select max(tmp_date) from results where loser='$player' 
         and score not in ('inj-fft','fft','wbf-inj','inj fft') and tmp_date < '$max_tmp_date';";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $current_streak_last_loss_date = $row[0];
   }

   # This gets the number of wins in the most recent streak.
   $sql="select count(*) from results where tmp_date > '$current_streak_last_loss_date' 
            and tmp_date <= '$max_tmp_date' and winner='$player'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $wins_streak = $row[0];
   }

   # this gets the first date of the current win streak, to make the report correct.
   $sql="select min(tmp_date) from results where tmp_date > '$current_streak_last_loss_date'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $current_streak_firstwindate = $row[0];
   }

   # lastly, put this in the @streak array
   $streak="$player~$current_streak_firstwindate~Current~$wins_streak";
   push (@streak,$streak);

   # this gets the first tourney winner (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT), the first person w/ a winning streak.
   # we start the processing with them
   $sql = "select winner,tmp_date from results where round='2' and tmp_date in
             (select min(tmp_date) from results)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$tmp_date)=($row[0],$row[1]);
   }
   
   printf "first player is $player, $tmp_date<br>" if $debug;

   printf "loop counters are $tmp_date and $current_streak_last_loss_date<br>" if $debug;
   $loopcounter=0;
   printf "tmp date is $tmp_date , current streak lastlossdate is $current_streak_last_loss_date<br>" if $debug;
   printf "---- beginning of big while loop ---<p>" if $debug;
   
   while ($tmp_date <= $current_streak_last_loss_date) {

      # Get the next loss date for the player
      $sql="select min(tmp_date) from results where loser='$player' and score not in ('inj-fft','fft','wbf-inj','inj fft') and tmp_date > '$tmp_date'" ;
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $next_loss_date = $row[0];
      }
	  
	  # if this returns as null ... then it means the current win streak is active but that player did not enter most recent tourney.
	  # fix it here by setting next_loss_date = current date.
	  if ($next_loss_date eq '' ) {
	     $next_loss_date=$max_tmp_date;
      } 

      # This then gets the number of wins for that player between their last tourney win and
      # the loss...
      $sql="select count(*) from results where tmp_date between '$tmp_date' and '$next_loss_date'
               and winner='$player'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $wins_streak = $row[0];
      }

      printf "wins streak is $wins_streak<br>" if $debug;

      # push it to the streak array, but only if its big enough (10 games)
      if ($wins_streak >= 10) {
         # this should prevent double counting of the current winning streak
         if ($tmp_date eq $current_streak_firstwindate) {
            printf "this win streak date $tmp_date is same as $current_streak_firstwindate, skipping<br>" if $debug;
         }
		 elsif ( $next_loss_date eq $max_tmp_date) {
            # its a current streak for someone who missed the last event.
            $streak="$player~$current_streak_firstwindate~Current~$wins_streak";
            push (@streak,$streak);
         }
         else {
            $streak="$player~$tmp_date~$next_loss_date~$wins_streak";
            push (@streak,$streak);
         }
      }

      # this gets the tourney winner where the streak ended, to start a new streak...
      $sql = "select winner from results where round='2' and tmp_date = '$next_loss_date'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $player=$row[0];
      }

      # reset the tmp_date to be the next_loss_date, to control the loop flow...
      $tmp_date = $next_loss_date;
 

      printf "flow control: at bottom of loop new winner is $player, tmp_date is $tmp_date, next_loss_date is $next_loss_date, 
	  max_tmp_date is $max_tmp_date, <br>" if $debug;

      $loopcounter++;
      if ($loopcounter==400) {
         # set to very large value to get loop to end 
         $tmp_date = '2999-12-31';
      }
   }

   #&dump_array(@streak) if $debug;

   # for some reason there's duplicates in the array...
   @streak=&strip_duplicate_in_array(@streak);

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @streak=&schwartzian_sort($sort_field,\@streak);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @streak=&reverse_array(@streak);

   $rank=0;
   foreach $streakline (@streak)
   {
      ($streakplayer, $begindate, $enddate, $wincount) = split(/~/,$streakline);
      $rank++;
         
      print "<tr><td align=center><b>$rank</b></td>
             <td>$streakplayer</td>
             <td align=center>$begindate</td>
             <td align=center>$enddate</td>
             <td align=center>$wincount</td></tr>";
   } 
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       
}

#--------------------------------------------------------------------------------
# 11/11/09: Longest Tourney Winning Streaks.
# 

sub longest_tourney_streak () {

   printf "<p><b>Longest Tourney Winning Streaks </b><p>";

   printf "Note: in this report if a player misses/skips a tournament, or if they forfeit out of the tournament, the streak ends.  See the 'non forfeit' version
           of this report for non-interupted streaks.";

   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Date of First Tourney Win of streak</b></td>
          <td><b>Date of Last Tourney Win of streak</b></td>
          <td><b># Tourney Wins in a row</b></td>
          </tr>\n";

   # this gets a complete list of the winners
   $sql = "select winner,tmp_date from results \
           where round='2' order by tmp_date asc";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $tmp_date=$row[1];

      $final="$winner~$tmp_date";
      push (@allfinals,$final);
   }

   #&dump_array(@allfinals) if $debug;

   # this gets the first tourney winner (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT), the first person w/ a winning streak.
   # we start the processing with him
   $sql = "select winner,tmp_date from results where round='2' and tmp_date in
             (select min(tmp_date) from results)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($working_player,$working_tmp_date)=($row[0],$row[1]);
   }

   $win_streak=1;
   $loop_counter=1;
   foreach $final (@allfinals)
   {
      ($winner, $tmp_date) = split(/~/, $final);

      # skip the first result 
      if ($loop_counter == 1) {
         printf "loop_counter is $loop_counter, next<br>" if $debug;
         $loop_counter++;
         next;
      }

      printf "winner, tmp_date are $winner and $tmp_date<br>" if $debug;

      # winning streak increases
      if ($winner eq $working_player) {
         printf "$winner, $working_player.  entering if winner = workingplayer clause<br>" if $debug;
         $win_streak++;
      }
      # else there's a different winner from before; add the winning streak to the list, start anew
      else {
         printf "$winner, $working_player.  entering else clause <br>" if $debug;

         if ($form{'tour'} eq 'IRT') {
            if ($win_streak > 3) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         elsif ($form{'tour'} eq 'LPRT') {
            if ($win_streak > 3) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         elsif ($form{'tour'} eq 'WRT') {
            if ($win_streak > 1) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }

         $win_streak=1;
         $working_player = $winner;
         $working_tmp_date = $tmp_date;

      }
   }


   &dump_array(@streak) if $debug;
   
   # for some reason there's duplicates in the array...
   #@streak=&strip_duplicate_in_array(@streak);

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @streak=&schwartzian_sort($sort_field,\@streak);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @streak=&reverse_array(@streak);

   $rank=0;
   foreach $streakline (@streak)
   {
      ($streakplayer, $begindate, $enddate, $wincount) = split(/~/,$streakline);
      $rank++;
         
      print "<tr><td align=center><b>$rank</b></td>
             <td>$streakplayer</td>
             <td align=center>$begindate</td>
             <td align=center>$enddate</td>
             <td align=center>$wincount</td></tr>";
   } 
   
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       
}

#--------------------------------------------------------------------------------
# 12/13/16: put in placeholder for this 
# 1/4/18: working on it again... got it to work!

sub longest_tourney_streak_nofft () {

   printf "<p><b>Longest Tourney Winning Streaks, accounting for Missed or skipped tournaments </b><p>";

   printf "Note: in this report if a player misses/skips a tournament, the streak continues.  If a player enters a tournament 
   but then no shows or forfeits their first round without having taken the court, then the streak continues.  If the player plays
   a match but then entirely forfeits ... the streak ends.";

   printf "<p>";

   print "<table border><tr>\n";
   print "<td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Date of First Tourney Win of streak</b></td>
          <td><b>Date of Last Tourney Win of streak</b></td>
          <td><b># Tourney Wins in a row</b></td>
          </tr>\n";

   # first, get date of most recent tourney in case we have a current streak
   $sql = "select max(tmp_date) from results";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $max_tmp_date=$row[0];
   }
   
   # Next, get the date of 2nd most recent event, incase there's an active streak that gets skipped b/c the current streak holder
   # skipped the most recent event
   $sql = "select max(tmp_date) from results where tmp_date < (select max(tmp_date) - INTERVAL 1 day from results)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $second_max_tmp_date=$row[0];
   }
   
   # this gets a complete list of the winners
   $sql = "select winner,tmp_date from results where round='2' order by tmp_date asc";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $tmp_date=$row[1];

      $final="$winner~$tmp_date";
      push (@allfinals,$final);
   }

   #&dump_array(@allfinals) if $debug;

   # this gets the first tourney winner (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT), the first person w/ a winning streak.
   # we start the processing with him
   $sql = "select winner,tmp_date from results where round='2' and tmp_date in
             (select min(tmp_date) from results)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($working_player,$working_tmp_date)=($row[0],$row[1]);
   }

   $win_streak=1;
   $loop_counter=1;
   foreach $final (@allfinals)
   {
      ($winner, $tmp_date) = split(/~/, $final);
	  
	  # get most recent tmp_date to this tourney for streak processing later.
      $sql = "select max(tmp_date) from results where tmp_date < (select max('$tmp_date' - INTERVAL 1 day) from results); ";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $trailing_tmp_date=$row[0];
      }	  

      # skip the first result to kick off the logic and populate the variables.
      if ($loop_counter == 1) {
         printf "loop_counter is $loop_counter, this is the first tourney in the database, move on to the 2nd/next tourney ...<br>" if $debug;
         $loop_counter++;
         next;
      }

      printf "Entering foreach loop: new winner, tmp_date are $winner and $tmp_date<br>" if $debug;

      # winning streak increases
      if ($winner eq $working_player) {
         $win_streak++;
         printf "New winner is $winner, old winner is $working_player. Winner won again, incrementing win streak, which is now $win_streak<br>" if $debug;
	  }
      # else there's a different winner from before; add the winning streak to the list, start anew
      else {
         printf "New winner is $winner, old winner is $working_player. entering new winner clause, final streak is $win_streak<p>" if $debug;

         # first, test to make sure that the former winner actually entered the current tourney.
         $sql="select count(*) from results where loser='$working_player' and tmp_date='$tmp_date'";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            $exists=$row[0];
         }

         if ($exists eq '0') {
            # previous winner did not enter this new tournament; skip this new winner
            printf "*** previous winner did not enter this new tournament; skip this new winner<p>" if $debug;
            printf "*** working_tmp_date is $working_tmp_date, trailing_tmp_date is $trailing_tmp_date, second_max_tmp_date is $second_max_tmp_date<br>" if $debug;			

			# if this occurred in the 2nd most recent event ... then we'll push this to the streak.
			if ($trailing_tmp_date eq $second_max_tmp_date) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);				
			}
			
            next;
         }

         # next, test to make sure that the former winner didn't forfeit out of the tournament outright
		 # we assume its a round of 32 or 16 fft ... this prevents later tournament ffts from getting caught...
         $sql="select count(*) from results where loser='$working_player' and tmp_date='$tmp_date' \
		       and round in ('32','16') and score in ('inj-fft','fft','wbf-inj','inj fft')";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            $count=$row[0];
         }

         if ($count eq '1') {
            # previous winner lost in this tourney by virtue of complete forfeit; don't count this as a loss
            printf "*** previous winner lost in this tourney by virtue of complete forfeit; don't count this as a loss<p>" if $debug;
            printf "*** working_tmp_date is $working_tmp_date, trailing_tmp_date is $trailing_tmp_date, second_max_tmp_date is $second_max_tmp_date<br>" if $debug;	
			
			# if this occurred in the 2nd most recent event ... then we'll push this to the streak.
			if ($trailing_tmp_date eq $second_max_tmp_date) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);				
			}

            next;
         }

         if ($form{'tour'} eq 'IRT') {
            if ($win_streak > 3) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         elsif ($form{'tour'} eq 'LPRT') {
            if ($win_streak > 3) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         elsif ($form{'tour'} eq 'WRT') {
            if ($win_streak > 1) {
               $streak="$working_player~$working_tmp_date~$tmp_date~$win_streak";
               push (@streak,$streak);
            }
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }

		 # these keep the current win streak data: working_player is the current win streak player 
		 # and working_tmp_date is the date of the start of the current win streak, used to push to streak array
		 # once a streak ends to capture begin/end dates.
		 
         $win_streak=1;
         $working_player = $winner;
         $working_tmp_date = $tmp_date;

      }
   }


   &dump_array(@streak) if $debug;
   
   # for some reason there's duplicates in the array...
   #@streak=&strip_duplicate_in_array(@streak);

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @streak=&schwartzian_sort($sort_field,\@streak);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @streak=&reverse_array(@streak);

   $rank=0;
   foreach $streakline (@streak)
   {
      ($streakplayer, $begindate, $enddate, $wincount) = split(/~/,$streakline);
      $rank++;

      if ($enddate eq $max_tmp_date) {
         $enddate="Current";
      }
         
      print "<tr><td align=center><b>$rank</b></td>
             <td>$streakplayer</td>
             <td align=center>$begindate</td>
             <td align=center>$enddate</td>
             <td align=center>$wincount</td></tr>";
   } 
   print "</table>";   
   &print_back_link;   
   printf "</body></html>";	       
}



#--------------------------------------------------------------------------------
# 5/9/14: modifying this to get 256s as well
# 1/2/18: putting in doubles version 

sub season_summary_all {

   if ($form{'tour'} eq 'IRT') {
      $match_limit=20;
   }
   elsif ($form{'tour'} eq 'LPRT') {
      $match_limit=20;
   }
   elsif ($form{'tour'} eq 'WRT') {
      $match_limit=5;
   }
   elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
      # ignoring the match limit for doubles altogether in the code since there's so few entrants; this is for the printing on screen.
      $match_limit=1;
   }
   elsif ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      $match_limit=1;
   }   
   else {
      printf "Invalid Tour selected; you should never get here";
   }

   printf "<p><b>Career Season Summaries for all players (with more than $match_limit wins) in the Database</b><p>";

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
      printf "<p>Note: be patient: this is a slightly longer running query...15 seconds or so<p>";
   }

   if ($form{'tour'} eq 'IRFmatch') {
      printf "<p>Note: this query does not count Round-Robin-only results<p>";
   }   
   if ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'AMATEUR') {
      printf "<p>Note: this query does not count 3rd place matches if they occurred.<p>";
   }  
   
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Career<br> Wins</b></td>
          <td><b>Career<br> Finals</b></td>
          <td><b>Career<br> Semis</b></td>
          <td><b>Career<br> Qtrs</b></td>
          <td><b>Career<br> 16s</b></td>
          <td><b>Career<br> 32s</b></td>
          <td><b>Career<br> 64s</b></td>
          <td><b>Career<br> 128s</b></td>
          <td><b>Career<br> 256s</b></td>
          </tr>\n";

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   # converting this to use wins > 9 rather than all players for time; if use all
   # players in the db, the query doesnt' come back within 5 minutes

   #$sql = "select distinct winner as name from results \
   #        union \
   #        select distinct loser as name from results order by name";

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
      $sql = "select distinct winner_p1 as name from results_doubles 
		      union 
		      select distinct winner_p2 as name from results_doubles 
			  union
			  select distinct loser_p1 as name from results_doubles 
			  union 
			  select distinct loser_p2 as name from results_doubles
			  order by name;"; 
   }
   else {	  
      $sql = "select winner from wins where wins >= $match_limit order by winner";
   }
	  

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) { 
      push (@players,$row);
   }

   # temporarily override all players while testing
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
   #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
   #@players=('Beltran, Alvaro','Swain, Cliff');
   #@players=('Harris, Jamal');

   for $plyr (@players) {

      printf "<p><b>Working on player $plyr</b><br>" if $debug;

      my $career_twofiftysixes=0;
      my $career_onetwentyeights=0;
      my $career_sixtyfours=0;
      my $career_thirtytwos=0;
      my $career_sixteens=0;
      my $career_quarters=0;
      my $career_semis=0;
      my $career_finals=0;
      my $career_wins=0;
      my $player=0;

      next if ($plyr =~ /\?/);

      ($player,$career_wins,$career_finals,$career_semis,$career_quarters,$career_sixteens,$career_thirtytwos,$career_sixtyfours,$career_onetwentyeights,$career_twofiftysixes)=&gen_season_summary($plyr);

      # 5/27/08: trying temp table to sort results instead of perl
      $sql = "insert into season_summary_rpt values ('$player',$career_wins,$career_finals,$career_semis,$career_quarters,$career_sixteens,$career_thirtytwos,$career_sixtyfours,$career_onetwentyeights,$career_twofiftysixes)";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      #$summary="$player~$career_wins~$career_finals~$career_semis~$career_quarters~$career_sixteens~$career_thirtytwos~$career_sixtyfours~$career_onetwentyeights";
      #push (@allsummaries,$summary);
   }

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "select player,wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes from season_summary_rpt order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) { 
      #printf "row is $row<br>" if $debug;
      $myplayer=$row[0];
      $mywinscity=$row[1];
      $myfinals=$row[2];
      $mysemis=$row[3];
      $myquarters=$row[4];
      $mysixteens=$row[5];
      $mythirtytwos=$row[6];
      $mysixtyfours=$row[7];
      $myonetwentyeights=$row[8];
      $mytwofiftysixes=$row[9];

      #push (@allsummariesdb,@row);
      push (@allsummariesdb,"$myplayer~$mywinscity~$myfinals~$mysemis~$myquarters~$mysixteens~$mythirtytwos~$mysixtyfours~$myonetwentyeights~$mytwofiftysixes");

   }

   printf "<p>" if $debug;
   &dump_array(@allsummariesdb) if $debug;

# now, sort the allsummaries array by total wins...

   # Sort the possibles by the score of the longest game.
   #$sort_field=1;
   #@allsummaries=&schwartzian_sort($sort_field,\@allsummaries);

   # Results come from DB in reverse order; this fixes that.
   @allsummariesdb=&reverse_array(@allsummariesdb);

# now print out the allsummaries
   foreach $playersummary (@allsummariesdb) {
      #printf "$match<br>";   
      ($player,$career_wins,$career_finals,$career_semis,$career_quarters,$career_sixteens,$career_thirtytwos,$career_sixtyfours,$career_onetwentyeights,$career_twofiftysixes) = split(/~/,$playersummary);
       
   print "<td>$player</td>
          <td align=center>$career_wins</td>
          <td align=center>$career_finals</td>
          <td align=center>$career_semis</td>
          <td align=center>$career_quarters</td>
          <td align=center>$career_sixteens</td>
          <td align=center>$career_thirtytwos</td>
          <td align=center>$career_sixtyfours</td>
          <td align=center>$career_onetwentyeights</td>
          <td align=center>$career_twofiftysixes</td>
          </tr>";
   }

   # 5/27/08: cleanup holding table at end
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   
   printf "</table>";
   &print_back_link;   
   printf "</body></html>";	       

}

#--------------------------------------------------------------------------------
# 5/9/14: listing season summary for all players who appear in a season
# 12/5/16: adding in age at end of season.

sub season_summary_allplayers() {

   printf "Entering season_summary_allplayers \n" if $debug;

   printf "<p><b>Season Summaries for all players for $form{'season'}</b><p>";
   printf "<p>This table sorts by Wins, then Finals made, then Semis, etc.  It will not necessarily correspond to the season ending ranking because (for example) a semi in a major is worth more than a semi at a normal tournament.  Age is the player's age as of the date of the last event of the season.<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Rank</b></td>
          <td><b>Age</b></td>
          <td><b>Season<br> Wins</b></td>
          <td><b>Season<br> Finals</b></td>
          <td><b>Season<br> Semis</b></td>
          <td><b>Season<br> Qtrs</b></td>
          <td><b>Season<br> 16s</b></td>
          <td><b>Season<br> 32s</b></td>
          <td><b>Season<br> 64s</b></td>
          <td><b>Season<br> 128s</b></td>
          <td><b>Season<br> 256s</b></td> 
          <td><b>Season<br> Missed</b></td> 
         </tr>\n";

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   # How many events in the season?  We'll use this later on to determine the number of missed events per player
   $sql="select count(distinct(event)) from results where season='$form{'season'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      $num_events=$row;
   }

   # Get the date of the last event for later age processing:

   # We use this maxdate at the very end of the next loop
   $sql="select max(tmp_date) from results where season='$form{'season'}'";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $maxdate = $row[0];
   } 

   # distinct list of all players per season

   $sql = "select distinct winner as name from results where season='$form{'season'}'
           union 
           select distinct loser as name from results where season='$form{'season'}' order by name";
     
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) { 
      push (@players,$row);
   }

   # temporarily override all players
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
   #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
   #@players=('Beltran, Alvaro','Swain, Cliff');

   for $plyr (@players) {

      printf "<p><b>Working on player $plyr</b>" if $debug;

# we've never had a round of 512 ...
      my $twofiftysixes=0;
      my $onetwentyeights=0;
      my $sixtyfours=0;
      my $thirtytwos=0;
      my $sixteens=0;
      my $quarters=0;
      my $semis=0;
      my $finals=0;
      my $wins=0;
      my $player=0;
      my $season=0;

      next if ($plyr =~ /\?/);

     ($player,$season,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)=&gen_perseason_summary($plyr,$form{'season'});

      # 5/27/08: trying temp table to sort results instead of perl
      $sql = "insert into season_summary_rpt values ('$player',$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
  }

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "select player,wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes from season_summary_rpt order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) { 
      #printf "row is $row<br>" if $debug;
      $myplayer=$row[0];
      $mywinscity=$row[1];
      $myfinals=$row[2];
      $mysemis=$row[3];
      $myquarters=$row[4];
      $mysixteens=$row[5];
      $mythirtytwos=$row[6];
      $mysixtyfours=$row[7];
      $myonetwentyeights=$row[8];
      $mytwofiftysixes=$row[9];

      #push (@allsummariesdb,@row);
      push (@allsummariesdb,"$myplayer~$mywinscity~$myfinals~$mysemis~$myquarters~$mysixteens~$mythirtytwos~$mysixtyfours~$myonetwentyeights~$mytwofiftysixes");
   }

   printf "<p>" if $debug;
   &dump_array(@allsummariesdb) if $debug;

# now, sort the allsummaries array by total wins...

   # Sort the possibles by the score of the longest game.
   #$sort_field=1;
   #@allsummaries=&schwartzian_sort($sort_field,\@allsummaries);

   # Results come from DB in reverse order; this fixes that.
   @allsummariesdb=&reverse_array(@allsummariesdb);


# now print out the allsummaries
   foreach $playersummary (@allsummariesdb) {
      #printf "$match<br>";   
      ($player,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes) = split(/~/,$playersummary);

# get the rank of the player if it exists
      $sql = "select rank from rankings where player='$player' \
              and season='$form{'season'}'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $rank=$rows[0];
         #printf "$rank[0]\n" if $debug;
      }

# gets DoB for player to do age processing
      $sql = "select dob,tmp_dob from player_profile where player = '$player'";
      printf "<br>$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         printf "@row\n" if $debug;

         $dob=$row[0];
         $tmp_dob=$row[1];
      }

      if ($dob eq '') { 
         $agey="unk ";
         $aged="unk ";
      }

      else {
          $maxdate_varchar = &date_to_varchar($maxdate);
         ($agey,$aged)=&get_age($dob,$maxdate_varchar);
      }


      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
      $missed=$num_events-$total_results;
     
      print "<td>$form{'season'}</td>
          <td>$player</td>
          <td align=center>#${rank}</td> 
          <td align=center>${agey}yrs<br>${aged}days</td>
          <td align=center>$wins</td>
          <td align=center>$finals</td>
          <td align=center>$semis</td>
          <td align=center>$quarters</td>
          <td align=center>$sixteens</td>
          <td align=center>$thirtytwos</td>
          <td align=center>$sixtyfours</td>
          <td align=center>$onetwentyeights</td>
          <td align=center>$twofiftysixes</td>
          <td align=center>$missed</td>
          </tr>";

      # resetting variables so we don't duplicate data
      $dob='';
      $rank='';
   }

   # 5/27/08: cleanup holding table at end
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}




#--------------------------------------------------------------------------------
# 10/21/08: put in Marty Hogan suggested query to print out tourney winners by season
# 11/9/08: joined to tourneys table to get "majors"

sub season_tourney_wins {

   # need 2nd connection.
   $dbh2 = DBI->connect ($db_connect,$db_user,$db_password) or die "Couldn't connect to database: " . DBI->errstr;

   printf "<p><b>Season-by-Season List of Wins</b><p>";

   if ($form{'tour'} eq 'WRT') {
      printf "The WRT only had one event in 2012; we've declared the winner of that event the 'tour champion' for that season.  We are waiting for official rankings from the WRT for the years 2013-2015, though we likely have the winner accurate herein.<p>";

      printf "The WRT has no known 'Majors' as of the end of 2017; if/when this changes we'll fix the majors table.<p>";
   }

   printf "Entering season-by-season<br>" if $debug;

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {
      printf "getting distinct list of winners per $season<br>" if $debug;
   
      printf "Season: <b>$season</b>.  ";

      $sql = "select player from tour_champions where season='$season'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $tour_winner = ($row[0]);
      }

      # this will need to be modified after each season: 
      if ($season eq $current_season) {  
         $tour_winner = "Current Season: none declared yet.";
      }

      if ($season eq '1973-4') {  
         $tour_winner = "none: 1973-4 had no official tour and thus no winner declared.";
      }
    
      # hard-code cancelled New Orleans event
      if ($season eq '2005-6') {  
         printf "<p>Note: Hurricane Katrina cancelled the 2005 New Orleans event, hence the '?' result.<p>";
      }

      if ($season lt '1981-2') {  
         printf "Recognized tour champion (by winning Nationals): <b>$tour_winner</b><p>";
      }
      else {
         printf "Recognized tour champion (by year-end point standings): <b>$tour_winner</b><p>";
      }

      print "<table border><tr>\n";
      print "<td><b>Player</b></td>
             <td><b>Number of Tourney Wins</b></td>
             <td><b>Number Majors</b></td></tr>";


      $sql = "select winner, count(winner) as count from results
              where round='2'
              and season='$season'
              group by winner
              order by count desc";

      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         ($player,$wins) = ($row[0],$row[1]);
         print "<tr><td>$player</td>
                <td align=center>$wins</td>";

         $sql2="select count(r.winner) as count
                from results r, tourneys t
                where r.round='2'
                and r.winner='$player'
                and r.season='$season'
                and r.event = t.event
                and r.season = t.season
                and t.major_flag='Y'";
         printf "$sql2<br>" if $debug;
         $sth2 = $dbh2->prepare($sql2);
         $sth2->execute;

         while (@row2 = $sth2->fetchrow_array) {
            printf "@row2\n" if $debug; 
            $major_win_count = $row2[0];
         }
         print "<td align=center>$major_win_count</td>";
      }

      print "</tr>";

      printf "</table><p><br><br>";
      #printf "<hr>";
	   
   }
   &print_back_link;   
   printf "</body></html>";	    
}





#--------------------------------------------------------------------------------
# 1/18/18: num events per season
# 

sub num_events {

   printf "<p><b>Number of Events Per Season</b><p>";
   
   if ($form{'tour'} eq 'IRT') {
      printf "Some explanations for the low event numbers for some seasons (some of this is detailed in the 
	          <a href=\"http://www.proracquetballstats.com/irt/tour_history.html\">IRT tour History</a> page.  Comments below as of Jan 2018.<br>";
	  printf "<ul><li>1973-4: there wasn't really a 'tour' yet, but 4 pro/money events occurred.  No tour champion was named, nor was there a nationals.";
	  printf "<li>Late 1970s: the number of 'sanctioned' events looks low, but the players were playing non-sanctioned, full money, full sized draws
	          week in and week out during the sport's hey-day.";	  
	  printf "<li>1988-89: the tour collapsed in November and had no events for months.";
	  printf "<li>1989-90: little to no magazine coverage left us with little to no data for this season; its the largest 'hole' in the database.";	   
	  printf "</ul>";
   }   
   if ($form{'tour'} eq 'WRT') {
      printf "Some explanations for the low event numbers for some seasons.  Comments below as of Jan 2018.";
	  printf "<ul><li>2012: the WRT formed in late 2012 and thus only had one event the first 'season.'  No tour champion named for that year."; 
	  printf "</ul>";
   } 
   if ($form{'tour'} eq 'LPRT') {
      printf "Some explanations for the low event numbers for some seasons (some of this is detailed in the 
	          <a href=\"http://www.proracquetballstats.com/lprt/lprt_tour_history.html\">LPRT tour History</a> page. Comments below as of Jan 2018.<br>";
	  printf "<ul><li>1974-75: there wasn't really a 'tour' yet, but some pro/money events occurred.  Women's pro events were just added to existing men's events,
	           which had been happening since late 1973.";
	  printf "<li>Late 1970s: there were probably more events that occurred than are in the database as of this time; as we build the history 
	            from the beginning, we find more.";	  
	  printf "<li>Late 1970s-Early 1980s: there were probably more events that occurred than are in the database as of this time; as we build the history 
	            from the beginning, we find more.";	   
	  printf "<li>1989-90: little to no magazine coverage left us with little to no data for this season; its the largest 'hole' in the database.  We are
	             aware of at least 5 tourneys from this season but have zero results.";	   
	  printf "<li>Mid 1990s (1994-95 especially): these are not mistakes; there were just a handful of events per season during this era of Ladies pro racquetball.";	   				
	  printf "<li>Mid 2000s (2006, 2007): we are missing a few tourneys here and there.";	   				
	  
	  printf "</ul>";
   }    
   
   printf "Entering num_events<br>" if $debug;

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Number of Tourneys</b></td></tr>";
			 
   # opting to do this out of results versus tourneys b/c of inconsistency in season variable in tourneys
   
   $sql = "select season,count(*) from (
              select distinct season,event,tmp_date from results
              ) a group by season order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      #push (@seasons,$row);
	  
      print "<td>$row[0]</td>
             <td><center>$row[1]</center></td></tr>";
		  
   }

   printf "</table><p><br><br>";
   &print_back_link;   
   printf "</body></html>";	    
}





#--------------------------------------------------------------------------------
# 11/4/08: put in simple player_profile query to print out key stats
# 10/16/17: modified this to only read profile data if the names appear in the database when going to master player profile xls.
# 11/1/17: put in player_profile_regular to just show frequent players.


sub player_profiles {

   # need a second link to do a second loop through
   $dbh2 = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

   printf "<p><b>Player Profiles</b><p>";

   printf "<p><b>Note</b>: this is player profile data that I've compiled from various websites, tour profiles and what not.  Any updates to this information is 
   definitely welcome.  Note: if the birthday falls on the first of the month, most likely its an estimated birthday and thus current age is an estimate.<p>";

   if ($form{'tour'} eq 'IRT') {
      printf "<p><b>11/5/08 Much thanks to Marty Hogan</b> for populating most of the player info for older tour players.<p>";
      printf "<p><b>11/5/12</b>: updated with some of the rising players on tour.. <p>";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "Ladies player profile data definitely lacking in detail; any information is welcome.<p>";
   }
   elsif ($form{'tour'} eq 'WRT') {
      printf "WRT player profile data definitely lacking in detail, especially for the younger players; any information is welcome.<p>";
   }
   elsif ($form{'tour'} eq 'IRFmatch') {
      printf "IRF player profile data definitely lacking in detail; any information is welcome.  I generally only have country of origin.<p>";
   }
   elsif ($form{'tour'} eq 'AMATEUR') {
      printf "Amateur player profile data definitely lacking in detail b/c of the number of non-pros who play.  <p>";
   }    
   elsif ($form{'tour'} eq 'JUNIOR') {
      printf "Junior player profile data definitely lacking in detail b/c of the number of non-pros who play, and because of the youth of the participants.  I have put in 'fake'
      birthdays/profiles for all tourney winners so that the code works, but do not expect significant details here for these kids unless they have grown up to play frequently
      on one of the pro tours and/or have volunteered their information.<p>";
   }  
   else {
      printf "Invalid Tour selected; you should never get here";
   }
   
   printf "<b>Oct 2017</b> converted to a consolidated player profile table across all DBs, loaded up a ton of data for US Open participants (thanks
   to John Oliver in this regard).  Any additional data welcome.<p>";

   printf "Bolded players means they played in the most recent tournament on tour.<p>";

   printf "Entering Player Profiles<br>" if $debug;

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>L/R</b></td>
          <td align=center><b>Country</b></td>
          <td align=center><b>Twitter</b></td>		  
          <td align=center><b>Hometown</b></td>
          <td align=center><b>Current Residence</b></td>
          <td><b>Height</b></td>
          <td><b>Weight</b></td>
          <td align=center><b>College</b></td>
          <td align=center><b>Sponsor</b></td>
          <td align=center><b>DOB</b></td>
          <td align=center><b>Current Age</b></td>
          </tr>\n";
		  
   # clean out temporary table
   $sql = "truncate table players_all;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;  	

   # populate temporary table with all players in the database.
   $sql = "insert into players_all \
           select distinct winner as name from results \
           union \
           select distinct loser as name from results order by name;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;     
   
   # 9/2/09: Find latest date in the database to determine if the player is active
   # We use this maxdate at the very end when displaying data
   $sql="select max(tmp_date) from results;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $maxdate = $row[0];
   }    

   if ($form{'query'} eq 'player_profiles') {
   #   $sql = "select player,l_r_flag,hometown,current_residence,height,weight,college,sponsor,dob,tmp_dob 
   #           from player_profile order by player asc";
      $sql = "select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter
              from player_profile p, players_all a
              where p.player = a.player
              order by p.player asc;";
   }
   elsif ($form{'query'} eq 'player_profiles_regular') {
      # Set the # of wins to filter by; same counts as in "regular player" drop down list in results_front.pl
      if ($form{'tour'} eq 'IRT') { $count=50; }
      elsif ($form{'tour'} eq 'LPRT') { $count=30; }
      elsif ($form{'tour'} eq 'WRT') { $count=10; }
      elsif ($form{'tour'} eq 'IRFmatch') { $count=5; }
      elsif ($form{'tour'} eq 'AMATEUR') { $count=3; }
      elsif ($form{'tour'} eq 'JUNIOR') { $count=3; }	  
      elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') { $count=7; }
      else {
         printf "Invalid Tour selected; you should never get here";
      }   
	  
	  $sql="select p.player,p.l_r_flag,p.hometown,p.current_residence,p.height,p.weight,p.college,p.sponsor,p.dob,p.tmp_dob,p.country,p.twitter
              from player_profile p, wins w
              where p.player = w.winner
              and w.wins > $count
              order by p.player asc;";
   }
   else {
      printf "Invalid query selected; you should never get here<p>"
   }
		   
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      printf "@row\n" if $debug;

      $myplayer=$row[0];
      $myl_r_flag=$row[1];
      $myhometown=$row[2];
      $mycurrent_residence=$row[3];
      $myheight=$row[4];
      $myweight=$row[5];
      $mycollege=$row[6];
      $mysponsor=$row[7];
      $mydob=$row[8];
      $mytmp_dob=$row[9];
	  $mycountry=$row[10];
	  $mytwitter=$row[11];	  

      if ($myl_r_flag eq '') { $myl_r_flag="&nbsp&nbsp"; }
      if ($myhometown eq '') { $myhometown="&nbsp&nbsp"; }
      if ($mycurrent_residence eq '') { $mycurrent_residence="&nbsp&nbsp"; }
      if ($myheight eq '') { $myheight="&nbsp&nbsp"; }
      if ($myweight eq '') { $myweight="&nbsp&nbsp"; }
      if ($mycollege eq '') { $mycollege="&nbsp&nbsp"; }
      if ($mysponsor eq '') { $mysponsor="&nbsp&nbsp"; }

      if ($mydob eq '') { 
         $mydob="&nbsp&nbsp"; 
         $myage="&nbsp&nbsp"; 
      }
      else {
         printf "<br>entered dob calculations<br>" if $debug;
         $sql = "select to_days(sysdate()) - to_days('$mytmp_dob') from dual;";
         printf "<br>$sql<br>" if $debug;
         $sth2 = $dbh2->prepare($sql);
         $sth2->execute;
         while (@row = $sth2->fetchrow_array) {
            #printf "@row\n" if $debug;
            $myageindays = $row[0];
         } 
         printf "my age returned is $myageindays<br>" if $debug;

         # Note: most of this day logic not used here, but definitely used elsewhere.
         $myage_full = $myageindays/365.25;
         ($years,$yearfraction)=split(/\./,$myage_full);

         $yearfraction='.' . $yearfraction;
         $daysfraction=$yearfraction*365;
         ($days,$daysfractiontmp)=split(/\./,$daysfraction);

         printf "$myage_full $years, $yearfraction $days<br>" if $debug;

         $myage = "${years}yrs ${days}days";
         #$myage = "${years}yrs";

      }
	  
      # Last Tour Appearance
      # Have to do this complicated sql to get the guy who won the last tournament...
      #$sql = "select max(tmp_date) from results where loser='$player'";
      $sql2="select max(ldate) from (
              select max(tmp_date) as ldate from results where loser='$myplayer'
              union
              select max(tmp_date) as ldate from results where winner='$myplayer' and round=2) ldate_list";
			  
      printf "<br>$sql2<br>" if $debug;
      $sth2 = $dbh2->prepare($sql2);
      $sth2->execute;
      while (@row2 = $sth2->fetchrow_array) {
         printf "@row2\n" if $debug;
         $lastapp_date = $row2[0];
      } 	  

	  # if their last appearance matches the max date, they're "active"
      if ($maxdate eq $lastapp_date) {
         print "<tr><td><b>$myplayer</b></td>";
	  }
      else {
         print "<tr><td>$myplayer</td>";
	  }
	  
      print "<td align=center>$myl_r_flag</td>
          <td align=center>$mycountry</td>
          <td align=center>$mytwitter</td>		  
          <td align=center>$myhometown</td>
          <td align=center>$mycurrent_residence</td>
          <td align=center>$myheight</td>
          <td align=center>$myweight</td>
          <td align=center>$mycollege</td>
          <td align=center>$mysponsor</td>
          <td align=center>$mydob</td>
          <td align=center>$myage</td>
          </tr>\n";

   }
   printf "</table>";
   &print_back_link;   
   printf "</body></html>";	    
}

#--------------------------------------------------------------------------------
# 11/7/08: Lists all tourney winners in history of tour, age of debut, age of win, etc.

sub tour_winners_age {

   printf "<p><b>Tourney Winners Ages</b><p>";

   printf "<p><b>Note</b>: Some of my DOBs for players are estimates (generally every DOB that is on the first of a month or on Jan 1st of a year), and some of the exact tourney dates for older tournaments are estimates, so the exact days and years may be slightly off.  As I get better dobs, this report improves.<p>"; 

   printf "<p><b>Bolded Player Names</b> are active players based on the latest tournament date.<p>";

   printf "Entering Tourney Winners Ages <br>" if $debug;

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td align=center><b>Tour Debut</b></td>
          <td align=center><b>Tour Debut Age</b></td>
          <td><b>1st Win Date</b></td>
          <td><b>1st Win Age</b></td>
          <td align=center><b>Last Win Date</b></td>
          <td align=center><b>Last Win Age</b></td>
          <td align=center><b>Last Appearance</b></td>
          <td align=center><b>Last Appearance Age</b></td>
          </tr>\n";

   $sql = "select distinct(winner) from results where round=2 order by winner;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@players,$row);
   }

   &dump_array(@players) if $debug;

   # 9/2/09: Find latest date in the database to determine if the player is active
   # We use this maxdate at the very end of the next loop
   $sql="select max(tmp_date) from results;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "@row\n" if $debug;
      $maxdate = $row[0];
   } 

   for $player (@players) {
      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      next if ($player =~ /\?/);

      # gets DoB for player
      $sql = "select dob,tmp_dob from player_profile where player = '$player'";
      printf "<br>$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         printf "@row\n" if $debug;

         $dob=$row[0];
         $tmp_dob=$row[1];
      }

      if ($dob eq '') { 
         $dob="&nbsp&nbsp"; 
         $age="&nbsp&nbsp"; 
         next;
      }

      else {

         # Tour Debut
         # Have to do this complicated sql basicaly to get the first winner's dates right (Steve Serot on IRT, Peggy Steding on LPRT, Carlos Keller on WRT)
         #$sql = "select min(tmp_date) from results where loser='$player'";
         $sql="select min(ldate) from (
                   select min(tmp_date) as ldate from results where loser='$player'     
                   union
                   select min(tmp_date) as ldate from results where winner='$player' and round=2) ldate_list";

         printf "<br>$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            printf "@row\n" if $debug;
            $debut_date = $row[0];
         } 

         $debut_date_varchar = &date_to_varchar($debut_date); 
         ($debuty,$debutd)=&get_age($dob,$debut_date_varchar);

         # First Tour Win
         $sql = "select min(tmp_date) from results where winner='$player' and round=2";
         printf "<br>$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            printf "@row\n" if $debug;
            $firstwin_date = $row[0];
         } 

         $firstwin_date_varchar = &date_to_varchar($firstwin_date); 
         ($firstwiny,$firstwind)=&get_age($dob,$firstwin_date_varchar);

         # Last Tour Win
         $sql = "select max(tmp_date) from results where winner='$player' and round=2";
         printf "<br>$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            printf "@row\n" if $debug;
            $lastwin_date = $row[0];
         } 

         $lastwin_date_varchar = &date_to_varchar($lastwin_date); 
         ($lastwiny,$lastwind)=&get_age($dob,$lastwin_date_varchar);

         # Last Tour Appearance
         # Have to do this complicated sql to get the guy who won the last tournament...
         #$sql = "select max(tmp_date) from results where loser='$player'";
         $sql="select max(ldate) from (
                 select max(tmp_date) as ldate from results where loser='$player'
                 union
                 select max(tmp_date) as ldate from results where winner='$player' and round=2) ldate_list";


         printf "<br>$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            printf "@row\n" if $debug;
            $lastapp_date = $row[0];
         } 

         $lastapp_date_varchar = &date_to_varchar($lastapp_date); 
         ($lastappy,$lastappd)=&get_age($dob,$lastapp_date_varchar);

      }

      printf "<p>Entering if-else clause for maxdate versus lastappdate logic" if $debug;
      printf "<p>maxdate is $maxdate, lastappdate is $lastapp_date" if $debug;

      if ($maxdate eq $lastapp_date) {
         printf "equal" if $debug;
         print "<tr><td><b>$player</b></td>
             <td align=center>$dob</td>
             <td align=center>$debut_date_varchar</td>
             <td align=center>${debuty}yrs<br>${debutd}days</td>
             <td align=center>$firstwin_date_varchar</td>
             <td align=center>${firstwiny}yrs<br>${firstwind}days</td>
             <td align=center>$lastwin_date_varchar</td>
             <td align=center>${lastwiny}yrs<br>${lastwind}days</td>
             <td align=center>$lastapp_date_varchar</td>";
         print "<td align=center>${lastappy}yrs<br>${lastappd}days</td>";
         print "</tr>\n";
      }
      else {
         printf "not equal" if $debug;
         print "<tr><td>$player</td>
             <td align=center>$dob</td>
             <td align=center>$debut_date_varchar</td>
             <td align=center>${debuty}yrs<br>${debutd}days</td>
             <td align=center>$firstwin_date_varchar</td>
             <td align=center>${firstwiny}yrs<br>${firstwind}days</td>
             <td align=center>$lastwin_date_varchar</td>
             <td align=center>${lastwiny}yrs<br>${lastwind}days</td>
             <td align=center>$lastapp_date_varchar</td>";
         print "<td align=center>${lastappy}yrs<br>${lastappd}days</td>";
         print "</tr>\n";
      }

      # 
      # If the last date for a player is the last result date, will print (active) in report
      #   $sql = "select max(tmp_date) from results";
      #   $sth = $dbh->prepare($sql);
      #   $sth->execute;
      #   while (@row = $sth->fetchrow_array) {
      #      $lastknown_date = $row[0];
      #   } 

      #if ($lastapp_date eq $lastknown_date) {
      #    print "<td align=center>${lastappy}yrs<br>${lastappd}days<br>(active)</td>";
      #}
      #else {
      #    print "<td align=center>${lastappy}yrs<br>${lastappd}days</td>";
      #}
      #    print "</tr>\n";

   }
   printf "</table>";
   &print_back_link;   
   printf "</body></html>";	    
}



#--------------------------------------------------------------------------------
# 5/12/14: lists out the oldest player to win an event, oldest finalist etc.
# 11/15/17: fixed the code to not break if a birthday is outright missing in the DB; it will just print 0 years, 0 days.

sub oldest_player_to {

   printf "<p><b>Oldest Player To...</b><p>";

   printf "<p>This query prints out the oldest player to Win an event, oldest finalist, etc<p>"; 

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {   
      printf "<p><b>Important note</b> I have estimates of birthdays for many of the older players from the tour.  Generally speaking if someone's birthday is listed as 1/1 or 
	  on the first of a month, it is an estimate based on my reading the literature of the time.  Any birthday updates to make these age-based reports more accuarate is welcome<p>";
   }
   
   printf "<p><b>Important note</b> This report breaks if I do not have a birthday entered for a tournament winner, which is common for Juniors/Amateurs.  If you see someone 
   of age 0years, 0days, it means I'm missing their birthday.  Any updates to the player profile data are welcome!<p>";

   if ($form{'tour'} eq 'IRT') {
      printf "<p>Limiting each query to 20 rows; as we will see the age-less Ruben Gonzalez dominates these tables, especially the round of 16 report<p>";
   }

   if ($form{'tour'} eq 'JUNIOR') {
      printf "<p>This data may not be that useful for Junior tournaments, since by and large we know how old the players are in each draw.";
   }
   
   printf "Entering Oldest Player To... <br>" if $debug;

   printf "<hr>\n";


# Oldest player to win a tournament
   printf "<b>Oldest Player to Win a Tournament</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</td>
          <td><b>DoB</td>
          <td><b>Season</td>
          <td><b>Event Name</td>
          <td><b>Date of Event</td>
          <td><b>Age at Event Date</b></td>
          </tr>\n";

   $sql = "select r.winner, p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $dob=$row[1];
      $season=$row[2];
      $event=$row[3];
      $event_date=$row[4];

      printf "<br>processing $player victory in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@winnerarray,$tmprow);
   }

   &dump_array(@winnerarray) if $debug;
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=7;
   @winnerarray=&schwartzian_sort($sort_field,\@winnerarray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @winnerarray=&reverse_array(@winnerarray);
      
   $counter=1;
   foreach $winnerarrayline (@winnerarray) {
      ($player,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$winnerarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";


# Oldest players to make a Final

   printf "<p><b>Oldest Player to Make a Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@finalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @finalistarray_sorted=&schwartzian_sort($sort_field,\@finalistarray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @finalistarray_sorted=&reverse_array(@finalistarray_sorted);

   &dump_array(@finalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $finalistarrayline (@finalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$finalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";



# Oldest players to make a Semi-Final

   printf "<p><b>Oldest Player to Make a Semi-Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@semifinalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @semifinalistarray_sorted=&schwartzian_sort($sort_field,\@semifinalistarray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @semifinalistarray_sorted=&reverse_array(@semifinalistarray_sorted);

   &dump_array(@semifinalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $semifinalistarrayline (@semifinalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$semifinalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";



# Oldest players to make a Quarter-Final

   printf "<p><b>Oldest Player to Make a Quarter-Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> ''
          union            
           select r.loser, 'Qtr-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=8
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@qtrfinalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @qtrfinalistarray_sorted=&schwartzian_sort($sort_field,\@qtrfinalistarray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @qtrfinalistarray_sorted=&reverse_array(@qtrfinalistarray_sorted);

   &dump_array(@qtrfinalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $qtrfinalistarrayline (@qtrfinalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$qtrfinalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";


# Oldest players to make a Main Draw/Round of 16

   printf "<p><b>Oldest Player to Make a Main Draw/Round of 16</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> ''
          union            
           select r.loser, 'Qtr-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=8
           and p.dob <> '' 
          union            
           select r.loser, 'Rnd-of-16', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=16
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@sixteensarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @sixteensarray_sorted=&schwartzian_sort($sort_field,\@sixteensarray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @sixteensarray_sorted=&reverse_array(@sixteensarray_sorted);

   &dump_array(@sixteensarray_sorted) if $debug;
      
   $counter=1;
   foreach $sixteensarrayline (@sixteensarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$sixteensarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	 


}



#--------------------------------------------------------------------------------
# 5/12/14: lists out the youngest player to win an event, youngest finalist etc.
# Just basically copied oldest_player_to and took out the "reverse" array to print this...

sub youngest_player_to {

   printf "<p><b>Youngest Player To...</b><p>";

   printf "<p>This query prints out the youngest player to Win an event, youngest finalist, etc.  Please be patient; this is a longer running query...<p>"; 

   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {      
      printf "<p><b>Important note</b> I have estimates of birthdays for many of the older players from the tour.  Generally speaking if someone's birthday 
      is listed as 1/1 or on the first of a month, it is an estimate based on my reading the literature of the time.  ";
   }
   
   printf "<p><b>Important note</b> This report breaks if I do not have a birthday entered for a tournament winner, which is common for Juniors/Amateurs.  If you see someone 
   of age 0years, 0days, it means I'm missing their birthday.  Any updates to the player profile data are welcome!<p>";

   # now have good b-days for both; removing this clause
   #if ($form{'tour'} eq 'IRT') {
   #   printf "That fact is especially relevant to this query as I have estimates for birthdays for a couple of the youngest players to have success, namely 
   #Steve Serot and Brett Harnett.  Any birthday updates to make these age-based reports more accuarate is welcome, especially for these two players.  We
   #recently got an updated bday for Mr. Harnett to correctly depict his birthday but still do not have a good Birthday for Serot.<p>";
   #}
   
   if ($form{'tour'} eq 'JUNIOR') {
      printf "<p>This data may not be that useful for Junior tournaments, since by and large we know how old the players are in each draw.";
   }   

   printf "Entering Youngest Player To... <br>" if $debug;

   printf "<hr>\n";


# youngest player to win a tournament
   printf "<b>Youngest Player to Win a Tournament</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</td>
          <td><b>DoB</td>
          <td><b>Season</td>
          <td><b>Event Name</td>
          <td><b>Date of Event</td>
          <td><b>Age at Event Date</b></td>
          </tr>\n";

   $sql = "select r.winner, p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $dob=$row[1];
      $season=$row[2];
      $event=$row[3];
      $event_date=$row[4];

      printf "processing $player victory in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@winnerarray,$tmprow);
   }

   &dump_array(@winnerarray) if $debug;
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=7;
   @winnerarray=&schwartzian_sort($sort_field,\@winnerarray);

   # the Array sorts ascending automatically, so we have youngest to oldest already
      
   $counter=1;
   foreach $winnerarrayline (@winnerarray) {
      ($player,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$winnerarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";


# youngest players to make a Final

   printf "<p><b>Youngest Player to Make a Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@finalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @finalistarray_sorted=&schwartzian_sort($sort_field,\@finalistarray);

   # the Array sorts ascending automatically, so we have youngest to oldest already

   &dump_array(@finalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $finalistarrayline (@finalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$finalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";



# youngest players to make a Semi-Final

   printf "<p><b>Youngest Player to Make a Semi-Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@semifinalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @semifinalistarray_sorted=&schwartzian_sort($sort_field,\@semifinalistarray);

   # the Array sorts ascending automatically, so we have youngest to oldest already

   &dump_array(@semifinalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $semifinalistarrayline (@semifinalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$semifinalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";



# youngest players to make a Quarter-Final

   printf "<p><b>Youngest Player to Make a Quarter-Final</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> ''
          union            
           select r.loser, 'Qtr-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=8
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@qtrfinalistarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @qtrfinalistarray_sorted=&schwartzian_sort($sort_field,\@qtrfinalistarray);

   # the Array sorts ascending automatically, so we have youngest to oldest already


   &dump_array(@qtrfinalistarray_sorted) if $debug;
      
   $counter=1;
   foreach $qtrfinalistarrayline (@qtrfinalistarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$qtrfinalistarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";


# youngest players to make a Main Draw/Round of 16

   printf "<p><b>Youngest Player to Make a Main Draw/Round of 16</b>\n";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>DoB</b></td>
          <td><b>Season</b></td>
          <td><b>Event Name</b></td>
          <td><b>Date of Event</b></td>
          <td><b>Player Result</b></td>
          <td><b>Age at Event Date</b></b></td>
          </tr>\n";

# skipping players with null DOBs; just too hard to make logic work.
   $sql = "select r.winner, 'Winner', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.winner
           and r.round=2
          union
           select r.loser, 'Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=2
           and p.dob <> ''
          union            
           select r.loser, 'Semi-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=4
           and p.dob <> ''
          union            
           select r.loser, 'Qtr-Finalist', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=8
           and p.dob <> '' 
          union            
           select r.loser, 'Rnd-of-16', p.dob, r.season, r.event, r.date
           from results r, player_profile p
           where p.player = r.loser
           and r.round=16
           and p.dob <> '' ";
   printf "<br>$sql<br>\n" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $player=$row[0];
      $result=$row[1];
      $dob=$row[2];
      $season=$row[3];
      $event=$row[4];
      $event_date=$row[5];

      printf "processing $player $result in $season $event\n" if $debug;

      # this skips the ? result for the Hurricane Katrina-ended event in 2004
      # don't need it because of inner join on query; won't get ? winner
      # next if ($player =~ /\?/);

      # quite a few players have null birthdays ... just have to skip them else they crash
      # the program here.  Actually, added clause to query to eliminate
      # printf "skipping result with null dob [${dob}] $player $result $season $event\n" if $debug;
      # next if ($dob = '');

      ($ageyears,$agedays)=&get_age($dob,$event_date);

      $totalnumberofdays=($ageyears*365)+$agedays;

      printf "ageyears is $ageyears, agedays is $agedays, total # of days is $totalnumberofdays\n" if $debug;

      $tmprow="$player~$result~$dob~$season~$event~$event_date~$ageyears~$agedays~$totalnumberofdays";
      push (@sixteensarray,$tmprow);
   }
   
   # Sort the possibles by the totalnumber of days.
   $sort_field=8;
   @sixteensarray_sorted=&schwartzian_sort($sort_field,\@sixteensarray);

   # the Array sorts ascending automatically, so we have youngest to oldest already

   &dump_array(@sixteensarray_sorted) if $debug;
      
   $counter=1;
   foreach $sixteensarrayline (@sixteensarray_sorted) {
      ($player,$result,$dob,$season,$event,$event_date,$ageyears,$agedays,$totalnumberofdays) = split(/~/,$sixteensarrayline);

      # this limits to the top 20
      next if $counter > 20;

      print "<td><b>$player</b></td>
          <td>$dob</td>
          <td>$season</td>
          <td>$event</td>
          <td>$event_date</td>
          <td>$result</td>
          <td>$ageyears Years, $agedays days</td>
         </tr>\n";

      $counter++;
      
   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	    

}





#--------------------------------------------------------------------------------
# 5/18/11: pulls all rankings data per season from rankings table

sub season_ending_rankings() {
   printf "Entering season ending rankings<br>" if $debug;

   printf "<b>Season Ending Rankings</b> for Season $form{'season'} <p>"; 

   if ($form{'tour'} eq 'WRT') {
      printf "The WRT season ending rankings are only populated from 2015-present; we are working on previous seasons.<p>";       
   }


   $sql = "select source from rankings_source where season='$form{'season'}' ";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      printf "<b>Source</b>: $row[0]<p>";
   }

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Rank</b></td>
          <td><b>Player</b></td>
          <td><b>Points</b></td></tr>";

   $sql = "select player,rank,points from rankings where season='$form{'season'}' ";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$rank,$points) = ($row[0],$row[1],$row[2]);
      $row="$player~$rank~$points";
      #printf "$row<br>" if $debug;
      push (@rankings,$row);
   }

   #&dump_array(@rankings) if $debug;

# 6/10/15: changed this sort field from 2 (points) to 1 (ranking) b/c we don't always have the rankings points ...
#   but we always have the rank.  So we'll sort on that instead, comment out the reverse array and we're good.
   
   $sort_field=1;
   @rankings=&schwartzian_sort($sort_field,\@rankings);

   #&dump_array(@rankings) if $debug;
   #@rankings=&reverse_array(@rankings);
   #&dump_array(@rankings) if $debug;

   foreach $rankline (@rankings) {
      ($player,$rank,$points) = split(/~/,$rankline);

      print "<td>$form{'season'}</td>
             <td><center>$rank</center></td>
             <td><b>$player</b></td>
             <td><center>$points</center></td></tr>";

   }

   print "</table>\n";
   &print_back_link;   
   printf "</body></html>";	 
}


#--------------------------------------------------------------------------------
# 5/18/11: pulls all rankings data per season from rankings table
# 5/19/11: changing this to use helper function instead of a straight pull

sub player_rankings() {
   printf "Entering player rankings<br>" if $debug;

   printf "<b>Season Ending Rankings</b> for player $form{'player'} <p>"; 

   if ($form{'tour'} eq 'WRT') {
      printf "The WRT season ending rankings are only populated from 2015-present; we are working on previous seasons.<p>";       
   }

   printf "Note: this query skips the current season<p>";
   #printf "<b>under development! 5/18/11</b><p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b><center>Rank</center></b></td>
          <td><b><center>Points</center></b></td>
          <td><b>Prize Money</b></td>
          <td><b>Comments</b></td></tr>";

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;     
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   #&dump_array(@seasons) if $debug;

   for $season (@seasons) {

      # skipping current season: will have to change this hard coded value each season presumably...
      # 1/17/17: why skip it?  just print it out as current season...
      # next if $season eq $current_season;

      $comments="";

      $tmp_rank = &gen_player_ranking($season,$form{'player'});
      printf "$tmp_rank\n" if $debug;

      ($rank,$points,$prizemoney) = split(/,/, $tmp_rank);
      printf "rank is $rank,points are $points,money is $prizemoney\n" if $debug;

      if ($rank eq "no results") {

         undef $rank;
         $comments = "No Results on tour";

      }
     

      print "<td>$season</td>
             <td>$form{'player'}</td>
             <td><center>$rank</center></td>
             <td><center>$points</center></td>
             <td><center>$prizemoney</center></td>
             <td>$comments</td> </tr>";
      
      $comments="";

      undef $rank;
      undef $tmp_rank;
      undef $points;
      undef $prizemoney;
   }


   print "</table>";
   &print_back_link;
   printf "</body></html>";	    
}


#--------------------------------------------------------------------------------
# 5/19/11: changing this to use helper function instead of a straight pull

sub player_rankings_old() {
   printf "Entering player rankings<br>" if $debug;       

   printf "<b>Season Ending Rankings</b> for player $form{'player'} <p>";
             
   printf "<b>under development! 5/18/11</b><p>";
             
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Rank</b></td>
          <td><b>Points</b></td></tr>";
 
   $sql = "select season,player,rank,points from rankings where player='$form{'player'}' order by season asc ";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($season,$player,$rank,$points) = ($row[0],$row[1],$row[2],$row[3]);

      print "<td>$season</td>
             <td>$player</td>
             <td><center>$rank</center></td>
             <td><center>$points</center></td></tr>";
     
   }

   print "</table>";
   &print_back_link;
   printf "</body></html>";	    
}


#--------------------------------------------------------------------------------
# 1/8/13: adding most matchups
# 5/13/14: coming back to this, will make this work

sub most_matchups() {

   printf "<b>Most Frequent Head to Head Matchups in tour History</b><p>"; 

   print "<table border><tr>\n";
   print "<td><b>Player 1</b></td>
         <td><b>Player 2</b></td> 
         <td align=center><b>Total number <br>of Matchups</b></td> 
         <td align=center><b>Head to Head <br> Record</b></td> 
          </tr>\n";

   # Starting with at least 10 matchups for IRT, less for other tours.

   if ($form{'tour'} eq 'IRT') {
      $sql="select winner,loser,count(*) from results 
            where loser <> '?'
            group by winner,loser 
            having count(*) >= 10
            order by count(*) desc;";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      $sql="select winner,loser,count(*) from results 
            where loser <> '?'
            group by winner,loser 
            having count(*) >= 5
            order by count(*) desc;";
   }
   elsif ($form{'tour'} eq 'WRT') {
      $sql="select winner,loser,count(*) from results 
            where loser <> '?'
            group by winner,loser 
            having count(*) >= 3
            order by count(*) desc;";
   }
   elsif ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
      $sql="select winner,loser,count(*) from results 
            where loser <> '?'
            group by winner,loser 
            having count(*) >= 2
            order by count(*) desc;";
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }



   printf "$sql<br>" if $debug;

   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($winner,$loser,$winnerwon)=($row[0],$row[1],$row[2]);

      printf "working on $winner,$loser,$winnerwon\n" if $debug;
   
      # This gets the number of matches where the reverse result occurred
      $sql2="select count(*) from results where winner='$loser' and loser='$winner'"; 
      printf "$sql2<br>" if $debug;
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;
      while (@row2 = $sth2->fetchrow_array) {
         $loserwon=$row2[0];
      }

      $totalmatches=$winnerwon+$loserwon;

      $candidaterow="$winner~$loser~$winnerwon~$loserwon~$totalmatches";
      push (@matchuparray,$candidaterow);
   }

   &dump_array(@matchuparray) if $debug;


   # Sort the possibles by the score of the longest game.
   # 11/16/17: sorting first on wins, then on matchup to get this to sort better
   @matchuparray=&schwartzian_sort(2,\@matchuparray);
   $sort_field=4;
   @matchuparray=&schwartzian_sort(4,\@matchuparray);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @matchuparray=&reverse_array(@matchuparray);


   # Clean out "duplicates" in the array where the player 1/player2 combo is reversed.

   @matchuparray2=@matchuparray;
   $foundwinner='';
   $foundloser='';

   $counter=0;

   foreach $matchuparrayrow (@matchuparray) {
      ($winner,$loser,$winnerwon,$loserwon,$totalmatches) = split(/~/,$matchuparrayrow);
      $counter++;

      printf "Counter is $counter.  $winner vs $loser <br>" if $debug;

      # 0 is false, 1 is true
      $found=0;

      printf "my foundwinner is $foundwinner, foundloser is $foundloser<br>" if $debug;

      if ($winner eq $foundwinner and $loser eq $foundloser) {
         printf "found a dup at top $winner vs $loser, skipping<br>" if $debug;
         $foundwinner='';
         $foundloser='';
         next;
      }

      foreach $matchuparrayrow2 (@matchuparray2) {    
        ($winner2,$loser2,$winnerwon2,$loserwon2,$totalmatches2) = split(/~/,$matchuparrayrow2);
         if ($winner eq $loser2 and $loser eq $winner2) {
            printf "found equals 1: $winner eq $loser2, $loser eq $winner2<br>" if $debug;
            $foundwinner=$loser;
            $foundloser=$winner;
            $found=1;
         }
      }

      $candidaterow="$winner~$loser~$winnerwon~$loserwon~$totalmatches";
      push (@matchuparrayclean,$candidaterow);

   }

   foreach $matchuparrayrow (@matchuparrayclean) {
      ($winner,$loser,$winnerwon,$loserwon,$totalmatches) = split(/~/,$matchuparrayrow);

      if ($winnerwon > $loserwon) {
         print "<tr><td>$winner</td>
                <td>$loser</td>
                <td align=center>$totalmatches</td>
                <td align=center>${winnerwon}-${loserwon}</td>
                </tr>";
      }
      else {
         print "<tr><td>$loser</td>
                <td>$winner</td>
                <td align=center>$totalmatches</td>
                <td align=center>${loserwon}-${winnerwon}</td>
                </tr>";
      }

   }

   print "</table>";
   &print_back_link;
   printf "</body></html>";	    
}





#--------------------------------------------------------------------------------
# 5/8/14: adding tour Depth query

sub tour_depth() {

   printf "<p><b>Depth Analysis on Tour Season-by-season</b>";

   printf "<p>This query takes a bit of time to run (10-15 seconds): be patient";

   printf "<p>Depending on the season, players can normally miss up-to two events per season and still qualify for full points, so adding up the players who missed 0, 1 or 2 events gives a good idea of the number of 'full time' tour players there were per year";

   if ($form{'tour'} eq 'IRT') {
      printf "<p>Caveats on this data to keep in mind while reading this:";
      printf "<br>- Better record keeping means that we've captured full qualifying rounds in recent years, which has resulted in a large increase in the total number of players who have appeared at least once on tour.";
      printf "<br>- This query shows how bad the data is for seasons 1988-89, 89-90 and 99-00.";
      printf "<br>- A couple of years look odd: 74-75 data is weird; every player missed at least 4 of the 14 events.  94-95 was an odd year as well; several guys in the top 10 missed multiple events.";
      printf "<br>- Its interesting how many players per year are one-and-dones; pretty consistently around 60pct of the players in the database.  These are of course local players who sign up to try to qualify at each stop.";
      printf "<p>";
   }

      if ($form{'tour'} eq 'WRT') {
      printf "<p>Note: the WRT only had one event in 2012, so the depth calculations are not really valid.<p>";
   }

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
         <td align=center><b>Total # of <br>Tournaments</b></td> 
         <td align=center><b>Total # of <br> Majors</b></td> 
         <td align=center><b>Total # of <br> Players</b></td>
         <td align=center><b># Players who <br> Played every event</b></td>
         <td align=center><b># Players who <br> Missed 1 event</b></td>
         <td align=center><b># Players who <br> Missed 2 events</b></td>
         <td align=center><b># Players who <br> Missed 0,1,2 events<br>(Full Time Tour depth est)</b></td>
         <td align=center><b># Players who <br> Played at least <br>75% of events</b></td>
         <td align=center><b># Players who <br> Played at least <br>50% of events</b></td>
         <td align=center><b># Players who <br> Played Just 1 event</b></td>
         <td align=center><b>Distinct # of <br> Tourney Winners</b></td>
         <td align=center><b>Distinct # of <br> Tourney Finalists</b></td>
         <td align=center><b>Distinct # of <br> Tourney <br>Semi-Finalists</b></td>
         <td align=center><b>Distinct # of <br> Tourney <br>Qtr-Finalists</b></td>
         <td align=center><b>Distinct # of <br> Rnd of 16s</b></td>
          </tr>\n";

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   # temporarily override seasons
   #@seasons=('2013-14','2012-13','2011-12');
   #@seasons=('2013-14');
   #@seasons=('2013-14','2012-13');

   &dump_array(@seasons) if $debug;

   $counter=1;
   # start per-season analysis
   for $season (@seasons) {
      printf "beginning processing $season<br>" if $debug;

      print "<tr><td><b>$season</b></td>";


      # Number of Tournaments that year
      $sql = "select count(distinct(event)) from results where season='$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $num_tourneys=$row[0];
      }

      print "<td><center>$num_tourneys</center></td>";


      # Number of Major Tournaments that year
      $sql = "select count(*) from tourneys where season='$season' and major_flag='Y'";
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $num_majors=$row[0];
      }

      print "<td><center>$num_majors</center></td>";


      # Number of players on tour
      $sql = "select count(*) from (
              select distinct(winner) as player from results where season='$season'
              union
              select distinct(loser) as player from results where season='$season') a";
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $player_total_count=$row[0];
      }

      print "<td><center>$player_total_count</center></td>";

      # Processing to get Players and Number of events they missed per season

      # First, clean out missed_tourney_rpt table to ensure we're clean.
      $sql = "delete from missed_tourney_rpt";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;


      # distinct list of all players per season
      
      # clean out @players; was getting duplicate results;
      @players=0;

      $sql = "select distinct winner as name from results where season='$season'
              union 
              select distinct loser as name from results where season='$season' order by name";
     
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while ($row = $sth->fetchrow_array) { 
         push (@players,$row);
      }

      # temporarily override all players
      #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
      #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
      #@players=('Beltran, Alvaro','Swain, Cliff');

      for $plyr (@players) {

         printf "<p><b>Working on player $plyr</b>" if $debug;

         # We'll just throw away most of these values; we keep them here so we can leverage the gen_per_season_summary
         my $twofiftysixes=0;
         my $onetwentyeights=0;
         my $sixtyfours=0;
         my $thirtytwos=0;
         my $sixteens=0;
         my $quarters=0;
         my $semis=0;
         my $finals=0;
         my $wins=0;
         my $player=0;
         my $ssn=0;

         next if ($plyr =~ /\?/);

         printf "getting ready to call genperseason summary, passing $plyr, $season<br>" if $debug;
      
($player,$ssn,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)=&gen_perseason_summary($plyr,$season);

         $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
         $missed=$num_tourneys-$total_results;

         $sql = "insert into missed_tourney_rpt values ('$season','$plyr',$missed)";  
         $sth = $dbh->prepare($sql);
         $sth->execute;

         $total_results=0;
         $missed=0;
      }

      # This counts all players who made every event
      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed=0";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $missed_zero=$row[0];
      }

      print "<td><center>$missed_zero</center></td>";

      # this counts all players who missed just one event in a season
      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed=1";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $missed_one=$row[0];
      }

      print "<td><center>$missed_one</center></td>";

      # This counts all players who missed 2 events in a season: usually 0,1,2 events missed == full time player
      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed=2";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $missed_two=$row[0];
      }

      print "<td><center>$missed_two</center></td>";


      # 0,1, or 2 events missed; real tour depth estimate

      $zeroonetwo = $missed_zero+$missed_one+$missed_two;

      print "<td><center>$zeroonetwo</center></td>";

      # This calculates 75% of the events per year to count the # of players who made at least 75%
      $seventyfive_pct=$num_tourneys*.25;
      printf "seventyfive pct value is $seventyfive_pct<br>" if $debug;

      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed<=$seventyfive_pct";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $seventyfive_pct_made=$row[0];
      }

      print "<td><center>$seventyfive_pct_made</center></td>";


      # This calculates 50% of the events per year to count the # of players who made at least 50%
      $fifty_pct=$num_tourneys*.5;
      printf "fifty pct value is $fifty_pct<br>" if $debug;

      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed<=$fifty_pct";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $fifty_pct_made=$row[0];
      }

      print "<td><center>$fifty_pct_made</center></td>";

      # This shows the number of players listed per season who played in just ONE event.
      $allbutone=$num_tourneys-1;

      $sql = "select count(*) from missed_tourney_rpt where season='$season' and missed=$allbutone";  
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $justone=$row[0];
      }

      $justone_pct=($justone/$player_total_count)*100;
      $justone_pct_rnded = sprintf("%.2f", $justone_pct);

      print "<td><center>$justone - ${justone_pct_rnded}%</center></td>";


      # clean out missed_tourney_rpt table when done with it.
      $sql = "delete from missed_tourney_rpt";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;



      # Distinct Number of winners on tour: code borrowed from distinct_winners subroutine.
      $sql = "select count(distinct(winner)) from results
              where round='2'
              and season='$season'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $count_distinct=$row[0];
      }

      print "<td><center>$count_distinct</center></td>";


      # Number of different players to make a final per season
      $sql = "select count(*) from (
              select distinct(winner) as player from results where season='$season' and round='2'
              union
              select distinct(loser) as player from results where season='$season' and round='2') a";   

      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $ttl_finalists=$row[0];
      }

      print "<td><center>$ttl_finalists</center></td>";


      # Number of different players to make Semi-final per season
      $sql = "select count(*) from (
              select distinct(winner) as player from results where season='$season' and round='4'
              union
              select distinct(loser) as player from results where season='$season' and round='4') a";   

      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $ttl_semifinalists=$row[0];
      }

      print "<td><center>$ttl_semifinalists</center></td>";


      # Number of different players to make a quarterfinal per season
      $sql = "select count(*) from (
              select distinct(winner) as player from results where season='$season' and round='8'
              union
              select distinct(loser) as player from results where season='$season' and round='8') a";   

      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $ttl_qtrfinalists=$row[0];
      }

      print "<td><center>$ttl_qtrfinalists</center></td>";

      # Number of different players to make a round of 16/to qualify for a main draw per season
      $sql = "select count(*) from (
              select distinct(winner) as player from results where season='$season' and round='16'
              union
              select distinct(loser) as player from results where season='$season' and round='16') a";   

      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $ttl_qualifiers=$row[0];
      }

      print "<td><center>$ttl_qualifiers</center></td>";




      # close off the row
      print "</tr>\n";

      # Every 20 rows re-print the header
      $counter++;

      if ($counter == 20) {
         print "<tr>\n";
         print "<td><b>Season</b></td>
         <td align=center><b>Total # of <br>Tournaments</b></td> 
         <td align=center><b>Total # of <br> Majors</b></td> 
         <td align=center><b>Total # of <br> Players</b></td>
         <td align=center><b># Players who <br> Played every event</b></td>
         <td align=center><b># Players who <br> Missed 1 event</b></td>
         <td align=center><b># Players who <br> Missed 2 events</b></td>
         <td align=center><b># Players who <br> Missed 0,1,2 events<br>(Full Time Tour depth est)</b></td>
         <td align=center><b># Players who <br> Played at least <br>75% of events</b></td>
         <td align=center><b># Players who <br> Played at least <br>50% of events</b></td>
         <td align=center><b># Players who <br> Played Just 1 event</b></td>
         <td align=center><b>Distinct # of <br> Tourney Winners</b></td>
         <td align=center><b>Distinct # of <br> Tourney Finalists</b></td>
         <td align=center><b>Distinct # of <br> Tourney <br>Semi-Finalists</b></td>
         <td align=center><b>Distinct # of <br> Tourney <br>Qtr-Finalists</b></td>
         <td align=center><b>Distinct # of <br> Rnd of 16s</b></td>
          </tr>\n";

         $counter=1;
      }
   }
   printf "</table>";
   &print_back_link;
   printf "</body></html>";	    
}

#--------------------------------------------------------------------------------
# 7/18/14: adding Age of tour Winners

sub tour_champ_age() {

   printf "<p><b>Champions and their age at the end of their winning season</b><br>";

   printf "<p>Some data caveats here: I still have estimates for the birthdays for a few of the older players.  Also I have just estimates for dates of some of the older tournaments.  So the ages for the older guys are probably a bit off.  Basically anywhere you see someone listed with a birthday or an event date that's the 1st day of the month is likely to be an estimate.  If anyone has any updated birthdays i'm all ears.<p>";
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Champion</b></td>
          <td><b>Birthday</b></td>
          <td><b>Date of Final Event of Season</b></td>
          <td><b>Age at Season End</b></td>
          </tr>\n";

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {
      next if ($season  eq $current_season);
      
      # Gets champ for each season
      printf "Getting champion for $season<br>" if $debug;

      $sql = "select player_dbname from tour_champions where season='$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
 
      while (@row = $sth->fetchrow_array) {
         $champion=$row[0];
      }

      printf "season is $season, champ is $champion<p>" if $debug;

      # gets DoB for player
      $sql = "select dob,tmp_dob from player_profile where player = '$champion'";
      printf "<br>$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         printf "@row\n" if $debug;

         $dob=$row[0];
         $tmp_dob=$row[1];
      }

      printf "player is $champion, dob is $dob<p>" if $debug;

      # gets max date for a season; should be the date of the last tournament
      $sql = "select max(tmp_date) from results where season ='$season'";
      printf "<br>$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         printf "@row\n" if $debug;
         $season_end_date=$row[0];
      }


      # This gets the age of the player as of the end of the season in question
      $season_end_date_varchar = &date_to_varchar($season_end_date);
      ($agey,$aged)=&get_age($dob,$season_end_date_varchar);

      # calculate age in total days.
      $ageindays=$agey*365.25+$aged;

      printf "Age of player $champion at $season end: $debuty Years, $debutd days.  $ageindays totaldays" if $debug;

      $line="$season~$champion~$dob~$season_end_date~$agey~$aged~$ageindays";
      
      push (@rows,$line);
   }

   &dump_array(@rows) if $debug;

   # Sort the possibles by the number of matchups
   $sort_field=6;
   @rows=&schwartzian_sort($sort_field,\@rows);

   # Sort sorts ascending.  we want descending, from longest game to shortest.
   @rows=&reverse_array(@rows);

   for $rowline (@rows) {
      ($season,$champion,$dob,$season_end_date,$agey,$aged,$ageindays) = split(/~/,$rowline);

   print "<td><b>$season</b></td>
          <td>$champion</td>
          <td><center>$dob</center></td>
          <td><center>$season_end_date</center></td>
          <td><center>$agey years $aged days</center></td>
          </tr>\n";
   }
   printf "</table>";
   &print_back_link;
   printf "</body></html>";	    
}

#--------------------------------------------------------------------------------
# Emulating Evan's Statistical Abstract report. Began thought 1/14/11, attempting 9/30/14
# 

sub statistical_abstract_byseason() {

#
# First: QSF per season, borrowed from qsf_by_season()
#
   printf "Entering Statistical Abstract \n" if $debug;

   printf "<b>Statistical Abstract for $form{'season'}<p></b>";

   printf "This query combines a number of reports that are present elsewhere in the database to emulate the Statistical Abstract per season created by Evan Pritchard, author of http://www.theracquetballblog.blogspot.com/ and (to my knowledge) the only person actively blogging about the sport today.<p>";

   printf "Quick Season stats:<p>";

   $sql = "select count(*) from 
           (select distinct winner from results where season = '$form{'season'}'
           union 
           select distinct loser from results where season = '$form{'season'}') a;";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $countallplayers = $row[0];
   }

   printf "<ul><li>There were <B>$countallplayers</B> distinct players who appeared on the $form{'tour'} during the $form{'season'} season.</ul>";

#
# Next: count of matches.
#

   printf "<b>Match Summary for the Season</b><p>";

   $sql = "select count(*) from results where season='$form{'season'}'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $ttl_match_count=$rows[0];
         #printf "$rank[0]\n" if $debug;
      }

   printf "<ul><li>Total matches in the database for $form{'season'}: <b>$ttl_match_count</b><p>";


# now do some quick manipulations on all the scores

# set all the scores to zero in case there are none so the printing looks correct
   $wbf=0;
   $no_score=0;
   $three_game_wins=0;
   $four_game_wins=0;
   $five_game_wins=0;
   
   $sql="select score from results where season='$form{'season'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $score=$row[0];

      if ($score =~ /inj|fft|ret|wbf/) {
         $wbf++;
         next;
      }
      if ($score eq "") {
         $no_score++;
         next;
      }
         
      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);

      $game_count=@points;
      #&dump_array(@points);

      if ($game_count eq "3") {
         $three_game_wins++;
         next;
      }
      elsif ($game_count eq "4") {
         $four_game_wins++;
         next;
      }
      elsif ($game_count eq "5") {
         $five_game_wins++;
         next;
      }
   }

   $threegamepct = ($three_game_wins/$ttl_match_count);
   $threegamepct = sprintf("%.02f", $threegamepct*100);
   printf "<li>Percentage of 3 game matches for $form{'season'}: <b>${threegamepct}%</b> ($three_game_wins out of $ttl_match_count total matches)";   

   $fourgamepct = ($four_game_wins/$ttl_match_count);
   $fourgamepct = sprintf("%.02f", $fourgamepct*100);
   printf "<li>Percentage of 4 game matches for $form{'season'}: <b>${fourgamepct}%</b> ($four_game_wins out of $ttl_match_count total matches)";   

   $fivegamepct = ($five_game_wins/$ttl_match_count);
   $fivegamepct = sprintf("%.02f", $fivegamepct*100);
   printf "<li>Percentage of 5 game matches for $form{'season'}: <b>${fivegamepct}%</b> ($five_game_wins out of $ttl_match_count total matches)";   

   $wbfgamepct = ($wbf/$ttl_match_count);
   $wbfgamepct = sprintf("%.02f", $wbfgamepct*100);
   printf "<li>Percentage of Win By Fft games for $form{'season'}: <b>${wbfgamepct}%</b> ($wbf out of $ttl_match_count total matches)";   

   $noscoregamepct = ($no_score/$ttl_match_count);
   $noscoregamepct = sprintf("%.02f", $noscoregamepct*100);
   printf "<li>Percentage of game with scores missing for $form{'season'}: <b>${noscoregamepct}%</b> ($no_score out of $ttl_match_count total matches)";   

   printf "</ul>";
   printf "<hr>";



   printf "<hr>";
   printf "<b>Event Summary for season $form{'season'}</b><br>";

   print "<table border><tr>\n";
   print "<td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Final</b></td>
          <td><b>Semis</b></td>
          <td><b>Quarters</b></td>
          </tr>\n";

   $sql = "select winner,loser,score,city,event,date from results \
           where round='2' and season='$form{'season'}' order by tmp_date";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $score=$row[2];
      $city=$row[3];
      $event=$row[4];
      $date=$row[5];

      ($wlname,$wfname)=split(/,/,$winner);
      ($llname,$lfname)=split(/,/,$loser);

      # must trim leading spaces from the first names in order to get the first initial
      $wfname =~ s/^\s+//;
      $wfname =~ s/\s+$//;
      $lfname =~ s/^\s+//;
      $lfname =~ s/\s+$//;

      $firstinitwinner=substr($wfname,0,1);
      $firstinitloser=substr($lfname,0,1);
      
      if ($wlname =~ /$dup_last_names/) {
         $wlname="${firstinitwinner}.${wlname}";
      }
      if ($llname =~ /$dup_last_names/) {
         $llname="${firstinitloser}.${llname}";
      }

      printf "winner first name is $wfname, loser first name is $lfname <br>" if $debug;      
      printf "winner first init is $firstinitwinner , loser first init is $firstinitloser <br>" if $debug;      
 
      print "<td>$date</td>
       <td>$city</td>
       <td>$event</td>
       <td>${wlname} d ${llname} $score</td>";


      $sql = "select loser from results \
              where round='4' and city='$city' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($slname,$slfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $slfname=~ s/^\s+//;
          $slfname =~ s/\s+$//;
          $sfirstinit = substr($slfname, 0, 1);

          if ($slname =~ /$dup_last_names/) {
            $slname="${sfirstinit}.${slname}";
          }

          print "${slname}";
          print ", " if $i==0;
          $i++;
      }
      print "</td>";


      $sql = "select loser from results \
              where round='8' and city='$city' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($qlname,$qlfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $qlfname=~ s/^\s+//;
          $qlfname =~ s/\s+$//;
          $qfirstinit = substr($qlfname, 0, 1);

# Only printing first initial for Rojas, Carson; can add in other names later as needed
          if ($qlname =~ /$dup_last_names/) {
            $qlname="${qfirstinit}.${qlname}";
          }

          print "${qlname}";
          print ", " if $i<3;
          $i++;
      }
      print "</td></tr>";
         
   }

   print "</table>";


#
# Next: Season Summary per season, borrowed from season_summary_allplayers() but modified to only get those 
#  who reached a quarter final
#

   printf "<hr>";

   printf "Entering season_summary_allplayers inside statistical_abstract function\n" if $debug;

   printf "<p><b>Season Summaries for all players for $form{'season'}</b><p>";
   printf "<p>This table sorts by Wins, then Finals made, then Semis, etc.  It will not necessarily correspond to the season ending ranking because (for example) a semi in a major is worth more than a semi at a normal tournament.  It only lists those players who at least made a quarterfinal on the year.<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Player</b></td>
          <td><b>Rank</b></td>
          <td><b>Season<br> Wins</b></td>
          <td><b>Season<br> Finals</b></td>
          <td><b>Season<br> Semis</b></td>
          <td><b>Season<br> Qtrs</b></td>
          <td><b>Season<br> 16s</b></td>
          <td><b>Season<br> 32s</b></td>
          <td><b>Season<br> 64s</b></td>
          <td><b>Season<br> 128s</b></td>
          <td><b>Season<br> 256s</b></td> 
          <td><b>Season<br> Missed</b></td> 
         </tr>\n";

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   # How many events in the season?  We'll use this later on to determine the number of missed events per player
   $sql="select count(distinct(event)) from results where season='$form{'season'}'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      $num_events=$row;
   }

   # distinct list of all players per season

   $sql = "select distinct winner as name from results where season='$form{'season'}'
           union 
           select distinct loser as name from results where season='$form{'season'}' order by name";
     
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) { 
      push (@players,$row);
   }

   # temporarily override all players
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
   #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
   #@players=('Beltran, Alvaro','Swain, Cliff');

   for $plyr (@players) {

      printf "<p><b>Working on player $plyr</b>" if $debug;

# we've never had a round of 512 ...
      my $twofiftysixes=0;
      my $onetwentyeights=0;
      my $sixtyfours=0;
      my $thirtytwos=0;
      my $sixteens=0;
      my $quarters=0;
      my $semis=0;
      my $finals=0;
      my $wins=0;
      my $player=0;
      my $season=0;

      next if ($plyr =~ /\?/);

     ($player,$season,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)=&gen_perseason_summary($plyr,$form{'season'});

      # 5/27/08: trying temp table to sort results instead of perl
      $sql = "insert into season_summary_rpt values ('$player',$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
  }

  # deleting, for the Abstract query only, players who didn't at least make a quarter.
   $sql = "delete from season_summary_rpt where wins=0 and finals=0 and semis=0 and quarters=0";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "select player,wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes from season_summary_rpt order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) { 
      #printf "row is $row<br>" if $debug;
      $myplayer=$row[0];
      $mywinscity=$row[1];
      $myfinals=$row[2];
      $mysemis=$row[3];
      $myquarters=$row[4];
      $mysixteens=$row[5];
      $mythirtytwos=$row[6];
      $mysixtyfours=$row[7];
      $myonetwentyeights=$row[8];
      $mytwofiftysixes=$row[9];

      #push (@allsummariesdb,@row);
      push (@allsummariesdb,"$myplayer~$mywinscity~$myfinals~$mysemis~$myquarters~$mysixteens~$mythirtytwos~$mysixtyfours~$myonetwentyeights~$mytwofiftysixes");
   }

   printf "<p>" if $debug;
   &dump_array(@allsummariesdb) if $debug;

# now, sort the allsummaries array by total wins...

   # Sort the possibles by the score of the longest game.
   #$sort_field=1;
   #@allsummaries=&schwartzian_sort($sort_field,\@allsummaries);

   # Results come from DB in reverse order; this fixes that.
   @allsummariesdb=&reverse_array(@allsummariesdb);


# now print out the allsummaries
   foreach $playersummary (@allsummariesdb) {
      #printf "$match<br>";   
      ($player,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes) = split(/~/,$playersummary);

# get the rank of the player if it exists
      $sql = "select rank from rankings where player='$player' \
              and season='$form{'season'}'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@rows = $sth->fetchrow_array) {
         $rank=$rows[0];
         #printf "$rank[0]\n" if $debug;
      }

      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
      $missed=$num_events-$total_results;
     
      print "<td>$form{'season'}</td>
          <td>$player</td>
          <td align=center>#${rank}</td> 
          <td align=center>$wins</td>
          <td align=center>$finals</td>
          <td align=center>$semis</td>
          <td align=center>$quarters</td>
          <td align=center>$sixteens</td>
          <td align=center>$thirtytwos</td>
          <td align=center>$sixtyfours</td>
          <td align=center>$onetwentyeights</td>
          <td align=center>$twofiftysixes</td>
          <td align=center>$missed</td>
          </tr>";
   }

   printf "</table>";

   # 5/27/08: cleanup holding table at end
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;


   printf "<hr>";


  
#
# Next: most points in a win
#

   printf "<b>Most Points scored in a Victory for season $form{'season'} </b><p>";

   $sql = "select winner,loser,round,score,tour,city,event,date,season from results \
              where season='$form{'season'}'"; 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1]; 
      $round=$row[2];
      $score=$row[3];
      $tour=$row[4];
      $city=$row[5];
      $event=$row[6];
      $date=$row[7];  
      $season=$row[8];

      $new_round=&fix_round($round);

      #printf "pre: $score <br>";

      # Data entry errors cause some scores to have commas, others spaces separating
      # game scores.  Must stript them
      if ($score =~ /\,/) {
         $score =~ s/\,/ /g;
         #@points=split(/\,/,$score);
      }

      # clean Extra spaces in scores
      $score=~ s/  */ /g;

      #printf "post: $score <br>";

      @points=split(/ /,$score);
      $winner_pts=0;
      $loser_pts=0;

      foreach $sc (@points) {
         printf "score is $sc | " if $debug;

         if ($sc =~ /\(/) {
            $sc =~ s/\(//g;
            $sc =~ s/\)//g;
            $winner_pts+=$sc;
            if ($sc > 9) {
               $loser_pts+=($sc+2);
            }
            else {
               $loser_pts+=11;
            }
         }
         else {
            $loser_pts+=$sc;
            if ($sc > 9) {            
               $winner_pts+=($sc+2);
            }
            else {
               $winner_pts+=11;
            }
         }
      }

      $delta=$winner_pts-$loser_pts;
      
      printf "post processing: @points, $ttl_pts $winner_pts $loser_pts<br>" if $debug;
      $possible="$winner~$loser~$new_round~$score~$tour~$city~$event~$date~$season~$ttl_pts~$winner_pts~$loser_pts~$delta";
      push (@possibles,$possible);
      
   }

   #&dump_array(@possibles);

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b>Winner Points</b></td>
          </tr>\n";

   # this removes duplicates; if a match is like 12,12,10, the two 12 scores report twice
   # in the above logic.
   
   # Sort the possibles by the score of the most winner points
   $sort_field=10;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # reverse the array
   @possibles=&reverse_array(@possibles);

   $counter=0;
   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total,$winnerpts,$loserpts,$deltapts) = split(/~/,$match);

      $score=~ s/ /,/g;

      if ($counter < 11) {
         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             <td align=center>$winnerpts</td>
             </tr>";
         $counter++;
      }
   }

   printf "</table>";
   printf "<hr>";

#
# Most points scored in a loss: taking array from above and re-sorting it.
#

   printf "<b>Most Points scored in a loss for season $form{'season'} </b><p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          <td><b>Loser Points</b></td>
          </tr>\n";

   # Sort the possibles by the score of the most loser points
   $sort_field=11;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # reverse the array
   @possibles=&reverse_array(@possibles);

   $counter=0;
   foreach $match (@possibles) {
      #printf "$match<br>";
      ($winner,$loser,$new_round,$score,$tour,$city,$event,$date,$season,$total,$winnerpts,$loserpts,$deltapts) = split(/~/,$match);

      $score=~ s/ /,/g;

      if ($counter < 11) {
         print "<tr><td>$season</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td>$new_round</td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             <td align=center>$loserpts</td>
             </tr>";
         $counter++;
      }
   }

   printf "</table>";
   printf "<hr>";

   printf "More to come... still under development...";
   
   &print_back_link;
   printf "</body></html>";	    

}




#--------------------------------------------------------------------------------
# 5/19/15: highest seeds per season to do ...
# 1/17/17: fixing bug in this report that doesn't repeat high-seeded winners in lower reports; discovered while creating overall version

sub highest_seeds() {

   printf "Entering Highest Seeds \n" if $debug;

   printf "<b>Highest Seeds Report for $form{'season'}<p></b>";

   printf "This query shows the highest seeds to win a tourney, make a final, make the quarters, etc for the season <b>$form{'season'}</b> <p>";

   printf "<hr>";

   printf "<b>Highest Seeds to win a tourney in season $form{'season'}</b> (excludes #1 or #2 seed wins).  If empty, then a #1 or #2 seed won every event.<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.winner, r.date, r.event, s.seeding,r.loser, r.score
           from results r, seedings s
           where r.event = s.event
           and r.winner=s.player
           and r.season='$form{'season'}'
           and r.round=2
           and s.seeding > 2
           order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $winner=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];
      $loser=$row[6];
      $score=$row[7];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Winner</td>
             <td><center>$seeding</center></td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";   

   }
   printf "</table>";
   printf "<hr>";


   printf "<b>Highest Seeds to Make a final in $form{'season'}</b> (excludes #1 or #2 seeds making the final)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 2
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Finalist</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }
   printf "</table>";
   printf "<hr>";



   printf "<b>Highest Seeds to Make a Semi in $form{'season'}</b> (excludes top 4 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=4
and s.seeding > 4
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 4
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 4
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Semis</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Quarter in $form{'season'}</b> (excludes top 8 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=8
and s.seeding > 8
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=4
and s.seeding > 8
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 8
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 8
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Quarters</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Round of 16 in $form{'season'}</b> (excludes top 16 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=16
and s.seeding > 16
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=8
and s.seeding > 16
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=4
and s.seeding > 16
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 16
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 16
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Rndof16</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Round of 32 in $form{'season'}</b> (excludes top 32 seeds)<p>";

   printf "Note: this query basically shows who upset a higher seed in the play-in rounds at the 1-2 tourneys each year that actually have a round of 32.  Not that useful, but also shows who had big results as very low seeds at the US Open and other Grand Slams<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=32
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=16
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=8
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=4
and s.seeding > 32
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.season='$form{'season'}'
and r.round=2
and s.seeding > 32
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Rndof32</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 


}




#--------------------------------------------------------------------------------
# 1/16/17: highest seeds per season to do ... for ALL data
#  Adapted from highest_seeds() and just removed seasons

sub highest_seeds_all() {

   printf "Entering Highest Seeds for All seasons \n" if $debug;

   printf "<b>Highest Seeds Report for All Seasons<p></b>";

   printf "This query shows the highest seeds to win a tourney, make a final, make the quarters, etc for all available data in the database.  Keep in mind that seeding data was only reliably captured starting in the 2010-11 season.  There are some tourneys going back in time where we have captured seeding data and those may show up herein.</b> <p>";

   if ($form{'tour'} eq 'IRT') {
      printf "Two of the most 'important' low-seed wins in the history of the tour are the only two times in recorded history where a qualifier has won a tournament; Cliff Swain in 1985 Tulsa and Kane Waselenchuk upon his return from suspension in Denver 2008.  I've manually found and re-created the seedings from these two tournaments to make this report show these two results.  I've also manually put in Hogan, Sudsy and Kane's first professional wins, since each of the top players won the 7th pro event they entered and were lower seeds.<p>";
   }

   printf "<hr>";

   printf "<b>Highest Seeds to win a tourney</b> (excludes #1 or #2 seed wins).<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.winner, r.date, r.event, s.seeding,r.loser, r.score
           from results r, seedings s
           where r.event = s.event
           and r.winner=s.player
           and r.round=2
           and s.seeding > 2
           order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $winner=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];
      $loser=$row[6];
      $score=$row[7];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Winner</td>
             <td><center>$seeding</center></td>
             <td>$winner</td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";   

   }
   printf "</table>";
   printf "<hr>";


   printf "<b>Highest Seeds to Make a final</b> (excludes top four seeds making the final)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=2
and s.seeding > 4
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.round=2
and s.seeding > 4
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Finalist</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }
   printf "</table>";
   printf "<hr>";



   printf "<b>Highest Seeds to Make a Semi</b> (excludes top 6 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=4
and s.seeding > 6
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.round=2
and s.seeding > 6
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=2
and s.seeding > 6
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Semis</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Quarter</b> (excludes top 12 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=8
and s.seeding > 12
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=4
and s.seeding > 12
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.round=2
and s.seeding > 12
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=2
and s.seeding > 12
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Quarters</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Round of 16</b> (excludes top 24 seeds)<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=16
and s.seeding > 24
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=8
and s.seeding > 24
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=4
and s.seeding > 24
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.round=2
and s.seeding > 24
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=2
and s.seeding > 24
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Rndof16</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   printf "<hr>";

   printf "<b>Highest Seeds to Make a Round of 32</b> (excludes top 32 seeds)<p>";

   printf "Note: this query basically shows who upset a higher seed in the play-in rounds at the 1-2 tourneys each year that actually have a round of 32.  Not that useful, but also shows who had big results as very low seeds at the US Open and other Grand Slams<p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Seeding</b></td>
          <td><b>Player</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=32
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=16
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=8
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=4
and s.seeding > 32
union
select r.season, r.round, r.winner, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.winner=s.player
and r.round=2
and s.seeding > 32
union
select r.season, r.round, r.loser, r.date, r.event, s.seeding
from results r, seedings s
where r.event = s.event
and r.loser=s.player
and r.round=2
and s.seeding > 32
order by seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $loser=$row[2];
      $date=$row[3];
      $event=$row[4];
      $seeding=$row[5];

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td>Rndof32</td>
             <td><center>$seeding</center></td>
             <td>$loser</td>
             </tr>";   

   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 


}

#--------------------------------------------------------------------------------
# 1/19/17: Put in per-event seed report, showing all upsets for the tourney.

sub seed_report_per_event() {

   ($event,$date)=split(/~/,$form{'event'});

   printf "Entering Seed Report per Event \n" if $debug;

   printf "<b>Upsets by Seeding for event <b>$event</b><p></b>";
   
   if ($form{'event'} eq "0") {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
	  next;
   }   

   printf "This query shows all the Upsets by seeding for the event, as well as all seeds who advanced to subsequent rounds not projected by their seeding (in other words, a 10th seed advancing to the semi finals even if they ended up advancing by beating a 15th seed).</b> <p>";


   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
      printf "The number of Qualifier wins is the number of wins by players seeded above #8 for regular tournaments, #16 for Majors.  This hasn't always been the case on tour; players used to qualify into the round of 32 for every tournament, and major qualifying has changed over the years.  As we get better seeding, we'll adjust.<p>";
   }
   else {
      # do nothing
      # no qualifying in WRT events so won't print anything related to those 
      # Nothing to note for IRF
   }


   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Round</b></td>
          <td><b>Winner Seed</b></td>
          <td><b>Winner</b></td>
          <td><b>Loser Seed</b></td>
          <td><b>Loser</b></td>
          <td><b>Score</b></td>
          </tr>\n";

   $sql = "select r.season, r.round, sw.seeding as winner_seeding, r.winner, r.date, r.event, sl.seeding as loser_seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and sw.seeding > sl.seeding
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=128 and sw.seeding > 64
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=64 and sw.seeding > 32
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=32 and sw.seeding > 16
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=16 and sw.seeding > 8
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=8 and sw.seeding > 4
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=4 and sw.seeding > 2
union
select r.season, r.round, sw.seeding, r.winner, r.date, r.event, sl.seeding, r.loser, r.score
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and r.round=2 and sw.seeding > 1
order by round desc, winner_seeding desc;";

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $round=$row[1];
      $winner_seed=$row[2];
      $winner=$row[3];
      $date=$row[4];
      $event=$row[5];
      $loser_seed=$row[6];
      $loser=$row[7];
      $score=$row[8];

      $new_round=&fix_round($round);

      print "<tr><td>$season</td>
             <td>$date</td>
             <td>$event</td>
             <td><center>$new_round</center></td>
             <td><center>$winner_seed</center></td>
             <td>$winner</td>
             <td><center>$loser_seed</center></td>
             <td>$loser</td>
             <td>$score</td>
             </tr>";   

   }
   printf "</table><hr>";


# no qualifying in WRT events so won't print anything related to those 
   if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
      $sql = "select major_flag from tourneys t where event='$event';";

      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $major_flag=$row[0];
      }

      if ($major_flag eq 'Y') {
         $round_count=32;
         $bye_count=16;
      }
      else {
         $round_count=16;
         $bye_count=8;
      }
 
      $sql = "select count(*) 
from results r, seedings sw, seedings sl
where r.event = sw.event
and r.event = sl.event
and r.winner=sw.player
and r.loser=sl.player
and r.event='$event'
and sw.seeding > sl.seeding
and r.round <= $round_count
and sw.seeding > $bye_count";

      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $qualifier_wins=$row[0];
      }

      printf "<b>Number of Main Draw Qualifier Wins for the tournament (round of $round_count onwards)</b>: $qualifier_wins<p>";

   }
   else {
      # do nothing
      # no qualifying in WRT events so won't print anything related to those 
      # Nothing to note for IRF
   }
   
   &print_back_link;
   printf "</body></html>";	    

}


#--------------------------------------------------------------------------------
# 1/4/18;  highest seeds to comprise the finals field; adapted from the _sf version
# 

sub highest_seeds_f() {

   printf "Entering Highest Seed/Lowest Seed finals for $form{'query'} Report  \n" if $debug;

   if ($form{'query'} eq 'highest_seeds_f') {
      printf "<b>Highest Combined Seeds to comprise a Final in Pro tour History</b><p>";

      printf "This query shows the highest combined seeds to comprise the the Final of a pro event.  Note that full seeding data is generally only available
from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 to present.<p>";
   }
   elsif ($form{'query'} eq 'lowest_seeds_f') {
      printf "<b>Lowest Combined Seeds to comprise a Final in Pro tour History</b><p>";

      printf "This query shows the lowest combined seeds to comprise the the Final of a pro event.  In other words, it prints out all the #1 vs #2 finals matchups known on tour. Note that full seeding data is generally only available from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 to present.<p>";
   }
   else {
      printf "you should never get here<p>";
   }



   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Combined Seeding of Finalists</b></td>		  
          <td><b>Winner Seed</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist Seed</b></td>
          <td><b>Finalist</b></td>		  
          </tr>\n";
		  
   # Get all tourneys
   $sql = "select distinct event,date,tmp_date,season from results order by tmp_date";
   printf "$sql<br>" if $debug;   
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
      $date=$row[1];	
	$tmp_date=$row[2];
      $season=$row[3];
		 
      # Get the winner and seed
      $sql2="select winner, s1.seeding as winner_seed
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2";

      printf "$sql2<br>" if $debug; 
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $winner=$row2[0];
         $winner_seed=$row2[1];			   
      }  
	  
	printf "winner is $winner, winner seed is $winner_seed<br>" if $debug;
		 
	# Get the finalist and seed

      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $finalist=$row2[0];
         $finalist_seed=$row2[1];			   
	  }  		 

	printf "finalist is $finalist, finalist seed is $finalist_seed<br>" if $debug;	  
	  
      $total_seed=$winner_seed+$finalist_seed;
		 
	printf "Total seeds combined is $total_seed<p>" if $debug;
		
      if ($form{'query'} eq 'highest_seeds_f') {
         # cutoff of 5
         if ($total_seed > 4) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed");
	   } 
      }
      elsif ($form{'query'} eq 'lowest_seeds_f') {
         # cutoff of 3: #1 vs #2
         if ($total_seed == 3) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed");
	   } 
      }
      else {
         printf "you should never get here<p>";
      } 	  
   }

   &dump_array(@possibles) if $debug;	  

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   # reverse the array
   @possibles=&reverse_array(@possibles);

   foreach $possible (@possibles) {
      #printf "$possible<br>";
      ($season,$date,$event,$total_seed,$winner,$winner_seed,$finalist,$finalist_seed,$semifinalist1,$semifinalist1_seed,$semifinalist2,$semifinalist2_seed) = split(/~/,$possible);

      print "<td>$season</td>
          <td>$date</td>
          <td>$event</td>
          <td><center>$total_seed</center></td>		  
          <td><center>$winner_seed</center></td>
          <td>$winner</td>
          <td><center>$finalist_seed</center></td>
          <td>$finalist</td>	  
          </tr>\n";
   }   
   
   printf "</table><hr>";
   &print_back_link;
   printf "</body></html>";	    

}



#--------------------------------------------------------------------------------
# 1/3/18;  highest seeds to comprise the semis field
# 

sub highest_seeds_sf() {

   printf "Entering Highest/Lowets Seed Semis/finals Report for $form{'query'}\n" if $debug;

   if ($form{'query'} eq 'highest_seeds_sf') {
      printf "<b>Highest Combined Seeds to comprise a Semis Field in Pro tour History</b><p>";
   
      printf "This query shows the highest combined seeds to comprise the Semis and Finals field of a pro event.  Note that full seeding data is 
              generally only available from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 
              to present.<p>";
   }
   elsif ($form{'query'} eq 'lowest_seeds_sf') {
      printf "<b>Lowest Combined Seeds to comprise a Semis Field in Pro tour History</b><p>";

      printf "This query shows the lowest combined seeds to comprise the the Semis and Finals of a pro event.  In other words, if the top four seeds in a draw all make the semis, that's the lowest possible combined seed count.  Note that full seeding data is generally only available from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 to present.<p>";
   }
   else {
      printf "you should never get here<p>";
   }



   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Combined Seeding of Semifinalists</b></td>		  
          <td><b>Winner Seed</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist Seed</b></td>
          <td><b>Finalist</b></td>
          <td><b>SemiFinalist 1 Seed</b></td>
          <td><b>SemiFinalist 1</b></td>
          <td><b>SemiFinalist 2 Seed</b></td>
          <td><b>SemiFinalist 2</b></td>		  
          </tr>\n";
		  
   # Get all tourneys
   $sql = "select distinct event,date,tmp_date,season from results order by tmp_date";
   printf "$sql<br>" if $debug;   
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
      $date=$row[1];	
	$tmp_date=$row[2];
      $season=$row[3];
		 
   # Get the winner and seed
      $sql2="select winner, s1.seeding as winner_seed
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2";

      printf "$sql2<br>" if $debug; 
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $winner=$row2[0];
         $winner_seed=$row2[1];			   
      }  
	  
	printf "winner is $winner, winner seed is $winner_seed<br>" if $debug;
		 
	# Get the finalist and seed

      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $finalist=$row2[0];
         $finalist_seed=$row2[1];			   
	}  		 

	printf "finalist is $finalist, finalist seed is $finalist_seed<br>" if $debug;	  
	  
      # Get the semi finalists and their seeds
      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=4
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

	$counter=0;
      while (@row2 = $sth2->fetchrow_array) {
         if ($counter eq '0') {
    	      $semifinalist1=$row2[0];
            $semifinalist1_seed=$row2[1];	
         } 
         else {
    	      $semifinalist2=$row2[0];
            $semifinalist2_seed=$row2[1];	
	   } 
         $counter++;			
      }  
	  
	printf "semifinalist1 is $semifinalist1, semifinalist1 seed is $semifinalist1_seed<br>" if $debug;      	  
	printf "semifinalist2 is $semifinalist2, semifinalist2 seed is $semifinalist2_seed<br>" if $debug;  
	  
      $total_seed=$winner_seed+$finalist_seed+$semifinalist1_seed+$semifinalist2_seed;
		 
	printf "Total seeds combined is $total_seed<p>" if $debug;

      if ($form{'query'} eq 'highest_seeds_sf') {
         # cutoff of 20
         if ($total_seed > 19) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed~$semifinalist1~$semifinalist1_seed~$semifinalist2~$semifinalist2_seed");
	   }
      }
      elsif ($form{'query'} eq 'lowest_seeds_sf') {
         if ($total_seed <= 11 && $total_seed > 0) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed~$semifinalist1~$semifinalist1_seed~$semifinalist2~$semifinalist2_seed");
         }
      }
      else {
         printf "you should never get here<p>";
      } 	  
   }

   &dump_array(@possibles) if $debug;	  

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   if ($form{'query'} eq 'highest_seeds_sf') {
      # reverse the array
      @possibles=&reverse_array(@possibles);
   }

   foreach $possible (@possibles) {
      #printf "$possible<br>";
      ($season,$date,$event,$total_seed,$winner,$winner_seed,$finalist,$finalist_seed,$semifinalist1,$semifinalist1_seed,$semifinalist2,$semifinalist2_seed) = split(/~/,$possible);

      print "<td>$season</td>
          <td>$date</td>
          <td>$event</td>
          <td><center>$total_seed</center></td>		  
          <td><center>$winner_seed</center></td>
          <td>$winner</td>
          <td><center>$finalist_seed</center></td>
          <td>$finalist</td>
          <td><center>$semifinalist1_seed</center></td>
          <td>$semifinalist1</td>
          <td><center>$semifinalist2_seed</center></td>
          <td>$semifinalist2</td>		  
          </tr>\n";
   }   
   
   printf "</table><hr>";
   &print_back_link;
   printf "</body></html>";	    

}


#--------------------------------------------------------------------------------
# 1/4/18;  highest seeds to comprise the qtrs/semis/finals field
# 

sub highest_seeds_qsf() {

   printf "Entering Highest/Lowest Seed Quarters/Semis/finals Report for $form{'query'} \n" if $debug;

   if ($form{'query'} eq 'highest_seeds_qsf') {
      printf "<b>Highest Combined Seeds to comprise a Quarters/Semis/Finals Field in Pro tour History</b><p>";
    
      printf "This query shows the highest combined seeds to comprise the Quarters/Semis/Finals field of a pro event.  Note that full seeding data is generally only available
from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 to present.<p>";
   }
   elsif ($form{'query'} eq 'lowest_seeds_qsf') {
      printf "<b>Lowest Combined Seeds to comprise a Quarters/Semis/Finals Field in Pro tour History</b><p>";
    
      printf "This query shows the Lowets combined seeds to comprise the Quarters/Semis/Finals field of a pro event.  The lowest possible amount is
36: the sum of seeds 1..8.  Note that full seeding data is generally only available
from 2009 to present for the IRT and LPRT, and is fully available for all WRT events from inception in 2012 to present.<p>";
   }
   else {
      printf "you should never get here<p>";
   }


   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Date</b></td>
          <td><b>Event</b></td>
          <td><b>Combined Seeding of Semifinalists</b></td>		  
          <td><b>Winner Seed</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist Seed</b></td>
          <td><b>Finalist</b></td>
          <td><b>SemiFinalist 1 Seed</b></td>
          <td><b>SemiFinalist 1</b></td>
          <td><b>SemiFinalist 2 Seed</b></td>
          <td><b>SemiFinalist 2</b></td>		  
          <td><b>QuarterFinalists Seeds</b></td>		
          <td><b>QuarterFinalists </b></td>	
          </tr>\n";
		  
   # Get all tourneys
   $sql = "select distinct event,date,tmp_date,season from results order by tmp_date";
   printf "$sql<br>" if $debug;   
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
      $date=$row[1];	
	  $tmp_date=$row[2];
      $season=$row[3];
		 
   # Get the winner and seed
      $sql2="select winner, s1.seeding as winner_seed
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2";

      printf "$sql2<br>" if $debug; 
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $winner=$row2[0];
         $winner_seed=$row2[1];			   
      }  
	  
	printf "winner is $winner, winner seed is $winner_seed<br>" if $debug;
		 
	# Get the finalist and seed

      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=2
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $finalist=$row2[0];
         $finalist_seed=$row2[1];			   
	}  		 

	printf "finalist is $finalist, finalist seed is $finalist_seed<br>" if $debug;	  
	  
      # Get the semi finalists and their seeds
      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=4
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

	$counter=0;
      while (@row2 = $sth2->fetchrow_array) {
         if ($counter eq '0') {
    	      $semifinalist1=$row2[0];
            $semifinalist1_seed=$row2[1];	
	   } 
         else {
    	      $semifinalist2=$row2[0];
            $semifinalist2_seed=$row2[1];	
         } 
         $counter++;			
      }  
	  
	printf "semifinalist1 is $semifinalist1, semifinalist1 seed is $semifinalist1_seed<br>" if $debug;      	  
	printf "semifinalist2 is $semifinalist2, semifinalist2 seed is $semifinalist2_seed<br>" if $debug;  
	  
	# Get the qtr finalists and their seeds
      $sql2="select loser, s2.seeding as loser_seed
           from results r
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           where r.event='$event'
           and r.tmp_date='$tmp_date'
           and r.round=8
           order by r.tmp_date,r.round desc;";

      printf "$sql2<br>" if $debug; 		   
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      $counter=0;
      while (@row2 = $sth2->fetchrow_array) {
         if ($counter eq '0') {
            $qtrfinalist1=$row2[0];
            $qtrfinalist1_seed=$row2[1];

            ($q1lname,$q1fname)=split(/,/,$qtrfinalist1);
            printf "$qtrfinalist1, $q1lname,$q1fname before cleaning<p>" if $debug;

            # must trim leading spaces from the first names in order to get the first initial
            $q1fname =~ s/^\s+//;
            $q1fname =~ s/\s+$//;
            printf "$qtrfinalist1, $q1lname, ~${q1fname} after cleaning<p>" if $debug;

            $firstinitq1=substr($q1fname,0,1);

            printf "$firstinitq1 is first initial<p>" if $debug;
      
            if ($q1lname =~ /$dup_last_names/) {
               printf "name match in dup_last_names, ${firstinitq1} . ${q1lname}<p>" if $debug;
               $q1lname="${firstinitq1}.${q1lname}";
            }

            printf "$qtrfinalist1, $q1lname,$q1fname, $firstinitq1<p>" if $debug;

	   } 
         elsif ($counter eq '1')  {
    	      $qtrfinalist2=$row2[0];
            $qtrfinalist2_seed=$row2[1];

            ($q2lname,$q2fname)=split(/,/,$qtrfinalist2);

            # must trim leading spaces from the first names in order to get the first initial
            $q2fname =~ s/^\s+//;
            $q2fname =~ s/\s+$//;

            $firstinitq2=substr($q2fname,0,1);
      
            if ($q2lname =~ /$dup_last_names/) {
               $q2lname="${firstinitq2}.${q2lname}";
            }	
	   } 
         elsif ($counter eq '2')  {
    	      $qtrfinalist3=$row2[0];
            $qtrfinalist3_seed=$row2[1];	

            ($q3lname,$q3fname)=split(/,/,$qtrfinalist3);

            # must trim leading spaces from the first names in order to get the first initial
            $q3fname =~ s/^\s+//;
            $q3fname =~ s/\s+$//;

            $firstinitq3=substr($q3fname,0,1);
      
            if ($q3lname =~ /$dup_last_names/) {
               $q3lname="${firstinitq3}.${q3lname}";
            }
	   } 
         elsif ($counter eq '3')  {
    	      $qtrfinalist4=$row2[0];
            $qtrfinalist4_seed=$row2[1];	

            ($q4lname,$q4fname)=split(/,/,$qtrfinalist4);

            # must trim leading spaces from the first names in order to get the first initial
            $q4fname =~ s/^\s+//;
            $q4fname =~ s/\s+$//;

            $firstinitq4=substr($q4fname,0,1);
      
            if ($q4lname =~ /$dup_last_names/) {
               $q4lname="${firstinitq4}.${q4lname}";
            }

	   } 		 
         $counter++;			
      }  
	  
      printf "Qtrfinalists are $qtrfinalist1,$qtrfinalist2,$qtrfinalist3,$qtrfinalist4. seeds are $qtrfinalist1_seed, $qtrfinalist2_seed, $qtrfinalist3_seed, $qtrfinalist4_seed<br>" if $debug;      	  
	  
      $total_seed=$winner_seed+$finalist_seed+$semifinalist1_seed+$semifinalist2_seed+$qtrfinalist1_seed+$qtrfinalist2_seed+$qtrfinalist3_seed+$qtrfinalist4_seed;
		 
      printf "Total seeds combined is $total_seed<p>" if $debug;
	 
      if ($form{'query'} eq 'highest_seeds_qsf') {
         # cutoff of 40
         if ($total_seed > 39) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed~$semifinalist1~$semifinalist1_seed~$semifinalist2~$semifinalist2_seed~$q1lname~$q2lname~$q3lname~$q4lname~$qtrfinalist1_seed~$qtrfinalist2_seed~$qtrfinalist3_seed~$qtrfinalist4_seed");
	   }
      }
      elsif ($form{'query'} eq 'lowest_seeds_qsf') {
         if ($total_seed <= 39 && $total_seed > 0) {
            push (@possibles,"$season~$date~$event~$total_seed~$winner~$winner_seed~$finalist~$finalist_seed~$semifinalist1~$semifinalist1_seed~$semifinalist2~$semifinalist2_seed~$q1lname~$q2lname~$q3lname~$q4lname~$qtrfinalist1_seed~$qtrfinalist2_seed~$qtrfinalist3_seed~$qtrfinalist4_seed");
         }
      }
      else {
         printf "you should never get here<p>";
      } 	  
   }

   &dump_array(@possibles) if $debug;	  

   # Sort the possibles by the score of the longest game.
   $sort_field=3;
   @possibles=&schwartzian_sort($sort_field,\@possibles);

   if ($form{'query'} eq 'highest_seeds_qsf') {
      # reverse the array
      @possibles=&reverse_array(@possibles);
   }

   foreach $possible (@possibles) {
      #printf "$possible<br>";
      ($season,$date,$event,$total_seed,$winner,$winner_seed,$finalist,$finalist_seed,$semifinalist1,$semifinalist1_seed,$semifinalist2,$semifinalist2_seed,$qtrfinalist1,$qtrfinalist2,$qtrfinalist3,$qtrfinalist4,$qtrfinalist1_seed,$qtrfinalist2_seed,$qtrfinalist3_seed,$qtrfinalist4_seed) = split(/~/,$possible);

      print "<td>$season</td>
          <td>$date</td>
          <td>$event</td>
          <td><center>$total_seed</center></td>		  
          <td><center>$winner_seed</center></td>
          <td>$winner</td>
          <td><center>$finalist_seed</center></td>
          <td>$finalist</td>
          <td><center>$semifinalist1_seed</center></td>
          <td>$semifinalist1</td>
          <td><center>$semifinalist2_seed</center></td>
          <td>$semifinalist2</td>	
          <td><center>$qtrfinalist1_seed,$qtrfinalist2_seed,$qtrfinalist3_seed,$qtrfinalist4_seed</center></td>		
          <td>$qtrfinalist1,$qtrfinalist2,$qtrfinalist3,$qtrfinalist4</td>			  
          </tr>\n";
   }   
   
   printf "</table><hr>";
   &print_back_link;
   printf "</body></html>";	    

}





#--------------------------------------------------------------------------------
# All top tens: goes through all the seasons, prints out just the top 10s.
# 

sub all_top_tens() {
   printf "Entering All top 10s<br>" if $debug;

   printf "<b>All Top 10 lists</b> <p>"; 

   if ($form{'tour'} eq 'IRT') {
      printf "Note: The IRT went to a pure points driven system for determining the champions starting with the 1981-82 season.  Prior to that, 
	  the winner of the NRC Nationals tournament was declared the 'Pro tour Winner.'  There were 'rankings' on the tour, used primarily for seeding 
	  purposes.  For some seasons prior to 1981-82 I have captured these 'rankings' (mostly from looking at the seedings to start the subsequent 
	  season and/or if they were published in the magazine at the time, but they do NOT determine a season-ending 'ranking' as we are accustomed to 
	  today.  In seasons where I do not have these rankings, I have listed the results from the Nationals event from that season: Q for quarterfinalist, 
	  S for semi finalist and 1/2 for the NRC Nationals winner and runner-up. <p>";
   }

   if ($form{'tour'} eq 'WRT') {
      printf "We only have WRT season ending rankings for part of the WRT history at this point; we are working on getting the other seasons.<p>";
   }

   $sql = "select distinct(season) from results order by season desc";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=0;
   while ($row = $sth->fetchrow_array) {
      #printf "$rows[$i]\n" if $debug;
      #$season=$rows[$i];
      #printf "$row\n" if $debug;

      push (@seasons,$row);
   }

   &dump_array(@seasons) if $debug;

   for $season (@seasons) {

      printf "<b>Season: $season</b><br>";

      print "<table border><tr>\n";
      print "<td><b>Season</b></td>
             <td><b>Rank</b></td>
             <td><b>Player</b></td>
             <td><b>Points</b></td></tr>";

      $sql = "select player,rank,points from rankings where season='$season' and rank <=10 order by rank";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         ($player,$rank,$points) = ($row[0],$row[1],$row[2]);
         $row="$player~$rank~$points";
         #printf "$row<br>" if $debug;
         push (@rankings,$row);
      }

      #&dump_array(@rankings) if $debug;

# 6/10/15: changed this sort field from 2 (points) to 1 (ranking) b/c we don't always have the rankings points ...
#   but we always have the rank.  So we'll sort on that instead, comment out the reverse array and we're good.
   
      $sort_field=1;
      @rankings=&schwartzian_sort($sort_field,\@rankings);

      #&dump_array(@rankings) if $debug;
      #@rankings=&reverse_array(@rankings);
      #&dump_array(@rankings) if $debug;

      foreach $rankline (@rankings) {
         ($player,$rank,$points) = split(/~/,$rankline);

         print "<td>$season</td>
                <td><center>$rank</center></td>
                <td><b>$player</b></td>
                <td><center>$points</center></td></tr>";

      }

      print "</table><p>\n";

      undef @rankings;
   }
   
   &print_back_link;
   printf "</body></html>";	    

}

#--------------------------------------------------------------------------------
# 10/10/17: All top tens Matrix: creates a matrix of all players who have ever finished in the top 10
# 

sub all_top_ten_matrix() {
   printf "Entering All top 10 Matrix<br>" if $debug;

   printf "<b>All Top 10 Matrix</b> <p>"; 

   if ($form{'tour'} eq 'IRT') {
      printf "Note: The IRT went to a pure points driven system for determining the champions starting with the 1981-82 season.  Prior to that, 
	  the winner of the NRC Nationals tournament was declared the 'Pro tour Winner.'  As a result, this matrix will only show the champion and runner-up from
      these National Championship tourneys from 1975-1981.  This 'shortchanges' players from the 1970s for sure but we have no other way to give them top 10
	  credit when there wasn't really an official points system being used.  <p>";
	  
	  printf "We have included the early IRA National Championships events for the purposes of this report (in 1975 and 1976), 
	  fairly or not.  There were 'competing' pro tours early on in the sport's history, and the 1976 IRA championship was missing all the top NRC players.  But the
      1975 event was a full draw and resulted in a 3rd 'pro title' for Brumfield (he claims 5 'titles' in all including two amateur titles).  
	  This explains the one National title for Jerry Hilecher, who won the 1976 IRA Nationals<p>";
	  
	  printf "We are missing full top 10 lists from a couple of seasons: 1982-83 and 1989-90.  When we find them, we'll load them in. <p>";
   }

   if ($form{'tour'} eq 'LPRT') {
      printf "Like with the IRT, the Women's Pro tour declared its champion based on who won the year ending NRC tour championship for a number of years.  I am
	  not sure at this point when they went to a points-accumulation system like the IRT did in 1981-82.  For the time being, the code assumes that the ladies tour
	  changed over at the same time.  We are missing top 10 lists for a few early seasons in the 1970s but it shouldn't matter for the purposes of this report<p>";
   }
   
   if ($form{'tour'} eq 'WRT') {
      printf "We only have WRT season ending rankings 2015 to present.  We are working on getting the other seasons.<p>";
   }
   
   # delete temp table to sort results instead of perl
   $sql = "delete from top_ten_matrix_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;   

# initialize variables:

   $alltoptens=0;
   $allnumberones=0;
   $allnumbertwos=0;
   $allnumberthrees=0;
   $allnumberfours=0;
   $allnumberfives=0;
   $allnumbersixes=0;
   $allnumbersevens=0;
   $allnumbereights=0;
   $allnumbernines=0;
   $allnumbertens=0;
   $outsidetopten=0;
   $seasoncount=0;
   
   # adding in the 1/2 players from early on so they're in this array for the next phase.
   $sql = "select distinct(player) from rankings where season > '1980-1' and rank <=10
   union select distinct(player) from rankings where season <='1980-1' and rank in (1,2);";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   
   while (@row = $sth->fetchrow_array) {
      ($player) = ($row[0]);
      #printf "$row<br>" if $debug;
      push (@players,$player);
   }

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>Ttl Seasons <br>with Appearances</b></td>     
          <td><b>Total Career Top 10s</b></td>             
          <td><b>#1 Finishes</b></td>
          <td><b>#2 Finishes</b></td>
          <td><b>#3 Finishes</b></td>
          <td><b>#4 Finishes</b></td>
          <td><b>#5 Finishes</b></td>
          <td><b>#6 Finishes</b></td>
          <td><b>#7 Finishes</b></td>
          <td><b>#8 Finishes</b></td>
          <td><b>#9 Finishes</b></td>
          <td><b>#10 Finishes</b></td>
          <td><b># Finishes <br>outside top10</b></td>
		  </tr>";

   for $plyr (@players) {
      printf "Working on player $plyr<p>" if $debug;
	  
	  # This is a complex query that gets the ranks for newer seasons and unions it with a query to get just winner and runner-up from
	  # the NRC nationals from 1975-1981.
	  
	  #$sql = "select rank from rankings where player='$plyr' and season > '1980-1' and rank <=10;";
	  $sql="select rank from rankings where player='$plyr' and season > '1980-1' and rank <=10 \
            union all
            select 1
            from tourneys t, results r where t.major_flag='Y' and t.season <= '1980-1' and t.tmp_date=r.tmp_date and t.event=r.event and r.round=2
            and r.winner='$plyr'
			union all
			select 2
			from tourneys t, results r where t.major_flag='Y' and t.season <= '1980-1' and t.tmp_date=r.tmp_date and t.event=r.event and r.round=2
			and r.loser='$plyr'";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         ($rank) = ($row[0]);
         #printf "$row<br>" if $debug;
		 
		 $alltoptens++;
		 
		 # There were lots of Ties for rankings in the Ladies tour; this strips the "t" from the rank so it can be evaluated.
		 $rank =~ s/t//g;
	 
         if ($rank eq '1') { $allnumberones++; }
         elsif ($rank eq '2') { $allnumbertwos++; }
         elsif ($rank eq '3') { $allnumberthrees++; }
         elsif ($rank eq '4') { $allnumberfours++; }
         elsif ($rank eq '5') { $allnumberfives++; }
         elsif ($rank eq '6') { $allnumbersixes++; }
         elsif ($rank eq '7') { $allnumbersevens++; }
         elsif ($rank eq '8') { $allnumbereights++; }
         elsif ($rank eq '9') { $allnumbernines++; }
         elsif ($rank eq '10') { $allnumbertens++; }
         else {
            # should never get here
            printf "Invalid ranking received.  Rank is '$rank' after if/then/else.<p>";
         }
      }
	  
	  # get quick count of all distinct seasons in results to be able to quickly calculate seasons outsidetop 10
	  
	  $sql2="select count(distinct(season)) from results where (winner='$plyr' or loser='$plyr');";
      printf "$sql2<br>" if $debug;
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;
      while (@row = $sth2->fetchrow_array) {
         ($seasoncount) = ($row[0]);
      }
	  
	  $outsidetopten=$seasoncount-$alltoptens;

	  $sql = "insert into top_ten_matrix_rpt values \
	     ('$plyr',$alltoptens,$allnumberones,$allnumbertwos,$allnumberthrees,$allnumberfours, \
		 $allnumberfives,$allnumbersixes,$allnumbersevens,$allnumbereights,$allnumbernines,$allnumbertens,$outsidetopten,$seasoncount)";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;	  
	  
	  
	  # zero out counting vars for next player.
	  $alltoptens=0;
      $allnumberones=0;
      $allnumbertwos=0;
      $allnumberthrees=0;
      $allnumberfours=0;
      $allnumberfives=0;
      $allnumbersixes=0;
      $allnumbersevens=0;
      $allnumbereights=0;
      $allnumbernines=0;
      $allnumbertens=0;
	  $outsidetopten=0;
	  $seasoncount=0;
   }	  
   
   
   #trying temp table to sort results instead of perl
   $sql = "select player,alltoptens,allnumberones,allnumbertwos,allnumberthrees,allnumberfours, \
		 allnumberfives,allnumbersixes,allnumbersevens,allnumbereights,allnumbernines,allnumbertens,outsidetopten,seasoncount \
		 from top_ten_matrix_rpt \
		 order by allnumberones desc,allnumbertwos desc,allnumberthrees desc,allnumberfours desc, \
         allnumberfives desc,allnumbersixes desc,allnumbersevens desc,allnumbereights desc,allnumbernines desc,allnumbertens desc,outsidetopten desc,seasoncount desc;";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) { 
      #printf "row is $row<br>" if $debug;
      $player=$row[0];
      $alltoptens=$row[1];
      $allnumberones=$row[2];
      $allnumbertwos=$row[3];
      $allnumberthrees=$row[4];
      $allnumberfours=$row[5];
      $allnumberfives=$row[6];
      $allnumbersixes=$row[7];
      $allnumbersevens=$row[8];
      $allnumbereights=$row[9];   
      $allnumbernines=$row[10];   
	  $allnumbertens=$row[11];   
	  $outsidetopten=$row[12];
	  $seasoncount=$row[13];

      print "<td><b>$player</b></td>
          <td><center>$seasoncount</center></td>               
		  <td><center>$alltoptens</center></td>             
          <td><center>$allnumberones</center></td>
          <td><center>$allnumbertwos</center></td>
          <td><center>$allnumberthrees</center></td>		  
          <td><center>$allnumberfours</center></td>		  
          <td><center>$allnumberfives</center></td>		  
          <td><center>$allnumbersixes</center></td>		  
          <td><center>$allnumbersevens</center></td>		  
          <td><center>$allnumbereights</center></td>		  
          <td><center>$allnumbernines</center></td>		  
          <td><center>$allnumbertens</center></td>		  
          <td><center>$outsidetopten</center></td>				  
		  </tr>";	 
   }
   print "</table><p>\n";
   &print_back_link;
   printf "</body></html>";	    
}





#--------------------------------------------------------------------------------
# Season Seed Report: dumps out the top players from each season and their seeds per tourney
# Nov 2017: this is not active; cannot get this to work.

sub season_seed_report() {
   printf "Entering Season Seed Report<br>" if $debug;

   printf "Season Seed Report for season: <b>$form{'season'}</b><p>";

   printf "List of the Tourneys in season: <b>$form{'season'}</b><p>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Event #</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event Name</b></td></tr>";

   $sql="select distinct(event),city,date,tmp_date from results where season='$form{'season'}' order by tmp_date;";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   $i=1;
   
   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
      $city=$row[1];
      $date=$row[2];
      $tmp_date=$row[3];
	  
	  push (@tourneys,"$event~$tmp_date");

      print "<tr><td>$form{'season'}</td>
          <td><center>#${i}</center></td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td></tr>";

      $i++;
   }

   print "</table>";

   print "<hr>";

   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Player</b></td>";

   $j=1;
   while ($j < $i) {
      print "<td>Event #${j}</td>";
      $j++;
   }
   print "<td><b>Season Ending Rank</b></td>";
   print "</tr>";

##   select season,rank,player from rankings where season='2014-15' and rank <=20;

   #&dump_array(@tourneys) if $debug;

  
   # distinct list of all players per season
   $sql = "select distinct winner as name from results where season='$form{'season'}'
           union 
           select distinct loser as name from results where season='$form{'season'}' order by name";
     
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) { 
      push (@players,$row);
   }

   # temporarily override all players
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
   #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
   @players=('Waselenchuk, Kane','Landa, Alejandro','Parrilla, Andree');

   $tourney_num=0;
   for $plyr (@players) {
      printf "<p><b>Working on player $plyr</b>" if $debug;   
	  
      foreach $tourneyline (@tourneys) {
	     $tourney_num++;
         ($event,$tmp_date) = split(/~/,$tourneyline);
	     #printf "$tourneyline<p>" if $debug;
	     printf "$event,$tmp_date<p>" if $debug;	  
		 
         $sql = "select seeding from seedings where event='$event' and player='$plyr';";
     
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while ($row = $sth->fetchrow_array) { 
            $seed=$row[0];
         }		

         #%tourney_matrix	 
      }
   }	  

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	    

}

#--------------------------------------------------------------------------------
# us_open only report
# 7/10/17: Linda Mojer inspired historical US Open report


sub us_open() {
   printf "Entering US Open Historical Report<br>" if $debug;

   printf "<b>US Open Historical Performance Report</b><p>";

   printf "This report is a historical presentation of individual player performance at the US Open, Racquetball's 
   marquee event since 1996.  Inspired by Linda Mojer's hand-created table used for US Open reporting.<p>";
   
   if ($form{'tour'} eq 'IRT') {
      printf "Note: its possible that we're missing early qualifying results for some players for some earlier US opens, 
	  resulting in missing events here.  I'm pretty sure Rocky played the 1997 event for example.  If you see an error, please
	  advise and I'll put in placeholder records for the player in question.<p>";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "Note: We're still building the database for some of the Ladies pro history, so some older records (especially in 
	  late 90s up to 2009) may not be complete.<p>";
   }
   else {
      # No US Open in WRT, IRF, Amateur; should never get here though since controlled via results_front.pl
      printf "Invalid Tour selected; you should never get here";
   }   
   
   printf "In this report at the moment, '1' means the winner, '2' means finalist/runner-up, '4' means semi-finalist, '8' means 
   a quarterfinalist, and then 16,32,64,128 are self-explanatory.<p>";
   
   
   # set two variables to use as flow control later on.  Seeding these variables with 2000, which guarantees logic works.
   $earliest_year=2000;
   $latest_year=2000;   
  
   # this starts the table, which we'll then scroll through in the next sql to create yearly headers
   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b># of Appearances</b></td>
          <td><b># of Titles</b></td>";

   # event names may vary slightly between databases so we do an if then else.
   # 9/25/17: moved tourney names to static variable; no more need for if then else on tour here:
   $sql="select event,date,tmp_date,year(tmp_date),season from tourneys where event in ($us_open_tourney_list) order by tmp_date desc;";
     
    
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   
   # this prints out all the years to start the table.
   while (@row = $sth->fetchrow_array) {
      $event=$row[0];
	  $year=$row[3];
	  
	  if ($year > $latest_year) {
	     $latest_year=$year;
	  }
	  
	  if ($year < $earliest_year) {
	     $earliest_year=$year;
	  }
	  
	  push (@usopens,"$event~$year");
      printf "<td><b>$year</b></td>";
   }
   
   # finish off the header row
   printf "</tr>";
   
   # we use this at the end to print out the rows.
   $numofusopens=@usopens;
   
   printf "Earliest year is now $earliest_year, Latest year is now $latest_year" if $debug;
   
   #&dump_array(@usopens) if $debug;
   
   # now lets run through the events one by one
   for $eventrow (@usopens) {
      ($event,$year) = split(/~/,$eventrow);
   
   # first push the winners of each event to the results array
	  $sql="select winner from results where round=2 and event='$event'";
	  printf "$sql<br>" if $debug;
	  $sth = $dbh->prepare($sql);
	  $sth->execute;
	  while (@row = $sth->fetchrow_array) {
	     $player=$row[0];
	     $usopenresult="$player~$year~1";
         push (@usopenresults,$usopenresult);
	  } 
	  
	  # now get all the non-winners per each event and push to the array   
	  $sql="select loser,round from results where event='$event'";
	  printf "$sql<br>" if $debug;
	  $sth = $dbh->prepare($sql);
	  $sth->execute;
	  while (@row = $sth->fetchrow_array) {
	     $player=$row[0];
	     $round=$row[1];		 
	     $usopenresult="$player~$year~$round";
         push (@usopenresults,$usopenresult);
	  } 	  
   }   
   

   # Sort the array: since the player name is first, this sorts it alphabetically. 
   @usopenresults=sort(@usopenresults);  

   #&dump_array(@usopenresults) if $debug;
   
   # set some variables to use in the next loop.  
   $i=1;
   $current_player='';
   $num_appearances=0;
   $num_titles=0;
   
   for $usopenresult (@usopenresults) {
      ($player,$year,$round) = split(/~/,$usopenresult);

	  # skipping unknown results
	  next if ($player eq '?');
	  
	  # skipping non significant rounds for testing.
	  # next if ($round > 16);
	  
	  #printf "inside for loop $player $year $round<br>" if $debug;
	  
	  # first time through loop, set the current_player variable; we only do this once.
	  if ($i eq 1) {
	     printf "entering onetime loop<br>" if $debug;
	     $current_player=$player;
		 $i++;
      }
	  
	  if ($player eq $current_player) {
	     # create matrix array for this player by year.
	     $matrix{$year}="$round";
		 $num_appearances++;
		 
		 if ($round eq "1") {
            $num_titles++;		 
		 }
	  }
	  else {
	     # player has changed; lets create full line for the former player
		 
		 $player_usopen_string="$current_player~$num_appearances~$num_titles";
         
		 for ($tmp_year=$latest_year; $tmp_year >= $earliest_year; $tmp_year--) {
		    $player_usopen_string = $player_usopen_string . "~$matrix{$tmp_year}";
		 }
		 
		 #printf "player string is $player_usopen_string<br>" if $debug;
		 
		 push (@master_usopen_string,$player_usopen_string);
		 
		 # print the table row for the player
		 #printf "<tr>
		 #        <td><b>$current_player</b></td>
		 #		 <td><b><center>$num_appearances</center></b></td>
         #        <td><b><center>$num_titles</center></b></td>";
         #for ($tmp_year=$latest_year; $tmp_year >= $earliest_year; $tmp_year--) {
		 #   print "<td><center>$matrix{$tmp_year}</center></td>";	
         #}	
         #printf "</tr>";

		 # set the current player to the new player to reset.  Clean up the matrix variable and other variables		 
		 for ($tmp_year=$latest_year; $tmp_year >= $earliest_year; $tmp_year--) {
		    undef $matrix{$tmp_year};

	        #store the first result for the new player.
	        $matrix{$year}="$round";
		 }	
		 
		 # New player means we reset the appearances.	 
		 $num_appearances=1;
		 # reset number of titles with the new player.
		 $num_titles=0;		
		 
		 # catch scenario where first event is a title for this new player...
		 if ($round eq "1") {
            $num_titles++;		 
		 }
		 
         # last cleanup; setting current player to loop player variable for next iteration.
	     $current_player=$player;
	  }
   }
   
   # The final player alphabetically in the array won't push via the above logic; push here.
   
   $player_usopen_string="$current_player~$num_appearances~$num_titles";
   for ($tmp_year=$latest_year; $tmp_year >= $earliest_year; $tmp_year--) {
      $player_usopen_string = $player_usopen_string . "~$matrix{$tmp_year}";
   }   
   printf "last player string is now $player_usopen_string<br>" if $debug;  
   
   push (@master_usopen_string,$player_usopen_string);
   
   # The final player alphabetically in the array won't print via the above logic; we print them out here:
   #printf "<tr>
   #	   <td><b>$current_player</b></td>
   #		   <td><b><center>$num_appearances</center></b></td>
   #        <td><b><center>$num_titles</center></b></td>";
   #for ($tmp_year=$latest_year; $tmp_year >= $earliest_year; $tmp_year--) {
   #   print "<td><center>$matrix{$tmp_year}</center></td>";	
   #}	
   #printf "</tr>";	 
   
   #printf "test text after the table.  <p>";

   #&dump_array(@master_usopen_string) if $debug;   
   
   # Sort the possibles by the # of appearances
   $sort_field=1;
   @master_usopen_string=&schwartzian_sort($sort_field,\@master_usopen_string);

   # Sort sorts ascending.  we want descending, from most to least appearances.
   @master_usopen_string=&reverse_array(@master_usopen_string);   

   #&dump_array(@master_usopen_string) if $debug;   
   
   for $master_usopen_string (@master_usopen_string) {
      @tmp_master_usopen_string = split(/~/,$master_usopen_string);
	  $numrecords=@tmp_master_usopen_string;
	  
	  $player=$tmp_master_usopen_string[0];
	  $num_appearances=$tmp_master_usopen_string[1];
	  $num_titles=$tmp_master_usopen_string[2];
	  
      printf "<tr>
   	      <td><b>$player</b></td>
   		  <td><b><center>$num_appearances</center></b></td>
          <td><b><center>$num_titles</center></b></td>";
      #for ($i=3; $i < $numrecords; $i++) {
      for ($i=3; $i < ($numofusopens+3); $i++) {	  
	     #if ($tmp_master_usopen_string[$i] eq '') {
		 #   $tmp_master_usopen_string[$i]=' ';
		 #}
         print "<td><center>$tmp_master_usopen_string[$i]</center></td>";	
      }	
      printf "</tr>";	 	  
	  
   }
   
   printf "</table>";
   &print_back_link;
   printf "</body></html>";	    
}

#--------------------------------------------------------------------------------
# draw Size report per event
# 9/7/17: putting in draw sizes since i'm constantly looking this information up.
# 


sub draw_size_per_event() {
   printf "Entering Draw Size per Event Report<br>" if $debug;

   printf "<b>Draw Size Per event Report.</b><p>";
   
   if ($form{'event'} eq "0") {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
	  next;
   }

   printf "This report simply reports the number of entrants to the tournament.<p>";
  
   # this starts the table, which we'll then scroll through in the next sql to create yearly headers
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Tour</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Number of Entrants</b></td>
          <td><b>Winner</b></td></tr>";

   ($event,$date)=split(/~/,$form{'event'});

   $sql = "select tour,city,date,source,season,winner from results where event='$event' and round='2' and date='$date'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $tour=$row[0];
      $city=$row[1];
      $date=$row[2];
      $source=$row[3];
      $season=$row[4];
      $winner=$row[5];
   }

   $sql = "select count(*) from results where event='$event' and date='$date'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $entry_count=$row[0];
   }

   # number of results for a tourney is n, entrants is n+1 so increment the count
   $entry_count++;

   print "<td>$season</td>
          <td>$tour</td>
          <td>$date</td>
          <td>$city</td>
          <td>$event</td>
          <td><center>$entry_count</center></td>
          <td>$winner</td></tr>";

   print "</table>\n";
   &print_back_link;
   printf "</body></html>";	    
}

#--------------------------------------------------------------------------------
# draw Size report for the season
# 9/7/17: putting in draw sizes since i'm constantly looking this information up.
# 10/28/17: overloading this for draw_size per category for Amateurs
# 11/2/17: putting in categories for IRF


sub draw_size_per_season() {
   printf "Entering Draw Size per Event per Season Report<br>" if $debug;

   if ($form{'query'} eq 'draw_size_per_category') {
      printf "<b>Draw Size Per event for Category $form{'category'}</b><p>";
      printf "This report reports the number of entrants to all the tourneys per category throughout history.<p>";
   }
   else {
      printf "<b>Draw Size Per event per Season Report.</b><p>";
      printf "This report reports the number of entrants to all the tourneys per season.<p>";
   }

  
   # this starts the table, which we'll then scroll through in the next sql to create yearly headers
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Tour</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Number of Entrants</b></td>
          <td><b>Winner</b></td></tr>";

   if ($form{'query'} eq 'draw_size_per_category') {
      if ($form{'category'} eq 'USA Mens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Mens%'"; }
      elsif ($form{'category'} eq 'USA Womens Open') { $clause="(city not like '%MEX' and city not like '%CAN') and event like '%- Womens%'"; }
      elsif ($form{'category'} eq 'Mexico Mens Open') { $clause="city like '%MEX' and event like '%- Mens%'"; }   
      elsif ($form{'category'} eq 'Mexico Womens Open') { $clause="city like '%MEX' and event like '%- Womens%'"; }
      elsif ($form{'category'} eq 'Canada Mens Open') { $clause="city like '%CAN' and event like '%- Mens%'"; }
      elsif ($form{'category'} eq 'Canada Womens Open') { $clause="city like '%CAN' and event like '%- Womens%'"; }  
	  # 11/17/17 added more Amateur categories
      elsif ($form{'category'} eq 'USA All') { $clause="(city not like '%MEX' and city not like '%CAN')"; } 
      elsif ($form{'category'} eq 'Mexico All') { $clause="city like '%MEX'"; } 
      elsif ($form{'category'} eq 'Canada All') { $clause="city like '%CAN'"; } 
      elsif ($form{'category'} eq 'All Men') { $clause="event like '%- Mens%'"; } 
      elsif ($form{'category'} eq 'All Women') { $clause="event like '%- Womens%'"; } 	
	  
      # 11/2/17; put in IRF categories	  
      elsif ($form{'category'} eq 'IRF All Men') { $clause="event like '% - Mens Open%'"; } 
      elsif ($form{'category'} eq 'IRF All Women') { $clause="event like '% - Womens Open%'"; }       
	  elsif ($form{'category'} eq 'Pan American Championships - Mens Open') { $clause="(event like '%Pan American Championships%' 
	                                                                                   or event like '%Pan American Racquetball Championships%')
																					   and event like '% - Mens Open%'"; } 	  
      elsif ($form{'category'} eq 'Pan American Championships - Womens Open') { $clause="(event like '%Pan American Championships%' 
	                                                                                   or event like '%Pan American Racquetball Championships%')
																					   and event like '% - Womens Open%'"; } 	  																					   
      elsif ($form{'category'} eq 'World Championships - Mens Open') { $clause="(event like '%World Championships%' 
	                                                                           or event like '%World Racquetball Championship%')
																			   and event like '% - Mens Open%'"; }         
      elsif ($form{'category'} eq 'World Championships - Womens Open') { $clause="(event like '%World Championships%' 
	                                                                           or event like '%World Racquetball Championship%')
																			   and event like '% - Womens Open%'"; }      
      elsif ($form{'category'} eq 'Pan American Games - Mens Open') { $clause="(event like '%Pan American Games%')
																			   and event like '% - Mens Open%'"; }   
      elsif ($form{'category'} eq 'Pan American Games - Womens Open') { $clause="(event like '%Pan American Games%')
																			   and event like '% - Womens Open%'"; }   																			   
      elsif ($form{'category'} eq 'Pan American Sports Festival - Mens Open') { $clause="(event like '%Pan American Sports Festival%')
																			   and event like '% - Mens Open%'"; }   
      elsif ($form{'category'} eq 'Pan American Sports Festival - Womens Open') { $clause="(event like '%Pan American Sports Festival%')
																			   and event like '% - Womens Open%'"; }  	  

																			   
      # 11/15/17: put in Junior categories
      # Note the use of "Canad" instead of Canada or Canadian
      elsif ($form{'category'} eq 'All Boys 18U') { $clause="event like '%- Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'All Boys 16U') { $clause="event like '%- Boys 16U%'"; } 	
      elsif ($form{'category'} eq 'All Girls 18U') { $clause="event like '%- Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'All Girls 16U') { $clause="event like '%- Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'All IRF') { $clause="event like '%World%'"; } 	
      elsif ($form{'category'} eq 'All USA') { $clause="event like '%USA%'"; } 	
      elsif ($form{'category'} eq 'All Mexico') { $clause="event like '%Mexico%'"; } 	
      elsif ($form{'category'} eq 'All Canada') { $clause="event like '%Canad%'"; } 	
      elsif ($form{'category'} eq 'All IRF Boys') { $clause="(event like '%World%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All USA Boys') { $clause="(event like '%USA%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All Mexico Boys') { $clause="(event like '%Mexico%' and event like '%Boys%')"; } 	
      elsif ($form{'category'} eq 'All Canada Boys') { $clause="(event like '%Canad%' and event like '%Boys%')"; } 
      elsif ($form{'category'} eq 'All IRF Girls') { $clause="(event like '%World%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All USA Girls') { $clause="(event like '%USA%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All Mexico Girls') { $clause="(event like '%Mexico%' and event like '%Girls%')"; } 	
      elsif ($form{'category'} eq 'All Canada Girls') { $clause="(event like '%Canad%' and event like '%Girls%')"; } 
      elsif ($form{'category'} eq 'IRF Boys 18U') { $clause="event like '%Junior World Championships - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'IRF Boys 16U') { $clause="event like '%Junior World Championships - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'IRF Girls 18U') { $clause="event like '%Junior World Championships - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'IRF Girls 16U') { $clause="event like '%Junior World Championships - Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'USA Boys 18U') { $clause="event like '%USA Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'USA Boys 16U') { $clause="event like '%USA Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'USA Girls 18U') { $clause="event like '%USA Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'USA Girls 16U') { $clause="event like '%USA Junior Nationals - Girls 16U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Boys 18U') { $clause="event like '%Mexico Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Boys 16U') { $clause="event like '%Mexico Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'Mexico Girls 18U') { $clause="event like '%Mexico Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'Mexico Girls 16U') { $clause="event like '%Mexico Junior Nationals - Girls 16U%'"; } 	  
      elsif ($form{'category'} eq 'Canada Boys 18U') { $clause="event like '%Canada Junior Nationals - Boys 18U%'"; } 	
      elsif ($form{'category'} eq 'Canada Boys 16U') { $clause="event like '%Canada Junior Nationals - Boys 16U%'"; } 		
      elsif ($form{'category'} eq 'Canada Girls 18U') { $clause="event like '%Canada Junior Nationals - Girls 18U%'"; } 	
      elsif ($form{'category'} eq 'Canada Girls 16U') { $clause="event like '%Canada Junior Nationals - Girls 16U%'"; } 																		   
																			   
      else {
         printf "Invalid form category passed $form{'category'}<P>";
      }

      $sql = "select tour,city,date,event,season,winner from results where round=2 and $clause order by tmp_date desc, event asc";
   } 
   else {
      $sql = "select tour,city,date,event,season,winner from results where season='$form{'season'}' and round=2 order by tmp_date";
   }


   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $tour=$row[0];
      $city=$row[1];
      $date=$row[2];
      $event=$row[3];
      $season=$row[4];
      $winner=$row[5];
   
      $sql2 = "select count(*) from results where event='$event' and date='$date'";
      printf "$sql2" if $debug;
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $entry_count=$row2[0];
      }

      # number of results for a tourney is n, entrants is n+1 so increment the count
      $entry_count++;

      print "<td>$season</td>
             <td>$tour</td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td><center>$entry_count</center></td>
             <td>$winner</td></tr>";
   }
   print "</table>\n";
   &print_back_link;
   printf "</body></html>";	    
}



#--------------------------------------------------------------------------------
# draw Size report for all US Opens
# 9/24/17: putting this in to show the Draw sizes of the US Open over time.
# 


sub us_open_drawsizes() {
   printf "Entering Draw Size for US Opens Report<br>" if $debug;

   printf "<b>Draw Size for all US Opens Report.</b><p>";

   printf "This report reports the number of entrants to Racquetball's marquee event from 1996-present<p>";

   if ($form{'tour'} eq 'IRT') {
      printf "The IRT draw numbers are only fully accurate from 2004 onward; from 1996-2003 I generally only captured those who qualified into the main draw.  In 1999 we barely got the full 16s, let alone the full 64 draw with qualifiers.  I was able to find the full 1998 event, with qualifiers.<p>";
   }
   elsif ($form{'tour'} eq 'LPRT') {
      printf "The LPRT draw numbers are fully accurate from about 2006 onwards; prior to that it is hit or miss.  We're working on populating the tourneys from the 1990s and will seek to improve where we're missing major parts of the tourneys<p>";
   }
   else {
      printf "Invalid Tour selected; you should never get here";
   }
  
   # this starts the table, which we'll then scroll through in the next sql to create yearly headers
   print "<table border><tr>\n";
   print "<td><b>Season</b></td>
          <td><b>Tour</b></td>
          <td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Number of Entrants</b></td>
          <td><b>Winner</b></td></tr>";


#   $sql = "select tour,city,date,source,season,winner from results where event='$event' and round='2' and date='$date'";


   # event names may vary slightly between databases so we do an if then else.
   
   # 9/25/17: moved tourney names to static variable; no more need for if then else on tour here:
   $sql="select season,date,city,event,winner from results where round='2' and event in ($us_open_tourney_list) order by tmp_date desc;";

   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $season=$row[0];
      $date=$row[1];
      $city=$row[2];
      $event=$row[3];
      $winner=$row[4];
   
      $sql2 = "select count(*) from results where event='$event' and date='$date'";
      printf "$sql2" if $debug;
      $sth2 = $dbh->prepare($sql2);
      $sth2->execute;

      while (@row2 = $sth2->fetchrow_array) {
         $entry_count=$row2[0];
      }

      # number of results for a tourney is n, entrants is n+1 so increment the count
      $entry_count++;

      print "<td>$season</td>
             <td><center>$form{'tour'}</center></td>
             <td>$date</td>
             <td>$city</td>
             <td>$event</td>
             <td><center>$entry_count</center></td>
             <td>$winner</td></tr>";
   }
   print "</table>\n";   
   &print_back_link;
   printf "</body></html>";	    
}


#--------------------------------------------------------------------------------
# 9/24/17:  QSF summary for all US Open, adapted from Tourney Summary report
# 

sub us_open_qsf() {

   printf "Entering quarters/semis/final by for all US Opens \n" if $debug;

   printf "<b>Tourney Summary including Q/S/F for all US Opens</b><p>";

   print "<table border><tr>\n";
   print "<td><b>Date</b></td>
          <td><b>City</b></td>
          <td><b>Event</b></td>
          <td><b>Final</b></td>
          <td><b>Semis</b></td>
          <td><b>Quarters</b></td>
          </tr>\n";

   # event names may vary slightly between databases so we do an if then else.
   # 9/25/17: moved tourney names to static variable; no more need for if then else on tour here:
   $sql="select winner,loser,score,city,event,date from results where round='2' and event in  ($us_open_tourney_list) order by tmp_date desc;";
   
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $winner=$row[0];
      $loser=$row[1];
      $score=$row[2];
      $city=$row[3];
      $event=$row[4];
      $date=$row[5];
	  
	  # keeping track of number of wins/losses
	  $winner_matrix{$winner}++;
	  $finalist_matrix{$loser}++;

      ($wlname,$wfname)=split(/,/,$winner);
      ($llname,$lfname)=split(/,/,$loser);

      # must trim leading spaces from the first names in order to get the first initial
      $wfname =~ s/^\s+//;
      $wfname =~ s/\s+$//;
      $lfname =~ s/^\s+//;
      $lfname =~ s/\s+$//;

      $firstinitwinner=substr($wfname,0,1);
      $firstinitloser=substr($lfname,0,1);
      
# Only printing first initial for Rojas, Carson; can add in other names later as needed
      if ($wlname =~ /$dup_last_names/) {
         $wlname="${firstinitwinner}.${wlname}";
      }
      if ($llname =~ /$dup_last_names/) {
         $llname="${firstinitloser}.${llname}";
      }

      printf "winner first name is $wfname, loser first name is $lfname <br>" if $debug;      
      printf "winner first init is $firstinitwinner , loser first init is $firstinitloser <br>" if $debug;      
 
# now this sql will print the first init/last name for Carson and Rojas but just last name for others.
      print "<td>$date</td>
       <td>$city</td>
       <td>$event</td>
       <td>${wlname} d ${llname} $score</td>";


      $sql = "select loser from results \
              where round='4' and city='$city' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($slname,$slfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $slfname=~ s/^\s+//;
          $slfname =~ s/\s+$//;
          $sfirstinit = substr($slfname, 0, 1);
	      $semis_matrix{$row2[0]}++;		  

# Only printing first initial for Rojas, Carson; can add in other names later as needed
          if ($slname =~ /$dup_last_names/) {
            $slname="${sfirstinit}.${slname}";
          }

          print "${slname}";
          print ", " if $i==0;
          $i++;
      }
      print "</td>";


      $sql = "select loser from results \
              where round='8' and city='$city' and date='$date'";
      printf "$sql" if $debug;
      $sth2 = $dbh->prepare($sql);
      $sth2->execute;

      $i=0;
      print "<td>";
      while (@row2 = $sth2->fetchrow_array) {
          ($qlname,$qlfname)=split(/,/,$row2[0]);
          # must trim leading spaces from the first names in order to get the first initial
          $qlfname=~ s/^\s+//;
          $qlfname =~ s/\s+$//;
          $qfirstinit = substr($qlfname, 0, 1);
		  $qtrs_matrix{$row2[0]}++;	

# Only printing first initial for Rojas, Carson; can add in other names later as needed
          if ($qlname =~ /$dup_last_names/) {
            $qlname="${qfirstinit}.${qlname}";
          }

          print "${qlname}";
          print ", " if $i<3;
          $i++;
      }
      print "</td></tr>";
         
   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
   
# ---------------------------------------------------------------------------------------
# prints simplistic tables of winners, semis, qtrs. Replacing with season_summary_us_open
#   print "List of all time winners, Semis, Quarterfinalists alphabetically<p>";
#
#   print "<table border><tr>\n";
#   print "<td><b>Player</b></td>
#          <td><b>US Open Winners</b></td>
#          </tr>\n";
#   
#   foreach $key ( sort keys %winner_matrix ) {
#      print "$key=$winner_matrix{$key}<br>" if $debug;
#	  
#      print "<td>$key</td>
#             <td><center>$winner_matrix{$key}</center></tr>";	  
#   }
#   print "</table>\n";
#   
#   print "<table border><tr>\n";
#   print "<td><b>Player</b></td>
#          <td><b>US Open Finalists</b></td>
#          </tr>\n";
#   
#   foreach $key ( sort keys %finalist_matrix ) {
#      print "$key=$finalist_matrix{$key}<br>" if $debug;
#	  
#      print "<td>$key</td>
#             <td><center>$finalist_matrix{$key}</center></tr>";	  
#   }
#   print "</table>\n";
#
#   print "<table border><tr>\n";
#   print "<td><b>Player</b></td>
#          <td><b>US Open Semi Finalists</b></td>
#          </tr>\n";
#   
#   foreach $key ( sort keys %semis_matrix ) {
#      print "$key=$semis_matrix{$key}<br>" if $debug;
#
#      print "<td>$key</td>
#             <td><center>$semis_matrix{$key}</center></tr>";	  
#   }
#   print "</table>\n";
#
#   print "<table border><tr>\n";
#   print "<td><b>Player</b></td>
#          <td><b>US Open Quarter Finalists</b></td>
#          </tr>\n";
#   
#   foreach $key ( sort keys %qtrs_matrix ) {
#      print "$key=$qtrs_matrix{$key}<br>" if $debug;
#	  
#      print "<td>$key</td>
#             <td><center>$qtrs_matrix{$key}</center></tr>";	  
#   }
#   print "</table>\n";

   # why is this here?
   #&season_summary_us_open;
   
}


#--------------------------------------------------------------------------------
# 9/25/17: creating season_summary for just US Opens; adapted from season_summary_allplayers() 
# 

sub season_summary_us_open() {

   printf "Entering season_summary_us_open \n" if $debug;

   printf "<p><b>US Open Finish Summaries for all players for all US Opens, 1996-present</b><p>";
   printf "<p>This table sorts by Wins, then Finals made, then Semis, etc.  <p>";

   print "<table border><tr>\n";
   print "<td><b>Player</b></td>
          <td><b>US Open<br> Wins</b></td>
          <td><b>US Open<br> Finals</b></td>
          <td><b>US Open<br> Semis</b></td>
          <td><b>US Open<br> Qtrs</b></td>
          <td><b>US Open<br> 16s</b></td>
          <td><b>US Open<br> 32s</b></td>
          <td><b>US Open<br> 64s</b></td>
          <td><b>US Open<br> 128s</b></td>
          <td><b>US Open<br> 256s</b></td> 
          <td><b>US Open<br> Missed</b></td> 
         </tr>\n";

   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;

   # How many events in the season?  We'll use this later on to determine the number of missed events per player
   $sql="select count(distinct(event)) from results where event in ($us_open_tourney_list)";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      $num_events=$row;
   }

   # distinct list of all players per season

   $sql = "select distinct winner as name from results where event in ($us_open_tourney_list)
           union 
           select distinct loser as name from results where event in ($us_open_tourney_list) order by name";
     
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) { 
      push (@players,$row);
   }

   # temporarily override all players
   #@players=('Swain, Cliff','Hogan, Marty','Williams, Mitch','Beltran, Alvaro');
   #@players=('Carson, Rocky','Swain, Cliff','Williams, Mitch','Beltran, Alvaro','Alder,D');
   #@players=('Beltran, Alvaro','Swain, Cliff');

   for $plyr (@players) {

      printf "<p><b>Working on player $plyr</b>" if $debug;

# we've never had a round of 512 ...
      my $twofiftysixes=0;
      my $onetwentyeights=0;
      my $sixtyfours=0;
      my $thirtytwos=0;
      my $sixteens=0;
      my $quarters=0;
      my $semis=0;
      my $finals=0;
      my $wins=0;
      my $player=0;
      my $season=0;

      next if ($plyr =~ /\?/);
	  
	  
      # copied logic from &gen_perseason_summary here manually, changed to read from US Open listof events instaed of seasons

      my $total_results=0;
      my $num_events=0;

      $sql="select event, min(round) from results where \
            (winner='$plyr' or loser='$plyr') \
            and event in ($us_open_tourney_list) group by event";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         ($event,$round)=($row[0],$row[1]);

         printf "$event and $round<br>" if $debug;

         if ($round eq "256") {
            $twofiftysixes++;
         }
         elsif ($round eq "128") {
            $onetwentyeights++;
         }
         elsif ($round eq "64") {
            $sixtyfours++;
         }
         elsif ($round eq "32") {
            $thirtytwos++;
         }
         elsif ($round eq "16") {
            $sixteens++;
         }
         elsif ($round eq "8") {
            $quarters++;
         }
         elsif ($round eq "4") {
            $semis++;
         }
         elsif ($round eq "2") {
            $sql2="select winner from results where event='$event' and round=2";
            printf "$sql2<br>" if $debug;
            $sth2 = $dbh->prepare($sql2);
            $sth2->execute;
            while (@row2 = $sth2->fetchrow_array) {
               $winner=$row2[0];
            }
            if ($winner eq "$plyr") {
               $wins++;
            }
            else {
               $finals++;
            }
         }
         else {
            printf "Invalid round in database; you should never see this";
         }

         $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;

         $others=$num_events-$total_results;

         #$results_summary="$wins Wins, $finals Finals, $semis Semis, $quarters Quarters, $sixteens 16s, "; 
         #if ($thirtytwos > 0) { $results_summary = $results_summary . "$thirtytwos 32s, "; }
         #if ($sixtyfours > 0) { $results_summary = $results_summary . "$sixtyfours 64s, "; }
         #if ($onetwentyeights > 0) { $results_summary = $results_summary . "$onetwentyeights 128s, "; }
         #$results_summary = $results_summary . "($others/$num_events Missed Tourneys)";

         next if ($others eq $num_events);

      }

      printf "\nreturning $plyr,$season,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes\n" if $debug;

      # 5/27/08: trying temp table to sort results instead of perl
      $sql = "insert into season_summary_rpt values ('$plyr',$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes)";
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
   }
	  
   # 5/27/08: trying temp table to sort results instead of perl
   $sql = "select player,wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes from season_summary_rpt order by wins,finals,semis,quarters,sixteens,thirtytwos,sixtyfours,onetwentyeights,twofiftysixes";
   printf "<br>$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) { 
      #printf "row is $row<br>" if $debug;
      $myplayer=$row[0];
      $mywinscity=$row[1];
      $myfinals=$row[2];
      $mysemis=$row[3];
      $myquarters=$row[4];
      $mysixteens=$row[5];
      $mythirtytwos=$row[6];
      $mysixtyfours=$row[7];
      $myonetwentyeights=$row[8];
      $mytwofiftysixes=$row[9];

      #push (@allsummariesdb,@row);
      push (@allsummariesdb,"$myplayer~$mywinscity~$myfinals~$mysemis~$myquarters~$mysixteens~$mythirtytwos~$mysixtyfours~$myonetwentyeights~$mytwofiftysixes");
   }

   printf "<p>" if $debug;
   &dump_array(@allsummariesdb) if $debug;

# now, sort the allsummaries array by total wins...

   # Sort the possibles by the score of the longest game.
   #$sort_field=1;
   #@allsummaries=&schwartzian_sort($sort_field,\@allsummaries);

   # Results come from DB in reverse order; this fixes that.
   @allsummariesdb=&reverse_array(@allsummariesdb);


# now print out the allsummaries
   foreach $playersummary (@allsummariesdb) {
      #printf "$match<br>";   
      ($player,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes) = split(/~/,$playersummary);

      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
      $missed=$num_events-$total_results;
     
      print "<td>$player</td>
          <td align=center>$wins</td>
          <td align=center>$finals</td>
          <td align=center>$semis</td>
          <td align=center>$quarters</td>
          <td align=center>$sixteens</td>
          <td align=center>$thirtytwos</td>
          <td align=center>$sixtyfours</td>
          <td align=center>$onetwentyeights</td>
          <td align=center>$twofiftysixes</td>
          <td align=center>$missed</td>
          </tr>";

   }

   # 5/27/08: cleanup holding table at end
   $sql = "delete from season_summary_rpt";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   
   printf "</table>";
   &print_back_link;
   printf "</body></html>";	    

}


#--------------------------------------------------------------------------------
# 10/11/17: First IRF query; All Singles
# 

sub irf_all_singles_matches_per_event() {

   ($year,$event)=split(/~/,$form{'sum_event'});
   
   printf "Entering irf_all_singles_matches_per_event\n" if $debug;
   
   printf "<b>Singles Results Summary for the $year $event</b>";

   printf "<p>This query lists 1st, 2nd and 3rd  place finishers in Singles for the event.  Where there are two 3rd place finishers listed, 
   joint 3rd place was awarded to both semifinalists.  This query does not promise to preserve which semi-finalist lost to which finalist nor
   does it imply that the '3rd place #1' necessarily defeated the '3rd place #2' player in a 3rd place match.  Please
   see the draw sheets and/or the IRF Match database for specific match results for the event.";
   
   printf "<p>If a 2nd or 3rd place finisher is missing, then the draw size was probably not large enough to declare anything other than a winner.  
   If the entire age group is missing for a tournament, odds are that no one entered it that year.<p>";   

   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Location</b></td>
          <td><b>Gender</b></td>
          <td><b>Division</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist</b></td>
          <td><b>Semifinalist 1/<br>Third Place</b></td>
		  <td><b>Semifinalist 2/<br>Third Place</b></td>
         </tr>\n";
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, \
      Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, \
      Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, \
	  third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg, location\
      from irf_main where year='$year' and tournament_name='$event' and division_flag='S' \
      order by ifnull(age_bracket,'Open'), gender_combined_flg;";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $agebracket=$row[0];
      $firstplacefirstname=$row[1];
      $firstplacelastname=$row[2];
      $firstplacecountry=$row[3];
      $secondplacefirstname=$row[4];
      $secondplacelastname=$row[5];
      $secondplacecountry=$row[6];
      $thirdplacefirstname=$row[7];
      $thirdplacelastname=$row[8];
      $thirdplacecountry=$row[9];
      $thirdplacefirstname2=$row[10];
      $thirdplacelastname2=$row[11];
      $thirdplacecountry2=$row[12];
	  $gender=$row[13];
	  $location=$row[14];	  
	  
	  &dump_array(@row) if $debug;
	  
	  printf "The agebracket string received is exactly ~~${agebracket}~~<p>" if $debug;
	  
      if ($agebracket eq '') {
	     print "agebracket is empty, assigning to Open<p>" if $debug;
         $agebracket='Open';
      }
	  
      if ($agebracket eq 'U18' || $agebracket eq 'U16' || $agebracket eq 'U14' || $agebracket eq 'U12' || $agebracket eq 'U10' || $agebracket eq 'U8') {
	     print "agebracket is $agebracket, moving on<p>" if $debug;
	     if ($gender eq 'M') {
		    $gender='Boy\'s';
		 }	
	     elsif ($gender eq 'W') {
		    $gender='Girl\'s';
		 }	

		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Received $gender.<p>";
		 }
	  }	 
	  elsif ($agebracket eq 'Open') {
	     print "agebracket is $agebracket, entering Open logic<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }
	  } 
	  else {
	     # this should be all other age brackets.
		 printf "agebracket is not a Uxx nor Open; it is $agebracket<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }		 
	  }
	  
	  # quick logic to prevent just a comma being printed by itself
	  
	  $firstplacestring="$firstplacefirstname $firstplacelastname, $firstplacecountry";
	  $secondplacestring="$secondplacefirstname $secondplacelastname, $secondplacecountry";
	  $thirdplacestring1="$thirdplacefirstname $thirdplacelastname, $thirdplacecountry";
	  $thirdplacestring2="$thirdplacefirstname2 $thirdplacelastname2, $thirdplacecountry2";
	  
	  if ($firstplacestring eq ' , ') {
	     $firstplacestring ='';
      }
	  if ($secondplacestring eq ' , ') {
	     $secondplacestring ='';
      }
	  if ($thirdplacestring1 eq ' , ') {
	     $thirdplacestring1 ='';
      }
	  if ($thirdplacestring2 eq ' , ') {
	     $thirdplacestring2 ='';
      }	  
      print "<td>$year</td>
          <td>$event</td>
		   <td>$location</td>
          <td><center>$gender</center></td>		  
		  <td><center>$agebracket</center></td>
          <td>$firstplacestring</td>
          <td>$secondplacestring</td>
		  <td>$thirdplacestring1</td>
		  <td>$thirdplacestring2</td>		  
         </tr>\n";	   

      undef $agebracket;
   }
   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}


#--------------------------------------------------------------------------------
# 10/14/17: First IRF query; All Singles per category of tournanent, not just event
# 10/19/17: changed if then else to use variable and have standardized sql.

sub irf_all_singles_matches_main() {

   printf "Entering irf_all_singles_matches_main, processing specificially $form{'query'}\n" if $debug;

   ($category)=split(/~/,$form{'category'});
   ($division)=split(/~/,$form{'division'});

   if ($form{'query'} eq 'irf_all_singles_matches_per_category') {	 
      $where_clause=" where tournament_name= '$category' and division_flag='S' ";
   }     
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mensopen') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket is null and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womensopen') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket is null and gender_combined_flg='W' ";
   }   

   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens30') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='30+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens30') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='30+' and gender_combined_flg='W' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens35') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='35+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens35') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='35+' and gender_combined_flg='W' ";
   }     
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens40') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='40+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens40') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='40+' and gender_combined_flg='W' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens45') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='45+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens45') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='45+' and gender_combined_flg='W' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens50') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='50+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens50') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='50+' and gender_combined_flg='W' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens55') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='55+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens55') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='55+' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens60') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='60+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens60') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='60+' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens65') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='65+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens65') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='65+' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens70') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='70+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens70') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='70+' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens75') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='75+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens75') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='75+' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens80') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='80+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens80') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='80+' and gender_combined_flg='W' ";
   }       
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens85') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='85+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens85') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='85+' and gender_combined_flg='W' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_mens90') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='90+' and gender_combined_flg='M' ";
   }   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_womens90') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='90+' and gender_combined_flg='W' ";
   }   

   
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys18u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U18' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls18u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U18' and gender_combined_flg='W' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys16u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U16' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls16u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U16' and gender_combined_flg='W' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys14u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U14' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls14u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U14' and gender_combined_flg='W' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys12u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U12' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls12u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U12' and gender_combined_flg='W' ";
   }     
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys10u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U10' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls10u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U10' and gender_combined_flg='W' ";
   }        
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys8u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U8' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls8u') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U8' and gender_combined_flg='W' ";
   } 
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys8umb') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U8 Mb' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls8umb') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U8 Mb' and gender_combined_flg='W' ";
   }    
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_boys6umb') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U6 Mb' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_category_girls6umb') {
      $where_clause=" where tournament_name= '$category' and division_flag='S' 
         and age_bracket='U6 Mb' and gender_combined_flg='W' ";
   }    
   
   if ($form{'query'} eq 'irf_all_singles_matches_per_division_male') {
      $where_clause=" where division_flag='S' 
         and ifnull(age_bracket,'Open')='$division' and gender_combined_flg='M' ";
   }  
   if ($form{'query'} eq 'irf_all_singles_matches_per_division_female') {
      $where_clause=" where division_flag='S' 
         and ifnull(age_bracket,'Open')='$division' and gender_combined_flg='W' ";
   }  
   
   # master SQL using above logic populated where clause variable.
   # this sorts by Open then age groups, and by Gender    
   $sql="select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, \
         Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, \
         Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, \
   	     third_place_first_name_2, third_place_last_name_2, third_place_country_21, \
         gender_combined_flg, year, tournament_name , location
         from irf_main $where_clause
         order by year desc, ifnull(age_bracket,'Open'), gender_combined_flg;";
   

   
   printf "<b>Singles Results Summary throughout IRF history</b>";

   printf "<p>This query lists 1st, 2nd and 3rd place finishers in Singles per the Category or division selected.  Where there are two 3rd place finishers listed, 
   joint 3rd place was awarded to both semifinalists.  This query does not promise to preserve which semi-finalist lost to which finalist nor
   does it imply that the '3rd place #1' necessarily defeated the '3rd place #2' player in a 3rd place match.  Please
   see the draw sheets and/or the IRF Match database for specific match results for the events.";
   
   printf "<p>If a 2nd or 3rd place finisher is missing, then the draw size was probably not large enough to declare anything other than a winner.  
   If the entire age group is missing for a tournament, odds are that no one entered it that year.  Or its older data that was not well captured in the source.<p>";   

   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Location</b></td>          
		  <td><b>Gender</b></td>
          <td><b>Division</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist</b></td>
          <td><b>Semifinalist 1/<br>Third Place</b></td>
	    <td><b>Semifinalist 2/<br>Third Place</b></td>
         </tr>\n";
		 
	 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $agebracket=$row[0];
      $firstplacefirstname=$row[1];
      $firstplacelastname=$row[2];
      $firstplacecountry=$row[3];
      $secondplacefirstname=$row[4];
      $secondplacelastname=$row[5];
      $secondplacecountry=$row[6];
      $thirdplacefirstname=$row[7];
      $thirdplacelastname=$row[8];
      $thirdplacecountry=$row[9];
      $thirdplacefirstname2=$row[10];
      $thirdplacelastname2=$row[11];
      $thirdplacecountry2=$row[12];
	  $gender=$row[13];
      $year=$row[14];
      $category=$row[15];
      $location=$row[16];	  
	  
	&dump_array(@row) if $debug;
	  
	printf "The agebracket string received is exactly ~~${agebracket}~~<p>" if $debug;
	  
      if ($agebracket eq '') {
	     print "agebracket is empty, assigning to Open<p>" if $debug;
         $agebracket='Open';
      }
	  
      if ($agebracket eq 'U18' || $agebracket eq 'U16' || $agebracket eq 'U14' || $agebracket eq 'U12' || $agebracket eq 'U10' || $agebracket eq 'U8') {
	     print "agebracket is $agebracket, moving on<p>" if $debug;
	     if ($gender eq 'M') {
		    $gender='Boy\'s';
		 }	
	     elsif ($gender eq 'W') {
		    $gender='Girl\'s';
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Received $gender.<p>";
		 }
	  }	 
	  elsif ($agebracket eq 'Open') {
	     print "agebracket is $agebracket, entering Open logic<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }
	  } 
	  else {
	     # this should be all other age brackets.
		 printf "agebracket is not a Uxx nor Open; it is $agebracket<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }		 
	  }
	  
	  # quick logic to prevent just a comma being printed by itself
	  
	  $firstplacestring="$firstplacefirstname $firstplacelastname, $firstplacecountry";
	  $secondplacestring="$secondplacefirstname $secondplacelastname, $secondplacecountry";
	  $thirdplacestring1="$thirdplacefirstname $thirdplacelastname, $thirdplacecountry";
	  $thirdplacestring2="$thirdplacefirstname2 $thirdplacelastname2, $thirdplacecountry2";
	  
	  if ($firstplacestring eq ' , ') {
	     $firstplacestring ='';
      }
	  if ($secondplacestring eq ' , ') {
	     $secondplacestring ='';
      }
	  if ($thirdplacestring1 eq ' , ') {
	     $thirdplacestring1 ='';
      }
	  if ($thirdplacestring2 eq ' , ') {
	     $thirdplacestring2 ='';
      }	  
      print "<td>$year</td>
          <td>$category</td>
          <td><center>$location</center></td>
          <td><center>$gender</center></td>		  
	      <td><center>$agebracket</center></td>
          <td>$firstplacestring</td>
          <td>$secondplacestring</td>
	      <td>$thirdplacestring1</td>
	      <td>$thirdplacestring2</td>		  
         </tr>\n";	   

      undef $agebracket;
   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}



#--------------------------------------------------------------------------------
# 10/12/17: All Doubles for IRF events
# 10/19/17: emulated singles_main query here as well.
# 

sub irf_all_doubles_matches_main() {

   printf "Entering irf_all_doubles_matches_main, processing specificially $form{'query'}\n" if $debug;

   ($category)=split(/~/,$form{'category'});
   ($division)=split(/~/,$form{'division'});
   ($year,$event)=split(/~/,$form{'sum_event'});
     
   printf "<b>Doubles Results Summary throughout IRF history</b>";   

   printf "<p>This query lists 1st, 2nd and 3rd  place finishers in Doubles for the event.  Where there are two 3rd place finishers listed, 
   joint 3rd place was awarded to both semifinalists.  This query does not promise to preserve which semi-finalist lost to which finalist nor
   does it imply that the '3rd place #1' necessarily defeated the '3rd place #2' player in a 3rd place match.  Please
   see the draw sheets and/or the IRF Match database for specific match results for the event.";
   
   printf "<p>If a 2nd or 3rd place finisher is missing, then the draw size was probably not large enough to declare anything other than a winner.  
   If the entire age group is missing for a tournament, odds are that no one entered it that year.<p>";   
   
   printf "<p>If no results are listed below, no Doubles was offered at the event.";
	 
   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Division</b></td>
          <td><b>Winning Team</b></td>
          <td><b>Runners-Up Team</b></td>
          <td><b>Semifinalist 1/<br>Third Place Team</b></td>
		  <td><b>Semifinalist 2/<br>Third Place Team</b></td>
         </tr>\n";		 
		 
   if ($form{'query'} eq 'irf_all_doubles_matches_per_event') {	 
      $where_clause=" where year='$year' and tournament_name='$event' and division_flag='D' ";
	  $orderby_clause=" order by ifnull(age_bracket,'Open')";
   }  
   if ($form{'query'} eq 'irf_all_doubles_matches_per_division_male') {
      $where_clause=" where ifnull(age_bracket,'Open')='$division' and gender_combined_flg='M' and division_flag='D' ";
	  $orderby_clause=" order by year desc, tournament_name";
   }  
   if ($form{'query'} eq 'irf_all_doubles_matches_per_division_female') {
      $where_clause=" where ifnull(age_bracket,'Open')='$division' and gender_combined_flg='W' and division_flag='D' ";
	  $orderby_clause=" order by year desc, tournament_name";
   }  
   
   
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select age_bracket, 
         First_Place_First_Name, first_place_last_name, first_place_country_1, 
		 First_Place_First_Name_Doubles, First_Place_Last_Name_Doubles, first_place_country_2,
		 Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1,
		 Second_Place_First_Name_Doubles, Second_Place_Last_Name_Doubles, second_place_country2,
		 Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
		 third_place_first_name_1_doubles, Third_Place_Last_Name_1_Doubles, third_place_country_12,
		 Third_Place_First_Name_2, Third_Place_Last_Name_2, Third_Place_Country_21, 
		 third_place_first_name_2_doubles, Third_Place_Last_Name_2_Doubles, third_place_country_22, gender_combined_flg,
		 year, tournament_name, location
		 from irf_main $where_clause $orderby_clause";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $agebracket=$row[0];
      $firstplacefirstname1=$row[1];
      $firstplacelastname1=$row[2];
      $firstplacecountry1=$row[3];
      $firstplacefirstname2=$row[4];
      $firstplacelastname2=$row[5];
      $firstplacecountry2=$row[6];
      $secondplacefirstname1=$row[7];
      $secondplacelastname1=$row[8];
      $secondplacecountry1=$row[9];
      $secondplacefirstname2=$row[10];
      $secondplacelastname2=$row[11];
      $secondplacecountry2=$row[12];	  
	  $thirdplacefirstname11=$row[13];
      $thirdplacelastname11=$row[14];
      $thirdplacecountry11=$row[15];
	  $thirdplacefirstname12=$row[16];
      $thirdplacelastname12=$row[17];
      $thirdplacecountry12=$row[18];
      $thirdplacefirstname21=$row[19];
      $thirdplacelastname21=$row[20];
      $thirdplacecountry21=$row[21];
      $thirdplacefirstname22=$row[22];
      $thirdplacelastname22=$row[23];
      $thirdplacecountry22=$row[24];
	  $gender=$row[25];
	  $year=$row[26];
	  $tournament_name=$row[27];
	  $location=$row[28];	  
	  
	  &dump_array(@row) if $debug;
	  
	  printf "The agebracket string received is exactly ~~${agebracket}~~<p>" if $debug;
	  
      if ($agebracket eq '') {
	     print "agebracket is empty, assigning to Open<p>" if $debug;
         $agebracket='Open';
      }
	  
      if ($agebracket eq 'U18' || $agebracket eq 'U16' || $agebracket eq 'U14' || $agebracket eq 'U12' || $agebracket eq 'U10' || $agebracket eq 'U8') {
	     print "agebracket is $agebracket, moving on<p>" if $debug;
	     if ($gender eq 'M') {
		    $gender='Boy\'s';
		 }	
	     elsif ($gender eq 'W') {
		    $gender='Girl\'s';
		 }	
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Received $gender.<p>";
		 }
	  }	 
	  elsif ($agebracket eq 'Open') {
	     print "agebracket is $agebracket, entering Open logic.  Gender is $gender<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }
	  } 
	  else {
	     # this should be all other age brackets.
		 printf "agebracket is not a Uxx nor Open; it is $agebracket<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }		 
	  }
	  
	  # Quick logic on Country; if they're the same, just print it once.
	  #if ($firstplacecountry1 eq $firstplacecountry2) {
	  #   $same_country='yes';
	  #}
	  	  
	  # quick logic to prevent just a comma being printed by itself; not bothering with first place b/c won't have a row unless its populated

	  $firstplacestring="$firstplacefirstname1 $firstplacelastname1, $firstplacecountry1/<br>
	                     $firstplacefirstname2 $firstplacelastname2, $firstplacecountry2";
						 
	  if ($secondplacefirstname1 eq '') {
	     $secondplacestring='';
	  }
      else {
	     $secondplacestring="$secondplacefirstname1 $secondplacelastname1, $secondplacecountry1/<br>
	                      $secondplacefirstname2 $secondplacelastname2, $secondplacecountry2";
	  }	  
	  
	  if ($thirdplacefirstname11 eq '') {
	     $thirdplacestring1='';
      }
	  else {
	     $thirdplacestring1="$thirdplacefirstname11 $thirdplacelastname11, $thirdplacecountry11/<br>
	                      $thirdplacefirstname12 $thirdplacelastname12, $thirdplacecountry12";
	  }		
	  
      if ($thirdplacefirstname21 eq '') {
	     $thirdplacestring2='';
	  }
	  else {
	     $thirdplacestring2="$thirdplacefirstname21 $thirdplacelastname21, $thirdplacecountry21/<br>
	                      $thirdplacefirstname22 $thirdplacelastname22, $thirdplacecountry22";
	  }
	  
      print "<td>$year</td>
          <td>$tournament_name</td>
          <td><center>$gender</center></td>		  
		  <td><center>$agebracket</center></td>
          <td>$firstplacestring</td>
          <td>$secondplacestring</td>
		  <td>$thirdplacestring1</td>
		  <td>$thirdplacestring2</td>		  
         </tr>\n";	   

      undef $agebracket;
   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}



#--------------------------------------------------------------------------------
# 10/12/17: Team Results for IRF events
# 

sub irf_team_results_per_event() {

   ($year,$event)=split(/~/,$form{'sum_event'});
   
   printf "Entering irf_team_results_per_event\n" if $debug;
   
   printf "<b>Team Results for the $year $event</b>";

   printf "<p>This query lists 1st, 2nd and 3rd  place Team finishers for the event.";

   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Team 1st Place</b></td>
          <td><b>Team 2nd Place</b></td>
          <td><b>Team 3rd Place</b></td>
         </tr>\n";
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select gender_combined_flg, first_place_country_1, Second_Place_Country_1,  Third_Place_Country_11 
         from irf_main 
		 where team_flag='Team' and year='$year' and tournament_name='$event';";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
	  $gender=$row[0];
      $firstplacecountry=$row[1];
      $secondplacecountry=$row[2];
      $thirdplacecountry=$row[3];
	  
	  &dump_array(@row) if $debug;
	  
      if ($gender eq 'M') {
	     if ($tournament_name =~ /Junior/) {
            $gender='Boy\'s';
	     }
		 else {
            $gender='Men\'s';
		 }	
	  }	
	  elsif ($gender eq 'W') {
	     if ($tournament_name =~ /Junior/) {	  
		    $gender='Girl\'s';
         }	
		 else {
		    $gender='Women\'s';
	     }
	  }	 
	  elsif ($gender eq 'Mixed') {
		 $gender='Combined';
	  }
	  elsif ($gender eq 'Combined') {
		 # do nothing; leave it as combined
	  }
	  else {	 
		 # we should never get here
		 printf "invalid gender rec'd.  Received $gender.<p>";
	  }	 

	  # dereference country code to a full name
	  $firstplacecountryname=&country_fullname($firstplacecountry);
	  $secondplacecountryname=&country_fullname($secondplacecountry);
	  $thirdplacecountryname=&country_fullname($thirdplacecountry);
      
	  print "<td>$year</td>
          <td>$event</td>
          <td><center>$gender</center></td>		  
          <td><center>$firstplacecountryname</center></td>
          <td><center>$secondplacecountryname</center></td>
		  <td><center>$thirdplacecountryname</center></td>
         </tr>\n";	   

   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}


#--------------------------------------------------------------------------------
# 10/19/17: All Team Results for IRF events
# 

sub irf_all_team() {

   printf "Entering irf_all_team n" if $debug;
   
   printf "<b>Team Results for all Events throughout History</b>";

   printf "<p>This query lists 1st, 2nd and 3rd  place Team finishers for every event in IRF history.";

   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Team 1st Place</b></td>
          <td><b>Team 2nd Place</b></td>
          <td><b>Team 3rd Place</b></td>
         </tr>\n";
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select year, tournament_name, gender_combined_flg, first_place_country_1, Second_Place_Country_1, Third_Place_Country_11 
         from irf_main where team_flag='Team'
         order by year desc, tournament_name;";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
	  $year=$row[0];
	  $tournament_name=$row[1];	  
	  $gender=$row[2];
      $firstplacecountry=$row[3];
      $secondplacecountry=$row[4];
      $thirdplacecountry=$row[5];
	  
	  &dump_array(@row) if $debug;
	  
      if ($gender eq 'M') {
	     if ($tournament_name =~ /Junior/) {
            $gender='Boy\'s Team';
	     }
		 else {
            $gender='Men\'s Team';
		 }	
	  }	
	  elsif ($gender eq 'W') {
	     if ($tournament_name =~ /Junior/) {	  
		    $gender='Girl\'s Team';
         }	
		 else {
		    $gender='Women\'s Team';
	     }
	  }	 
	  elsif ($gender eq 'Mixed') {
		 $gender='Combined Team';
	  }
	  elsif ($gender eq 'Combined') {
		 $gender='Combined Team';
	  }
	  elsif ($gender eq '') {
	     # blank gender seems to mean combined team.
		 $gender='Combined Team';
	  }
	  else {	 
		 # we should never get here
		 printf "invalid gender rec'd.  Received $gender.<p>";
	  }	 

	  # dereference country code to a full name
	  $firstplacecountryname=&country_fullname($firstplacecountry);
	  $secondplacecountryname=&country_fullname($secondplacecountry);
	  $thirdplacecountryname=&country_fullname($thirdplacecountry);
      
	  print "<td>$year</td>
          <td>$tournament_name</td>
          <td><center>$gender</center></td>		  
          <td><center>$firstplacecountryname</center></td>
          <td><center>$secondplacecountryname</center></td>
		  <td><center>$thirdplacecountryname</center></td>
         </tr>\n";	   

   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
}




#--------------------------------------------------------------------------------
# 10/12/17: ALL Results for IRF events
# just a quick copy of all the above code in one place.

sub irf_all_results_per_event() {

   ($year,$event)=split(/~/,$form{'sum_event'});
   
   printf "Entering irf_all_results_per_event\n" if $debug;
   
   printf "<b>All Results for the $year $event</b>";

   printf "<hr><b>Team Results</b><p>";
   
   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Team 1st Place</b></td>
          <td><b>Team 2nd Place</b></td>
          <td><b>Team 3rd Place</b></td>
         </tr>\n";
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select gender_combined_flg, first_place_country_1, Second_Place_Country_1,  Third_Place_Country_11 
         from irf_main 
		 where team_flag='Team' and year='$year' and tournament_name='$event';";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
	  $gender=$row[0];
      $firstplacecountry=$row[1];
      $secondplacecountry=$row[2];
      $thirdplacecountry=$row[3];
	  
	  &dump_array(@row) if $debug;
	  
      if ($gender eq 'M') {
	     if ($tournament_name =~ /Junior/) {
            $gender='Boy\'s';
	     }
		 else {
            $gender='Men\'s';
		 }	
	  }	
	  elsif ($gender eq 'W') {
	     if ($tournament_name =~ /Junior/) {	  
		    $gender='Girl\'s';
         }	
		 else {
		    $gender='Women\'s';
	     }
	  }	 
	  elsif ($gender eq 'Mixed') {
		 $gender='Combined';
	  }
	  elsif ($gender eq 'Combined') {
		 # do nothing; leave it as combined
	  }
	  else {	 
		 # we should never get here
		 printf "invalid gender rec'd.  Received $gender.<p>";
	  }	 

	  # dereference country code to a full name
	  $firstplacecountryname=&country_fullname($firstplacecountry);
	  $secondplacecountryname=&country_fullname($secondplacecountry);
	  $thirdplacecountryname=&country_fullname($thirdplacecountry);
      
	  print "<td>$year</td>
          <td>$event</td>
          <td><center>$gender</center></td>		  
          <td><center>$firstplacecountryname</center></td>
          <td><center>$secondplacecountryname</center></td>
		  <td><center>$thirdplacecountryname</center></td>
         </tr>\n";	   

   }
   printf "</table>";
   
   printf "<hr><b>Singles Results</b><p>";
   
   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Division</b></td>
          <td><b>Winner</b></td>
          <td><b>Finalist</b></td>
          <td><b>Semifinalist 1/<br>Third Place</b></td>
		  <td><b>Semifinalist 2/<br>Third Place</b></td>
         </tr>\n";
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select Age_Bracket , First_Place_First_Name, first_place_last_name, first_place_country_1, \
      Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1, \
      Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, \
	  third_place_first_name_2, third_place_last_name_2, third_place_country_21, gender_combined_flg\
      from irf_main where year='$year' and tournament_name='$event' and division_flag='S' \
      order by ifnull(age_bracket,'Open'), gender_combined_flg;";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $agebracket=$row[0];
      $firstplacefirstname=$row[1];
      $firstplacelastname=$row[2];
      $firstplacecountry=$row[3];
      $secondplacefirstname=$row[4];
      $secondplacelastname=$row[5];
      $secondplacecountry=$row[6];
      $thirdplacefirstname=$row[7];
      $thirdplacelastname=$row[8];
      $thirdplacecountry=$row[9];
      $thirdplacefirstname2=$row[10];
      $thirdplacelastname2=$row[11];
      $thirdplacecountry2=$row[12];
	  $gender=$row[13];
	  
	  &dump_array(@row) if $debug;
	  
	  printf "The agebracket string received is exactly ~~${agebracket}~~<p>" if $debug;
	  
      if ($agebracket eq '') {
	     print "agebracket is empty, assigning to Open<p>" if $debug;
         $agebracket='Open';
      }
	  
      if ($agebracket eq 'U18' || $agebracket eq 'U16' || $agebracket eq 'U14' || $agebracket eq 'U12' || $agebracket eq 'U10' || $agebracket eq 'U8') {
	     print "agebracket is $agebracket, moving on<p>" if $debug;
	     if ($gender eq 'M') {
		    $gender='Boy\'s';
		 }	
	     elsif ($gender eq 'W') {
		    $gender='Girl\'s';
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Received $gender.<p>";
		 }
	  }	 
	  elsif ($agebracket eq 'Open') {
	     print "agebracket is $agebracket, entering Open logic<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }
	  } 
	  else {
	     # this should be all other age brackets.
		 printf "agebracket is not a Uxx nor Open; it is $agebracket<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }		 
	  }
	  
	  # quick logic to prevent just a comma being printed by itself
	  
	  $firstplacestring="$firstplacefirstname $firstplacelastname, $firstplacecountry";
	  $secondplacestring="$secondplacefirstname $secondplacelastname, $secondplacecountry";
	  $thirdplacestring1="$thirdplacefirstname $thirdplacelastname, $thirdplacecountry";
	  $thirdplacestring2="$thirdplacefirstname2 $thirdplacelastname2, $thirdplacecountry2";
	  
	  if ($firstplacestring eq ' , ') {
	     $firstplacestring ='';
      }
	  if ($secondplacestring eq ' , ') {
	     $secondplacestring ='';
      }
	  if ($thirdplacestring1 eq ' , ') {
	     $thirdplacestring1 ='';
      }
	  if ($thirdplacestring2 eq ' , ') {
	     $thirdplacestring2 ='';
      }	  
      print "<td>$year</td>
          <td>$event</td>
          <td><center>$gender</center></td>		  
		  <td><center>$agebracket</center></td>
          <td>$firstplacestring</td>
          <td>$secondplacestring</td>
		  <td>$thirdplacestring1</td>
		  <td>$thirdplacestring2</td>		  
         </tr>\n";	   

      undef $agebracket;
   }

   printf "</table>";
   
   printf "<hr><b>Doubles Results</b><p>";
   
   print "<table border><tr>\n";
   print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Gender</b></td>
          <td><b>Division</b></td>
          <td><b>Winning Team</b></td>
          <td><b>Runners-Up Team</b></td>
          <td><b>Semifinalist 1/<br>Third Place Team</b></td>
		  <td><b>Semifinalist 2/<br>Third Place Team</b></td>
         </tr>\n";		 
		 
   # this sorts by Open then age groups, and by Gender 		 
   $sql="select age_bracket, 
         First_Place_First_Name, first_place_last_name, first_place_country_1, 
		 First_Place_First_Name_Doubles, First_Place_Last_Name_Doubles, first_place_country_2,
		 Second_Place_First_Name, Second_Place_Last_Name, Second_Place_Country_1,
		 Second_Place_First_Name_Doubles, Second_Place_Last_Name_Doubles, second_place_country2,
		 Third_Place_First_Name_1, Third_Place_Last_Name_1, Third_Place_Country_11, 
		 third_place_first_name_1_doubles, Third_Place_Last_Name_1_Doubles, third_place_country_12,
		 Third_Place_First_Name_2, Third_Place_Last_Name_2, Third_Place_Country_21, 
		 third_place_first_name_2_doubles, Third_Place_Last_Name_2_Doubles, third_place_country_22, gender_combined_flg
		 from irf_main where year='$year' and tournament_name='$event' and division_flag='D' 
		 order by ifnull(age_bracket,'Open')";
		 
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $agebracket=$row[0];
      $firstplacefirstname1=$row[1];
      $firstplacelastname1=$row[2];
      $firstplacecountry1=$row[3];
      $firstplacefirstname2=$row[4];
      $firstplacelastname2=$row[5];
      $firstplacecountry2=$row[6];
      $secondplacefirstname1=$row[7];
      $secondplacelastname1=$row[8];
      $secondplacecountry1=$row[9];
      $secondplacefirstname2=$row[10];
      $secondplacelastname2=$row[11];
      $secondplacecountry2=$row[12];	  
	  $thirdplacefirstname11=$row[13];
      $thirdplacelastname11=$row[14];
      $thirdplacecountry11=$row[15];
	  $thirdplacefirstname12=$row[16];
      $thirdplacelastname12=$row[17];
      $thirdplacecountry12=$row[18];
      $thirdplacefirstname21=$row[19];
      $thirdplacelastname21=$row[20];
      $thirdplacecountry21=$row[21];
      $thirdplacefirstname22=$row[22];
      $thirdplacelastname22=$row[23];
      $thirdplacecountry22=$row[24];
	  $gender=$row[25];
	  
	  &dump_array(@row) if $debug;
	  
	  printf "The agebracket string received is exactly ~~${agebracket}~~<p>" if $debug;
	  
      if ($agebracket eq '') {
	     print "agebracket is empty, assigning to Open<p>" if $debug;
         $agebracket='Open';
      }
	  
      if ($agebracket eq 'U18' || $agebracket eq 'U16' || $agebracket eq 'U14' || $agebracket eq 'U12' || $agebracket eq 'U10' || $agebracket eq 'U8') {
	     print "agebracket is $agebracket, moving on<p>" if $debug;
	     if ($gender eq 'M') {
		    $gender='Boy\'s';
		 }	
	     elsif ($gender eq 'W') {
		    $gender='Girl\'s';
		 }	
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Received $gender.<p>";
		 }
	  }	 
	  elsif ($agebracket eq 'Open') {
	     print "agebracket is $agebracket, entering Open logic.  Gender is $gender<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }
	  } 
	  else {
	     # this should be all other age brackets.
		 printf "agebracket is not a Uxx nor Open; it is $agebracket<p>" if $debug;
	     if ($gender eq 'M' ) {
		   $gender='Men\'s';
		 }	
	     elsif ($gender eq 'W' ) {
		    $gender='Women\'s';
		 }
	     elsif ($gender eq 'Mixed') {
		    # do nothing
		 }	
		 else {
		    # we should never get here
		    printf "invalid gender rec'd.  Rec'd $gender.<p>";
		 }		 
	  }
	  
	  # Quick logic on Country; if they're the same, just print it once.
	  #if ($firstplacecountry1 eq $firstplacecountry2) {
	  #   $same_country='yes';
	  #}
	  	  
	  # quick logic to prevent just a comma being printed by itself; not bothering with first place b/c won't have a row unless its populated

	  $firstplacestring="$firstplacefirstname1 $firstplacelastname1, $firstplacecountry1/<br>
	                     $firstplacefirstname2 $firstplacelastname2, $firstplacecountry2";
						 
	  if ($secondplacefirstname1 eq '') {
	     $secondplacestring='';
	  }
      else {
	     $secondplacestring="$secondplacefirstname1 $secondplacelastname1, $secondplacecountry1/<br>
	                      $secondplacefirstname2 $secondplacelastname2, $secondplacecountry2";
	  }	  
	  
	  if ($thirdplacefirstname11 eq '') {
	     $thirdplacestring1='';
      }
	  else {
	     $thirdplacestring1="$thirdplacefirstname11 $thirdplacelastname11, $thirdplacecountry11/<br>
	                      $thirdplacefirstname12 $thirdplacelastname12, $thirdplacecountry12";
	  }		
	  
      if ($thirdplacefirstname21 eq '') {
	     $thirdplacestring2='';
	  }
	  else {
	     $thirdplacestring2="$thirdplacefirstname21 $thirdplacelastname21, $thirdplacecountry21/<br>
	                      $thirdplacefirstname22 $thirdplacelastname22, $thirdplacecountry22";
	  }
	  
      print "<td>$year</td>
          <td>$event</td>
          <td><center>$gender</center></td>		  
		  <td><center>$agebracket</center></td>
          <td>$firstplacestring</td>
          <td>$secondplacestring</td>
		  <td>$thirdplacestring1</td>
		  <td>$thirdplacestring2</td>		  
         </tr>\n";	   

      undef $agebracket;
   }

   printf "</table>";
   &print_back_link;
   printf "</body></html>";	 
   
}


#--------------------------------------------------------------------------------
# 10/15/17: all player Results for IRF events main
# 

sub irf_all_player_results_main() {

   ($player)=split(/~/,$form{'player'});

   ($lname,$fname)=split(/,/,$form{'player'});

   $fname=~ s/^ //g;

   $player="$fname $lname";
   
    
   printf "Entering irf_all_player_results_main, $form{'query'} call, for player ~$player~, ~$form{'player'}~, ~$lname~ and ~$fname~ <p>" if $debug;
  

   if ($form{'query'} eq 'irf_all_player_results_singles') {	 
      printf "All International (Adult & Junior) Singles 1st/2nd/3rd place results for <B>$player</b>";
      
      printf "<p>Note: This query lists 1st, 2nd and 3rd place finishers only for the player.  If a player played an event but did not
finish in the top 3, then they are not listed here.  Please see the draw sheets at IRF's website and/or the IRF Match database for specific 
match results for the player.<p>";
	  
	  $sql="select 'Winner',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(first_place_first_name , ' ' , first_place_last_name) = '$player' and division_flag='S'
         union
         select 'Finalist',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(second_place_first_name , ' ' , second_place_last_name) = '$player' and division_flag='S'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = '$player' and division_flag='S'
         union
         select '3rd Place',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(third_place_first_name_2, ' ', third_place_last_name_2) = '$player' and division_flag='S'
         order by year desc, 1;";
		 
      print "<table border><tr>\n";
      print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Location</b></td>
          <td><b>Division</b></td>
          <td><b>Player</b></td>
          <td><b>Place</b></td>
         </tr>\n";		 
		 
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $place=$row[0];
         $event=$row[1];
         $year=$row[2];
         $location=$row[3];
         $division=$row[4];
		 
         print "<td>$year</td>
                <td>$event</td>
                <td><center>$location</td>		  
	            <td><center>$division</center></td>
                <td>$player</td>
                <td><center>$place</center></td>
                </tr>\n";
      }
      printf "</table>";   
   }		 
		 
  
   if ($form{'query'} eq 'irf_all_player_results_doubles') {
      printf "All International (Adult & Junior) Doubles 1st/2nd/3rd place results for <B>$player</b>";
	  
      printf "<p>Note: This query lists 1st, 2nd and 3rd place team finishes only for the player.  If a Doubles team played an event but did not
finish in the top 3, then they are not listed here.";
	  
      $sql="select 'Winner1',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(first_place_first_name , ' ' , first_place_last_name) = '$player' and division_flag='D'
         union
         select 'Winner2',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) = '$player' and division_flag='D'
         union
         select 'Finalist1',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(second_place_first_name , ' ' , second_place_last_name) = '$player' and division_flag='D'
         union
         select 'Finalist2',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(second_place_first_name_doubles , ' ' , second_place_last_name_doubles) = '$player' and division_flag='D'
         union
         select '3rd Place11',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = '$player' and division_flag='D'
         union
         select '3rd Place12',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(Third_Place_First_Name_1_doubles, ' ', Third_Place_Last_Name_1_doubles) = '$player' and division_flag='D'
         union
         select '3rd Place21',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(third_place_first_name_2, ' ', third_place_last_name_2) = '$player' and division_flag='D'
         union
         select '3rd Place22',tournament_name,year,location,ifnull(age_bracket,'Open') from irf_main 
         where concat(third_place_first_name_2_doubles, ' ', third_place_last_name_2_doubles) = '$player' and division_flag='D'
	   order by year desc, 1; ";
		 
      print "<table border><tr>\n";
      print "<td><b>Year</b></td>
          <td><b>Event</b></td>
          <td><b>Location</b></td>
          <td><b>Division</b></td>
          <td><b>Place</b></td>
          <td><b>Player</b></td>
          <td><b>Partner</b></td>		  
         </tr>\n";		 
		 
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $place=$row[0];
         $event=$row[1];
         $year=$row[2];
         $location=$row[3];
         $division=$row[4];
		 
		 # get the partner for the display
		 if ($place eq 'Winner1') {
		    $sql1="select concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(first_place_first_name , ' ' , first_place_last_name) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='Winner';			
		 }
		 if ($place eq 'Winner2') {
		    $sql1="select concat(first_place_first_name , ' ' , first_place_last_name) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(first_place_first_name_doubles , ' ' , first_place_last_name_doubles) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='Winner';			
		 }
		 if ($place eq 'Finalist1') {
		    $sql1="select concat(second_place_first_name_doubles , ' ' , second_place_last_name_doubles) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(second_place_first_name , ' ' , second_place_last_name) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='Finalist';			
		 }		 
		 if ($place eq 'Finalist2') {
		    $sql1="select concat(second_place_first_name , ' ' , second_place_last_name) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(second_place_first_name_doubles , ' ' , second_place_last_name_doubles) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='Finalist';			
		 }		 		 
		 if ($place eq '3rd Place11') {
		    $sql1="select concat(Third_Place_First_Name_1_doubles, ' ', Third_Place_Last_Name_1_doubles) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='3rd Place';			
		 }			 
		 if ($place eq '3rd Place12') {
		    $sql1="select concat(Third_Place_First_Name_1, ' ', Third_Place_Last_Name_1) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(Third_Place_First_Name_1_doubles, ' ', Third_Place_Last_Name_1_doubles) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='3rd Place';			
		 }		
		 if ($place eq '3rd Place21') {
		    $sql1="select concat(third_place_first_name_2_doubles, ' ', third_place_last_name_2_doubles) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(third_place_first_name_2, ' ', third_place_last_name_2) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='3rd Place';			
		 }	
		 if ($place eq '3rd Place22') {
		    $sql1="select concat(third_place_first_name_2, ' ', third_place_last_name_2) as partner from irf_main
			       where tournament_name='$event' and year='$year' and division_flag='D' 
                   and concat(third_place_first_name_2_doubles, ' ', third_place_last_name_2_doubles) = '$player';";
			printf "$sql1<br>" if $debug;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute;
			while (@row1 = $sth1->fetchrow_array) {
               $partner=$row1[0];
			}	
            $place='3rd Place';			
		 }	

         print "<td>$year</td>
                <td>$event</td>
                <td><center>$location</td>		  
	            <td><center>$division Doubles</center></td>
                <td><center>$place</center></td>
                <td>$player</td>
                <td>$partner</td>				
                </tr>\n";
      }
      printf "</table>";		 
   }  
   
   &print_back_link;
   printf "</body></html>";	    
}















#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Utility functions

#--------------------------------------------------------------------------------
# This transforms the database numeric round 8,4,2 into Q,S,F as appropriate
# 10/13/17: put in fix to turn 99 into RR for round robins
# 10/18/17: put in fix to turn 3 into 3rd place match for national competitions if/when they occur

sub fix_round() {
   my $rnd = shift;

   #printf "entering fix_round, value is [$rnd]\n" if $debug;

   if ($rnd eq '8') {
      return('Q');
   }
   elsif ($rnd eq '4') {
      return('S');
   }
   elsif ($rnd eq '2') {
      return('F');
   }
   elsif ($rnd eq '99') {
      return ('RR');
   }
   elsif ($rnd eq '3') {
      return ('3rd');
   }
   else {
      return($rnd);
   }
}


#--------------------------------------------------------------------------------
# Debugging routine that dumps out an array 

sub dump_array() {
   my @array = @_;
   
   foreach $line (@array) {
      printf "$line|~|";
   }
   printf "<br>";
}


#--------------------------------------------------------------------------------
# This cleans up duplicate lines in an array

sub strip_duplicate_in_array (@) {
  my (@arr) = @_;
  my %hash = map {$_ => 1} @arr;
  return keys %hash;
}

#--------------------------------------------------------------------------------
# This is a Schwartzian Transform, pulled from a c.l.p.m posting (also in perlfaq)
# This sorts an array on a particular field value (passed in as first parameter)

sub schwartzian_sort() {
   my ($sort_field,$aref) = @_;
   my @arr = @$aref;
   printf "inside schwartzian sort sub, sort_field is [$sort_field]<br>" if $debug;

   @arr = map { [ (split "~", $_)[$sort_field], $_ ] } @arr;
   @arr = sort { $a->[0] <=> $b->[0] } @arr;
   @arr = map { $_->[1] } @arr;

   return(@arr);

}


#--------------------------------------------------------------------------------
# This reverses an array;

sub reverse_array() {
   my @arr = @_;
   my @newarr;

   #&dump_array(@arr) if $debug;

   printf "inside reverse_array sub<br>" if $debug;
   my $count=@arr;
   for ($i=$count;$i>0;$i--) {
      #print "i is [$i-1], data is $arr[$i-1]<br>";
      push (@newarr,$arr[$i-1]);
   }

   return(@newarr);
}

#--------------------------------------------------------------------------------
sub gen_wl() {
   my $player = shift;

   printf "Entering gen_wl routine and player is $_ ... \n" if $debug;

   #my $sql = "select count(*) from results where winner='$form{'player'}'";
   my $sql = "select count(*) from results where winner='$player'";
   my $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_wins=$row[0];
   }

   $sql = "select count(*) from results where loser='$player'";
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      $overall_losses=$row[0];
   }

   if ($overall_wins+$overall_losses > 0) { 
      $winning_pct = ($overall_wins/($overall_wins+$overall_losses));
      $winning_pct = sprintf("%.03f", $winning_pct);
   }
   else {
      $winning_pct = "0.000";
   }

   printf "returning $overall_wins,$overall_losses,$winning_pct for $player\n" if $debug;
   return($overall_wins,$overall_losses,$winning_pct);

}

#--------------------------------------------------------------------------------
# 5/23/08: put this in to generate career summary matrix per player
#  borrowed mostly from player_summary; in fact they have identical logic, with the
#  printing stripped and variables fixed and return values done.
#  Probably could make this more efficient by combining the two functions
# 5/9/14: fixed this to also get round of 256 results, ahead of per-season analysis.
# 10/14/17: fixed this to also capture round robin results...
# 10/18/17: fixed this to capture 3rd place results.
# 1/2/18: fixed this to work for doubles and for RR rounds either 99 or 0

sub gen_season_summary() {

   my $player = shift;

   my @seasons;

   printf "inside gen_season_summary, tour is $form('tour'}, local player variable is $player\n" if $debug;

   if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
      $sql = "select distinct(season) from results_doubles order by season desc"; 
   }
   else {	  
      $sql = "select distinct(season) from results order by season desc";
   }   

   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      push (@seasons,$row);
   }

   my $career_roundrobins=0;
   my $career_twofiftysixes=0;
   my $career_onetwentyeights=0;
   my $career_sixtyfours=0;
   my $career_thirtytwos=0;
   my $career_sixteens=0;
   my $career_quarters=0;
   my $career_semis=0;
   my $career_thirds=0;
   my $career_finals=0;
   my $career_wins=0;
   my $career_total_results=0;
   my $career_num_events=0;

   &dump_array(@seasons) if $debug;

   foreach $season (@seasons) {
      my $roundrobins=0;
      my $twofiftysixes=0;
      my $onetwentyeights=0;
      my $sixtyfours=0;
      my $thirtytwos=0;
      my $sixteens=0;
      my $quarters=0;
      my $semis=0;
      my $thirds=0;
      my $finals=0;
      my $wins=0;
      my $total_results=0;
      my $num_events=0;

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
         $sql="select count(distinct(event)) from results_doubles where season='$season'";
      }
      else {	  
         $sql="select count(distinct(event)) from results where season='$season'";
      }  	  

      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while ($row = $sth->fetchrow_array) {
         $num_events=$row;
      }

      $career_num_events=$career_num_events+$num_events;

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
         $sql="select event, min(round) from results_doubles where \
            (winner_p1='$player' or winner_p2='$player' or loser_p1='$player' or loser_p2='$player') \
            and season='$season' group by event";
      }
      else {	  
         $sql="select event, min(round) from results where \
            (winner='$player' or loser='$player') \
            and season='$season' group by event";
      }  	  

      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         ($event,$round)=($row[0],$row[1]);

         printf "$event and $round<br>" if $debug;

         if ($round eq "99") {
            $roundrobins++;
            $career_roundrobins++;
         }
         elsif ($round eq "0") {
            $roundrobins++;
            $career_roundrobins++;
         }
         elsif ($round eq "256") {
            $twofiftysixes++;
            $career_twofiftysixes++;
         }
         elsif ($round eq "128") {
            $onetwentyeights++;
            $career_onetwentyeights++;
         }
         elsif ($round eq "64") {
            $sixtyfours++;
            $career_sixtyfours++;
         }
         elsif ($round eq "32") {
            $thirtytwos++;
            $career_thirtytwos++;
         }
         elsif ($round eq "16") {
            $sixteens++;
            $career_sixteens++;
         }
         elsif ($round eq "8") {
            $quarters++;
            $career_quarters++;
         }
         elsif ($round eq "4") {
            $semis++;
            $career_semis++;
         }
         elsif ($round eq "3") {
            $thirds++;
            $career_thirds++;
         }
         elsif ($round eq "2") {
		 
            if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {	
               $sql2="select winner_p1, winner_p2 from results_doubles where season='$season' and event='$event' and round=2";
               printf "$sql2<br>" if $debug;
               $sth2 = $dbh->prepare($sql2);
               $sth2->execute;
               while (@row2 = $sth2->fetchrow_array) {
                  $winner_p1=$row2[0];
                  $winner_p2=$row2[1];				  
               }
               if ($winner_p1 eq "$player" || $winner_p2 eq "$player") {
                  $wins++;
                  $career_wins++;
               }
               else {
                  $finals++;
                  $career_finals++;
               }			
            }
            else {	  
               $sql2="select winner from results where season='$season' and event='$event' and round=2";
               printf "$sql2<br>" if $debug;
               $sth2 = $dbh->prepare($sql2);
               $sth2->execute;
               while (@row2 = $sth2->fetchrow_array) {
                  $winner=$row2[0];
               }
               if ($winner eq "$player") {
                  $wins++;
                  $career_wins++;
               }
               else {
                  $finals++;
                  $career_finals++;
               }
			}  			 
         }
         else {
            printf "Invalid round $round in database; you should never see this (from gen_season_summary)<br>";
         }
      }

      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;
      $career_total_results=$career_total_results+$total_results;

      $others=$num_events-$total_results;
      $career_others=$career_others+$others;

      #$results_summary="$wins Wins, $finals Finals, $semis Semis, $quarters Quarters, $sixteens 16s, "; 
      #if ($thirtytwos > 0) { $results_summary = $results_summary . "$thirtytwos 32s, "; }
      #if ($sixtyfours > 0) { $results_summary = $results_summary . "$sixtyfours 64s, "; }
      #if ($onetwentyeights > 0) { $results_summary = $results_summary . "$onetwentyeights 128s, "; }
      #$results_summary = $results_summary . "($others/$num_events Missed Tourneys)";

      next if ($others eq $num_events);

   }

   printf "\nreturning $player,$career_wins,$career_finals,$career_semis,$career_quarters,$career_sixteens,$career_thirtytwos,$career_sixtyfours,$career_onetwentyeights,$career_twofiftysixes\n" if $debug;

   return($player,$career_wins,$career_finals,$career_semis,$career_quarters,$career_sixteens,$career_thirtytwos,$career_sixtyfours,$career_onetwentyeights,$career_twofiftysixes);

}


#--------------------------------------------------------------------------------
# 5/9/14: modified the gen_season_summary to take a second parameter (the season) and just
# return the results for that season.

sub gen_perseason_summary() {

   my ($player,$season) = @_;

   printf "<br>inside gen_perseason_summary, local player variable is $player\n, local season variable is $season<br>" if $debug;

   my $twofiftysixes=0;
   my $onetwentyeights=0;
   my $sixtyfours=0;
   my $thirtytwos=0;
   my $sixteens=0;
   my $quarters=0;
   my $semis=0;
   my $finals=0;
   my $wins=0;
   my $total_results=0;
   my $num_events=0;

   $sql="select count(distinct(event)) from results where season='$season'";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while ($row = $sth->fetchrow_array) {
      $num_events=$row;
   }

   $sql="select event, min(round) from results where \
         (winner='$player' or loser='$player') \
         and season='$season' group by event";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($event,$round)=($row[0],$row[1]);

   printf "$event and $round<br>" if $debug;

      if ($round eq "256") {
         $twofiftysixes++;
      }
      elsif ($round eq "128") {
         $onetwentyeights++;
      }
      elsif ($round eq "64") {
         $sixtyfours++;
      }
      elsif ($round eq "32") {
         $thirtytwos++;
      }
      elsif ($round eq "16") {
         $sixteens++;
      }
      elsif ($round eq "8") {
         $quarters++;
      }
      elsif ($round eq "4") {
         $semis++;
      }
      elsif ($round eq "2") {
         $sql2="select winner from results where season='$season' and event='$event' and round=2";
         printf "$sql2<br>" if $debug;
         $sth2 = $dbh->prepare($sql2);
         $sth2->execute;
         while (@row2 = $sth2->fetchrow_array) {
            $winner=$row2[0];
         }
         if ($winner eq "$player") {
            $wins++;
         }
         else {
            $finals++;
         }
      }
      else {
         printf "Invalid round in database; you should never see this";
      }

      $total_results=$wins+$finals+$semis+$quarters+$sixteens+$thirtytwos+$sixtyfours+$onetwentyeights+$twofiftysixes;

      $others=$num_events-$total_results;

      #$results_summary="$wins Wins, $finals Finals, $semis Semis, $quarters Quarters, $sixteens 16s, "; 
      #if ($thirtytwos > 0) { $results_summary = $results_summary . "$thirtytwos 32s, "; }
      #if ($sixtyfours > 0) { $results_summary = $results_summary . "$sixtyfours 64s, "; }
      #if ($onetwentyeights > 0) { $results_summary = $results_summary . "$onetwentyeights 128s, "; }
      #$results_summary = $results_summary . "($others/$num_events Missed Tourneys)";

      next if ($others eq $num_events);

   }

   printf "\nreturning $player,$season,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes\n" if $debug;

   return($player,$season,$wins,$finals,$semis,$quarters,$sixteens,$thirtytwos,$sixtyfours,$onetwentyeights,$twofiftysixes);

}







#--------------------------------------------------------------------------------
# 5/18/11: sub gen player rankings: takes in two parameters: season and player and then
# returns the ranking.  

sub gen_player_ranking() {
   my ($season,$player) = @_;

   printf "<p>season is $season, player is $player<br>" if $debug;

   # Step 1: if the player has a ranking in the rankings table, use that 

   $sql = "select player,rank,points,prizemoney from rankings where player='$player' and season='$season' ";
   printf "$sql<br>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   while (@row = $sth->fetchrow_array) {
      ($player,$rank,$points,$money) = ($row[0],$row[1],$row[2]);
   }

   printf "from rankings table: [$player ~ $rank ~ $points ~ $money]<br>" if $debug;

   # Step 2: if the player does NOT have an entry in the table for this season, we'll see if he/she actually played
   # any matches

   if ($rank eq "") {

      # Step 2.5: if its the current season, there won't be rankings; return "current season"

      if ($season eq $current_season) {
         printf "season is $season, current_season is $current_season, returning 'Current Season'<br>" if $debug;
         return "Current Season";
      }

      printf "Entering blank name from rankings clause<br>" if $debug;

      my $sql = "select count(*) from results where winner='$player' and season='$season'";     
      my $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $season_wins=$row[0];
      }
   
      $sql = "select count(*) from results where loser='$player' and season='$season'";
      $sth = $dbh->prepare($sql);
      $sth->execute;
      while (@row = $sth->fetchrow_array) {
         $season_losses=$row[0];
      }  
   

      # Step 3: If the player has matches but no ranking, we'll assume that the player's ranking is less than
      # whatever the maximum is for that season.  Get the current max and report back 

      if ($season_wins+$season_losses > 0) {

         $sql = "select max(cast(rank as unsigned)) from rankings where season='$season'";
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
         while (@row = $sth->fetchrow_array) {
            ($maxrank) = ($row[0]);
         }

         #return "A $maxrank";

         if ($maxrank eq '') {
            return "No rankings in DB";
         }
         else {
            return "Outside top $maxrank";
         }      
      }
      else {
         return "no results";
      }  

   }
   else {
         return "$rank,$points,$money";
   }

}


   
   





#--------------------------------------------------------------------------------
# 11/7/08: get_age
# coded up to simplfy getting the difference in years and days between two dates.
# You can pass in two dates, a day and today, etc
# Using Date::Calc routine Delta_Days

# Format of dates needs to be in MM/DD/YYYY

use Date::Calc qw(:all);

sub get_age() {
   my ($first_date,$second_date) = @_;
   #printf "<br>entered dob calculations<br>\n" if $debug;
   printf "<br>inside get_age, passed '$first_date' and '$second_date'<br>\n" if $debug;
   
   if ($first_date eq '') {
      printf "Empty date received, returning zero" if $debug;
      return(0,0);
   }
   if ($second_date eq '') {
      printf "Empty date received, returning zero" if $debug;
      return(0,0);
   }
   
   ($month1,$day1,$year1)=split(/\//,$first_date);
   ($month2,$day2,$year2)=split(/\//,$second_date);

   if ($first_date eq 'today') {
      ($year1,$month1,$day1) = Today([$gmt]);
   }
   if ($second_date eq 'today') {
      ($year2,$month2,$day2) = Today([$gmt]);
   }

   printf "$year1,$month1,$day1 $year2,$month2,$day2\n" if $debug;

   $deltadays = Delta_Days($year1,$month1,$day1, 
                     $year2,$month2,$day2);

   printf "days difference is $deltadays<br>\n" if $debug;

   # Note: most of this day logic not used here, but definitely used elsewhere.
   $myage_full = $deltadays/365.25;
   ($years,$yearfraction)=split(/\./,$myage_full);

   $yearfraction='.' . $yearfraction;
   $daysfraction=$yearfraction*365;
   ($days,$daysfractiontmp)=split(/\./,$daysfraction);

   #printf "$myage_full $years, $yearfraction $days<br>\n" if $debug;

   #$myage = "${years}yrs ${days}days";
   #$myage = "${years}yrs";

   printf "returning ${years}yrs ${days}days\n" if $debug;
   return($years,$days);
}


#--------------------------------------------------------------------------------
# 11/8/08: date_to_varchar conversion: used to convert 1983-01-01 to 01/01/1983
sub date_to_varchar() {
   
   my $date = shift;

   printf "inside date_to_varchar, passed variable is $date<br>\n" if $debug;

   ($year,$day,$month)=split(/-/,$date);

   printf "date_to_varchar returning ${day}/${month}/${year}<br>\n" if $debug;

   return "${day}/${month}/${year}";
}


#--------------------------------------------------------------------------------
# 10/12/17: quick utility function to take a 3-character country code and return full name
# Believe this is driven by IOC codes: https://en.wikipedia.org/wiki/List_of_IOC_country_codes

sub country_fullname() {
   
   my $ccode = shift;

   printf "inside country_fullname, passed variable is $ccode<br>\n" if $debug;

   if ($ccode eq 'USA') { return 'United States'; }
   elsif ($ccode eq 'MEX') { return 'Mexico'; }
   elsif ($ccode eq 'COL') { return 'Columbia'; }
   elsif ($ccode eq 'CAN') { return 'Canada'; }
   elsif ($ccode eq 'USA/CAN') { return 'United States/Canada'; } # ?? why is this here?
   elsif ($ccode eq 'ECU') { return 'Ecuador'; }
   elsif ($ccode eq 'BOL') { return 'Bolivia'; }
   elsif ($ccode eq 'CHI') { return 'Chile'; }
   elsif ($ccode eq 'CRC') { return 'Costa Rica'; }
   elsif ($ccode eq 'GUA') { return 'Guatemala'; }
   elsif ($ccode eq 'SUI') { return 'Switzerland'; }
   elsif ($ccode eq 'IND') { return 'India'; }  # Indonesia?
   elsif ($ccode eq 'ENG') { return 'England'; }
   elsif ($ccode eq 'IRL') { return 'Ireland'; }
   elsif ($ccode eq 'JPN') { return 'Japan'; }
   elsif ($ccode eq 'JAP') { return 'Japan'; }
   elsif ($ccode eq 'GER') { return 'Germany'; }
   elsif ($ccode eq 'VEN') { return 'Venezuela'; }
   elsif ($ccode eq 'PUR') { return 'Puerto Rico'; }
   elsif ($ccode eq 'PAN') { return 'Panama'; }
   elsif ($ccode eq 'ARG') { return 'Argentina'; }
   elsif ($ccode eq 'DOM') { return 'Dominican Republic'; }
   elsif ($ccode eq 'DR') { return 'Dominican Republic'; }   
   elsif ($ccode eq 'TUR') { return 'Turkey'; }
   elsif ($ccode eq 'NCA') { return 'Nicaragua'; }
   elsif ($ccode eq 'HON') { return 'Honduras'; }
   elsif ($ccode eq 'NED') { return 'Netherlands'; }
   elsif ($ccode eq 'MUS') { return 'Mauritius'; }
   elsif ($ccode eq 'KOR') { return 'South Korea'; }
   elsif ($ccode eq 'NIC') { return 'Nicaragua'; }
   elsif ($ccode eq 'UY') { return 'Uruguay'; }
   elsif ($ccode eq 'URU') { return 'Uruguay'; }   
   elsif ($ccode eq 'BEL') { return 'Belize'; }
   elsif ($ccode eq 'CUB') { return 'Cuba'; }   
   elsif ($ccode eq 'INA') { return 'Indonesia'; }   
#   elsif ($ccode eq '') { return '<blank>'; }      
   elsif ($ccode eq 'UNK') { return 'Unknown'; }      
   elsif ($ccode eq 'AUS') { return 'Australia'; }        
   elsif ($ccode eq '') { return ''; }      
   else {
      printf "Invalid Country code $ccode passed to lookup, returning the same<p>";
	  return $ccode;
   }
}

#--------------------------------------------------------------------------------
# 11/24/17: quick utility function to take full country name and return code
# Believe this is driven by IOC codes: https://en.wikipedia.org/wiki/List_of_IOC_country_codes

sub country_abbr() {
   
   my $ccode = shift;

   printf "inside country_fullname, passed variable is $ccode<br>\n" if $debug;

   if ($ccode eq 'United States') { return 'USA'; }
   elsif ($ccode eq 'USA') { return 'USA'; }
   elsif ($ccode eq 'Mexico') { return 'MEX'; }
   elsif ($ccode eq 'Columbia') { return 'COL'; }
   elsif ($ccode eq 'Canada') { return 'CAN'; }
   elsif ($ccode eq 'United States/Canada') { return 'USA/CAN'; } # ?? why is this here?
   elsif ($ccode eq 'Ecuador') { return 'ECU'; }
   elsif ($ccode eq 'Bolivia') { return 'BOL'; }
   elsif ($ccode eq 'Chile') { return 'CHI'; }
   elsif ($ccode eq 'Costa Rica') { return 'CRC'; }
   elsif ($ccode eq 'Guatemala') { return 'GUA'; }
   elsif ($ccode eq 'Switzerland') { return 'SUI'; }
   elsif ($ccode eq 'India') { return 'IND'; }  # Indonesia?
   elsif ($ccode eq 'England') { return 'ENG'; }
   elsif ($ccode eq 'Ireland') { return 'IRL'; }
   elsif ($ccode eq 'Japan') { return 'JPN'; } # JAP?
   elsif ($ccode eq 'Germany') { return 'GER'; }
   elsif ($ccode eq 'Venezuela') { return 'VEN'; }
   elsif ($ccode eq 'Puerto Rico') { return 'PUR'; }
   elsif ($ccode eq 'Panama') { return 'PAN'; }
   elsif ($ccode eq 'Argentina') { return 'ARG'; }
   elsif ($ccode eq 'Dominican Republic') { return 'DOM'; }
   elsif ($ccode eq 'Turkey') { return 'TUR'; }
   elsif ($ccode eq 'Nicaragua') { return 'NCA'; }
   elsif ($ccode eq 'Honduras') { return 'HON'; }
   elsif ($ccode eq 'Netherlands') { return 'NED'; }
   elsif ($ccode eq 'Mauritius') { return 'MUS'; }
   elsif ($ccode eq 'South Korea') { return 'KOR'; }
   elsif ($ccode eq 'Uruguay') { return 'URU'; }
   elsif ($ccode eq 'Belize') { return 'BEL'; }
   elsif ($ccode eq 'Cuba') { return 'CUB'; }   
   elsif ($ccode eq 'Indonesia') { return 'INA'; }   
   elsif ($ccode eq 'Unknown') { return 'UNK'; }      
   elsif ($ccode eq 'Australia') { return 'AUS'; }      
#   elsif ($ccode eq '') { return '<blank>'; }    
   elsif ($ccode eq '') { return ''; }   
   else {
      printf "Invalid Country code $ccode passed to lookup, returning the same<p>";
  return $ccode;
   }
}

#--------------------------------------------------------------------------------
# 1/23/18: quick function to print back links at top and bottom of each report page

sub print_back_link() {
   printf "<hr><p>click <a href=\"http://www.proracquetballstats.com/cgi-bin/results_front_new.pl?tour=$form{'tour'}\">here</a> to go back to the Report Select page<p>";
}



