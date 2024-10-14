SELECT
    Name + '(' + LEFT(Occupation, 1) + ')' AS output
FROM
    OCCUPATIONS
UNION
SELECT
    'There are a total of ' + CAST(COUNT(*) AS VARCHAR(50)) + ' ' + LOWER(Occupation) + 's.' AS output
FROM
    OCCUPATIONS
GROUP BY
    Occupation
ORDER BY
    output;