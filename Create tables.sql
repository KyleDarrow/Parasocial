--TABLES
--Drop Tables
DROP TABLE Landmarks;
DROP TABLE City;
DROP TABLE Passwords;
DROP TABLE Account;
DROP TABLE Location;
DROP TABLE Tag;
DROP TABLE Photo;
DROP TABLE Verified;
DROP TABLE Normal;
DROP TABLE AccountLocation;
DROP TABLE Search;
DROP TABLE AccountSearch;
DROP TABLE Filter;
DROP TABLE Video;
DROP TABLE Rating;
DROP TABLE Interaction;
DROP TABLE Question;
DROP TABLE ApplicationQ;
DROP TABLE Asker;
DROP TABLE UserQ;
DROP TABLE Answer;
DROP TABLE VerbalResponse;
DROP TABLE TextResponse;
DROP TABLE AIResponse;
DROP TABLE AIResponseChange;

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

-- Create table AIResponseChange
CREATE TABLE AIResponseChange(
AnswerChangeID DECIMAL(12) NOT NULL PRIMARY KEY,
OldAnswer VARCHAR(1000) NOT NULL,
NewAnswer VARCHAR(1000) NOT NULL,
AnswerID DECIMAL(12) NOT NULL FOREIGN KEY REFERENCES Answer(AnswerID),
DateChanged DATE NOT NULL);

--SEQUENCES
-- Create Sequences
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
CREATE SEQUENCE airesponsechange_seq START WITH 1;
