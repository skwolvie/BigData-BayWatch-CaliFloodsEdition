-- CREATE DATABASE flood_analytics;
-- Use flood_analytics;

CREATE TABLE COUNTY(
   fips_code int, county_name varchar(255),
   PRIMARY KEY (fips_code)
);

CREATE TABLE FACT(
   fips_code int REFERENCES COUNTY(fips_code), date varchar(255), year int,
   floods_count int,
   PRCP_min int, PRCP_max int, PRCP_mean int,
   TEMP_min int, TEMP_max int, TEMP_mean int,
   SNOW_min int, SNOW_max int, SNOW_mean int,
   SNWD_min int, SNWD_max int, SNWD_mean int,
   PRIMARY KEY (fips_code, date, year)
);


CREATE TABLE FLOOD_EVENTS(
   event_id int, date varchar(255),
   fips_code int REFERENCES COUNTY(fips_code),
   location varchar(255), lat varchar(255), lng varchar(255),
   event_type varchar(255), flood_cause varchar(255), flood_impact_days int,
   PRIMARY KEY (event_id)
);

CREATE TABLE INSURANCE(
   fima_record_id varchar(255),
   policy_date varchar(255), year int,
   fips_code int REFERENCES COUNTY(fips_code),
   zip_code int, flood_zone varchar(255),
   lat varchar(255), lng varchar(255),
   occupancy_type varchar(255), floors varchar(255),
   policy_cost int,
   total_building_insurance_coverage varchar(255),
   total_contents_insurance_coverage varchar(255),
   PRIMARY KEY (fima_record_id)
);

CREATE TABLE WEATHER_STATIONS(
   fips_code int REFERENCES COUNTY(fips_code),
   stationID varchar(255),
   lat varchar(255),
   lng varchar(255),
   PRIMARY KEY (stationID)
);

CREATE TABLE WEATHER(
   stationID varchar(255) REFERENCES WEATHER_STATIONS(stationID),
   date varchar(255),
   year int,
   PRCP varchar(255),
   SNOW varchar(255),
   SNWD varchar(255),
   TMAX varchar(255),
   TMIN varchar(255),
   PRIMARY KEY (stationID, date)
);

CREATE TABLE CA_COUNTY_YEARLY_INSURANCE_STATS(
   fips_code int REFERENCES COUNTY(fips_code),
   year int,
   log_insured float,
   log_cost float,
   policy_count int,
   PRIMARY KEY (fips_code, year)
);

Copy COUNTY from 's3://data228-redshift/COUNTY.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."county";

Copy CA_COUNTY_YEARLY_INSURANCE_STATS from 's3://data228-redshift/CA_COUNTY_YEARLY_INSURANCE_STATS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."ca_county_yearly_insurance_stats";

Copy WEATHER_STATIONS from 's3://data228-redshift/WEATHER_STATIONS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."weather_stations";

Copy FLOOD_EVENTS from 's3://data228-redshift/FLOOD_EVENTS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."FLOOD_EVENTS";

Copy FACT from 's3://data228-redshift/FACT.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."FACT";

Copy WEATHER from 's3://data228-redshift/WEATHER.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."WEATHER";

Copy INSURANCE from 's3://data228-redshift/INSURANCE.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."INSURANCE";


SELECT * FROM information_schema.columns WHERE table_name = 'your_table_name';

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public';
