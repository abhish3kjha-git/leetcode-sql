WITH RECURSIVE SplitWords AS (
    -- Anchor: extract the 1st word
    SELECT 
        content_id,
        content_text,
        1 AS word_order,
        SUBSTRING_INDEX(SUBSTRING_INDEX(content_text, ' ', 1), ' ', -1) AS word,
        1 + LENGTH(content_text) - LENGTH(REPLACE(content_text, ' ', '')) AS total_words
    FROM user_content

    UNION ALL

    -- Recursive step: extract subsequent words
    SELECT 
        content_id,
        content_text,
        word_order + 1,
        SUBSTRING_INDEX(SUBSTRING_INDEX(content_text, ' ', word_order + 1), ' ', -1) AS word,
        total_words
    FROM SplitWords
    WHERE word_order < total_words
),
CapitalizedWords AS (
    -- Convert 1st character to uppercase and the rest to lowercase
    SELECT 
        content_id,
        content_text,
        word_order,
        CONCAT(
            UPPER(LEFT(word, 1)),
            LOWER(SUBSTRING(word, 2))
        ) AS formatted_word
    FROM SplitWords
)
-- Recombine the words in original order
SELECT 
    content_id,
    content_text AS original_text,
    GROUP_CONCAT(formatted_word ORDER BY word_order SEPARATOR ' ') AS converted_text
FROM CapitalizedWords
GROUP BY content_id, content_text;