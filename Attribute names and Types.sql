

select 
c.name as "Model", 
b.name as "Entity", 
a.name as "Attribute",
a.phys_colname as "PhysicalName",
a.label, 
a.r_type 
from mta_attribute as a
join mta_entity as b on a.o_entity = b.uuid 
join mta_root_model as c on b.o_model = c.uuid 



