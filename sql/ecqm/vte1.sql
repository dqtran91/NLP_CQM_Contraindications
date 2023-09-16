-- Calculate measures using the materialized views
SELECT *,
         ROUND(100.0 * numerator_count / denominator_count, 2) AS vte_1_percentage
FROM (SELECT COUNT(DISTINCT d.hadm_id)                                          AS denominator_count,
             COUNT(DISTINCT CASE WHEN n.hadm_id IS NOT NULL THEN d.hadm_id END) AS numerator_count
      FROM vte1_denominator_mv    d
      LEFT JOIN vte1_numerator_mv n
                ON d.subject_id = n.subject_id AND d.hadm_id = n.hadm_id) as dcnc;

-- Search for encounters that are in the denominator, but not in the numerator
SELECT distinct d.hadm_id
FROM vte1_denominator_mv d
LEFT JOIN vte1_numerator_mv n
    ON d.subject_id = n.subject_id AND d.hadm_id = n.hadm_id
WHERE n.hadm_id IS NULL;
