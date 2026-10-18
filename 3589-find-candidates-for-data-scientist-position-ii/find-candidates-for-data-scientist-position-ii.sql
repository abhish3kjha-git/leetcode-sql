WITH ProjectRequirements AS (
    SELECT 
        project_id, 
        COUNT(skill) AS required_skills_count
    FROM Projects
    GROUP BY project_id
),
CandidateProjectScores AS (
    SELECT 
        p.project_id,
        c.candidate_id,
        100 + SUM(
            CASE 
                WHEN c.proficiency > p.importance THEN 10
                WHEN c.proficiency < p.importance THEN -5
                ELSE 0 
            END
        ) AS score,
        RANK() OVER (
            PARTITION BY p.project_id 
            ORDER BY 100 + SUM(
                CASE 
                    WHEN c.proficiency > p.importance THEN 10
                    WHEN c.proficiency < p.importance THEN -5
                    ELSE 0 
                END
            ) DESC, c.candidate_id ASC
        ) AS rnk
    FROM Projects p
    JOIN Candidates c ON p.skill = c.skill
    JOIN ProjectRequirements pr ON p.project_id = pr.project_id
    GROUP BY p.project_id, c.candidate_id, pr.required_skills_count
    HAVING COUNT(c.skill) = pr.required_skills_count
)
SELECT 
    project_id, 
    candidate_id, 
    score
FROM CandidateProjectScores
WHERE rnk = 1
ORDER BY project_id ASC;