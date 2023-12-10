-- First Query - Which normal accounts have a filter on their videos?
-- This query answers this question.
SELECT Account.AccountName, Account.AccountType, Filter.FilterType 
FROM Account
JOIN Normal ON Normal.AccountID = Account.AccountID
JOIN Video ON Video.AccountID = Account.AccountID
JOIN Filter ON Video.FilterID = Filter.FilterID
WHERE Filter.FilterType != 'None';