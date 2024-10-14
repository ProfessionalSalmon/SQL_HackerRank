-- UNION and inclusion
SELECT
    *
FROM
    t1
WHERE
    challenge_count IN (
        SELECT
            MAX(challenge_count)
        FROM
            t1
    )
UNION
SELECT
    *
FROM
    t1
WHERE
    challenge_count IN (
        SELECT
            challenge_count
        FROM
            t1
        GROUP BY
            challenge_count
        HAVING
            COUNT(challenge_count) = 1
    )
ORDER BY
    challenge_count DESC,
    hacker_id;