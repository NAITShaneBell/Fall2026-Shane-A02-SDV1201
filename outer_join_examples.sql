--OUTER JOINS
Select PositionDescription, FirstName, LastName
from Position
inner join Staff on Position.PositionID = Staff.PositionID
--Remember, inner joins only return records where there are related records
--Outer joins will preserve unmatched rows
--Left outer join
Select PositionDescription, FirstName, LastName
from Position
left outer join Staff on Position.PositionID = Staff.PositionID

--right outer join
Select PositionDescription, FirstName, LastName
from Staff
right outer join Position  on Position.PositionID = Staff.PositionID
--Left outer join preserves all the records from the left
--right outer join preserves all the records from the right

--why does this not make sense if the FK is not null
Select PositionDescription, FirstName, LastName
from Staff
left outer join Position on Position.PositionID = Staff.PositionID

--Show all the student names and their payment amounts
Select FirstName, LastName, Amount
from Student
left outer join Payment on Student.StudentID = Payment.StudentID

--How many payments has each student made? Show StudentID, Name and the count.
Select Student.StudentID, FirstName, LastName, count(PaymentID) as PaymentCount
from Student
Left Outer join Payment on Student.StudentID = Payment.StudentID
group by Student.StudentID
--When using count() with outer joins, count the PK of the child table, not *. Count(*) will return a count of 1 when it should be 0

--Select StudentID, firstname, lastname, courseid, coursename and mark for ALL students
Select Student.StudentID, FirstName,LastName, Mark, Course.CourseID, CourseName
from Student
Left Outer Join Registration on Student.StudentID = Registration.StudentID
left outer join Course on Course.courseID = Registration.courseID;

--Choose joins that preserve the rows you want











