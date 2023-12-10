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