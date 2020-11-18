SELECT q.name, count(0) ticket  

FROM ticket t 

inner join service q on t.service_id=q.id 

where ticket_state_id= 2 and date(t.create_time) between '2019-11-01' and '2022-11-30' 

group by q.name 

order by 2 desc
