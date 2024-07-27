WITH t1 AS (
    SELECT
        w.code,
        age,
        MIN(coins_needed) AS min_coins_needed,
        power
    FROM
        Wands w
        LEFT JOIN Wands_Property wp ON w.code = wp.code
    WHERE
        is_evil = 0
    GROUP BY
        w.code,
        age,
        power
)
SELECT
    id,
    age,
    min_coins_needed,
    t1.power
FROM
    Wands w
    JOIN t1 ON w.code = t1.code
    AND w.coins_needed = min_coins_needed
ORDER BY
    t1.power DESC,
    age DESC;