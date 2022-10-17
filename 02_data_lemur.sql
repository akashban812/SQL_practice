--Assume you are given the tables below about Facebook pages and page likes.
--Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

--My solution
select x.page_id
from

(select p.page_id,pl.p2

from pages as p

left join
(select distinct(page_id) as p2 from page_likes) as pl
on pl.p2=p.page_id) as x

where x.p2 is null

order by 1



;
