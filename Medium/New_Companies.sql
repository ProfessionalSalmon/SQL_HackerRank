SELECT
    e.company_code,
    founder,
    COUNT(DISTINCT lead_manager_code),
    COUNT(DISTINCT senior_manager_code),
    COUNT(DISTINCT manager_code),
    COUNT(DISTINCT employee_code)
FROM
    Employee e
    LEFT JOIN Company c ON e.company_code = c.company_code
GROUP BY
    e.company_code,
    founder;