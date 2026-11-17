
USE student_org_management;

-- ==========================================
-- MEMBER DATA (10 records)
-- ==========================================

INSERT INTO Member
(member_id, first_name, last_name, email, phone,
 join_date, membership_status)
VALUES
(1, 'Maria', 'Singleton', 'maria.singleton@example.com',
 '3185550101', '2026-08-20', 'Active'),
(2, 'James', 'Carter', 'james.carter@example.com',
 '3185550102', '2026-08-21', 'Active'),
(3, 'Olivia', 'Brown', 'olivia.brown@example.com',
 '3185550103', '2026-08-22', 'Active'),
(4, 'Emma', 'Wilson', 'emma.wilson@example.com',
 '3185550104', '2026-08-23', 'Active'),
(5, 'Noah', 'Davis', 'noah.davis@example.com',
 '3185550105', '2026-08-24', 'Active'),
(6, 'Sophia', 'Miller', 'sophia.miller@example.com',
 '3185550106', '2026-08-25', 'Active'),
(7, 'Liam', 'Taylor', 'liam.taylor@example.com',
 '3185550107', '2026-08-26', 'Pending'),
(8, 'Ava', 'Anderson', 'ava.anderson@example.com',
 '3185550108', '2026-08-27', 'Active'),
(9, 'Ethan', 'Thomas', 'ethan.thomas@example.com',
 '3185550109', '2026-08-28', 'Inactive'),
(10, 'Isabella', 'Moore', 'isabella.moore@example.com',
 '3185550110', '2026-08-29', 'Active');

-- ==========================================
-- EVENT DATA (6 records)
-- ==========================================

INSERT INTO Event
(event_id, event_name, event_type, event_date,
 event_time, location, description, manager_id)
VALUES
(1, 'General Body Meeting', 'Meeting', '2026-09-05',
 '17:00:00', 'University Center',
 'Monthly organization meeting', 1),
(2, 'Leadership Workshop', 'Workshop', '2026-09-12',
 '16:00:00', 'Business Building',
 'Leadership development', 2),
(3, 'Service Day', 'Service', '2026-09-19',
 '09:00:00', 'Community Center',
 'Community volunteer event', 3),
(4, 'Fall Social', 'Social', '2026-10-03',
 '18:00:00', 'Student Union',
 'Fall social gathering', 4),
(5, 'Fundraising Event', 'Fundraiser', '2026-10-17',
 '12:00:00', 'Campus Quad',
 'Fundraising for student programs', 5),
(6, 'End of Semester Meeting', 'Meeting', '2026-12-02',
 '17:00:00', 'University Center',
 'Final organization meeting', 1);

-- ==========================================
-- ATTENDANCE DATA (24 records)
-- ==========================================

INSERT INTO Attendance
(member_id, event_id, attendance_status,
 check_in_time, notes)
VALUES
(1,1,'Present','17:00:00','On time'),
(2,1,'Present','17:02:00','On time'),
(3,1,'Present','17:05:00','On time'),
(4,1,'Present','17:10:00','Late'),
(5,1,'Absent',NULL,'Excused'),

(1,2,'Present','16:00:00','On time'),
(2,2,'Present','16:05:00','On time'),
(3,2,'Absent',NULL,'Excused'),
(6,2,'Present','16:02:00','On time'),
(7,2,'Present','16:10:00','Late'),

(1,3,'Present','09:00:00','On time'),
(3,3,'Present','09:03:00','On time'),
(4,3,'Present','09:05:00','On time'),
(5,3,'Present','09:07:00','On time'),
(8,3,'Absent',NULL,'Excused'),

(2,4,'Present','18:00:00','On time'),
(4,4,'Present','18:05:00','On time'),
(6,4,'Present','18:10:00','Late'),
(8,4,'Present','18:02:00','On time'),
(9,4,'Absent',NULL,'Excused'),

(1,5,'Present','12:00:00','On time'),
(5,5,'Present','12:03:00','On time'),
(7,5,'Present','12:05:00','On time'),
(10,5,'Present','12:10:00','Late');

-- ==========================================
-- PAYMENT DATA (20 records)
-- ==========================================

INSERT INTO Payment
(payment_id, member_id, amount, payment_date,
 semester, payment_method, payment_type,
 payment_status)
