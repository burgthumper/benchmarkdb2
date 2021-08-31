
SET GLOBAL log_bin_trust_function_creators = 1;


CREATE FUNCTION `f_cpu_datapoint_cap`() RETURNS float
BEGIN
	declare num1 float; 
	SET num1 = truncate((RAND()*(100-50)+50),4);
	if num1 > 100 then
		SET num1 = 100;
	end if;	
	RETURN num1;
END

select f_cpu_datapoint_cap();




CREATE FUNCTION `f_insert_cpu_data`() RETURNS int
BEGIN
	declare x INT default 0;
    WHILE x < 2000000 DO
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),'100001',benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap());
		SET x = x + 1;
    END WHILE;
    RETURN 1;
END

select f_insert_cpu_data();
select count(*) from cpu;
select * from cpu;




CREATE FUNCTION `f_insert_cpu_data_pass`(rest_id varchar) 
RETURNS int
NOT DETERMINISTIC
BEGIN
	declare x INT default 0;
    WHILE x < 2000000 DO
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),rest_id,benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap());
		SET x = x + 1;
    END WHILE;
    RETURN 1;
END

select f_insert_cpu_data_pass('1');
select count(*) from cpu;


---------------------------------------------------------------------------

SELECT f_insert_cpu_data_pass('100004');

##delete from cpu where restaurant_id = '100004';

select count(*) from cpu;
select count(*) from cpu where restaurant_id = '100004';

select * from cpu where restaurant_id = '100004' LIMIT 5;
2021-04-06 14:18:14

select * from cpu where restaurant_id = '100004' LIMIT 10;

