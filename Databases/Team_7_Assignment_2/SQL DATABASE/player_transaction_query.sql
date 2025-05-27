SELECT A.username, B.*
FROM player AS A
JOIN transaction AS B ON A.player_id = B.player_id
WHERE B.player_id = 56
      AND B.payment_method = 'PayPal'
      AND B.date > '2023-04-23';