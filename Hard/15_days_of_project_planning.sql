/* Clarify Problem Statement:
 Write a query to print 
 1. submission_date
 2. total number of unique hackers who made at least one submission each day 
 (starting from the first day of the contest until that day)
 3. hacker_id and 
 4. name of the hacker who made maximum number of submissions each day 
 
 - For 3 and 4, hackers do not have to make consecutive submissions to be qualified 
 - If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
 - The query should print this information for each day of the contest, sorted by the date.
 */


-- STEP 1: 
-- Query a table which collect the records of hacker's id and days in which they made submissions, along with what day we are currently looking at
-- This can be done by crossing join the submission table with itself.
-- However, we need to reduce the complexity and numbers of column of submission table first.
-- We query a new table with only unique submission_date and hacker_id then cross join.
-- Cross join where s1.submission_date >= s2.submission_date AND s1.hacker_id = s2.hacker_id
-- We will then obtain the records of 1. submission_date 2. hacker's id and 3. days in which they made submissions before and including the day we are currently looking at (day_submitted).
-- Select submission_date, hacker's id and, count day_submitted (which is of each hacker and each date)
-- Select only the rows where number of day_submitted equals numbers of days from the starting date (which corresponds to the day we are looking at)

WITH total_sub_per_hack AS (
    SELECT
        s1.submission_date,
        s1.hacker_id,
        COUNT(s1.hacker_id) AS count_sub_per_hack_per_day
    FROM
        (
            SELECT
                DISTINCT submission_date,
                hacker_id
            FROM
                Submissions
        ) AS s1
        CROSS JOIN (
            SELECT
                DISTINCT submission_date,
                hacker_id
            FROM
                Submissions
        ) AS s2
    WHERE
        s1.submission_date >= s2.submission_date
        AND s1.hacker_id = s2.hacker_id
    GROUP BY
        s1.submission_date,
        s1.hacker_id
    HAVING
        COUNT(s1.hacker_id) = DATEDIFF(day, '2016-03-01', s1.submission_date) + 1
),

-- STEP 2:
-- Query a table which count the numbers of unique hackers whose day_submitted equals numbers of days from the starting date

total_sub AS (
    SELECT
        submission_date,
        COUNT(*) AS count_sub
    FROM
        total_sub_per_hack
    GROUP BY
        submission_date
),

-- STEP 3: Query a table that counts the number of submissions per hacker per day and find its maximum value

hack_sub AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(submission_id) AS count_hack
    FROM
        Submissions
    GROUP BY
        submission_date,
        hacker_id
),
max_sub AS (
    SELECT
        submission_date,
        MAX(count_hack) AS max_count_hack
    FROM
        hack_sub
    GROUP BY
        submission_date
)

-- STEP 4:
-- Inner Join table from step 2 with table from step 3 by submission_date
-- (hack_sub is required because we need id of hackers who made maximum submissions that day)
-- Add name column by joining the above table with Hackers table by hacker_id

SELECT
    submission_date,
    count_sub,
    id_hacker,
    name
FROM
    (
        SELECT
            t.submission_date,
            t.count_sub,
            max_count_hack,
            MIN(hs.hacker_id) AS id_hacker
        FROM
            total_sub t
            JOIN max_sub m ON t.submission_date = m.submission_date
            JOIN hack_sub hs ON hs.submission_date = m.submission_date
            AND hs.count_hack = m.max_count_hack
        GROUP BY
            t.submission_date,
            t.count_sub,
            max_count_hack
    ) AS t1
    JOIN Hackers h ON t1.id_hacker = h.hacker_id
ORDER BY
    submission_date;