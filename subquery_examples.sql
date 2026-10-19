--subquery - a query inside another statement(query, insert, update, delete)
-- Can usually be used anywhere you a value(s) are used

--subquery executes first, and the results are used by the outer query

-- some problems can be answered with joins or subqueries
--syntax

-- Select columns from tablenames......
-- where columnname operator (subquery)

--join -Select all the staff names that are in the Dean position
Select FirstName, LastName 
from Position
Inner Join Staff on Position.PositionID = Staff.PositionID
where PositionDescription = 'Dean'

--subquery
Select FirstName, LastName
from staff
Where PositionID = (Select PositionID from position where PositionDescription = 'Dean') 

--join - Select the studentid and names of students that have made payments

Select distinct Student.studentID, firstname, lastname
from student
inner join payment on student.StudentID = payment.StudentID

--subquery
Select studentID, firstname, lastname
from student
where StudentID in (Select StudentID from Payment)

--Without subquery
-- Select the studentid, name of students that have made 0 payments

Select student.studentid,firstname, lastname,paymentid
from student
left outer join payment on student.StudentID=payment.StudentID
where paymentid is null 
--OR
Select student.studentid,firstname, lastname
from student
left outer join payment on student.StudentID=payment.StudentID
group by student.studentid,firstname, lastname
having count(paymentid) = 0

--subquery
Select studentID, firstname, lastname
from student
where StudentID not in (Select StudentID from Payment)

--Show the paymentID and amount for payments that are greater than the avg payment amount
Select PaymentID, Amount from payment
where Amount > (Select avg(AMount) from Payment)

--Show the paymentID and amount for payments that are tied for the largest amount
Select PaymentID, Amount from payment
where Amount = (Select max(AMount) from Payment)

