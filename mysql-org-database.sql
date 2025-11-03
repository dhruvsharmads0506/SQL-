/* ==========================================================
   🏢 ORGANIZATION DATABASE PROJECT
   Author: Dhruv Sharma
   Description: MySQL script to create and populate the ORG database
   Tables: Worker, Bonus, Title
   ========================================================== */

/* ----------------------------------------------------------
   1️⃣ CREATE DATABASE AND SELECT IT
   ---------------------------------------------------------- */
CREATE DATABASE ORG;              -- Create a new database named ORG
SHOW DATABASES;                   -- List all available databases
USE ORG;                          -- Switch to the ORG database

/* ----------------------------------------------------------
   2️⃣ CREATE TABLE: WORKER
   ----------------------------------------------------------
   Stores employee details such as name, salary, joining date,
   and department.
   ---------------------------------------------------------- */
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each worker
    FIRST_NAME CHAR(25),                                -- Employee first name
    LAST_NAME CHAR(25),                                 -- Employee last name
    SALARY INT,                                         -- Employee salary
    JOINING_DATE DATETIME,                              -- Date and time of joining
    DEPARTMENT CHAR(25)                                 -- Department name
);

-- ✅ View table structure
DESC Worker;

/* ----------------------------------------------------------
   3️⃣ INSERT DATA INTO WORKER
   ----------------------------------------------------------
   Note: Using standard date format 'YYYY-MM-DD HH:MM:SS'
   ---------------------------------------------------------- */
INSERT INTO Worker (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
('Monika',  'Arora',  100000, '2014-02-20 09:00:00', 'HR'),
('Niharika','Verma',   80000, '2014-06-11 09:00:00', 'Admin'),
('Vishal',  'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
('Amitabh', 'Singh',  500000, '2014-02-20 09:00:00', 'Admin'),
('Vivek',   'Bhati',  500000, '2014-06-11 09:00:00', 'Admin'),
('Vipul',   'Diwan',  200000, '2014-06-11 09:00:00', 'Account'),
('Satish',  'Kumar',   75000, '2014-01-20 09:00:00', 'Account'),
('Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');

-- ✅ View all records in Worker
SELECT * FROM Worker;

/* ----------------------------------------------------------
   4️⃣ CREATE TABLE: BONUS
   ----------------------------------------------------------
   Stores bonus details for each worker.
   Has a foreign key referencing Worker(WORKER_ID).
   ---------------------------------------------------------- */
CREATE TABLE Bonus (
    WORKER_REF_ID INT,                                -- References Worker table
    BONUS_AMOUNT INT,                                 -- Amount of bonus
    BONUS_DATE DATETIME,                              -- Date bonus was given
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE                             -- Delete bonus when worker is deleted
);

-- ✅ View table structure
DESCRIBE Bonus;

/* ----------------------------------------------------------
   5️⃣ INSERT DATA INTO BONUS
   ---------------------------------------------------------- */
INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(1, 5000, '2016-02-20 00:00:00'),
(2, 3000, '2016-06-11 00:00:00'),
(3, 4000, '2016-02-20 00:00:00'),
(1, 4500, '2016-02-20 00:00:00'),
(2, 3500, '2016-06-11 00:00:00');

-- ✅ View all records in Bonus
SELECT * FROM Bonus;

/* ----------------------------------------------------------
   6️⃣ CREATE TABLE: TITLE
   ----------------------------------------------------------
   Stores job titles of workers.
   Has a foreign key referencing Worker(WORKER_ID).
   ---------------------------------------------------------- */
CREATE TABLE Title (
    WORKER_REF_ID INT,                                -- References Worker table
    WORKER_TITLE CHAR(25),                            -- Job title
    AFFECTED_FROM DATETIME,                           -- Effective date
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- ✅ Insert sample data into Title
INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
(1, 'Manager',        '2016-02-20 00:00:00'),
(2, 'Executive',      '2016-06-11 00:00:00'),
(8, 'Executive',      '2016-06-11 00:00:00'),
(5, 'Manager',        '2016-06-11 00:00:00'),
(4, 'Asst. Manager',  '2016-06-11 00:00:00'),
(7, 'Executive',      '2016-06-11 00:00:00'),
(6, 'Lead',           '2016-06-11 00:00:00'),
(3, 'Lead',           '2016-06-11 00:00:00');

-- ✅ View all records in Title
SELECT * FROM Title;

/* ----------------------------------------------------------
   7️⃣ VIEW ALL TABLES IN DATABASE
   ---------------------------------------------------------- */
SHOW TABLES;

/* ----------------------------------------------------------
   8️⃣ OPTIONAL: SAMPLE JOINS (FOR REVISION)
   ----------------------------------------------------------
   Join examples to connect Worker, Bonus, and Title tables
   ---------------------------------------------------------- */

-- 🔹 List workers with their bonus amounts
SELECT W.FIRST_NAME, W.DEPARTMENT, B.BONUS_AMOUNT, B.BONUS_DATE
FROM Worker W
JOIN Bonus B ON W.WORKER_ID = B.WORKER_REF_ID;

-- 🔹 List workers with their titles
SELECT W.FIRST_NAME, W.LAST_NAME, T.WORKER_TITLE, T.AFFECTED_FROM
FROM Worker W
JOIN Title T ON W.WORKER_ID = T.WORKER_REF_ID;

-- 🔹 List all information combined (Worker + Bonus + Title)
SELECT W.FIRST_NAME, W.LAST_NAME, W.DEPARTMENT, T.WORKER_TITLE, B.BONUS_AMOUNT
FROM Worker W
LEFT JOIN Title T ON W.WORKER_ID = T.WORKER_REF_ID
LEFT JOIN Bonus B ON W.WORKER_ID = B.WORKER_REF_ID;

/* ==========================================================
   ✅ END OF SCRIPT
   ========================================================== */
