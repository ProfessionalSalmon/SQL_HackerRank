WITH t1 AS (
    SELECT
        MIN(LAT_N) AS a,
        MIN(LONG_W) AS b,
        MAX(LAT_N) AS c,
        MAX(LONG_W) AS d
    FROM
        STATION
)
SELECT
    CAST((ABS(a - c) + ABS(b - d)) AS DECIMAL(10, 4))
FROM
    t1