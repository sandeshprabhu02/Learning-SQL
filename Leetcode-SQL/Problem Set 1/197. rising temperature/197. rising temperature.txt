SELECT Today.Id FROM Weather AS Today
INNER 
JOIN Weather AS Yesterday

ON TO_DAYS(Today.Date) - TO_DAYS(Yesterday.Date) = 1  

AND Yesterday.Temperature < Today.Temperature;



SELECT wt1.Id 
FROM Weather wt1, Weather wt2
WHERE wt1.Temperature > wt2.Temperature AND 
      TO_DAYS(wt1.DATE)-TO_DAYS(wt2.DATE)=1;

