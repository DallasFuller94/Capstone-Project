-- 04_top_exercises.sql
-- Question 2: Which exercise types appear most among rated workouts?
-- Labels (ATUS Activity Coding Lexicon): 130131 Walking,
-- 130134 Working out unspecified, 130133 Weightlifting/strength training,
-- 130104 Biking, 130132 Water sports, 130124 Running, 130199 Other sports,
-- 130128 Cardiovascular equipment, 130116 Hiking, 130136 Yoga.

SELECT TRCODE, COUNT(*) AS workouts
FROM `Workout.exercise_feelings_clean`
GROUP BY TRCODE
ORDER BY workouts DESC
LIMIT 10;
