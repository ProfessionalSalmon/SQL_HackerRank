WITH t1 AS (
    SELECT
        l.company_code,
        COUNT(DISTINCT l.lead_manager_code) AS a,
        COUNT(DISTINCT s.senior_manager_code) AS b,
        COUNT(DISTINCT m.manager_code) AS c,
        COUNT(DISTINCT e.employee_code) AS d
    FROM
        Lead_Manager l
        JOIN Senior_Manager s ON l.company_code = s.company_code
        JOIN Manager m ON s.company_code = m.company_code
        JOIN Employee e ON e.company_code = m.company_code
    GROUP BY
        (l.company_code)
)
SELECT
    t1.company_code,
    founder,
    a,
    b,
    c,
    d
FROM
    t1
    JOIN Company ON t1.company_code = Company.company_code
ORDER BY
    t1.company_code;