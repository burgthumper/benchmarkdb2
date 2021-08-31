-- FUNCTION: benchmarkts_schema.f_cpu_datapoint_cap()

-- DROP FUNCTION benchmarkts_schema.f_cpu_datapoint_cap();

CREATE OR REPLACE FUNCTION benchmarkts_schema.f_cpu_datapoint_cap(
	)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare 
	num1 numeric; 
begin
	num1 = trunc((random()*(100-50)+50)::numeric,4);
	if num1 > 100 then
		num1 = 100;
	end if;
	RETURN num1;
END;
$BODY$;

ALTER FUNCTION benchmarkts_schema.f_cpu_datapoint_cap()
    OWNER TO postgres;




-- FUNCTION: benchmarkts_schema.f_insert_cpu_data_pass(character varying)

-- DROP FUNCTION benchmarkts_schema.f_insert_cpu_data_pass(character varying);

CREATE OR REPLACE FUNCTION benchmarkts_schema.f_insert_cpu_data_pass(
	rest_id character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),rest_id,benchmarkts_schema.f_cpu_datapoint_cap(),benchmarkts_schema.f_cpu_datapoint_cap(),benchmarkts_schema.f_cpu_datapoint_cap(),benchmarkts_schema.f_cpu_datapoint_cap());
	end loop;
END;
$BODY$;

ALTER FUNCTION benchmarkts_schema.f_insert_cpu_data_pass(character varying)
    OWNER TO postgres;
	
	
	
-- FUNCTION: benchmarkts_schema.insert_cpu_data()

-- DROP FUNCTION benchmarkts_schema.insert_cpu_data();

CREATE OR REPLACE FUNCTION benchmarkts_schema.insert_cpu_data(
	)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
	for count in 1..2000000 loop
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),'100001',benchmarkts_schema.cpu_datapoint_cap(),benchmarkts_schema.cpu_datapoint_cap(),benchmarkts_schema.cpu_datapoint_cap(),benchmarkts_schema.cpu_datapoint_cap());
	end loop;
END;
$BODY$;

ALTER FUNCTION benchmarkts_schema.insert_cpu_data()
    OWNER TO postgres;	