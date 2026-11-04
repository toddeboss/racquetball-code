#!/usr/local/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: results_front_new.pl
# Purpose: Frontend to results database 
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
# 1/8/13	tboss	adding most matchups
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
   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

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
   elsif ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch') {
      $pwdfilename = 'cp30725_irf.txt';
   }   
   elsif ($form{'tour'} eq 'AMATEUR') {
      $pwdfilename = 'cp30725_amateur.txt';
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
   
      print "<p><center><font size=+3><font color=\"#3333FF\">";
      print "Pro Results Query Page</font></font></center></p>\n";
      print "<form name=\"coupon_send\" ACTION=\"print_results_new.pl\" METHOD=\"POST\">";

      print "<p><b>Tour Selected</b>: <select name=\"tour\">";
      print "<option selected value='$form{'tour'}'>$form{'tour'}";
      print "</select> (Hit Back to select a different tour or <a href=\"http://www.proracquetballstats.com/cgi-bin/choose_tour.pl\">Click Here</a>)<p>";

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
      $sth->execute;
      
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
      $sth->execute;
      
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
      $sth->execute;
      
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
      $sth->execute;
      
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
      $sth->execute;
      
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
      $sth->execute;
      
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

      # Head to Head options
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
   
      print "<p><center><font size=+3><font color=\"#3333FF\">";
      print "Pro Results Query Page</font></font></center></p>\n";
      print "<form name=\"coupon_send\" ACTION=\"print_results_new.pl\" METHOD=\"POST\"";
   
      $tour=$form{'tour'};
   
      if ($form{'tour'} eq 'IRFsumm' || $form{'tour'} eq 'IRFmatch') {
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
	  
	  
      #print "<p><b>Tour Selected<b>: $tour<p>";
   
      print "<p><b>Tour Selected</b>: <select name=\"tour\">";
      print "<option selected value='$form{'tour'}'>$form{'tour'}";
      print "</select> (Hit Back to select a different tour or <a href=\"http://www.proracquetballstats.com/cgi-bin/choose_tour.pl\">Click Here</a>)<p>";
   
      # 10/4/13: putting in banner selection text instead of depending on hand-editing perl files every update.
      $sql = "select last_update_date,banner_text from banner"; 
      printf "$sql<br>" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;
   
      while (@row = $sth->fetchrow_array) {
         $lastupdatedate=$row[0];
         $bannertext=$row[1];
      }
    
      print "<b>$tour Database Last Updated $lastupdatedate</b>: $bannertext<br>";
   
      print "<p><b>Page Instructions</b>: Click on one of the pre-built queries to ";
      print "run the selection.  If any box is selected, any 'Submit Form' button will work.";
   
   
#--------------------------------------------------------------------------------------------------
# IRF Summary Data
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
         $sth->execute;
      
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
         $sth->execute;
      
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
         $sth->execute;
   
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
         $sth->execute;	  
   
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
         $sth->execute;
      
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

      if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
         print "<hr>";
	  
#-------------
# By Event
#-------------	  
	  
         $sql = "select event,date,city,season,tour from results_doubles where round='2' order by tmp_date desc"; 
		 
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
      
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
   	  
         print "<input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred ";
         print "at the tourney.  All known qualifiers are included. ";	  
   	  
         
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";	  
	  
#-------------
# By Season/Year
#-------------
      
         print "<hr>";
         print "Select Season: ";
   
         print "<select name=\"season\">";
         print "<option selected value=0>(none)";
         
         $sql = "select distinct season from results_doubles order by season desc"; 
   	  
         printf "<br>$sql\n" if $debug;      
         $sth = $dbh->prepare($sql);
         $sth->execute;
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            print "<option value='$name'>$name";
         }
         print "</select><p>";
   
   	  
         print "<input type='radio' name='query' value='finals_by_season'><b>Finals by Season</b>: This query will list the finals of every tourney for the selected season";	  
   	  
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";	
		 
#-------------
# By Player
#-------------

         print "<hr>";
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
         $sth->execute;
      
      
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

		 print "<input type='radio' name='query' value='player_wl_dbls'><b>Player Overall W-L record</b>: This will list the player's Won-Lost record, overall and by season ";

		 print "<br><input type='radio' name='query' value='player_wl_bypartner'><b>Player W-L record by partner</b>: This will list the player's Won-Lost record, 
		 in the whole database grouped by partner";
		 
         print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  John Doe: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";	 
		 
         print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically</b>: This query will list every match that the player has in the DB, earliest to latest/Ascending";
         print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";
		 
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";		
		 
		 
#-------------
# Misc tour stats
#-------------

         print "<hr>";
		 
         print "<p><input type='radio' name='query' value='all_finals'><b>All Finals</b>: This query will list all the finals of every tourney 
		 in the database";	  
         print "<br><input type='radio' name='query' value='season_summary_all'><b>Career Season Summaries</b>:  This will list the \"Season Summary\" career totals for all players in the database (15 second query).";		 
   	  
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			 
		 
   	  
      } # if ($form{'tour'} eq 'IRTdbls'): just limited doubles queries for now, may incorporate back in below later.




