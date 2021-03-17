select 
t.id, tn, title as titulo,
replace(adm.a_body,'\n',' ')  as descricao,
(select concat(u2.first_name,' ',u2.last_name ) from otrs.users u2 where u2.id = t.responsible_user_id) as responsavel,
(select name from otrs.ticket_state s where s.id  = t.ticket_state_id) status,
(select q.name from otrs.queue q where q.id  = t.queue_id ) fila,
(select s2.name from otrs.service s2 where s2.id  = t.service_id) servico,
t.create_time criado_em,
(select max(th.change_time) from otrs.ticket_history th where th.ticket_id  = t.id) alterado_em,
(select concat(u2.first_name,' ',u2.last_name ) from otrs.users u2 where u2.id = t.create_by) as criado_por,
TIMESTAMPDIFF(DAY,t.create_time,(select max(th.change_time) from otrs.ticket_history th where th.ticket_id  = t.id)) idade_dias
from otrs.ticket t 
inner join otrs.article a on  a.ticket_id  = t.id
inner join otrs.article_data_mime adm on adm.article_id = a.id
where adm.change_time = (select min(adm.change_time) from otrs.article a2 
inner join otrs.article_data_mime adm on adm.article_id = a2.id where t.id = a2.ticket_id 
)
