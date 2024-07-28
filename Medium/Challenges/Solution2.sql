-- WHERE INCLUSION

WITH t1 AS (
    SELECT
        c.hacker_id,
        h.name,
        COUNT(c.challenge_id) AS challenge_created
    FROM
        Hackers h
        JOIN Challenges C ON h.hacker_id = c.hacker_id
    GROUP BY
        c.hacker_id,
        h.name
),
t2 AS (
    SELECT
        challenge_created,
        COUNT(challenge_created) AS challenge_created_count
    FROM
        t1
    GROUP BY
        challenge_created
)
SELECT
    t1.*
FROM
    t1
    LEFT JOIN t2 ON t1.challenge_created = t2.challenge_created
WHERE --INCLUSION
    (challenge_created_count = 1)
    OR (
        (challenge_created_count > 1)
        AND (
            t1.challenge_created IN (
                SELECT
                    MAX(challenge_created) AS max_challenge_created
                FROM
                    t1
            )
        )
    )
ORDER BY
    t1.challenge_created DESC,
    t1.hacker_id;