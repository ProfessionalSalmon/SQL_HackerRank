WITH t1 AS (
    SELECT
        Start_Date,
        DENSE_RANK() OVER (
            ORDER BY
                Start_Date
        ) AS rank_start
    FROM
        Projects
    WHERE
        Start_Date NOT IN (
            SELECT
                End_Date
            FROM
                Projects
        )
),
t2 AS (
    SELECT
        End_Date,
        DENSE_RANK() OVER (
            ORDER BY
                End_Date
        ) AS rank_end
    FROM
        Projects
    WHERE
        End_Date NOT IN (
            SELECT
                Start_Date
            FROM
                Projects
        )
)
SELECT
    Start_Date,
    End_Date
FROM
    t1
    JOIN t2 ON rank_start = rank_end
ORDER BY
    DATEDIFF(day, Start_Date, End_Date),
    Start_Date;