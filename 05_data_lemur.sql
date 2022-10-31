/*
Assume you have the table below containing information on Facebook user actions. Write a query to obtain the active user retention in July 2022. Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).

Hint: An active user is a user who has user action ("sign-in", "like", or "comment") in the current month and last month.

Note: We are showing you output for June 2022 as the user_actions table only have event_dates in June 2022. You should work out the solution for July 2022.

*/

select x.month,count(distinct(x.u1)) as monthly_active_users
from
(select 
EXTRACT(month from a.event_date) as month,
EXTRACT(month from b.event_date) as month2,
a.user_id as u1,
b.user_id as u2,
count(a.event_type)
FROM
user_actions as a

LEFT JOIN user_actions as b

on b.user_id=a.user_id
and EXTRACT(month from a.event_date)=EXTRACT(month from b.event_date) + 1

GROUP BY
1,2,3,4) as x
where x.month2 is not null
and x.month=7
group by 1
