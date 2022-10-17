/*Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a SQL query to list the candidates who possess all of the required skills for the job. Sort the the output by candidate ID in ascending order.

Assumption:

There are no duplicates in the candidates table*/

##My solution

SELECT c.candidate_id

from candidates as c

where c.skill in ('Python','Tableau','PostgreSQL')

group by c.candidate_id

having count(c.skill) = 3
