--Table aliases
Select Student.StudentID, FirstName,LastName, Mark, Course.CourseID, CourseName
from Student
Left Outer Join Registration on Student.StudentID = Registration.StudentID
left outer join Course on Course.courseID = Registration.courseID;

--Using table aliases
Select S.StudentID, FirstName,LastName, Mark, C.CourseID, CourseName
from Student S
Left Outer Join Registration R on S.StudentID = R.StudentID
left outer join Course C on C.courseID = R.courseID;





