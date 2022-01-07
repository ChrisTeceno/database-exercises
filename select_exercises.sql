#Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in Sequel Ace as you go. DONE

#Use the albums_db database. DONE

#Explore the structure of the albums table. SIX FIELDS, MULTIPLE VARIABLES, 31 ALBUMS, 

#a. How many rows are in the albums table? 31

#b. How many unique artist names are in the albums table?
SELECT DISTINCT artist
FROM albums;
#23 UNIQUE ARTISTS

#c. What is the primary key for the albums table?
#ID

#d. What is the oldest release date for any album in the albums table? What is the most recent release date? OLDEST "Sgt. Pepper's Lonely Hearts Club Band" 1967, ADELE "21" 2011

#Write queries to find the following information:

#a. The name of all albums by Pink Floyd
SELECT name
FROM albums
WHERE artist = 'Pink floyd';

#b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name like 'Sgt. Pepper%';

#c. The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';

#d. Which albums were released in the 1990s BETWEEN FUNCTION IS INCLUSIVE
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 and 1999;

#e. Which albums had less than 20 million certified sales
SELECT name
FROM albums
WHERE sales < 20;

#f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT name
FROM albums
WHERE genre like '%Rock%';
#LIKE MUST BE USED INSTEAD OF "="