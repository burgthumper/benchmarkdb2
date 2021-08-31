CREATE DEFINER=`root`@`%` FUNCTION `f_cpu_datapoint_cap`() RETURNS float
BEGIN
	declare num1 float; 
	SET num1 = truncate((RAND()*(100-50)+50),4);
	if num1 > 100 then
		SET num1 = 100;
	end if;	
	RETURN num1;
END


CREATE DEFINER=`root`@`%` FUNCTION `f_insert_cpu_data`() RETURNS int
BEGIN
	declare x INT default 0;
    WHILE x < 2000000 DO
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(4),'100001',benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap());
		SET x = x + 1;
    END WHILE;
    RETURN 1;
END


CREATE DEFINER=`root`@`%` FUNCTION `f_insert_cpu_data_pass`(rest_id varchar(6)) RETURNS int
BEGIN
	declare x INT default 0;
    WHILE x < 2000000 DO
		insert into cpu (ts_insert, restaurant_id, virtual_memory_percent, virtual_memory_avail , cpu_percent , getloadavg) 
			values (now(),rest_id,benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap(),benchmarkmysql.f_cpu_datapoint_cap());
		SET x = x + 1;
    END WHILE;
    RETURN 1;
END