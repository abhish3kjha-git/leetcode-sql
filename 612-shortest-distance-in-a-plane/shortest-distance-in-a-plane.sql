# Write your MySQL query statement below
SELECT
    ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))), 2) AS shortest
FROM
    point2d p1
        JOIN
    point2d p2 ON p1.x != p2.x OR p1.y != p2.y
;