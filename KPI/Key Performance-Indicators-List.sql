###GERAL
##Percentual dos chamados que possuem SLA
# NOME : % chamados encerrados que possuem SLA

select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_geral
from vw_kpi_tickets
where 1=1
and queue_finish is not null

### N1
#Percentual dos chamados que possuem SLA
## % SLA N1
select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Suporte 1º Nível'

###N2
#Percentual dos chamados que possuem SLA
## % SLA N2
select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Suporte 2º Nível'

###N3
#Percentual dos chamados que possuem SLA
## % SLA N3
select 
round((sum(case when sla_attend = 'true' then 1 else 0 end) * 100)/count(*),2) as perc_csti
from vw_kpi_tickets
where 1=1
and queue_finish = 'Suporte 3º Nível'


## % SLA estourado 

select 
round((sum(case when sla_attend = 'false' then 1 else 0 end) * 100)/count(*),2) as perc_geral
from vw_kpi_tickets
where 1=1
and queue_finish is not null

