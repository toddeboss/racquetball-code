-- Manual clean up of 2023 outdoor nationals event names.

update results set event='2023 49th Annual Outdoor Nationals - Mens Three Wall' where event='2022 49th Annual Outdoor Nationals - Mens Three Wall';

update results set event='2023 49th Annual Outdoor Nationals - Womens Three Wall' where event='2022 49th Annual Outdoor Nationals - Womens Three Wall';

update tourneys set event='2023 49th Annual Outdoor Nationals - Mens Three Wall' where event='2022 49th Annual Outdoor Nationals - Mens Three Wall';

update tourneys set event='2023 49th Annual Outdoor Nationals - Womens Three Wall' where event='2022 49th Annual Outdoor Nationals - Womens Three Wall';


commit;