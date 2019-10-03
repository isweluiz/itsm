###GERAL

select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_geral
from vw_kpi_tickets
where 1=1
and queue_finish is not null

### CSTI

select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Central de Serviços'


###N2
select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Tecnologia::Suporte Presencial'



###N3
select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Tecnologia::Rede'


## SLA estourado 

select 
round((sum(case when sla_attend = 'false' then 1 else 0 end) * 100)/count(*),2) as perc_geral
from vw_kpi_tickets
where 1=1
and queue_finish is not null

