--Third Query - Which users created an account after the date 12/31/2022 that use the filter 'animal'?
--This query answers this question.
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

