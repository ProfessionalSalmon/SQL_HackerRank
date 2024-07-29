SELECT
    CONCAT(Name, "(", LEFT(Occupation, 1), ")")
FROM
    OCCUPATIONS
UNION
SELECT
    CONCAT(
        "There are a total of ",
        COUNT(*),
        " ",
        LOWER(Occupation),
        "s."
    )
FROM
    OCCUPATIONS
GROUP BY
    Occupation;