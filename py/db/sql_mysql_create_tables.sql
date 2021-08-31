Create database benchmarkmysql;

USE benchmarkmysql;
DROP TABLE IF EXISTS `cpu`;
CREATE TABLE `cpu` (
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_insert` timestamp,
  `restaurant_id` varchar(6) NOT NULL,
  `virtual_memory_percent` float DEFAULT NULL,
  `virtual_memory_avail` float DEFAULT NULL,
  `cpu_percent` float DEFAULT NULL,
  `getloadavg` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `restaurants` (
  `restaurant_id` varchar(6) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(2) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `country` varchar(3) DEFAULT NULL,
  `latitude` decimal(8,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `mdb` varchar(200) DEFAULT NULL,
  `dbd` varchar(200) DEFAULT NULL,
  `rvp` varchar(200) DEFAULT NULL,
  `rmm` varchar(200) DEFAULT NULL,
  `mos` varchar(200) DEFAULT NULL,
  `mrt` varchar(200) DEFAULT NULL,
  `dma` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `daily_coupon_redemptions_per_restaurant` (
  `summary_date` date NOT NULL,
  `coupon_id` int NOT NULL,
  `restaurant_id` varchar(6) NOT NULL,
  `redemption_count` int DEFAULT '0',
  PRIMARY KEY (`summary_date`,`coupon_id`,`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `coupon_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `status` int NOT NULL,
  `utc_timestamp` datetime NOT NULL,
  `coupon_id` int DEFAULT NULL,
  `coupon_serial` bigint DEFAULT NULL,
  `pos_token` varchar(32) DEFAULT NULL,
  `pos_restaurant` varchar(6) DEFAULT NULL,
  `pos_terminal` varchar(50) DEFAULT NULL,
  `pos_operator` varchar(50) DEFAULT NULL,
  `pos_transid` varchar(20) DEFAULT NULL,
  `pos_timestamp` datetime DEFAULT NULL,
  `pos_language` varchar(2) DEFAULT NULL,
  `coupon_code_raw` varchar(100) DEFAULT NULL,
  `coupon_code` varchar(45) DEFAULT NULL,
  `coupon_secret_hash` varchar(32) DEFAULT NULL,
  `coupon_expiration_hash` varchar(32) DEFAULT NULL,
  `basket_type` varchar(20) DEFAULT NULL,
  `basket_items` text,
  `basket_coupon_amount` decimal(9,2) DEFAULT NULL,
  `basket_coupon_retail_amount` decimal(9,2) DEFAULT NULL,
  `basket_taxes` decimal(9,2) DEFAULT NULL,
  `basket_total` decimal(9,2) DEFAULT NULL,
  `basket_discounted_plu` varchar(500) DEFAULT NULL,
  `basket_discounted_category` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165280 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `coupon_issued` (
  `id` int NOT NULL,
  `serial` bigint NOT NULL,
  `secret` varchar(32) NOT NULL,
  `is_burnable` tinyint NOT NULL DEFAULT '0',
  `expiration` datetime DEFAULT NULL,
  `incipience` datetime DEFAULT NULL,
  `overall_use_count` int NOT NULL DEFAULT '0',
  `period_use_count` int NOT NULL DEFAULT '0',
  `last_use_timestamp` datetime DEFAULT NULL,
  `last_action` varchar(20) DEFAULT NULL,
  `tracked_use_count` int NOT NULL DEFAULT '0',
  `last_tracked_timestamp` datetime DEFAULT NULL,
  `tracked_active_until` datetime DEFAULT NULL,
  `available_redemptions` int DEFAULT '0',
  `last_redemption_earned` datetime DEFAULT NULL,
  `last_number_of_redemptions_applied` int DEFAULT '0',
  `number_of_redemptions_earned_in_time_period` int DEFAULT '0',
  `last_apply_amount` decimal(9,2) DEFAULT NULL,
  `registration_timestamp` datetime DEFAULT NULL,
  `user_reference_id` varchar(100) DEFAULT NULL,
  `is_deactivated` tinyint DEFAULT '0',
  `has_received_registration_reward` tinyint DEFAULT '0',
  `campaign_id` int DEFAULT NULL,
  `coupon_short_id` varchar(25) DEFAULT NULL,
  `coupon_barcode` varchar(100) DEFAULT NULL,
  `first_transaction_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`serial`),
  UNIQUE KEY `short_id_INDEX` (`coupon_short_id`),
  KEY `user_reference_id_INDEX` (`user_reference_id`),
  KEY `barcode_INDEX` (`coupon_barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
