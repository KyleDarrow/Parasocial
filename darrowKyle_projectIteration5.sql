--TABLES
--Create table Landmarks
CREATE TABLE Landmarks(
LandmarkID DECIMAL(12) NOT NULL PRIMARY KEY,
LandmarkName VARCHAR(140) NOT NULL);

--Create table City
CREATE TABLE City(
CityID DECIMAL(12) NOT NULL PRIMARY KEY,
CityName VARCHAR(140) NOT NULL,
LarkmarkID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Landmarks(LandmarkID));

--Create table Passwords
CREATE TABLE Passwords(
PasswordID DECIMAL(12) NOT NULL PRIMARY KEY,
Password VARCHAR(50) NOT NULL);

--Create table Account
CREATE TABLE Account(
AccountID DECIMAL(12) NOT NULL PRIMARY KEY,
AccountName VARCHAR(50) NOT NULL,
Email VARCHAR(255) NOT NULL,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
AccountDate DATE NOT NULL,
AccountType CHAR(1) NOT NULL);

--Create table Location
CREATE TABLE Location(
LocationID DECIMAL(12) NOT NULL PRIMARY KEY,
CityID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES City(CityID));

--Create table Tag
CREATE TABLE Tag(
TagID DECIMAL(12) NOT NULL PRIMARY KEY,
TaggedUser VARCHAR(50) NOT NULL);

--Create table Photo
CREATE TABLE Photo(
PhotoID DECIMAL(12) NOT NULL PRIMARY KEY,
LocationID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Location(LocationID),
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID),
PhotoDescription VARCHAR(1000) NULL,
UploadDate DATE NOT NULL,
TagID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Tag(TagID),
Comments VARCHAR(144) NULL,
Likes DECIMAL(12) NULL);

--Create table Verified
CREATE TABLE Verified(
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID));

--Create table Normal
CREATE TABLE Normal(
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID));

--Create table AccountLocation
CREATE TABLE AccountLocation(
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID),
LocationID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Location(LocationID));

--Create table Search
CREATE TABLE Search(
SearchID DECIMAL(20) NOT NULL PRIMARY KEY,
SearchDate DATE NOT NULL,
SearchName VARCHAR(50) NOT NULL);

--Create table AccountSearch
CREATE TABLE AccountSearch(
SearchID DECIMAL(20) NOT NULL FOREIGN KEY REFERENCES Search(SearchID),
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID));

--Create table Filter
CREATE TABLE Filter(
FilterID DECIMAL(12) NOT NULL PRIMARY KEY,
FilterType VARCHAR(50) NOT NULL);

--Create table Video
CREATE TABLE Video(
VideoID DECIMAL(12) NOT NULL PRIMARY KEY,
FilterID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Filter(FilterID),
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID),
UploadDate DATE NOT NULL);

--Create table Rating
CREATE TABLE Rating(
RatingID DECIMAL(12) NOT NULL PRIMARY KEY,
VideoID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Video(VideoID),
VideoRating DECIMAL(3) NOT NULL,
DateRated DATE NOT NULL,
UserRated VARCHAR(50) NOT NULL);

--Create table Interaction
CREATE TABLE Interaction(
InteractionID DECIMAL(12) NOT NULL PRIMARY KEY,
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID),
InteractionType VARCHAR(20) NOT NULL,
IneractionDate DATE NOT NULL);

--Create table Question
CREATE TABLE Question(
QuestionID DECIMAL(12) NOT NULL PRIMARY KEY,
AccountID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Account(AccountID),
QuestionType VARCHAR(4) NOT NULL,
QuestionDate DATE NOT NULL);

--Create table ApplicationQ
CREATE TABLE ApplicationQ(
QuestionID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Question(QuestionID),
Question VARCHAR(255) NOT NULL);

--Create table Asker
CREATE TABLE Asker(
AskID DECIMAL(12) NOT NULL PRIMARY KEY,
AskingUser VARCHAR(50) NOT NULL);

--Create table UserQ
CREATE TABLE UserQ(
QuestionID DECIMAL(12) NOT NULL PRIMARY KEY,
AskID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Asker(AskID),
Question VARCHAR(255) NOT NULL);

