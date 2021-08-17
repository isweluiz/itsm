select tn, create_time, title, communication_channel, type_name,
                state_name,user_create,user_finish,queue_create
                FROM vw_kpi_tickets
                WHERE ((YEAR(create_time) = 2020 and MONTH(create_time) = 07)
                or
                (YEAR(create_time) = 2020 and MONTH(create_time) = 08));



select tn, create_time,finish_time, title, communication_channel, type_name,
                state_name,user_create,user_finish,queue_create,customer_user_id
                FROM vw_kpi_tickets
                WHERE ((YEAR(create_time) = 2021 and MONTH(create_time) = 08)
                or
                (YEAR(create_time) = 2021 and MONTH(create_time) = 08));
