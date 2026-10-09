-- 1.	Select the average mark for each course. Display the CourseID and the average mark.
Select courseid, avg(mark)"Average" from registration 
group by courseid
-- 2.	How many payments were made for each payment type. Display the PaymentTypeID and the count.
Select PaymentTypeID, count(*)"PaymentCount" from payment
group by PaymentTypeID
-- 3.	Select the average mark for each student. Display the StudentID and their average mark.
Select StudentID, avg(mark)"AverageMark" from registration
group by StudentID
-- 4.	Select the same data as question 3 but only show the students with averages that are > 80.
Select StudentID, avg(mark)"AverageMark" from registration
group by StudentID 
having  avg(mark) > 80
-- 5.	How many students are from each city? Display the City and the count.
Select City, count(*)"Count" from Student
group by City

-- 6.	Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having clauses do not need to be selected)
Select City from Student
group by City
having count(*) >= 2
-- 7.	What is the highest, lowest, and average payment amount for each payment type? 
Select PaymentTypeID,  MAX(amount)"Highest", MIN(amount)"Lowest", AVG(amount)"Average" from payment
group by PaymentTypeID 
-- 8.	How many students are there in each club? Show the ClubID and the count.
Select ClubID, count(*)"Count" from activity
group by clubID

-- 9.	Which clubs have 3 or more students in them?
Select ClubID from activity
group by clubID
having count(*) >= 3

--10. For each student, calculate the total amount paid using payment type 1. Display the StudentID and total, including only students whose total for that payment type exceeds $1,600.
SELECT StudentID, SUM(Amount) AS TotalPaid
FROM Payment
WHERE PaymentTypeID = 1
GROUP BY StudentID
HAVING SUM(Amount) > 1600 --use having to evaluate aggregate columns, not non aggregate columns