#--------------------------------------------------------------------------------------------------
# Singles Match Results
#--------------------------------------------------------------------------------------------------


#-------------
# By Event
#-------------

# 10/11/17: created this huge if-then-else so that we could call different IRF queries
      if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
         print "<hr>";
   
         if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            $sql = "select event,date,city,season,tour from results_doubles where round='2' order by tmp_date desc"; 
         }
         else {
            $sql = "select event,date,city,season,tour from results where round='2' order by tmp_date desc,event;"; 
         }
   
         printf "$sql<br>" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
      
   
         if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            print "<b>$tour Doubles Match Results Data: match by match Results database</b><p>";
         }
         else {
            print "<b>$tour Singles Match Results Data: Singles only match by match Results database</b><p>";
         }
   
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
      
         print "<p><input type='radio' name='query' value='all_matches_per_event'><b>All matches per event</b>: This query will list every match that occurred ";
         print "at the tourney.  All known qualifiers are included. ";
      
         print "<br><input type='radio' name='query' value='qsf_per_event'><b>Quarters, Semis and Final per Event</b>: Quarters, Semis and Finals";
         
         print "<br><input type='radio' name='query' value='seed_report_per_event'><b>Upsets by Seed Report per Event</b>: Lists all upsets by seeding for the event.  Caveat; seeding only guaranteed to be populated from 2010 onwards.";
        
         print "<br><input type='radio' name='query' value='draw_size_per_event'><b>Draw Size per Event</b>: Gives the size of the draw per Event.";
         
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";


#-------------
# By Season/Year
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
         
         if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            $sql = "select distinct season from results_doubles order by season desc"; 
         }
         else {
            $sql = "select distinct season from results order by season desc"; 
         }
         
         $sth = $dbh->prepare($sql);
         $sth->execute;
      
         while (@row = $sth->fetchrow_array) {
            $name=$row[0];
            print "<option value='$name'>$name";
         }
         print "</select>\n";
         printf "<br>$sql\n" if $debug;
      
         if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' ) {
            print "<p><input type='radio' name='query' value='finals_by_season'><b>Finals by Year</b>: This query will list the finals of every tourney for the selected year";
            print "<br><input type='radio' name='query' value='qsf_by_season'><b>Quarters, Semis, Final by Year</b>: Quarters, Semis and Finals for a Year";
         }
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            print "<p><input type='radio' name='query' value='finals_by_season'><b>Finals by Season</b>: This query will list the finals of every tourney for the selected season";
            print "<br><input type='radio' name='query' value='qsf_by_season'><b>Quarters, Semis, Final by Season</b>: Quarters, Semis and Finals for a Season";
            print "<br><input type='radio' name='query' value='distinct_winners'><b>Distinct Winners per Season</b>: Number of distinct Tourney winners in a season";
            print "<br><input type='radio' name='query' value='season_ending_rankings'><b>Season-Ending Rankings</b>: Season Ending Rankings per season";
            print "<br><input type='radio' name='query' value='season_summary_allplayers'><b>Season Summaries for all Players</b>:  This will list the \"Season Summary\" totals for all players who appeared in a season.";
      
            print "<br><input type='radio' name='query' value='statistical_abstract_byseason'><b>Statistical Abstract Stats for the Season</b>: Evan Prichard's Statistical Abstracts (<b>beta</b>)";
      
            print "<br><input type='radio' name='query' value='highest_seeds'><b>Highest Seeds to...</b>: Highest Seeds to win, make a final, etc.  Data for the chose season only (see below for same report for the whole database). Fyi: Seeding data only guaranteed to be available starting with the 2010-11 season; data is spotty prior to that.";   
 
			}

		 
         print "<br><input type='radio' name='query' value='draw_size_per_season'><b>Draw Size per Event for Season</b>: Gives the size of the draw in all events for the Season.";
      
      
         # commenting out until have time to fix it.
         #print "<br><input type='radio' name='query' value='season_seed_report'><b>Season Seed Report</b>: Lists all the leading players and their seed per event for a season. Fyi: Seeding data only available starting with the 2010-11 season";
      
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";



