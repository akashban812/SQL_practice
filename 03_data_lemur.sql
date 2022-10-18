/*
Given the reviews table, write a query to get the average stars for each product every month.

The output should include the month in 
numerical value, product id, and average star rating rounded to two decimal places. Sort the output based on month followed by the product id.

*/

SELECT EXTRACT(month from r.submit_date) as mth,
r.product_id, ROUND(avg(r.stars),2) as avg_stars
FROM reviews as r
group by 1,2
order by 1,2;
