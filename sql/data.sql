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
    event_date DATE NOT NULL,
    event_time TIME,
    location VARCHAR(100),
    description VARCHAR(255),
    PRIMARY KEY (event_id)
);

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT,
    member_id INT NOT NULL,
    event_id INT NOT NULL,
    attendance_status VARCHAR(20) NOT NULL,
    PRIMARY KEY (attendance_id),
    UNIQUE (member_id, event_id),
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

-- Additional future event for upcoming event queries
INSERT INTO Event
(event_name, event_date, event_time, location, description)
VALUES
('End of Semester Meeting', '2026-11-12', '17:00:00',
 'University Center', 'Final organization meeting of the fall semester');
 
 -- Sample payment data
INSERT INTO Payment
(member_id, amount, payment_date, semester, payment_method, payment_type, payment_status)
VALUES
(1, 35.00, '2026-09-01', 'Fall 2026', 'Card', 'Semester Dues', 'Paid'),
(2, 35.00, '2026-09-02', 'Fall 2026', 'Cash', 'Semester Dues', 'Paid'),
(3, 35.00, '2026-09-03', 'Fall 2026', 'Card', 'Semester Dues', 'Paid'),
(4, 35.00, '2026-09-04', 'Fall 2026', 'Cash', 'Semester Dues', 'Paid'),
(5, 35.00, '2026-09-05', 'Fall 2026', 'Card', 'Semester Dues', 'Paid'),
(6, 35.00, '2026-09-06', 'Fall 2026', 'Card', 'Semester Dues', 'Paid'),
(7, 35.00, '2026-09-07', 'Fall 2026', 'Cash', 'Semester Dues', 'Unpaid'),
(8, 35.00, '2026-09-08', 'Fall 2026', 'Card', 'Semester Dues', 'Paid');
