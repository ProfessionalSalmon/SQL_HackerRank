SELECT
    X,
    Y
FROM
    Functions
WHERE
    X != Y
    AND CONCAT(X, Y) IN (
        SELECT
            CONCAT(Y, X)
        FROM
            Functions
    )
    AND X <= Y
UNION
SELECT
    X,
    Y
FROM
    Functions
WHERE
    X = Y
GROUP BY
    X,
    Y
HAVING
    COUNT(*) >= 2
ORDER BY
    X,
    Y;