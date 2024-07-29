WITH SHORTEST AS (
    SELECT
        TOP 1 CITY,
        LEN(CITY) AS LEN_CITY
    FROM
        STATION
    WHERE
        LEN(CITY) IN (
            SELECT
                MIN(LEN(CITY))
            FROM
                STATION
        )
    ORDER BY
        CITY
),
LONGEST AS (
    SELECT
        TOP 1 CITY,
        LEN(CITY) AS LEN_CITY
    FROM
        STATION
    WHERE
        LEN(CITY) IN (
            SELECT
                MAX(LEN(CITY))
            FROM
                STATION
        )
    ORDER BY
        CITY
)
SELECT
    *
FROM
    SHORTEST
UNION
SELECT
    *
FROM
    LONGEST;