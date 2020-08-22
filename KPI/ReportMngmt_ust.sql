select tn as Ticket, t.title as Assunto,UST.name Servico,
ts.name Estado, 
tty.name as Tipo,
UST.ust_amount, UST.complexity, UST.effort, UST.ust_quantity, t.create_time, ttq.name Fila,customer_user_id,
t.service_id,UST.id as pk_serviceid,t.id ticket_id 
from ticket t inner join 
(select s.id, s.name,
sp1.preferences_value as ust_amount,
sp2.preferences_value as complexity,
sp3.preferences_value as effort,
sp4.preferences_value as ust_quantity
from service s
left join service_preferences sp1 on s.id = sp1.service_id
	and sp1.preferences_key = 'ServiceUSTAmount'
left join service_preferences sp2 on s.id = sp2.service_id
	and sp2.preferences_key = 'ServiceComplexity'
left join service_preferences sp3 on s.id = sp3.service_id
	and sp3.preferences_key = 'ServiceEffort'
left join service_preferences sp4 on s.id = sp4.service_id
	and sp4.preferences_key = 'ServiceUSTQuantity') UST on UST.id = t.service_id
inner join ticket_state ts on ts.id  = t.ticket_state_id 
inner join ticket_type tty on tty.id  = t.type_id 
inner join queue ttq on ttq.id  = t.queue_id 

WHERE YEAR(t.create_time) = 2020 and MONTH(t.create_time) = 03
