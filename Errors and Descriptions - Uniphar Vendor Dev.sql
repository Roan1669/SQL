select
v.ID,
v.ErrorName,
v.Entity,
case when ErrorName = 'Vendor' then 'No Vendor has been assigned to this company code'
when ErrorName = 'PaymentMethods' then 'Makes sure that suitable Payment Methods are entered, depending on the Account Group, Currency and Bank Country'
else b.Description
end as 'Description',
case when ErrorName = 'PaymentMethods' then 'The Payment Method selected needs to be compatible with the selected Account Group'
       else b.Information
end as 'Information',
b.Condition
from
(
select VENDOR_COMPANY_C_LINK_ID as 'ID', b_constraintname as 'ErrorName', b_classname as 'Entity' from GE_VENDOR_COMPANY_CODE_LINK
union all
select cast(ADDRESS_ID as Varchar) as 'ID', b_constraintname as 'ErrorName', b_classname as 'Entity' from GE_ADDRESS
union all
select cast(CONTACT_PERSON_ID as varchar) as 'ID', b_constraintname as 'ErrorName', b_classname as 'Entity' from GE_CONTACT_PERSON
union all
select cast(EMAIL_ID as varchar) as 'ID', b_constraintname as 'ErrorName', b_classname as 'Entity' from GE_EMAIL
union all
select cast(PHONE_NUMBER_ID as varchar) as 'ID', b_constraintname as 'ErrorName', b_classname as 'Entity' from GE_PHONE_NUMBER
union all
select cast(a.vendor_id as varchar) as 'ID', a.b_constraintname as 'ErrorName', a.b_classname as 'Entitity' from GE_VENDOR as a
join gd_vendor as b on a.vendor_id = b.vendor_id
where b.F_ACCOUNT_GROUP <> 'ZEXP'
union all
select cast(c.vendor_id as varchar) as 'ID', c.b_constraintname as 'ErrorName', 'HRVendor' as 'Entitity' from GE_VENDOR as c
join gd_vendor as d on c.vendor_id = d.vendor_id
where d.F_ACCOUNT_GROUP = 'ZEXP') as v
left outer JOIN (
Select
b.NAME,
b.LABEL,
b.DESCRIPTION as 'Description',
b.VALID_LABEL as 'Information',
b.CONDITION as 'Condition'
from [SEMARCHY_XDM].[dbo].[MTA_CHECKCONS] as b
JOIN
[SEMARCHY_XDM].[dbo].[MTA_ENTITY] as c on c.UUID = b.O_ENTITY
JOIN
[SEMARCHY_XDM].[dbo].[MTA_APPLICATION] as d on d.O_MODEL = c.O_MODEL
where d.name = 'VendorModel' ) as b on b.name = v.ErrorName



