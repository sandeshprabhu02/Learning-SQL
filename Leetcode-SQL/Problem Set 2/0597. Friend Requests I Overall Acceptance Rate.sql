/*
597. Friend Requests I: Overall Acceptance Rate
In social network like Facebook or Twitter, 
people send friend requests and accept others’ requests as well. 
Now given two tables as below:
Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
Write a query to find the overall acceptance rate of requests 
rounded to 2 decimals, which is the number of acceptance 
divide the number of requests.
For the sample data above, your query should return 
the following result.
|accept_rate|
|-----------|
|       0.80|
*/
-- Q1:  Write a query to find the overall acceptance rate of requests 
-- rounded to 2 decimals, which is the number of acceptance 
-- divide the number of requests.
-- Solution 1
SELECT IFNULL(
    ROUND(
        (COUNT(DISTINCT requester_id, accepter_id))
        /
        (COUNT(DISTINCT sender_id, send_to_id))
    ,2)
,0.00) AS accept_rate
FROM friend_request, request_accepted;

-- Solution 2:
SELECT ROUND(IFNULL(fr.acp/ra.sed, 0), 2) AS accept_rate
FROM
    (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp
     FROM request_accepted) AS fr,

    (SELECT COUNT(DISTINCT sender_id, send_to_id) AS sed
     FROM friend_request) AS ra;

-- Q2: create a subquery which contains count, month, 
-- join each other with month and group by month so we can get the finally result.
SELECT ROUND(IFNULL(fr.acp/ra.sed, 0), 2) AS accept_rate, fr.mon AS month
FROM
    (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp, MONTH(accept_date) AS mon
     FROM request_accepted) AS fr,

    (SELECT COUNT(DISTINCT sender_id, send_to_id) AS sed, MONTH(request_date) AS mon
     FROM friend_request) AS ra
WHERE fr.mon = ra.mon
;

-- Q3: Can you write a query to return the accept rate but for every month?

SELECT s.date,
       IFNULL(round(sum(IF(t.ind = 'a', t.cnt, 0))/sum(IF(t.ind = 'r', t.cnt, 0)),2),0) AS accept_rate
FROM 
    (SELECT distinct x.request_date AS date
     FROM friend_request AS x
     union SELECT distinct y.accept_date AS date
     FROM request_accepted AS y) AS s
LEFT JOIN
    (SELECT v.request_date AS date,
            count(*) AS cnt,
            'r' AS ind
     FROM friend_request AS v
     GROUP BY v.request_date
     union all select w.accept_date AS date,
                      count(*) AS cnt,
                      'a' AS ind
     FROM request_accepted AS w
     GROUP BY w.accept_date) AS t ON s.date >= t.date
GROUP BY s.date