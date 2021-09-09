select * from
(select
tn as tn,
th.ticket_id,
ts.name AS state_name,
u1.first_name user_finish,
u2.first_name user_create,
t.create_time,
max(th.change_time) as finish_time
from
    ticket_history th
inner join ticket t on t.id= th.ticket_id  
inner join ticket_state ts on th.state_id = ts.id
left join users u1 on t.change_by = u1.id
left join users u2 on t.create_by = u2.id
where
    th.state_id=13 and th.history_type_id=27 
group by t.tn,th.ticket_id,t.create_time, ts.name) as a
where a.finish_time >= '2021-08-02 17:56:02' and a.finish_time<='2021-09-02 17:56:02'
