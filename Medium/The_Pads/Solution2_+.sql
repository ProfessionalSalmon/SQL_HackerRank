SELECT
    Name + '(' + LEFT(Occupation, 1) + ')'
FROM
    OCCUPATIONS
UNION
SELECT
    'There are a total of ' + CAST(COUNT(*) AS VARCHAR(50)) + ' ' + LOWER(Occupation) + 's.'
FROM
    OCCUPATIONS
GROUP BY
    Occupation;