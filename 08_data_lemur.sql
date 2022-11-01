/*
Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage.

Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

Assumptions:

Each server might start and stop several times.
The total time in which the server fleet is running can be calculated as the sum of each server's uptime.

*/

with strt_tbl AS
(
select s.*, rank() over(PARTITION BY s.server_id order by status_time) as rnk
from server_utilization as s
where s.session_status='start'
),
stp_tbl AS
(
select s.*, rank() over(PARTITION BY s.server_id order by status_time) as rnk
from server_utilization as s
where s.session_status='stop'
)
, difftbl as (
select x.server_id,x.status_time as strt_time,y.status_time as stp_time,
EXTRACT(epoch from (y.status_time-x.status_time))/(60*60*24) as dy
from strt_tbl as x
JOIN
stp_tbl as y
on x.server_id=y.server_id and x.rnk=y.rnk)
select round(sum(a.dy)) as total_uptime_days from difftbl as a
