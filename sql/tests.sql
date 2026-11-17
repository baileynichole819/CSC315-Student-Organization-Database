
USE student_org_management;

-- =============================================
-- STUDENT ORGANIZATION MANAGEMENT SYSTEM
-- PM2 CONSTRAINT TESTS
-- =============================================

-- POSITIVE TEST: Valid member insertion
-- Expected: Success

INSERT INTO Member
(member_id, first_name, last_name, email,
 phone, join_date, membership_status)
VALUES
(9001, 'Test', 'Member', 'test.member@example.com',
 '318-555-0199', '2026-10-01', 'Active');

SELECT * FROM Member WHERE member_id = 9001;

DELETE FROM Member WHERE member_id = 9001;


-- =============================================
-- NEGATIVE TEST 1: PRIMARY KEY
-- =============================================

-- Expected: FAIL
-- Member ID 1 already exists.

INSERT INTO Member
(member_id, first_name, last_name, email,
 phone, join_date, membership_status)
VALUES
(1, 'Duplicate', 'PrimaryKey',
 'duplicate.pk@example.com',
 '318-555-0198', '2026-10-01', 'Active');

-- Verification
SELECT * FROM Member WHERE member_id = 1;


-- =============================================
-- NEGATIVE TEST 2: FOREIGN KEY
-- =============================================

-- Expected: FAIL
-- Member 9999 does not exist.

INSERT INTO Attendance
(member_id, event_id, attendance_status)
VALUES
(9999, 1, 'Present');

-- Verification
SELECT * FROM Attendance WHERE member_id = 9999;


-- =============================================
-- NEGATIVE TEST 3: CHECK CONSTRAINT
-- =============================================

-- Expected: FAIL
-- Negative payment amounts are not allowed.

INSERT INTO Payment
(member_id, amount, payment_date,
 payment_type, payment_status)
VALUES
(1, -35.00, '2026-10-01',
 'Semester Dues', 'Paid');

-- Verification
SELECT * FROM Payment WHERE amount < 0;


-- =============================================
-- NEGATIVE TEST 4: REFERENTIAL ACTION
-- =============================================

-- Expected: FAIL
-- Member 1 has payment records.
-- Payment uses ON DELETE RESTRICT.

DELETE FROM Member
WHERE member_id = 1;

-- Verification
SELECT * FROM Member WHERE member_id = 1;
SELECT * FROM Payment WHERE member_id = 1;


-- =============================================
-- ADDITIONAL TEST: UNIQUE CONSTRAINT
-- =============================================

-- Expected: FAIL
-- This email already belongs to Maria Singleton.

INSERT INTO Member
(first_name, last_name, email, phone,
 join_date, membership_status)
VALUES
('Duplicate', 'Member',
 'maria.singleton@example.com',
 '318-555-0197', '2026-10-01', 'Active');

-- Verification
SELECT * FROM Member
WHERE email = 'maria.singleton@example.com';
