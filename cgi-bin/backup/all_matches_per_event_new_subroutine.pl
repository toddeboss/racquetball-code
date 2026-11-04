# saved off copy of original code 2/12/20 before implementing.

sub all_matches_per_event_new() {

   #$debug=1;
   
   printf "Doubles flag is $doubles_flag<p>" if $debug;
   
   printf "Entering all matches per event new, $form{'query'}<br>" if $debug;
   
   # boot strap code has a hard time reading the form variables.
   $tour=$form{'tour'};   
   
   if ($form{'event'} eq '0') {
      printf "<p>No Event selected (did you forget to select an event?  Hit back and select an event and re-submit<p>";
      next;
   }   

   ($event,$date)=split(/~/,$form{'event'});

   # 1/29/18: putting in rpt_tracking code
   my $subroutine = (caller(0))[3];
   &rpt_tracking($form{'tour'},$form{'query'},$form{'sum_event'},$form{'division'},$form{'category'},'0',$event,$form{'season'},$subroutine);

   if ($doubles_flag eq 'Yes') {
      # get the winners for the image.
      $sql = "select winner_p1, winner_p2 from results_doubles where event='$event' and round='2' and date='$date'";
      printf "$sql" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $winner1=$row[0];
         $winner2=$row[1];		 
      }     
      $sql = "select tour,city,date,source,season from results_doubles where event='$event' and round='2' and date='$date'";   
   }
   else {
      # get the winner for the image.
      $sql = "select winner from results where event='$event' and round='2' and date='$date'";
      printf "$sql" if $debug;
      $sth = $dbh->prepare($sql);
      $sth->execute;

      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
      }      
      $sql = "select tour,city,date,source,season from results where event='$event' and round='2' and date='$date'"; 
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
   
   # set the logo variable based on the tour
   $logo = &get_logo($date); 
   
   # Get tourney preview and wrap-up links
   $sql = "select preview_url from tourneys where event='$event'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $preview_url=$row[0];
   }   
   $sql = "select wrapup_url from tourneys where event='$event'";
   printf "$sql" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;

   while (@row = $sth->fetchrow_array) {
      $wrapup_url=$row[0];
   } 
   
   # set the "Season" button text
   
   $season_button_text="$tour $season";
   if ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'AMATEURdbls') { 
      $season_button_text="Amateur events for $season";   
   }
   

   # 9/4/19: adding photo accreditation code.
   ($photo_credit,$jpgname)= &get_photocredits($winner);   

   if ($doubles_flag eq 'Yes') {   
      print "<div class=\"jumbotron\"> 
  		<div class=\"container\"> 
  			<h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"150\">$tour $event</h1>
<P>Tournament Winners: <b>${winner1}/${winner2}</b></P> 
  			<p>Full Results Report: &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 	
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=finals_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   
   }
   else {
      if ($preview_url ne '') {
         print "<div class=\"jumbotron\"> 
  		   <div class=\"container\"> 
				<figure class=\"label inside bottom left\" data-label=\"Photo Credit: $photo_credit\" style=\"float:right; font-size:small !important;\">	
                   <img src=\"https://www.proracquetballstats.com/images/${jpgname}\" align=\"right\" width=\"350\" class=\"player-photo\" 
				      style text-align:center alt=\"$photo_credit\"> 			   
                </figure>
  			<h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"150\">$tour $event</h1>
            <P>Tournament Winner: <b>$winner</b></P> 
  			<p>Full Results Report: &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 
  			<p>Tourney Preview: <a href=\"$preview_url\" target=\"_blank\">$preview_url</a></p> 
  			<p>Tourney Wrap-Up: <a href=\"$wrapup_url\" target=\"_blank\">$wrapup_url</a></p> 				
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=qsf_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   
      }
      elsif ($wrapup_url ne '') {
         print "<div class=\"jumbotron\"> 
  		   <div class=\"container\"> 
				<figure class=\"label inside bottom left\" data-label=\"Photo Credit: $photo_credit\" style=\"float:right; font-size:small !important;\">	
                   <img src=\"https://www.proracquetballstats.com/images/${jpgname}\" align=\"right\" width=\"350\" class=\"player-photo\" 
				      style text-align:center alt=\"$photo_credit\"> 			   
                </figure>
  			<h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"150\">$tour $event</h1>
            <P>Tournament Winner: <b>$winner</b></P> 
  			<p>Full Results Report: &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 
  			<p>Tourney Wrap-Up: <a href=\"$wrapup_url\" target=\"_blank\">$wrapup_url</a></p> 				
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=qsf_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   
      }
      else {
	     if ($form{'tour'} eq 'IRFmatch' || $form{'tour'} eq 'IRFmatchdbls') {
            print "<div class=\"jumbotron\"> 
  		      <div class=\"container\"> 
				<figure class=\"label inside bottom left\" data-label=\"Photo Credit: $photo_credit\" style=\"float:right; font-size:small !important;\">	
                   <img src=\"https://www.proracquetballstats.com/images/${jpgname}\" align=\"right\" width=\"350\" class=\"player-photo\" 
				      style text-align:center alt=\"$photo_credit\"> 			   
                </figure>	
  			  <h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"300\">$tour $event</h1>
            <P>Tournament Winner: <b>$winner</b></P> 
  			<p>Full Results &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 	
            <p>Note: RR = Round Robin matches.  Seeding not determined until after the Round Robin matches.  Some events qualify players to the knockout rounds
	            based on RR results; if no seed is present, then player eliminated at the RR stage.<br>			
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=qsf_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   
         }	
	     elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'AMATEURdbls' || $form{'tour'} eq 'JUNIOR') {
            print "<div class=\"jumbotron\"> 
  		      <div class=\"container\"> 
				<figure class=\"label inside bottom left\" data-label=\"Photo Credit: $photo_credit\" style=\"float:right; font-size:small !important;\">	
                   <img src=\"https://www.proracquetballstats.com/images/${jpgname}\" align=\"right\" width=\"350\" class=\"player-photo\" 
				      style text-align:center alt=\"$photo_credit\"> 			   
                </figure>
  			  <h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"150\">$tour $event</h1>
            <P>Tournament Winner: <b>$winner</b></P> 
  			<p>Full Results &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 	
            <p>Note: Some amateur associations play a 3rd place game; if those results are known, it is shown.<br>
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=qsf_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   
         }	
		 else {
            print "<div class=\"jumbotron\"> 
  		      <div class=\"container\"> 
				<figure class=\"label inside bottom left\" data-label=\"Photo Credit: $photo_credit\" style=\"float:right; font-size:small !important;\">	
                   <img src=\"https://www.proracquetballstats.com/images/${jpgname}\" align=\"right\" width=\"350\" class=\"player-photo\" 
				      style text-align:center alt=\"$photo_credit\"> 			   
                </figure>
  			  <h1 class=\"display-4\"><img src=\"https://www.proracquetballstats.com/logos/${logo}\" align=\"left\" width=\"150\">$tour $event</h1>
            <P>Tournament Winner: <b>$winner</b></P> 
  			<p>Full Results &bull; $date &bull; $city &bull; <a href=\"$source\" target=\"_blank\">(results source: $source)</a></p> 	
  			<p><a class=\"btn btn-primary btn-lg\" href=\"https://www.proracquetballstats.com/cgi-bin/print_results_new.pl?tour=${form{'tour'}}&season=$season&query=qsf_by_season\" role=\"button\">$season_button_text</a></p> 
  		</div> 
  	</div>";   	
         }	
	  }	  
   }

