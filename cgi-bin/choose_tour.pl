#!/usr/bin/perl

#--------------------------------------------------------------------------------
# Author: Todd Boss
# Name: choose_tour.pl
# Purpose: Quick landing page to choose your tour 
#
# Dependencies: 
# - needs subsequently called scripts to be present and executable
# - Needs Bootstrap code in root directory
# - needs expected logos present
#
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
# 12/7/17		tboss	reading master_navigation code form outside file for consistency.
# 12/12/17		tboss	put in LPRT doubles card, put in placeholders for WRT doubles card, updated doubles logos
# 1/10/18		tboss	put in Google analytics code, fixed bugs in card display with help of Wayne troubleshooting, added WOR logo placeholder.
# 1/17/18		tboss	put in WOR link at bottom too
# 2/18/18		tboss	Putting in AMATEURdbls logic
# 7/3/18		tboss	Put in IRFmatchdbls logic
# 7/15/18		tboss	put in WORdbls, moved Juniors to Amateur line on screen.
# 9/12/18		tboss	changed form method from POST to GET to print the direct URLs in the browser window
# 10/3/18		tboss	Added blog link at top.f
# 5/15/19		tboss	REmoving irf summary from the front page: 4 yrs out of date and has data entry errors, especially for team data (1988 men's worlds)
# 8/26/19		tboss	Updating text on screen to note WRT defunct
# 10/25/19		tboss	changed all PRS links to use https:// (wasn't an issue in this program, but was in all others)
# 3/18/20		tboss	Changed source url for IRT (changed url), LPRT (had error) on footer links.
# 4/6/20		tboss	Reorganized front page, adding Junior doubles
# 9/22/20		tboss	Added in propickleballstats.com if then else logic for code, added more debugging, split out front end form to PRS vs PPS
# 10/2/20		tboss	Added google analytics for PPS
# 8/12/24		tboss	change "PPA" to "PPS" for generic ProPickleballStats work, fixed links/acronyms to beupdated for mondern tours at bottom.

#---------------------------------------------------------------

