BEGIN TRANSACTION AddVideo
EXECUTE AddVideo 'Cartoon', 4;
EXECUTE AddVideo 'Anime', 3;
EXECUTE AddVideo 'Animal', 5;
EXECUTE AddVideo 'Scary', 1;
EXECUTE AddVideo 'None', 3;
COMMIT TRANSACTION AddVideo;