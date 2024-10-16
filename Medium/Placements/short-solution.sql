SELECT
    Name
FROM
    Students s
    JOIN Friends f ON s.ID = f.ID
    JOIN Packages p1 ON s.ID = p1.ID
    JOIN Packages p2 ON f.Friend_ID = p2.ID
WHERE
    p1.salary < p2.salary
ORDER BY
    p2.Salary;