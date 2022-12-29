/*

The table below contains information about tweets over a given period of time. Calculate the 3-day rolling average of tweets published by each user for each date that a tweet was posted. Output the user id, tweet date, and rolling averages rounded to 2 decimal places.

Important Assumptions:

Rows in this table are consecutive and ordered by date.
Each row represents a different day
A day that does not correspond to a row in this table is not counted. The most recent day is the next row above the current row.
Note: Rolling average is a metric that helps us analyze data points by creating a series of averages based on different subsets of a dataset. It is also known as a moving average, running average, moving mean, or rolling mean.
*/


with t1 as(
SELECT 
user_id,
tweet_date,
count(distinct(tweet_id)) as cnt_twt

FROM tweets
group by 1,2)

select user_id,tweet_date,

round(AVG(cnt_twt) over(partition by user_id
order by user_id,tweet_date rows BETWEEN 2 preceding and current row),2) as rolling_avg_3d

from t1
order by 1,2
