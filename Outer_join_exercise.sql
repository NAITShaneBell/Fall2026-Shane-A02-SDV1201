/*
Question 1 - Courses and registrations
Show all courses, including courses with no registrations.
Display CourseID, CourseName, and any matching registration's
StudentID, Semester, and Mark.
Sort by course ID, semester, and student ID.
*/
SELECT Course.CourseID, CourseName, StudentID, Semester, Mark
FROM Course 
LEFT OUTER JOIN Registration ON Course.CourseID = Registration.CourseID
ORDER BY Course.CourseID, Semester, StudentID;

/*
Question 2 - Staff and assigned registrations
Show all staff members, including staff who have never been assigned
 to a registration. Display staff ID, first name, last name, and any
matching registration's course ID and semester.
Sort by staff ID, course ID, and semester.
*/
SELECT Staff.StaffID, FirstName, LastName, CourseID, Semester
FROM Staff
LEFT OUTER JOIN Registration ON Staff.StaffID = Registration.StaffID
ORDER BY Staff.StaffID, CourseID, Semester;

/*
Question 3 - Positions without staff
Find positions that have no staff assigned.
Display PositionID and PositionDescription.
*/
SELECT Position.PositionID, PositionDescription
FROM Position
LEFT OUTER JOIN Staff ON Position.PositionID = Staff.PositionID
WHERE StaffID is NULL;

/*
Question 4 - Students and club memberships
Show all students, along with the names of any clubs they belong to.
Include students who do not belong to a club.
Display student ID, first name, last name, and club name.
Join Student, Activity, and Club.
*/
SELECT
    Student.StudentID, FirstName, LastName, ClubName
FROM Student
LEFT OUTER JOIN Activity ON Student.StudentID = Activity.StudentID
LEFT OUTER JOIN Club ON Activity.ClubID = Club.ClubID;

/*
Question 5 - Payment count per student
Show how many payments each student has made.
Display student ID, first name, last name, and PaymentCount.
Students with no payments must show 0.
Sort by payment count descending, then student ID.
*/
SELECT Student.StudentID, FirstName, LastName, COUNT(PaymentID) AS PaymentCount
FROM Student
LEFT OUTER JOIN Payment ON Student.StudentID = Payment.StudentID
GROUP BY Student.StudentID, FirstName, LastName
ORDER BY COUNT(PaymentID) DESC, Student.StudentID;


/*
Question 6 - Membership count per club
Show every club and its number of members.
Display ClubID, ClubName, and MemberCount.
Include clubs with no members and show their count as 0.
Write this query using a RIGHT OUTER JOIN.
*/
SELECT Club.ClubID, ClubName, COUNT(StudentID) AS MemberCount
FROM Activity
RIGHT OUTER JOIN Club ON Activity.ClubID = Club.ClubID
GROUP BY Club.ClubID, ClubName;

-- Activity has a composite primary key. StudentID is NOT NULL in each
-- actual membership row, so it safely counts matching memberships.


/*
Question 7 - Total payments per student
Show the total amount paid by each student.
Display student ID, first name, last name, and TotalPaid.
Include students with no payments and display 0 instead of NULL for
 their total. Use COALESCE.
Sort by total paid descending, then student ID.
*/
--COALESCE will replace sum(amount) with 0 if there is no amount
SELECT Student.StudentID, FirstName, LastName, COALESCE(SUM(Amount), 0) AS TotalPaid --teach coalesce when we take this up
FROM Student
LEFT OUTER JOIN Payment ON Student.StudentID = Payment.StudentID
GROUP BY Student.StudentID, FirstName, LastName
--ORDER BY "TotalPaid" DESC, Student.StudentID; - can order by column alias if use quotes because of the mixed name quotes. do not show unless need to
ORDER BY TotalPaid DESC, Student.StudentID;--order by puts nulls first in sorting desc.... so need COALESCE, not just sum()


/*
Question 8 - Registration count and average mark per course
Show every course, its number of registrations, and its average mark.
Display CourseID, CourseName, RegistrationCount, and AverageMark.
Include all semesters. 
Count registration records, including separate registrations by the
same student in different semesters.
Show 0 for courses with no qualifying registrations.
Leave their average as NULL.
*/
SELECT Course.CourseID, CourseName, COUNT(StudentID) AS RegistrationCount,
    AVG(Mark) AS "AverageMark"
FROM Course
LEFT OUTER JOIN Registration ON Course.CourseID = Registration.CourseID
GROUP BY Course.CourseID, CourseName;

/*
Question 9 - Students and their largest payment
Show every student and the largest payment amount they have made.
Display student ID, first name, last name, and LargestPayment.
Include students who have never made a payment.
Leave their largest payment as NULL.
*/
SELECT
    Student.StudentID, FirstName, LastName, MAX(Amount) AS "LargestPayment"
FROM Student
LEFT OUTER JOIN Payment ON Student.StudentID = Payment.StudentID
GROUP BY Student.StudentID, FirstName, LastName;
/*
Question 10 - Students with few registrations
Show students who have fewer than nine registrations across all
semesters, including students with none.
Display student ID, first name, last name, and RegistrationCount.
Use an outer join and HAVING to keep only counts below two.
Sort by registration count, then student ID.
*/
SELECT
    Student.StudentID,
    FirstName,
    LastName,
    COUNT(CourseID) AS RegistrationCount
FROM Student
LEFT OUTER JOIN Registration ON Student.StudentID = Registration.StudentID
GROUP BY Student.StudentID, FirstName, LastName
HAVING COUNT(CourseID) < 9
ORDER BY RegistrationCount, Student.StudentID;