VALUES
(1,1,35.00,'2026-09-01','Fall 2026','Card','Semester Dues','Paid'),
(2,2,35.00,'2026-09-02','Fall 2026','Cash','Semester Dues','Paid'),
(3,3,35.00,'2026-09-03','Fall 2026','Card','Semester Dues','Paid'),
(4,4,35.00,'2026-09-04','Fall 2026','Cash','Semester Dues','Paid'),
(5,5,35.00,'2026-09-05','Fall 2026','Card','Semester Dues','Paid'),
(6,6,35.00,'2026-09-06','Fall 2026','Card','Semester Dues','Paid'),
(7,7,35.00,'2026-09-07','Fall 2026','Cash','Semester Dues','Unpaid'),
(8,8,35.00,'2026-09-08','Fall 2026','Card','Semester Dues','Paid'),
(9,9,35.00,'2026-09-09','Fall 2026','Cash','Semester Dues','Unpaid'),
(10,10,35.00,'2026-09-10','Fall 2026','Card','Semester Dues','Paid'),

(11,1,10.00,'2026-10-01','Fall 2026','Cash','Event Fee','Paid'),
(12,2,10.00,'2026-10-02','Fall 2026','Card','Event Fee','Paid'),
(13,3,10.00,'2026-10-03','Fall 2026','Cash','Event Fee','Paid'),
(14,4,10.00,'2026-10-04','Fall 2026','Card','Event Fee','Paid'),
(15,5,10.00,'2026-10-05','Fall 2026','Cash','Event Fee','Paid'),
(16,6,10.00,'2026-10-06','Fall 2026','Card','Event Fee','Paid'),
(17,7,10.00,'2026-10-07','Fall 2026','Cash','Event Fee','Unpaid'),
(18,8,10.00,'2026-10-08','Fall 2026','Card','Event Fee','Paid'),
(19,9,10.00,'2026-10-09','Fall 2026','Cash','Event Fee','Unpaid'),
(20,10,10.00,'2026-10-10','Fall 2026','Card','Event Fee','Paid');

-- ==========================================
-- SERVICE OPPORTUNITIES (6 records)
-- ==========================================

INSERT INTO ServiceOpportunity
(service_id, service_name, service_date,
 location, description)
VALUES
(1,'Food Bank Volunteer Day','2026-09-10',
 'Shreveport Food Bank','Sort donated food'),
(2,'Campus Cleanup','2026-09-20',
 'LSUS Campus','Clean campus grounds'),
(3,'Community Garden','2026-10-05',
 'Community Garden','Garden maintenance'),
(4,'Animal Shelter Volunteer','2026-10-15',
 'Animal Shelter','Assist shelter staff'),
(5,'Clothing Drive','2026-11-05',
 'University Center','Organize donations'),
(6,'Holiday Outreach','2026-12-10',
 'Community Center','Holiday assistance');

-- ==========================================
-- MEMBER SERVICE (12 records)
-- ==========================================

INSERT INTO MemberService
(member_id, service_id, hours_completed)
VALUES
(1,1,3.00),
(2,1,2.50),
(3,1,4.00),
(4,2,2.00),
(5,2,3.00),
(6,2,2.50),
(7,3,2.00),
(8,3,3.50),
(9,4,2.00),
(10,4,4.00),
(1,5,2.00),
(2,5,3.00);

-- ==========================================
-- OFFICER POSITIONS (6 records)
-- ==========================================

INSERT INTO OfficerPosition
(position_id, position_title, description)
VALUES
(1,'President','Leads the organization'),
(2,'Vice President','Assists the president'),
(3,'Treasurer','Manages organization finances'),
(4,'Secretary','Maintains organization records'),
(5,'Parliamentarian','Oversees meeting procedures'),
(6,'Social Media Manager','Manages social media');

-- ==========================================
-- MEMBER OFFICER POSITIONS (6 records)
-- ==========================================

INSERT INTO MemberOfficerPosition
(member_id, position_id, start_date, end_date)
VALUES
(1,1,'2026-08-20',NULL),
(2,2,'2026-08-20',NULL),
(3,3,'2026-08-20',NULL),
(4,4,'2026-08-20',NULL),
(5,5,'2026-08-20',NULL),
(6,6,'2026-08-20',NULL);