#-------------
# By Tourney Category just for Amateur/IRF events
#-------------


         if ($form{'tour'} eq 'AMATEUR' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";
         
            print "<option value='USA Mens Open'>USA Mens Open";
            print "<option value='USA Womens Open'>USA Womens Open";
            print "<option value='Mexico Mens Open'>Mexico Mens Open";
            print "<option value='Mexico Womens Open'>Mexico Womens Open";
            print "<option value='Canada Mens Open'>Canada Mens Open";
            print "<option value='Canada Womens Open'>Canada Womens Open";
            print "<option value='USA All'>All USA Mens and Womens Events";
            print "<option value='Mexico All'>All Mexico Mens and Womens Events";		
            print "<option value='Canada All'>All Canadian Mens and Womens Events";
            print "<option value='All Men'>All Mens Events for all Countries";
            print "<option value='All Women'>All Womens Events for all Countries";		

            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
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
            print "<option value='Pan American Championships - Mens Open'>Pan American Championships Mens Open";
            print "<option value='Pan American Championships - Womens Open'>Pan American Championships Womens Open";
            print "<option value='World Championships - Mens Open'>World Championships Mens Open";
            print "<option value='World Championships - Womens Open'>World Championships Womens Open";
			print "<option value='Pan American Games - Mens Open'>Pan American Games Mens Open";
            print "<option value='Pan American Games - Womens Open'>Pan American Games Womens Open";
			print "<option value='Pan American Sports Festival - Mens Open'>Pan American Sports Festival Mens Open";
            print "<option value='Pan American Sports Festival - Womens Open'>Pan American Sports Festival Womens Open";
			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
			print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
         }

         if ($form{'tour'} eq 'JUNIOR' ) {
            print "<hr>";
   
            print "Select Tourney Category: ";

            print "<select name=\"category\">";
            print "<option selected value=0>(none)";

            print "<option value='All Boys 18U'>All Boys 18U competitions, across all federations";
            print "<option value='All Boys 16U'>All Boys 16U competitions, across all federations";
            print "<option value='All Girls 18U'>All Girls 18U competitions, across all federations";
            print "<option value='All Girls 16U'>All Girls 16U competitions, across all federations";			
            print "<option value='All IRF'>All IRF Junior competitions, Boys and Girls";
            print "<option value='All USA'>All USA competitions, Boys and Girls";
            print "<option value='All Mexico'>All Mexican competitions, Boys and Girls";
            print "<option value='All Canada'>All Canadian competitions, Boys and Girls";
            print "<option value='All IRF Boys'>All IRF Junior competitions, Boys only";
            print "<option value='All USA Boys'>All USA competitions, Boys only";
            print "<option value='All Mexico Boys'>All Mexican competitions, Boys only";
            print "<option value='All Canada Boys'>All Canadian competitions, Boys only";
            print "<option value='All IRF Girls'>All IRF Junior competitions, Girls only";
            print "<option value='All USA Girls'>All USA competitions, Girls only";
            print "<option value='All Mexico Girls'>All Mexican competitions, Girls only";
            print "<option value='All Canada Girls'>All Canadian competitions, Girls only";
            print "<option value='IRF Boys 18U'>IRF Boys 18U";
            print "<option value='IRF Boys 16U'>IRF Boys 16U";
            print "<option value='IRF Girls 18U'>IRF Girls 18U";
            print "<option value='IRF Girls 16U'>IRF Girls 16U";
            print "<option value='USA Boys 18U'>USA Boys 18U";
            print "<option value='USA Boys 16U'>USA Boys 16U";
            print "<option value='USA Girls 18U'>USA Girls 18U";
            print "<option value='USA Girls 16U'>USA Girls 16U";
            print "<option value='Mexico Boys 18U'>Mexico Boys 18U";
            print "<option value='Mexico Boys 16U'>Mexico Boys 16U";
            print "<option value='Mexico Girls 18U'>Mexico Girls 18U";
            print "<option value='Mexico Girls 16U'>Mexico Girls 16U";
            print "<option value='Canada Boys 18U'>Canada Boys 18U";
            print "<option value='Canada Boys 16U'>Canada Boys 16U";
            print "<option value='Canada Girls 18U'>Canada Girls 18U";
            print "<option value='Canada Girls 16U'>Canada Girls 16U";
			
            print "</select>\n";

            print "<p><input type='radio' name='query' value='finals_per_category'><b>All Finals</b>: This query will list the finals of every tourney for the selected category throughout history";
            print "<br><input type='radio' name='query' value='qsf_per_category'><b>All Quarters, Semis, Final</b>: Quarters, Semis and Finals for all tourneys for the selected category throughout history";

            print "<br><input type='radio' name='query' value='draw_size_per_category'><b>Draw Size per Event</b>: Gives the size of the draw in all events for all tourneys for the selected category throughout history.";
			
            print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
            print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";			
         }		 
		 



