-- Creating ENUM types
CREATE TYPE semester_enum AS ENUM ('FALL', 'WINTER', 'SUMMER');
CREATE TYPE program_level_enum AS ENUM ('UG', 'PG', 'DR.', 'Asso.');
CREATE TYPE student_gender_enum AS ENUM ('Female', 'Male', 'Other');
CREATE TYPE staff_designation_enum AS ENUM ('President', 'Vice President', 'Dean', 'Professor', 'Vice Professor', 'Instructor');

-- Students Table
CREATE TABLE students
(
    id                SERIAL PRIMARY KEY,
    name              VARCHAR(255)        NOT NULL,
    gender            student_gender_enum NOT NULL,
    email_id          VARCHAR(255) UNIQUE NOT NULL,
    password          VARCHAR(255)        NOT NULL,
    personal_email_id VARCHAR(255) UNIQUE,
    joining_term      semester_enum       NOT NULL,
    joining_year      INT                 NOT NULL,
    phone_number      VARCHAR(20) UNIQUE,
    nationality       VARCHAR(100)        NOT NULL
);

-- Student Address Table
CREATE TABLE student_address
(
    id         SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (id) ON DELETE CASCADE,
    street     VARCHAR(255),
    aptno      VARCHAR(50),
    city       VARCHAR(100),
    state      VARCHAR(100),
    country      VARCHAR(100),
    is_permanent      BOOLEAN,
    is_current     BOOLEAN,
    zip        VARCHAR(20)
);

-- Staff Table
CREATE TABLE staff
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255)        NOT NULL,
    gender      student_gender_enum NOT NULL,
    designation staff_designation_enum NOT NULL
);

-- Staff Address Table
CREATE TABLE staff_address
(
    id       SERIAL PRIMARY KEY,
    staff_id INT REFERENCES staff (id) ON DELETE CASCADE,
    street   VARCHAR(255),
    aptno    VARCHAR(50),
    city     VARCHAR(100),
    state    VARCHAR(100),
    zip      VARCHAR(20)
);

-- College Table
CREATE TABLE college
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    president_id INT REFERENCES staff (id) ON DELETE SET NULL
);

-- Department Table
CREATE TABLE department
(
    id         SERIAL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    dean_id    INT REFERENCES staff (id) ON DELETE SET NULL,
    college_id INT REFERENCES college (id) ON DELETE CASCADE
);

-- Programs Table
CREATE TABLE programs
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(255)       NOT NULL,
    level         program_level_enum NOT NULL,
    department_id INT REFERENCES department (id) ON DELETE CASCADE
);

-- Courses Table
CREATE TABLE courses
(
    id            SERIAL PRIMARY KEY,
    department_id INT REFERENCES department (id) ON DELETE CASCADE,
    course_code   VARCHAR(50) UNIQUE NOT NULL,
    name          VARCHAR(255)       NOT NULL,
    credits       INT                NOT NULL,
    total_hours   INT                NOT NULL,
    pre_requisite INT REFERENCES courses (id) ON DELETE SET NULL
);

-- Program Registration Table
CREATE TABLE program_registration
(
    student_id INT REFERENCES students (id) ON DELETE CASCADE,
    program_id INT REFERENCES programs (id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, program_id)
);

-- Department Staff Table
CREATE TABLE department_staff
(
    department_id INT REFERENCES department (id) ON DELETE CASCADE,
    staff_id      INT REFERENCES staff (id) ON DELETE CASCADE,
    PRIMARY KEY (department_id, staff_id)
);

-- Classrooms Table
CREATE TABLE classrooms
(
    id          SERIAL PRIMARY KEY,
    room_number VARCHAR(50) UNIQUE NOT NULL,
    max_acc     INT                NOT NULL
);

-- Courses Offered Table
CREATE TABLE courses_offered
(
    id            SERIAL PRIMARY KEY,
    course_id     INT REFERENCES courses (id) ON DELETE CASCADE,
    lectured_by   INT REFERENCES staff (id) ON DELETE SET NULL,
    semester      semester_enum NOT NULL,
    year          INT           NOT NULL,
    start_time    TIME          NOT NULL,
    end_time      TIME          NOT NULL,
    day_of_week   VARCHAR(20)   NOT NULL,
    class_room_id INT REFERENCES classrooms (id) ON DELETE SET NULL
);

-- Course Registration Table
CREATE TABLE course_registration
(
    id                SERIAL PRIMARY KEY,
    student_id        INT REFERENCES students (id) ON DELETE CASCADE,
    course_offered_id INT REFERENCES courses_offered (id) ON DELETE CASCADE
);

-- Timetable Table
CREATE TABLE timetable
(
    id                 SERIAL PRIMARY KEY,
    courses_offered_id INT REFERENCES courses_offered (id) ON DELETE CASCADE,
    class_date         DATE NOT NULL
);

-- Attendance Table
CREATE TABLE attendance
(
    id           SERIAL PRIMARY KEY,
    student_id   INT REFERENCES students (id) ON DELETE CASCADE,
    timetable_id INT REFERENCES timetable (id) ON DELETE CASCADE,
    is_present   BOOLEAN NOT NULL
);
