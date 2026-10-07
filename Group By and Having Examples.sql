--GROUP BY
Select * from Staff;
Select * from Position;

--How many staff are there in the staff table?
Select count(*) as StaffCount from Staff;
Select count(StaffID) as StaffCount from Staff;

--How many staff are there in each position? Show the PositionID and the count.
Select PositionID, count(*) as StaffCount from staff
group by PositionID
order by PositionID asc;

--PositionID	--CountOfStaff
--1					1
--2					1
--3					2		
--4					4
--5					1
--6					1
--Group by performs subtotals for each different value you are grouping on
-- The words for each, in each, each often mean you should be using group by.
Select * from payment;

--How much money has been paid to the school for each student(that has made payments). Show the StudentID and the amount.36225.00
Select StudentID, sum(amount) as TotalPayments from payment
group by StudentID;
--Multiple aggregates
Select StudentID, sum(amount) as TotalPayments, count(*) as PaymentCount, Avg(amount) as AveragePayment, max(amount) as HightestPayment, min(amount) as LowestPayment from payment
group by StudentID;

--Select the avg(mark) for each course. Show the courseid and the average.16 records
Select courseid, avg(mark) as AverageMark from registration
group by courseid;

--How many students names start with each letter? Show the letter and the count. Order the results alphabetically by letter.

--Bob
--Billy
--Sue
--Dave
--Sally

--Letter	--Count
--B				2
--S				2
--D				1

Select left(firstname,1) as Letter, count(*) as Count
from student
Group by Letter-- OR left(firstname,1)
order by Letter asc;

--Having
--WHERE filters individual rows before grouping.
--GROUP BY forms groups; aggregates summarize each group.
--HAVING filters groups, usually using an aggregate condition.

--Select the StudentID and the count of payment for each student. But only show the records that have a count > 4
Select StudentID, count(*) as PaymentCount  from payment
group by StudentID
Having count(*) > 4;

--Which students have made more than 4 payments
Select StudentID from payment
group by StudentID
Having count(*) > 4;

--You can have where AND having in the same query

Select sum(coursecost) as SumProgramming from course
where coursename like '%Programming%';

--Select the sum of payments for each student, but only include payments that were paymenttypeID 1. How much has each student paid in cash (paymenttypeid 1). Only include the ones that have paid over 1600 in cash payments
select * from payment;


--an example of having without a group by, but his is not as common 
SELECT SUM(amount) AS "TotalPayments"
FROM payment
HAVING SUM(amount) > 30000;

-- Build it in three runs: show the cash rows, show all student cash totals, then add HAVING. Students can watch exactly which stage removes what.

--for me only
EXPLAIN (ANALYZE, BUFFERS)
Select StudentID, sum(amount) as PaymentAmount from payment
where paymenttypeid = 1--Where picks the records that are used in the aggregate calculation
group by studentid
having sum(amount) > 1600 ;

EXPLAIN (ANALYZE, BUFFERS)
Select StudentID, sum(amount) as PaymentAmount from payment
group by studentid, paymenttypeid
having sum(amount) > 1600  and paymenttypeid = 1--Where picks the records that are used in the aggregate calculation

--for me
select studentid,sum(amount) from payment
where paymenttypeid = 1
group by payment.studentid
having  sum(amount) > 1600


