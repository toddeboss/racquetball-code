SELECT winner,  
loser,
round,   
score,   
tour,    
city,    
event,   
date,    
source,  
season,  
notes,   
tmp_date
    FROM results
    order by tmp_date,round desc
    INTO OUTFILE 'results_online2.csv'
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n' ;

-- note must do this as sys users in mysql, file goes into:
-- ./usr/databases/mysql/wwwbossconsultingcom/results_online2.csv
