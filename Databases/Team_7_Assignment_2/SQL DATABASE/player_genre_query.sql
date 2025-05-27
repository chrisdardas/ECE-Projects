SELECT C.player_id
FROM game AS A 
JOIN genre AS B ON A.genre_name = B.name
JOIN player_owns_game AS C ON A.game_id = C.game_id
WHERE B.name = "RPG";