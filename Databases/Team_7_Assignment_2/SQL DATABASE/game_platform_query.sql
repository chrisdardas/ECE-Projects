SELECT A.game_id, A.title 
FROM game AS A
JOIN platform AS B ON A.platform_id=B.platform_id 
JOIN platform_name AS C ON B.platform_name = C.name
WHERE C.type = "PC";
