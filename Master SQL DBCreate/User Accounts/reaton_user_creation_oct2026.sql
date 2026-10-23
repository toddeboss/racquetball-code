/* 10/16/26: Adding an account for Rich Eaton 

steps:
- log into cpanel
- in the Manage my Databases section add the user

cp30725_reaton
pwd: 14RichEaton!
create user

- now add newly created user to cp30725_men

via the same cpanel wizard just below create user

do not give any permissions except select


- log into vserver410 console as root, log into mysql as dba

*/

use cp30725_men;

grant select on results to 'cp30725_reaton'@'c-67-166-172-92.hsd1.va.comcast.net';
grant select on seedings to 'cp30725_reaton'@'c-67-166-172-92.hsd1.va.comcast.net';
grant select on tourneys to 'cp30725_reaton'@'c-67-166-172-92.hsd1.va.comcast.net';

-- LOGIN  wouldn't work until ran this:
GRANT SELECT
ON `cp30725_men`.*
TO 'cp30725_reaton'@'%';


----------

now log in as the newly created user cp30725_reaton and ensure selects work.