--Create table Answer
CREATE TABLE Answer(
AnswerID DECIMAL(12) NOT NULL PRIMARY KEY,
QuestionID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Question(QuestionID),
AnswerType VARCHAR(6) NOT NULL,
AnswerDate DATE NOT NULL);

--Create table VerbalResponse
CREATE TABLE VerbalResponse(
AnswerID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Answer(AnswerID),
Answer VARCHAR(1000) NOT NULL);

--Create table TextResponse
CREATE TABLE TextResponse(
AnswerID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Answer(AnswerID),
Answer VARCHAR(1000) NOT NULL);

--Create table AIResponse
CREATE TABLE AIResponse(
AnswerID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Answer(AnswerID),
Answer VARCHAR(1000) NOT NULL);

-- Create table AnswerChange
CREATE TABLE AnswerChange(
AnswerChangeID DECIMAL(12) NOT NULL PRIMARY KEY,
OldAnswer VARCHAR(1000) NOT NULL,
NewAnswer VARCHAR(1000) NOT NULL,
AnswerID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Answer(AnswerID),
DateChanged DATE NOT NULL);

--SEQUENCES
CREATE SEQUENCE city_seq START WITH 1;
CREATE SEQUENCE landmark_seq START WITH 1;
CREATE SEQUENCE location_seq START WITH 1;
CREATE SEQUENCE account_seq START WITH 1;
CREATE SEQUENCE photo_seq START WITH 1;
CREATE SEQUENCE tag_seq START WITH 1;
CREATE SEQUENCE video_seq START WITH 1;
CREATE SEQUENCE rating_seq START WITH 1;
CREATE SEQUENCE interaction_seq START WITH 1;
CREATE SEQUENCE answer_seq START WITH 1;
CREATE SEQUENCE question_seq START WITH 1;
CREATE SEQUENCE asker_seq START WITH 1;
CREATE SEQUENCE filter_seq START WITH 1;
CREATE SEQUENCE answerchange_seq START WITH 1;

--INDEXES
-- First index from query 1.
CREATE INDEX AccountNameIdx
ON Account(AccountName);

-- First index from query 2.
CREATE INDEX UserQuestionIdx
ON UserQ(Question);

-- First index from query 1.
CREATE INDEX AccountCreationIdx
ON Account(AccountDate);

--STORED PROCEDURES
--Stored procedure that adds a normal account to Account and Normal tables.
CREATE PROCEDURE AddNormalAccount
	@AccountName VARCHAR(50),
	@Email VARCHAR(255),
	@FirstName VARCHAR(255),
	@LastName VARCHAR(255)
AS
BEGIN
	DECLARE @account_seq INT = NEXT VALUE FOR account_seq
	INSERT INTO Account(AccountID, AccountName, Email, FirstName, LastName, AccountDate, AccountType)
	VALUES(@account_seq, @AccountName, @Email, @FirstName, @LastName, GETDATE(), 'N');

	INSERT INTO Normal(AccountID)
	VALUES(@account_seq);
END;
go

--Stored procedure that adds a verified account to Account and Verified tables.
CREATE PROCEDURE AddVerifiedAccount
	@AccountName VARCHAR(50),
	@Email VARCHAR(255),
	@FirstName VARCHAR(255),
	@LastName VARCHAR(255)
AS
BEGIN
	DECLARE @account_seq INT = NEXT VALUE FOR account_seq
	INSERT INTO Account(AccountID, AccountName, Email, FirstName, LastName, AccountDate, AccountType)
	VALUES(@account_seq, @AccountName, @Email, @FirstName, @LastName, GETDATE(), 'V');

	INSERT INTO Verified(AccountID)
	VALUES(@account_seq);
END;
go

--Stored procedure that adds questions from the application to the Question table and ApplicationQ table.
CREATE PROCEDURE AppQuestion
	@AccountID DECIMAL(12),
	@Question VARCHAR(255)
AS
BEGIN
	DECLARE @question_seq INT = NEXT VALUE FOR question_seq
	INSERT INTO Question(QuestionID, AccountID, QuestionType, QuestionDate)
	VALUES(@question_seq, @AccountID, 'APP', GETDATE());

	INSERT INTO ApplicationQ(QuestionID, Question)
	VALUES(@question_seq, @Question);
