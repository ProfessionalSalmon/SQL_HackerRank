-- Query the Euclidean Distance

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
    CAST( SQRT(POWER(a - c, 2) + POWER(b - d,2) ) AS DECIMAL(10, 4) )
FROM
    t1;