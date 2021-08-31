set search_path = benchmarkpg_schema;

select * from restaurants where restaurant_id = '100004';


--QUERY A
select count (*) from (
	SELECT ts, (virtual_memory_percent / virtual_memory_avail / 1000000) as value
	FROM benchmarkpg_schema.cpu
	WHERE ts > now() - INTERVAL '20 minute'
) as t;

--QUERY B
select count (*) from (
	SELECT date_trunc('minute', cpu.ts) AS minute, virtual_memory_percent
	FROM cpu
	WHERE cpu.restaurant_id = '100004'
	  AND cpu.ts >= '2021-04-06 13:44:28.558137'
	  AND cpu.ts < '2021-04-06 13:44:29.0'
	ORDER BY minute ASC
) as t;

--QUERY C
SELECT date_trunc('minute', cpu.ts) AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.restaurant_id = '100004'
  AND cpu.ts >= '2021-04-06 13:44:28.558137'
  AND cpu.ts < '2021-04-06 13:44:29.0'
GROUP BY minute

--QUERY D
SELECT date_trunc('minute', cpu.ts) AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.restaurant_id = '100004'
  AND cpu.ts >= '2021-04-06 13:44:28.558137'
  AND cpu.ts < '2021-04-06 13:44:29.0'
GROUP BY minute
ORDER BY minute ASC;

--QUERY E; expand ts range in where; 2 restaurants
SELECT date_trunc('minute', cpu.ts) AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.ts >= '2021-04-05 19:14:31.14387'
  AND cpu.ts <= '2021-04-06 13:44:28.558137'
GROUP BY minute
ORDER BY minute ASC;

--QUERY F; further expand ts range in where; 4 restaurants
SELECT date_trunc('minute', cpu.ts) AS minute, MAX(ts_insert)
FROM cpu
WHERE cpu.ts >= '2021-03-31 19:43:18.621106'
  AND cpu.ts <= '2021-04-06 13:44:28.558137'
GROUP BY minute
ORDER BY minute ASC;

--QUERY G
select count (*) from (
	select cpu.ts, cpu.restaurant_id, restaurants.postal_code from cpu
	inner join restaurants on cpu.restaurant_id = restaurants.restaurant_id
	WHERE cpu.restaurant_id = '100004'
	  AND cpu.ts >= '2021-04-06 13:44:28.558137'
	  AND cpu.ts < '2021-04-06 13:44:29.0'
) as t;

--QUERY H
select count (*) from (
	SELECT ts, virtual_memory_percent
	FROM cpu
	WHERE cpu.restaurant_id = '100004'
	  AND cpu.ts >= '2021-04-06 13:44:28.558137'
	  AND cpu.ts < '2021-04-06 13:44:29.0'
	ORDER BY virtual_memory_percent ASC
) as t;