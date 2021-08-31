
##QUERY A
select count(*) from (
	SELECT ts, (virtual_memory_percent / virtual_memory_avail / 1000000) as value
	FROM cpu
	WHERE ts = '2021-04-07 15:21:58'
	##WHERE ts > now() - INTERVAL '20' minute
) as t;

##QUERY B
select count(*) from (
	SELECT DATE_FORMAT(ts, '%Y-%m-%d %H:%i') AS minute, virtual_memory_percent 
	FROM cpu
	WHERE cpu.restaurant_id = '100013'
	  AND cpu.ts >= '2021-04-07 15:21:58'
	  AND cpu.ts < '2021-04-07 15:22:00'
	ORDER BY minute ASC
) as t;

##QUERY C
SELECT DATE_FORMAT(ts, '%Y-%m-%d %H:%i') AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.restaurant_id = '100013'
  AND cpu.ts >= '2021-04-07 15:21:58'
  AND cpu.ts < '2021-04-07 15:22:00'
GROUP BY minute;

##QUERY D
SELECT DATE_FORMAT(ts, '%Y-%m-%d %H:%i') AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.restaurant_id = '100013'
  AND cpu.ts >= '2021-04-07 15:21:58'
  AND cpu.ts < '2021-04-07 15:22:00'
GROUP BY minute
ORDER BY minute ASC;

##QUERY E; expand ts range in where; 2 restaurants
SELECT DATE_FORMAT(ts, '%Y-%m-%d %H:%i') AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.ts >= '2021-04-07 14:39:20'
  AND cpu.ts <= '2021-04-07 15:21:58'
GROUP BY minute
ORDER BY minute ASC;

##QUERY F; further expand ts range in where; 4 restaurants
SELECT DATE_FORMAT(ts, '%Y-%m-%d %H:%i') AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.ts >= '2021-04-06 20:35:54'
  AND cpu.ts <= '2021-04-07 15:21:58'
GROUP BY minute
ORDER BY minute ASC;

##QUERY G
select count(*) from (
	select cpu.ts, cpu.restaurant_id, restaurants.postal_code from cpu
	inner join restaurants on cpu.restaurant_id = restaurants.restaurant_id
	WHERE cpu.restaurant_id = '100013'
	  AND cpu.ts >= '2021-04-07 15:21:58'
	  AND cpu.ts < '2021-04-07 15:22:00'
) as t;

##QUERY H
select count(*) from (
	SELECT ts, virtual_memory_percent 
	FROM cpu
	WHERE cpu.restaurant_id = '100013'
	  AND cpu.ts >= '2021-04-07 15:21:58'
	  AND cpu.ts < '2021-04-07 15:22:00'
	ORDER BY virtual_memory_percent ASC
) as t;
