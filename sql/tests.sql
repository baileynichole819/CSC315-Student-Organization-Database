USE student_org_management;

-- =============================================
-- CONSTRAINT TESTS
-- Student Organization Management System
-- =============================================

-- POSITIVE TEST
-- This should succeed because all required values
-- are present and the email address is unique.

INSERT INTO Member
(first_name, last_name, email, phone, join_date, membership_status)
VALUES
('Test', 'Member', 'test.member@example.com',
 '318-555-0199', '2026-10-01', 'Active');

-- Verify that the valid member was added.
SELECT *
FROM Member
WHERE email = 'test.member@example.com';

-- Remove the test member afterward.
DELETE FROM Member
WHERE email = 'test.member@example.com';


-- =============================================
-- NEGATIVE TEST 1: UNIQUE CONSTRAINT
-- =============================================

-- SHOULD FAIL because this email already belongs
-- to an existing member.
INSERT INTO Member
(first_name, last_name, email, phone, join_date, membership_status)
VALUES
('Duplicate', 'Member', 'maria.singleton@example.com',
 '318-555-0198', '2026-10-01', 'Active');


-- =============================================
-- NEGATIVE TEST 2: FOREIGN KEY CONSTRAINT
-- =============================================

-- SHOULD FAIL because member 9999 does not exist.
INSERT INTO Attendance
(member_id, event_id, attendance_status)
VALUES
(9999, 1, 'Present');


-- =============================================
-- NEGATIVE TEST 3: CHECK CONSTRAINT
-- =============================================

-- SHOULD FAIL because a payment cannot have
-- a negative amount.
INSERT INTO Payment
(member_id, amount, payment_date, payment_type, payment_status)
VALUES
(1, -35.00, '2026-10-01', 'Semester Dues', 'Paid');
