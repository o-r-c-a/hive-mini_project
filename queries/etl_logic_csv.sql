DROP TABLE nyc_taxi;

CREATE EXTERNAL TABLE nyc_taxi (
    vendor_id INT,
    lpep_pickup_datetime STRING,
    lpep_dropoff_datetime STRING,
    store_and_fwd_flag STRING,
    rate_code_id INT,
    pu_location_id INT,
    do_location_id INT,
    passenger_count INT,
    trip_distance DOUBLE,
    fare_amount DOUBLE,
    extra DOUBLE,
    mta_tax DOUBLE,
    tip_amount DOUBLE,
    tolls_amount DOUBLE,
    ehail_fee DOUBLE,
    improvement_surcharge DOUBLE,
    total_amount DOUBLE,
    payment_type INT,
    trip_type INT,
    congestion_surcharge DOUBLE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/opt/hive/data/warehouse/nyc_taxi/csv/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM nyc_taxi LIMIT 7;