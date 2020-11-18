SELECT s.name as Fila,
sum((case s.status when 'Novo' then 1 else 0 end)) as "Novo",
sum((case s.status when 'Aberto' then 1 else 0 end)) as "Aberto",
sum((case s.status when 'Pendente' then 1 else 0 end)) as "Pendente",
sum((case s.status when 'Em Cancelado' then 1 else 0 end)) as "Em andamento",
sum((case s.status when 'Encerrado' then 1 else 0 end)) as "Encerrado",
sum((case s.status when 'Cancelado' then 1 else 0 end)) as "Cancelado"
from (select q.name, ts.name status from queue q 
inner join ticket t on q.id = t.queue_id
inner join ticket_state ts on t.ticket_state_id=ts.id
where date(t.create_time) between '2020-01-30' and '2022-11-30') s 
group by s.name
