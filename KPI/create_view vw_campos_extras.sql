create view vw_campos_extras as 
select 
dfv1.object_id as tickect_id,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =11 and object_id =  dfv1.object_id ) as MasterSlave,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =12 and object_id =  dfv1.object_id ) as urgencia,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =13 and object_id =  dfv1.object_id ) as UST,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =14 and object_id =  dfv1.object_id ) as Atividade,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =15 and object_id =  dfv1.object_id ) as ramal,
(select dfv.value_text from dynamic_field_value dfv where dfv.field_id =16 and object_id =  dfv1.object_id ) as ramal2
from dynamic_field_value dfv1
group by object_id
