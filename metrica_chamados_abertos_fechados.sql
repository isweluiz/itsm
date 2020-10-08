SELECT  MONTHNAME(create_time) AS "metric",
create_time AS "time",
count(*) 
FROM ticket WHERE YEAR(create_time)=2020
GROUP BY MONTH(create_time) ORDER BY create_time





SELECT  MONTHNAME(finish_time) AS "metric",
finish_time AS "time",
count(DISTINCT ticket_id) 
FROM otrs.vw_kpi_tickets WHERE YEAR(finish_time)=2020
and finish_time is not null
GROUP BY MONTH(finish_time) ORDER BY finish_time


