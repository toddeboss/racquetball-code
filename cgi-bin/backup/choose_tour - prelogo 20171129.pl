#!/usr/local/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: choose_tour.pl
# Purpose: Quick landing page to choose your tour 
#
# Dependencies: needs subsequently called script
# Todo
#
# Modification History
# Date          who		What
# 11/16/16      TBoss   creation (adapted from results_front.pl)
# 10/11/17		tboss	Added in IRF Main
# 10/13/17		tboss	Added first IRF match results database data
# 10/15/17		tboss	split out IRF summary and match data
# 10/17/17		tboss	Put in Amateur queries
# 10/21/17		tboss	 put in IRT doubles
# 10/23/17		tboss	 put in Cross-tour h2h query
# 11/13/17		tboss	updated text showing what data we have.
# 11/15/17		tboss	Added Juniors
# 11/27/17		tboss	putting in Html5/Bootstrap implementation details

#---------------------------------------------------------------

# set unbuffered i/o for STDOUT (probably not needed)
select((select(STDOUT), $|=1)[$[]);

# Debug flag: if set to 1, debugging info prints
$debug=0;

#---------------------------------------------------------------
# Main

&make_form;


#---------------------------------------------------------------
# Subroutine Defn's
#---------------------------------------------------------------

sub make_form
{

   # Print out a content-type for HTTP/1.0 compatibility
   print "Content-type: text/html\n\n";
   
   # Print out updated HTML5 tag
   print "<!DOCTYPE html>\n";
   
   print "<html lang=\"en\">";
   
  print "<head>
    <meta charset=\"utf-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\" />
    <meta name=\"description\" content=\"\">
    <meta name=\"author\" content=\"\">

    <title>Pro Results Query Tour Selection Page</title>

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
   
   print " <!-- Navigation -->
    <nav class=\"navbar navbar-expand-lg navbar-dark bg-dark fixed-top\">
      <div class=\"container\">
        <a class=\"navbar-brand\" href=\"#\">Pro Racquetball Stats</a>
        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarResponsive\" aria-controls=\"navbarResponsive\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">
          <span class=\"navbar-toggler-icon\"></span>
        </button>
        <div class=\"collapse navbar-collapse\" id=\"navbarResponsive\">
          <ul class=\"navbar-nav ml-auto\">
            <li class=\"nav-item active\">
              <a class=\"nav-link\" href=\"#\">Home
                <span class=\"sr-only\">(current)</span>
              </a>
            </li>
            <li class=\"nav-item\">
              <a class=\"nav-link\" href=\"#\">Other</a>
            </li>
            <li class=\"nav-item\">
              <a class=\"nav-link\" href=\"#\">Links</a>
            </li>
            <li class=\"nav-item\">
              <a class=\"nav-link\" href=\"#\">Here</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
	<div style=\"padding: 0 1%;\">";   
	
   

   print "<p><center><font size=+3><font color=\"#3333FF\">";
   print "Pro Results Query Tour Selection Page</font></font></center></p>\n";
   
   print "<form name=\"tour_send\" ACTION=\"results_front_new.pl\" METHOD=\"POST\">";
   
   print "<p><b>Page Instructions</b>: Select one of the tours below to enter the Match Reporting website: ";


   print "<p><input type='radio' name='tour' value='IRT'><b>IRT</b>: International Racquetball Tour; the primary Men's pro tour.  Data from 1974-present";

   print "<br><input type='radio' name='tour' value='LPRT'><b>LPRT</b>: Ladies Professional Racquetball Tour; the primary Women's pro tour.  Note that the Ladies data is only 'complete' from Apr 2009 to present; we're building the data from 1974-2009 but it is spotty, especially in the early 1980s and early 1990s.";

   print "<br><input type='radio' name='tour' value='WRT'><b>WRT</b>: World Racquetball Tour.  Data complete from 2012-present with exception of 2 early 2013 tourneys";

   print "<br>";

   print "<p><input type='radio' name='tour' value='IRTdbls'><b>IRT Doubles</b>: International Racquetball Tour Doubles; New Oct 2017 with new emphasis on doubles game on pro tour; has first 10 seeding tournaments dating to 2014 US Open plus all 'official' doubles events since.";

   print "<br>";
   
   print "<br><input type='radio' name='tour' value='IRFsumm'><b>IRF Summary</b>: International Racquetball Federation:  Tournament Summary Data New data as of Oct 2017 
   thanks to Dr. Timothy Baghurst.  <b>Under development Oct 2017</b>; not yet finalized; data has 1st/2nd/3rd place finishers for Singles & Doubles for all IRF events from 1981-2015</b>";
   print "<br><input type='radio' name='tour' value='IRFmatch'><b>IRF Match</b>: International Racquetball Federation:  Match Results Database.  Data available for all Major IRF events from 2004-2017.  Need 1981-2003.</b>";

   print "<br>";

   print "<br><input type='radio' name='tour' value='AMATEUR'><b>Amateur Nationals</b>: Amateur National tournaments: US Nationals, Mexican Nationals, Canadian Nationals.  
   <b>New Data as of Oct 2017</b>; USA Nationals available from 2006-2017, Canada 2002-2017, Mexico 2014-2017.  USA has just the winner from 1968-2005. Canada has limited data from 1975-2001 (sometimes finals only, sometimes q/s/f)";

   print "<br><input type='radio' name='tour' value='JUNIOR'><b>Juniors</b>: Junior Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds.  
   <b>New Data as of Nov 2017</b>; Data available: all junior nationals and IRF events from 2013-2017.  Only focusing on 18U/16U for Boys and Girls for the purposes of this database.";
   
   print "<p><input type='radio' name='tour' value='CROSS'><b>Cross-Tour Head to Heads</b>: Cross-tour Head to Head records.  This will log into IRT, WRT, IRF and 
   Amateur Singles tournaments to find ALL head to head matchups for players.";
   
   print "<p><input TYPE=\"submit\" value=\"Submit Form\">\n";
   print "<input TYPE=\"RESET\" value=\"Clear Form\"></p>\n";
   
   print "</form>\n";
   
   

   printf "<hr>Click <a href=\"http://www.proracquetballstats.com\">here</a> to go back to the Pro Racquetball Stats Home Page.<br>";
   printf "Click <a href=\"http://www.irt-tour.com\">here</a> to go to the IRT website.<br>";
   printf "Click <a href=\"http://www.lprtour.com/\">here</a> to go to the LPRT website.<br>";
   printf "Click <a href=\"http://www.worldracquetballtour.com//\">here</a> to go to the WRT website.<br>";
   printf "Click <a href=\"http://www.internationalracquetball.com\">here</a> to go to the IRF website. <br>";
   printf "Click <a href=\"https://www.teamusa.org/USA-Racquetball\">here</a> to go to the USA Racquetball website. <br>";
   printf "Click <a href=\"http://www.racquetball.ca/racquetball.asp?languageID=1\">here</a> to go to Canada Racquetball website. <br>";
   printf "Click <a href=\"http://www.fmr.mx \">here</a> to go to the Mexican National Racquetball Association website. <br>";   

   printf "<p>All data in this database here was compiled by Todd Boss, with assistance from many helpful people 
   (see <a href=\"http://www.bossconsulting.com/irt/sources.html\">Sources</a> for a list of people I have spoken with or who have sent data/magazines).  
   If you have additions, corrections or comments, please direct them to me, at <a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>.";

   printf "<p>at www.proracquetballstats.com<p>";
   
   print "</div></body></html>";
   
}

