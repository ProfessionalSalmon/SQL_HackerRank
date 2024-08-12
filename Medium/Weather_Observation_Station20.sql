-- Find Median

SELECT
   CAST(AVG(LAT_N) AS DECIMAL(10, 4))
FROM
   (
      SELECT
         LAT_N,
         ROW_NUMBER() OVER (
            ORDER BY
               LAT_N
         ) AS row_asc,
         ROW_NUMBER() OVER (
            ORDER BY
               LAT_N DESC
         ) AS row_desc
      FROM
         STATION
   ) AS t1
WHERE
   row_asc IN (row_desc, row_desc - 1, row_desc + 1);