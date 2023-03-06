USE codeup_test_db;
# In select_exercises.sql write queries to find the following information. Before each item, output a caption explaining the results:

# The name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name='Sgt. Pepper''s Lonely Hearts Club Band';

# The genre for Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';

# Which albums were released in the 1990s
SELECT name, artist, release_date
FROM albums
WHERE release_date between 1990 and 1999;

# Which albums had less than 20 million certified sales
SELECT name, artist, sales
FROM albums
WHERE sales < 20;

# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT name, genre
FROM albums
WHERE genre LIKE '%rock%';
