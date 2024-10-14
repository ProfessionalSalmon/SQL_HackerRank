WITH doctor AS (
    SELECT
        Name,
        ROW_NUMBER() OVER (
            ORDER BY
                Name
        ) AS rownum
    FROM
        Occupations
    WHERE
        Occupation = 'Doctor'
),
professor AS (
    SELECT
        Name,
        ROW_NUMBER() OVER (
            ORDER BY
                Name
        ) AS rownum
    FROM
        Occupations
    WHERE
        Occupation = 'Professor'
),
singer AS (
    SELECT
        Name,
        ROW_NUMBER() OVER (
            ORDER BY
                Name
        ) AS rownum
    FROM
        Occupations
    WHERE
        Occupation = 'Singer'
),
actor AS (
    SELECT
        Name,
        ROW_NUMBER() OVER (
            ORDER BY
                Name
        ) AS rownum
    FROM
        Occupations
    WHERE
        Occupation = 'Actor'
)
SELECT
    doctor.name,
    professor.name,
    singer.name,
    actor.name
FROM
    doctor FULL
    OUTER JOIN professor ON doctor.rownum = professor.rownum FULL
    OUTER JOIN singer ON professor.rownum = singer.rownum FULL
    OUTER JOIN actor ON professor.rownum = actor.rownum;