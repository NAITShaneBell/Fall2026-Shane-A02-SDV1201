-- Aggregate Functions Exercise
-- Use the IQSchool Database
-- 1.	Select the average Mark from all the Marks in the Registration table
Select AVG(mark) "average_mark" from registration;
-- 2.	Select the average Mark of all the students who are taking CPSC1012
Select AVG(mark) "average_mark" from registration
where courseid = 'CPSC1012';
-- 3.	Select how many students there are in the Student Table
Select COUNT(Studentid) "student_count" from student;
-- 4.	Select how many students are taking (i.e. have a mark for) DMIT2015
Select count(mark)"mark_count" from registration
where courseid = 'DMIT2015';

-- 5.	Select the average payment amount for payment type 5
Select AVG(amount)"avg_payment_amount" from payment
where paymenttypeid = 5;
-- 6.	Select the highest payment amount
Select MAX(amount)"highest_payment" from payment;
-- 7.	Select the lowest payment amount
Select Min(amount)"lowest_payment" from payment;
-- 8.	Select the total of all the payments that have been made
Select sum(amount)"total_payments" from payment;
-- 9.	How many different payment types does the school accept?
Select count(*) "PaymentTypeCount" from PaymentType;

-- 10.	How many students are in club 'CSS'?
Select count(*) from activity
where ClubID ='CSS';

select * from activity;

