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