SELECT DISTINCT a.user_id
FROM Sessions a
JOIN Sessions b
  ON a.user_id = b.user_id
 AND a.session_type = b.session_type
 AND a.session_id <> b.session_id
 AND b.session_start >= a.session_start
 AND b.session_start <= DATE_ADD(a.session_end, INTERVAL 12 HOUR)
ORDER BY a.user_id ASC;