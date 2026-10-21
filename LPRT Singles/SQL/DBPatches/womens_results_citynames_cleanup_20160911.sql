/* 
filename: womens_results_citynames_cleanup_20160911.sql
purpose: SQL to clean up the cities in the women's results table

modification history
when	who	what
9/11/16	tboss	creation

Usage: n/a: one-off working commands used to fix certain things in databases

Prerequisites to run: none

Other notes: none

*/

use cp30725_women;

SET SQL_SAFE_UPDATES = 0;

-- fixing all cities not already properly formatted


------------------

select distinct(city) from wpro_results order by city;

-- save to working xls, make the below swl

update wpro_results set city='Albuquerque, NM' where city='Albuquerque';
update wpro_results set city='Anaheim, CA' where city='Anaheim';
update wpro_results set city='Anchorage, AK' where city='Anchorage';
update wpro_results set city='Annapolis, MD' where city='Annapolis';
update wpro_results set city='Arlington, VA' where city='Arlington';
update wpro_results set city='Arvada, CO' where city='Arvada';
update wpro_results set city='Atlanta, GA' where city='Atlanta';
update wpro_results set city='Auburn, MA' where city='Auburn';
update wpro_results set city='Baltimore, MD' where city='Baltimore';
update wpro_results set city='Bangor, ME' where city='Bangor';
update wpro_results set city='Belleville, IL' where city='Belleville';
update wpro_results set city='Bloomingdale, IN' where city='Bloomingdale';
update wpro_results set city='Boise, ID' where city='Boise';
update wpro_results set city='Boston, MA' where city='Boston';
update wpro_results set city='Canoga Park, CA' where city='Canoga Park';
update wpro_results set city='Chalfont, PA' where city='Chalfont';
update wpro_results set city='Charlotte, NC' where city='Charlotte';
update wpro_results set city='Chattanooga, TN' where city='Chattanooga';
update wpro_results set city='Chicago, IL' where city='Chicago';
update wpro_results set city='Cincinnati, OH' where city='Cincinnati';
update wpro_results set city='Colorado Springs, CO' where city='Co Springs';
update wpro_results set city='Colma, CA' where city='Colma';
update wpro_results set city='Columbus, OH' where city='Columbus';
update wpro_results set city='Coral Gables, FL' where city='Coral Gables';
update wpro_results set city='Coral Springs, FL' where city='Coral Springs';
update wpro_results set city='Costa Mesa, CA' where city='Costa Mesa';
update wpro_results set city='Denver, CO' where city='Denver';
update wpro_results set city='Edmonton, CAN' where city='Edmonton';
update wpro_results set city='Escondido, CA' where city='Escondido';
update wpro_results set city='Essex Junction, VT' where city='Essex Junction';
update wpro_results set city='Fayetteville, NC' where city='Fayetteville';
update wpro_results set city='Federal Way, WA' where city='Federal Way';
update wpro_results set city='Fishkill,NY' where city='Fishkill';
update wpro_results set city='Fort Worth, TX' where city='Fort Worth';
update wpro_results set city='Fountain Valley, CA' where city='Fountain Valley';
update wpro_results set city='Fort Lauderdale, FL' where city='Ft Lauderdale';
update wpro_results set city='Gaithersburg, MD' where city='Gaithersburg';
update wpro_results set city='Greensboro, NC' where city='Greensboro';
update wpro_results set city='Honolulu, HI' where city='Hawaii';
update wpro_results set city='Hershey, PA' where city='Hershey';
update wpro_results set city='Houston, TX' where city='Houston';
update wpro_results set city='Kent, WA' where city='Kent';
update wpro_results set city='King of Prussia, PA' where city='King of Prussia';
update wpro_results set city='Lafayette, LA' where city='Lafayette';
update wpro_results set city='Las Vegas, NV' where city='Las Vegas';
update wpro_results set city='Lombard, IL' where city='Lombard';
update wpro_results set city='Los Angeles, CA' where city='Los Angeles';
update wpro_results set city='Lynwood, WA' where city='Lynwood';
update wpro_results set city='Manchester, NH' where city='Manchester';
update wpro_results set city='Mayfield, CAN' where city='Mayfield';
update wpro_results set city='Mclean, VA' where city='Mclean, VA';
update wpro_results set city='Melbourne, FL' where city='Melbourne';
update wpro_results set city='Memphis, TN' where city='Memphis';
update wpro_results set city='Miami, FL' where city='Miami';
update wpro_results set city='Milpitas, CA' where city='Milpitas';
update wpro_results set city='Milwaukee, WI' where city='Milwaukee';
update wpro_results set city='Minneapolis, MN' where city='Minneapolis';
update wpro_results set city='Nashville, TN' where city='Nashville';
update wpro_results set city='New Haven, CT' where city='New Haven';
update wpro_results set city='New Orleans, LA' where city='New Orleans';
update wpro_results set city='New York, NY' where city='New York';
update wpro_results set city='Newport Beach, CA' where city='Newport Beach';
-- update wpro_results set city='Ohio' where city='Ohio';
-- update wpro_results set city='Oklahoma' where city='Oklahoma';
update wpro_results set city='Omaha, NE' where city='Omaha';
update wpro_results set city='Palantine, IL' where city='Palantine';
update wpro_results set city='Panama, FL' where city='Panama';
update wpro_results set city='Philadelphia, PA' where city='Philadelphia';
update wpro_results set city='Phoenix, AZ' where city='Phoenix';
update wpro_results set city='Pleasanton, CA' where city='Pleasanton';
update wpro_results set city='Plymouth, MA' where city='Plymouth';
update wpro_results set city='Portland, OR' where city='Portland';
-- update wpro_results set city='Pro Nationals' where city='Pro Nationals';
update wpro_results set city='Quebec City, CAN' where city='Quebec City';
update wpro_results set city='Roanoke, VA' where city='Roanoke';
update wpro_results set city='Rosarito Beach, CA' where city='Rosarito Beach';
update wpro_results set city='Sacramento, CA' where city='Sacramento';
update wpro_results set city='San Antonio, TX' where city='San Antonio';
update wpro_results set city='San Diego, CA' where city='San Diego';
update wpro_results set city='San Francisco, CA' where city='San Francisco';
update wpro_results set city='Santa Ana, CA' where city='Santa Ana';
update wpro_results set city='Saskatoon, CAN' where city='Saskatoon';
update wpro_results set city='Seattle, WA' where city='Seattle';
update wpro_results set city='Sellersville, PA' where city='Sellersville';
update wpro_results set city='Southfield, MI' where city='Southfield';
update wpro_results set city='St. Louis, MO' where city='St. Louis';
update wpro_results set city='Stockton, CA' where city='Stockton';

update wpro_results set city='Syracuse, NY' where city='Syracuse';
update wpro_results set city='Syracuse, NY' where city='Syracuse?';
update wpro_results set city='Tempe, AZ' where city='Tempe';
update wpro_results set city='Tijuana, MEX' where city='Tijuana';
update wpro_results set city='Toronto, CAN' where city='Toronto';
update wpro_results set city='Vancouver, CAN' where city='Vancouver';
update wpro_results set city='Warwick, RI' where city='Warwick';
update wpro_results set city='Watertown, SD' where city='Watertown';
update wpro_results set city='Westminster, CO' where city='Westminster';

update wpro_results set city='Winnipeg, CAN' where city='Winnipeg';
update wpro_results set city='York, PA' where city='York';

