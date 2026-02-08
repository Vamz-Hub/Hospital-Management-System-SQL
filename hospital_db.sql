
-- Hospital Management System (MySQL)


-- Create Database
CREATE DATABASE hospital_db;
USE hospital_db;


-- Patients Table

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 0),
    gender VARCHAR(10),
    phone VARCHAR(15) UNIQUE
);


-- Doctors Table

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    consultation_fee INT CHECK (consultation_fee > 0)
);


-- Appointments Table

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Bills Table

CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    bill_amount INT CHECK (bill_amount > 0),
    payment_status VARCHAR(20),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);


-- Insert Sample Data


-- Patients
INSERT INTO patients (patient_name, age, gender, phone) VALUES
('Ravi Kumar', 30, 'Male', '9876543210'),
('Anita Sharma', 25, 'Female', '9876543222'),
('Suresh Rao', 45, 'Male', '9876543333');

-- Doctors
INSERT INTO doctors (doctor_name, specialization, consultation_fee) VALUES
('Dr. Mehta', 'Cardiology', 800),
('Dr. Priya', 'Dermatology', 500);

-- Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-02-01', 'Completed'),
(2, 2, '2025-02-02', 'Pending'),
(3, 1, '2025-02-03', 'Completed');

-- Bills
INSERT INTO bills (appointment_id, bill_amount, payment_status) VALUES
(1, 2000, 'Paid'),
(2, 500, 'Unpaid'),
(3, 2500, 'Paid');


-- CONDITIONAL LOGIC (CASE)

SELECT 
    bill_id,
    bill_amount,
    CASE
        WHEN bill_amount >= 2000 THEN 'High Bill'
        WHEN bill_amount >= 1000 THEN 'Medium Bill'
        ELSE 'Low Bill'
    END AS bill_category
FROM bills;


-- NESTED SUBQUERY

-- Patients who consulted Cardiology doctor
SELECT patient_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    WHERE doctor_id = (
        SELECT doctor_id
        FROM doctors
        WHERE specialization = 'Cardiology'
    )
);


-- JOIN QUERY (Report)

-- Pending appointments
SELECT 
    p.patient_name,
    d.doctor_name,
    a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Pending';


-- AGGREGATE FUNCTION

-- Total revenue collected
SELECT SUM(bill_amount) AS total_revenue
FROM bills
WHERE payment_status = 'Paid';