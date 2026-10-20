CREATE DATABASE IF NOT EXISTS student_org_management;

USE student_org_management;

CREATE TABLE Member (
    member_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    join_date DATE NOT NULL,
    membership_status VARCHAR(20) NOT NULL,
    total_service_hours DECIMAL(6,2) DEFAULT 0.00,
    PRIMARY KEY (member_id),
    UNIQUE (email)
);

CREATE TABLE Event (
    event_id INT AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_type VARCHAR(50),
    event_date DATE NOT NULL,
    event_time TIME,
    location VARCHAR(100),
    description VARCHAR(255),
    manager_id INT,
    PRIMARY KEY (event_id),
    FOREIGN KEY (manager_id) REFERENCES Member(member_id)
);

CREATE TABLE Attendance (
    member_id INT NOT NULL,
    event_id INT NOT NULL,
    attendance_status VARCHAR(20) NOT NULL,
    check_in_time TIME,
    notes VARCHAR(255),
    PRIMARY KEY (member_id, event_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT,
    member_id INT NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    payment_date DATE NOT NULL,
    semester VARCHAR(20),
    payment_method VARCHAR(30),
    payment_type VARCHAR(50),
    payment_status VARCHAR(20) NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    CHECK (amount >= 0)
);

CREATE TABLE ServiceOpportunity (
    service_id INT AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL,
    service_date DATE NOT NULL,
    location VARCHAR(100),
    description VARCHAR(255),
    PRIMARY KEY (service_id)
);

CREATE TABLE MemberService (
    member_id INT NOT NULL,
    service_id INT NOT NULL,
    hours_completed DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (member_id, service_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (service_id) REFERENCES ServiceOpportunity(service_id),
    CHECK (hours_completed >= 0)
);

CREATE TABLE OfficerPosition (
    position_id INT AUTO_INCREMENT,
    position_title VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (position_id),
    UNIQUE (position_title)
);

CREATE TABLE MemberOfficerPosition (
    member_id INT NOT NULL,
    position_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (member_id, position_id, start_date),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (position_id) REFERENCES OfficerPosition(position_id)
);

USE student_org_management;

-- =============================================
-- VIEWS
-- =============================================

CREATE OR REPLACE VIEW MemberSummary AS
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    m.membership_status,
    COUNT(DISTINCT a.event_id) AS events_attended,
    COALESCE(SUM(DISTINCT ms.hours_completed), 0) AS service_hours
FROM Member m
LEFT JOIN Attendance a
    ON m.member_id = a.member_id
    AND a.attendance_status = 'Present'
LEFT JOIN MemberService ms
    ON m.member_id = ms.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    m.membership_status;


CREATE OR REPLACE VIEW EventAttendanceSummary AS
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.location,
    COUNT(a.attendance_id) AS total_records,
    SUM(CASE
        WHEN a.attendance_status = 'Present' THEN 1
        ELSE 0
    END) AS total_present,
    SUM(CASE
        WHEN a.attendance_status = 'Absent' THEN 1
        ELSE 0
    END) AS total_absent
FROM Event e
LEFT JOIN Attendance a
    ON e.event_id = a.event_id
GROUP BY
    e.event_id,
    e.event_name,
    e.event_date,
    e.location;


CREATE OR REPLACE VIEW ServiceHoursSummary AS
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    COALESCE(SUM(ms.hours_completed), 0) AS calculated_service_hours
FROM Member m
LEFT JOIN MemberService ms
    ON m.member_id = ms.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name;

Add database schema
