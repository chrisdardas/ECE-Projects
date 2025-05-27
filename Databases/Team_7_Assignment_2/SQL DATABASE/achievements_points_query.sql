SELECT A.username, SUM(achievement_points) AS total_achievement_points
FROM UnlockedAchievements AS A 
JOIN AchievementsByGames AS B ON A.title = B.title
GROUP BY A.username;