#-------------
# By Player
#-------------

         print "<hr>";
         print "Select from All Players: ";
         print "<select name=\"player\">";
         print "<option selected value=0>(none)";
         
         if ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            $sql = "select distinct winner as name from results_doubles \
                    union \
                    select distinct loser as name from results_doubles order by name";  
         }
         else {
            $sql = "select distinct winner as name from results \
                    union \
                    select distinct loser as name from results order by name";         
         }
   
   
         printf "$sql\n" if $debug;
         $sth = $dbh->prepare($sql);
         $sth->execute;
      
      
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
      
         print "or Select regular tour player: <select name=\"player2\">";
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
         elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            $sql = "select winner from wins_doubles where wins > 7 order by winner";
         }      
         else {
            printf "Invalid Tour selected; you should never get here";
         }	 
		 
      
         $sth = $dbh->prepare($sql);
         $sth->execute;
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
         print "<br>(choose (none) for \"All Players\" if you're selecting a \"Regular tour player\".  ";
      
         if ($form{'tour'} eq 'IRT') {
            print "Regular tour player defined as having more than 50 wins on tour.)";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "Regular tour player defined as having more than 30 wins on tour.)";
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "Regular tour player defined as having more than 15 wins on tour.)";
         }
         elsif ($form{'tour'} eq 'IRFmatch') {
            print "Regular Intl player defined as having more than 3 wins in all International events.)";
         }
         elsif ($form{'tour'} eq 'AMATEUR') {
            print "Regular Nationals player defined as having more than 5 wins in all Amateur events.)";
         }
         elsif ($form{'tour'} eq 'JUNIOR') {
            print "Regular Junior Nationals player defined as having more than 10 wins in all Junior competitions.)";
         }		  
         elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            print "Regular $tour Pro Doubles player defined as having more than 7 wins in all Doubles events.)";
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
         printf "<br>$sql\n" if $debug; 
      
      
         if ($form{'tour'} eq 'IRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Cliff Swain: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Paola Longoria: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Alejandro Cardona: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Rocky Carson: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         elsif ($form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            print "<p><input type='radio' name='query' value='player_summary'><b>Season and Career Player Summary</b>: One line summary of a player's career by season (i.e.,  Alvaro Beltran: 2 Wins, 3 Finals, 2 Semis, 3 Quarters).";
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
         print "<br><input type='radio' name='query' value='player_wl'><b>Player Overall W-L record</b>: This will list the player's Won-Lost record, overall and by season ";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRTdbls' || $form{'tour'} eq 'LPRTdbls' || $form{'tour'} eq 'WRTdbls') {
            print "<br><input type='radio' name='query' value='player_rankings'><b>Season Ending Rankings Per Player</b>: by season";
         }
      
         print "<br><input type='radio' name='query' value='player_history'><b>Complete player match history chronologically</b>: This query will list every match that the player has in the DB, earliest to latest/Ascending";
         print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";
      
      
         print "<br><input type='radio' name='query' value='player_wins'><b>Player Wins</b>: This will list the all the players Wins chronologically";
         print "<br><input type='radio' name='query' value='player_losses'><b>Player Losses</b>: This will list all the players Losses chronologically";
      
         print "<br><input type='radio' name='query' value='player_games_wl'><b>Player Games and W-L record</b>: This will list the player's Won-Lost record, including Games won/lost, overall and by season";
      
      
         print "<br><input type='radio' name='query' value='head_to_head'><b>Player Head-to-Head Record Alphabetically</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by player name";
      
          print "<br><input type='radio' name='query' value='head_to_head_ttl'><b>Player Head-to-Head Record Ordered by most Matchups</b>: This will list a matrix of the player's head to head record w/ every other player in the DB, sorted by the number of times they've met from most to least";
      
         print "<br><input type='radio' name='query' value='head_to_head_3yr'><b>Player Head-to-Head Records in last 3 years </b>: To gauge more recent head-to-head records, this limits the search to the last three years for active players";
      
         print "<br><input type='radio' name='query' value='nontriv_head_to_head'><b>Non-Trivial Player Head-to-Head Record</b>: This is head-to-head among the more regular tour members (eliminates all matchups where there have been less than 2 meetings)";
      
         print "<br><input type='radio' name='query' value='nontriv_head_to_head_withresults'><b>Non-Trivial Player Head-to-Head Records With Results</b>: Shows non-trivial head-to-head records for players on tour, with the results.";
      
         print "<br><input type='radio' name='query' value='career_best'><b>Career Best Showing </b>: Shows a player's best showing on tour";
         print "<br><input type='radio' name='query' value='record_by_city'><b>Player Record by City</b>: Do players do better in particular cities?";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='player_record_5th'><b>Player record in 5-game matches</b>: 5-game match records by player ";
         }
         else {
            # do nothing: WRT and IRF play best of 3.  Same with IRT dbls, Amateurs, Juniors
         }
      
      
         print "<br><input type='radio' name='query' value='donuts'><b>Donut Counts</b>: Given and received";
         print "<br><input type='radio' name='query' value='twinkies'><b>'Twinkie' Counts</b>: (11-1 or 1-11 games), Given and received (inspired by the IRT stats page)";
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='ot_games'><b>OT Games</b>: What is a player's record in \"OT\" Games (games that go to super tiebreaker, or 12-10 or longer)";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='ot_games'><b>OT Games</b>: What is a player's record in \"OT\" Games (games that go to super tiebreaker, or 12-10 or longer): Note that this query won't make a ton of sense for now with the varying scoring over the years.";
         }
         else {
            # Do nothing: no "Overtime" games in the WRT/IRF since it is USAR scoring.  Same with IRTdbls, Amateurs, Juniors
         }
      
      
      
         print "<br><input type='radio' name='query' value='tourney_pct'><b>Tournament Winning Percentage</b>: Percentage of Tournaments won when entered.";
         print "<br><input type='radio' name='query' value='tourney_final_pct'><b>Finals Percentage</b>: Percentage of Tournaments reaching the Final";
      
         print "<br><input type='radio' name='query' value='player_wl_finals'><b>Player W-L record in Finals</b>: This will list the player's Won-Lost record in finals only, overall and by season";
         print "<br><input type='radio' name='query' value='player_wl_semis'><b>Player W-L record in Semis</b>";
         print "<br><input type='radio' name='query' value='player_wl_qtrs'><b>Player W-L record in Quarters</b>";
         print "<br><input type='radio' name='query' value='player_wl_16s'><b>Player W-L record in 16s</b>";
         print "<br><input type='radio' name='query' value='player_wl_early'><b>Player W-L record in Early rounds</b>: not as meaningful for 90s players b/c records are spotty for round of 32";
      
         print "<br><input type='radio' name='query' value='first_tour'><b>Player \"Firsts\"</b>: Prints a player's first Tour Event Appearance, First Tour Win, and the Number of Tourneys it took to win their first";
         print "<br><input type='radio' name='query' value='last_tour'><b>Player \"Lasts\"</b>: Prints a player's last Tour Event Appearance, Last Tour Win";
      
         print "<br><input type='radio' name='query' value='misc_player_stats'><b>Misc Player Stats</b>: How does a player fare when losing the first game?  When winning the first game?  etc";
      
      
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";

