--MAX()

SELECT hacker_id, name, SUM(max_score) as sum_score
FROM 
(SELECT h.hacker_id AS hacker_id, name, challenge_id, MAX(score) AS max_score
FROM HACKERS h
    JOIN SUBMISSIONS s ON h.hacker_id = s.hacker_id
GROUP BY h.hacker_id, name, challenge_id) AS t1
GROUP BY hacker_id, name
HAVING SUM(max_score) != 0
ORDER BY SUM(max_score) DESC, hacker_id