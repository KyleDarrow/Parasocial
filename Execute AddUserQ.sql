BEGIN TRANSACTION AddUserQ
EXECUTE AddUserQ 2, 'What have you enjoyed doing recently?', 'MrMogie';
EXECUTE AddUserQ 4, 'How often do you go to the movies?', 'DarrowBall13';
COMMIT TRANSACTION AddUserQ;