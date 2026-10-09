--Inner joins
--Allows us to work with related data  in nmore than one tabl

Select positionID, FirstName, LastName from Staff;
--Syntax
--Select columns
--from tablename1
--inner join table2name on tablename1.joinfield = tablename2.joinfield
--Join field is the column(s) that relate th tables together

--names of all the staff and the position descriptions they are in
Select FirstName, LastName, PositionDescription
from Position 
inner join Staff on Position.PositionID = Staff.PositionID
--List all the position descriptions ad the names of staff in them
Select PositionDescription, FirstName, LastName
from Position 
inner join Staff on Position.PositionID = Staff.PositionID

--OH NO :( :(. WE are miissing a position description
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



