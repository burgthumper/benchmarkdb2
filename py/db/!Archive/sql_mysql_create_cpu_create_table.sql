DROP TABLE IF EXISTS `cpu`;
CREATE TABLE `cpu` (
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_insert` timestamp,
  `restaurant_id` varchar(6) NOT NULL,
  `virtual_memory_percent` float DEFAULT NULL,
  `virtual_memory_avail` float DEFAULT NULL,
  `cpu_percent` float DEFAULT NULL,
  `getloadavg` float DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
