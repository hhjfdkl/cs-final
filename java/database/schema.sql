BEGIN TRANSACTION;
DROP TABLE IF EXISTS favorite_genres, genres, favorites, movies, users, reviews, accounts CASCADE;


CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_users PRIMARY KEY (user_id)
);


CREATE TABLE accounts (
	account_id INTEGER NOT NULL UNIQUE,
	--may add a "display name" later or something


	CONSTRAINT FK_accounts_users FOREIGN KEY (account_id) REFERENCES users (user_id)

);

CREATE TABLE movies(
    titleText varchar(50),
    movie_id SERIAL,
    primaryImage varchar(1024) ,
--    titleType varchar(50), don't know what this would be for
    releaseDate date ,
    genres varchar(200) ,
    runtime time ,
    plot varchar(1024) ,
-- meterRanking will probably just be a calculated value from our users' ratings
    meterRanking varchar(10) ,
    ratingsSummary varchar(100) , --??
    episodes numeric,
--    series
    CONSTRAINT PK_movies PRIMARY KEY (movie_id)
);

CREATE TABLE favorites (
	account_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,

	CONSTRAINT PK_favorites PRIMARY KEY (account_id, movie_id),
	CONSTRAINT FK_favorites_accounts FOREIGN KEY (account_id) REFERENCES accounts (account_id),
	CONSTRAINT FK_favorites_movies FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
);

--non-mock
CREATE TABLE genres (
	genre_id SERIAL,
	genre_name VARCHAR(20),

	CONSTRAINT PK_genres PRIMARY KEY (genre_id)


);

CREATE TABLE favorite_genres (
	account_id INTEGER NOT NULL,
	genre_id INTEGER NOT NULL,

	CONSTRAINT PK_favorite_genres PRIMARY KEY (account_id, genre_id),
	CONSTRAINT FK_favorite_genres_accounts FOREIGN KEY (account_id) REFERENCES accounts (account_id),
	CONSTRAINT FK_favorite_genres_genres FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);

CREATE TABLE reviews (
	account_id INTEGER NOT NULL,
	rating INTEGER NOT NULL,
	review VARCHAR(1024),
	movie_id INTEGER NOT NULL,

	CONSTRAINT PK_reviews PRIMARY KEY (account_id, movie_id),
	CONSTRAINT FK_reviews_accounts FOREIGN KEY (account_id) REFERENCES accounts (account_id),
	CONSTRAINT FK_reviews_movies FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
	CONSTRAINT check_rating_min CHECK (rating > 0),
	CONSTRAINT check_rating_max CHECK (rating <= 5)
);

CREATE TABLE movie_to_genre (
	movie_id INTEGER NOT NULL,
	genre_id INTEGER NOT NULL,

	CONSTRAINT PK_movie_to_genre PRIMARY KEY (movie_id, genre_id),
	CONSTRAINT FK_movie_to_genre_movies FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
	CONSTRAINT FK_movie_to_genre_genres FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);





-- testing data -luke delete this later
INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Shawshank Redemption', 'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_FMjpg_UX1000_.jpg', '1994-09-23', 'Drama', '2:22:00', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', '9.3', 'Rated R for language and prison violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Godfather', 'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1972-03-24', 'Crime, Drama', '2:55:00', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', '9.2', 'Rated R for language and violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Dark Knight', 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg', '2008-07-18', 'Action, Crime, Drama', '2:32:00', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', '9.0', 'Rated PG-13 for intense sequences of violence and some menace', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('12 Angry Men', 'https://m.media-amazon.com/images/M/MV5BMWU4N2FjNzYtNTVkNC00NzQ0LTg0MjAtYTJlMjFhNGUxZDFmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1957-04-10', 'Drama', '1:36:00', 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.', '8.9', 'Rated Approved', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Schindler''s List', 'https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1993-02-04', 'Biography, Drama, History', '3:15:00', 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.', '8.9', 'Rated R for language, violence, and disturbing content', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Return of the King', 'https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2003-12-17', 'Action, Adventure, Drama', '3:21:00', 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', '8.9', 'Rated PG-13 for intense epic battle sequences and frightening images', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Pulp Fiction', 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1994-10-14', 'Crime, Drama', '2:34:00', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', '8.9', 'Rated R for strong language, some violence, drug use, and sexual content', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Fellowship of the Ring', 'https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_FMjpg_UX1000_.jpg', '2001-12-19', 'Action, Adventure, Drama', '2:58:00', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', '8.8', 'Rated PG-13 for epic battle sequences and some scary images', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Forrest Gump', 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1994-07-06', 'Drama, Romance', '2:22:00', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', '8.8', 'Rated PG-13 for drug content, some sensuality, and war violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Fight Club', 'https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1999-10-15', 'Drama', '2:19:00', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into something much, much more.', '8.8', 'Rated R for disturbing and graphic depiction of violent anti-social behavior, sexuality and language', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Inception', 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg', '2010-07-16', 'Action, Adventure, Sci-Fi', '2:28:00', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', '8.8', 'Rated PG-13 for sequences of violence and action throughout', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Two Towers', 'https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2002-12-18', 'Action, Adventure, Drama', '2:59:00', 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron''s new ally, Saruman, and his hordes of Isengard.', '8.7', 'Rated PG-13 for epic battle sequences and scary images', NULL);



--more test data
INSERT INTO genres (genre_name) VALUES ('Horror');
INSERT INTO genres (genre_name) VALUES ('Action');
INSERT INTO genres (genre_name) VALUES ('Crime');
INSERT INTO genres (genre_name) VALUES ('Comedy');
INSERT INTO genres (genre_name) VALUES ('Romance');
INSERT INTO genres (genre_name) VALUES ('Documentary');
INSERT INTO genres (genre_name) VALUES ('Thriller');
INSERT INTO genres (genre_name) VALUES ('Drama');


--more test data
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (1,1);
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (2,1);
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (3,1);
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (2,2);
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (3,2);




--test data ends here
COMMIT TRANSACTION;
