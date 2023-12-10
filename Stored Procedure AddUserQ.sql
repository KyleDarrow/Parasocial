-- Stored procedure to add a user question to  UserQ.
CREATE PROCEDURE AddUserQ
	@AccountID DECIMAL(12),
	@Question VARCHAR(255),
	@AskingUser VARCHAR(50)
AS
BEGIN
	DECLARE @question_seq INT = NEXT VALUE FOR account_seq
	DECLARE @asker_seq INT = NEXT VALUE FOR asker_seq
	INSERT INTO Question(QuestionID, AccountID, QuestionType, QuestionDate)
	VALUES(@question_seq, @AccountID, 'User', GETDATE());

	INSERT INTO Asker(AskID, AskingUser)
	VALUES(@asker_seq, @AskingUser);

	INSERT INTO UserQ(QuestionID, AskID, Question)
	VALUES(@question_seq, @asker_seq, @Question);

END;
go