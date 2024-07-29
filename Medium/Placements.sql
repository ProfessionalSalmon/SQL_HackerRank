WITH INFO AS (
    SELECT
        s.ID as my_ID,
        s.name as my_name,
        f.Friend_ID,
        p.Salary AS my_salary
    FROM
        Students s
        JOIN Friends f ON s.ID = f.ID
        JOIN Packages p ON s.ID = p.ID
)
SELECT
    my_name
FROM
    INFO i
    JOIN Packages p ON i.Friend_ID = p.ID
WHERE
    my_salary < p.salary
ORDER BY
    p.Salary