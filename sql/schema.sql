
CREATE DATABASE IF NOT EXISTS student_org_management;
USE student_org_management;

-- Remove existing views
DROP VIEW IF EXISTS MemberSummary;
DROP VIEW IF EXISTS EventAttendanceSummary;
DROP VIEW IF EXISTS ServiceHoursSummary;

-- Remove existing tables (children first)
DROP TABLE IF EXISTS MemberOfficerPosition;
DROP TABLE IF EXISTS MemberService;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS OfficerPosition;
DROP TABLE IF EXISTS ServiceOpportunity;
DROP TABLE IF EXISTS Member;

-- MEMBER
CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    join_date DATE NOT NULL,
    membership_status VARCHAR(20) NOT NULL,
    CONSTRAINT chk_member_status
        CHECK (membership_status IN
            ('Active', 'Inactive', 'Pending'))
);

-- EVENT
CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_type VARCHAR(50),
    event_date DATE NOT NULL,
    event_time TIME,
    location VARCHAR(100),
    description VARCHAR(255),
    manager_id INT,
    CONSTRAINT fk_event_manager
        FOREIGN KEY (manager_id)
        REFERENCES Member(member_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ATTENDANCE
CREATE TABLE Attendance (
    member_id INT NOT NULL,
    event_id INT NOT NULL,
    attendance_status VARCHAR(20) NOT NULL,
    check_in_time TIME,
    notes VARCHAR(255),
    PRIMARY KEY (member_id, event_id),
    CONSTRAINT fk_attendance_member
        FOREIGN KEY (member_id)
        REFERENCES Member(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_attendance_event
        FOREIGN KEY (event_id)
        REFERENCES Event(event_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- PAYMENT
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    payment_date DATE NOT NULL,
    semester VARCHAR(20),
    payment_method VARCHAR(30),
    payment_type VARCHAR(50),
    payment_status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_payment_member
        FOREIGN KEY (member_id)
        REFERENCES Member(member_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0)
);

-- SERVICE OPPORTUNITY
CREATE TABLE ServiceOpportunity (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_date DATE NOT NULL,
    location VARCHAR(100),
    description VARCHAR(255)
);

-- MEMBER SERVICE
CREATE TABLE MemberService (
    member_id INT NOT NULL,
    service_id INT NOT NULL,
    hours_completed DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (member_id, service_id),
    CONSTRAINT fk_service_member
        FOREIGN KEY (member_id)
        REFERENCES Member(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_service_opportunity
        FOREIGN KEY (service_id)
        REFERENCES ServiceOpportunity(service_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_service_hours
        CHECK (hours_completed >= 0)
);

-- OFFICER POSITION
CREATE TABLE OfficerPosition (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    position_title VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- MEMBER OFFICER POSITION
CREATE TABLE MemberOfficerPosition (
    member_id INT NOT NULL,
    position_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (member_id, position_id, start_date),
    CONSTRAINT fk_officer_member
        FOREIGN KEY (member_id)
        REFERENCES Member(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_officer_position
        FOREIGN KEY (position_id)
        REFERENCES OfficerPosition(position_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_officer_dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);

-- VIEWS

CREATE VIEW ServiceHoursSummary AS
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    COALESCE(SUM(ms.hours_completed), 0)
        AS calculated_service_hours
FROM Member m
LEFT JOIN MemberService ms
    ON m.member_id = ms.member_id
GROUP BY m.member_id, m.first_name, m.last_name;

CREATE VIEW MemberSummary AS
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    m.membership_status,
    (SELECT COUNT(*)
     FROM Attendance a
     WHERE a.member_id = m.member_id
       AND a.attendance_status = 'Present')
        AS events_attended,
    COALESCE(s.calculated_service_hours, 0)
        AS service_hours
FROM Member m
LEFT JOIN ServiceHoursSummary s
    ON m.member_id = s.member_id;

CREATE VIEW EventAttendanceSummary AS
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.location,
    COUNT(a.member_id) AS total_records,
    SUM(CASE WHEN a.attendance_status = 'Present'
        THEN 1 ELSE 0 END) AS total_present,
    SUM(CASE WHEN a.attendance_status = 'Absent'
        THEN 1 ELSE 0 END) AS total_absent
FROM Event e
LEFT JOIN Attendance a
    ON e.event_id = a.event_id
GROUP BY
    e.event_id, e.event_name,
    e.event_date, e.location;
