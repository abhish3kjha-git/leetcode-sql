SELECT player_id, IFNULL(MAX(cnt), 0) AS longest_streak
FROM Matches m
LEFT JOIN (
	SELECT player_id, p_rnk - rnk AS diff,  count(*) as cnt
	FROM (
		SELECT *, 	
			CAST(RANK () OVER (PARTITION BY player_id, result ORDER BY match_day) AS SIGNED) AS rnk,
			CAST(RANK () OVER (PARTITION BY player_id ORDER BY match_day) AS SIGNED) AS p_rnk
		FROM Matches
	) t
	WHERE result = 'Win'
	GROUP BY player_id, diff
) t2
	USING (player_id)
GROUP BY player_id