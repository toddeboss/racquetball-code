
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
   elsif ($ccode eq '') { return '<blank>'; }      
   else {
      printf "Invalid Country code $ccode passed to lookup, returning the same<p>";
	  return $ccode;
   }
}