-- 02_validation_counts.sql
-- Validation: row counts per time bucket in the cleaned table.
-- Expected result: Morning 195, Midday 142, Evening 89, Other 14 (440 total).

SELECT time_bucket, COUNT(*) AS workouts
FROM `Workout.exercise_feelings_clean`
GROUP BY time_bucket
ORDER BY workouts DESC;
