USE PA303TASK
CREATE TABLE Categories2(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) UNIQUE NOT NULL
)
CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(100) NOT NULL,
Price DECIMAL(6,2) CHECK(Price > 0),
CategoryId INT,

FOREIGN KEY (CategoryId) REFERENCES Categories2(Id)
)

CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
Surname VARCHAR(70) NOT NULL
)

Create TABLE BookAuthors(
BookId INT,
AuthorId INT,

PRIMARY KEY (BookId,AuthorId),
FOREIGN KEY (BookId) REFERENCES Books(Id),
FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)

SELECT Books.Name AS BookName, Books.Price AS BookPrice, Categories2.Name AS Category, Authors.Name AS AuthorName, Authors.Surname AS AuthorSurname
FROM Books
JOIN Categories2
ON Books.CategoryId = Categories2.Id
JOIN BookAuthors
ON Books.Id = BookAuthors.BookId
JOIN Authors
ON BookAuthors.AuthorId = Authors.Id