create or replace view otrs.vw_campos_extras 
as select
    `dfv1`.`object_id` AS `tickect_id`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 11)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `MasterSlave`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 12)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `urgencia`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 13)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `UST`,
    (
    select
        distinct `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 14)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `Atividade`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 15)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `ramal`,
    (select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 23)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `justifictiva`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 25)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `sla`,
    (
    select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 26)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `hostname`,
    (select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 27)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `ip`,
    (select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 28)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `macaddress`,
   (select
        `dfv`.`value_text`
    from
        `dynamic_field_value` `dfv`
    where
        ((`dfv`.`field_id` = 29)
        and (`dfv`.`object_id` = `dfv1`.`object_id`))) AS `complexidade_analista`
from
    `dynamic_field_value` `dfv1`
group by
    `dfv1`.`object_id`
