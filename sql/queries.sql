USE student_org_management;

-- =====================================================
-- FUNCTIONAL REQUIREMENT QUERIES
-- Student Organization Management System
-- Based on Project Milestone 1
-- =====================================================


-- =====================================================
-- FR1
-- An officer can add a new member and record the
-- member's contact and membership information.
-- =====================================================

INSERT INTO Member
(first_name, last_name, email, phone, join_date, membership_status)
VALUES
('Demo', 'Member', 'demo.member@example.com',
 '318-555-0199', CURDATE(), 'Active');


-- =====================================================
-- FR2
-- An officer can update a member's information
-- or membership status.
-- =====================================================

UPDATE Member
SET
    phone = '318-555-0100',
    membership_status = 'Inactive'
WHERE email = 'demo.member@example.com';


-- =====================================================
-- FR3
-- An officer can create an organization event,
-- record its information, and assign a member
-- to manage the event.
-- =====================================================

INSERT INTO Event
(event_name, event_date, event_time, location,
 description, manager_id)
VALUES
('Demo Organization Event',
 '2026-11-20',
 '17:00:00',
 'University Center',
 'Demonstration event for PM2',
 1);


-- =====================================================
-- FR4
-- An officer can record which members attended
-- a specific organization event.
-- =====================================================

INSERT INTO Attendance
(member_id, event_id, attendance_status)
SELECT
    1,
    event_id,
    'Present'
FROM Event
WHERE event_name = 'Demo Organization Event';


-- =====================================================
-- FR5
-- An officer can record a dues payment made by
-- a member, including amount, date, semester,
-- and payment method.
-- =====================================================

INSERT INTO Payment
(member_id, amount, payment_date,
 semester, payment_method, payment_status)
VALUES
(1, 35.00, CURDATE(),
 'Fall 2026', 'Cash', 'Paid');


-- =====================================================
-- FR6
-- An officer can view members who have or have
-- not paid dues for a selected semester.
-- Demonstrates LEFT JOIN.
-- =====================================================

SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    CASE
        WHEN p.payment_id IS NOT NULL THEN 'Paid'
        ELSE 'Not Paid'
    END AS dues_status
FROM Member m
LEFT JOIN Payment p
    ON m.member_id = p.member_id
    AND p.semester = 'Fall 2026'
    AND p.payment_status = 'Paid'
ORDER BY m.last_name, m.first_name;


-- =====================================================
-- FR7
-- An officer can create a service opportunity
-- and record which members participated in it.
-- =====================================================

INSERT INTO ServiceOpportunity
(service_name, service_date, location, description)
VALUES
('Demo Campus Cleanup',
 '2026-11-14',
 'LSUS Campus',
 'Campus cleanup service opportunity');


INSERT INTO MemberService
(member_id, service_id, hours_completed)
SELECT
    1,
    service_id,
    0
FROM ServiceOpportunity
WHERE service_name = 'Demo Campus Cleanup';


-- =====================================================
-- FR8
-- An officer can record how many service hours
-- a member earned from a service opportunity.
-- =====================================================

UPDATE MemberService ms
JOIN ServiceOpportunity so
    ON ms.service_id = so.service_id
SET ms.hours_completed = 3.50
WHERE ms.member_id = 1
  AND so.service_name = 'Demo Campus Cleanup';


-- =====================================================
-- FR9
-- An officer can view the total number of service
-- hours completed by each member.
-- Demonstrates LEFT JOIN, SUM, GROUP BY.
-- =====================================================

SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    COALESCE(SUM(ms.hours_completed), 0)
        AS total_service_hours
FROM Member m
LEFT JOIN MemberService ms
    ON m.member_id = ms.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY total_service_hours DESC;


-- =====================================================
-- FR10
-- An officer can assign a member to an officer
-- position and record the dates of the member's term.
-- =====================================================

INSERT INTO MemberOfficerPosition
(member_id, position_id, start_date, end_date)
VALUES
(1, 1, '2026-08-20', '2027-05-15');


-- =====================================================
-- FR11
-- The system can display the total number of
-- members who attended each organization event.
-- Demonstrates LEFT JOIN, COUNT, GROUP BY.
-- =====================================================

SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    COUNT(
        CASE
            WHEN a.attendance_status = 'Present'
            THEN 1
        END
    ) AS total_attended
FROM Event e
LEFT JOIN Attendance a
    ON e.event_id = a.event_id
GROUP BY
    e.event_id,
    e.event_name,
    e.event_date
ORDER BY e.event_date;


-- =====================================================
-- FR12
-- The system can display the total amount of dues
-- recorded for a selected semester.
-- Demonstrates SUM.
-- =====================================================

SELECT
    semester,
    COALESCE(SUM(amount), 0) AS total_dues_recorded
FROM Payment
WHERE semester = 'Fall 2026'
GROUP BY semester;
