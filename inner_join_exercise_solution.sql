-- Inner Join Exercise
-- Use the IQSchool Database
-- 1.	Select student full names and the Course ID's they are registered in.
Select firstname || ' ' || lastname as StudentName, CourseID
from Student
inner join Registration on Student.StudentID = Registration.StudentID;
-- 2.	Select the staff full names and the Course ID’s they teach.
Select distinct firstname || ' ' || lastname as StaffName, courseid
from  Staff
inner join registration on Staff.StaffID = Registration.StaffID

-- 3.	Select the Club ID's and the student full names that are in them.
Select ClubID, firstname || ' ' || lastname as StudentName
from student
inner join activity on Student.StudentID = Activity.StudentID

-- 4.	Select the student full name, Course ID's, and marks for Student ID 199899200.
Select firstname || ' ' || lastname as StudentName , courseid, mark
from  Student
inner join registration on Student.StudentID = Registration.StudentID
where Student.StudentID = 199899200

-- 5.	Select the student full name, course names, and marks for Student ID 199899200.
Select firstname || ' ' || lastname as StudentName, coursename, mark
from Student
inner join registration on Student.StudentID = Registration.StudentID
inner join course on Course.CourseID = Registration.CourseID
where Student.StudentID = 199899200

--Same but do not select the mark
--student --> registration <-- course
Select distinct firstname || ' ' || lastname as StudentName, coursename
from Student
inner join registration on Student.StudentID = Registration.StudentID
inner join course on Course.CourseID = Registration.CourseID
where Student.StudentID = 199899200

-- 6.	Select the Course  IDs, course names, and the semesters they have been taught in.
Select distinct Course.CourseID, CourseName, Semester
from course
inner join Registration on Course.CourseID = Registration.CourseID;
-- 7.	Select the staff full names that have taught Securing MS Active Directory?
Select Distinct firstname || ' ' || lastname as StaffName
from staff 
inner join registration on Staff.StaffID = Registration.StaffID 
inner join Course on Course.CourseID = Registration.CourseID
where CourseName = 'Securing MS Active Directory';

-- 8.	What is the course list for Student ID 199912010 in semester 2001S. Select the students full name and the course names.
Select firstname || ' ' || lastname as StudentName, CourseName
from Student
inner join registration on Student.StudentID = Registration.StudentID
inner join Course on Course.CourseID = Registration.CourseID
where Student.StudentID = 199912010 and Semester = '2001S';
-- 9.	What are the student names, Course ID's that have marks > 80?
Select firstname || ' ' || lastname as StudentName, CourseID
from Student
inner join registration on Student.StudentID = Registration.StudentID
where mark > 80
