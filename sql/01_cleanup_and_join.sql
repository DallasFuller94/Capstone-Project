-- 01_cleanup_and_join.sql
-- Capstone: Does workout time of day relate to how people feel during exercise?
-- Builds the analysis table by joining the ATUS 2021 Activity file
-- (activity codes + start times) to the Well-Being Module Activity file
-- (feelings ratings 0-6), keeping only exercise activities with a valid
-- happiness rating, and bucketing start time into Morning/Midday/Evening.
-- Note: TUSTARTTIM loads into BigQuery as TIME, so EXTRACT(HOUR ...) is used.

CREATE OR REPLACE TABLE `Workout.exercise_feelings_clean` AS
SELECT
  a.TUCASEID,
  a.TUACTIVITY_N,
  a.TRCODE,
  a.TUSTARTTIM,
  EXTRACT(HOUR FROM a.TUSTARTTIM) AS start_hour,
  CASE
    WHEN EXTRACT(HOUR FROM a.TUSTARTTIM) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM a.TUSTARTTIM) BETWEEN 12 AND 16 THEN 'Midday'
    WHEN EXTRACT(HOUR FROM a.TUSTARTTIM) BETWEEN 17 AND 21 THEN 'Evening'
    ELSE 'Other'
  END AS time_bucket,
  wb.WUHAPPY   AS happy,
  wb.WUSTRESS  AS stressed,
  wb.WUTIRED   AS tired,
  wb.WUSAD     AS sad,
  wb.WUPAIN    AS pain,
  wb.WUMEANING AS meaning
FROM `Workout.Activity` a
JOIN `Workout.wbact` wb
  ON a.TUCASEID = wb.TUCASEID
 AND a.TUACTIVITY_N = wb.TUACTIVITY_N
WHERE a.TRCODE BETWEEN 130100 AND 130299  -- Sports, Exercise & Recreation codes
  AND wb.WUHAPPY BETWEEN 0 AND 6;          -- valid feelings ratings only