#-------------
# Misc/Tour Wide
#-------------
         print "<hr><b>Miscellaneous Tour Statistics</b>";
      
         print "<p><input type='radio' name='query' value='most_tourney_wins'><b>Most Tourney Wins</b>: This query will list the number of tourney wins in the database by player.";
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='best_season'><b>Best Seasons</b>: This query will print a list of the best player performances in a single season (by winning pct).";
         }
   
         print "<br><input type='radio' name='query' value='wl_pct_all'><b>Best Career Won/Loss Percentages</b>: This query will list all the Regular tour players and their career W/L percentages.";
         print "<br><input type='radio' name='query' value='season_summary_all'><b>Career Season Summaries</b>:  This will list the \"Season Summary\" career totals for all players in the database (15 second query).";
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'JUNIOR') {
            print "<br><input type='radio' name='query' value='most_appearances'><b>Most Appearances on Tour</b>: This query will list every player in the database and the number of times they played a tournament on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_wins'><b>Most Wins on Tour</b>: This query will list every player in the database and the number of Wins they have on the $form{'tour'} tour.";
            print "<br><input type='radio' name='query' value='most_losses'><b>Most Losses on Tour</b>: This query will list every player in the database and the number of Losses they have on the $form{'tour'} tour.";
         }

   
   
         print "<br><input type='radio' name='query' value='all_finals'><b>All Finals</b>: This query will list the results of every Final in the database.";
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='all_major_finals'><b>All Major Finals</b>: All Major Finals through the years.";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='all_major_finals'><b>All Major Finals</b>: All Major Finals through the years.";
         }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
            # do nothing; no majors in the WRT as of 2016; may adjust this later on
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         print "<br><input type='radio' name='query' value='longest_games'><b>Longest Games</b>: Matches with the longest single games";
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
         }
         elsif ($form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='longest_matches_all'><b>Longest Matches </b>: Most points scored in a match.  Note: WRT games are scored by USA-R amateur rules: 2 games to 15, tiebreaker to 11, so the max longest game is 15-14, 14-15, 11-10";
            print "<br><input type='radio' name='query' value='most_points_win'><b>Most Points in a Win</b>: Most points scored in a match by someone who won the match.";
            print "<br><input type='radio' name='query' value='most_points_loss'><b>Most Points in a Loss</b>: Most points scored in a match by someone who lost the match.";	
         }
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
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         if ($form{'tour'} eq 'IRT') {
            print "<br><input type='radio' name='query' value='longest_fifth'><b>Longest 5th game</b>: Matches with longest 5th game/Super Tiebreaker.";
         }
         elsif ($form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='longest_fifth'><b>Longest 5th game</b>: Matches with longest 5th game/Super Tiebreaker.  Includes rally and non-rally seasons.";
         }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
           # do nothing; no 5th games on WRT
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
      
      
         print "<br><input type='radio' name='query' value='all_negative'><b>All Negative Score Games</b>: A list of all matches with negative scores on tour.";
         print "<br><input type='radio' name='query' value='all_forfeits'><b>All Forfeit Score Games</b>: A list of all matches with forfeit scores on tour.";
         print "<br><input type='radio' name='query' value='all_forfeits_qsf'><b>All Forfeit Score Games in Q/S/F</b>: A list of all matches with forfeit scores on tour that occurred in the Quarters/Semis/Finals (this strips away most of the FFTs show in the above query because many happen in early rounds.";
      
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {
            print "<br><input type='radio' name='query' value='season_tourney_wins'><b>Season by Season Tourney Wins</b>: Marty Hogan suggested List of Tourney Winners by season; Provides an interesting look at year-end winner versus who won the most tourneys. ";
         }
      
         # Needs some thought 
         print "<br><input type='radio' name='query' value='longest_game_streak'><b>Longest Game Winning Streaks</b>: Longest Individual Game Winning Streaks.  Note that this report will skip forfeits only if they resulted in no on-court play.";
      
         print "<br><input type='radio' name='query' value='longest_match_streak'><b>Longest Match Winning Streaks</b>: Longest individual Match Winning Streaks.  Note: ffts break winning streaks in this report; we are working on a non-fft win streak version";
      
         print "<br><input type='radio' name='query' value='longest_match_streak_nofft'><b>Longest Match Winning Streaks, no Ffts</b>: Longest Match Winning Streaks not counting Ffts.";
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {  
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
            print "<br><input type='radio' name='query' value='tour_winners_age'><b>Ages of Tour Winners</b>: A list of every winner on tour, their age at first tour win, first appearance, last tour win, etc.";
         }  
    
         print "<br><input type='radio' name='query' value='oldest_player_to'><b>Oldest Players to...</b>:  Oldest player to win a tourney, make a final, etc.  ";
         print "<br><input type='radio' name='query' value='youngest_player_to'><b>Youngest Players to...</b>:  Youngest player to win a tourney, make a final, etc. ";
   
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT') {  
            print "<br><input type='radio' name='query' value='tour_champ_age'><b>Ages of All Tour Champs</b>: A report that shows the age of each season tour winner at season end.";
         }
      
         print "<br><input type='radio' name='query' value='highest_seeds_all'><b>Highest Seeds to...</b>: Highest Seeds to win, make a final, etc.  Reports across all available data, though the seeding is really only guaranteed to be available starting in the 2010-11 season for all tours.";
         print "<br><input type='radio' name='query' value='highest_seeds_f'><b>Highest Combined Seeds in Finals</b>: Highest Combined Seeds to comprise a Final(rpts suggested by Evan Pritchard).  Fyi: Seeding data only guaranteed to be available starting with the 2010-11 season; data is spotty prior to that.";   
         print "<br><input type='radio' name='query' value='highest_seeds_sf'><b>Highest Combined Seeds in Semis</b>: Highest Combined Seeds to comprise a Semis field.  Fyi: Seeding data only guaranteed to be available starting with the 2010-11 season; data is spotty prior to that.";   
         print "<br><input type='radio' name='query' value='highest_seeds_qsf'><b>Highest Combined Seeds in Qtrs/Semis/Final</b>: Highest Combined Seeds to comprise the Qtrs/Semis/Finals field.  Fyi: Seeding data only guaranteed to be available starting with the 2010-11 season; data is spotty prior to that.";   

		 
         if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT') {
            print "<br><input type='radio' name='query' value='us_open'><b>US Open Participation Summary</b>: Historical summary of all Participants in the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='us_open_drawsizes'><b>US Open Draw Sizes</b>: Draw Sizes for the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='us_open_qsf'><b>US Open Tourney Qtrs/Semis/Finals historically</b>: Historical summary of Q/S/F  Participants in the US Open (1996-present).";
            print "<br><input type='radio' name='query' value='season_summary_us_open'><b>US Open Results Summary</b>: Summary of US Open-only finishes, all players.";
      	  }
         elsif ($form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR') {
         # US Open queries not applicable to WRT, IRF, Amateurs, Juniors
         }
         else {
            printf "Invalid Tour selected; you should never get here";
         }
   	  
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
      
      
      } # if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR')
	     # this is end of very large if then else starting at line 680 or so to show all singles match queries.

   }  # else clause of if ($form{'tour'} eq 'CROSS') ... if clause is just showing h2h records.
   
  
   print "</form>\n";


