-- changed slightly the Pan Am Trials event so it won't get picked up in Pan Am games query

update results set event='1994 Tournament of the Americas IX/Pan American Trials - Mens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Mens Open';

update results set event='1994 Tournament of the Americas IX/Pan American Trials - Womens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Womens Open';

update seedings set event='1994 Tournament of the Americas IX/Pan American Trials - Mens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Mens Open';

update seedings set event='1994 Tournament of the Americas IX/Pan American Trials - Womens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Womens Open';


update tourneys set event='1994 Tournament of the Americas IX/Pan American Trials - Mens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Mens Open';

update tourneys set event='1994 Tournament of the Americas IX/Pan American Trials - Womens Open' where event='1994 Tournament of the Americas IX/Pan American Games Trials - Womens Open';

