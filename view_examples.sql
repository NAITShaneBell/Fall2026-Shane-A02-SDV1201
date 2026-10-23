--View - A query that is given a name. The results of the view can be queried like a table
--Can control access to data
--Simply complex queries

--Create a view
--Syntax
-- create view NAME AS
-- query

Create View studentInfo
AS
Select StudentID, Firstname,  LastName  
from student

--test it
Select * from studentInfo

Select firstname, lastname FROM
studentInfo
where  lastname like 'B%'

--A view does not store a copy of the data, just the query def

Select * from staff

--A view of staffnames and their descriptions
Create VIEW StaffInfo 
as 
Select FirstName,LastName,PositionDescription
from Position
inner join staff on Position.PositionID = Staff. PositionID

--Hide/simplify complex queries
--Selects ALL studentId, names(one column),
-- courseid, couresname, stafffullname, mark
--for students without marks make the mark 0
-- COALESCE
SELECT Student.StudentID, Student.FirstName || ' ' || Student.LastName AS StudentName, Course.CourseID,
    Course.CourseName, Staff.FirstName || ' ' || Staff.LastName AS InstructorName, COALESCE(Mark, 0) as "Mark"
FROM Student 
LEFT OUTER JOIN Registration ON Student.StudentID = Registration.StudentID
LEFT OUTER JOIN Course ON Registration.CourseID = Course.CourseID
LEFT OUTER JOIN Staff ON Registration.StaffID = Staff.StaffID; 

--Create a view of this query
Create View StudentTranscript
AS
SELECT Student.StudentID, Student.FirstName || ' ' || Student.LastName AS StudentName, Course.CourseID,
    Course.CourseName, Staff.FirstName || ' ' || Staff.LastName AS InstructorName, COALESCE(Mark, 0) as "Mark"
FROM Student 
LEFT OUTER JOIN Registration ON Student.StudentID = Registration.StudentID
LEFT OUTER JOIN Course ON Registration.CourseID = Course.CourseID
LEFT OUTER JOIN Staff ON Registration.StaffID = Staff.StaffID;

Select * from StudentTranscript
where StudentID = 199899200
--I want to use the view and order results by student lastname in asc
--THis will not work since there is no last name column in the view
Select * from StudentTranscript
order by LastName asc

--We need to change the view to add lastname column
--We can drop the view and recreate it with lastname
drop view StudentTranscript

Create View StudentTranscript
AS
SELECT Student.StudentID, Student.FirstName || ' ' || Student.LastName AS StudentName, Course.CourseID,
    Course.CourseName, Staff.FirstName || ' ' || Staff.LastName AS InstructorName, COALESCE(Mark, 0) as "Mark", Student.LastName
FROM Student 
LEFT OUTER JOIN Registration ON Student.StudentID = Registration.StudentID
LEFT OUTER JOIN Course ON Registration.CourseID = Course.CourseID
LEFT OUTER JOIN Staff ON Registration.StaffID = Staff.StaffID;

Select StudentID, StudentName, Courseid, CourseName, InstructorName, "Mark" from StudentTranscript
order by LastName asc

--change the view
--The existing columns must retain their names and order. if you add new columns, you must do so at the end

Create or Replace View StudentTranscript
AS
SELECT Student.StudentID, Student.FirstName || ' ' || Student.LastName AS StudentName, Course.CourseID,
    Course.CourseName, Staff.FirstName || ' ' || Staff.LastName AS InstructorName, COALESCE(Mark, 0) as "Mark", Student.LastName, city
FROM Student 
LEFT OUTER JOIN Registration ON Student.StudentID = Registration.StudentID
LEFT OUTER JOIN Course ON Registration.CourseID = Course.CourseID
LEFT OUTER JOIN Staff ON Registration.StaffID = Staff.StaffID;





