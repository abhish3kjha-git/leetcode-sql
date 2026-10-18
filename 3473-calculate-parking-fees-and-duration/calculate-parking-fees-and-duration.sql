WITH lot_time AS (
    SELECT
        car_id,
        lot_id,
        SUM(
            TIMESTAMPDIFF(SECOND, entry_time, exit_time)
        ) AS total_time
    FROM ParkingTransactions
    GROUP BY car_id, lot_id
),

ranked AS (
    SELECT
        car_id,
        lot_id,
        RANK() OVER (
            PARTITION BY car_id
            ORDER BY total_time DESC
        ) AS rnk
    FROM lot_time
)

SELECT
    p.car_id,
    SUM(p.fee_paid) AS total_fee_paid,

    ROUND(
        SUM(p.fee_paid) /
        (SUM(TIMESTAMPDIFF(SECOND, p.entry_time, p.exit_time)) / 3600)
    , 2) AS avg_hourly_fee,

    r.lot_id AS most_time_lot
FROM ParkingTransactions p
JOIN ranked r
    ON p.car_id = r.car_id
    AND r.rnk = 1
GROUP BY p.car_id, r.lot_id
ORDER BY p.car_id
