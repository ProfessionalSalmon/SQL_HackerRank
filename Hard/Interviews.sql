WITH sum_view AS (
    SELECT
        challenge_id,
        SUM(total_views) AS a,
        SUM(total_unique_views) AS b
    FROM
        View_Stats
    GROUP BY
        challenge_id
),
sum_submission AS (
    SELECT
        challenge_id,
        SUM(total_submissions) AS c,
        SUM(total_accepted_submissions) AS d
    FROM
        Submission_Stats
    GROUP BY
        challenge_id
) -- separate sum of two tables because they do not necessarily contain data of the same challenges
SELECT
    c.contest_id,
    hacker_id,
    name,
    -- SUM(null) = 0
    SUM(c),
    SUM(d),
    SUM(a),
    SUM(b)
FROM
    Contests c
    LEFT JOIN Colleges cl ON c.contest_id = cl.contest_id
    LEFT JOIN Challenges ch ON cl.college_id = ch.college_id
    LEFT JOIN sum_view sv ON ch.challenge_id = sv.challenge_id
    LEFT JOIN sum_submission ss ON ch.challenge_id = ss.challenge_id -- LEFT JOIN because all the latter tables do not necessarily contain all foreign keys referenced from primary keys of the former tables
    -- but we want data from all of the contests, colleges, and challenges
GROUP BY
    c.contest_id,
    hacker_id,
    name
HAVING
    SUM(c) + SUM(d) + SUM(a) + SUM(b) > 0
ORDER BY
    c.contest_id;