
USE student_org_management;

-- =====================================================
-- FR1: Add a new member
-- =====================================================
INSERT INTO Member
(first_name, last_name, email, phone,
 join_date, membership_status)
VALUES
('Demo', 'Member', 'demo.member@example.com',
 '318-555-0199', CURDATE(), 'Active');

-- =====================================================
-- FR2: Update member information
-- =====================================================
UPDATE Member
SET phone = '318-555-0100',
    membership_status = 'Inactive'
WHERE email = 'demo.member@example.com';

-- =====================================================
-- FR3: Create an event
-- =====================================================
INSERT INTO Event
(event_name, event_type, event_date,
 event_time, location, description, manager_id)
VALUES
('Demo Organization Event', 'Meeting',
 '2026-11-20', '17:00:00',
 'University Center',
 'Demonstration event for PM2', 1);

-- =====================================================
-- FR4: Record event attendance
-- =====================================================
INSERT INTO Attendance
(member_id, event_id, attendance_status,
 check_in_time, notes)
SELECT
    1, event_id, 'Present',
    '17:00:00', 'Demo attendance'
FROM Event
WHERE event_name = 'Demo Organization Event';

-- =====================================================
-- FR5: Record dues payment
-- =====================================================
INSERT INTO Payment
(member_id, amount, payment_date, semester,
 payment_method, payment_type, payment_status)
VALUES
(1, 35.00, CURDATE(), 'Fall 2026',
 'Cash', 'Semester Dues', 'Paid');

-- =====================================================
-- FR6: View paid/unpaid members
-- Uses a nested subquery
-- =====================================================
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM Payment p
            WHERE p.member_id = m.member_id
              AND p.semester = 'Fall 2026'
              AND p.payment_type = 'Semester Dues'
              AND p.payment_status = 'Paid'
        )
        THEN 'Paid'
        ELSE 'Not Paid'
    END AS dues_status
FROM Member m
ORDER BY m.last_name, m.first_name;

-- =====================================================
-- FR7: Create service opportunity
-- =====================================================
INSERT INTO ServiceOpportunity
(service_name, service_date, location, description)
VALUES
('Demo Campus Cleanup', '2026-11-14',
 'LSUS Campus', 'Campus cleanup opportunity');

-- Record a participant
INSERT INTO MemberService
(member_id, service_id, hours_completed)
SELECT
    1, service_id, 0
FROM ServiceOpportunity
WHERE service_name = 'Demo Campus Cleanup';

-- =====================================================
-- FR8: Record service hours
-- =====================================================
UPDATE MemberService ms
JOIN ServiceOpportunity so
    ON ms.service_id = so.service_id
SET ms.hours_completed = 3.50
WHERE ms.member_id = 1
  AND so.service_name = 'Demo Campus Cleanup';

-- =====================================================
-- FR9: View total service hours
-- Uses ServiceHoursSummary view
-- =====================================================
SELECT
    member_id,
    first_name,
    last_name,
    calculated_service_hours
FROM ServiceHoursSummary
ORDER BY calculated_service_hours DESC;

-- =====================================================
-- FR10: Assign officer position
-- Uses an existing member and position
-- =====================================================
INSERT INTO MemberOfficerPosition
(member_id, position_id, start_date, end_date)
VALUES
(7, 3, '2026-11-01', '2027-05-15');

-- =====================================================
-- FR11: View attendance totals
-- Uses EventAttendanceSummary view
-- =====================================================
SELECT
    event_id,
    event_name,
    event_date,
    total_present AS total_attended
FROM EventAttendanceSummary
ORDER BY event_date;

-- =====================================================
-- FR12: View dues totals
-- Uses SUM and GROUP BY
-- =====================================================
SELECT
    semester,
    COALESCE(SUM(amount), 0) AS total_dues_recorded
FROM Payment
WHERE semester = 'Fall 2026'
  AND payment_type = 'Semester Dues'
  AND payment_status = 'Paid'
GROUP BY semester;

-- =====================================================
-- ADDITIONAL REPORT 1
-- Three-table JOIN
-- =====================================================
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    e.event_name,
    e.event_date,
    a.attendance_status
FROM Member m
JOIN Attendance a
    ON m.member_id = a.member_id
JOIN Event e
    ON a.event_id = e.event_id
ORDER BY e.event_date, m.last_name;

-- =====================================================
-- ADDITIONAL REPORT 2
-- HAVING clause
-- Members with more than 3 service hours
-- =====================================================
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    SUM(ms.hours_completed) AS total_hours
FROM Member m
JOIN MemberService ms
    ON m.member_id = ms.member_id
GROUP BY
    m.member_id, m.first_name, m.last_name
HAVING SUM(ms.hours_completed) > 3;

-- =====================================================
-- ADDITIONAL OPERATION
-- DELETE demonstration
-- Deletes only the demo attendance record
-- =====================================================
DELETE a
FROM Attendance a
JOIN Event e ON a.event_id = e.event_id
WHERE a.member_id = 1
  AND e.event_name = 'Demo Organization Event';

-- =====================================================
-- VERIFY THE RESULTS
-- =====================================================
SELECT * FROM MemberSummary;
SELECT * FROM EventAttendanceSummary;
SELECT * FROM ServiceHoursSummary;
