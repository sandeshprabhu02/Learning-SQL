SELECT Score, RANK() OVER 
(SELECT Score FROM Scores 
ORDER BY Score DESC)
FROM Scores;
