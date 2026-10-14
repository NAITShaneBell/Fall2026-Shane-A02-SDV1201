--Inner joins
--Allows us to work with related data  in more than one table

Select positionID, FirstName, LastName from Staff;
--Syntax
--Select columns
--from tablename1
--inner join table2name on tablename1.joinfield = tablename2.joinfield
--Join field is the column(s) that relate the tables together

--ANSI join - older style - Do not use
Select FirstName, LastName, PositionDescription
from position,staff
where position.PositionID = Staff.PositionID

--names of all the staff and the position descriptions they are in
Select FirstName, LastName, PositionDescription
from Position 
inner join Staff on Position.PositionID = Staff.PositionID

--List all the position descriptions and the names of staff in them
Select PositionDescription, FirstName, LastName
from Position 
inner join Staff on Position.PositionID = Staff.PositionID

--OH NO :( :(. We are missing a position description
--An inner join only returns records where there are related records in the other tables in the join
--Select  paymentid, amount, paymentdate, and the payment type description for each payment
Select paymentID, amount, PaymentDate, PaymentTypeDescription
from PaymentType 
inner join Payment on PaymentType.PaymentTypeID = Payment.PaymentTypeID;
--More Than 2 table join
--Show the full studentnames, marks, and coursenames for each student that has taken courses
Select FirstName || ' ' || LastName as StudentName, mark, coursename
from Student
inner join Registration on Student.StudentID = Registration.StudentID
inner join Course on Course.CourseID = Registration.CourseID;

--Select only the students names that have made payments
Select Distinct FirstName, LastName from Student
inner join Payment on Student.StudentID = Payment.StudentID

--Do not join tables you do not need
Select FirstName, LastName, PositionDescription
from Position 
inner join Staff on Position.PositionID = Staff.PositionID
inner join registration on Registration.StaffId = Staff.StaffID

--Select the student name and their avg(mark) 
Select FirstName, LastName, avg(Mark)
from Student
inner join Registration on Student.StudentID = Registration.StudentID
group by FirstName, LastName
--how many students are in courses
select count(distinct StudentID) from Registration

--We should have 8 student names and averages. We only have 7
select * from student order by firstname,lastname
--We were grouping on each student NAME, not student
--Group by what uniquely identifies what you are grouping on
Select FirstName, LastName, avg(Mark)
from Student
inner join Registration on Student.StudentID = Registration.StudentID
group by Student.StudentID, FirstName, LastName
--Always group by the unique identifier
--How many payments for each paymenttype. Show the desc and the count
Select paymentTypeDescription, count(*) as Count
from PaymentType
inner join Payment on PaymentType.PaymentTypeID = Payment.PaymentTypeID
group by PaymentType.PaymentTypeID, PaymentTypeDescription

--short cut for PostgreSQL
--If grouping on the pk you can omit the other columns
Select FirstName, LastName, avg(Mark)
from Student
inner join Registration on Student.StudentID = Registration.StudentID
group by Student.StudentID













