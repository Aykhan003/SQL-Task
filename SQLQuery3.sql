CREATE TABLE Depots(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(100) NOT NULL UNIQUE,
City VARCHAR(50) NOT NULL UNIQUE,
Zipcode VARCHAR(20) NOT NULL UNIQUE)

CREATE TABLE Medicines(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(100) NOT NULL UNIQUE,
Manufacturer VARCHAR(200) NOT NULL,
Price DECIMAL (11,2) NOT NULL CHECK(Price >= 0),
)

CREATE TABLE Pharmacies(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
Zipcode VARCHAR(20) NOT NULL 
)

CREATE TABLE DepotMedicines(
Id INT PRIMARY KEY IDENTITY,
DepotId INT NOT NULL,
MedicineId INT NOT NULL,
Quantity INT NOT NULL, CHECK(Quantity >= 0),
FOREIGN KEY (DepotId) REFERENCES Depots(Id),
FOREIGN KEY (MedicineId) REFERENCES Medicines(Id)
)
CREATE TABLE PharmacyMedicines(
Id INT PRIMARY KEY IDENTITY,
PharmacyId INT NOT NULL,
MedicineId INT NOT NULL,
Quantity INT NOT NULL,
FOREIGN KEY (PharmacyId) REFERENCES Pharmacies(Id),
FOREIGN KEY (MedicineId) REFERENCES Medicines(Id)
)

SELECT m.Name AS [Derman adi], m.Price, m.Manufacturer, p.Name AS [Aptek], d.Name AS [Depo]
FROM Medicines AS m
JOIN PharmacyMedicines AS pm
ON m.Id=pm.MedicineId
JOIN Pharmacies AS p
ON p.Id=pm.PharmacyId
JOIN DepotMedicines AS dm
ON m.Id=dm.MedicineId
JOIN Depots AS d
ON dm.DepotId = d.Id
ORDER BY m.Name