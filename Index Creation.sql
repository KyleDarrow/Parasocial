-- First index from query 1.
CREATE INDEX AccountNameIdx
ON Account(AccountName);

-- First index from query 2.
CREATE INDEX UserQuestionIdx
ON UserQ(Question);

-- First index from query 1.
CREATE INDEX AccountCreationIdx
ON Account(AccountDate);