END;
go

--Stored procedure that adds a video with a filter or no filter to the Video table.
CREATE PROCEDURE AddVideo
	@FilterType VARCHAR(50),
	@AccountID DECIMAL(12)
AS
BEGIN
	DECLARE @filter_seq INT = NEXT VALUE FOR filter_seq
	INSERT INTO Filter(FilterID, FilterType)
	VALUES(@filter_seq, @FilterType);

	DECLARE @video_seq INT = NEXT VALUE FOR video_seq
	INSERT INTO Video(VideoID, FilterID, AccountID, UploadDate)
	VALUES(@video_seq, @filter_seq, @AccountID, GETDATE());
END;
go

--INSERTS
-- Inserts data into Account and Normal.
BEGIN TRANSACTION AddNormalAccount
EXECUTE AddNormalAccount 'DarrowBall13', 'rdude1010@yahoo.com','Ryan', 'Darrow';
EXECUTE AddNormalAccount 'Spillin360', 'jyang@gmail.com', 'Jeff', 'Yang';
EXECUTE AddNormalAccount 'Drivethrough', 'mkisil@gmail.com', 'Mark', 'Kisil';
COMMIT TRANSACTION AddNormalAccount;

-- Inserts data into Account and Verified.
BEGIN TRANSACTION AddVerifiedAccount
EXECUTE AddVerifiedAccount 'MrsMogie', 'acraine1@gmail.com','Abby', 'Craine';
EXECUTE AddVerifiedAccount 'MrMogie', 'kdarrow1@gmail.com', 'Kyle', 'Darrow';
COMMIT TRANSACTION AddVerifiedAccount;

-- Inserts data into Question and ApplicationQ.
BEGIN TRANSACTION AppQuestion
EXECUTE AppQuestion 1, 'Do you enjoy eating out or cooking at home?';
EXECUTE AppQuestion 3, 'What games do you like to play?';
EXECUTE AppQuestion 5, 'How many family members do you have?';
EXECUTE AppQuestion 5, 'What is your favorite vacation spot?';
EXECUTE AppQuestion 4, 'What is your favorite color?';
COMMIT TRANSACTION AppQuestion;

-- Inserts data into Video and Filter.
BEGIN TRANSACTION AddVideo
EXECUTE AddVideo 'Cartoon', 4;
EXECUTE AddVideo 'Anime', 3;
EXECUTE AddVideo 'Animal', 5;
EXECUTE AddVideo 'Scary', 1;
EXECUTE AddVideo 'None', 3;
COMMIT TRANSACTION AddVideo;


--QUERIES
-- First Query - Which normal accounts have a filter on their videos?
-- This query answers this question.
SELECT Account.AccountName, Account.AccountType, Filter.FilterType 
FROM Account
JOIN Normal ON Normal.AccountID = Account.AccountID
JOIN Video ON Video.AccountID = Account.AccountID
JOIN Filter ON Video.FilterID = Filter.FilterID
WHERE Filter.FilterType != 'None';

-- Second Query - Which verified accounts have requested an application question?
-- This query answers this question.
SELECT DISTINCT AccountName, AccountType
FROM Account
JOIN Question ON Question.AccountID = Account.AccountID
JOIN ApplicationQ ON ApplicationQ.QuestionID = Question.QuestionID
WHERE AccountType = 'V';

-- Third Query - Which users created an account after the date 12/31/2022 that use the filter 'animal'?
-- This query answers this question.
-- Scripts must be run seperately.

-- This must be run first.
-- This will create the view.
CREATE OR ALTER VIEW After_2022 AS
SELECT AccountName
	FROM Filter
	JOIN Video ON Video.FilterID = Filter.FilterID
	JOIN Account ON Account.AccountID = Video.AccountID
	WHERE AccountDate > CAST('31/DEC/2022' AS DATE)
	AND FilterType = 'Animal';

--This must be run second.
--This will pull information from the view.
SELECT After_2022.AccountName, Account.FirstName, Account.LastName, Account.AccountDate
FROM After_2022
JOIN Account ON Account.AccountName = After_2022.AccountName;

