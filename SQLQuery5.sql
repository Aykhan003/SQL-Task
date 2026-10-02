CREATE DATABASE LAB8
USE LAB8

CREATE TABLE Patients(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(25) NOT NULL,
BirthDate DATETIME2 CHECK (BirthDate < GETDATE()),
Email VARCHAR(254) NOT NULL UNIQUE)

CREATE TABLE Departments(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(40) NOT NULL UNIQUE)

CREATE TABLE Doctors(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR (25) NOT NULL,
Experience INT CHECK (Experience > 0)
)

INSERT INTO Patients (FirstName,LastName,BirthDate,Email)
VALUES
('Ayxan', 'Bayramov', '11-09-2000', 'test@gmail.com'),
('Resad', 'Memmedli', '07-10-2003', 'test1@gmail.com'),
('Hebib', 'Orxanzade', '04-08-2004', 'test2@gmail.com')

INSERT INTO Departments (Name)
VALUES
('Beyin'),
('Bogaz'),
('Urek')

INSERT INTO Doctors (FirstName,LastName,Experience)
VALUES
('Ferid', 'Feridov', 6),
('Zulfuqar', 'Zulfuqarov', 10),
('Rasul', 'Rasulov', 12)

CREATE TABLE DoctorDepartments(
DoctorId INT ,
DepartmentId INT,
PRIMARY KEY (DoctorId, DepartmentId),

FOREIGN KEY (DoctorId) REFERENCES Doctors(Id),
FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
)

CREATE TABLE PatientDoctors(
PatientId INT,
DoctorId INT,
CheckupDate DATETIME2 NOT NULL,
CheckupResult NVARCHAR(500),

PRIMARY KEY (PatientId, DoctorId, CheckupDate),

FOREIGN KEY (PatientId) REFERENCES Patients(Id),
FOREIGN KEY (DoctorId) REFERENCES Doctors(Id)
)


CREATE TABLE Medicines(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(70) NOT NULL UNIQUE
)

CREATE TABLE PatientDoctorMedicines(
PatientId INT NOT NULL,
DoctorId INT NOT NULL,
CheckupDate DATETIME2 NOT NULL,
MedicineId INT NOT NULL,

PRIMARY KEY (PatientId,DoctorId,CheckupDate,MedicineId),

FOREIGN KEY (PatientId,DoctorId,CheckupDate) REFERENCES PatientDoctors(PatientId,DoctorId,CheckupDate),
FOREIGN KEY (MedicineId) REFERENCES Medicines(Id)
)

SELECT Doctors.Id, Doctors.FirstName + ' ' + Doctors.LastName AS Doctor, COUNT ( PatientDoctors.PatientId ) AS AppointmentCount
FROM Doctors
LEFT JOIN PatientDoctors
ON Doctors.Id = PatientDoctors.DoctorId
GROUP BY
Doctors.Id,
Doctors.FirstName,
Doctors.LastName

SELECT Departments.Name AS Department, COUNT (DoctorDepartments.DoctorId) AS DoctorCount
FROM Departments
JOIN DoctorDepartments
ON Departments.Id = DoctorDepartments.DepartmentId
GROUP BY
Departments.Id, Departments.Name

--SELECT Doctors.FirstName, Doctors.LastName, Departments.Name AS Department
--FROM Doctors
--JOIN DoctorDepartments
--ON Doctors.Id = DoctorDepartments.DoctorId
--JOIN Departments
--ON DoctorDepartments.DepartmentId = Departments.Id

--SELECT Patients.FirstName + ' ' + Patients.LastName AS Patient, Doctors.FirstName + ' ' + Doctors.LastName AS Doctor,
--PatientDoctors.CheckupDate, PatientDoctors.CheckupResult
--FROM Patients
--JOIN PatientDoctors
--ON Patients.Id = PatientDoctors.PatientId
--JOIN Doctors
--ON PatientDoctors.DoctorId = Doctors.Id

--SELECT PatientDoctors.CheckupDate, Doctors.FirstName + ' ' + Doctors.LastName AS Doctor, PatientDoctors.CheckupResult
--FROM PatientDoctors
--JOIN Doctors
--ON PatientDoctors.DoctorId = Doctors.Id
--Where PatientDoctors.PatientId = 1

--SELECT Patients.FirstName + ' ' + Patients.LastName AS Patient, PatientDoctors.CheckupDate
--FROM PatientDoctors
--JOIN Patients
--ON PatientDoctors.PatientId = Patients.Id
--WHERE PatientDoctors.DoctorId = 1
--AND PatientDoctors.CheckupDate >= GETDATE()
--AND PatientDoctors.CheckupDate < DATEADD(DAY, 1, GETDATE())