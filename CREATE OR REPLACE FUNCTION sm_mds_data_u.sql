CREATE OR REPLACE FUNCTION sm_mds_data_user.create_master_address(masteraddressid character varying, loadid numeric)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	INSERT INTO sa_master_address (b_loadid, master_address_id, b_classname, b_credate,
		b_upddate, b_creator, b_updator)
	select
		loadid as "b_loadid",
		masteraddressid as master_address_id ,
		'MasterAddress' as "b_classname",
		now() as "b_credate",
		now() as "b_upddate",
		'SQL Function' as "b_creator",
		'SQL Function' as "b_updator"
	;
return true;
END
$function$
;
