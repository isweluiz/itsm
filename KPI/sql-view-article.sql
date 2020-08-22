SELECT tn,ticket_priority_id, DATE_FORMAT(ticket.change_time,'%m') mes, Title,customer_user_id, ticket.create_time, ticket.change_time,sla.name,sla.comments,
CAST(REPLACE(SUBSTR(sla.comments, 5,10),',','.') AS DECIMAL (10,2)) ust, queue.name, ticket_state.name, 
CAST(REPLACE(SUBSTR(sla.comments, 5,10),',','.') AS DECIMAL (10,2)) * 32.56 valor, 
otrs_consolidado.vw_dashman.ticket_analista_responsavel, otrs_consolidado.vw_dashman.ticket_solucao
from otrs.ticket,otrs.sla,otrs.queue,otrs.ticket_state,otrs_consolidado.vw_dashman
where otrs.ticket.tn = otrs_consolidado.vw_dashman.ticket_numero
and ticket.sla_id = sla.id
and ticket.queue_id = queue.id
and otrs.ticket.ticket_state_id = otrs.ticket_state.id
