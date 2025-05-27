SELECT A.player_id, A.TotalGames, B.TotalDLCs
FROM TotalGamesPerPlayer AS A
JOIN TotalDLCsPerPlayer AS B ON A.game_id = B.game_id
WHERE A.player_id = 555;