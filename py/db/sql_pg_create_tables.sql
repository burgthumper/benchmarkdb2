
CREATE SCHEMA benchmarkpg
    AUTHORIZATION postgres;
	
CREATE TABLE benchmarkpg.cpu_test
(
    ts timestamp without time zone,
    ts_insert timestamp without time zone,
    restaurant_id character varying(6) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE benchmarkpg.cpu_test
    OWNER to postgres;
	
##-------------------------------------------------

set search_path = benchmarkpg_schema;
CREATE TABLE restaurants (
  restaurant_id character varying(6) NOT NULL,
  address character varying(200) DEFAULT NULL,
  city character varying(100) DEFAULT NULL,
  province character varying(2) DEFAULT NULL,
  postal_code character varying(10) DEFAULT NULL,
  country character varying(3) DEFAULT NULL,
  latitude decimal(8,6) DEFAULT NULL,
  longitude decimal(9,6) DEFAULT NULL,
  mdb character varying(200) DEFAULT NULL,
  dbd character varying(200) DEFAULT NULL,
  rvp character varying(200) DEFAULT NULL,
  rmm character varying(200) DEFAULT NULL,
  mos character varying(200) DEFAULT NULL,
  mrt character varying(200) DEFAULT NULL,
  dma character varying(3) DEFAULT NULL,
  PRIMARY KEY (restaurant_id)
);

CREATE TABLE daily_coupon_redemptions_per_restaurant (
  summary_date date NOT NULL,
  coupon_id integer NOT NULL,
  restaurant_id character varying(6) NOT NULL,
  redemption_count integer DEFAULT '0',
  PRIMARY KEY (summary_date,coupon_id,restaurant_id)
);

CREATE TABLE cpu (
  ts timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  ts_insert timestamp NULL DEFAULT NULL,
  restaurant_id character varying(6) NOT NULL,
  virtual_memory_percent float DEFAULT NULL,
  virtual_memory_avail float DEFAULT NULL,
  cpu_percent float DEFAULT NULL,
  getloadavg float DEFAULT NULL
);

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-timescaledb-on-ubuntu-20-04
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
??? ALTER DATABASE benchmarkts SET search_path = public,benchmarkts_schema; ???
SELECT public.create_hypertable('"cpu"', 'ts');


CREATE TABLE coupon_issued (
  id int NOT NULL,
  serial bigint NOT NULL,
  secret character varying(32) NOT NULL,
  is_burnable numeric(1) NOT NULL DEFAULT '0',
  expiration timestamp DEFAULT NULL,
  incipience timestamp DEFAULT NULL,
  overall_use_count integer NOT NULL DEFAULT '0',
  period_use_count integer NOT NULL DEFAULT '0',
  last_use_timestamp timestamp DEFAULT NULL,
  last_actioN character varying(20) DEFAULT NULL,
  tracked_use_count integer NOT NULL DEFAULT '0',
  last_tracked_timestamp timestamp DEFAULT NULL,
  tracked_active_until timestamp DEFAULT NULL,
  available_redemptions integer DEFAULT '0',
  last_redemption_earned timestamp DEFAULT NULL,
  last_number_of_redemptions_applied integer DEFAULT '0',
  number_of_redemptions_earned_in_time_period integer DEFAULT '0',
  last_apply_amount decimal(9,2) DEFAULT NULL,
  registration_timestamp timestamp DEFAULT NULL,
  user_reference_id character varying(100) DEFAULT NULL,
  is_deactivated numeric(1) DEFAULT '0',
  has_received_registration_reward numeric(1) DEFAULT '0',
  campaign_id integer DEFAULT NULL,
  coupon_short_id character varying(25) DEFAULT NULL,
  coupon_barcode character varying(100) DEFAULT NULL,
  first_transaction_timestamp timestamp DEFAULT NULL,
  PRIMARY KEY (id,serial),
  UNIQUE (coupon_short_id)
);
CREATE INDEX user_reference_id_INDEX ON coupon_issued (user_reference_id);
CREATE INDEX barcode_INDEX ON coupon_issued (coupon_barcode);


CREATE TABLE coupon_transaction (
  id SERIAL,
  type character varying(20) NOT NULL,
  status integer NOT NULL,
  utc_timestamp timestamp NOT NULL,
  coupon_id integer DEFAULT NULL,
  coupon_serial bigint DEFAULT NULL,
  pos_token character varying(32) DEFAULT NULL,
  pos_restaurant character varying(6) DEFAULT NULL,
  pos_terminal character varying(50) DEFAULT NULL,
  pos_operator character varying(50) DEFAULT NULL,
  pos_transid character varying(20) DEFAULT NULL,
  pos_timestamp timestamp DEFAULT NULL,
  pos_language character varying(2) DEFAULT NULL,
  coupon_code_raw character varying(100) DEFAULT NULL,
  coupon_code character varying(45) DEFAULT NULL,
  coupon_secret_hash character varying(32) DEFAULT NULL,
  coupon_expiration_hash character varying(32) DEFAULT NULL,
  basket_type character varying(20) DEFAULT NULL,
  basket_items text,
  basket_coupon_amount decimal(9,2) DEFAULT NULL,
  basket_coupon_retail_amount decimal(9,2) DEFAULT NULL,
  basket_taxes decimal(9,2) DEFAULT NULL,
  basket_total decimal(9,2) DEFAULT NULL,
  basket_discounted_plu character varying(500) DEFAULT NULL,
  basket_discounted_category character varying(200) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE (id)
); 
