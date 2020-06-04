/*
574. Winning Candidate
Table: Candidate
+-----+---------+
| id  | Name    |
+-----+---------+
| 1   | A       |
| 2   | B       |
| 3   | C       |
| 4   | D       |
| 5   | E       |
+-----+---------+  
Table: Vote

+-----+--------------+
| id  | CandidateId  |
+-----+--------------+
| 1   |     2        |
| 2   |     4        |
| 3   |     3        |
| 4   |     2        |
| 5   |     5        |
+-----+--------------+
id is the auto-increment primary key,
CandidateId is the id appeared in Candidate table.
Write a sql to find the name of the winning candidate, the above example will return the winner B.

+------+
| Name |
+------+
| B    |
+------+
Notes:

You may assume there is no tie, in other words there will be at most one winning candidate.

*/

-- Solution 1
SELECT Name
FROM Candidate
WHERE id =
        (SELECT CandidateId
         FROM Vote
         GROUP BY CandidateId
         ORDER BY COUNT(CandidateId) DESC
         Limit 1)

-- Solution 2
select C.Name
from Candidate as C
join
    ( select V.CandidateId,
             count(V.id) as cnt
     from Vote as V
     group by V.CandidateId
     order by cnt desc
     limit 1) as A on (C.id = A.CandidateId)

select A.Name from
    ( select C.Name
     from Vote as V
     left join Candidate as C on(C.id = V.CandidateId)
     group by V.CandidateId,C.Name
     order by count(V.id) desc
     limit 1) as A
where A.Name is not null

SELECT Name
FROM Candidate
WHERE id =
        (SELECT CandidateId
         FROM Vote
         GROUP BY CandidateId
         ORDER BY COUNT(*) DESC
         LIMIT 1);