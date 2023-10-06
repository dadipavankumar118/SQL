DROP DATABASE IF EXISTS library;
CREATE DATABASE IF NOT EXISTS library;
USE library;

CREATE TABLE IF NOT EXISTS publisher(
PublisherName VARCHAR(45) NOT NULL,
PublisherAddress VARCHAR(100),
PublisherPhone VARCHAR(20),
PRIMARY KEY (PublisherName));

SELECT *
FROM publisher;

CREATE TABLE IF NOT EXISTS books (
BookID INT NOT NULL AUTO_INCREMENT,
Title VARCHAR(60),
PublisherName VARCHAR(45),
PRIMARY KEY (BookID),
FOREIGN KEY (PublisherName)
REFERENCES publisher (PublisherName)
ON DELETE CASCADE
ON UPDATE CASCADE);

SELECT *
FROM books;

CREATE TABLE IF NOT EXISTS authors(
AuthorID INT NOT NULL AUTO_INCREMENT,
BookID INT,
AuthorName VARCHAR(45),
PRIMARY KEY (AuthorID),
FOREIGN KEY (BookID)
REFERENCES books (BookID)
ON DELETE CASCADE
ON UPDATE CASCADE);

SELECT *
FROM authors;

CREATE TABLE IF NOT EXISTS library_branch(
BranchID INT NOT NULL AUTO_INCREMENT,
BranchName VARCHAR(45),
BranchAddress VARCHAR(45),
PRIMARY KEY (BranchID));

SELECT *
FROM library_branch;

CREATE TABLE IF NOT EXISTS book_copies(
CopiesID INT NOT NULL AUTO_INCREMENT,
BookID INT,
BranchID INT,
No_Of_Copies INT,
PRIMARY KEY (CopiesID),
FOREIGN KEY (BookID)
REFERENCES books (BookID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (BranchID)
REFERENCES library_branch(BranchID)
ON DELETE CASCADE
ON UPDATE CASCADE);

SELECT *
FROM book_copies;

CREATE TABLE IF NOT EXISTS borrower(
CardNo INT NOT NULL AUTO_INCREMENT,
BorrowerName VARCHAR(45),
BorrowerAddress VARCHAR(50),
BorrowerPhone VARCHAR(20),
PRIMARY KEY (CardNo));

SELECT *
FROM borrower;

CREATE TABLE IF NOT EXISTS book_loans (
LoanID INT NOT NULL AUTO_INCREMENT,
BookID INT,
BranchID INT,
CardNo INT,
DateOut DATE,
DueDate DATE,
PRIMARY KEY (LoanID),
FOREIGN KEY (BookID)
REFERENCES books (BookID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (BranchID)
REFERENCES library_branch (BranchID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (CardNo)
REFERENCES borrower(CardNo)
ON DELETE CASCADE
ON UPDATE CASCADE);

SELECT *
FROM book_loans;

/*  1.	How many copies of the book titled "The Lost Tribe" 
are owned by the library branch whose name is "Sharpstown"?*/
SELECT books.Title,library_branch.BranchName,book_copies.No_Of_Copies
FROM books
INNER JOIN book_copies
ON books.BookID = book_copies.BookID
INNER JOIN library_branch
ON book_copies.BranchID = library_branch.BranchID
WHERE library_branch.BranchName = 'Sharpstown' AND books.Title = 'The Lost Tribe';

/*  2.	How many copies of the book titled "The Lost Tribe" 
are owned by each library branch?*/
SELECT books.Title,library_branch.BranchName,book_copies.No_Of_Copies
FROM books
INNER JOIN book_copies
ON books.BookID = book_copies.BookID
INNER JOIN library_branch
ON book_copies.BranchID = library_branch.BranchID
WHERE books.Title = 'The Lost Tribe';

/*  3.	Retrieve the names of all borrowers who do not have any books checked out.*/
SELECT borrower.BorrowerName
FROM borrower
LEFT JOIN book_loans
ON book_loans.CardNo = borrower.CardNo
WHERE book_loans.BookID IS NULL;

/*  4.	For each book that is loaned out from the "Sharpstown" 
branch and whose DueDate is 2/3/18, retrieve the book title, 
the borrower's name, and the borrower's address. */
SELECT books.Title,borrower.BorrowerName,borrower.BorrowerAddress,book_loans.DueDate
FROM books
INNER JOIN book_loans
ON books.BookID = book_loans.BookID
INNER JOIN library_branch
ON library_branch.BranchID = book_loans.BranchID
INNER JOIN borrower
ON borrower.CardNo = book_loans.CardNo
WHERE library_branch.BranchName = 'Sharpstown' AND DueDate = '2018-02-03';

/*  5.	For each library branch, retrieve the branch name 
and the total number of books loaned out from that branch.*/
SELECT library_branch.BranchName,count(book_loans.BookID) AS No_Of_Books
FROM book_loans
INNER JOIN library_branch
ON book_loans.BranchID = library_branch.BranchID
GROUP BY library_branch.BranchName;

/*  6.	Retrieve the names, addresses, and number of books checked 
out for all borrowers who have more than five books checked out.*/
SELECT borrower.BorrowerName,borrower.BorrowerAddress,count(book_loans.BookID) AS No_Of_Books_Checkedout
FROM borrower
INNER JOIN book_loans
ON book_loans.CardNo = borrower.CardNo
GROUP BY borrower.BorrowerName,borrower.BorrowerAddress
HAVING No_Of_Books_Checkedout > 5;

/*  7.	For each book authored by "Stephen King", retrieve the title 
and the number of copies owned by the library branch whose name is "Central".*/
SELECT books.Title,book_copies.No_Of_Copies,authors.AuthorName,library_branch.BranchName
FROM authors
INNER JOIN books
ON books.BookID = authors.BookID
INNER JOIN book_copies
ON book_copies.BookID = authors.BookID
INNER JOIN library_branch
ON book_copies.BranchID = library_branch.BranchID
WHERE authors.AuthorName = 'Stephen King' AND library_branch.BranchName = 'Central';