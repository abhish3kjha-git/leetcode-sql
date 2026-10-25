# Write your MySQL query statement below
WITH RECURSIVE chains AS (

    SELECT
        giver_id AS start_id,
        giver_id,
        receiver_id,
        gift_value,
        1 AS chain_length,
        gift_value AS total_gift_value
    FROM SecretSanta

        UNION ALL

    SELECT
        c.start_id,
        s.giver_id,
        s.receiver_id,
        s.gift_value,
        c.chain_length + 1,
        c.total_gift_value + s.gift_value
    FROM chains c
    JOIN SecretSanta s
        ON c.receiver_id = s.giver_id
    WHERE s.giver_id != c.start_id
),

completed AS (
    SELECT
        start_id,
        chain_length,
        total_gift_value
    FROM chains
    WHERE receiver_id = start_id
),

unique_chains AS (
    SELECT DISTINCT
        chain_length,
        total_gift_value
    FROM completed
)

SELECT
    ROW_NUMBER() OVER (ORDER BY chain_length DESC, total_gift_value DESC) AS chain_id,
    chain_length,
    total_gift_value
FROM unique_chains
ORDER BY 2 DESC, 3 DESC
