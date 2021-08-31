--CANNOT FIND TEST SQLCODE
--THIS IS THE ORIGINAL IT WAS DERIVED FROM
--LOOK AT THE MYSQL QUERIES TO RECREATE


set search_path = benchmarkts_schema;
SELECT ts, (virtual_memory_percent / virtual_memory_avail / 1000000) as value
FROM cpu
WHERE ts > now() - INTERVAL '1 hour'

SELECT date_trunc('minute', time) AS minute, 
  MAX(usage_user)
FROM cpu
WHERE hostname = 'host_731'
  AND time >= '2016-01-01 02:17:08.646325 -7:00'
  AND time < '2016-01-01 03:17:08.646325 -7:00'
GROUP BY minute
ORDER BY minute ASC;

SELECT
  date_trunc('minute', time) AS minute,
  MAX(usage_user)
FROM cpu
WHERE hostname = 'host_731'
  AND time >= '2016-01-01 07:47:52'
  AND time < '2016-01-01 19:47:52'
GROUP BY minute
ORDER BY minute ASC

SELECT date_trunc('minute', time) 
  AS minute, max(usage_user) 
FROM cpu 
WHERE time < '2016-01-01 19:47:52' 
GROUP BY minute 
ORDER BY minute DESC 
LIMIT 5

