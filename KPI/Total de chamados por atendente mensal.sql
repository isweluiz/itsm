select t1.usuario as Atendente, 
if(t4.atendimento IS NOT NULL, t4.atendimento, 0) Atendimento, 
if(t3.aberto IS NOT NULL, t3.aberto, 0) Aberto, 
if(t2.fechado IS NOT NULL, t2.fechado, 0) Fechado, 
if(t1.total IS NOT NULL, t1.total, 0) Total 
from 

(SELECT concat_ws(' ', u.first_name, u.last_name) usuario, count(0) total  
FROM ticket t 
inner join users u on t.user_id=u.id 
where date(t.create_time) between '2020-09-01' and '2020-09-30' 
group by u.id) t1 
left join 

(SELECT concat_ws(' ', u.first_name, u.last_name) usuario, count(0) fechado 
FROM ticket t 
inner join users u on t.user_id=u.id 
where date(t.create_time) between '2020-09-01' and '2020-09-30'  
and ticket_state_id=2
group by u.id) t2 on t1.usuario=t2.usuario 
left join 


(SELECT concat_ws(' ', u.first_name, u.last_name) usuario, count(0) aberto 
FROM ticket t 
inner join users u on t.user_id=u.id 
where date(t.create_time) between '2020-09-01' and '2020-09-30'   
and ticket_state_id=4 
group by u.id) t3 on t1.usuario=t3.usuario 

left join 

(SELECT concat_ws(' ', u.first_name, u.last_name) usuario, count(0) atendimento 
FROM ticket t 
inner join users u on t.user_id=u.id 
where date(t.create_time) between  '2020-09-01' and '2020-09-30' 
and ticket_state_id=11
group by u.id) t4 on t1.usuario=t4.usuario
