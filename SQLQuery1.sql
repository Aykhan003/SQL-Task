USE PA303TASK

--DROP TABLE Students

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL
)

CREATE TABLE Colors(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL
)


CREATE TABLE Products(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Cost DECIMAL(10,2) NOT NULL,
CategoryId INT NOT NULL,
FOREIGN KEY (CategoryId)
REFERENCES Categories(Id)
)

CREATE TABLE ProductColors(
ProductId INT NOT NULL,
ColorId INT NOT NULL,
PRIMARY KEY (ProductId, ColorId),
FOREIGN KEY (ProductId)
REFERENCES Products(Id),
FOREIGN KEY (ColorId)
REFERENCES Colors(Id)
)

SELECT
Products.Name,
Products.Price,
Products.Cost,
Categories.Name [Category Name],
Colors.Name [Color Name]
FROM Products
JOIN Categories
ON Products.CategoryId = Categories.Id
JOIN ProductColors
ON Products.Id = ProductColors.ProductId
JOIN Colors
ON ProductColors.ColorId = Colors.Id
--DROP TABLE Products