INSERT INTO students (name, gender, email_id, password, personal_email_id, joining_term, joining_year, phone_number,
                      nationality)
VALUES ('John Doe', 'Male', 'john.doe@university.edu', 'student@123', 'johndoe@gmail.com', 'FALL', 2023, '1234567890',
        'USA'),
       ('Jane Smith', 'Female', 'jane.smith@university.edu', 'student@123', 'janesmith@yahoo.com', 'WINTER', 2022,
        '0987654321',
        'Canada'),
       ('Alice Johnson', 'Female', 'alice.johnson@university.edu', 'student@123', 'alicej@yahoo.com', 'SUMMER', 2024,
        '9876543210',
        'UK'),
       ('Bob Williams', 'Male', 'bob.williams@university.edu', 'student@123', 'bobw@gmail.com', 'FALL', 2021,
        '5678901834', 'Germany'),
       ('Charlie Brown', 'Other', 'charlie.brown@university.edu', 'student@123', 'charlieb@gmail.com', 'WINTER', 2023,
        '2345678901',
        'France'),
       ('David Miller', 'Male', 'david.miller@university.edu', 'student@123', 'davidm@yahoo.com', 'FALL', 2022,
        '3456789012', 'USA'),
       ('Emma Wilson', 'Female', 'emma.wilson@university.edu', 'student@123', 'emmaw@gmail.com', 'SUMMER', 2023,
        '4567890123',
        'Canada'),
       ('Frank Thomas', 'Male', 'frank.thomas@university.edu', 'student@123', 'frankt@gmail.com', 'WINTER', 2024,
        '5678901234', 'UK'),
       ('Grace Lee', 'Female', 'grace.lee@university.edu', 'student@123', 'gracel@gmail.com', 'FALL', 2021,
        '6789012345', 'Germany'),
       ('Henry Martin', 'Male', 'henry.martin@university.edu', 'student@123', 'henrym@gmail.com', 'SUMMER', 2022,
        '7890123456',
        'France'),
       ('Isabella Moore', 'Female', 'isabella.moore@university.edu', 'student@123', 'isabellam@gmail.com', 'WINTER',
        2023,
        '8901234567', 'USA'),
       ('Jack Taylor', 'Male', 'jack.taylor@university.edu', 'student@123', 'jackt@gmail.com', 'FALL', 2022,
        '9012345678', 'Canada'),
       ('Karen Anderson', 'Female', 'karen.anderson@university.edu', 'student@123', 'karena@gmail.com', 'SUMMER', 2023,
        '1234509876',
        'UK'),
       ('Liam Harris', 'Male', 'liam.harris@university.edu', 'student@123', 'liamh@gmail.com', 'WINTER', 2024,
        '2345609875',
        'Germany'),
       ('Mia Clark', 'Female', 'mia.clark@university.edu', 'student@123', 'miac@gmail.com', 'FALL', 2021, '3456709864',
        'France'),
       ('Noah Lewis', 'Male', 'noah.lewis@university.edu', 'student@123', 'noahl@gmail.com', 'SUMMER', 2022,
        '4567809853', 'USA'),
       ('Olivia Walker', 'Female', 'olivia.walker@university.edu', 'student@123', 'oliviaw@gmail.com', 'WINTER', 2023,
        '5678909842',
        'Canada'),
       ('Paul Hall', 'Male', 'paul.hall@university.edu', 'student@123', 'paulh@gmail.com', 'FALL', 2022, '6789009831',
        'UK'),
       ('Quincy Scott', 'Other', 'quincy.scott@university.edu', 'student@123', 'quincys@gmail.com', 'SUMMER', 2023,
        '7890109820',
        'Germany');


