/*
Assume you are given the following tables on Walmart transactions and products. Find the number of unique product combinations that are bought together (purchased in the same transaction).

For example, if I find two transactions where apples and bananas are bought, and another transaction where bananas and soy milk are bought, my output would be 2 to represent the 2 unique combinations. Your output should be a single number.

Assumption:

For each transaction, a maximum of 2 products are purchased
*/

with tbl as
(
select t1.transaction_id,t1.product_id,p1.product_name,
RANK() OVER(PARTITION BY t1.transaction_id 
ORDER BY t1.product_id DESC) as prod_rnk
from transactions as t1
join products as p1
on p1.product_id=t1.product_id

),
tbl2 AS
(
select t1.transaction_id,
t1.product_id,t2.product_id

from tbl as t1
JOIN
tbl as t2
on t1.product_id>t2.product_id
and t1.transaction_id=t2.transaction_id)

select count(1) as combo_num
from tbl2
