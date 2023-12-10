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