INSERT INTO student_address (student_id, street, aptno, city, state, country, is_permanent, is_current, zip)
VALUES (1, '123 Main St', 'Apt 1B', 'Ann Arbor', 'Michigan', 'USA', TRUE, FALSE, '48104'),
       (1, '456 College Ave', 'Apt 2C', 'Dearborn', 'Michigan', 'USA', FALSE, TRUE, '48126'),
       (2, '789 Elm St', NULL, 'Chicago', 'Illinois', 'USA', TRUE, TRUE, '60616'),
       (3, '101 Pine Ave', 'Suite 301', 'San Francisco', 'California', 'USA', TRUE, FALSE, '94107'),
       (3, '202 Bay Rd', NULL, 'Palo Alto', 'California', 'USA', FALSE, TRUE, '94306'),
       (4, '303 Oak Lane', 'Unit 5A', 'Boston', 'Massachusetts', 'USA', TRUE, FALSE, '02115'),
       (4, '404 River St', NULL, 'Cambridge', 'Massachusetts', 'USA', FALSE, TRUE, '02139'),
       (5, '505 Maple Dr', NULL, 'New York', 'New York', 'USA', TRUE, TRUE, '10001'),
       (6, '606 Birch St', 'Apt 7B', 'Seattle', 'Washington', 'USA', TRUE, FALSE, '98101'),
       (6, '707 Cedar Ln', 'Unit 8C', 'Bellevue', 'Washington', 'USA', FALSE, TRUE, '98004'),
       (7, '808 Spruce Ct', NULL, 'Houston', 'Texas', 'USA', TRUE, TRUE, '77002'),
       (8, '909 Redwood Blvd', 'Suite 10D', 'Los Angeles', 'California', 'USA', TRUE, FALSE, '90012'),
       (8, '1010 Hollywood St', NULL, 'Beverly Hills', 'California', 'USA', FALSE, TRUE, '90210'),
       (9, '1111 Aspen Rd', NULL, 'Austin', 'Texas', 'USA', TRUE, TRUE, '73301'),
       (10, '1212 Fir St', 'Apt 3E', 'Denver', 'Colorado', 'USA', TRUE, FALSE, '80202'),
       (10, '1313 Pinecone Ave', 'Unit 4F', 'Boulder', 'Colorado', 'USA', FALSE, TRUE, '80301'),
       (11, '1414 Chestnut Blvd', NULL, 'Phoenix', 'Arizona', 'USA', TRUE, TRUE, '85001'),
       (12, '1515 Walnut St', 'Suite 6G', 'Philadelphia', 'Pennsylvania', 'USA', TRUE, FALSE, '19103'),
       (12, '1616 Cherry Rd', NULL, 'Pittsburgh', 'Pennsylvania', 'USA', FALSE, TRUE, '15222'),
       (13, '1717 Oakwood Ln', NULL, 'Miami', 'Florida', 'USA', TRUE, TRUE, '33101');


INSERT INTO staff (name, gender, designation)
VALUES ('Dr. Sarah Adams', 'Female', 'Dean'),
       ('Prof. Michael Bennett', 'Male', 'Professor'),
       ('Dr. Emily Clark', 'Female', 'Vice Professor'),
       ('Mr. James Dalton', 'Male', 'Instructor'),
       ('Dr. Olivia Evans', 'Female', 'President'),
       ('Dr. Robert Harris', 'Male', 'Vice President'),
       ('Prof. Anna White', 'Female', 'Professor'),
       ('Dr. Brian Green', 'Male', 'Dean'),
       ('Prof. Laura Scott', 'Female', 'Vice Professor'),
       ('Mr. Eric Cooper', 'Male', 'Instructor'),
       ('Dr. Sophia Lee', 'Female', 'Dean'),
       ('Prof. Thomas Martinez', 'Male', 'Professor'),
       ('Dr. Rachel Carter', 'Female', 'Vice Professor'),
       ('Mr. Kevin Brown', 'Male', 'Instructor'),
       ('Dr. William Anderson', 'Male', 'President'),
       ('Prof. Nancy Moore', 'Female', 'Professor'),
       ('Dr. Daniel Clark', 'Male', 'Vice President'),
       ('Prof. Olivia Taylor', 'Female', 'Professor'),
       ('Dr. Henry Wilson', 'Male', 'Dean'),
       ('Mr. Jacob Lewis', 'Male', 'Instructor');

