SELECT
    CONCAT(Name, '(', SUBSTRING(Occupation, 1, 1), ')') AS output
FROM
    OCCUPATIONS
UNION
SELECT
    CONCAT(
        'There are a total of ',
        COUNT(*),
        ' ',
        LOWER(Occupation),
        's.'
    ) AS output
FROM
    OCCUPATIONS
GROUP BY
    Occupation
ORDER BY
    output;