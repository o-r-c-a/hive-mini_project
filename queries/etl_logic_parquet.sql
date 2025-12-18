DROP TABLE IF EXISTS nyc_taxi_parquet;

CREATE EXTERNAL TABLE nyc_taxi_parquet (
    VendorID INT,
    tpep_pickup_datetime TIMESTAMP,
    tpep_dropoff_datetime TIMESTAMP,
    passenger_count DOUBLE,
    trip_distance DOUBLE,
    RatecodeID DOUBLE,
    store_and_fwd_flag STRING,
    PULocationID INT,
    DOLocationID INT,
    payment_type INT,
    fare_amount DOUBLE,
    extra DOUBLE,
    mta_tax DOUBLE,
    tip_amount DOUBLE,
    tolls_amount DOUBLE,
    improvement_surcharge DOUBLE,
    total_amount DOUBLE,
    congestion_surcharge DOUBLE,
    airport_fee DOUBLE
)
STORED AS PARQUET
LOCATION '/opt/hive/data/warehouse/nyc_taxi/parquet/';

-- SET hive.vectorized.execution.enabled = false;
-- SET hive.vectorized.execution.reduce.enabled = false;

SELECT
    CASE payment_type
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Cash'
        WHEN 3 THEN 'No Charge'
        WHEN 4 THEN 'Dispute'
        ELSE 'Unknown'
    END AS payment_method,
    COUNT(*) as total_trips,
    ROUND(SUM(fare_amount), 2) as total_revenue,
    ROUND(AVG(trip_distance), 2) as avg_distance_miles
FROM nyc_taxi_parquet
GROUP BY payment_type
ORDER BY total_revenue DESC;