
WITH RECURSIVE  A AS(
    SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(tweet, "#", -1), " ", 1) AS tag,
    SUBSTRING(tweet, 1, LENGTH(tweet) - LOCATE('#', REVERSE(tweet))) AS remain
    FROM Tweets
    UNION ALL
    SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(remain, "#", -1), " ", 1) AS tag,
    SUBSTRING(remain, 1, LENGTH(remain) - LOCATE('#', REVERSE(remain))) AS remain
    FROM A WHERE LOCATE('#', remain) > 0
),
B AS(
    SELECT CONCAT("#", tag) AS hashtag , COUNT(*) AS count  FROM A GROUP BY 1
)
SELECT * FROM B ORDER BY 2 DESC, 1 DESC LIMIT 3