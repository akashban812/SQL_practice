/*
Assume you are given the below table on transactions from users. Bucketing users based on their latest transaction date, write a query to obtain the number of users who made a purchase and the total number of products bought for each transaction date.

Output the transaction date, number of users and number of products.
*/

select x.transaction_date,
count(DISTINCT(x.u)) as number_of_users,
sum(x.prd) as number_of_products
FROM
(
(select a.user_id as u,max(a.transaction_date) as mx_dt
from user_transactions as a
group by 1) as x1

JOIN

(select a.user_id, count(a.product_id) as prd,a.transaction_date
from user_transactions as a
group by 1,3) as x2

on x1.u=x2.user_id
and x1.mx_dt=x2.transaction_date) as x

group by 1
order by 1

