SELECT COUNT(DISTINCT game_id) AS TotalReviewedGames
FROM ReviewsForDeveloperGames
GROUP BY player_id;