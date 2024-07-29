SELECT
    a.X AS X,
    a.Y
FROM
    FUNCTIONS a,
    FUNCTIONS b
WHERE
    a.X = b.Y
    AND a.Y = b.X
    AND a.X != b.X
    AND b.Y != a.Y
    AND a.X < a.Y
UNION
SELECT
    X,
    Y
FROM
    FUNCTIONS
GROUP BY
    X,
    Y
HAVING
    COUNT(*) > 1
ORDER BY
    X;