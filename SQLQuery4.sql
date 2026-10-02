USE PA303TASK

CREATE TABLE Students(
Id INT PRIMARY KEY IDENTITY,
FullName NVARCHAR(50) NOT NULL,
Age INT CHECK (Age > 16) NOT NULL,
)
CREATE TABLE Teachers(
Id INT PRIMARY KEY IDENTITY,
FullName NVARCHAR(50) NOT NULL,
[Subject] NVARCHAR(30) NOT NULL
)
CREATE TABLE Classes(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) UNIQUE NOT NULL,
RoomNumber INT UNIQUE NOT NULL
)
CREATE TABLE StudentClasses(
Id INT PRIMARY KEY IDENTITY,
StudentId INT UNIQUE NOT NULL,
ClassId INT UNIQUE NOT NULL,

FOREIGN KEY (StudentId) REFERENCES Students(Id),
FOREIGN KEY (ClassId) REFERENCES Classes(Id)
)
CREATE TABLE TeacherClasses(
Id INT PRIMARY KEY IDENTITY,
TeacherId INT UNIQUE NOT NULL,
ClassId INT UNIQUE NOT NULL,

FOREIGN KEY (TeacherId) REFERENCES Teachers(Id),
FOREIGN KEY (ClassId) REFERENCES Classes(Id)
)
SELECT Students.FullName, Classes.Name, Teachers.FullName, Teachers.Subject
FROM Students
JOIN StudentClasses
ON Students.Id = StudentClasses.StudentId
JOIN Classes
ON StudentClasses.ClassId = Classes.Id
JOIN TeacherClasses
ON Classes.Id = TeacherClasses.ClassId
JOIN Teachers
ON TeacherClasses.TeacherId = Teachers.Id
