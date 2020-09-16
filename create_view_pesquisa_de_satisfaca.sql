create or replace view vw_aux_survey as 
select sa.answer, 
       sa.question_id ,
       sr.ticket_id,
       sv.question_id as vote_qestion_id,
       sv.vote_value,
       sv.create_time,
       sv.request_id
  from survey_answer sa 
  right join survey_vote sv on sa.question_id  = sv.question_id and sv.vote_value  = sa.id 
  right join survey_request sr on sr.id  = sv.request_id

create or replace view vw_aux_client_tkt as
select distinct cuc.user_id,
      t4.id id_tkt 
      from customer_user_customer cuc 
      inner join ticket t4 on t4.customer_user_id = cuc.user_id
      group by t4.id  
  
create or replace view vw_aux_finaliza_tkt as      
select max(vkt.user_finish) as analista_solucionador,
            vkt.ticket_id from vw_kpi_tickets vkt
     group by ticket_id

create or replace view vw_pesq_sat as 
select 
tn  numero_chamado ,
t2.id id_ticket,
t2.title as assunto , 
q2.name  as fila,
cuc1.user_id as cliente,
sr.send_to enviado_para,
usrfn.analista_solucionador,
sqt.id id_question,
sqt.question as pergunta,
sr.id id_survey_request,
ifnull(rp.answer,rp.vote_value) as resposta,
rp.create_time as data_resposta
from survey_request sr
inner join ticket t2  on t2.id  = sr.ticket_id
left join vw_aux_client_tkt cuc1 on t2.id = cuc1.id_tkt
left join vw_aux_finaliza_tkt  usrfn on t2.id=usrfn.ticket_id
left join survey_queue sq on sq.survey_id = sr.survey_id and sq.queue_id  = t2.queue_id 
inner join queue q2 on q2.id  = t2.queue_id 
left join survey_question sqt on sqt.survey_id = sr.survey_id 
left join otrs.vw_aux_survey rp on sr.ticket_id  = rp.ticket_id and sr.id = rp.request_id and sqt.id = rp.vote_qestion_id
