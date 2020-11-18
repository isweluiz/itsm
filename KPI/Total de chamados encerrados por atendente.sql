select s.usuario as Atendente, 
sum(case s.status when 'Novo' then 1 else 0 end) as "Novo",
sum(case s.status when 'Aberto' then 1 else 0 end) as "Aberto",
sum(case s.status when 'Cancelado' then 1 else 0 end) as "Cancelado",
sum(case s.status when 'Em andamento' then 1 else 0 end) as "Em andamento",
sum(case s.status when 'Encerrado' then 1 else 0 end) as "Encerrado",
sum(case s.status when 'Pendente' then 1 else 0 end) as "Pendente"
from 
(SELECT concat_ws(' ', u.first_name, u.last_name) usuario, ts.name as status
FROM ticket t 
inner join users u on t.user_id=u.id 
inner join ticket_state ts on t.ticket_state_id=ts.id) s
group by s.usuario
