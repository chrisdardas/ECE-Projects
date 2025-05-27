 SELECT A.player_id, A.username, C.achievement_id, C.title, C.date_of_completion
 FROM player AS A
 JOIN player_unlocks_achievement AS B ON A.player_id = B.player_id
 JOIN achievement AS C ON B.achievement_id = C.achievement_id
 WHERE C.achievement_id = 5;