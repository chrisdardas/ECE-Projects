SELECT A.game_id, A.title, A.price, C.date_of_addition
FROM game AS A
JOIN game_belongsto_wishlist AS B ON A.game_id = B.game_id
JOIN wishlist AS C ON B.wishlist_id = C.wishlist_id
WHERE C.wishlist_id = 23500;