select * from ticket_history th 
inner join ticket t on t.id  = th.ticket_id
inner join ticket_state ts on ts.id  = th.state_id 
inner join ticket_history_type tht on tht.id  = th.history_type_id 
where th.history_type_id = 27 and t.tn = '2020082706005409'
and ts.id in (15,16) order by th.change_time
