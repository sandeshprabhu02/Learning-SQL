/*
182. Duplicate Emails

*/
SELECT Email
FROM Person
GROUP BY Email
Having COUNT(Email)>1

