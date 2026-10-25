# Write your MySQL query statement below
WITH term_table AS (
   SELECT 
       ROW_NUMBER() OVER(ORDER BY power DESC) AS line, 
       CONCAT(
           CASE
               WHEN factor > 0 THEN CONCAT('+', factor)
               ELSE factor
           END,
           CASE
               WHEN power = 1 THEN 'X'
               WHEN power = 0 THEN ''
               ELSE CONCAT('X^', power)
           END
       ) AS equation
   FROM terms
)
SELECT 
    CONCAT(GROUP_CONCAT(equation SEPARATOR ''), '=0') AS equation
FROM term_table