INSERT INTO staff_address (staff_id, street, aptno, city, state, zip)
VALUES (1, '123 Elm St', 'Apt 101', 'New York', 'NY', '10001'),
       (2, '456 Oak St', 'Apt 202', 'Los Angeles', 'CA', '90001'),
       (3, '789 Pine St', 'Apt 303', 'Chicago', 'IL', '60601'),
       (4, '101 Maple Ave', 'Apt 404', 'Houston', 'TX', '77001'),
       (5, '202 Birch Rd', 'Apt 505', 'Phoenix', 'AZ', '85001'),
       (6, '303 Cedar Blvd', 'Apt 606', 'Philadelphia', 'PA', '19101'),
       (7, '404 Willow Way', 'Apt 707', 'San Antonio', 'TX', '78201'),
       (8, '505 Redwood Ln', 'Apt 808', 'San Diego', 'CA', '92101'),
       (9, '606 Aspen Dr', 'Apt 909', 'Dallas', 'TX', '75201'),
       (10, '707 Fir Ct', 'Apt 1010', 'San Jose', 'CA', '95101'),
       (11, '808 Cherry Pl', 'Apt 1111', 'Austin', 'TX', '73301'),
       (12, '909 Walnut St', 'Apt 1212', 'Jacksonville', 'FL', '32201'),
       (13, '1001 Chestnut Ave', 'Apt 1313', 'Fort Worth', 'TX', '76101'),
       (14, '1102 Maplewood Dr', 'Apt 1414', 'Columbus', 'OH', '43201'),
       (15, '1203 Oakwood Dr', 'Apt 1515', 'Indianapolis', 'IN', '46201'),
       (16, '1304 Pinehill Rd', 'Apt 1616', 'Charlotte', 'NC', '28201'),
       (17, '1405 Willowbrook Ln', 'Apt 1717', 'Detroit', 'MI', '48201'),
       (18, '1506 Sequoia Blvd', 'Apt 1818', 'Seattle', 'WA', '98101'),
       (19, '1607 Redwood Rd', 'Apt 1919', 'Denver', 'CO', '80201'),
       (20, '1708 Maple St', 'Apt 2020', 'Washington', 'DC', '20001');

INSERT INTO college (id, name, president_id)
VALUES (1, 'College of Arts, Sciences and Letters', 1),
       (2, 'College of Business', 2),
       (3, 'College of Education, Health and Human Services', 3),
       (4, 'College of Engineering and Computer Science', 4);

INSERT INTO department (id, name, dean_id, college_id)
VALUES (1, 'Behavioral Sciences', 1, 1),
       (2, 'Language, Culture, and the Arts', 2, 1),
       (3, 'Mathematics and Statistics', 3, 1),
       (4, 'Natural Sciences', 4, 1),
       (5, 'Social Sciences', 5, 1),
       (6, 'Accounting', 6, 2),
       (7, 'Digital Marketing', 7, 2),
       (8, 'General Business', 8, 2),
       (9, 'Finance', 9, 2),
       (10, 'Human Resource Management', 10, 2),
       (11, 'Supply Chain Management', 1, 2),
       (12, 'Business Analytics', 2, 2),
       (13, 'Information System Management', 3, 2),
       (14, 'Education', 4, 3),
       (15, 'Health and Human Services', 5, 3),
       (16, 'Computer and Information Science', 6, 4),
       (17, 'Electrical and Computer Engineering', 7, 4),
       (18, 'Industrial and Manufacturing Systems Engineering', 8, 4),
       (19, 'Mechanical Engineering', 9, 4);

INSERT INTO programs (id, name, level, department_id)
VALUES
-- College of Arts, Sciences and Letters (Departments: 1-5)
(1, 'Undergraduate Program', 'UG', 1),
(2, 'Graduate Program', 'PG', 2),
(3, 'Certifications', 'Asso.', 3),

-- College of Business (Departments: 6-13)
(4, 'Undergraduate Program', 'UG', 6),
(5, 'Graduate Program', 'PG', 7),

-- College of Education, Health and Human Services (Departments: 14-15)
(6, 'Undergraduate Program', 'UG', 14),
(7, 'Graduate Program', 'PG', 15),
(8, 'Post-Degree and Endorsement Programs', 'Asso.', 14),

-- College of Engineering and Computer Science (Departments: 16-19)
(9, 'Undergraduate Program', 'UG', 16),
(10, 'Graduate Program', 'PG', 17),
(11, 'PhD Programs', 'DR.', 18),
(12, 'D.Eng Programs', 'DR.', 19);


INSERT INTO courses (id, department_id, course_code, name, credits, total_hours, pre_requisite)
VALUES
-- College of Arts, Science and Letters
(1, 1, 'ASL101', 'Introduction to Sociology', 3, 165, NULL),
(2, 1, 'ASL102', 'Psychology of Human Behavior', 3, 165, NULL),
(3, 1, 'ASL201', 'Cultural Anthropology', 3, 165, 1),
(4, 2, 'LIT201', 'World Literature', 3, 165, NULL),
(5, 2, 'LIT202', 'Creative Writing', 3, 165, 4),
(6, 2, 'LIT203', 'Classical Mythology', 3, 165, 5),
(7, 3, 'MTH201', 'Calculus I', 3, 165, NULL),
(8, 3, 'MATH202', 'Linear Algebra', 3, 165, NULL),
(9, 3, 'MTH301', 'Differential Equations', 3, 165, 8),
(10, 4, 'BIO101', 'General Biology', 3, 165, NULL),
(11, 4, 'BIO202', 'Microbiology', 3, 165, 10),
(12, 4, 'CHE101', 'General Chemistry', 3, 165, NULL),
(13, 5, 'SOC201', 'Social Research Methods', 3, 165, NULL),
(14, 5, 'SOC202', 'Comparative Politics', 3, 165, 13),

