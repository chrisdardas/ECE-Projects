SELECT B.name, COUNT(A.title) AS DLCs
FROM dlc AS A
JOIN developer AS B ON A.developer_id = B.developer_id
GROUP BY B.name;