WITH t1 AS (
    SELECT
        h.hacker_id,
        h.name,
        c.challenge_id,
        c.difficulty_level,
        s.score AS score_obtained,
        d.score AS full_score
    FROM
        Hackers h
        JOIN Submissions s ON h.hacker_id = s.hacker_id
        JOIN Challenges c ON s.challenge_id = c.challenge_id
        JOIN Difficulty d ON d.difficulty_level = c.difficulty_level
    WHERE
        s.score = d.score
)
SELECT
    hacker_id,
    name
FROM
    t1
GROUP BY
    hacker_id,
    name
HAVING
    COUNT(*) > 1
ORDER BY
    COUNT(*) DESC,
    hacker_id;