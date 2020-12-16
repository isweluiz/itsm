SELECT * FROM ticket_history 
WHERE ticket_id IN (8709,8711,8718,8784)

UPDATE otrs.ticket_history
SET change_time='2020-12-16 09:14:17.0'
WHERE ticket_id IN (

12373,
12375
) and history_type_id = 27; 
