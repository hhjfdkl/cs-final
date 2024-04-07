BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
--DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS movie;

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE movie(
    titleText varchar(50) ,
    id SERIAL,
    primaryImage varchar(200) ,
--    titleType varchar(50), don't know what this would be for
    releaseDate date ,
    genres varchar(200) ,
    runtime time ,
    plot varchar(1000) ,
    meterRanking varchar(10) ,
    ratingsSummary varchar(100) , --??
    episodes numeric,
--    series
    CONSTRAINT PK_movie PRIMARY KEY (id)
);









-- testing data -luke delete this later
INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Shawshank Redemption', 'shawshank_redemption.jpg', '1994-09-23', 'Drama', '2:22:00', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', '9.3', 'Rated R for language and prison violence', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Godfather', 'the_godfather.jpg', '1972-03-24', 'Crime, Drama', '2:55:00', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', '9.2', 'Rated R for language and violence', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Dark Knight', 'the_dark_knight.jpg', '2008-07-18', 'Action, Crime, Drama', '2:32:00', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', '9.0', 'Rated PG-13 for intense sequences of violence and some menace', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('12 Angry Men', '12_angry_men.jpg', '1957-04-10', 'Drama', '1:36:00', 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.', '8.9', 'Rated Approved', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Schindler''s List', 'schindlers_list.jpg', '1993-02-04', 'Biography, Drama, History', '3:15:00', 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.', '8.9', 'Rated R for language, violence, and disturbing content', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Return of the King', 'lotr_return_of_the_king.jpg', '2003-12-17', 'Action, Adventure, Drama', '3:21:00', 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', '8.9', 'Rated PG-13 for intense epic battle sequences and frightening images', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Pulp Fiction', 'pulp_fiction.jpg', '1994-10-14', 'Crime, Drama', '2:34:00', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', '8.9', 'Rated R for strong language, some violence, drug use, and sexual content', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Fellowship of the Ring', 'lotr_fellowship_of_the_ring.jpg', '2001-12-19', 'Action, Adventure, Drama', '2:58:00', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', '8.8', 'Rated PG-13 for epic battle sequences and some scary images', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Forrest Gump', 'forrest_gump.jpg', '1994-07-06', 'Drama, Romance', '2:22:00', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', '8.8', 'Rated PG-13 for drug content, some sensuality, and war violence', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Fight Club', 'fight_club.jpg', '1999-10-15', 'Drama', '2:19:00', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into something much, much more.', '8.8', 'Rated R for disturbing and graphic depiction of violent anti-social behavior, sexuality and language', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Inception', 'inception.jpg', '2010-07-16', 'Action, Adventure, Sci-Fi', '2:28:00', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', '8.8', 'Rated PG-13 for sequences of violence and action throughout', NULL);

INSERT INTO movie (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Two Towers', 'lotr_two_towers.jpg', '2002-12-18', 'Action, Adventure, Drama', '2:59:00', 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron''s new ally, Saruman, and his hordes of Isengard.', '8.7', 'Rated PG-13 for epic battle sequences and scary images', NULL);
--test data ends here


COMMIT TRANSACTION;
