#!/usr/local/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: tour_results.pl
# Purpose: Tale of the Tape Custom code, created from results_front specifically to run one program
#
# Dependencies: DBI, MySQL being up and available.
# Todo
#
# Modification History
# Date      who	What
# 03/17/04  TBoss   creation (adapted from old Corrivo code, from papa code)
# ....
# 3/19/19	tboss	created, adapted from results_front_new.pl
# 9/5/19	tboss	added checked to the input tag to default the checkbox of the only report on the page.
# 10/9/19	tboss	Adding head_to_head_summary
# 10/25/19	tboss	changed all PRS links to use https://s://
# ....
# 1/21/20	tboss	created, adapted from tale_of_the_tape.pl to have a one-off program for calling tour results.


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

   # Print out a content-type for https:///1.0 compatibility
   print "Content-type: text/html\n\n";
   
   # Print out updated HTML5 tag
   print "<!DOCTYPE html>\n";   
   print "<html lang=\"en\">";
   
   print "<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src=\"https://s://www.googletagmanager.com/gtag/js?id=UA-112282142-1\"></script>
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
   elsif ($form{'tour'} eq 'JUNIOR') {
      $pwdfilename = 'cp30725_junior.txt';
   }  
   elsif ($form{'tour'} eq 'WOR' || $form{'tour'} eq 'WORdbls') {
      # 1/17/18: placeholder
	#  printf "World Outdoor Racquetball (WOR) data has not yet been loaded into the database.  <p><p>We are discussing/considering what tournaments
	#  and what data may make sense to include here at this time.  Please hit the 'Home' button to return to the tour select page.<br>";

      $pwdfilename = 'cp30725_wor.txt';
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


      # Log into Mysql
      $dbh = DBI->connect ($db_connect,$db_user,$db_password)  or die "Couldn't connect to database: " . DBI->errstr;

      # Print out a content-type for https:///1.0 compatibility
      #print "Content-type: text/html\n\n";
	  
      # Print out updated HTML5 tag
      #print "<!DOCTYPE html>\n";   
      print "<html lang=\"en\">\n<body>\n<title>Pro Results Query Page</title>\n";
   
      print "<img src=\"../logos/PRS_logo.png\" width=250><font size=+3><font color=\"#3333FF\">";
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
	  
	  
      #print "<p><b>Tour Selected<b>: $tour<p>";
   
      print "<p><b>Tour Selected</b>: <select name=\"tour\">";
      print "<option selected value='$form{'tour'}'>$form{'tour'}";
      print "</select> (Hit Back to select a different tour or <a href=\"https://://www.proracquetballstats.com/cgi-bin/choose_tour.pl\">Click Here</a>)<p>";
   
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
# Singles Match Results
#--------------------------------------------------------------------------------------------------



# 10/11/17: created this huge if-then-else so that we could call different IRF queries
      if ($form{'tour'} eq 'IRT' || $form{'tour'} eq 'LPRT' || $form{'tour'} eq 'WRT' || $form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'WOR') {


		 
#-------------
# By Player
#-------------

         print "<hr>";
         print "Select Player: ";
         print "<select name=\"player\">";
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
      
	 
		 print "<p>";

         print "<br><input type='radio' name='query' value='player_history_desc'><b>Complete player match history</b>: This query will list every match that the player has in the DB, latest to earliest/Descending";

		 
		 print "<p>";		 
          
         print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
         print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
  
  
   print "</form>\n";
   }


#----------------------------------------------------------------------------------------
# 12/5/17: movement of all static links from former front-page to here.
#----------------------------------------------------------------------------------------


   printf "<hr>";
   
    
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

