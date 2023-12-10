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