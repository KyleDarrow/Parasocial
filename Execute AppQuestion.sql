BEGIN TRANSACTION AppQuestion
EXECUTE AppQuestion 1, 'Do you enjoy eating out or cooking at home?';
EXECUTE AppQuestion 3, 'What games do you like to play?';
EXECUTE AppQuestion 5, 'How many family members do you have?';
EXECUTE AppQuestion 5, 'What is your favorite vacation spot?';
EXECUTE AppQuestion 4, 'What is your favorite color?';
COMMIT TRANSACTION AppQuestion;