# set unbuffered i/o for STDOUT (probably not needed)
select((select(STDOUT), $|=1)[$[]);

# Debug flag: if set to 1, debugging info prints
$debug=0;

#---------------------------------------------------------------
# Main

# 9/22/20: put in additional debugging to get web server environment variables printed out.
if ($debug eq 1) {
   print "Content-type: text/html", "\n\n";
   print "<HTML>", "\n";
   print "<HEAD><TITLE>About this Server</TITLE></HEAD>", "\n";
   print "<BODY><H1>About this Server</H1>", "\n";
   print "<HR><PRE>";
   print "Server Name:      ", $ENV{'SERVER_NAME'}, "<BR>", "\n";
   print "Running on Port:  ", $ENV{'SERVER_PORT'}, "<BR>", "\n";
   print "Server Software:  ", $ENV{'SERVER_SOFTWARE'}, "<BR>", "\n";
   print "Server Protocol:  ", $ENV{'SERVER_PROTOCOL'}, "<BR>", "\n";
   print "CGI Revision:     ", $ENV{'GATEWAY_INTERFACE'}, "<BR>", "\n";
   print "<HR></PRE>", "\n";

}

# 9/22/20: put in PPS vs PRS logic.

if ($ENV{'SERVER_NAME'} eq 'www.proracquetballstats.com') {
   &make_prs_form;
}
elsif ($ENV{'SERVER_NAME'} eq 'www.propickleballstats.com') {
   &make_pps_form;
}
elsif ($ENV{'SERVER_NAME'} eq '') {
   printf "Hopefully you're calling this from your local computer because the ENV{'SERVER_NAME'} is blank ";
}
else {
   printf "Error: choose_tour.pl being called from an unknown hostname ~~~$ENV{'SERVER_NAME'}~~~.  Exiting";
   exit;
}


#---------------------------------------------------------------
# Subroutine Defn's
#---------------------------------------------------------------

sub make_prs_form
{

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

	<title>Pro Racquetball Stats Tour Selection Page</title>

	<!-- Bootstrap core CSS -->
	<link href=\"/bootstrap/bootstrap.min.css\" rel=\"stylesheet\" />

	<link rel=\"stylesheet\" href=\"/bootstrap/fonts.googleapis.com.css?v=1\" />


	<!-- Custom styles for this template -->
	<style>
		body {
			padding-top: 54px;
			font-family:'Open Sans';
		}

		span.more_content {
			display:none;
		}

		span.more_link {
			color:#3b88c6;
			cursor:pointer;
			display:block;
		}

		ul.footer-nav-links {
			list-style-type:none;
			margin:0;
			padding:0;
		}

		ul.footer-nav-links li {
			display:inline;
		}



		/* ************** */
		/* tabular */
		table.main_nav_layout tr td {
			text-align: left;
			font-size: 0.8em;
			padding:15px 0;
		}

		table.main_nav_layout tr td.content_column {
			padding-left:5px;
		}

			table.main_nav_layout tr td.logo_column {
				text-align:center;
			}

				table.main_nav_layout tr td.logo_column img {
					margin: 0 12px;
					cursor: pointer;
					width: 80px;
					padding: 10px 2px;
					border: 1px solid #cccccc;
					background-color: #ebebeb;
				}

		table.main_nav_layout {
			border-collapse: collapse;
		}

			table.main_nav_layout tr {
				border:1px solid #ebebeb;
			}

			table.main_nav_layout tr:hover td {
				background-color:#f7f7f7;
			}

		div.tour_name {
			color: #3b88c6;
			font-weight: bold;
			padding-bottom: 4px;
			font-size: 1.2em;
			cursor: pointer;
		}
		/* ************** */
		/* tabular */




		/* ************** */
		/* cards */
		h4.card-title {
			font-size: 0.9rem;
			font-weight: bold;
			color: #3b88c6;
		}

		div.card-image-container {
			min-height:180px;
			text-align:center;
		}

		div.card-image-container img {
			max-width:100%;
		}

		.card-group .card {
			padding:1%;
		}

		p.card-text {
			font-size:0.9rem;
		}

		div.card-no-image {
			height: 20px;
			background-color: #ebebeb;
			margin-bottom: 10px;
			border: 1px solid #cccccc;
		}

		/* cards */
		/* ************** */
		
        \@media (min-width: 576px) { 
		   .card-group .card { 
		      flex: initial; margin-bottom: -2px; 
		   } 
		}
		\@media (min-width: 992px) {
			body {
				padding-top: 56px;
			}
		}

		\@media (min-width: 415px) {
			div.responsive-tabular {
				display:none;
			}
		}

		\@media (max-width: 414px) {
			div.responsive-cards {
				display: none;
			}
			h1.mt-5 {font-size:2rem;}
		}

		\@media (max-width: 415px) {
				.container_results_table {
					margin: 0px !important;
					padding: 0px !important;
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
   
   # 9/22/20: took out the blog line from the header; its been live for more than a year
   # 				<p class=\"lead\"><a href=\"https://blog.proracquetballstats.com\">click here to go to the new Pro Racquetball Stats blog at blog.proracquetballstats.com</a></p>
   
   print "<!-- Page Content -->
	<div class=\"container\">
		<div class=\"row\">
			<div class=\"col-lg-12 text-center\">
				<h1 class=\"mt-5\"><img src=\"../logos/PRS_logo.png\" width=250>&nbsp &nbsp Pro Racquetball Stats Tour Selection Page</h1>
				<p class=\"lead\">Select one of the tours below to enter the Match Reporting website</p>
			</div>
		</div>

		<!-- /cards -->
		<div class=\"responsive-cards\">
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRT_logo.jpg\" \" alt=\"IRT\" height=\"175\"  /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRT: International Racquetball Tour</h4>
						<p class=\"card-text\">The primary Men's pro tour. Data from 1974-present, covering all major tour-sanctioned events.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRT\">Launch IRT &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/LPRT_logo.png\" alt=\"LPRT\" height=\"162\" width=\"166\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">LPRT: Ladies Professional Racquetball Tour</h4>
						<p class=\"card-text\">The primary Women's pro tour. Note that the Ladies data is only 'complete' from Apr 2009 to present; we're building the data from 1974-2009 but it is spotty, especially in the early 1980s and early 1990s.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"LPRT\">Launch LPRT &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/Logo-WRT-2015-224x120.png\" alt=\"WRT\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">WRT: World Racquetball Tour</h4>
						<p class=\"card-text\">Data is complete from 2012 to Jan 2019; tour now defunct.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"WRT\">Launch WRT &gt;&gt;</a>
					</div>
				</div>
				<div class=\"col-lg-1\"></div>		
			</div>
			
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRTdbls_logo.jpg\" alt=\"IRTDbls\" width=\"275\"  /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRT Doubles</h4>
						<p class=\"card-text\"><span class=\"label label-success\">New Data as of Oct 2017:</span> new emphasis on doubles game on pro tour; has first 10 seeding tournaments dating to 2014 US Open plus all 'official' doubles events since.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRTdbls\">Launch IRTdbls &gt;&gt;</a>
					</div>
				</div>
				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/LPRTDoubles3.png\" alt=\"LPRTDbls\" width=\"150\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">LPRT Doubles</h4>
						<p class=\"card-text\"><span class=\"label label-success\">New Data as of Dec 2017:</span> All LPRT doubles events for last four seasons</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"LPRTdbls\">Launch LPRTdbls &gt;&gt;</a>
					</div>
				</div>
				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/WRTDoubles3.png\" alt=\"WRTDbls\" width=\"250\"  /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">WRT Doubles</h4>
						<p class=\"card-text\"><span class=\"label label-success\">All known WRT doubles events 2012-Jan 2019; tour now defunct</span></p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"WRTdbls\">Launch WRTdbls &gt;&gt;</a>
					</div>
				</div>
				<div class=\"col-lg-1\"></div>						
			</div>
			
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>					    
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRF_logo.jpg\" alt=\"IRFmatch\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRF Match</h4>
						<p class=\"card-text\">IRF match Results Database. Singles Data available for all Major IRF events from 1981-present.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRFmatch\">Launch IRFMatch &gt;&gt;</a>
					</div>
				</div>
				
			    <div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/AMATEUR_logo.jpg\" alt=\"AMATEUR\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">Amateur Nationals</h4>
						<p class=\"card-text\">
							USA Nationals, Mexican Nationals, Canadian Nationals. New Data as of Oct 2017; USA Nationals available from 2006-present,
							<span class=\"more_content\" data-more-id=\"amateur\">Canada 2002-present, Mexico 2014-present. USA has just the winner from 1968-2005. Canada has limited data from 1975-2001 (sometimes finals only, sometimes q/s/f)</span>
							<span class=\"more_link\" data-more-id=\"amateur\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"AMATEUR\" >Launch Amateur &gt;&gt;</a>
					</div>
				</div>	

				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/racquet-jr.jpg\" alt=\"Juniors\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">Juniors</h4>
						<p class=\"card-text\">
							Junior Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds.
							<span class=\"more_content\" data-more-id=\"juniors\">New Data as of Nov 2017; Data available: all junior nationals and IRF events from 2013-2017. Only focusing on 18U/16U for Boys and Girls for the purposes of this database.</span>
							<span class=\"more_link\" data-more-id=\"juniors\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"JUNIOR\">Launch Junior &gt;&gt;</a>
					</div>
				</div>				
				

	        </div>	
			
			
			<div class=\"row card-group\">
			    <div class=\"col-lg-1\"></div>	
				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRFmatchdbls_logo.jpg\" alt=\"IRFmatchdbls\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRF Doubles</h4>
						<p class=\"card-text\">IRF Doubles Results Database. Doubles Data being built for 1981-present</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRFmatchdbls\">Launch IRFMatchdbls &gt;&gt;</a>
					</div>
				</div>
				
			    <div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/AMATEURDbls_logo.jpg\" alt=\"AMATEURdbls\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">Amateur Doubles</h4>
						<p class=\"card-text\">
							USA/Can/Mexico National Amateur Doubles. New Data as of Feb 2018; USA Nationals available from 2006-2018
							<span class=\"more_content\" data-more-id=\"amateur\">Canada inprogress, Mexico in progress. USA has just the winner from 1968-2005. </span>
							<span class=\"more_link\" data-more-id=\"amateur\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"AMATEURdbls\" >Launch AmateurDbls &gt;&gt;</a>
					</div>
				</div>
				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/JUNIORdbls_logo.jpg\" alt=\"JUNIORdbls\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">Juniors</h4>
						<p class=\"card-text\">
							Junior Doubles Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds.
							<span class=\"more_content\" data-more-id=\"juniors\">New Data as of Mar 2020: winners-only of all Junior Dbls competitions</span>
							<span class=\"more_link\" data-more-id=\"juniors\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"JUNIORdbls\">Launch Junior Dbls &gt;&gt;</a>
					</div>
				</div>
				
				<div class=\"col-lg-1\"></div>						
			</div>
			<div class=\"row card-group\">		
				<div class=\"col-lg-1\"></div>					
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/wor-logo.png\" alt=\"WOR\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">WOR</h4>
						<p class=\"card-text\">World Outdor Racquetball (limited data for now)</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"WOR\">Launch WOR &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/WORDbls_logo.jpg\" alt=\"WORdbls\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">WORdbls</h4>
						<p class=\"card-text\">World Outdor Racquetball Doubles (limited data for now)</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"WORdbls\">Launch WORdbls &gt;&gt;</a>
					</div>
				</div>				
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/CliffSudsycroppedcleaned.jpg\" alt=\"H2H\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">Cross-Tour Head-to-Heads</h4>
						<p class=\"card-text\">Cross-tour Head to Head records. This will log into IRT, WRT, IRF, Amateur Singles and Juniors tournaments to find ALL head to head matchups for players.  (Image courtesy of Killshot magazine Instructional issue 1995)</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"CROSS\">Launch Cross H2H &gt;&gt;</a>
					</div>
				</div>
				<div class=\"col-lg-1\"></div>
			</div>
		</div>
		<!-- /cards -->


		<!-- tabular -->
		<div class=\"responsive-tabular\">
			<div class=\"row\">
				<div class=\"col-lg-1\"></div>
				<div class=\"col-lg-10 text-center\">
					<!--Bacon ipsum dolor amet capicola pig venison shoulder, buffalo short ribs porchetta. Salami flank pork, prosciutto buffalo andouille porchetta. Beef ribs chuck tongue alcatra cow. Tongue strip steak capicola jowl drumstick pig t-bone buffalo pork belly picanha bacon short loin turkey ribeye porchetta. Kevin tongue ham filet mignon sausage prosciutto cow flank burgdoggen chicken pork loin swine salami. Andouille landjaeger swine ball tip jerky pork loin turducken tongue kielbasa cow. Sausage bresaola shoulder leberkas ham andouille meatball shank salami filet mignon chicken beef short loin flank.-->
					<table class=\"main_nav_layout\">
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRT_logo.jpg\" data-tour-name=\"IRT\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRT\">IRT: International Racquetball Tour</div>
								<div>The primary Men's pro tour. Data from 1974-present, covering all major tour-sanctioned events.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/LPRT_logo.png\" data-tour-name=\"LPRT\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"LPRT\">LPRT: Ladies Professional Racquetball Tour</div>
								<div>The primary Women's pro tour. Note that the Ladies data is only 'complete' from Apr 2009 to present; we're building the data from 1974-2009 but it is spotty, especially in the early 1980s and early 1990s.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/Logo-WRT-2015-224x120.png\" data-tour-name=\"WRT\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"WRT\">WRT: World Racquetball Tour</div>
								<div>Data is complete from 2012 to Jan 2019; tour now defunct.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRTdbls_logo.jpg\" data-tour-name=\"IRTdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRTdbls\">IRT Doubles</div>
								<div>New data Oct 2017 with new emphasis on doubles game on pro tour; has first 10 seeding tournaments dating to 2014 US Open plus all 'official' doubles events since.</div>
							</td>
						</tr>

						<tr>
							<td class=\"logo_column\"><img src=\"/logos/LPRTDoubles3.png\" data-tour-name=\"LPRTdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"LPRTdbls\">LPRT Doubles</div>
								<div>New Data as of Dec 2017:</span> All LPRT doubles events for last four seasons</div>
							</td>
						</tr>

						<tr>
							<td class=\"logo_column\"><img src=\"/logos/WRTDoubles3.png\" data-tour-name=\"WRTdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"WRTdbls\">WRT Doubles</div>
								<div>All known WRT doubles events 2012-Jan 2019; tour now defunct.</div>
							</td>
						</tr>
						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRF_logo.jpg\" data-tour-name=\"IRFmatch\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRFmatch\">IRF Match</div>
								<div>IRF Match Results Database. Singles Data available for all Major IRF events from 2004-present.</div>
							</td>
						</tr>
					
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/AMATEUR_logo.jpg\" data-tour-name=\"AMATEUR\" /></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"AMATEUR\">Amateur Nationals</div>
								<div>Amateur National tournaments: US Nationals, Mexican Nationals, Canadian Nationals. New Data as of Oct 2017; USA Nationals available from 2006-present, Canada 2002-present, Mexico 2014-present. USA has just the winner from 1968-2005. Canada has limited data from 1975-2001 (sometimes finals only, sometimes q/s/f)</div>
							</td>
						</tr>

						<tr>
							<td class=\"logo_column\"><img src=\"/logos/racquet-jr.jpg\" data-tour-name=\"JUNIOR\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"JUNIOR\">Juniors</div>
								<div>Junior Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds. New Data as of Nov 2017; Data available: all junior nationals and IRF events from 2013-2017. Only focusing on 18U/16U for Boys and Girls for the purposes of this database.</div>
							</td>
						</tr>
						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRFmatchdbls_logo.jpg\" data-tour-name=\"IRFmatchdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRFmatchdbls\">IRF Doubles</div>
								<div>IRF Doubles Results Database. Doubles Data being built for 1981-present</div>
							</td>
						</tr>	

						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/AMATEURDbls_logo.jpg\" data-tour-name=\"AMATEURdbls\" /></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"AMATEURdbls\">Amateur National Doubles</div>
								<div>USA/Can/Mexico National Amateur Doubles. New Data as of Feb 2018.  USA Nationals available from 2006-2018 fully.  Canada inprogress, Mexico in progress. USA has just the winner from 1968-2005.</div>
							</td>
						</tr>
						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/JUNIORdbls_logo.jpg\" data-tour-name=\"JUNIORdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"JUNIORdbls\">Junior Doubles</div>
								<div>Junior Doubles Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds.</div>
							</td>
						</tr>		
						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/wor-logo.png\"  data-tour-name=\"WOR\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"WOR\">WOR: World Outdoor Racquetball</div>
								<div>World Outdor Racquetball (limited data for now)</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/WORDbls_logo.jpg\"  data-tour-name=\"WORdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"WORdbls\">WORdbls: World Outdoor Racquetball Doubles</div>
								<div>World Outdor Racquetball Doubles (limited data for now)</div>
							</td>
						</tr>						
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/CliffSudsycroppedcleaned.jpg\"  data-tour-name=\"CROSS\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"CROSS\">Cross-Tour Head to Heads</div>
								<div>Cross-tour Head to Head records. This will log into IRT, WRT, IRF, Amateur Singles and Juniors tournaments to find ALL head to head matchups for players.   (Image courtesy of Killshot magazine Instructional issue 1995)</div>
							</td>
						</tr>
					</table>

				</div>
				<div class=\"col-lg-1\"></div>
			</div>
		</div>
		<!-- /tabular -->

		<hr />

		<div class=\"row\">
			<div class=\"col-lg-1\"></div>
			<div class=\"card\">
				<div class=\"card-header\">
					Data Sources
				</div>
				<div class=\"card-body\">
					<p class=\"card-text\">
						All data in this database here was compiled by Todd Boss, with assistance from many helpful people
						(see <a href=\"https://www.proracquetballstats.com/irt/sources.html\">Sources</a> for a list of people I have spoken with or who have 
						sent data/magazines).
						If you have additions, corrections or comments, please direct them to me, at 
						<a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>.  This great new interface was designed by Southern California-based UI/UX developer and racquetball enthusiast  
						<a href=\"https://www.linkedin.com/in/wayne-saucier/\">Wayne Saucier</a> by manipulating Bootstrap UI/UX code; I owe him a huge debt of gratitude for 
						volunteering his time to make this site look a ton better than it used to!
					</p>

					<hr />
					<ul class=\"footer-nav-links\">
						<li><a href=\"https://www.irttour.com\" target=\"_blank\">IRT</a> &bull;</li>
						<li><a href=\"https://www.lprtour.com\" target=\"_blank\">LPRT</a> &bull;</li>
						<li><a href=\"https://www.worldracquetballtour.com/\" target=\"_blank\">WRT</a> &bull;</li>
						<li><a href=\"https://worldoutdoorracquetball.net/\" target=\"_blank\">WOR</a> &bull;</li>
						<li><a href=\"https://www.internationalracquetball.com\" target=\"_blank\">IRF</a> &bull;</li>
						<li><a href=\"https://www.teamusa.org/USA-Racquetball\" target=\"_blank\">USA-Racquetball</a> &bull;</li>
						<li><a href=\"https://www.racquetball.ca/racquetball.asp?languageID=1\" target=\"_blank\">Racquetball Canada</a> &bull;</li>
						<li><a href=\"https://www.fmr.mx\" target=\"_blank\">Federacion Mexicana de Raquetbol</a></li>
					</ul>
				</div>
			</div>
			<div class=\"col-lg-1\"></div>
		</div>

	</div>";   
	
# email protection code
# <a href=\"/cdn-cgi/l/email-protection#463224293535062429353525292835332a322f28216825292b\"><span class=\"__cf_email__\" data-cfemail=\"7d091f120e0e3d1f120e0e1e12130e08110914131a531e1210\">[email&#160;protected]</span></a>

# actual email href
# <a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>	

   print "<script src=\"/bootstrap/jquery.min.js\"></script>
	
	<form id=\"frm_tour\" name=\"tour_send\" ACTION=\"results_front_new.pl\" METHOD=\"GET\">
		<input type=\"hidden\" name=\"tour\" id=\"hdn_tour_name\" />
	</form>

	<script type=\"text/javascript\">
		var process_tour_selection = function (e) {
			var elem_click_target = get_click_target(e);
			var str_tour_name = \$(elem_click_target).attr(\"data-tour-name\");
			if (str_tour_name === '' || str_tour_name == undefined) {
				alert('error - tour name not correctly configured on radio button');
			} else {
				console.log('chosen tour: ' + str_tour_name);
				\$(\"#hdn_tour_name\").val(str_tour_name);
				\$(\"#frm_tour\").trigger(\"submit\");
			}
		};

		var get_click_target = function(e) {
			var obj_out;
			if (e.srcElement == undefined) {
				obj_out = e.target;
			} else {
				obj_out = e.srcElement;
			}
			return obj_out;
		}

		\$(document).ready(function () {
			\$('[data-tour-name]:not([data-tour-name=\"\"])').on('click', function (e) {
				process_tour_selection(e);
			})
		});
	</script>

	<p>&nbsp;</p>";
    
   print "</body></html>";
   
}




#---------------------------------------------------------------
# www.propickleballstats.com version
#---------------------------------------------------------------


sub make_pps_form
{

   # Print out a content-type for HTTP/1.0 compatibility
   print "Content-type: text/html\n\n";
   
   # Print out updated HTML5 tag
   print "<!DOCTYPE html>\n";
   
   print "<html lang=\"en\">";
   
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

	<title>Pro Pickleball Stats Tour Selection Page</title>

	<!-- Bootstrap core CSS -->
	<link href=\"/bootstrap/bootstrap.min.css\" rel=\"stylesheet\" />

	<link rel=\"stylesheet\" href=\"/bootstrap/fonts.googleapis.com.css?v=1\" />


	<!-- Custom styles for this template -->
	<style>
		body {
			padding-top: 54px;
			font-family:'Open Sans';
		}

		span.more_content {
			display:none;
		}

		span.more_link {
			color:#3b88c6;
			cursor:pointer;
			display:block;
		}

		ul.footer-nav-links {
			list-style-type:none;
			margin:0;
			padding:0;
		}

		ul.footer-nav-links li {
			display:inline;
		}



		/* ************** */
		/* tabular */
		table.main_nav_layout tr td {
			text-align: left;
			font-size: 0.8em;
			padding:15px 0;
		}

		table.main_nav_layout tr td.content_column {
			padding-left:5px;
		}

			table.main_nav_layout tr td.logo_column {
				text-align:center;
			}

				table.main_nav_layout tr td.logo_column img {
					margin: 0 12px;
					cursor: pointer;
					width: 80px;
					padding: 10px 2px;
					border: 1px solid #cccccc;
					background-color: #ebebeb;
				}

		table.main_nav_layout {
			border-collapse: collapse;
		}

			table.main_nav_layout tr {
				border:1px solid #ebebeb;
			}

			table.main_nav_layout tr:hover td {
				background-color:#f7f7f7;
			}

		div.tour_name {
			color: #3b88c6;
			font-weight: bold;
			padding-bottom: 4px;
			font-size: 1.2em;
			cursor: pointer;
		}
		/* ************** */
		/* tabular */




		/* ************** */
		/* cards */
		h4.card-title {
			font-size: 0.9rem;
			font-weight: bold;
			color: #3b88c6;
		}

		div.card-image-container {
			min-height:180px;
			text-align:center;
		}

		div.card-image-container img {
			max-width:100%;
		}

		.card-group .card {
			padding:1%;
		}

		p.card-text {
			font-size:0.9rem;
		}

		div.card-no-image {
			height: 20px;
			background-color: #ebebeb;
			margin-bottom: 10px;
			border: 1px solid #cccccc;
		}

		/* cards */
		/* ************** */
		
        \@media (min-width: 576px) { 
		   .card-group .card { 
		      flex: initial; margin-bottom: -2px; 
		   } 
		}
		\@media (min-width: 992px) {
			body {
				padding-top: 56px;
			}
		}

		\@media (min-width: 415px) {
			div.responsive-tabular {
				display:none;
			}
		}

		\@media (max-width: 414px) {
			div.responsive-cards {
				display: none;
			}
			h1.mt-5 {font-size:2rem;}
		}

		\@media (max-width: 415px) {
				.container_results_table {
					margin: 0px !important;
					padding: 0px !important;
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
   
   print "<!-- Page Content -->
	<div class=\"container\">
		<div class=\"row\">
			<div class=\"col-lg-12 text-center\">
				<h1 class=\"mt-5\"><img src=\"../logos/PPS_logo_placeholder.JPG\" width=250>&nbsp &nbsp Pro Pickleball Stats Tour Selection Page</h1>
				<p class=\"lead\">Select one of the tours below to enter the Match Reporting website</p>
			</div>
		</div>

		<!-- /cards -->
		<div class=\"responsive-cards\">
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/ppa-dark-header-315.png\" \" alt=\"Pro Singles\" height=\"175\"  /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">Professional Pickleball Association Singles</h4>
						<p class=\"card-text\">Pro Pickleball Singles; Men and Women</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"PPS\">Launch Singles &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/USAPA_Logo_Header.png\" alt=\"Pro Doubles\" height=\"162\" width=\"166\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">Professional Pickleball Association Doubles</h4>
						<p class=\"card-text\">Pro Pickleball Doubles; Men, Women, Mixed</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"PPSdbls\">Launch Doubles &gt;&gt;</a>
					</div>
				</div>			
			</div>
			

		<!-- /cards -->


		<!-- tabular -->
		<div class=\"responsive-tabular\">
			<div class=\"row\">
				<div class=\"col-lg-1\"></div>
				<div class=\"col-lg-10 text-center\">
					<table class=\"main_nav_layout\">
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/ppa-dark-header-315.png\" data-tour-name=\"Pro Singles\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"PPS\">Professional Pickleball Association Singles</div>
								<div>Pro Pickleball Singles; Men and Women</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/USAPA_Logo_Header.png\" data-tour-name=\"Pro Doubles\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"PPAdbls\">Professional Pickleball Association Doubles</div>
								<div>Pro Pickleball Doubles; Men, Women, Mixed</div>
							</td>
						</tr>

					</table>

				</div>
				<div class=\"col-lg-1\"></div>
			</div>
		</div>
		<!-- /tabular -->

		<hr />

		<div class=\"row\">
			<div class=\"col-lg-1\"></div>
			<div class=\"card\">
				<div class=\"card-header\">
					Data Sources
				</div>
				<div class=\"card-body\">
					<p class=\"card-text\">
						All data in this database here was compiled by Todd Boss, with assistance from many helpful people.
						If you have additions, corrections or comments, please direct them to me, at 
						<a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>.  The presentation interface here was designed by Southern California-based 
						UI/UX developer and racquetball enthusiast  
						<a href=\"https://www.linkedin.com/in/wayne-saucier/\">Wayne Saucier</a> by manipulating Bootstrap UI/UX code; I owe him a huge debt of gratitude for 
						volunteering his time to make this site look a ton better than it used to!
					</p>

					<hr />
					<ul class=\"footer-nav-links\">
						<li><a href=\"https://www.ppatour.com/\" target=\"_blank\">PPA</a> &bull;</li>
						<li><a href=\"https://www.majorleaguepickleball.net/\" target=\"_blank\">MLP</a> &bull;</li>
						<li><a href=\"https://www.theapp.global/\" target=\"_blank\">APP</a> &bull;</li>
						<li><a href=\"https://www.usopenpickleballchampionship.com/\" target=\"_blank\">US Open</a> &bull;</li>
						<li><a href=\"https://usapickleball.org/\" target=\"_blank\">USAP</a> &bull;</li>

					</ul>
				</div>
			</div>
			<div class=\"col-lg-1\"></div>
		</div>

	</div>";   
	
# email protection code
# <a href=\"/cdn-cgi/l/email-protection#463224293535062429353525292835332a322f28216825292b\"><span class=\"__cf_email__\" data-cfemail=\"7d091f120e0e3d1f120e0e1e12130e08110914131a531e1210\">[email&#160;protected]</span></a>

# actual email href
# <a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>	

   print "<script src=\"/bootstrap/jquery.min.js\"></script>
	
	<form id=\"frm_tour\" name=\"tour_send\" ACTION=\"results_front_new.pl\" METHOD=\"GET\">
		<input type=\"hidden\" name=\"tour\" id=\"hdn_tour_name\" />
	</form>

	<script type=\"text/javascript\">
		var process_tour_selection = function (e) {
			var elem_click_target = get_click_target(e);
			var str_tour_name = \$(elem_click_target).attr(\"data-tour-name\");
			if (str_tour_name === '' || str_tour_name == undefined) {
				alert('error - tour name not correctly configured on radio button');
			} else {
				console.log('chosen tour: ' + str_tour_name);
				\$(\"#hdn_tour_name\").val(str_tour_name);
				\$(\"#frm_tour\").trigger(\"submit\");
			}
		};

		var get_click_target = function(e) {
			var obj_out;
			if (e.srcElement == undefined) {
				obj_out = e.target;
			} else {
				obj_out = e.srcElement;
			}
			return obj_out;
		}

		\$(document).ready(function () {
			\$('[data-tour-name]:not([data-tour-name=\"\"])').on('click', function (e) {
				process_tour_selection(e);
			})
		});
	</script>

	<p>&nbsp;</p>";
    
   print "</body></html>";
   
}



