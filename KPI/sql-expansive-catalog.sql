select 
s.name,
sp1.preferences_value as ust_amount,
sp2.preferences_value as complexity,
sp3.preferences_value as effort,
sp4.preferences_value as ust_quantity
from service s
-- UST Amount
left join service_preferences sp1 on s.id = sp1.service_id
	and sp1.preferences_key = 'ServiceUSTAmount'
-- Complexity
left join service_preferences sp2 on s.id = sp2.service_id
	and sp2.preferences_key = 'ServiceComplexity'
-- Effort
left join service_preferences sp3 on s.id = sp3.service_id
	and sp3.preferences_key = 'ServiceEffort'
-- UST Quantity
left join service_preferences sp4 on s.id = sp4.service_id
	and sp4.preferences_key = 'ServiceUSTQuantity'
where 1=1
;
