-- Create Database
CREATE DATABASE Libraryd;
USE Libraryd;

-- Create Tables
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Publisher VARCHAR(100),
    Price DECIMAL(8,2),
    Quantity INT,
    ISBN VARCHAR(20)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE IssuedBooks (
    IssueID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Table for Trigger Logging
CREATE TABLE log_table (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

-- Insert Data into Books (with column names)
INSERT INTO Books (BookID, Title, Author, Publisher, Price, Quantity, ISBN) VALUES
(1, 'SQL Basics', 'John Smith', 'TechPress', 500.00, 10, 'ISBN12345'),
(2, 'Advanced SQL', 'John Smith', 'TechPress', 650.00, 8, 'ISBN12346'),
(3, 'Database Design', 'Alice Johnson', 'DBBooks', 450.00, 15, 'ISBN12347'),
(4, 'Python Programming', 'David Clark', 'CodeHouse', 700.00, 5, 'ISBN12348'),
(5, 'Java for Beginners', 'John Smith', 'CodeHouse', 600.00, 7, 'ISBN12349'),
(6, 'Data Structures', 'Alice Johnson', 'TechWorld', 550.00, 6, 'ISBN12350');

-- Insert Data into Members (with column names)
INSERT INTO Members (MemberID, Name, Email, Phone, Address) VALUES
(1, 'Ram', 'ram@gmail.com', '9876543210', 'Hyderabad'),
(2, 'Nithin', 'nithin@gmail.com', '9876501234', 'Chennai'),
(3, 'Yash', 'yash@gmail.com', '9876598765', 'Bangalore');

-- Insert Data into IssuedBooks
INSERT INTO IssuedBooks (IssueID, BookID, MemberID, IssueDate, ReturnDate) VALUES
(1, 1, 1, '2025-08-10', '2025-08-17'),
(2, 4, 2, '2025-08-11', '2025-08-18'),
(3, 2, 3, '2025-08-12', '2025-08-19');

-- Update & Delete
UPDATE Books SET Quantity = 12 WHERE BookID = 1;
DELETE FROM Members WHERE MemberID = 4;

-- Queries
SELECT * FROM Books WHERE Price > 300;
SELECT COUNT(*) AS TotalBooks FROM Books;
SELECT AVG(Price) AS AvgPrice FROM Books;
SELECT Author, COUNT() AS BookCount FROM Books GROUP BY Author HAVING COUNT() > 1;
SELECT * FROM Books WHERE Title LIKE '%SQL%';
SELECT * FROM Books WHERE Price = (SELECT MAX(Price) FROM Books);

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE GetBookDetails()
BEGIN
    SELECT * FROM Books;
END //
DELIMITER ;

-- Trigger
DELIMITER //
CREATE TRIGGER after_book_insert
AFTER INSERT ON Books
FOR EACH ROW
BEGIN
    INSERT INTO log_table (message) VALUES ('New book added');
END //
DELIMITER ;