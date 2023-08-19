CREATE DATABASE BookLibrary;
USE BookLibrary;

--Tạo bảng Book
CREATE TABLE Book(
BookCode INT PRIMARY KEY,
BookTitle VARCHAR(100) NOT NULL,
Author VARCHAR(50) NOT NULL,
Edition INT DEFAULT 1,
BookPrice MONEY DEFAULT 0.0,
);
ALTER TABLE Book
ADD Copies INT DEFAULT 0

--Tạo bảng Member
CREATE TABLE Member (
MemberCode INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Address VARCHAR(100) NOT NULL,
PhoneNumber BIGINT NOT NULL
);

-- Tạo bảng IssueDetails
CREATE TABLE IssueDetails (
BookCode INT,
MemberCode INT,
IssueDate DATETIME DEFAULT GETDATE(),
ReturnDate DATETIME,
CONSTRAINT FK_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
CONSTRAINT FK_Member FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode),
CONSTRAINT CK_IssueDate CHECK (IssueDate <= ReturnDate)
);

--Xóa bỏ ràng buộc khóa ngoại
ALTER TABLE IssueDetails
DROP CONSTRAINT FK_Book;

ALTER TABLE IssueDetails
DROP CONSTRAINT FK_Member;

--Xóa bỏ ràng buộc khóa chính Book và Member
ALTER TABLE Book

DROP CONSTRAINT PK__Book__0A5FFCC609DE7BCC;

ALTER TABLE Member
DROP CONSTRAINT PK__Member__84CA63760F975522;

--Thêm mới ràng buộc Khóa chính cho bảng Member
ALTER TABLE Member
ADD CONSTRAINT PK_MemberCode PRIMARY KEY (MemberCode);

--Thêm mới ràng buộc Khóa chính cho bảng Book
ALTER TABLE Book
ADD CONSTRAINT PK_BookCode PRIMARY KEY (BookCode);

--Thêm mới ràng buộc khóa ngoại cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT FK_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode);

ALTER TABLE IssueDetails
ADD CONSTRAINT FFK_Member FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode);

-- Thêm ràng buộc giá trị cho cột BookPrice trong bảng Book
ALTER TABLE Book
ADD CONSTRAINT CK_BookPriceRange CHECK (BookPrice > 0 AND BookPrice < 200);

-- Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
ALTER TABLE Member
ADD CONSTRAINT vn_phone_number UNIQUE (PhoneNumber);
--Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
ALTER TABLE IssueDetails
ALTER COLUMN BookCode INT NOT NULL;

ALTER TABLE IssueDetails
ALTER COLUMN MemberCode INT NOT NULL;

--Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT pk_issue_details PRIMARY KEY (BookCode, MemberCode);

-- Chèn dữ liệu hợp lý cho các bảng: IssueDetails, Member và Book(Sử dụng SQL) 
INSERT INTO Book(BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES(001, 'Làm đũy', 'Vũ Trọng Phụng', 02, 50, 10)

INSERT INTO Book(BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES(002, 'Làm người', 'Kimminh', 03, 51, 19)

INSERT INTO Book(BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES(003, 'Làm chó', 'Lukaku', 04, 50, 20)

INSERT INTO Book(BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES(004, 'Làm đế', 'Long Vip', 03, 22, 90)

INSERT INTO Book(BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES(005, 'Làm biếng', 'Kim Quang Minh', 02, 40, 10)
------------------------------------------------------------
INSERT INTO Member (MemberCode, Name, Address, PhoneNumber)
VALUES
    (1001, 'Alice Johnson', '123 Main St, City', 123456789),
    (1002, 'Bob Smith', '456 Park Ave, Town', 987654321),
    (1003, 'Eva Davis', '789 Broadway, Village', 555555555),
    (1004, 'Daniel Miller', '234 Elm Rd, County', 111111111),
    (1005, 'Olivia Wilson', '567 Oak Lane, State', 222222222);
--------------------------------------------------------------
INSERT INTO IssueDetails (BookCode, MemberCode, IssueDate, ReturnDate)
VALUES
    (1, 1001, '2023-08-01', '2023-08-15'),
    (2, 1002, '2023-08-02', '2023-08-18'),
    (3, 1003, '2023-08-03', '2023-08-20'),
    (4, 1004, '2023-08-04', '2023-08-17'),
    (5, 1005, '2023-08-05', '2023-08-22');