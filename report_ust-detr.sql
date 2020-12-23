select tn as Ticket,
                t.id as ticket_id,
                t.title as Assunto,
                t.service_id,
                (select s.name from service s left join service_preferences sp4 on s.id = sp4.service_id  and sp4.preferences_key = 'ServiceUSTQuantity' where s.id = t.service_id) Servico,
                 (select ts.name from ticket_state ts where ts.id  = t.ticket_state_id) as Estado,
                 (select tty.name from ticket_type tty where tty.id  = t.type_id)   as Tipo,
                 (select usr.first_name from otrs.users usr where usr.id  = t.responsible_user_id ) as responsavel,
                 (select ttq.name from queue ttq where ttq.id  = t.queue_id)  as Fila,
                 customer_user_id,
                 t.create_time,
                 (select max(finish_time) from vw_kpi_tickets vkt where vkt.tn = t.tn) as finish_time,
                ifnull(cex.Qtd_atividades_executadas,0) as qtd_atividades,
                ifnull((select sp4.preferences_value from service s left join service_preferences sp4 on s.id = sp4.service_id  and sp4.preferences_key = 'ServiceUSTQuantity' where s.id = t.service_id),0) ust_quantity,
                (ifnull((select sp4.preferences_value from service s left join service_preferences sp4 on s.id = sp4.service_id and sp4.preferences_key = 'ServiceUSTQuantity' where s.id = t.service_id),0) *
                 ifnull(cex.Qtd_atividades_executadas,0)) as ust_total
                from ticket t left join otrs.vw_campos_extras cex on cex.tickect_id  = t.id
                 WHERE YEAR((Select max(kpi.finish_time) from vw_kpi_rate as kpi where t.id=kpi.ticket_id)) =  $Year and
                MONTH((Select max(kpi.finish_time) from vw_kpi_rate as kpi where t.id=kpi.ticket_id)) = $Month"
