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
		

		@media (min-width: 992px) {
				

			body {
				padding-top: 56px;
			}

		}

		@media (min-width: 415px) {
			div.responsive-tabular {
				display:none;
			}
		}

		@media (max-width: 414px) {
			div.responsive-cards {
				display: none;
			}
			h1.mt-5 {font-size:2rem;}
		}

		@media (max-width: 415px) {
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
   
   print "<!-- Navigation -->
	<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark fixed-top\">
		<div class=\"container\">
			<a class=\"navbar-brand\" href=\"#\">Pro Racquetball Stats</a>
			<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarResponsive\" aria-controls=\"navbarResponsive\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">
				<span class=\"navbar-toggler-icon\"></span>
			</button>
			<div class=\"collapse navbar-collapse\" id=\"navbarResponsive\">
				<ul class=\"navbar-nav ml-auto\">
					<li class=\"nav-item active\">
						<a class=\"nav-link\" href=\"#\">
							Home
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

	<!-- Page Content -->
	<div class=\"container\">
		<div class=\"row\">
			<div class=\"col-lg-12 text-center\">
				<h1 class=\"mt-5\">Pro Results Query Tour Selection Page</h1>
				<p class=\"lead\">Select one of the tours below to enter the Match Reporting website</p>
			</div>
		</div>

		<!-- /cards -->
		<div class=\"responsive-cards\">
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/FinalIRTLogo-600.png\" \" alt=\"IRT\" height=\"152\" width=\"300\" /></div>
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
						<p class=\"card-text\">The primary Women's pro tour. Note that the Ladies data is only 'complete' from Apr 2009 to present.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"LPRT\">Launch LPRT &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/Logo-WRT-2015-224x120.png\" alt=\"WRT\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">WRT: World Racquetball Tour</h4>
						<p class=\"card-text\">Data is complete from 2012 to the present with the exception of 2 tournaments in early 2013.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"WRT\">Launch WRT &gt;&gt;</a>
					</div>
				</div>
				<div class=\"col-lg-1\"></div>
			</div>
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/rs=h_125.webp\" alt=\"IRTDbls\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRT Doubles</h4>
						<p class=\"card-text\"><span class=\"label label-success\">New Oct 2017:</span> new emphasis on doubles game on pro tour; has first 10 seeding tournaments dating to 2014 US Open plus all 'official' doubles events since.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRTdbls\">Launch IRTdbls &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRF_Logo.png\" alt=\"IRFsumm\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRF Tournament Summary</h4>
						<p class=\"card-text\">
							International Racquetball Federation: New data as of Oct 2017 thanks to Dr. Timothy Baghurst. Under development Oct 2017;
							<span class=\"more_content\" data-more-id=\"irf_tourney\">not yet finalized; data has 1st/2nd/3rd place finishers for Singles & Doubles for all IRF events from 1981-2015.</span>
							<span class=\"more_link\" data-more-id=\"irf_tourney\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRFsumm\">Launch IRFsumm &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRF.jpg\" alt=\"IRFmatch\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">IRF Match</h4>
						<p class=\"card-text\">International Racquetball Federation: Match Results Database. Data available for all Major IRF events from 2004-2017. Need 1981-2003.</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"IRFmatch\">Launch IRFMatch &gt;&gt;</a>
					</div>
				</div>
				<div class=\"col-lg-1\"></div>
			</div>
			<div class=\"row card-group\">
				<div class=\"col-lg-1\"></div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/usaracquetballmod_12115_1913_large.jpg\" alt=\"USA-R\" height=\"150\" width=\"300\" /></div>
					<div class=\"card-block\">
						<h4 class=\"card-title\">Amateur Nationals</h4>
						<p class=\"card-text\">
							US Nationals, Mexican Nationals, Canadian Nationals. New Data as of Oct 2017; USA Nationals available from 2006-2017,
							<span class=\"more_content\" data-more-id=\"amateur\">Canada 2002-2017, Mexico 2014-2017. USA has just the winner from 1968-2005. Canada has limited data from 1975-2001 (sometimes finals only, sometimes q/s/f)</span>
							<span class=\"more_link\" data-more-id=\"amateur\">more &gt;&gt;</span>
						</p>
						<a href=\"#\" class=\"btn btn-primary\" data-tour-name=\"AMATEUR\" >Launch Amateur &gt;&gt;</a>
					</div>
				</div>
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/IRF_JuniorWorlds_Logo2017.PNG\" alt=\"Juniors\"  width=\"300\" /></div>	
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
				<div class=\"card\" style=\"width: 20rem;\">
					<div class=\"card-image-container\"><img src=\"/logos/CliffSudsycroppedcleaned.jpg\" alt=\"H2H\"  width=\"300\" /></div>	
					<div class=\"card-block\">
						<h4 class=\"card-title\">Cross-Tour Head-to-Heads</h4>
						<p class=\"card-text\">Cross-tour Head to Head records. This will log into IRT, WRT, IRF, Amateur Singles and Juniors tournaments to find ALL head to head matchups for players.</p>
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
							<td class=\"logo_column\"><img src=\"/logos/FinalIRTLogo-600.png\" data-tour-name=\"IRT\"/></td>
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
								<div>Data complete from 2012-present with exception of 2 early 2013 tourneys.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/rs=h_125.webp\" data-tour-name=\"IRTdbls\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRTdbls\">IRT Doubles</div>
								<div>New Oct 2017 with new emphasis on doubles game on pro tour; has first 10 seeding tournaments dating to 2014 US Open plus all 'official' doubles events since.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRF_Logo.png\" data-tour-name=\"IRFsumm\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRFsumm\">IRF Summary</div>
								<div>International Racquetball Federation: Tournament Summary Data New data as of Oct 2017 thanks to Dr. Timothy Baghurst. Under development Oct 2017; not yet finalized; data has 1st/2nd/3rd place finishers for Singles & Doubles for all IRF events from 1981-2015.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRF.jpg\" data-tour-name=\"IRFmatch\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"IRFmatch\">IRF Match</div>
								<div>International Racquetball Federation: Match Results Database. Data available for all Major IRF events from 2004-2017. Need 1981-2003.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/usaracquetballmod_12115_1913_large.jpg\" data-tour-name=\"AMATEUR\" /></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"AMATEUR\">Amateur Nationals</div>
								<div>Amateur National tournaments: US Nationals, Mexican Nationals, Canadian Nationals. New Data as of Oct 2017; USA Nationals available from 2006-2017, Canada 2002-2017, Mexico 2014-2017. USA has just the winner from 1968-2005. Canada has limited data from 1975-2001 (sometimes finals only, sometimes q/s/f)</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/IRF_JuniorWorlds_Logo2017.PNG\" data-tour-name=\"JUNIOR\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"JUNIOR\">Juniors</div>
								<div>Junior Tournament Data: Junior Amateur National tournaments for USA, Mexico and Canada plus IRF Junior Worlds. New Data as of Nov 2017; Data available: all junior nationals and IRF events from 2013-2017. Only focusing on 18U/16U for Boys and Girls for the purposes of this database.</div>
							</td>
						</tr>
						<tr>
							<td class=\"logo_column\"><img src=\"/logos/CliffSudsycroppedcleaned.jpg\"  data-tour-name=\"CROSS\"/></td>
							<td class=\"content_column\">
								<div class=\"tour_name\" data-tour-name=\"CROSS\">Cross-Tour Head to Heads</div>
								<div>Cross-tour Head to Head records. This will log into IRT, WRT, IRF, Amateur Singles and Juniors tournaments to find ALL head to head matchups for players.</div>
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
						(see <a href=\"http://www.bossconsulting.com/irt/sources.html\">Sources</a> for a list of people I have spoken with or who have sent data/magazines).
						If you have additions, corrections or comments, please direct them to me, at <a href=\"mailto:tboss\@bossconsulting.com\">tboss\@bossconsulting.com</a>	.
					</p>

					<hr />
					<ul class=\"footer-nav-links\">
						<li><a href=\"http://www.irt-tour.com\" target=\"_blank\">IRT</a> &bull;</li>
						<li><a href=\"http://www.lprt.com\" target=\"_blank\">LPRT</a> &bull;</li>
						<li><a href=\"http://www.worldracquetballtour.com/\" target=\"_blank\">WRT</a> &bull;</li>
						<li><a href=\"http://www.internationalracquetball.com\" target=\"_blank\">IRF</a> &bull;</li>
						<li><a href=\"https://www.teamusa.org/USA-Racquetball\" target=\"_blank\">USA Racquetball</a> &bull;</li>
						<li><a href=\"http://www.racquetball.ca/racquetball.asp?languageID=1\" target=\"_blank\">Canada Racquetball</a> &bull;</li>
						<li><a href=\"http://www.fmr.mx\" target=\"_blank\">Mexican Nat'l RB Assoc.</a></li>
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
	
	<form id=\"frm_tour\" name=\"tour_send\" ACTION=\"results_front_new.pl\" METHOD=\"POST\">
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

