
select distinct t.tn ,
t.title,
UST.name ,
ts.name, 
tty.name ,
UST.ust_amount,
UST.complexity, 
UST.effort,
UST.ust_quantity,
t.create_time,
ttq.name ,
kpi.customer_user_id,
t.service_id,
UST.id ,
t.id,
usr.login 
,kpi.pririty_name
,kpi.queue_create
,kpi.queue_actual
,kpi.queue_finish
,kpi.finish_time
,kpi.user_finish
,kpi.user_create
,kpi.service_id
,kpi.sla_id
,kpi.sla_name
,kpi.sla_response_time
,kpi.sla_solution_time
,kpi.time_opened
,kpi.time_pending
,kpi.time_solution
,kpi.rate_solution
,kpi.sla_attend
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
inner join otrs.users usr on usr.id  = t.responsible_user_id
left join otrs.vw_kpi_rate kpi on t.id = kpi.ticket_id
WHERE YEAR(t.create_time) = 2020 and MONTH(t.create_time) = 03