# 3/19/18: putting in explanation of the ? finals issue for New Orleans 2005
   if ($event eq 'Summer Cooler' && $date eq '8/29/2005') {
      printf "The 2005 Elmwood Summer Cooler Pro-Am was cancelled by the impending arrival of Hurricane Katrina.  The tournament was called off after the quarter finals round.  We left 
	          ? results for the semis, final and winner.  This event had been run every year since 1992 as the IRT season opener; there's never been another event
              held in New Orleans since.<P>";
   }   
   
# 11/22/17: putting in explanation of the finals issue from 2006 for Men's Open Canada
   if ($event eq '2006 Canadian National Racquetball Championships - Mens Open') {
      printf "A note about the 2006 Canadian Men's Open tournament: in 2006 Kane Waselenchuk defeated Mike Green in the finals of the Men's Open National championship on the court.  Subsequently he tested positive for banned substances.  Officially, Canada stripped him of his 2006 
title, awarding it to Mike Green and elevating the semi-finalists to co-2nd place.  I have chosen to leave it here in the database with 
this explanation; when running career title reports, technically Green has one more than the database gives him credit for and Waselenchuk one less.<P>";
   }   

   if ($form{'tour'} eq 'IRFmatch' | $form{'tour'} eq 'IRFmatchdbls') {
      printf "<p>tour is $tour from database<p>" if $debug;

      $division=$tour;

      $division =~ s/IRF //g;

      #print "<p>Full Results for <b>$event, $division division</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      print "<p>Note: RR = Round Robin matches.  Seeding not determined until after the Round Robin matches.  Some events qualify players to the knockout rounds
	            based on RR results; if no seed is present, then player eliminated at the RR stage.<br>";
      #print "(results source: $source)<hr>";
   }	  
   elsif ($form{'tour'} eq 'AMATEUR' || $form{'tour'} eq 'JUNIOR' || $form{'tour'} eq 'AMATEURdbls' ) {
      #print "<p>Full Results for <b>$event, $division division</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      #print "<p>Note: Some amateur associations play a 3rd place game; if those results are known, it is shown.<br>";
      #print "(results source: $source)<hr>";   
   }
   else {
      #print "<p>Full Results for <b>$event</b>, held <b>$date</b> in <b>$city</b> during the <b>$season</b> season.<br>";
      #print "(results source: $source)<hr>";
   }
   
   # 10/13/18: putting in text for private RYDF report
   if ($form{'query'} eq 'all_matches_per_event_rydf') {
      printf "Team RYDF Match Report; only RYDF program participants are listed here.  They are bolded in the below report.<p>";
   }
   
   # 8/24/19: adding in country for IRF and amateur doubles, not for pros...
   if ($doubles_flag eq 'Yes') {
      if ($form{'tour'} eq 'IRFmatchdbls' || $form{'tour'} eq 'AMATEURdbls') {
	     printf "inside doubles flag, inside $form{'tour'} clause<p>" if $debug;
         printf "<!-- Page Content -->
           <div class=\"container container_results_table table-responsive\">
		   <table class=\"table table-striped table-bordered table-hover table-scrollable\">
			<tr>
				<td><b>Round</b></td>
				<td><b>Winning Country</b></td>				
				<td><b>Winning Team</b></td>
				<td><b>Winning Country</b></td>				
				<td><b>Losing Team</b></td>
				<td><b>Score</b></td>
			</tr>";
      }
	  else {
         printf "<!-- Page Content -->
           <div class=\"container container_results_table table-responsive\">
		   <table class=\"table table-striped table-bordered table-hover table-scrollable\">
			<tr>
				<td><b>Round</b></td>		
				<td><b>Winning Team</b></td>			
				<td><b>Losing Team</b></td>
				<td><b>Score</b></td>
			</tr>";	  
	  }
   }
   else {
	  printf "NOT inside doubles flag so this must be singles<p>" if $debug;      
      printf "<!-- Page Content -->
        <div class=\"container container_results_table table-responsive\">
		<table class=\"table table-striped table-bordered table-hover table-scrollable\">
			<tr>
				<td><b>Round</b></td>
				<td><b>Winner Country</b></td>
				<td><b>Winner</b></td>
				<td><b>Loser Country</b></td>
				<td><b>Loser</b></td>
				<td><b>Score</b></td>
			</tr>";
			
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

   if ($doubles_flag eq 'Yes') {
      # 10/16/18: modifying this for _rydf query; join results to team_rydf
      if ($form{'query'} eq 'all_matches_per_event_rydf') {
	     printf "inside doubles flag, inside $form{'tour'} clause, inside $form{'query'} (RYDF) to determine main SQL<p>" if $debug;
         $sql = "select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed, p1.country as winner_country,
                 loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, p2.country as loser_country,
				 round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event   
           left join cp30725_prs.player_profile p1 on r.winner_p1 = p1.player
           left join cp30725_prs.player_profile p2 on r.loser_p1 = p2.player  		   
           where r.event='$event'
           and r.date='$date'
           and (winner_p1 in (select player from cp30725_prs.team_rydf) 
			 or winner_p2 in (select player from cp30725_prs.team_rydf)
             or loser_p1 in (select player from cp30725_prs.team_rydf) 
			 or loser_p2 in (select player from cp30725_prs.team_rydf))			   
           order by r.tmp_date,r.round desc;"; 
      }
	  else {
	     if ($form{'tour'} eq 'IRFmatchdbls' || $form{'tour'} eq 'AMATEURdbls') {
	        printf "inside doubles flag, inside $form{'tour'} clause, NOT in RYDF clause, inside $form{'query'} to determine main SQL<p>" if $debug;   
            $sql = "select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed, p1.country as winner_country,
                 loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, p2.country as loser_country,
                 round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event  
           left join cp30725_prs.player_profile p1 on r.winner_p1 = p1.player
           left join cp30725_prs.player_profile p2 on r.loser_p1 = p2.player           
           where r.event='$event'
           and r.date='$date'
           order by r.tmp_date,r.round desc;"; 	  
         }
		 else {
	        printf "inside doubles flag, inside $form{'tour'} clause so not IRFmatchdbls or Amaterumatchdbls, so we're not getting country, NOT in RYDF clause, inside $form{'query'} to determine main SQL<p>" if $debug;   		 
            $sql = "select winner_p1, winner_p2, s1.seeding as winnerp1_seed, s2.seeding as winnerp2_seed,
                 loser_p1, loser_p2, s3.seeding as loserp1_seed,s4.seeding as loserp2_seed, round,score 
           from results_doubles r
           left join seedings_doubles s1 on r.winner_p1 = s1.player1 and s1.event=r.event
           left join seedings_doubles s2 on r.winner_p2 = s2.player2 and s2.event=r.event 
           left join seedings_doubles s3 on r.loser_p1 = s3.player1 and s3.event=r.event            
           left join seedings_doubles s4 on r.loser_p2 = s4.player2 and s4.event=r.event            
           where r.event='$event'
           and r.date='$date'
           order by r.tmp_date,r.round desc;"; 
		 }
	  }
   }
   else {

      # 10/12/18: if using hidden _rydf query, join the results to the team_rydf table to only list RYDF players
	  # 
      if ($form{'query'} eq 'all_matches_per_event_rydf') {
	     printf "NOT inside doubles flag, inside $form{'tour'} clause, in RYDF clause, inside $form{'query'} to determine main SQL<p>" if $debug;      
         $sql = "select winner, p1.country as winner_country, s1.seeding as winner_seed,
                        loser, p2.country as loser_country, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           left outer join cp30725_prs.player_profile p1 on r.winner = p1.player
           left outer join cp30725_prs.player_profile p2 on r.loser = p2.player             
           where r.event='$event'
           and r.date='$date'
           and (winner in (select player from cp30725_prs.team_rydf) 
			or loser in (select player from cp30725_prs.team_rydf))		   
           order by r.tmp_date,r.round desc;";   
	  }
	  else {
	     printf "NOT inside doubles flag, inside $form{'tour'} clause, NOT in RYDF clause, inside $form{'query'} to determine main SQL<p>" if $debug;      
	  
         $sql = "select winner, p1.country as winner_country, s1.seeding as winner_seed,
                        loser, p2.country as loser_country, s2.seeding as loser_seed,round,score 
           from results r
           left join seedings s1 on r.winner = s1.player and s1.event=r.event
           left join seedings s2 on r.loser = s2.player and s2.event=r.event 
           left outer join cp30725_prs.player_profile p1 on r.winner = p1.player
           left outer join cp30725_prs.player_profile p2 on r.loser = p2.player  		   
           where r.event='$event'
           and r.date='$date'
           order by r.tmp_date,r.round desc;";
      }
   }
   
   printf "$sql<p>" if $debug;
   $sth = $dbh->prepare($sql);
   $sth->execute;
   	   
   if ($doubles_flag eq 'Yes') {
	  if ($form{'tour'} eq 'IRFmatchdbls' || $form{'tour'} eq 'AMATEURdbls') {   
	     printf "Printing results: inside irf or amateurdbls<p>" if $debug;      	  
         while (@row = $sth->fetchrow_array) {
            $winner_p1=$row[0];
            $winner_p2=$row[1];		 
            $winner_p1_seed=$row[2];
            $winner_p2_seed=$row[3];
            $winner_country=$row[4];		
            $loser_p1=$row[5];
            $loser_p2=$row[6];		 
            $loser_p1_seed=$row[7];
            $loser_p2_seed=$row[8];	
            $loser_country=$row[9];			
            $round=$row[10];
            $score=$row[11];

            $new_round=&fix_round($round);	 	

            # 10/12/18: bolding team_rydf players if they're in the team_rydf table
		    if ($form{'query'} eq 'all_matches_per_event_rydf') {
		       $winner_p1=&is_rydf($winner_p1);
		       $winner_p2=&is_rydf($winner_p2);
			   $loser_p1=&is_rydf($loser_p1);
			   $loser_p2=&is_rydf($loser_p2);			
		    }
						
   	        $winnerstring="#$winner_p1_seed $winner_p1 / $winner_p2";	 
	        $loserstring="#$loser_p1_seed $loser_p1 / $loser_p2";			
					
		    # 10/23/17: assuming no missing seeds for now.... may need to do if/then/else in here.
            # 10/3/10: putting this code in to account for missing seed info.
            printf "<tr><td>$new_round</td>
		         <td>$winner_country</td>		         
				 <td>$winnerstring</td>
		         <td>$loser_country</td>	
				 <td>$loserstring</td>
				 <td>$score</td> </tr>\n";
         }
      }
	  else {
	     printf "Printing results: NOT inside irf or amateurdbls<p>" if $debug;    	  
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
				 
            # 10/12/18: bolding team_rydf players if they're in the team_rydf table
		    if ($form{'query'} eq 'all_matches_per_event_rydf') {
		       $winner_p1=&is_rydf($winner_p1);
		       $winner_p2=&is_rydf($winner_p2);
			   $loser_p1=&is_rydf($loser_p1);
			   $loser_p2=&is_rydf($loser_p2);			
		    }		 
		 
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
   }
   else {
      while (@row = $sth->fetchrow_array) {
         $winner=$row[0];
		 $winner_country=$row[1];
         $winner_seed=$row[2];
         $loser=$row[3];
		 $loser_country=$row[4];
         $loser_seed=$row[5];
         $round=$row[6];
         $score=$row[7];

         $new_round=&fix_round($round);
		 
		 # 10/12/18: bolding team_rydf players if they're in the team_rydf table
		 if ($form{'query'} eq 'all_matches_per_event_rydf') {
		    $winner=&is_rydf($winner);
			$loser=&is_rydf($loser);
		 }
		 
		 # zzz
		 # 2/12/20: cleaning nationality of player based on date
		 
         $winner_country_new = &clean_nationality($winner,$date,$winner_country);
				 

         # 10/3/10: putting this code in to account for missing seed info.
         if ($winner_seed eq '' && $loser_seed eq '') {
            printf "<tr> <td>$new_round</td> <td>$winner_country_new</td> <td>$winner</td> <td>$loser_country</td> <td>$loser</td> <td>$score</td> </tr>\n";
         }
         elsif ($winner_seed eq '' && $loser_seed ne '') {
            printf "<tr> <td>$new_round</td> <td>$winner_country_new</td> <td>$winner</td> <td>$loser_country</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
         }
         elsif ($winner_seed ne '' && $loser_seed eq '') {
            printf "<tr> <td>$new_round</td> <td>$winner_country_new</td> <td>#$winner_seed $winner</td> <td>$loser_country</td> <td>$loser</td> <td>$score</td> </tr>\n";
         }
         else {
            printf "<tr> <td>$new_round</td> <td>$winner_country_new</td> <td>#$winner_seed $winner</td> <td>$loser_country</td> <td>#$loser_seed $loser</td> <td>$score</td> </tr>\n";
         }
      }
   }

   print "</table>\n";

   &print_back_link;

   print "</div>\n"; 

   printf "<!-- Bootstrap core JavaScript -->
    <script src=\"/bootstrap/jquery.min.js\"></script>
    <script src=\"/bootstrap/bootstrap.bundle.min.js\"></script>";
	
   printf "</body></html>";	        

}
