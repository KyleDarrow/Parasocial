-- Second Query - Which verified accounts have requested an application question?
-- This query answers this question.
SELECT DISTINCT AccountName, AccountType
FROM Account
JOIN Question ON Question.AccountID = Account.AccountID
JOIN ApplicationQ ON ApplicationQ.QuestionID = Question.QuestionID
WHERE AccountType = 'V';