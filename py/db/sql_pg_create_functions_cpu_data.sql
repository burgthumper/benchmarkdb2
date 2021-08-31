
set search_path = benchmarkpg_schema;
CREATE OR REPLACE FUNCTION benchmarkpg_schema.cpu_datapoint_cap()
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
declare 
	num1 numeric; 
begin
	num1 = trunc((random()*(100-50)+50)::numeric,4);
	if num1 > 100 then
		num1 = 100;
	end if;
	RETURN num1;
END;
$function$
;

set search_path = benchmarkpg_schema;
select benchmarkpg_schema.cpu_datapoint_cap();



CREATE PROCEDURE p_insert_cpu_data()
language plpgsql
as $$
BEGIN
    for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),'100001',benchmarkpg_schema.f_cpu_datapoint_cap(),benchmarkpg_schema.f_cpu_datapoint_cap(),benchmarkpg_schema.f_cpu_datapoint_cap(),benchmarkpg_schema.f_cpu_datapoint_cap());
    end loop;
end;$$

Call p_insert_cpu_data();



set search_path = benchmarkpg_schema;
CREATE OR REPLACE FUNCTION benchmarkpg_schema.insert_cpu_data()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
	for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) values (now(),'100001',benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap());
	end loop;
END;
$function$
;



set search_path = benchmarkpg_schema;
CREATE OR REPLACE FUNCTION benchmarkpg_schema.f_insert_cpu_data_pass(rest_id varchar)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
	for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) values (now(),rest_id,benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap());
	end loop;
END;
$function$
;

set search_path = benchmarkpg_schema;
SELECT benchmarkpg_schema.f_insert_cpu_data_pass('100002');




set search_path = benchmarkpg_schema;
CREATE OR REPLACE FUNCTION benchmarkpg_schema.restaurant_datapoint()
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare result varchar;
BEGIN
	SELECT restaurant_id into result FROM restaurants ORDER BY random() LIMIT 1;
	return result;
END;
$function$
;

set search_path = benchmarkpg_schema;
SELECT restaurant_id FROM restaurants ORDER BY random() LIMIT 1;

set search_path = benchmarkpg_schema;
SELECT benchmarkpg_schema.restaurant_datapoint();



set search_path = benchmarkpg_schema;
CREATE OR REPLACE FUNCTION benchmarkpg_schema.insert_cpu_data_restid()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
	for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) values (now(),benchmarkpg_schema.restaurant_datapoint(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap(),benchmarkpg_schema.cpu_datapoint_cap());
	end loop;
END;
$function$
;

set search_path = benchmarkpg_schema;
SELECT benchmarkpg_schema.insert_cpu_data();

select count(*) from cpu;

set search_path = benchmarkpg_schema;
truncate table cpu;

---------------------------------------------------------------------------

set search_path = benchmarkpg_schema;

select * from restaurants where restaurant_id = '100005';

SELECT benchmarkpg_schema.f_insert_cpu_data_pass('100004');

--delete from benchmarkpg_schema.cpu where restaurant_id = '100004';

select count(*) from cpu;
select count(*) from cpu where restaurant_id = '100004';

select * from cpu where restaurant_id = '100004' LIMIT 10;
2021-04-06 15:16:05
