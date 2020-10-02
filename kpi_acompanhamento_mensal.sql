SELECT  MONTHNAME(create_time) AS "metric",
create_time AS "time",
count(*)
FROM ticket WHERE YEAR(create_time)=2020
GROUP BY MONTH(create_time) ORDER BY create_time
