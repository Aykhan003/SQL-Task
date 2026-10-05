CREATE DATABASE Spotify
USE Spotify

CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(80) NOT NULL,
Surname NVARCHAR(100) NOT NULL,
Username NVARCHAR(50) NOT NULL UNIQUE,
Password VARCHAR(120) CHECK(LEN(Password) >= 8),
Gender VARCHAR (10) CHECK(Gender='Male' OR Gender='Female' OR Gender='Others')
)

CREATE TABLE Artists(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(80) NOT NULL,
Surname NVARCHAR(100) NOT NULL,
Birthday DATE NOT NULL,
Gender VARCHAR (10) CHECK(Gender='Male' OR Gender='Female' OR Gender='Others')
)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(80) NOT NULL UNIQUE
)

CREATE TABLE Musics(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(80) NOT NULL,
Duration INT NOT NULL CHECK(Duration > 0),
ArtistId INT NOT NULL,
CategoryId INT NOT NULL,
FOREIGN KEY (ArtistId) REFERENCES Artists(Id),
FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
)

CREATE TABLE Playlist(
UserId INT NOT NULL,
MusicId INT NOT NULL,
PRIMARY KEY (UserId, MusicId),
FOREIGN KEY (UserId) REFERENCES Users(Id),
FOREIGN KEY (MusicId) REFERENCES Musics(Id)
)

CREATE VIEW InfoMusic
AS
SELECT Musics.Name AS MusicName,Musics.Duration,Categories.Name AS Category, Artists.Name AS ArtistName,Artists.Surname AS ArtistSurname
FROM Musics
JOIN Categories
ON Musics.CategoryId = Categories.Id
JOIN Artists
ON Musics.ArtistId = Artists.Id

CREATE VIEW MaxMusicCountbyArtist
AS
SELECT Artists.Id,Artists.Name,Artists.Surname, COUNT(Musics.Id) AS MusicCount
FROM Artists
JOIN Musics
ON Artists.Id = Musics.ArtistId
GROUP BY
Artists.Id,
Artists.Name,
Artists.Surname
HAVING COUNT(Musics.Id)=(
SELECT MAX(MusicCount)
FROM(
SELECT COUNT(*) AS MusicCount
FROM Musics
GROUP BY ArtistId) AS ArtistMusicCounts
)

SELECT *
FROM InfoMusic

SELECT * 
FROM MaxMusicCountbyArtist