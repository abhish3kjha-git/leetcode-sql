# Write your MySQL query statement below
WITH ranked AS (
    SELECT
        policy_id,
        state,
        fraud_score,
        RANK() OVER (
            PARTITION BY state
            ORDER BY fraud_score DESC
        ) AS rnk
    FROM Fraud
)

SELECT
    policy_id,
    state,
    fraud_score
FROM ranked
WHERE rnk = 1
ORDER BY state, fraud_score DESC, policy_id
