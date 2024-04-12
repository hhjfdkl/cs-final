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
VALUES ('The Shawshank Redemption', 'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_FMjpg_UX1000_.jpg', '1994-09-23', 'Drama', '2:22:00', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 'R', 'Rated R for language and prison violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Godfather', 'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1972-03-24', 'Crime, Drama', '2:55:00', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 'R', 'Rated R for language and violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Dark Knight', 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg', '2008-07-18', 'Action, Crime, Drama', '2:32:00', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 'PG-13', 'Rated PG-13 for intense sequences of violence and some menace', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('12 Angry Men', 'https://m.media-amazon.com/images/M/MV5BMWU4N2FjNzYtNTVkNC00NzQ0LTg0MjAtYTJlMjFhNGUxZDFmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1957-04-10', 'Drama', '1:36:00', 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.', 'N/A', 'Not rated by the MPAA', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Schindler''s List', 'https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1993-02-04', 'Biography, Drama, History', '3:15:00', 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.', 'R', 'Rated R for language, violence, and disturbing content', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Return of the King', 'https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2003-12-17', 'Action, Adventure, Drama', '3:21:00', 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', 'PG-13', 'Rated PG-13 for intense epic battle sequences and frightening images', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Pulp Fiction', 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1994-10-14', 'Crime, Drama', '2:34:00', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 'R', 'Rated R for strong language, some violence, drug use, and sexual content', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Fellowship of the Ring', 'https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_FMjpg_UX1000_.jpg', '2001-12-19', 'Action, Adventure, Drama', '2:58:00', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', 'PG-13', 'Rated PG-13 for epic battle sequences and some scary images', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Forrest Gump', 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1994-07-06', 'Drama, Romance', '2:22:00', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', 'PG-13', 'Rated PG-13 for drug content, some sensuality, and war violence', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Fight Club', 'https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1999-10-15', 'Drama', '2:19:00', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into something much, much more.', 'R', 'Rated R for disturbing and graphic depiction of violent anti-social behavior, sexuality and language', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('Inception', 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg', '2010-07-16', 'Action, Adventure, Sci-Fi', '2:28:00', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 'PG-13', 'Rated PG-13 for sequences of violence and action throughout', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES ('The Lord of the Rings: The Two Towers', 'https://m.media-amazon.com/images/M/MV5BZGMxZTdjZmYtMmE2Ni00ZTdkLWI5NTgtNjlmMjBiNzU2MmI5XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2002-12-18', 'Action, Adventure, Drama', '2:59:00', 'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron''s new ally, Saruman, and his hordes of Isengard.', 'PG-13', 'Rated PG-13 for epic battle sequences and scary images', NULL);

INSERT INTO movies (titleText, primaryImage, releaseDate, genres, runtime, plot, meterRanking, ratingsSummary, episodes)
VALUES
('O Brother, Where Art Thou?', 'https://m.media-amazon.com/images/M/MV5BMjZkOTdmMWItOTkyNy00MDdjLTlhNTQtYzU3MzdhZjA0ZDEyXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2000-12-22', 'Adventure, Comedy, Crime', '01:47:00', 'In this comedic retelling of Homer''s Odyssey set in the American South during the Great Depression, three escaped convicts embark on a journey to find hidden treasure and reunite with their families.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Con Air', 'https://m.media-amazon.com/images/M/MV5BMGZmNGIxMTYtMmVjMy00YzhkLWIyOTktNTExZGFiYjNiNzdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1997-06-06', 'Action, Crime, Thriller', '01:55:00', 'A newly paroled ex-convict finds himself trapped on a prison transport plane hijacked by a group of dangerous criminals, forcing him to try and save the day.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Magnolia', 'https://m.media-amazon.com/images/M/MV5BZjk3YThkNDktNjZjMS00MTBiLTllNTAtYzkzMTU0N2QwYjJjXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '1999-12-17', 'Drama', '03:08:00', 'In this ensemble drama set in Los Angeles, the lives of various characters intersect over the course of one tumultuous day, revealing their interconnectedness and struggles.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Swiss Army Man', 'https://m.media-amazon.com/images/M/MV5BMTk0OTEyMjM1OF5BMl5BanBnXkFtZTgwMzMzODM4ODE@._V1_FMjpg_UX1000_.jpg', '2016-07-01', 'Comedy, Drama, Fantasy', '01:37:00', 'A suicidal man stranded on a deserted island befriends a talking corpse with magical powers, embarking on a surreal and emotional journey of self-discovery.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Riki-Oh: The Story of Ricky', 'https://m.media-amazon.com/images/M/MV5BYmU0ODhkMzYtYjdhYy00ODhiLWEyYjItNDk4YzIwZDJlN2I2XkEyXkFqcGdeQXVyNzgzODI1OTE@._V1_FMjpg_UX1000_.jpg', '1991-10-05', 'Action, Comedy, Thriller', '01:31:00', 'In this cult classic martial arts film, a young man with superhuman strength battles corrupt prison officials and inmates in a brutal and over-the-top fight for justice.', 'N/A', 'Unrated. This film has not been rated by the MPAA.', NULL),
('Truman Show', 'https://m.media-amazon.com/images/M/MV5BMDIzODcyY2EtMmY2MC00ZWVlLTgwMzAtMjQwOWUyNmJjNTYyXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_FMjpg_UX1000_.jpg', '1998-06-05', 'Comedy, Drama, Sci-Fi', '01:43:00', 'A man''s seemingly idyllic life in a small town turns out to be a carefully orchestrated reality TV show, prompting him to question his existence and seek freedom from the control of the show''s creator.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('Big Trouble in Little China', 'https://m.media-amazon.com/images/M/MV5BNzlhYjEzOGItN2MwNS00ODRiLWE5OTItYThiNmJlMTdmMzgxXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', '1986-07-02', 'Action, Adventure, Comedy', '01:39:00', 'In this action-packed comedy, a truck driver finds himself embroiled in a mystical battle in Chinatown when he tries to rescue a friend''s fiancée from an ancient sorcerer.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Breakfast at Tiffany''s', 'https://m.media-amazon.com/images/M/MV5BNGEwMTRmZTQtMDY4Ni00MTliLTk5ZmMtOWMxYWMyMTllMDg0L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1961-10-05', 'Comedy, Drama, Romance', '01:55:00', 'In this romantic comedy, a young New York socialite becomes romantically involved with a struggling writer while trying to find herself and pursue her dreams.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('The Room', 'https://m.media-amazon.com/images/M/MV5BN2IwYzc4MjEtMzJlMS00MDJlLTkzNDAtN2E4NGNkZjg0MDgxXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_FMjpg_UX1000_.jpg', '2003-06-27', 'Drama', '01:39:00', 'In this notoriously bad film, a banker''s life spirals out of control as he becomes entangled in a love triangle with his best friend and his fiancée, leading to betrayal and tragedy.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Matrix', 'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1999-03-31', 'Action, Sci-Fi', '02:16:00', 'In this groundbreaking sci-fi film, a computer hacker learns the truth about his reality and his role in the war against oppressive machines.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Whiplash', 'https://m.media-amazon.com/images/M/MV5BOTA5NDZlZGUtMjAxOS00YTRkLTkwYmMtYWQ0NWEwZDZiNjEzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2014-10-15', 'Drama, Music', '01:47:00', 'A talented young drummer enrolls in a prestigious music academy, where he is mentored by a demanding and abusive instructor who pushes him to his limits.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Big Short', 'https://m.media-amazon.com/images/M/MV5BNDc4MThhN2EtZjMzNC00ZDJmLThiZTgtNThlY2UxZWMzNjdkXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_FMjpg_UX1000_.jpg', '2015-12-11', 'Biography, Comedy, Drama', '02:10:00', 'Based on true events, this film follows a group of financial experts who predict the housing market collapse and decide to profit from the impending crisis.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Wolf of Wall Street', 'https://m.media-amazon.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_FMjpg_UX1000_.jpg', '2013-12-25', 'Biography, Crime, Drama', '03:00:00', 'Based on the real-life story of Jordan Belfort, this film chronicles his rise and fall as a wealthy stockbroker involved in corruption, fraud, and excessive indulgence.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Fast Five', 'https://m.media-amazon.com/images/M/MV5BMTUxNTk5MTE0OF5BMl5BanBnXkFtZTcwMjA2NzY3NA@@._V1_FMjpg_UX1000_.jpg', '2011-04-29', 'Action, Adventure, Crime', '02:10:00', 'In this installment of the Fast & Furious series, Dominic Toretto and his team pull off a series of high-stakes heists while evading capture by a relentless federal agent.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Time Bandits', 'https://m.media-amazon.com/images/M/MV5BODg1NGYwN2MtNWI0OC00N2RiLWE4YzMtOTlhZTgxNmI3NTM0XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1981-07-13', 'Adventure, Comedy, Fantasy', '01:56:00', 'A young boy joins a group of time-traveling dwarves on a series of adventures through history and legend, pursued by the Supreme Being.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('End Game', 'https://m.media-amazon.com/images/M/MV5BZjg3MTVhY2YtZWE4Yi00MjUyLWIzNDQtNmEzNDkwNTBiNmMxXkEyXkFqcGdeQXVyNTM3MDMyMDQ@._V1_FMjpg_UX1000_.jpg', '2019-04-26', 'Action, Adventure, Sci-Fi', '03:01:00', 'In the epic conclusion to the Avengers saga, the remaining heroes band together for one last mission to defeat the villainous Thanos and restore balance to the universe.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('One More Shot', 'https://m.media-amazon.com/images/M/MV5BNWM5YmQ2NTMtOGExOS00NDcxLWEwNWQtMTlmNDkxZjA5MGM2XkEyXkFqcGdeQXVyNzUwMDA5NDE@._V1_FMjpg_UX1000_.jpg', '2023-09-15', 'Drama', '02:00:00', 'A former basketball star seeks redemption by coaching a struggling high school team, facing personal demons and challenging odds along the way.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Magic Mike', 'https://m.media-amazon.com/images/M/MV5BMTQzMDMzOTA5M15BMl5BanBnXkFtZTcwMjc4MTg4Nw@@._V1_FMjpg_UX1000_.jpg', '2012-06-29', 'Comedy, Drama', '01:50:00', 'A male stripper navigates the ups and downs of his profession and personal life, while mentoring a young newcomer to the world of exotic dancing.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Like Mike', 'https://m.media-amazon.com/images/M/MV5BNWM1MGI4ZDgtMjExYi00ZjcwLTgxMzktMDMyZDIxZWU1MWVhXkEyXkFqcGdeQXVyNjk1Njg5NTA@._V1_FMjpg_UX1000_.jpg', '2002-07-03', 'Comedy, Family, Fantasy', '01:39:00', 'A young orphan finds a pair of magical sneakers that give him incredible basketball skills, leading him on a journey to NBA stardom and unexpected adventures.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('300', 'https://m.media-amazon.com/images/M/MV5BMjc4OTc0ODgwNV5BMl5BanBnXkFtZTcwNjM1ODE0MQ@@._V1_FMjpg_UX1000_.jpg', '2007-03-09', 'Action, Fantasy', '01:57:00', 'In this stylized retelling of the Battle of Thermopylae, King Leonidas and 300 Spartans face overwhelming odds as they defend Greece against the Persian army.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Meet the Spartans', 'https://m.media-amazon.com/images/M/MV5BNjYzMjNiMGQtN2RlNS00NWJlLTg2NzUtZjMyNWMxZjQyNjhlXkEyXkFqcGdeQXVyMTUyOTc1NDYz._V1_FMjpg_UX1000_.jpg', '2008-01-25', 'Comedy', '01:26:00', 'In this parody film, the Spartans face off against various pop culture icons and movie characters in a series of absurd and hilarious scenarios.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('A Clockwork Orange', 'https://m.media-amazon.com/images/M/MV5BMTY3MjM1Mzc4N15BMl5BanBnXkFtZTgwODM0NzAxMDE@._V1_FMjpg_UX1000_.jpg', '1971-02-02', 'Crime, Drama, Sci-Fi', '02:16:00', 'In a dystopian future, a young delinquent named Alex leads a gang of thugs until he''s captured and subjected to an experimental form of rehabilitation.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Super Troopers', 'https://m.media-amazon.com/images/M/MV5BYzAyOTZjZDItZjNiYy00YTA3LWEyYWMtZTA0NmUzYjZhNjg0XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2001-02-15', 'Comedy, Crime, Mystery', '01:40:00', 'A comedy about a group of highway patrolmen in the Vermont state police. The troopers have fun pulling pranks on hapless speeders and making a joke out of their station commander.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Bob Ross, the Happy Painter', 'https://m.media-amazon.com/images/M/MV5BMmE5NDllZmUtMGQxNS00NTFiLTg2MWUtOWM0MDZhMDkwNjA2L2ltYWdlXkEyXkFqcGdeQXVyNDkwMzY5NjQ@._V1_FMjpg_UX1000_.jpg', '2011-01-01', 'Documentary', '01:01:00', 'A documentary exploring the life and legacy of Bob Ross, the beloved host of the television program "The Joy of Painting."', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('Jin-Roh: The Wolf Brigade', 'https://m.media-amazon.com/images/M/MV5BOGYxMjk3ZWQtZGY5NC00ZDZlLTk5NTAtMTY4OWM1ZjQ4YzJkXkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_FMjpg_UX1000_.jpg', '1999-11-17', 'Animation, Drama, Fantasy', '01:42:00', 'Set in an alternate history where Japan has been conquered by Germany, a member of an elite police unit faces moral dilemmas when he falls in love with a girl who''s part of a terrorist group.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Shrek', 'https://m.media-amazon.com/images/M/MV5BOGZhM2FhNTItODAzNi00YjA0LWEyN2UtNjJlYWQzYzU1MDg5L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2001-05-18', 'Animation, Adventure, Comedy', '01:30:00', 'A mean lord exiles fairytale creatures to the swamp of a grumpy ogre, who must go on a quest to rescue a princess for the lord in order to get his land back.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', NULL),
('Knives Out', 'https://m.media-amazon.com/images/M/MV5BMGUwZjliMTAtNzAxZi00MWNiLWE2NzgtZGUxMGQxZjhhNDRiXkEyXkFqcGdeQXVyNjU1NzU3MzE@._V1_FMjpg_UX1000_.jpg', '2019-11-27', 'Comedy, Crime, Drama', '02:10:00', 'A detective investigates the death of a patriarch of an eccentric, combative family.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Philosophy of a Knife', 'https://m.media-amazon.com/images/M/MV5BMTYzMTEwNjY1OV5BMl5BanBnXkFtZTcwNjY0ODA0Mg@@._V1_FMjpg_UX1000_.jpg', '2008-06-15', 'Drama, History, Horror', '04:09:00', 'A group of Japanese soldiers are tortured by the KGB during World War II.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Scream', 'https://m.media-amazon.com/images/M/MV5BMjA2NjU5MTg5OF5BMl5BanBnXkFtZTgwOTkyMzQxMDE@._V1_FMjpg_UX1000_.jpg', '1996-12-20', 'Horror, Mystery', '01:51:00', 'A year after the murder of her mother, a teenage girl is terrorized by a new killer, who targets the girl and her friends by using horror films as part of a deadly game.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('All the Old Knives', 'https://m.media-amazon.com/images/M/MV5BNTZhNDM0MGItYjIwYS00NTMzLWIxYmUtZjIwM2Q4NDhjY2EyXkEyXkFqcGdeQXVyMTM1MTE1NDMx._V1_FMjpg_UX1000_.jpg', '2022-04-08', 'Action, Drama, Thriller', '01:41:00', 'Two CIA operatives, and former lovers, reunite at idyllic Carmel-by-the-Sea to re-examine a mission six years ago in Vienna where a fellow agent might have been compromised.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Ice Age', 'https://m.media-amazon.com/images/M/MV5BM2JmZGJkNzAtOWI0MC00ZmE5LWIwMjYtODU0OGUxNDg4ZDkwXkEyXkFqcGdeQXVyMTA5ODEyNTc5._V1_FMjpg_UX1000_.jpg', '2002-03-15', 'Animation, Adventure, Comedy', '01:21:00', 'Set during the Ice Age, a sabertooth tiger, a sloth, and a wooly mammoth find a lost human infant, and they try to return him to his tribe.', 'PG', 'PG - Parental Guidance Suggested. Some material may not be suitable for children.', 6),
('Roundhay Garden Scene', 'https://m.media-amazon.com/images/M/MV5BOGE3YjczMTQtZTAwNi00Y2ZkLWIxZjYtZGFkMWY2ZTM3YTU5XkEyXkFqcGdeQXVyNzg5OTk2OA@@._V1_FMjpg_UX1000_.jpg', '1888-11-16', '', '00:00:02', 'In the garden, a man asks his friends to do something silly for him to record on film.', 'N/A', 'Not rated by the MPAA', NULL),
('Strangers on a Train', 'https://m.media-amazon.com/images/M/MV5BNWJjOGM4NmEtNDE2YS00OGEyLTkwZWItMGM4YzdhZDZhMzNhXkEyXkFqcGdeQXVyMDI2NDg0NQ@@._V1_FMjpg_UX1000_.jpg', '1951-06-30', 'Thriller, Mystery, Crime', TIME '01:41:00', 'A psychotic socialite confronts a pro tennis star with a theory on how two complete strangers can get away with murder - a theory that he plans to implement.', NULL, NULL, NULL),
('Rashomon', 'https://m.media-amazon.com/images/M/MV5BMjEzMzA4NDE2OF5BMl5BanBnXkFtZTcwNTc5MDI2NQ@@._V1_FMjpg_UX1000_.jpg', '1950-08-25', 'Drama, Crime, Mystery', TIME '01:28:00', 'A heinous crime and its aftermath are recalled from differing points of view.', NULL, NULL, NULL),
('Singin'' in the Rain', 'https://m.media-amazon.com/images/M/MV5BZDRjNGViMjQtOThlMi00MTA3LThkYzQtNzJkYjBkMGE0YzE1XkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_FMjpg_UX1000_.jpg', '1952-04-11', 'Musical, Romance, Comedy', TIME '01:43:00', 'A silent film production company and cast make a difficult transition to sound.', NULL, NULL, NULL),
('High Noon', 'https://m.media-amazon.com/images/M/MV5BOWIzZGUxZmItOThkMS00Y2QxLTg0MTYtMDdhMjRlNTNlYTI3L2ltYWdlXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1952-07-30', 'Western, Drama, Thriller', TIME '01:25:00', 'A marshall, personally compelled to face a returning deadly enemy, finds that his own town refuses to help him.', NULL, NULL, NULL),
('Stalag 17', 'https://m.media-amazon.com/images/M/MV5BNmFlNzE5YjQtZDhlMC00MmQ0LWFkYWYtMDhhZTc5MzZjYTBkXkEyXkFqcGdeQXVyMTYwMTcxOTYy._V1_FMjpg_UX1000_.jpg', '1953-07-01', 'War, Drama, Comedy', TIME '02:00:00', 'When two escaping American World War II prisoners are killed, the German P.O.W. camp barracks black marketeer, J.J. Sefton, is suspected of being an informer.', NULL, NULL, NULL),
('Roman Holiday', 'https://m.media-amazon.com/images/M/MV5BMTE2MDM4MTMtZmNkZC00Y2QyLWE0YjUtMTAxZGJmODMxMDM0XkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1953-08-26', 'Romance, Comedy, Drama', TIME '01:58:00', 'A bored and sheltered princess escapes her guardians and falls in love with an American newsman in Rome.', NULL, NULL, NULL),
('On the Waterfront', 'https://m.media-amazon.com/images/M/MV5BY2I0MWFiZDMtNWQyYy00Njk5LTk3MDktZjZjNTNmZmVkYjkxXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1954-07-28', 'Crime, Drama, Romance', TIME '01:48:00', 'An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.', NULL, NULL, NULL);



--more test data
INSERT INTO genres (genre_name) VALUES
('Horror'),     --1
('Action'),     --2
('Romance'),    --3
('Crime'),      --4
('Thriller'),   --5
('Documentary'),--6
('Comedy'),     --7
('Drama'),      --8
('Sci-Fi'),     --9
('Adventure'),  --10
('Fantasy'),    --11
('Biography'),  --12
('Mystery'),    --13
('History');    --14

--more test data
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES
(1,8),(2,4),(2,8),(3,2),(3,4),(3,8),(4,8),(5,8),(5,14),(6,2),(6,8),(6,10),(7,4),(7,8),(8,2),(8,8),(8,10),(9,8),(9,3),(10,8),(11,2),(11,9),(12,2),(12,8),
(13,7),(13,10),(13,4),(14,2),(14,4),(14,5),(15,8),(16,7),(16,8),(16,11),(17,2),(17,7),(17,5),(18,7),(18,8),(18,9),(19,2),
(19,10),(19,7),(20,7),(20,8),(20,3),(21,8),(22,2),(22,9),(23,8),(24,12),(24,7),(24,8),(25,12),(25,4),(25,8),
(26,2),(26,10),(26,4),(27,10),(27,7),(27,11),(28,2),(28,10),(28,9),(29,8),(30,7),(30,8),(31,7),(31,11),(32,2),(32,11),
(33,7),(34,4),(34,8),(34,9),(35,7),(35,4),(35,13),(36,6),(37,8),(37,11),(38,10),(38,7),(39,7),(39,4),(39,8),
(40,8),(40,14),(40,1),(41,1),(41,13),(42,2),(42,8),(42,5),(43,10),(43,7),
(45,5),(45,13),(45,4),(46,8),(46,4),(46,13),(47,3),(47,7),(48,8),(48,5),(49,8),(49,7),(50,3),(50,7),(50,8),(51,4),(51,8),(51,3);


--test data ends here
COMMIT TRANSACTION;
