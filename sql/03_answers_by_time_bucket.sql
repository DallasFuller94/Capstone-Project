-- 03_answers_by_time_bucket.sql
-- Question 1: Which workout time of day is associated with the best mood?
-- Averages each feeling (0-6 scale) per time bucket, with sample sizes.

CREATE OR REPLACE TABLE `Workout.answers_by_time_bucket` AS
SELECT
  time_bucket,
  COUNT(*) AS workouts,
  COUNT(DISTINCT TUCASEID) AS people,
  ROUND(AVG(happy), 2) AS avg_happy,
  ROUND(AVG(stressed), 2) AS avg_stressed,
  ROUND(AVG(tired), 2) AS avg_tired,
  ROUND(AVG(sad), 2) AS avg_sad,
  ROUND(AVG(pain), 2) AS avg_pain,
  ROUND(AVG(meaning), 2) AS avg_meaning
FROM `Workout.exercise_feelings_clean`
WHERE time_bucket IN ('Morning', 'Midday', 'Evening')
GROUP BY time_bucket;
