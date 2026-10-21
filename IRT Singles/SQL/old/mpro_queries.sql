
-- Finals

SELECT [WINNER], [LOSER], [SCORE], [City], [EVENT], [DATE], [season], [notes]
FROM [Mens Pro Results]
WHERE round='F'
ORDER BY [season], [date];

-- Finals by season

SELECT [WINNER], [LOSER], [SCORE], [City], [EVENT], [DATE], [season], [notes]
FROM [Mens Pro Results]
WHERE round='F' And Season='2002-3'
ORDER BY [season], [date];


--- Head to Head
SELECT [WINNER], [LOSER], [ROUND], [SCORE], [Tour], [City], [EVENT], [DATE]
FROM [Mens Pro Results]
WHERE (winner='Monchik, S' And loser='Mannino, J') Or (winner='Mannino, J' And loser='Monchik, S');