-- College of Business
(15, 6, 'ACC101', 'Financial Accounting', 3, 165, NULL),
(16, 6, 'ACC201', 'Managerial Accounting', 3, 165, 15),
(17, 7, 'MKT101', 'Principles of Marketing', 3, 165, NULL),
(18, 7, 'MKT202', 'Consumer Behavior', 3, 165, 17),
(19, 8, 'BUS101', 'Introduction to Business', 3, 165, NULL),
(20, 8, 'BUS201', 'Business Law', 3, 165, NULL),
(21, 9, 'FIN101', 'Corporate Finance', 3, 165, NULL),
(22, 9, 'FIN202', 'Investment Strategies', 3, 165, 21),
(23, 10, 'HRM101', 'Human Resources Management', 3, 165, NULL),
(24, 10, 'HRM201', 'Organizational Behavior', 3, 165, 23),

-- College of Education, Health
(25, 14, 'EDU101', 'Foundations of Education', 3, 165, NULL),
(26, 14, 'EDU201', 'Classroom Management', 3, 165, 25),
(27, 15, 'HHS101', 'Introduction to Public Health', 3, 165, NULL),
(28, 15, 'HHS202', 'Healthcare Policy', 3, 165, 27),

-- College of Engineering
(29, 16, 'CIS101', 'Programming Fundamentals', 3, 165, NULL),
(30, 16, 'CIS201', 'Data Structures', 3, 165, 29),
(31, 16, 'CSE202', 'Computer Architecture', 3, 165, NULL),
(32, 16, 'CSE301', 'Artificial Intelligence', 3, 165, 31),
(33, 17, 'ECE101', 'Circuit Analysis', 3, 165, NULL),
(34, 17, 'ECE202', 'Digital Systems', 3, 165, NULL),
(35, 18, 'EEE101', 'Electromagnetics', 3, 165, NULL),
(36, 18, 'EEE201', 'Microprocessors', 3, 165, 35),
(37, 19, 'ME101', 'Thermodynamics', 3, 165, NULL),
(38, 19, 'ME201', 'Heat Transfer', 3, 165, 37),
(39, 19, 'ME301', 'Machine Elements', 3, 165, NULL);



INSERT INTO program_registration (student_id, program_id)
VALUES (1, 3),
       (2, 5),
       (3, 8),
       (4, 10),
       (5, 2),
       (6, 7),
       (7, 12),
       (8, 11),
       (9, 1),
       (10, 6),
       (11, 9),
       (12, 10),
       (13, 11),
       (14, 8),
       (15, 4),
       (16, 6),
       (17, 6),
       (18, 5),
       (19, 12),
       (5, 9);

INSERT INTO department_staff (department_id, staff_id)
VALUES (1, 5),   -- Behavioral Sciences
       (1, 6),
       (2, 3),   -- Language, Culture, and the Arts
       (2, 4),
       (3, 5),   -- Mathematics and Statistics
       (3, 6),
       (4, 7),   -- Natural Sciences
       (4, 8),
       (5, 9),   -- Social Sciences
       (5, 10),
       (6, 11),  -- Accounting
       (6, 12),
       (7, 13),  -- Digital Marketing
       (7, 14),
       (8, 15),  -- General Business
       (8, 16),
       (9, 17),  -- Finance
       (9, 18),
       (10, 19), -- Human Resource Management
       (10, 20),
       (11, 1),  -- Supply Chain Management
       (11, 2),
       (12, 3),  -- Business Analytics
       (12, 4),
       (13, 5),  -- Information System Management
       (13, 6),
       (14, 7),  -- Education
       (14, 8),
       (15, 9),  -- Health and Human Services
       (15, 10),
       (16, 11), -- Computer and Information Science
       (16, 12),
       (17, 13), -- Electrical and Computer Engineering
       (17, 14),
       (18, 15), -- Industrial and Manufacturing Systems Engineering
       (18, 16),
       (19, 17), -- Mechanical Engineering
       (19, 18);



