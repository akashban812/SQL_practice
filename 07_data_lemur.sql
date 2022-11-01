/*

Assume you are given the table below containing information on user
transactions for particular products. Write a query to obtain the year-on-year growth rate for the total spend of each product for each year.

Output the year (in ascending order) partitioned by 
product id, current year's spend, previous year's spend and year-on-year growth rate (percentage rounded to 2 decimal places).
*/
with cu AS
(
select EXTRACT(year from ut.transaction_date) as year,
ut.product_id,
sum(ut.spend) as curr_year_spend

from user_transactions as ut
group by 1,2
),
pr as (
select cu.year,cu.product_id,cu.curr_year_spend,
c2.curr_year_spend as prev_year_spend

from cu
left join cu as c2
on cu.product_id=c2.product_id AND
cu.year=c2.year + 1

)
SELECT pr.*, ROUND(((pr.curr_year_spend-pr.prev_year_spend)*100/pr.prev_year_spend),2)
from pr
order by 2,1
