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