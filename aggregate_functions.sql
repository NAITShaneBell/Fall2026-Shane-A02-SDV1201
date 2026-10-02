Select * from course;
--Aggregate functions returns a single value from a range of values
Select min(CourseCost)"Lowest" from Course;
Select max(CourseCost)"Highest" from Course;
Select sum(CourseCost)"Sum" from Course;
Select avg(CourseCost)"Average" from Course;
Select round(avg(CourseCost),2)"Average" from Course;

Select * from staff

--Must name all aggregate columns
Select count(*) "Staff_Count" from Staff; --10 (count all records)
--count(column) does not count nulls
Select count(StaffID) "Staff_Count" from Staff; --10
Select count(FirstName) "Staff_Count" from Staff; --10
Select count(DateHired) "Staff_Count" from Staff; --10
Select count(DateReleased) "Staff_Count_Fired" from Staff; --1

--you cannot mix columns with aggregate columns (without group by)
Select count(StaffID), FirstName, LastName from Staff

