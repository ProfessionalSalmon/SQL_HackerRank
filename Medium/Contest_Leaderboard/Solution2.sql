--ROW_NUMBER()

SELECT * FROM
(SELECT hacker_id, name, SUM(score) as sum_score
FROM 
(SELECT h.hacker_id AS hacker_id, name, challenge_id, score, ROW_NUMBER() OVER (PARTITION BY h.hacker_id, name, challenge_id ORDER BY score DESC) AS rn
FROM HACKERS h
    JOIN SUBMISSIONS s ON h.hacker_id = s.hacker_id) AS t1
WHERE rn = 1
GROUP BY hacker_id, name) AS t2
WHERE sum_score != 0
ORDER BY sum_score DESC, hacker_id