INSERT INTO classrooms (room_number, max_acc)
VALUES
-- Behavioral Sciences Building (BSB)
('BSB-101', 50),
('BSB-102', 40),
('BSB-201', 60),
('BSB-202', 45),
('BSB-301', 55),
('BSB-Lab1', 30),
('BSB-Lab2', 25),

-- Language, Culture, and the Arts Building (LCA)
('LCA-101', 50),
('LCA-102', 40),
('LCA-201', 60),
('LCA-202', 45),
('LCA-301', 55),
('LCA-Lab1', 30),
('LCA-Lab2', 25),

-- Mathematics and Statistics Building (MSB)
('MSB-101', 50),
('MSB-102', 40),
('MSB-201', 60),
('MSB-202', 45),
('MSB-301', 55),
('MSB-Lab1', 30),
('MSB-Lab2', 25),

-- Natural Sciences Building (NSB)
('NSB-101', 50),
('NSB-102', 40),
('NSB-201', 60),
('NSB-202', 45),
('NSB-301', 55),
('NSB-Lab1', 30),
('NSB-Lab2', 25),

-- Social Sciences Building (SSB)
('SSB-101', 50),
('SSB-102', 40),
('SSB-201', 60),
('SSB-202', 45),
('SSB-301', 55),
('SSB-Lab1', 30),
('SSB-Lab2', 25),

-- Accounting Building (ACB)
('ACB-101', 50),
('ACB-102', 40),
('ACB-201', 60),
('ACB-202', 45),
('ACB-301', 55),
('ACB-Lab1', 30),
('ACB-Lab2', 25),

-- Digital Marketing Building (DMB)
('DMB-101', 50),
('DMB-102', 40),
('DMB-201', 60),
('DMB-202', 45),
('DMB-301', 55),
('DMB-Lab1', 30),
('DMB-Lab2', 25),

-- General Business Building (GBB)
('GBB-101', 50),
('GBB-102', 40),
('GBB-201', 60),
('GBB-202', 45),
('GBB-301', 55),
('GBB-Lab1', 30),
('GBB-Lab2', 25),

-- Finance Building (FB)
('FB-101', 50),
('FB-102', 40),
('FB-201', 60),
('FB-202', 45),
('FB-301', 55),
('FB-Lab1', 30),
('FB-Lab2', 25),

-- Human Resource Management Building (HRMB)
('HRMB-101', 50),
('HRMB-102', 40),
('HRMB-201', 60),
('HRMB-202', 45),
('HRMB-301', 55),
('HRMB-Lab1', 30),
('HRMB-Lab2', 25),

-- Supply Chain Management Building (SCMB)
('SCMB-101', 50),
('SCMB-102', 40),
('SCMB-201', 60),
('SCMB-202', 45),
('SCMB-301', 55),
('SCMB-Lab1', 30),
('SCMB-Lab2', 25),

-- Education Building (EDB)
('EDB-101', 50),
('EDB-102', 40),
('EDB-201', 60),
('EDB-202', 45),
('EDB-301', 55),
('EDB-Lab1', 30),
('EDB-Lab2', 25),

-- Health and Human Services Building (HHSB)
('HHSB-101', 50),
('HHSB-102', 40),
('HHSB-201', 60),
('HHSB-202', 45),
('HHSB-301', 55),
('HHSB-Lab1', 30),
('HHSB-Lab2', 25),

-- Computer and Information Science Building (CISB)
('CISB-101', 50),
('CISB-102', 40),
('CISB-201', 60),
('CISB-202', 45),
('CISB-301', 55),
('CISB-Lab1', 30),
('CISB-Lab2', 25),

-- Electrical and Computer Engineering Building (ECEB)
('ECEB-101', 50),
('ECEB-102', 40),
('ECEB-201', 60),
('ECEB-202', 45),
('ECEB-301', 55),
('ECEB-Lab1', 30),
('ECEB-Lab2', 25),

-- Industrial and Manufacturing Systems Engineering Building (IMSEB)
('IMSB-101', 50),
('IMSB-102', 40),
('IMSB-201', 60),
('IMSB-202', 45),
('IMSB-301', 55),
('IMSB-Lab1', 30),
('IMSB-Lab2', 25),