#----------------------------------------------------------------------------------------
# 12/5/17: movement of all static links from former front-page to here.
#----------------------------------------------------------------------------------------


   printf "<hr>";
   
   if ($form{'tour'} eq 'IRT') {

      print "<b>IRT Men's Pro Tour History Pages</b>
             <p>
             <li><a href=\"http://www.proracquetballstats.com/irt/tour_history.html\">Tour History</a>: a bullet-point history of the Pro Tour since inception, with major events, rule changes, 
			 etc (this is a highlight list; obviously the events of the early 80s could really fill a book).  Last updated Oct 2017 with Doubles emphasis announcement
             <li><a href=\"http://www.proracquetballstats.com/irt/rule_changes.html\">Major Rule Change History</a>: History of major rule changes on tour (scoring and how to determine the year 
			 end champ).  Last Updated June 2010 with a detailed discussion of the upcoming 4 major rule changes proposed for the tour.
             <li><a href=\"http://www.proracquetballstats.com/irt/tour_name.html\">Tour Name History</a>: A history of the name of the Pro Tour.  Created/last updated Mar 2004.
             <li><a href=\"http://www.proracquetballstats.com/irt/commissioners.html\">Commissioner History</a>: A history of the Pro Tour Commissioners.  Last Updated Mid 2017 with Kulbeck's 
			 appointment as new commissioner.
             <li><a href=\"http://www.proracquetballstats.com/irt/cpro.html\">Canadian Professional Racquetball Organization History</a>: During the early 80s, the Catalina tour creation 
			 forced non-invitees off the pro tour, including Canadians, who formed their own tour.  Last updated July 2006 with some input from Mike 
			 Ceresia on tour winners/participants.
  
             <hr>
			 
             <b>IRT Men's Tour Player History Pages</b>
             <p>
             <li><a href=\"http://www.proracquetballstats.com/irt/year_end_titles.html\">Year End Title Winners</a> 1968-present.  Last updated May 2017 with Kane's 12th title.
             <li><a href=\"http://www.proracquetballstats.com/irt/year_end_summaries.html\">Year End Summaries</a> Year-long season narratives providing an editorial \"summary\" of each season.  
			 Summaries are written through out the year and are perpetually updated to the website.
             <li>Season End Standings by year: This data has been loaded into the database and is no longer maintained in a static file here; use season-specific queries to see all the rankings per year, 
			 get rankings per player or use the \"all top 10\" to get the top 10 for every season.
             <li><a href=\"http://www.proracquetballstats.com/irt/number_ones.html\">#1 Ranking holders who never won a title</a>: a list of players who have, at some point in their career, been #1 
			 but who do not have a year end title.  Last updated Nov 2010, with Ben Croft getting a #1 seed when Kane skipped a tourney and Dec 2017 with some
			 new research uncovering the fact that Inoue was ranked #1 for a time during the early 1990s.
             <li><a href=\"http://www.proracquetballstats.com/irt/top_players.html\">Top Players never to have finished #1</a>: a subjective list of top players of the eras of racquetball who never 
			 finished on top.  These are players who routinely were in the Top 8 rankings but who never made their way to the top.  Last updated Dec 2017 to
			 put in some new player detail from the 1990s and update current players.
             <li><a href=\"http://www.proracquetballstats.com/irt/number_of_titles.html\">Number of overall Titles</a>: A list of players and the number of titles they earned.  Last updated May 2017 with 
			 Kane's 12th title.
             <li><a href=\"http://www.proracquetballstats.com/irt/major_titles.html\">Major Championship Titles</a>: A list of the Major Title winners, by tournament.  \"Major\" titles are/were the 
			 \"Grand Slams\" of the day, equivalent of the US Open now, and includes the US Open, Tournament of Champions, Pro Nationals/Grand Nationals, 
			 Ektelon Nationals, Catalina Nationals, DP/Leach Nationals and the IRA Nationals.  Last updated Oct 2017 with Kane's unprecidented 13th US Open title.  Note; 
			 you can also run the above report calld 'All Major Finals' to get a list of all Major winners.
             <li><a href=\"http://www.proracquetballstats.com/irt/poty.html\">Player of the Year</a>: Player of the Year honors (data very spotty).  Also includes Rookie of the Year, Comeback Player of 
			 the Year winners (if known).  Last updated 11/19/07 with awards given post US Open banquet; I've never had good data here.
             <li>Number of Distinct Winners by year: replaced this static HTML page with the 'Distinct Winners Per Season' report per season.
             <li><a href=\"http://www.proracquetballstats.com/irt/greatest_upsets.html\">Greatest Upsets in tour History</a>: inspired by a meetandplay.com forum conversation in August, 2004.  
			 A list of great upsets and great runs in Pro Racquetball history.  Last updated 1/17/09 to add in Jose Rojas' California Open play, Dec 2017
			 to describe Pratt's improbable win.
             <li><a href=\"http://www.proracquetballstats.com/irt/best_never_heardof.html\">The Best Players you've never heard of</a>: inspired by a meetandplay.com forum conversation in September 
			 2008, this lists players who demonstrated real talent on tour but who didn't play full time, quit early or who had other reasons not to play.  Last 
			 updated 1/17/09 with more musings post NYC 09 event, Dec 2017 to add in some names.
             <li><a href=\"http://www.proracquetballstats.com/irt/keeley_goat.html\">Bo Keeley's Greatest of All Time Article</a>: Published in Feb 2013, Keeley discusses the four eras of Racquetball, 
			 the best player from each era, and talks about determining the G.O.A.T.
       <hr>";
			 
   }
   
   if ($form{'tour'} eq 'LPRT') {
   
      print "<b>LPRT Women's Pro tour History Pages</b>
             <p>
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_tour_history.html\">LPRT Tour History</a>: A brief overview of known Women's pro tour 
			 changes; needs more detail from those involved over the years.
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_rule_changes.html\">LPRT Major Rule Change History</a>: mostly capturing the various 
			 scoring changes that have occurred over the years.
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_tour_name.html\">LPRT Tour Name History</a>: as it has changed over the years.
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_commissioner.html\">LPRT Commissioner History</a>: very spotty with lots of turnover 
			 over the years.
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_summary_2017.html\">2017 LPRT Stat Summary</a>: 12/27/17 published LPRT 2017 Statistical 'year in review' summary

             
             <hr>
             <b>LPRT Women's Tour Player History Pages</b>
             <p>
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_year_end_titles.html\">Women's Year End Title Winners</a> 1970-present.  Also includes a 
			 summary of # of overall titles
             <li>Season End Standings by year: Loaded in Database: see Match Results Database and run the \"All Season Top 10 Lists\" report.
             <li>Major Championship Titles: Loaded into database; see Match Results Database and run the \"All Major Finals\" report.
             <li>Year End Summaries: tbd; may need some research
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_best_never_heardof.html\">Top Players never to have finished #1</a>: Also includes 
			 discussions on the best players who never won a tourney and a list of some of the better players from yesteryear.
             <li><a href=\"http://www.proracquetballstats.com/lprt/lprt_greatest_upsets.html\">Greatest Upsets in tour History</a>: a non-complete list that 
			 I've compiled as I've gone through some of the data entry cataloging great runs and big upsets.
       <hr>";

   
   }
   if ($form{'tour'} eq 'WRT') {
      print "<b>WRT Pro tour History Pages</b>
             <p>
             <li><a href=\"http://www.proracquetballstats.com/wrt/wrt_tour_history.html\">WRT Tour History</a>: A brief overview of the WRT, which started in late 2012 but began \"touring\" in earnest in 2013.
             <li>WRT Major Rule Change History: no real rule changes thus far to document.  WRT plays by IRF/Amateur scoring rules (2 games to 15, tiebreaker to 11, win by one).
             <li><a href=\"http://www.proracquetballstats.com/wrt/wrt_tour_name.html\">WRT Tour Name History</a>: No changes to document.
             <li><a href=\"http://www.proracquetballstats.com/wrt/wrt_commissioner.html\">WRT Commissioner History</a>: Overview of the WRT management.
             <hr>
			 
             <b>WRT Tour Player History Pages</b>
             <p>
             <li>WRT Year End Title Winners: 2013 to present; see seedings or POTY links.
             <li><a href=\"http://www.proracquetballstats.com/wrt/wrt_poty.html\">WRT Players of the Year</a>: Poty, Rookie of the Year, Sportsmanship, Most Improved and \"Fan Favorites.\"  Have 2015, 2016, waiting for older data.
             <li>Season End Standings by year: Loaded in Database: see Match Results Database and run the \"All Season Top 10 Lists\" report.  More data needed.
             <li>Major Championship Titles: No WRT Majors as of yet.
             <li>Year End Summaries: tbd
             <li>Top Players never to have finished #1: tbd
             <li>Greatest Upsets in tour History: tbd
       <hr>"; 
   }   
   
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
					</p>

					<hr />
					<ul class=\"footer-nav-links\">
						<li><a href=\"http://www.irt-tour.com\" target=\"_blank\">IRT</a> &bull;</li>
						<li><a href=\"http://www.lprt.com\" target=\"_blank\">LPRT</a> &bull;</li>
						<li><a href=\"http://www.worldracquetballtour.com/\" target=\"_blank\">WRT</a> &bull;</li>
						<li><a href=\"http://www.internationalracquetball.com\" target=\"_blank\">IRF</a> &bull;</li>
						<li><a href=\"https://www.teamusa.org/USA-Racquetball\" target=\"_blank\">USA-Racquetball</a> &bull;</li>
						<li><a href=\"http://www.racquetball.ca/racquetball.asp?languageID=1\" target=\"_blank\">Racquetball Canada</a> &bull;</li>
						<li><a href=\"http://www.fmr.mx\" target=\"_blank\">Federacion Mexicana de Raquetbol</a></li>
					</ul>
				</div>
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

