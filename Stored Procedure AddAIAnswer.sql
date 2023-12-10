-- Stored procedure that add an AI's answer to a question.
CREATE PROCEDURE AddAIAnswer
	@QuestionID DECIMAL(12),
	@Answer VARCHAR(1000)
AS
BEGIN
	DECLARE @answer_seq INT = NEXT VALUE FOR answer_seq
	INSERT INTO Answer(AnswerID, QuestionID, AnswerType, AnswerDate)
	VALUES(@answer_seq, @QuestionID, 'AI', GETDATE());

	INSERT INTO AIResponse(AnswerID, Answer)
	VALUES(@answer_seq, @Answer);
END;
go