-- Mechanical Engineering Building (MEB)
('MEB-101', 50),
('MEB-102', 40),
('MEB-201', 60),
('MEB-202', 45),
('MEB-301', 55),
('MEB-Lab1', 30),
('MEB-Lab2', 25);


INSERT INTO courses_offered (course_id, lectured_by, semester, year, start_time, end_time, day_of_week, class_room_id)
VALUES
-- Fall 2025 Courses
(1, 2, 'FALL', 2025, '09:00:00', '10:45:00', 'Monday', 1),
(2, 3, 'FALL', 2025, '11:00:00', '12:45:00', 'Tuesday', 2),
(3, 4, 'FALL', 2025, '14:00:00', '15:45:00', 'Wednesday', 3),
(4, 5, 'FALL', 2025, '10:00:00', '11:45:00', 'Thursday', 4),
(5, 6, 'FALL', 2025, '13:00:00', '14:45:00', 'Friday', 5),
(6, 7, 'FALL', 2025, '15:00:00', '16:45:00', 'Monday', 6),
(7, 8, 'FALL', 2025, '09:00:00', '10:45:00', 'Wednesday', 7),

-- Winter 2025 Courses
(8, 9, 'WINTER', 2025, '10:00:00', '11:45:00', 'Tuesday', 8),
(9, 10, 'WINTER', 2025, '13:00:00', '14:45:00', 'Thursday', 9),
(10, 11, 'WINTER', 2025, '15:00:00', '16:45:00', 'Friday', 10),
(11, 12, 'WINTER', 2025, '09:00:00', '10:45:00', 'Monday', 11),
(12, 13, 'WINTER', 2025, '11:00:00', '12:45:00', 'Wednesday', 12),
(13, 14, 'WINTER', 2025, '14:00:00', '15:45:00', 'Tuesday', 13),

-- Summer 2025 Courses
(14, 15, 'SUMMER', 2025, '10:00:00', '11:45:00', 'Monday', 14),
(15, 16, 'SUMMER', 2025, '12:00:00', '13:45:00', 'Tuesday', 15),
(16, 17, 'SUMMER', 2025, '14:00:00', '15:45:00', 'Wednesday', 16),
(17, 18, 'SUMMER', 2025, '09:00:00', '10:45:00', 'Thursday', 17),
(18, 19, 'SUMMER', 2025, '13:00:00', '14:45:00', 'Friday', 18),
(19, 20, 'SUMMER', 2025, '15:00:00', '16:45:00', 'Monday', 19),
(20, 18, 'SUMMER', 2025, '11:00:00', '12:45:00', 'Wednesday', 20);


INSERT INTO course_registration (student_id, course_offered_id)
VALUES (1, 7),
       (2, 10),
       (3, 15),
       (4, 20),
       (5, 3),
       (6, 8),
       (7, 12),
       (8, 17),
       (9, 2),
       (10, 6),
       (11, 11),
       (12, 14),
       (13, 18),
       (14, 1),
       (15, 4),
       (16, 7),
       (17, 9),
       (18, 13),
       (19, 16);
INSERT INTO timetable (courses_offered_id, class_date)
VALUES (1, '2025-01-10'),
       (1, '2025-01-17'),
       (1, '2025-01-24'),
       (2, '2025-02-05'),
       (2, '2025-02-12'),
       (2, '2025-02-19'),
       (3, '2025-03-08'),
       (3, '2025-03-15'),
       (3, '2025-03-22'),
       (4, '2025-04-01'),
       (4, '2025-04-08'),
       (4, '2025-04-15'),
       (5, '2025-05-10'),
       (5, '2025-05-17'),
       (5, '2025-05-24'),
       (6, '2025-06-05'),
       (6, '2025-06-12'),
       (6, '2025-06-19'),
       (7, '2025-07-01'),
       (7, '2025-07-08');


INSERT INTO attendance (student_id, timetable_id, is_present)
VALUES (1, 1, TRUE),
       (1, 2, TRUE),
       (1, 3, FALSE),
       (2, 4, TRUE),
       (2, 5, FALSE),
       (2, 6, TRUE),
       (3, 7, TRUE),
       (3, 8, FALSE),
       (3, 9, TRUE),
       (4, 10, TRUE),
       (4, 11, TRUE),
       (4, 12, FALSE),
       (5, 13, FALSE),
       (5, 14, TRUE),
       (5, 15, TRUE),
       (6, 16, TRUE),
       (6, 17, FALSE),
       (6, 18, TRUE),
       (7, 19, TRUE),
       (7, 20, FALSE);

