BEGIN TRANSACTION;
DROP TABLE IF EXISTS favorite_genres, genres, favorites, movies, users, reviews, accounts, articles CASCADE;


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
-- meterRanking is MPAA rating
    meterRanking varchar(10) ,
    ratingsSummary varchar(100) , --??
    episodes numeric,
    avgRating numeric,
    synopsis varchar(3072),
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
('On the Waterfront', 'https://m.media-amazon.com/images/M/MV5BY2I0MWFiZDMtNWQyYy00Njk5LTk3MDktZjZjNTNmZmVkYjkxXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1954-07-28', 'Crime, Drama, Romance', TIME '01:48:00', 'An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.', NULL, NULL, NULL),
('Terminator 2: Judgment Day', 'https://m.media-amazon.com/images/M/MV5BMGU2NzRmZjUtOGUxYS00ZjdjLWEwZWItY2NlM2JhNjkxNTFmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1991-07-03', 'Action, Sci-Fi', '02:17:00', 'A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her ten-year-old son, John Connor, from a more advanced and powerful cyborg.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),


('The Grand Budapest Hotel', 'https://m.media-amazon.com/images/M/MV5BMzM5NjUxOTEyMl5BMl5BanBnXkFtZTgwNjEyMDM0MDE@._V1_FMjpg_UX1000_.jpg', '2014-03-28', 'Comedy', '01:39:00', 'Plot summary for The Grand Budapest Hotel.', 'R', 'Rating for The Grand Budapest Hotel', NULL),
('Superbad', 'https://m.media-amazon.com/images/M/MV5BY2VkMDg4ZTYtN2M3Yy00NWZiLWE2ODEtZjU5MjZkYWNkNGIzXkEyXkFqcGdeQXVyODY5Njk4Njc@._V1_FMjpg_UX1000_.jpg', '2007-08-17', 'Comedy', '01:53:00', 'Plot summary for Superbad.', 'R', 'Rating for Superbad', NULL),
('Monty Python and the Holy Grail', 'https://m.media-amazon.com/images/M/MV5BN2IyNTE4YzUtZWU0Mi00MGIwLTgyMmQtMzQ4YzQxYWNlYWE2XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1975-05-23', 'Comedy', '01:31:00', 'Plot summary for Monty Python and the Holy Grail.', 'PG', 'Rating for Monty Python and the Holy Grail', NULL),
('The Hangover', 'https://m.media-amazon.com/images/M/MV5BNGQwZjg5YmYtY2VkNC00NzliLTljYTctNzI5NmU3MjE2ODQzXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2009-06-05', 'Comedy', '01:40:00', 'Plot summary for The Hangover.', 'R', 'Rating for The Hangover', NULL),
('Airplane!', 'https://m.media-amazon.com/images/M/MV5BZjA3YjdhMWEtYjc2Ni00YzVlLWI0MTUtMGZmNTJjNmU0Yzk2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1980-07-02', 'Comedy', '01:28:00', 'Plot summary for Airplane!.', 'PG', 'Rating for Airplane!', NULL),
('The Big Lebowski', 'https://m.media-amazon.com/images/M/MV5BMzliZDk0NjctNjhlOC00MWEyLWI3OWYtNjA5ZDYxMTMzNTc5XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', '1998-03-06', 'Comedy', '01:57:00', 'Plot summary for The Big Lebowski.', 'R', 'Rating for The Big Lebowski', NULL),
('Anchorman: The Legend of Ron Burgundy', 'https://m.media-amazon.com/images/M/MV5BMTQ2MzYwMzk5Ml5BMl5BanBnXkFtZTcwOTI4NzUyMw@@._V1_FMjpg_UX1000_.jpg', '2004-07-09', 'Comedy', '01:34:00', 'Plot summary for Anchorman: The Legend of Ron Burgundy.', 'PG-13', 'Rating for Anchorman: The Legend of Ron Burgundy', NULL),

('Dumb and Dumber', 'https://m.media-amazon.com/images/M/MV5BZDQwMjNiMTQtY2UwYy00NjhiLTk0ZWEtZWM5ZWMzNGFjNTVkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1994-12-16', 'Comedy', '01:47:00', 'Plot summary for Dumb and Dumber.', 'PG-13', 'Rating for Dumb and Dumber', NULL),
('Bridesmaids', 'https://m.media-amazon.com/images/M/MV5BMjAyOTMyMzUxNl5BMl5BanBnXkFtZTcwODI4MzE0NA@@._V1_FMjpg_UX1000_.jpg', '2011-05-13', 'Comedy', '02:05:00', 'Plot summary for Bridesmaids.', 'R', 'Rating for Bridesmaids', NULL),
('Napoleon Dynamite', 'https://m.media-amazon.com/images/M/MV5BNjYwNTA3MDIyMl5BMl5BanBnXkFtZTYwMjIxNjA3._V1_FMjpg_UX1000_.jpg', '2004-08-27', 'Comedy', '01:35:00', 'Plot summary for Napoleon Dynamite.', 'PG', 'Rating for Napoleon Dynamite', NULL),
('Shaun of the Dead', 'https://m.media-amazon.com/images/M/MV5BMTg5Mjk2NDMtZTk0Ny00YTQ0LWIzYWEtMWI5MGQ0Mjg1OTNkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2004-09-24', 'Comedy', '01:39:00', 'Plot summary for Shaun of the Dead.', 'R', 'Rating for Shaun of the Dead', NULL),
('Ferris Bueller''s Day Off', 'https://m.media-amazon.com/images/M/MV5BMDA0NjZhZWUtNmI2NC00MmFjLTgwZDYtYzVjZmNhMDVmOTBkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1986-06-11', 'Comedy', '01:43:00', 'Plot summary for Ferris Bueller''s Day Off.', 'PG-13', 'Rating for Ferris Bueller''s Day Off', NULL),
('The Princess Bride', 'https://m.media-amazon.com/images/M/MV5BYzdiOTVjZmQtNjAyNy00YjA2LTk5ZTAtNmJkMGQ5N2RmNjUxXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1987-10-09', 'Comedy', '01:38:00', 'Plot summary for The Princess Bride.', 'PG', 'Rating for The Princess Bride', NULL),
('Groundhog Day', 'https://m.media-amazon.com/images/M/MV5BZWIxNzM5YzQtY2FmMS00Yjc3LWI1ZjUtNGVjMjMzZTIxZTIxXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1993-02-12', 'Comedy', '01:41:00', 'Plot summary for Groundhog Day.', 'PG', 'Rating for Groundhog Day', NULL),


('School of Rock', 'https://m.media-amazon.com/images/M/MV5BOTg2NDU4Mjg2NV5BMl5BanBnXkFtZTgwNjQ0MDIyMDI@._V1_FMjpg_UX1000_.jpg', '2003-10-03', 'Comedy', '01:48:00', 'Plot summary for School of Rock.', 'PG-13', 'Rating for School of Rock', NULL),
('The Producers', 'https://m.media-amazon.com/images/M/MV5BMzYwYWNhOTUtNDdhMi00NDg0LThlM2UtNWM1NjEwMzE0OWIzXkEyXkFqcGdeQXVyNjc5NjEzNA@@._V1_FMjpg_UX1000_.jpg', '1968-11-22', 'Comedy', '01:28:00', 'Plot summary for The Producers.', 'PG', 'Rating for The Producers', NULL),
('Little Miss Sunshine', 'https://m.media-amazon.com/images/M/MV5BMTgzNTgzODU0NV5BMl5BanBnXkFtZTcwMjEyMjMzMQ@@._V1_FMjpg_UX1000_.jpg', '2006-08-18', 'Comedy', '01:41:00', 'Plot summary for Little Miss Sunshine.', 'R', 'Rating for Little Miss Sunshine', NULL),
('Hot Fuzz', 'https://m.media-amazon.com/images/M/MV5BMzg4MDJhMDMtYmJiMS00ZDZmLThmZWUtYTMwZDM1YTc5MWE2XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2007-04-20', 'Comedy', '02:01:00', 'Plot summary for Hot Fuzz.', 'R', 'Rating for Hot Fuzz', NULL),
('Ted', 'https://m.media-amazon.com/images/M/MV5BMTQ1OTU0ODcxMV5BMl5BanBnXkFtZTcwOTMxNTUwOA@@._V1_FMjpg_UX1000_.jpg', '2012-06-29', 'Comedy', '01:46:00', 'Plot summary for Ted.', 'R', 'Rating for Ted', NULL),
('This Is Spinal Tap', 'https://m.media-amazon.com/images/M/MV5BMTQ2MTIzMzg5Nl5BMl5BanBnXkFtZTgwOTc5NDI1MDE@._V1_FMjpg_UX1000_.jpg', '1984-03-02', 'Comedy', '01:22:00', 'Plot summary for This Is Spinal Tap.', 'R', 'Rating for This Is Spinal Tap', NULL),
('Zombieland', 'https://m.media-amazon.com/images/M/MV5BMTU5MDg0NTQ1N15BMl5BanBnXkFtZTcwMjA4Mjg3Mg@@._V1_FMjpg_UX1000_.jpg', '2009-10-02', 'Comedy', '01:28:00', 'Plot summary for Zombieland.', 'R', 'Rating for Zombieland', NULL),
('The Naked Gun: From the Files of Police Squad!', 'https://m.media-amazon.com/images/M/MV5BODk1ZWM4ZjItMjFhZi00MDMxLTgxNmYtODFhNWZlZTkwM2UwXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1988-12-02', 'Comedy', '01:25:00', 'Plot summary for The Naked Gun: From the Files of Police Squad!.', 'PG-13', 'Rating for The Naked Gun: From the Files of Police Squad!', NULL),
('Trading Places', 'https://m.media-amazon.com/images/M/MV5BZGVjNTBiYWUtY2MwOC00NTg1LWJiNWMtNzM5MTBkYzE5NjQxXkEyXkFqcGdeQXVyMTUzMDUzNTI3._V1_FMjpg_UX1000_.jpg', '1983-06-08', 'Comedy', '01:58:00', 'Plot summary for Trading Places.', 'R', 'Rating for Trading Places', NULL),
('The 40-Year-Old Virgin', 'https://m.media-amazon.com/images/M/MV5BNWY1NDI0ZTQtMjJiNS00ODY4LWE1NmUtYTkwNzY3NWQ0ZDZjXkEyXkFqcGdeQXVyMTM0NTc2NDgw._V1_FMjpg_UX1000_.jpg', '2005-08-19', 'Comedy', '01:56:00', 'Plot summary for The 40-Year-Old Virgin.', 'R', 'Rating for The 40-Year-Old Virgin', NULL),
('Spaceballs', 'https://m.media-amazon.com/images/M/MV5BMTBlNGE0N2EtZDA2OS00OTA3LWFiYjUtODI0YzFmODY3NDExXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1987-06-24', 'Comedy', '01:36:00', 'Plot summary for Spaceballs.', 'PG', 'Rating for Spaceballs', NULL),
('Coming to America', 'https://m.media-amazon.com/images/M/MV5BNGZlNjdlZmMtYTg0MC00MmZkLWIyNDktYmNlOWYzMTkzYWQ1XkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_FMjpg_UX1000_.jpg', '1988-06-29', 'Comedy', '01:57:00', 'Plot summary for Coming to America.', 'R', 'Rating for Coming to America', NULL),
('Caddyshack', 'https://m.media-amazon.com/images/M/MV5BMjhlNzFiNTAtMGY4OC00ODFjLWI2NWQtZDMwNTNlMTJmNGM2XkEyXkFqcGdeQXVyNDUzNzgxODE@._V1_FMjpg_UX1000_.jpg', '1980-07-25', 'Comedy', '01:38:00', 'Plot summary for Caddyshack.', 'R', 'Rating for Caddyshack', NULL),
('Office Space', 'https://m.media-amazon.com/images/M/MV5BOTA5MzQ3MzI1NV5BMl5BanBnXkFtZTgwNTcxNTYxMTE@._V1_FMjpg_UX1000_.jpg', '1999-02-19', 'Comedy', '01:29:00', 'Plot summary for Office Space.', 'R', 'Rating for Office Space', NULL),
('Wayne''s World', 'https://m.media-amazon.com/images/M/MV5BMDAyNDY3MjUtYmJjYS00Zjc5LTlhM2MtNzgzYjNlOWVkZjkzL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1992-02-14', 'Comedy', '01:34:00', 'Plot summary for Wayne''s World.', 'PG-13', 'Rating for Wayne''s World', NULL),
('Blade Runner', 'https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1982-06-25', 'Sci-Fi, Thriller', '01:57:00', 'Plot summary for Blade Runner.', 'R', 'Rating for Blade Runner.', NULL),
('Star Wars: Episode IV - A New Hope', 'https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_FMjpg_UX1000_.jpg', '1977-05-25', 'Sci-Fi, Action, Adventure', '02:01:00', 'Plot summary for Star Wars: Episode IV - A New Hope.', 'PG', 'Rating for Star Wars: Episode IV - A New Hope.', NULL),
('Interstellar', 'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2014-11-07', 'Sci-Fi, Adventure, Drama', '02:49:00', 'Plot summary for Interstellar.', 'PG-13', 'Rating for Interstellar.', NULL),


('Alien', 'https://m.media-amazon.com/images/M/MV5BOGQzZTBjMjQtOTVmMS00NGE5LWEyYmMtOGQ1ZGZjNmRkYjFhXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1979-05-25', 'Sci-Fi, Horror', '01:57:00', 'Plot summary for Alien.', 'R', 'Rating for Alien.', NULL),
('The Terminator', 'https://m.media-amazon.com/images/M/MV5BYTViNzMxZjEtZGEwNy00MDNiLWIzNGQtZDY2MjQ1OWViZjFmXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1984-10-26', 'Sci-Fi, Action', '01:47:00', 'Plot summary for The Terminator.', 'R', 'Rating for The Terminator.', NULL),
('Jurassic Park', 'https://m.media-amazon.com/images/M/MV5BMjM2MDgxMDg0Nl5BMl5BanBnXkFtZTgwNTM2OTM5NDE@._V1_FMjpg_UX1000_.jpg', '1993-06-11', 'Sci-Fi, Adventure, Action', '02:07:00', 'Plot summary for Jurassic Park.', 'PG-13', 'Rating for Jurassic Park.', NULL),
('The Fifth Element', 'https://m.media-amazon.com/images/M/MV5BZWFjYmZmZGQtYzg4YS00ZGE5LTgwYzAtZmQwZjQ2NDliMGVmXkEyXkFqcGdeQXVyNTUyMzE4Mzg@._V1_FMjpg_UX1000_.jpg', '1997-05-09', 'Sci-Fi, Action, Adventure', '02:06:00', 'Plot summary for The Fifth Element.', 'PG-13', 'Rating for The Fifth Element.', NULL),
('Avatar', 'https://m.media-amazon.com/images/M/MV5BZDA0OGQxNTItMDZkMC00N2UyLTg3MzMtYTJmNjg3Nzk5MzRiXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '2009-12-18', 'Sci-Fi, Action, Adventure', '02:42:00', 'Plot summary for Avatar.', 'PG-13', 'Rating for Avatar.', NULL),
('The Martian', 'https://m.media-amazon.com/images/M/MV5BMTc2MTQ3MDA1Nl5BMl5BanBnXkFtZTgwODA3OTI4NjE@._V1_FMjpg_UX1000_.jpg', '2015-10-02', 'Sci-Fi, Adventure, Drama', '02:24:00', 'Plot summary for The Martian.', 'PG-13', 'Rating for The Martian.', NULL),
('2001: A Space Odyssey', 'https://m.media-amazon.com/images/M/MV5BMmNlYzRiNDctZWNhMi00MzI4LThkZTctMTUzMmZkMmFmNThmXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1968-04-06', 'Sci-Fi, Adventure, Mystery', '02:29:00', 'Plot summary for 2001: A Space Odyssey.', 'G', 'Rating for 2001: A Space Odyssey.', NULL),
('E.T. the Extra-Terrestrial', 'https://m.media-amazon.com/images/M/MV5BMTQ2ODFlMDAtNzdhOC00ZDYzLWE3YTMtNDU4ZGFmZmJmYTczXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1982-06-11', 'Sci-Fi, Family, Fantasy', '01:55:00', 'Plot summary for E.T. the Extra-Terrestrial.', 'PG', 'Rating for E.T. the Extra-Terrestrial.', NULL),
('Back to the Future', 'https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1985-07-03', 'Sci-Fi, Adventure, Comedy', '01:56:00', 'Plot summary for Back to the Future.', 'PG', 'Rating for Back to the Future.', NULL),
('The Avengers', 'https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2012-05-04', 'Sci-Fi, Action, Adventure', '02:23:00', 'Plot summary for The Avengers.', 'PG-13', 'Rating for The Avengers.', NULL),
('The Hunger Games', 'https://m.media-amazon.com/images/M/MV5BMjA4NDg3NzYxMF5BMl5BanBnXkFtZTcwNTgyNzkyNw@@._V1_FMjpg_UX1000_.jpg', '2012-03-23', 'Sci-Fi, Action, Adventure', '02:22:00', 'Plot summary for The Hunger Games.', 'PG-13', 'Rating for The Hunger Games.', NULL),
('Star Trek', 'https://m.media-amazon.com/images/M/MV5BMjE5NDQ5OTE4Ml5BMl5BanBnXkFtZTcwOTE3NDIzMw@@._V1_FMjpg_UX1000_.jpg', '2009-05-08', 'Sci-Fi, Action, Adventure', '02:07:00', 'Plot summary for Star Trek.', 'PG-13', 'Rating for Star Trek.', NULL),
('District 9', 'https://m.media-amazon.com/images/M/MV5BMTM4OTI1OTM5NF5BMl5BanBnXkFtZTcwMzk5MTU1Mg@@._V1_FMjpg_UX1000_.jpg', '2009-08-14', 'Sci-Fi, Action, Thriller', '01:52:00', 'Plot summary for District 9.', 'R', 'Rating for District 9.', NULL),
('The War of the Worlds', 'https://m.media-amazon.com/images/M/MV5BYTViNjlmM2ItMmRhZC00ZDhkLWE2NTQtNzViMTgxNzY2MGY4XkEyXkFqcGdeQXVyNjEyNjA4ODg@._V1_FMjpg_UX1000_.jpg', '1953-08-26', 'Sci-Fi, Action, Drama', '01:25:00', 'Plot summary for The War of the Worlds.', 'G', 'Rating for The War of the Worlds.', NULL),
('The Day the Earth Stood Still', 'https://m.media-amazon.com/images/M/MV5BMTI5NTg1MzU5Nl5BMl5BanBnXkFtZTcwMDU1ODMwMg@@._V1_FMjpg_UX1000_.jpg', '1951-09-28', 'Sci-Fi, Drama, Thriller', '01:32:00', 'Plot summary for The Day the Earth Stood Still.', 'G', 'Rating for The Day the Earth Stood Still.', NULL),
('Gravity', 'https://m.media-amazon.com/images/M/MV5BNjE5MzYwMzYxMF5BMl5BanBnXkFtZTcwOTk4MTk0OQ@@._V1_FMjpg_UX1000_.jpg', '2013-10-04', 'Sci-Fi, Drama, Thriller', '01:31:00', 'Plot summary for Gravity.', 'PG-13', 'Rating for Gravity.', NULL),
('Close Encounters of the Third Kind', 'https://m.media-amazon.com/images/M/MV5BMjM1NjE5NjQxN15BMl5BanBnXkFtZTgwMjYzMzQxMDE@._V1_FMjpg_UX1000_.jpg', '1977-11-16', 'Sci-Fi, Drama', '02:17:00', 'Plot summary for Close Encounters of the Third Kind.', 'PG', 'Rating for Close Encounters of the Third Kind.', NULL),
('The Iron Giant', 'https://m.media-amazon.com/images/M/MV5BYzBjZTNkMzQtZmNkOC00Yzk0LTljMjktZjk3YWVlZjY3NTk2XkEyXkFqcGdeQXVyMTUzMDUzNTI3._V1_FMjpg_UX1000_.jpg', '1999-08-06', 'Sci-Fi, Animation, Action', '01:26:00', 'Plot summary for The Iron Giant.', 'PG', 'Rating for The Iron Giant.', NULL),
('Pacific Rim', 'https://m.media-amazon.com/images/M/MV5BMTY3MTI5NjQ4Nl5BMl5BanBnXkFtZTcwOTU1OTU0OQ@@._V1_FMjpg_UX1000_.jpg', '2013-07-12', 'Sci-Fi, Action, Adventure', '02:11:00', 'Plot summary for Pacific Rim.', 'PG-13', 'Rating for Pacific Rim.', NULL),
('Ex Machina', 'https://m.media-amazon.com/images/M/MV5BMTUxNzc0OTIxMV5BMl5BanBnXkFtZTgwNDI3NzU2NDE@._V1_FMjpg_UX1000_.jpg', '2014-01-21', 'Sci-Fi, Drama, Mystery', '01:48:00', 'Plot summary for Ex Machina.', 'R', 'Rating for Ex Machina.', NULL),
('Looper', 'https://m.media-amazon.com/images/M/MV5BMTg5NTA3NTg4NF5BMl5BanBnXkFtZTcwNTA0NDYzOA@@._V1_FMjpg_UX1000_.jpg', '2012-09-28', 'Sci-Fi, Action, Crime', '01:53:00', 'Plot summary for Looper.', 'R', 'Rating for Looper.', NULL),


('The Prestige', 'https://m.media-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_FMjpg_UX1000_.jpg', '2006-10-20', 'Sci-Fi, Drama, Mystery', '02:10:00', 'Plot summary for The Prestige.', 'PG-13', 'Rating for The Prestige.', NULL),
('Minority Report', 'https://m.media-amazon.com/images/M/MV5BZTI3YzZjZjEtMDdjOC00OWVjLTk0YmYtYzI2MGMwZjFiMzBlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2002-06-21', 'Sci-Fi, Action, Crime', '02:25:00', 'Plot summary for Minority Report.', 'PG-13', 'Rating for Minority Report.', NULL),
('The Abyss', 'https://m.media-amazon.com/images/M/MV5BYmU4NmUxZjEtYjY0OC00ZDAwLTg0MGQtMDRkNDk5NWQ0OTQ5XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1989-08-09', 'Sci-Fi, Adventure, Drama', '02:20:00', 'Plot summary for The Abyss.', 'PG-13', 'Rating for The Abyss.', NULL),
('Indiana Jones and the Raiders of the Lost Ark', 'https://m.media-amazon.com/images/M/MV5BNTU2ODkyY2MtMjU1NC00NjE1LWEzYjgtMWQ3MzRhMTE0NDc0XkEyXkFqcGdeQXVyMjM4MzQ4OTQ@._V1_FMjpg_UX1000_.jpg', '1981-06-12', 'Action, Adventure', '01:55:00', 'Plot summary for Indiana Jones and the Raiders of the Lost Ark.', 'PG', 'Rating for Indiana Jones and the Raiders of the Lost Ark.', NULL),
('The Mummy', 'https://m.media-amazon.com/images/M/MV5BOTJiYjBhZDgtMjhiOC00MTIzLThlNGMtMmI1NjIwM2M3YTI5XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1999-05-07', 'Action, Adventure, Fantasy', '02:05:00', 'Plot summary for The Mummy.', 'PG-13', 'Rating for The Mummy.', NULL),
('The Goonies', 'https://m.media-amazon.com/images/M/MV5BNTNmZDc0ZDEtZjY3Ni00YmVjLTljNWQtMTE3NDAxNWFhMDk4XkEyXkFqcGdeQXVyMTUzMDUzNTI3._V1_FMjpg_UX1000_.jpg', '1985-06-07', 'Adventure, Comedy, Family', '01:54:00', 'Plot summary for The Goonies.', 'PG', 'Rating for The Goonies.', NULL),
('National Treasure', 'https://m.media-amazon.com/images/M/MV5BMTY3NTc4OTYxMF5BMl5BanBnXkFtZTcwMjk5NzUyMw@@._V1_FMjpg_UX1000_.jpg', '2004-11-19', 'Action, Adventure, Mystery', '02:11:00', 'Plot summary for National Treasure.', 'PG', 'Rating for National Treasure.', NULL),
('The Jungle Book', 'https://m.media-amazon.com/images/M/MV5BMTc3NTUzNTI4MV5BMl5BanBnXkFtZTgwNjU0NjU5NzE@._V1_FMjpg_UX1000_.jpg', '2016-04-15', 'Adventure, Drama, Family', '01:46:00', 'Plot summary for The Jungle Book.', 'PG', 'Rating for The Jungle Book.', NULL),
('Mad Max: Fury Road', 'https://m.media-amazon.com/images/M/MV5BN2EwM2I5OWMtMGQyMi00Zjg1LWJkNTctZTdjYTA4OGUwZjMyXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2015-05-15', 'Action, Adventure, Sci-Fi', '02:00:00', 'Plot summary for Mad Max: Fury Road.', 'R', 'Rating for Mad Max: Fury Road.', NULL),
('The Hobbit: An Unexpected Journey', 'https://m.media-amazon.com/images/M/MV5BMTcwNTE4MTUxMl5BMl5BanBnXkFtZTcwMDIyODM4OA@@._V1_FMjpg_UX1000_.jpg', '2012-12-14', 'Adventure, Family, Fantasy', '02:49:00', 'Plot summary for The Hobbit: An Unexpected Journey.', 'PG-13', 'Rating for The Hobbit: An Unexpected Journey.', NULL),
('The African Queen', 'https://m.media-amazon.com/images/M/MV5BYTRkMDVlMjEtMzY1Yy00NTg5LWFlMDQtNmYzY2U2YzdhMTViXkEyXkFqcGdeQXVyNjc5NjEzNA@@._V1_FMjpg_UX1000_.jpg', '1951-12-23', 'Adventure, Drama, Romance', '01:45:00', 'Plot summary for The African Queen.', 'PG', 'Rating for The African Queen.', NULL),
('The Treasure of the Sierra Madre', 'https://m.media-amazon.com/images/M/MV5BOTJlZWMxYzEtMjlkMS00ODE0LThlM2ItMDI3NGQ2YjhmMzkxXkEyXkFqcGdeQXVyMDI2NDg0NQ@@._V1_FMjpg_UX1000_.jpg', '1948-01-24', 'Adventure, Drama, Western', '02:06:00', 'Plot summary for The Treasure of the Sierra Madre.', 'Not Rated', 'Rating for The Treasure of the Sierra Madre.', NULL),
('The Revenant', 'https://m.media-amazon.com/images/M/MV5BMDE5OWMzM2QtOTU2ZS00NzAyLWI2MDEtOTRlYjIxZGM0OWRjXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_FMjpg_UX1000_.jpg', '2015-12-25', 'Adventure, Biography, Drama', '02:36:00', 'Plot summary for The Revenant.', 'R', 'Rating for The Revenant.', NULL),
('King Kong', 'https://m.media-amazon.com/images/M/MV5BMjYxYmRlZWYtMzAwNC00MDA1LWJjNTItOTBjMzlhNGMzYzk3XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2005-12-14', 'Action, Adventure, Drama', '03:07:00', 'Plot summary for King Kong.', 'PG-13', 'Rating for King Kong.', NULL),
('Sahara', 'https://m.media-amazon.com/images/M/MV5BMjExOTM4NDUzNV5BMl5BanBnXkFtZTcwOTgzNzczMw@@._V1_FMjpg_UX1000_.jpg', '2005-04-08', 'Action, Adventure, Comedy', '02:04:00', 'Plot summary for Sahara.', 'PG-13', 'Rating for Sahara.', NULL),
('The Secret Life of Walter Mitty', 'https://m.media-amazon.com/images/M/MV5BODYwNDYxNDk1Nl5BMl5BanBnXkFtZTgwOTAwMTk2MDE@._V1_FMjpg_UX1000_.jpg', '2013-12-25', 'Adventure, Comedy, Drama', '01:54:00', 'Plot summary for The Secret Life of Walter Mitty.', 'PG', 'Rating for The Secret Life of Walter Mitty.', NULL),
('Harry Potter and the Sorcerer''s Stone', 'https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_FMjpg_UX1000_.jpg', '2001-11-16', 'Adventure, Family, Fantasy', '02:32:00', 'Plot summary for Harry Potter and the Sorcerer''s Stone.', 'PG', 'Rating for Harry Potter and the Sorcerer''s Stone.', NULL),
('Pan''s Labyrinth', 'https://m.media-amazon.com/images/M/MV5BYzFjMThiMGItOWRlMC00MDI4LThmOGUtYTNlZGZiYWI1YjMyXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '2006-12-29', 'Drama, Fantasy, War', '01:58:00', 'Plot summary for Pan''s Labyrinth.', 'R', 'Rating for Pan''s Labyrinth.', NULL),
('Stardust', 'https://m.media-amazon.com/images/M/MV5BMjkyMTE1OTYwNF5BMl5BanBnXkFtZTcwMDIxODYzMw@@._V1_FMjpg_UX1000_.jpg', '2007-08-10', 'Adventure, Family, Fantasy', '02:07:00', 'Plot summary for Stardust.', 'PG-13', 'Rating for Stardust.', NULL),
('The Wizard of Oz', 'https://m.media-amazon.com/images/M/MV5BY2NjNDU1ZjctN2VhZi00Nzc5LTljNmItMTZiOTg1ODkwYjgwXkEyXkFqcGdeQXVyNTkxMzEwMzU@._V1_FMjpg_UX1000_.jpg', '1939-08-25', 'Adventure, Family, Fantasy', '01:42:00', 'Plot summary for The Wizard of Oz.', 'PG', 'Rating for The Wizard of Oz.', NULL),
('Alice in Wonderland', 'https://m.media-amazon.com/images/M/MV5BMTMwNjAxMTc0Nl5BMl5BanBnXkFtZTcwODc3ODk5Mg@@._V1_FMjpg_UX1000_.jpg', '2010-03-05', 'Adventure, Family, Fantasy', '01:48:00', 'Plot summary for Alice in Wonderland.', 'PG', 'Rating for Alice in Wonderland.', NULL),


('The NeverEnding Story', 'https://m.media-amazon.com/images/M/MV5BM2YwNWExYjItODZmOC00MTRjLWFlYmEtODFmNGI5M2E5NzYxXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '1984-07-20', 'Adventure, Drama, Family', '01:42:00', 'Plot summary for The NeverEnding Story.', 'PG', 'Rating for The NeverEnding Story.', NULL),
('Howl''s Moving Castle', 'https://m.media-amazon.com/images/M/MV5BNmM4YTFmMmItMGE3Yy00MmRkLTlmZGEtMzZlOTQzYjk3MzA2XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2004-11-20', 'Animation, Adventure, Family', '01:59:00', 'Plot summary for Howl''s Moving Castle.', 'PG', 'Rating for Howl''s Moving Castle.', NULL),
('Spirited Away', 'https://m.media-amazon.com/images/M/MV5BMjlmZmI5MDctNDE2YS00YWE0LWE5ZWItZDBhYWQ0NTcxNWRhXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2001-07-20', 'Animation, Adventure, Family', '02:05:00', 'Plot summary for Spirited Away.', 'PG', 'Rating for Spirited Away.', NULL),
('The Dark Crystal', 'https://m.media-amazon.com/images/M/MV5BNDQyNDkzZGEtZjE2NC00M2I3LWI1YmItNTcxOTJkMTg3ZmNkXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1982-12-17', 'Adventure, Family, Fantasy', '01:33:00', 'Plot summary for The Dark Crystal.', 'PG', 'Rating for The Dark Crystal.', NULL),
('Willow', 'https://m.media-amazon.com/images/M/MV5BNTliMTA3ZTUtYzJkMC00M2UzLTllYmItNjc1MzFhOTJmMmJjXkEyXkFqcGdeQXVyOTYyMTY2NzQ@._V1_FMjpg_UX1000_.jpg', '1988-05-20', 'Action, Adventure, Drama', '02:06:00', 'Plot summary for Willow.', 'PG', 'Rating for Willow.', NULL),
('The Secret of NIMH', 'https://m.media-amazon.com/images/M/MV5BNDJlM2E1M2QtNTVmNi00MzNhLTlmZTgtMGM0YjYzYzhjM2JmXkEyXkFqcGdeQXVyNTkxMzEwMzU@._V1_FMjpg_UX1000_.jpg', '1982-07-02', 'Animation, Adventure, Drama', '01:22:00', 'Plot summary for The Secret of NIMH.', 'G', 'Rating for The Secret of NIMH.', NULL),
('The Golden Compass', 'https://m.media-amazon.com/images/M/MV5BMTM2NDkxMjQxMV5BMl5BanBnXkFtZTYwNTMxMDM4._V1_FMjpg_UX1000_.jpg', '2007-12-07', 'Adventure, Family, Fantasy', '01:53:00', 'Plot summary for The Golden Compass.', 'PG-13', 'Rating for The Golden Compass.', NULL),
('Labyrinth', 'https://m.media-amazon.com/images/M/MV5BMjM2MDE4OTQwOV5BMl5BanBnXkFtZTgwNjgxMTg2NzE@._V1_FMjpg_UX1000_.jpg', '1986-06-27', 'Adventure, Family, Fantasy', '01:41:00', 'Plot summary for Labyrinth.', 'PG', 'Rating for Labyrinth.', NULL),
('The Nightmare Before Christmas', 'https://m.media-amazon.com/images/M/MV5BNWE4OTNiM2ItMjY4Ni00ZTViLWFiZmEtZGEyNGY2ZmNlMzIyXkEyXkFqcGdeQXVyMDU5NDcxNw@@._V1_FMjpg_UX1000_.jpg', '1993-10-29', 'Animation, Family, Fantasy', '01:16:00', 'Plot summary for The Nightmare Before Christmas.', 'PG', 'Rating for The Nightmare Before Christmas.', NULL),
('Harry Potter and the Deathly Hallows – Part 1', 'https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_FMjpg_UX1000_.jpg', '2010-11-19', 'Adventure, Family, Fantasy', '02:26:00', 'Plot summary for Harry Potter and the Deathly Hallows – Part 1.', 'PG-13', 'Rating for Harry Potter and the Deathly Hallows – Part 1.', NULL),
('Eragon', 'https://m.media-amazon.com/images/M/MV5BNzMyMGI1N2UtNzc5YS00OGNkLTg1OTktMTNkMmY2Zjk1NTQxXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_FMjpg_UX1000_.jpg', '2006-12-15', 'Action, Adventure, Family', '01:44:00', 'Plot summary for Eragon.', 'PG', 'Rating for Eragon.', NULL),
('The Social Network', 'https://m.media-amazon.com/images/M/MV5BOGUyZDUxZjEtMmIzMC00MzlmLTg4MGItZWJmMzBhZjE0Mjc1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2010-10-01', 'Biography, Drama', '02:00:00', 'Plot summary for The Social Network.', 'PG-13', 'Rating for The Social Network.', NULL),
('The King''s Speech', 'https://m.media-amazon.com/images/M/MV5BMzU5MjEwMTg2Nl5BMl5BanBnXkFtZTcwNzM3MTYxNA@@._V1_FMjpg_UX1000_.jpg', '2010-12-25', 'Biography, Drama, History', '01:58:00', 'Plot summary for The King''s Speech.', 'R', 'Rating for The King''s Speech.', NULL),
('Gandhi', 'https://m.media-amazon.com/images/M/MV5BYjZiYmYwYjYtOTdlZS00OGM4LTg0NmQtOTg0OGMzMjkyYWM2XkEyXkFqcGdeQXVyMTUzMDUzNTI3._V1_FMjpg_UX1000_.jpg', '1982-12-10', 'Biography, Drama, History', '03:11:00', 'Plot summary for Gandhi.', 'PG', 'Rating for Gandhi.', NULL),
('The Theory of Everything', 'https://m.media-amazon.com/images/M/MV5BMTAwMTU4MDA3NDNeQTJeQWpwZ15BbWU4MDk4NTMxNTIx._V1_FMjpg_UX1000_.jpg', '2015-01-09', 'Biography, Drama, Romance', '02:03:00', 'Plot summary for The Theory of Everything.', 'PG-13', 'Rating for The Theory of Everything.', NULL),
('A Beautiful Mind', 'https://m.media-amazon.com/images/M/MV5BMzcwYWFkYzktZjAzNC00OGY1LWI4YTgtNzc5MzVjMDVmNjY0XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2002-01-04', 'Biography, Drama', '02:15:00', 'Plot summary for A Beautiful Mind.', 'PG-13', 'Rating for A Beautiful Mind.', NULL),
('Catch Me If You Can', 'https://m.media-amazon.com/images/M/MV5BMTY5MzYzNjc5NV5BMl5BanBnXkFtZTYwNTUyNTc2._V1_FMjpg_UX1000_.jpg', '2002-12-25', 'Biography, Crime, Drama', '02:21:00', 'Plot summary for Catch Me If You Can.', 'PG-13', 'Rating for Catch Me If You Can.', NULL),
('The Pursuit of Happyness', 'https://m.media-amazon.com/images/M/MV5BMTQ5NjQ0NDI3NF5BMl5BanBnXkFtZTcwNDI0MjEzMw@@._V1_FMjpg_UX1000_.jpg', '2006-12-15', 'Biography, Drama', '01:57:00', 'Plot summary for The Pursuit of Happyness.', 'PG-13', 'Rating for The Pursuit of Happyness.', NULL),
('The Imitation Game', 'https://m.media-amazon.com/images/M/MV5BNjI3NjY1Mjg3MV5BMl5BanBnXkFtZTgwMzk5MDQ3MjE@._V1_FMjpg_UX1000_.jpg', '2014-12-25', 'Biography, Drama, Thriller', '01:54:00', 'Plot summary for The Imitation Game.', 'PG-13', 'Rating for The Imitation Game.', NULL),
('Ray', 'https://m.media-amazon.com/images/M/MV5BMTQxNDQwNjQzOV5BMl5BanBnXkFtZTcwNTQxNDYyMQ@@._V1_FMjpg_UX1000_.jpgg', '2004-10-29', 'Biography, Drama, Music', '02:32:00', 'Plot summary for Ray.', 'PG-13', 'Rating for Ray.', NULL),
('Goodfellas', 'https://m.media-amazon.com/images/M/MV5BY2NkZjEzMDgtN2RjYy00YzM1LWI4ZmQtMjIwYjFjNmI3ZGEwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1990-09-21', 'Biography, Crime, Drama', '02:26:00', 'Plot summary for Goodfellas.', 'R', 'Rating for Goodfellas.', NULL),
('Malcolm X', 'https://m.media-amazon.com/images/M/MV5BZDkzOTFmMTUtMmI2OS00MDE4LTg5YTUtODMwNDMzNmI5OGYwL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1992-11-20', 'Biography, Drama, History', '03:22:00', 'Plot summary for Malcolm X.', 'PG-13', 'Rating for Malcolm X.', NULL),


('The Aviator', 'https://m.media-amazon.com/images/M/MV5BZTYzMjA2M2EtYmY1OC00ZWMxLThlY2YtZGI3MTQzOWM4YjE3XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2005-12-25', 'Biography, Drama', '02:50:00', 'Plot summary for The Aviator.', 'PG-13', 'Rating for The Aviator.', NULL),
('Into the Wild', 'https://m.media-amazon.com/images/M/MV5BNjQ0ODlhMWUtNmUwMS00YjExLWI4MjQtNjVmMmE2Y2E0MGRmXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_FMjpg_UX1000_.jpg', '2007-10-19', 'Adventure, Biography, Drama', '02:28:00', 'Plot summary for Into the Wild.', 'R', 'Rating for Into the Wild.', NULL),
('Lincoln', 'https://m.media-amazon.com/images/M/MV5BMTQzNzczMDUyNV5BMl5BanBnXkFtZTcwNjM2ODEzOA@@._V1_FMjpg_UX1000_.jpg', '2012-11-16', 'Biography, Drama, History', '02:30:00', 'Plot summary for Lincoln.', 'PG-13', 'Rating for Lincoln.', NULL),
('The Elephant Man', 'https://m.media-amazon.com/images/M/MV5BMDVjNjIwOGItNDE3Ny00OThjLWE0NzQtZTU3YjMzZTZjMzhkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1980-10-03', 'Biography, Drama', '02:04:00', 'Plot summary for The Elephant Man.', 'PG', 'Rating for The Elephant Man.', NULL),
('Erin Brockovich', 'https://m.media-amazon.com/images/M/MV5BYTA1NWRkNTktNDMxNS00NjE4LWEzMDAtNzA3YzlhYzRhNDA4L2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2000-03-17', 'Biography, Drama', '02:10:00', 'Plot summary for Erin Brockovich.', 'R', 'Rating for Erin Brockovich.', NULL),
('Lawrence of Arabia', 'https://m.media-amazon.com/images/M/MV5BYWY5ZjhjNGYtZmI2Ny00ODM0LWFkNzgtZmI1YzA2N2MxMzA0XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_FMjpg_UX1000_.jpg', '1962-12-16', 'Adventure, Biography, Drama', '03:48:00', 'Plot summary for Lawrence of Arabia.', 'PG', 'Rating for Lawrence of Arabia.', NULL),
('Capote', 'https://m.media-amazon.com/images/M/MV5BMTczMzU0MjM1MV5BMl5BanBnXkFtZTcwMjczNzgyNA@@._V1_FMjpg_UX1000_.jpg', '2006-03-03', 'Biography, Crime, Drama', '01:54:00', 'Plot summary for Capote.', 'R', 'Rating for Capote.', NULL),
('Braveheart', 'https://m.media-amazon.com/images/M/MV5BMzkzMmU0YTYtOWM3My00YzBmLWI0YzctOGYyNTkwMWE5MTJkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1995-05-24', 'Biography, Drama, History', '02:58:00', 'Plot summary for Braveheart.', 'R', 'Rating for Braveheart.', NULL),
('Walk the Line', 'https://m.media-amazon.com/images/M/MV5BMjIyOTU3MjUxOF5BMl5BanBnXkFtZTcwMTQ0NjYzMw@@._V1_FMjpg_UX1000_.jpg', '2005-11-18', 'Biography, Drama, Music', '02:16:00', 'Plot summary for Walk the Line.', 'PG-13', 'Rating for Walk the Line.', NULL),
('Steve Jobs', 'https://m.media-amazon.com/images/M/MV5BMjE0NTA2MTEwOV5BMl5BanBnXkFtZTgwNzg4NzU2NjE@._V1_FMjpg_UX1000_.jpg', '2015-10-23', 'Biography, Drama', '02:02:00', 'Plot summary for Steve Jobs.', 'R', 'Rating for Steve Jobs.', NULL),
('The Blind Side', 'https://m.media-amazon.com/images/M/MV5BMjEzOTE3ODM3OF5BMl5BanBnXkFtZTcwMzYyODI4Mg@@._V1_FMjpg_UX1000_.jpg', '2009-11-20', 'Biography, Drama, Sport', '02:09:00', 'Plot summary for The Blind Side.', 'PG-13', 'Rating for The Blind Side.', NULL),
('127 Hours', 'https://m.media-amazon.com/images/M/MV5BMTc2NjMzOTE3Ml5BMl5BanBnXkFtZTcwMDE0OTc5Mw@@._V1_FMjpg_UX1000_.jpg', '2010-11-05', 'Biography, Drama, Thriller', '01:34:00', 'Plot summary for 127 Hours.', 'R', 'Rating for 127 Hours.', NULL),
('Amadeus', 'https://m.media-amazon.com/images/M/MV5BNWJlNzUzNGMtYTAwMS00ZjI2LWFmNWQtODcxNWUxODA5YmU1XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_FMjpg_UX1000_.jpg', '1984-09-19', 'Biography, Drama, History', '02:40:00', 'Plot summary for Amadeus.', 'R', 'Rating for Amadeus.', NULL),
('My Left Foot', 'https://m.media-amazon.com/images/M/MV5BYjdkNzA4MzYtZThhOS00ZDgzLTlmMDItNmY1ZjI5YjkzZTE1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1989-11-10', 'Biography, Drama', '01:43:00', 'Plot summary for My Left Foot.', 'R', 'Rating for My Left Foot.', NULL),
('Selma', 'https://m.media-amazon.com/images/M/MV5BZGZkNzFkYTgtYTBkZC00M2MzLWJhNzUtMGE4YzRhYmU2Zjg0XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2014-01-09', 'Biography, Drama, History', '02:08:00', 'Plot summary for Selma.', 'PG-13', 'Rating for Selma.', NULL),
('Chaplin', 'https://m.media-amazon.com/images/M/MV5BZGQ3ZjI3NjgtMjU4OS00OTBiLWE4YmUtYWY4ZTljNTlkNGNjXkEyXkFqcGdeQXVyNjExODE1MDc@._V1_FMjpg_UX1000_.jpg', '1992-12-25', 'Biography, Comedy, Drama', '02:23:00', 'Plot summary for Chaplin.', 'PG-13', 'Rating for Chaplin.', NULL),

('John Wick', 'https://m.media-amazon.com/images/M/MV5BMTU2NjA1ODgzMF5BMl5BanBnXkFtZTgwMTM2MTI4MjE@._V1_FMjpg_UX1000_.jpg', '2014-10-24', 'Action, Crime, Thriller', '01:41:00', 'An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took everything from him.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Gladiator', 'https://m.media-amazon.com/images/M/MV5BMDliMmNhNDEtODUyOS00MjNlLTgxODEtN2U3NzIxMGVkZTA1L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2000-05-05', 'Action, Adventure, Drama', '02:35:00', 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Lethal Weapon', 'https://m.media-amazon.com/images/M/MV5BZTllNWNlZjctMWQwMS00ZDc3LTg5ZjMtNzhmNzhjMmVhYTFlXkEyXkFqcGdeQXVyNTc1NTQxODI@._V1_FMjpg_UX1000_.jpg', '1987-03-06', 'Action, Crime, Thriller', '01:49:00', 'Two newly paired cops who are complete opposites must put aside their differences in order to catch a gang of drug smugglers.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Bourne Identity', 'https://m.media-amazon.com/images/M/MV5BM2JkNGU0ZGMtZjVjNS00NjgyLWEyOWYtZmRmZGQyN2IxZjA2XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_FMjpg_UX1000_.jpg', '2002-06-14', 'Action, Mystery, Thriller', '01:59:00', 'A man is picked up by a fishing boat, bullet-riddled and suffering from amnesia, before racing to elude assassins and attempting to regain his memory.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Mission: Impossible - Fallout', 'https://m.media-amazon.com/images/M/MV5BNjRlZmM0ODktY2RjNS00ZDdjLWJhZGYtNDljNWZkMGM5MTg0XkEyXkFqcGdeQXVyNjAwMjI5MDk@._V1_FMjpg_UX1000_.jpg', '2018-07-27', 'Action, Adventure, Thriller', '02:27:00', 'Ethan Hunt and his IMF team, along with some familiar allies, race against time after a mission gone wrong.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('The Raid: Redemption', 'https://m.media-amazon.com/images/M/MV5BY2UyNDM1ZmUtM2E4Mi00ZDEzLWFhMTEtOGVlYjQ2NDZiYjg3XkEyXkFqcGdeQXVyNzI1NzMxNzM@._V1_FMjpg_UX1000_.jpg', '2011-04-13', 'Action, Thriller', '01:41:00', 'A S.W.A.T. team becomes trapped in a tenement run by a ruthless mobster and his army of killers and thugs.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Speed', 'https://m.media-amazon.com/images/M/MV5BYjc0MjYyN2EtZGRhMy00NzJiLWI2Y2QtYzhiYTU3NzAxNzg4XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1994-06-10', 'Action, Adventure, Thriller', '01:56:00', 'A young police officer must prevent a bomb exploding aboard a city bus by keeping its speed above 50 mph.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Predator', 'https://m.media-amazon.com/images/M/MV5BY2QwYmFmZTEtNzY2Mi00ZWMyLWEwY2YtMGIyNGZjMWExOWEyXkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_FMjpg_UX1000_.jpg', '1987-06-12', 'Action, Adventure, Sci-Fi', '01:47:00', 'A team of commandos on a mission in a Central American jungle find themselves hunted by an extraterrestrial warrior.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('First Blood', 'https://m.media-amazon.com/images/M/MV5BODBmOWU2YWMtZGUzZi00YzRhLWJjNDAtYTUwNWVkNDcyZmU5XkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_FMjpg_UX1000_.jpg', '1982-10-22', 'Action, Adventure', '01:33:00', 'A veteran Green Beret is forced by a cruel Sheriff and his deputies to flee into the mountains and wage an escalating one-man war against his pursuers.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Crouching Tiger, Hidden Dragon', 'https://m.media-amazon.com/images/M/MV5BNDdhMzMxOTctNDMyNS00NTZmLTljNWEtNTc4MDBmZTYxY2NmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2000-12-08', 'Action, Adventure, Fantasy', '02:00:00', 'Two warriors in pursuit of a stolen sword and a notorious fugitive are led to an impetuous, physically skilled, adolescent nobleman''s daughter, who is at a crossroads in her life.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Kill Bill: Vol. 1', 'https://m.media-amazon.com/images/M/MV5BNzM3NDFhYTAtYmU5Mi00NGRmLTljYjgtMDkyODQ4MjNkMGY2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2003-10-10', 'Action, Crime, Drama', '01:51:00', 'After awakening from a four-year coma, a former assassin wreaks vengeance on the team of assassins who betrayed her.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Titanic', 'https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg', '1997-12-19', 'Drama, Romance', '03:14:00', 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('The Notebook', 'https://m.media-amazon.com/images/M/MV5BNzc3Mzg1OGYtZjc3My00Y2NhLTgyOWUtYjRhMmI4OTkwNDg4XkEyXkFqcGdeQXVyMTU3NDU4MDg2._V1_FMjpg_UX1000_.jpg', '2004-06-25', 'Drama, Romance', '02:03:00', 'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Pride and Prejudice', 'https://m.media-amazon.com/images/M/MV5BMTA1NDQ3NTcyOTNeQTJeQWpwZ15BbWU3MDA0MzA4MzE@._V1_FMjpg_UX1000_.jpg', '2005-11-23', 'Drama, Romance', '02:09:00', 'Sparks fly when spirited Elizabeth Bennet meets single, rich, and proud Mr. Darcy. But Mr. Darcy reluctantly finds himself falling in love with a woman beneath his class. Can each overcome their own pride and prejudice?', 'PG', 'PG - Parental Guidance Suggested. General Audiences.', NULL),
('La La Land', 'https://m.media-amazon.com/images/M/MV5BMzUzNDM2NzM2MV5BMl5BanBnXkFtZTgwNTM3NTg4OTE@._V1_FMjpg_UX1000_.jpg', '2016-12-25', 'Comedy, Drama, Music', '02:08:00', 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Romeo + Juliet', 'https://m.media-amazon.com/images/M/MV5BMGU4YmI1ZGQtZjExYi00M2E0LTgyYTAtNzQ5ZmVlMTk4NzUzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '1996-11-01', 'Drama, Romance', '02:00:00', 'Shakespeare''s famous play is updated to the hip modern suburb of Verona still retaining its original dialogue.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Before Sunrise', 'https://m.media-amazon.com/images/M/MV5BZDdiZTAwYzAtMDI3Ni00OTRjLTkzN2UtMGE3MDMyZmU4NTU4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1995-01-27', 'Drama, Romance', '01:41:00', 'A young man and woman meet on a train in Europe and wind up spending one evening together in Vienna. Unfortunately, both know that this will probably be their only night together.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Dirty Dancing', 'https://m.media-amazon.com/images/M/MV5BYjM0MzA3NmUtZTA5Yi00ZmI5LWExNzQtYWRjOGNmZjNhNmIwXkEyXkFqcGdeQXVyODUzMjQxMTA@._V1_FMjpg_UX1000_.jpg', '1987-08-21', 'Drama, Music, Romance', '01:40:00', 'Spending the summer at a Catskills resort with her family, Frances "Baby" Houseman falls in love with the camp''s dance instructor, Johnny Castle.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Notting Hill', 'https://m.media-amazon.com/images/M/MV5BMTE5OTkwYzYtNDhlNC00MzljLTk1YTktY2IxZjliZmNjMjUzL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1999-05-28', 'Comedy, Drama, Romance', '02:04:00', 'The life of a simple bookshop owner changes when he meets the most famous film star in the world.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('500 Days of Summer', 'https://m.media-amazon.com/images/M/MV5BMTk5MjM4OTU1OV5BMl5BanBnXkFtZTcwODkzNDIzMw@@._V1_FMjpg_UX1000_.jpg', '2009-08-07', 'Comedy, Drama, Romance', '01:35:00', 'An offbeat romantic comedy about a woman who doesn''t believe true love exists, and the young man who falls for her.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('The Fault in Our Stars', 'https://m.media-amazon.com/images/M/MV5BNTVkMTFiZWItOTFkOC00YTc3LWFhYzQtZTg3NzAxZjJlNTAyXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_FMjpg_UX1000_.jpg', '2014-06-06', 'Drama, Romance', '02:06:00', 'Two teenage cancer patients begin a life-affirming journey to visit a reclusive author in Amsterdam.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Casablanca', 'https://m.media-amazon.com/images/M/MV5BY2IzZGY2YmEtYzljNS00NTM5LTgwMzUtMzM1NjQ4NGI0OTk0XkEyXkFqcGdeQXVyNDYyMDk5MTU@._V1_FMjpg_UX1000_.jpg', '1942-01-23', 'Drama, Romance, War', '01:42:00', 'A cynical expatriate American cafe owner struggles to decide whether or not to help his former lover and her fugitive husband escape the Nazis in French Morocco.', 'PG', 'PG - Parental Guidance Suggested. General Audiences.', NULL),
('Eternal Sunshine of the Spotless Mind', 'https://m.media-amazon.com/images/M/MV5BMTY4NzcwODg3Nl5BMl5BanBnXkFtZTcwNTEwOTMyMw@@._V1_FMjpg_UX1000_.jpg', '2004-03-19', 'Drama, Romance, Sci-Fi', '01:48:00', 'When their relationship turns sour, a couple undergoes a medical procedure to have each other erased from their memories.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Pretty Woman', 'https://m.media-amazon.com/images/M/MV5BNjk2ODQzNDYxNV5BMl5BanBnXkFtZTgwMTcyNDg4NjE@._V1_FMjpg_UX1000_.jpg', '1990-03-23', 'Comedy, Romance', '01:59:00', 'A man in a legal but hurtful business needs an escort for some social events, and hires a beautiful prostitute he meets... only to fall in love.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Brokeback Mountain', 'https://m.media-amazon.com/images/M/MV5BNTM4NTFiZGMtNjljZi00MDIzLWJkNTctMzA0NWViNjYxMDY1XkEyXkFqcGdeQXVyMTU3NDU4MDg2._V1_FMjpg_UX1000_.jpg', '2005-01-13', 'Drama, Romance', '02:14:00', 'The story of a forbidden and secretive relationship between two cowboys, and their lives over the years.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('A Star Is Born', 'https://m.media-amazon.com/images/M/MV5BNmE5ZmE3OGItNTdlNC00YmMxLWEzNjctYzAwOGQ5ODg0OTI0XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2018-10-05', 'Drama, Music, Romance', '02:16:00', 'A musician helps a young singer find fame as age and alcoholism send his own career into a downward spiral.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Shape of Water', 'https://m.media-amazon.com/images/M/MV5BNGNiNWQ5M2MtNGI0OC00MDA2LWI5NzEtMmZiYjVjMDEyOWYzXkEyXkFqcGdeQXVyMjM4NTM5NDY@._V1_FMjpg_UX1000_.jpg', '2017-12-22', 'Adventure, Drama, Fantasy', '02:03:00', 'At a top secret research facility in the 1960s, a lonely janitor forms a unique relationship with an amphibious creature that is being held in captivity.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Annie Hall', 'https://m.media-amazon.com/images/M/MV5BZDg1OGQ4YzgtM2Y2NS00NjA3LWFjYTctMDRlMDI3NWE1OTUyXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1977-04-20', 'Comedy, Romance', '01:33:00', 'Neurotic New York comedian Alvy Singer falls in love with the ditzy Annie Hall.', 'PG', 'PG - Parental Guidance Suggested. General Audiences.', NULL),
('Ghost', 'https://m.media-amazon.com/images/M/MV5BMmE4ZjI3YzctNjM0YS00MjBlLWFmYjItNDRiNTk0ZmRkYjVjXkEyXkFqcGdeQXVyNjc3MjQzNTI@._V1_FMjpg_UX1000_.jpg', '1990-07-13', 'Drama, Fantasy, Romance', '02:07:00', 'After a young man is murdered, his spirit stays behind to warn his lover of impending danger, with the help of a reluctant psychic.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Love Actually', 'https://m.media-amazon.com/images/M/MV5BNThkNjgxNGQtOTIxMy00ZTFmLWIwMDItYzE5YzM3ZDMzNDE3XkEyXkFqcGdeQXVyMTUyNjc3NDQ4._V1_FMjpg_UX1000_.jpg', '2003-11-14', 'Comedy, Drama, Romance', '02:15:00', 'Follows the lives of eight very different couples in dealing with their love lives in various loosely interrelated tales all set during a frantic month before Christmas in London, England.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Departed', 'https://m.media-amazon.com/images/M/MV5BMTI1MTY2OTIxNV5BMl5BanBnXkFtZTYwNjQ4NjY3._V1_FMjpg_UX1000_.jpg', '2006-10-06', 'Crime, Drama, Thriller', '02:31:00', 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Scarface', 'https://m.media-amazon.com/images/M/MV5BNjdjNGQ4NDEtNTEwYS00MTgxLTliYzQtYzE2ZDRiZjFhZmNlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1983-12-09', 'Crime, Drama', '02:50:00', 'In 1980 Miami, a determined Cuban immigrant takes over a drug cartel and succumbs to greed.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Heat', 'https://m.media-amazon.com/images/M/MV5BYjZjNTJlZGUtZTE1Ny00ZDc4LTgwYjUtMzk0NDgwYzZjYTk1XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1995-12-15', 'Crime, Drama, Thriller', '02:50:00', 'A group of professional bank robbers start to feel the heat from police when they unknowingly leave a clue at their latest heist.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Casino', 'https://m.media-amazon.com/images/M/MV5BMTcxOWYzNDYtYmM4YS00N2NkLTk0NTAtNjg1ODgwZjAxYzI3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg', '1995-11-22', 'Biography, Crime, Drama', '02:58:00', 'A tale of greed, deception, money, power, and murder occur between two best friends: a mafia enforcer and a casino executive compete against each other over a gambling empire, and over a fast-living and fast-loving socialite.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Se7en', 'https://m.media-amazon.com/images/M/MV5BOTUwODM5MTctZjczMi00OTk4LTg3NWUtNmVhMTAzNTNjYjcyXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1995-09-22', 'Crime, Drama, Mystery', '02:07:00', 'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Silence of the Lambs', 'https://m.media-amazon.com/images/M/MV5BNjNhZTk0ZmEtNjJhMi00YzFlLWE1MmEtYzM1M2ZmMGMwMTU4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1991-02-14', 'Crime, Drama, Thriller', '01:58:00', 'A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Reservoir Dogs', 'https://m.media-amazon.com/images/M/MV5BZmExNmEwYWItYmQzOS00YjA5LTk2MjktZjEyZDE1Y2QxNjA1XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1992-10-23', 'Crime, Drama, Thriller', '01:39:00', 'When a simple jewelry heist goes horribly wrong, the surviving criminals begin to suspect that one of them is a police informant.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Usual Suspects', 'https://m.media-amazon.com/images/M/MV5BYTViNjMyNmUtNDFkNC00ZDRlLThmMDUtZDU2YWE4NGI2ZjVmXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1995-09-15', 'Crime, Mystery, Thriller', '01:46:00', 'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('L.A. Confidential', 'https://m.media-amazon.com/images/M/MV5BMDQ2YzEyZGItYWRhOS00MjBmLTkzMDUtMTdjYzkyMmQxZTJlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1997-09-19', 'Crime, Drama, Mystery', '02:18:00', 'As corruption grows in 1950s Los Angeles, three policemen -- one strait-laced, one brutal, and one sleazy -- investigate a series of murders with their own brand of justice.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('No Country for Old Men', 'https://m.media-amazon.com/images/M/MV5BMjA5Njk3MjM4OV5BMl5BanBnXkFtZTcwMTc5MTE1MQ@@._V1_FMjpg_UX1000_.jpg', '2007-11-21', 'Crime, Drama, Thriller', '02:02:00', 'Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Godfather: Part II', 'https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1974-12-20', 'Crime, Drama', '03:22:00', 'The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Training Day', 'https://m.media-amazon.com/images/M/MV5BMDZkMTUxYWEtMDY5NS00ZTA5LTg3MTItNTlkZWE1YWRjYjMwL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2001-10-05', 'Crime, Drama, Thriller', '02:02:00', 'A rookie cop spends his first day as a Los Angeles narcotics officer with a rogue detective who isn''t what he appears to be.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Taxi Driver', 'https://m.media-amazon.com/images/M/MV5BM2M1MmVhNDgtNmI0YS00ZDNmLTkyNjctNTJiYTQ2N2NmYzc2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1976-02-08', 'Crime, Drama', '01:54:00', 'A mentally unstable veteran works as a nighttime taxi driver in New York City, where the perceived decadence and sleaze fuels his urge for violent action by attempting to liberate a presidential campaign worker and an underage prostitute.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('City of God', 'https://m.media-amazon.com/images/M/MV5BMGU5OWEwZDItNmNkMC00NzZmLTk1YTctNzVhZTJjM2NlZTVmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2002-08-30', 'Crime, Drama', '02:10:00', 'In the slums of Rio, two kids'' paths diverge as one struggles to become a photographer and the other a kingpin.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Drive', 'https://m.media-amazon.com/images/M/MV5BZjY5ZjQyMjMtMmEwOC00Nzc2LTllYTItMmU2MzJjNTg1NjY0XkEyXkFqcGdeQXVyNjQ1MTMzMDQ@._V1_FMjpg_UX1000_.jpg', '2011-09-16', 'Crime, Drama', '01:40:00', 'A mysterious Hollywood stuntman and mechanic moonlights as a getaway driver and finds himself in trouble when he helps out his neighbor.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The French Connection', 'https://m.media-amazon.com/images/M/MV5BOTZhY2E3NmItMGIwNi00OTA2LThkYmEtODFiZTM0NGI0ZWU5XkEyXkFqcGdeQXVyNTc1NTQxODI@._V1_FMjpg_UX1000_.jpg', '1971-10-09', 'Action, Crime, Drama', '01:44:00', 'A pair of NYC cops in the Narcotics Bureau stumble onto a drug smuggling job with a French connection.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Infernal Affairs', 'https://m.media-amazon.com/images/M/MV5BZWM1MTdhM2YtNjgwZS00YjQ3LTk3NTQtMzQ1NDE3YzZlODFlXkEyXkFqcGdeQXVyMTI3ODAyMzE2._V1_FMjpg_UX1000_.jpg', '2002-12-12', 'Crime, Drama, Mystery', '01:41:00', 'A story between a mole in the police department and an undercover cop. Their objectives are the same: to find out who is the mole, and who is the cop.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('American Gangster', 'https://m.media-amazon.com/images/M/MV5BMjFmZGI2YTEtYmJhMS00YTE5LWJjNjAtNDI5OGY5ZDhmNTRlXkEyXkFqcGdeQXVyODAwMTU1MTE@._V1_FMjpg_UX1000_.jpg', '2007-11-02', 'Biography, Crime, Drama', '02:37:00', 'An outcast New York City cop is charged with bringing down Harlem drug lord Frank Lucas, whose real life inspired this partly biographical film.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Town', 'https://m.media-amazon.com/images/M/MV5BMTcyNzcxODg3Nl5BMl5BanBnXkFtZTcwMTUyNjQ3Mw@@._V1_FMjpg_UX1000_.jpg', '2010-09-17', 'Crime, Drama, Thriller', '02:05:00', 'A longtime thief, planning his next job, tries to balance his feelings for a bank manager connected to an earlier heist, and a hell-bent F.B.I Agent looking to bring him and his crew down.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Psycho', 'https://m.media-amazon.com/images/M/MV5BNTQwNDM1YzItNDAxZC00NWY2LTk0M2UtNDIwNWI5OGUyNWUxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '1960-09-08', 'Horror, Mystery, Thriller', '01:49:00', 'A Phoenix secretary embezzles $40,000 from her employer''s client, goes on the run, and checks into a remote motel run by a young man under the domination of his mother.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Rear Window', 'https://m.media-amazon.com/images/M/MV5BNGUxYWM3M2MtMGM3Mi00ZmRiLWE0NGQtZjE5ODI2OTJhNTU0XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1954-09-01', 'Mystery, Thriller', '01:52:00', 'A wheelchair-bound photographer spies on his neighbors from his apartment window and becomes convinced one of them has committed murder.', 'PG', 'PG - Parental Guidance Suggested. General Audiences.', NULL),
('The Sixth Sense', 'https://m.media-amazon.com/images/M/MV5BMWM4NTFhYjctNzUyNi00NGMwLTk3NTYtMDIyNTZmMzRlYmQyXkEyXkFqcGdeQXVyMTAwMzUyOTc@._V1_FMjpg_UX1000_.jpg', '1999-08-06', 'Drama, Mystery, Thriller', '01:47:00', 'A boy who communicates with spirits seeks the help of a disheartened child psychologist.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Shutter Island', 'https://m.media-amazon.com/images/M/MV5BYzhiNDkyNzktNTZmYS00ZTBkLTk2MDAtM2U0YjU1MzgxZjgzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2010-02-19', 'Mystery, Thriller', '02:18:00', 'In 1954, a U.S. Marshal investigates the disappearance of a murderer who escaped from a hospital for the criminally insane.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Gone Girl', 'https://m.media-amazon.com/images/M/MV5BMTk0MDQ3MzAzOV5BMl5BanBnXkFtZTgwNzU1NzE3MjE@._V1_FMjpg_UX1000_.jpg', '2014-10-03', 'Drama, Mystery, Thriller', '02:29:00', 'With his wife''s disappearance having become the focus of an intense media circus, a man sees the spotlight turned on him when it''s suspected that he may not be innocent.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Prisoners', 'https://m.media-amazon.com/images/M/MV5BMTg0NTIzMjQ1NV5BMl5BanBnXkFtZTcwNDc3MzM5OQ@@._V1_FMjpg_UX1000_.jpg', '2013-09-20', 'Crime, Drama, Mystery', '02:33:00', 'When Keller Dover''s daughter and her friend go missing, he takes matters into his own hands as the police pursue multiple leads and the pressure mounts.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Memento', 'https://m.media-amazon.com/images/M/MV5BZTcyNjk1MjgtOWI3Mi00YzQwLWI5MTktMzY4ZmI2NDAyNzYzXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2000-09-05', 'Mystery, Thriller', '01:53:00', 'A man with short-term memory loss attempts to track down his wife''s murderer.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Zodiac', 'https://m.media-amazon.com/images/M/MV5BN2UwNDc5NmEtNjVjZS00OTI5LWE5YjctMWM3ZjBiZGYwMGI2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg', '2007-03-02', 'Crime, Drama, Mystery', '02:42:00', 'In the late 1960s/early 1970s, a San Francisco cartoonist becomes an amateur detective obsessed with tracking down the Zodiac Killer, an unidentified individual who terrorizes Northern California with a killing spree.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Girl with the Dragon Tattoo', 'https://m.media-amazon.com/images/M/MV5BMTczNDk4NTQ0OV5BMl5BanBnXkFtZTcwNDAxMDgxNw@@._V1_FMjpg_UX1000_.jpg', '2011-12-20', 'Crime, Drama, Mystery', '02:38:00', 'Journalist Mikael Blomkvist is aided in his search for a woman who has been missing for forty years by Lisbeth Salander, a young computer hacker.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Black Swan', 'https://m.media-amazon.com/images/M/MV5BNzY2NzI4OTE5MF5BMl5BanBnXkFtZTcwMjMyNDY4Mw@@._V1_FMjpg_UX1000_.jpg', '2010-12-17', 'Drama, Thriller', '01:48:00', 'A committed dancer struggles to maintain her sanity after winning the lead role in a production of Tchaikovsky''s "Swan Lake".', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Others', 'https://m.media-amazon.com/images/M/MV5BYjVhMmM3ZTMtNzIzOS00YTY4LTkxNTAtOTA5Mjk3YzMwMzA2XkEyXkFqcGdeQXVyNDE0OTU3NDY@._V1_FMjpg_UX1000_.jpg', '2001-08-10', 'Horror, Mystery, Thriller', '01:44:00', 'A woman who lives in her darkened old family house with her two photosensitive children becomes convinced that the home is haunted.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Cape Fear', 'https://m.media-amazon.com/images/M/MV5BNjdhNzZlYzYtYTBlNS00NTJiLWI2ZWUtMDI2YzI2MzM5NjY4XkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_FMjpg_UX1000_.jpg', '1991-11-15', 'Crime, Thriller', '02:08:00', 'A convicted rapist, released from prison after serving a fourteen-year sentence, stalks the family of the lawyer who originally defended him.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Fugitive', 'https://m.media-amazon.com/images/M/MV5BYmFmOGZjYTItYjY1ZS00OWRiLTk0NDgtMjQ5MzBkYWE2YWE0XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '1993-08-06', 'Action, Crime, Drama', '02:10:00', 'Dr. Richard Kimble, unjustly accused of murdering his wife, must find the real killer while being the target of a nationwide manhunt led by a seasoned U.S. Marshal.', 'PG-13', 'PG-13 - Parents Strongly Cautioned. Some material may be inappropriate for children under 13.', NULL),
('Mystic River', 'https://m.media-amazon.com/images/M/MV5BMTIzNDUyMjA4MV5BMl5BanBnXkFtZTYwNDc4ODM3._V1_FMjpg_UX1000_.jpg', '2003-10-15', 'Crime, Drama, Mystery', '02:18:00', 'The lives of three men who were childhood friends are shattered when one of them has a family tragedy.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Insomnia', 'https://m.media-amazon.com/images/M/MV5BYzlkZTEyYjUtMTY5NS00ZjU0LTk5OTYtM2M0ZDg1NmNjMzhkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2002-05-24', 'Drama, Mystery, Thriller', '01:58:00', 'Two Los Angeles homicide detectives are dispatched to a northern town where the sun doesn''t set to investigate the methodical murder of a local teen.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Game', 'https://m.media-amazon.com/images/M/MV5BNWQ2ODFhNWItNTA4NS00MzkyLTgyYzUtZjlhYWE5MmEzY2Q1XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1997-09-12', 'Drama, Mystery, Thriller', '02:09:00', 'After a wealthy banker is given an opportunity to participate in a mysterious game, his life is turned upside down when he becomes unable to distinguish between the game and reality.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Girl on the Train', 'https://m.media-amazon.com/images/M/MV5BNzFlMjA0ZmUtZWI0Mi00ZGJkLTlmMmYtZmE1ODZiMjhjMGM0XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2016-10-07', 'Crime, Drama, Mystery', '01:52:00', 'A divorcee becomes entangled in a missing persons investigation that promises to send shockwaves throughout her life.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Primal Fear', 'https://m.media-amazon.com/images/M/MV5BZTM2NWI2OGYtYWNhMi00ZTlmLTg2ZTAtMmI5NWRjODA5YTE1XkEyXkFqcGdeQXVyODE2OTYwNTg@._V1_FMjpg_UX1000_.jpg', '1996-04-03', 'Crime, Drama, Mystery', '02:09:00', 'An altar boy is accused of murdering a priest, and the truth is buried several layers deep.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Donnie Darko', 'https://m.media-amazon.com/images/M/MV5BZjZlZDlkYTktMmU1My00ZDBiLWFlNjEtYTBhNjVhOTM4ZjJjXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_FMjpg_UX1000_.jpg', '2001-10-26', 'Drama, Mystery, Sci-Fi', '01:53:00', 'A troubled teenager is plagued by visions of a man in a large rabbit suit who manipulates him to commit a series of crimes, after he narrowly escapes a bizarre accident.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Machinist', 'https://m.media-amazon.com/images/M/MV5BNjk1NzBlY2YtNjJmNi00YTVmLWI2OTgtNDUxNDE5NjUzZmE0XkEyXkFqcGdeQXVyNTc1NTQxODI@._V1_FMjpg_UX1000_.jpg', '2004-10-22', 'Drama, Thriller', '01:41:00', 'An industrial worker who hasn''t slept in a year begins to doubt his own sanity.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('13th', 'https://m.media-amazon.com/images/M/MV5BMjAwMjU5NTAzOF5BMl5BanBnXkFtZTgwMjQwODQxMDI@._V1_FMjpg_UX1000_.jpg', '2016-10-07', 'Documentary, Crime, History', '01:40:00', 'An in-depth look at the prison system in the United States and how it reveals the nation''s history of racial inequality.', 'TV-MA', 'TV-MA - Mature Audiences.', NULL),
('Blackfish', 'https://m.media-amazon.com/images/M/MV5BNTkyNTkwMzkxMl5BMl5BanBnXkFtZTcwMzAwOTE2OQ@@._V1_FMjpg_UX1000_.jpg', '2013-07-19', 'Documentary, Biography, Crime', '01:23:00', 'A documentary following the controversial captivity of killer whales, and its dangers for both humans and whales.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('Fahrenheit 9/11', 'https://m.media-amazon.com/images/M/MV5BMjAyODU1NzM0NF5BMl5BanBnXkFtZTcwNjI1MjYyMQ@@._V1_FMjpg_UX1000_.jpg', '2004-06-25', 'Documentary, Drama, War', '02:02:00', 'Filmmaker Michael Moore examines the presidency of George W. Bush, the War on Terror, and its coverage in the media.', 'R', 'R - Restricted.', NULL),
('Bowling for Columbine', 'https://m.media-amazon.com/images/M/MV5BOWY2OWM1ODEtNDU5OS00MjMwLTliYzItZWZlOTEyYmQ2Njg4XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2002-10-11', 'Documentary, Crime, Drama', '02:00:00', 'Filmmaker Michael Moore explores the roots of America''s predilection for gun violence.', 'R', 'R - Restricted.', NULL),
('Supersize Me', 'https://m.media-amazon.com/images/M/MV5BMTYyOTk4MjIxOF5BMl5BanBnXkFtZTcwMzk1NTUyMQ@@._V1_FMjpg_UX1000_.jpg', '2004-06-11', 'Documentary, Comedy, Drama', '01:40:00', 'While examining the influence of the fast food industry, Morgan Spurlock personally explores the consequences on his health of a diet of solely McDonald''s food for one month.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('An Inconvenient Truth', 'https://m.media-amazon.com/images/M/MV5BOTg3NjYxMjM5OF5BMl5BanBnXkFtZTcwMzQzMDA0MQ@@._V1_FMjpg_UX1000_.jpg', '2006-06-30', 'Documentary', '01:36:00', 'Filmmaker Davis Guggenheim follows Al Gore on the lecture circuit, as the former presidential candidate campaigns to raise public awareness of the dangers of global warming and calls for immediate action to curb its destructive effects on the environment.', 'PG', 'PG - Parental Guidance.', NULL),
('The Cove', 'https://m.media-amazon.com/images/M/MV5BMzM3NTRhMTctNTE2MS00YjJmLWE2ZmMtMmY3MWI0ODExMTMzXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg', '2009-08-07', 'Documentary, Crime, Drama', '01:32:00', 'Using state-of-the-art equipment, a group of activists, led by renowned dolphin trainer Ric O''Barry, infiltrate a cove near Taijii, Japan to expose both a shocking instance of animal abuse and a serious threat to human health.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('Won''t You Be My Neighbor?', 'https://m.media-amazon.com/images/M/MV5BMjM1NDg1MjUzNF5BMl5BanBnXkFtZTgwNTAxNjIzNTM@._V1_FMjpg_UX1000_.jpg', '2018-06-29', 'Documentary, Biography', '01:34:00', 'An exploration of the life, lessons, and legacy of iconic children''s television host, Fred Rogers.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('March of the Penguins', 'https://m.media-amazon.com/images/M/MV5BMTM1NDc5MDYxMl5BMl5BanBnXkFtZTcwMjMzNDAzMQ@@._V1_FMjpg_UX1000_.jpg', '2005-06-24', 'Documentary, Family', '01:20:00', 'In the Antarctic, every March since the beginning of time, the quest begins to find the perfect mate and start a family.', 'G', 'G - General Audiences.', NULL),
('Man on Wire', 'https://m.media-amazon.com/images/M/MV5BMTMxNTk3NDY1NV5BMl5BanBnXkFtZTcwNDk0ODg3MQ@@._V1_FMjpg_UX1000_.jpg', '2008-08-29', 'Documentary, Biography, Crime', '01:34:00', 'A look at tightrope walker Philippe Petit''s daring, but illegal, high-wire routine performed between New York City''s World Trade Center''s twin towers in 1974, what some consider, "the artistic crime of the century."', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('Food, Inc.', 'https://m.media-amazon.com/images/M/MV5BZGNhYTA1ODMtY2M5Yy00MTYwLWFlZmEtNDM4M2I4ZTI2ZmVmXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg', '2009-07-31', 'Documentary', '01:34:00', 'An unflattering look inside America''s corporate controlled food industry.', 'PG', 'PG - Parental Guidance.', NULL),
('Inside Job', 'https://m.media-amazon.com/images/M/MV5BMTQ3MjkyODA2Nl5BMl5BanBnXkFtZTcwNzQxMTU4Mw@@._V1_FMjpg_UX1000_.jpg', '2010-10-08', 'Documentary, Crime', '01:49:00', 'Takes a closer look at what brought about the 2008 financial meltdown.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('The Act of Killing', 'https://m.media-amazon.com/images/M/MV5BNmZjMDgyMDgtYWI4OS00YjZkLWEyODktNzE0MmViOTFjMDA4XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_FMjpg_UX1000_.jpg', '2012-08-30', 'Documentary, Crime', '01:57:00', 'A documentary which challenges former Indonesian death squad leaders to reenact their real-life mass killings in whichever cinematic genres they wish, including classic Hollywood crime scenarios and lavish musical numbers.', 'Unrated', 'Not Rated.', NULL),
('Exit Through the Gift Shop', 'https://m.media-amazon.com/images/M/MV5BMjE2NTg1NDM4Ml5BMl5BanBnXkFtZTcwMzMxOTkyMw@@._V1_FMjpg_UX1000_.jpg', '2010-04-16', 'Documentary, Comedy, Crime', '01:27:00', 'The story of how an eccentric French shop-keeper and amateur film-maker attempted to locate and befriend Banksy, only to have the artist turn the camera back on its owner.', 'R', 'R - Restricted.', NULL),
('Jiro Dreams of Sushi', 'https://m.media-amazon.com/images/M/MV5BMTA5NzQzODUxOTheQTJeQWpwZ15BbWU3MDIwODg1MDc@._V1_FMjpg_UX1000_.jpg', '2012-03-15', 'Documentary', '01:21:00', 'A documentary on 85-year-old sushi master Jiro Ono, his renowned Tokyo restaurant, and his relationship with his son and eventual heir, Yoshikazu.', 'PG', 'PG - Parental Guidance.', NULL),
('Searching for Sugar Man', 'https://m.media-amazon.com/images/M/MV5BMjA5Nzc2NDUyN15BMl5BanBnXkFtZTcwNjQwMjc5Nw@@._V1_FMjpg_UX1000_.jpg', '2012-07-27', 'Documentary, Biography, Music', '01:26:00', 'Two South Africans set out to discover what happened to their unlikely musical hero, the mysterious 1970s rock ''n'' roller, Rodriguez.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('The Fog of War', 'https://m.media-amazon.com/images/M/MV5BMTc3MTA4NDgzNl5BMl5BanBnXkFtZTcwOTAxNTQyMQ@@._V1_FMjpg_UX1000_.jpg', '2004-01-23', 'Documentary, Biography, History', '01:47:00', 'The story of America as seen through the eyes of the former Secretary of Defense, under President Kennedy and President Johnson, Robert S. McNamara.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('Citizenfour', 'https://m.media-amazon.com/images/M/MV5BMTc0MTM0MTA5MF5BMl5BanBnXkFtZTgwNzEwODEwMzE@._V1_FMjpg_UX1000_.jpg', '2014-10-24', 'Documentary, Biography, Crime', '01:54:00', 'A documentarian and a reporter travel to Hong Kong for the first of many meetings with Edward Snowden.', 'R', 'R - Restricted.', NULL),
('Free Solo', 'https://m.media-amazon.com/images/M/MV5BMjMwYjcwNWQtNTQ5YS00MzVlLTkxYzMtNDIwZWIxZTE4Zjg2XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2018-09-28', 'Documentary, Sport', '01:40:00', 'Follow Alex Honnold as he becomes the first person to ever free solo climb Yosemite''s 3,000ft high El Capitan Wall.', 'PG-13', 'PG-13 - Parents Strongly Cautioned.', NULL),
('RBG', 'https://m.media-amazon.com/images/M/MV5BNTE4Nzc0NDU3Nl5BMl5BanBnXkFtZTgwODIzMTQzNTM@._V1_FMjpg_UX1000_.jpg', '2018-05-04', 'Documentary, Biography', '01:38:00', 'The exceptional life and career of U.S. Supreme Court Justice Ruth Bader Ginsburg, who has developed a breathtaking legal legacy while becoming an unexpected pop culture icon.', 'PG', 'PG - Parental Guidance.', NULL),
('The Exorcist', 'https://m.media-amazon.com/images/M/MV5BYWFlZGY2NDktY2ZjOS00ZWNkLTg0ZDAtZDY4MTM1ODU4ZjljXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1973-12-26', 'Horror', '02:02:00', 'When a teenage girl is possessed by a mysterious entity, her mother seeks the help of two priests to save her daughter.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Get Out', 'https://m.media-amazon.com/images/M/MV5BMjUxMDQwNjcyNl5BMl5BanBnXkFtZTgwNzcwMzc0MTI@._V1_FMjpg_UX1000_.jpg', '2017-02-24', 'Horror, Mystery, Thriller', '01:44:00', 'A young African-American visits his white girlfriend''s parents for the weekend, where his simmering uneasiness about their reception of him eventually reaches a boiling point.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Hereditary', 'https://m.media-amazon.com/images/M/MV5BOTU5MDg3OGItZWQ1Ny00ZGVmLTg2YTUtMzBkYzQ1YWIwZjlhXkEyXkFqcGdeQXVyNTAzMTY4MDA@._V1_FMjpg_UX1000_.jpg', '2018-06-08', 'Drama, Horror, Mystery', '02:07:00', 'A grieving family is haunted by tragic and disturbing occurrences.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('A Nightmare on Elm Street', 'https://m.media-amazon.com/images/M/MV5BNzFjZmM1ODgtMDBkMS00NWFlLTg2YmUtZjc3ZTgxMjE1OTI2L2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', '1984-11-16', 'Horror', '01:31:00', 'The monstrous spirit of a slain child murderer seeks revenge by invading the dreams of teenagers whose parents were responsible for his untimely death.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Babadook', 'https://m.media-amazon.com/images/M/MV5BMTk0NzMzODc2NF5BMl5BanBnXkFtZTgwOTYzNTM1MzE@._V1_FMjpg_UX1000_.jpg', '2014-05-22', 'Drama, Horror, Thriller', '01:34:00', 'A single mother and her child fall into a deep well of paranoia when an eerie children''s book titled "Mister Babadook" manifests in their home.', 'Not Rated', 'Not Rated - Not rated by the MPAA.', NULL),
('Rosemary''s Baby', 'https://m.media-amazon.com/images/M/MV5BMTA5NWQwMmYtZjEyYS00Nzc2LTgwZjAtNTQ4NmFmZjNkNjg4XkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UX1000_.jpg', '1968-06-12', 'Drama, Horror', '02:16:00', 'A young couple moves into an apartment, only to be surrounded by peculiar neighbors and occurrences. When the wife becomes mysteriously pregnant, paranoia over the safety of her unborn child begins to control her life.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Texas Chain Saw Massacre', 'https://m.media-amazon.com/images/M/MV5BZDI3OWE0ZWMtNGJjOS00N2E4LWFiOTAtZjQ4OTNiNzIwN2NkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1974-10-01', 'Horror', '01:23:00', 'Two siblings and three of their friends en route to visit their grandfather''s grave in Texas end up falling victim to a family of cannibalistic psychopaths and must survive the terrors of Leatherface and his family.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Halloween', 'https://m.media-amazon.com/images/M/MV5BNzk1OGU2NmMtNTdhZC00NjdlLWE5YTMtZTQ0MGExZTQzOGQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1978-10-25', 'Horror, Thriller', '01:31:00', 'Fifteen years after murdering his sister on Halloween night 1963, Michael Myers escapes from a mental hospital and returns to the small town of Haddonfield, Illinois to kill again.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Witch', 'https://m.media-amazon.com/images/M/MV5BMTUyNzkwMzAxOF5BMl5BanBnXkFtZTgwMzc1OTk1NjE@._V1_FMjpg_UX1000_.jpg', '2016-02-19', 'Drama, Horror, Mystery', '01:32:00', 'A family in 1630s New England is torn apart by the forces of witchcraft, black magic, and possession.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('It Follows', 'https://m.media-amazon.com/images/M/MV5BMmU0MjBlYzYtZWY0MC00MjliLWI3ZmUtMzhlZDVjMWVmYWY4XkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '2015-03-27', 'Horror, Mystery', '01:40:00', 'A young woman is followed by an unknown supernatural force after getting involved in a sexual encounter.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Conjuring', 'https://m.media-amazon.com/images/M/MV5BMTM3NjA1NDMyMV5BMl5BanBnXkFtZTcwMDQzNDMzOQ@@._V1_FMjpg_UX1000_.jpg', '2013-07-19', 'Horror, Mystery, Thriller', '01:52:00', 'Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Suspiria', 'https://m.media-amazon.com/images/M/MV5BZGRjNjljOGEtZjFmMi00YzU1LWIxOWYtZTQzODMzNDQzMzY1XkEyXkFqcGdeQXVyNDE5MTU2MDE@._V1_FMjpg_UX1000_.jpg', '1977-02-01', 'Horror', '01:32:00', 'An American newcomer to a prestigious German ballet academy comes to realize that the school is a front for something sinister amid a series of grisly murders.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('28 Days Later', 'https://m.media-amazon.com/images/M/MV5BYTFkM2ViMmQtZmI5NS00MjQ2LWEyN2EtMTI1ZmNlZDU3MTZjXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg', '2003-06-27', 'Horror, Sci-Fi', '01:53:00', 'Four weeks after a mysterious, incurable virus spreads throughout the UK, a handful of survivors try to find sanctuary.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Blair Witch Project', 'https://m.media-amazon.com/images/M/MV5BNzQ1NDBlNDItMDAyYS00YTI2LTgwMmYtMzAwMzg4NDFlM2ZmXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg', '1999-07-30', 'Horror, Mystery', '01:21:00', 'Three film students vanish after traveling into a Maryland forest to film a documentary on the local Blair Witch legend, leaving only their footage behind.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('The Thing', 'https://m.media-amazon.com/images/M/MV5BNGViZWZmM2EtNGYzZi00ZDAyLTk3ODMtNzIyZTBjN2Y1NmM1XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg', '1982-06-25', 'Horror, Mystery, Sci-Fi', '01:49:00', 'A research team in Antarctica is hunted by a shape-shifting alien that assumes the appearance of its victims.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL),
('Paranormal Activity', 'https://m.media-amazon.com/images/M/MV5BMjY1NjcxODQ4MV5BMl5BanBnXkFtZTcwMzUxNjM4Mg@@._V1_FMjpg_UX1000_.jpg', '2009-10-16', 'Horror, Mystery', '01:26:00', 'After moving into a suburban home, a couple becomes increasingly disturbed by a nightly demonic presence.', 'R', 'R - Restricted. Under 17 requires accompanying parent or adult guardian.', NULL);

-- updating plot summaries where ChatGPT missed them
UPDATE movies
SET plot = 'The adventures of Gustave H, a legendary concierge at a famous European hotel between the wars, and Zero Moustafa, the lobby boy who becomes his most trusted friend. The story involves the theft and recovery of a priceless Renaissance painting and the battle for an enormous family fortune – all against the backdrop of a suddenly and dramatically changing Continent.'
WHERE titletext = 'The Grand Budapest Hotel';

UPDATE movies
SET plot = 'Two co-dependent high school seniors are forced to deal with separation anxiety after their plan to stage a booze-soaked party goes awry.'
WHERE titletext = 'Superbad';

UPDATE movies
SET plot = 'King Arthur and his Knights of the Round Table embark on a surreal, low-budget search for the Holy Grail, encountering many, very silly obstacles.'
WHERE titletext = 'Monty Python and the Holy Grail';

UPDATE movies
SET plot = 'A man afraid to fly must ensure that a plane lands safely after the pilots become sick.'
WHERE titletext = 'Airplane!';

UPDATE movies
SET plot = 'Jeff "The Dude" Lebowski, mistaken for a millionaire of the same name, seeks restitution for his ruined rug and enlists his bowling buddies to help get it.'
WHERE titletext = 'The Big Lebowski';

UPDATE movies
SET plot = 'Ron Burgundy is San Diego''s top-rated newsman in the male-dominated broadcasting of the 1970s, but that''s all about to change for Ron and his cronies when an ambitious woman is hired as a new anchor.'
WHERE titletext = 'Anchorman: The Legend of Ron Burgundy';

UPDATE movies
SET plot = 'The cross-country adventures of two good-hearted but incredibly stupid friends.'
WHERE titletext = 'Dumb and Dumber';

UPDATE movies
SET plot = 'Competition between the maid of honor and a bridesmaid, over who is the bride''s best friend, threatens to upend the life of an out-of-work pastry chef.'
WHERE titletext = 'Bridesmaids';

UPDATE movies
SET plot = 'A listless and alienated teenager decides to help his new friend win the class presidency in their small western high school, while he must deal with his bizarre family life back home.'
WHERE titletext = 'Napoleon Dynamite';

UPDATE movies
SET plot = 'A man''s uneventful life is disrupted by the zombie apocalypse.'
WHERE titletext = 'Shaun of the Dead';

UPDATE movies
SET plot = 'A high school wise guy is determined to have a day off from school, despite what the Principal thinks of that.'
WHERE titletext = 'Ferris Bueller''s Day Off';

UPDATE movies
SET plot = 'While home sick in bed, a young boy''s grandfather reads him the story of a farmboy-turned-pirate who encounters numerous obstacles, enemies, and allies in his quest to be reunited with his true love.'
WHERE titletext = 'The Princess Bride';

UPDATE movies
SET plot = 'A weatherman finds himself inexplicably living the same day over and over again.'
WHERE titletext = 'Groundhog Day';

UPDATE movies
SET plot = 'A struggling musician poses as a substitute teacher at a prestigious prep school, where he teaches his students about rock music.'
WHERE titletext = 'School of Rock';

UPDATE movies
SET plot = 'A down-on-his-luck Broadway producer and his accountant come up with a scheme to produce the worst musical ever in order to make money.'
WHERE titletext = 'The Producers';

UPDATE movies
SET plot = 'A dysfunctional family takes a cross-country trip in their VW bus so their daughter can compete in a beauty pageant.'
WHERE titletext = 'Little Miss Sunshine';

UPDATE movies
SET plot = 'A top London cop is reassigned to a small town, where he discovers a dark secret amidst a series of mysterious accidents.'
WHERE titletext = 'Hot Fuzz';

UPDATE movies
SET plot = 'A man''s childhood teddy bear, who came to life as a result of a wish, complicates his adult life and relationship with his girlfriend.'
WHERE titletext = 'Ted';

UPDATE movies
SET plot = 'A mockumentary about a fictional British rock band on tour.'
WHERE titletext = 'This Is Spinal Tap';

UPDATE movies
SET plot = 'In a post-apocalyptic world overrun by zombies, a group of survivors forms an unlikely alliance to travel across the country.'
WHERE titletext = 'Zombieland';

UPDATE movies
SET plot = 'A bumbling police detective must stop an assassination attempt on Queen Elizabeth II.'
WHERE titletext = 'The Naked Gun: From the Files of Police Squad!';

UPDATE movies
SET plot = 'A wealthy investor and a street hustler find their lives reversed due to a bet between two wealthy brothers.'
WHERE titletext = 'Trading Places';

UPDATE movies
SET plot = 'A middle-aged man, who has never had sex, embarks on a journey to lose his virginity with the help of his friends.'
WHERE titletext = 'The 40-Year-Old Virgin';

UPDATE movies
SET plot = 'A parody of science fiction films, following the adventures of a rogue star pilot and his companions as they attempt to save a Princess.'
WHERE titletext = 'Spaceballs';

UPDATE movies
SET plot = 'An African prince travels to Queens, New York City, to find a wife whom he can respect for her intelligence and will.'
WHERE titletext = 'Coming to America';

UPDATE movies
SET plot = 'An exclusive golf course has to deal with a brash new member and a destructive dancing gopher.'
WHERE titletext = 'Caddyshack';

UPDATE movies
SET plot = 'Three company workers who hate their jobs decide to rebel against their greedy boss.'
WHERE titletext = 'Office Space';

UPDATE movies
SET plot = 'Two slacker friends try to promote their public-access cable show.'
WHERE titletext = 'Wayne''s World';

UPDATE movies
SET plot = 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.'
WHERE titletext = 'Blade Runner';

UPDATE movies
SET plot = 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee, and two droids to save the galaxy from the Empire''s world-destroying Death Star.'
WHERE titletext = 'Star Wars: Episode IV - A New Hope';

UPDATE movies
SET plot = 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.'
WHERE titletext = 'Interstellar';

UPDATE movies
SET plot = 'The crew of a commercial spacecraft encounter a deadly extraterrestrial being.'
WHERE titletext = 'Alien';

UPDATE movies
SET plot = 'A cyborg assassin is sent back in time to kill the mother of the future leader of the resistance, while a soldier from that war is sent to protect her.'
WHERE titletext = 'The Terminator';

UPDATE movies
SET plot = 'During a preview tour, a theme park suffers a major power breakdown that allows its cloned dinosaur exhibits to run amok.'
WHERE titletext = 'Jurassic Park';

UPDATE movies
SET plot = 'In the colorful future, a cab driver unwittingly becomes the central figure in the search for a legendary cosmic weapon to keep Evil and Mr. Zorg at bay.'
WHERE titletext = 'The Fifth Element';

UPDATE movies
SET plot = 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.'
WHERE titletext = 'Avatar';

UPDATE movies
SET plot = 'An astronaut becomes stranded on Mars after his team assumes him dead, and must rely on his ingenuity to find a way to signal to Earth that he is alive.'
WHERE titletext = 'The Martian';

UPDATE movies
SET plot = 'Humanity finds a mysterious, obviously artificial object buried beneath the Lunar surface and, with the intelligent computer H.A.L. 9000, sets off on a quest.'
WHERE titletext = '2001: A Space Odyssey';

UPDATE movies
SET plot = 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.'
WHERE titletext = 'E.T. the Extra-Terrestrial';

UPDATE movies
SET plot = 'A young man is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his friend, Dr. Emmett Brown.'
WHERE titletext = 'Back to the Future';

UPDATE movies
SET plot = 'Earth''s mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.'
WHERE titletext = 'The Avengers';

UPDATE movies
SET plot = 'Katniss Everdeen voluntarily takes her younger sister''s place in the Hunger Games: a televised competition in which two teenagers from each of the twelve Districts of Panem are chosen at random to fight to the death.'
WHERE titletext = 'The Hunger Games';

UPDATE movies
SET plot = 'The brash James T. Kirk tries to live up to his father''s legacy with Mr. Spock keeping him in check as a vengeful Romulan from the future creates black holes to destroy the Federation one planet at a time.'
WHERE titletext = 'Star Trek';

UPDATE movies
SET plot = 'An extraterrestrial race forced to live in slum-like conditions on Earth suddenly find a kindred spirit in a government agent who is exposed to their biotechnology.'
WHERE titletext = 'District 9';

UPDATE movies
SET plot = 'A small town in California is attacked by Martians, beginning a worldwide invasion.'
WHERE titletext = 'The War of the Worlds';

UPDATE movies
SET plot = 'A mysterious alien spacecraft lands in Washington, D.C., and an alien emissary delivers a chilling ultimatum to Earth.'
WHERE titletext = 'The Day the Earth Stood Still';

UPDATE movies
SET plot = 'Two astronauts work together to survive after an accident leaves them stranded in space.'
WHERE titletext = 'Gravity';

UPDATE movies
SET plot = 'After an encounter with U.F.O.s, a line worker feels undeniably drawn to an isolated area in the wilderness where something spectacular is about to happen.'
WHERE titletext = 'Close Encounters of the Third Kind';

UPDATE movies
SET plot = 'A young boy befriends a giant robot from outer space that a paranoid government agent wants to destroy.'
WHERE titletext = 'The Iron Giant';

UPDATE movies
SET plot = 'As a war between humankind and monstrous sea creatures wages on, a former pilot and a trainee are paired up to drive a seemingly obsolete special weapon in a desperate effort to save the world from the apocalypse.'
WHERE titletext = 'Pacific Rim';

UPDATE movies
SET plot = 'A young programmer is selected to participate in a ground-breaking experiment in synthetic intelligence by evaluating the human qualities of a highly advanced humanoid A.I.'
WHERE titletext = 'Ex Machina';

UPDATE movies
SET plot = 'In 2074, when the mob wants to get rid of someone, the target is sent into the past, where a hired gun awaits - someone like Joe - who one day learns the mob wants to ''close the loop'' by sending back Joe''s future self for assassination.'
WHERE titletext = 'Looper';

UPDATE movies
SET plot = 'Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion.'
WHERE titletext = 'The Prestige';

UPDATE movies
SET plot = 'In a future where a special police unit is able to arrest murderers before they commit their crimes, an officer from that unit is himself accused of a future murder.'
WHERE titletext = 'Minority Report';

UPDATE movies
SET plot = 'A civilian diving team is enlisted to search for a lost nuclear submarine and faces danger while encountering an alien aquatic species.'
WHERE titletext = 'The Abyss';

UPDATE movies
SET plot = 'Archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before the Nazis.'
WHERE titletext = 'Indiana Jones and the Raiders of the Lost Ark';

UPDATE movies
SET plot = 'An American serving in the French Foreign Legion on an archaeological dig at the ancient city of Hamunaptra accidentally awakens a mummy.'
WHERE titletext = 'The Mummy';

UPDATE movies
SET plot = 'A group of young misfits who call themselves The Goonies discover an ancient map and set out on a quest to find a legendary pirate''s long-lost treasure.'
WHERE titletext = 'The Goonies';

UPDATE movies
SET plot = 'A historian races to find the legendary Templar Treasure before a team of mercenaries.'
WHERE titletext = 'National Treasure';

UPDATE movies
SET plot = 'Bagheera the Panther and Baloo the Bear have a difficult time trying to convince a boy to leave the jungle for human civilization.'
WHERE titletext = 'The Jungle Book';

UPDATE movies
SET plot = 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search of her homeland with the help of a group of female prisoners, a psychotic worshiper, and a drifter named Max.'
WHERE titletext = 'Mad Max: Fury Road';

UPDATE movies
SET plot = 'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it, from the dragon Smaug.'
WHERE titletext = 'The Hobbit: An Unexpected Journey';

UPDATE movies
SET plot = 'In Africa during World War I, a gin-swilling riverboat captain is persuaded by a strait-laced missionary to use his boat to attack an enemy warship.'
WHERE titletext = 'The African Queen';

UPDATE movies
SET plot = 'Two Americans searching for work in Mexico convince an old prospector to help them mine for gold in the Sierra Madre Mountains.'
WHERE titletext = 'The Treasure of the Sierra Madre';

UPDATE movies
SET plot = 'A frontiersman on a fur trading expedition in the 1820s fights for survival after being mauled by a bear and left for dead by members of his own hunting team.'
WHERE titletext = 'The Revenant';

UPDATE movies
SET plot = 'A film crew goes to a tropical island for an exotic location shoot and discovers a colossal ape who takes a shine to their female blonde star.'
WHERE titletext = 'King Kong';

UPDATE movies
SET plot = 'Master explorer Dirk Pitt goes on the adventure of a lifetime of seeking out a lost Civil War battleship known as the "Ship of Death" in the deserts of West Africa.'
WHERE titletext = 'Sahara';

UPDATE movies
SET plot = 'A daydreamer escapes his anonymous life by disappearing into a world of fantasies filled with heroism, romance, and action.'
WHERE titletext = 'The Secret Life of Walter Mitty';

UPDATE movies
SET plot = 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family, and the terrible evil that haunts the magical world.'
WHERE titletext = 'Harry Potter and the Sorcerer''s Stone';

UPDATE movies
SET plot = 'In the falangist Spain of 1944, the bookish young stepdaughter of a sadistic army officer escapes into an eerie but captivating fantasy world.'
WHERE titletext = 'Pan''s Labyrinth';

UPDATE movies
SET plot = 'In a countryside town bordering on a magical land, a young man makes a promise to his beloved that he''ll retrieve a fallen star by venturing into the magical realm.'
WHERE titletext = 'Stardust';

UPDATE movies
SET plot = 'Dorothy Gale is swept away from a farm in Kansas to a magical land of Oz in a tornado and embarks on a quest with her new friends to see the Wizard who can help her return home to Kansas and help her friends as well.'
WHERE titletext = 'The Wizard of Oz';

UPDATE movies
SET plot = 'Nineteen-year-old Alice returns to the magical world from her childhood adventure, where she reunites with her old friends and learns of her true destiny: to end the Red Queen''s reign of terror.'
WHERE titletext = 'Alice in Wonderland';

UPDATE movies
SET plot = 'A troubled boy dives into a wondrous fantasy world through the pages of a mysterious book.'
WHERE titletext = 'The NeverEnding Story';

UPDATE movies
SET plot = 'When an unconfident young woman is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking castle.'
WHERE titletext = 'Howl''s Moving Castle';

UPDATE movies
SET plot = 'During her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.'
WHERE titletext = 'Spirited Away';

UPDATE movies
SET plot = 'On another planet in the distant past, a Gelfling embarks on a quest to find the missing shard of a magical crystal, and so restore order to his world.'
WHERE titletext = 'The Dark Crystal';

UPDATE movies
SET plot = 'A young farmer is chosen to undertake a perilous journey in order to protect a special baby from an evil queen.'
WHERE titletext = 'Willow';

UPDATE movies
SET plot = 'To save her ill son, a field mouse must seek the aid of a colony of rats, with whom she has a deeper link than she ever suspected.'
WHERE titletext = 'The Secret of NIMH';

UPDATE movies
SET plot = 'In a parallel universe, young Lyra Belacqua journeys to the far North to save her best friend and other kidnapped children from terrible experiments by a mysterious organization.'
WHERE titletext = 'The Golden Compass';

UPDATE movies
SET plot = 'A selfish 16-year-old girl is given 13 hours to solve a labyrinth and rescue her baby brother when her wish for him to be taken away is granted by the Goblin King.'
WHERE titletext = 'Labyrinth';

UPDATE movies
SET plot = 'Jack Skellington, king of Halloween Town, discovers Christmas Town, but his attempts to bring Christmas to his home causes confusion.'
WHERE titletext = 'The Nightmare Before Christmas';

UPDATE movies
SET plot = 'As Harry, Ron, and Hermione race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows.'
WHERE titletext = 'Harry Potter and the Deathly Hallows - Part 1';

UPDATE movies
SET plot = 'In his homeland of Alagaesia, a farm boy happens upon a dragon''s egg -- a discovery that leads him on a predestined journey where he realizes he''s the one person who can defend his home against an evil king.'
WHERE titletext = 'Eragon';

UPDATE movies
SET plot = 'Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, but is later sued by two brothers who claimed he stole their idea, and the co-founder who was later squeezed out of the business.'
WHERE titletext = 'The Social Network';

UPDATE movies
SET plot = 'The story of King George VI, his impromptu ascension to the throne of the British Empire in 1936, and the speech therapist who helped the unsure monarch overcome his stammer.'
WHERE titletext = 'The King''s Speech';

UPDATE movies
SET plot = 'The life of the lawyer who became the famed leader of the Indian revolts against the British rule through his philosophy of nonviolent protest.'
WHERE titletext = 'Gandhi';

UPDATE movies
SET plot = 'A look at the relationship between the famous physicist Stephen Hawking and his wife.'
WHERE titletext = 'The Theory of Everything';

UPDATE movies
SET plot = 'Three buddies wake up from a bachelor party in Las Vegas, with no memory of the previous night and the bachelor missing. They make their way around the city in order to find their friend before his wedding.'
WHERE titletext = 'The Hangover';

UPDATE movies
SET plot = 'After John Nash, a brilliant but asocial mathematician, accepts secret work in cryptography, his life takes a turn for the nightmarish.'
WHERE titletext = 'A Beautiful Mind';

UPDATE movies
SET plot = 'A seasoned FBI agent pursues Frank Abagnale Jr. who, before his 19th birthday, successfully forged millions of dollars'' worth of checks while posing as a Pan Am pilot, a doctor, and a legal prosecutor.'
WHERE titletext = 'Catch Me If You Can';

UPDATE movies
SET plot = 'A struggling salesman takes custody of his son as he''s poised to begin a life-changing professional career.'
WHERE titletext = 'The Pursuit of Happyness';

UPDATE movies
SET plot = 'During World War II, the English mathematical genius Alan Turing tries to crack the German Enigma code with help from fellow mathematicians.'
WHERE titletext = 'The Imitation Game';

UPDATE movies
SET plot = 'The story of the life and career of the legendary rhythm and blues musician Ray Charles, from his humble beginnings in the South, where he went blind at age seven, to his meteoric rise to stardom during the 1950s and 1960s.'
WHERE titletext = 'Ray';

UPDATE movies
SET plot = 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.'
WHERE titletext = 'Goodfellas';

UPDATE movies
SET plot = 'Biographical epic of the controversial and influential Black Nationalist leader, from his early life and career as a small-time gangster, to his ministry as a member of the Nation of Islam.'
WHERE titletext = 'Malcolm X';


UPDATE movies
SET plot = 'A biopic depicting the early years of legendary director and aviator Howard Hughes'' career, from the late 1920s to the mid-1940s.'
WHERE titletext = 'The Aviator';

UPDATE movies
SET plot = 'After graduating from Emory University, top student and athlete Christopher McCandless abandons his possessions, gives his entire savings account to charity, and hitchhikes to Alaska to live in the wilderness.'
WHERE titletext = 'Into the Wild';

UPDATE movies
SET plot = 'As the Civil War continues to rage, America''s president struggles with continuing carnage on the battlefield as he fights with many inside his own cabinet on the decision to emancipate the slaves.'
WHERE titletext = 'Lincoln';

UPDATE movies
SET plot = 'A Victorian surgeon rescues a heavily disfigured man who is mistreated while scraping a living as a side-show freak. Behind his monstrous facade, there is revealed a person of intelligence and sensitivity.'
WHERE titletext = 'The Elephant Man';

UPDATE movies
SET plot = 'An unemployed single mother becomes a legal assistant and almost single-handedly brings down a California power company accused of polluting a city''s water supply.'
WHERE titletext = 'Erin Brockovich';

UPDATE movies
SET plot = 'The story of T.E. Lawrence, the English officer who successfully united and led the diverse, often warring, Arab tribes during World War I in order to fight the Turks.'
WHERE titletext = 'Lawrence of Arabia';

UPDATE movies
SET plot = 'In 1959, Truman Capote learns of the murder of a Kansas family and decides to write a book about the case. While researching for his novel In Cold Blood, Capote forms a relationship with one of the killers, Perry Smith, who is on death row.'
WHERE titletext = 'Capote';

UPDATE movies
SET plot = 'When his secret bride is executed for assaulting an English soldier who tried to rape her, William Wallace begins a revolt against King Edward I of England.'
WHERE titletext = 'Braveheart';

UPDATE movies
SET plot = 'A chronicle of country music legend Johnny Cash''s life, from his early days on an Arkansas cotton farm to his rise to fame with Sun Records in Memphis, where he recorded alongside Elvis Presley, Jerry Lee Lewis, and Carl Perkins.'
WHERE titletext = 'Walk the Line';

UPDATE movies
SET plot = 'Steve Jobs takes us behind the scenes of the digital revolution, to paint a portrait of the man at its epicenter. The story unfolds backstage at three iconic product launches, ending in 1998 with the unveiling of the iMac.'
WHERE titletext = 'Steve Jobs';

UPDATE movies
SET plot = 'The true story of Michael Oher, a homeless and traumatized boy who became an All-American football player and first-round NFL draft pick with the help of a caring woman and her family.'
WHERE titletext = 'The Blind Side';

UPDATE movies
SET plot = 'A mountain climber becomes trapped under a boulder while canyoneering alone near Moab, Utah and resorts to desperate measures in order to survive.'
WHERE titletext = '127 Hours';

UPDATE movies
SET plot = 'The incredible story of Wolfgang Amadeus Mozart, told by his peer and secret rival Antonio Salieri - now confined to an insane asylum.'
WHERE titletext = 'Amadeus';

UPDATE movies
SET plot = 'Christy Brown, born with cerebral palsy, learns to paint and write with his only controllable limb - his left foot.'
WHERE titletext = 'My Left Foot';

UPDATE movies
SET plot = 'A chronicle of Dr. Martin Luther King, Jr.''s campaign to secure equal voting rights via an epic march from Selma to Montgomery, Alabama, in 1965.'
WHERE titletext = 'Selma';

UPDATE movies
SET plot = 'A film about the troubled and controversial life of the master comedy filmmaker Charles Chaplin.'
WHERE titletext = 'Chaplin';


--Adding synopsis to movies (Thanks to Lord ChadGPT)
UPDATE movies
SET synopsis = 'In this gripping tale of resilience and hope, banker Andy Dufresne finds himself unjustly sentenced to life in Shawshank State Penitentiary for a crime he didn''t commit. Inside the harsh confines of the prison, Andy befriends fellow inmate Red and navigates a world of corruption and brutality while never losing sight of his dream of freedom. As Andy''s determination grows, he embarks on a daring plan to escape, defying all odds and leaving behind a legacy of redemption.'
WHERE titletext = 'The Shawshank Redemption';
UPDATE movies
SET synopsis = 'Set in the world of organized crime, ''The Godfather'' follows the powerful Corleone family as they navigate the complex underworld of 1940s New York. When patriarch Don Vito Corleone is targeted in an assassination attempt, his youngest son, Michael, reluctantly steps into the family business, becoming embroiled in a web of violence, betrayal, and ambition. As Michael rises to power, he must confront his own morality and loyalty to protect his family''s legacy while establishing his own reign as the new Godfather.'
WHERE titletext = 'The Godfather';
UPDATE movies
SET synopsis = 'In this exhilarating chapter of the Batman saga, the caped crusader faces his greatest challenge yet as he battles the chaos unleashed by the Joker, a psychotic criminal mastermind. With Gotham City plunged into darkness and despair, Batman teams up with District Attorney Harvey Dent and police commissioner James Gordon to thwart the Joker''s reign of terror. As the lines between hero and villain blur, Batman must confront his own inner demons and make the ultimate sacrifice to save the city he has sworn to protect.'
WHERE titletext = 'The Dark Knight';
UPDATE movies
SET synopsis = ' In this tense courtroom drama, twelve jurors must deliberate the fate of a young man accused of murder, with a guilty verdict meaning the death penalty. As tempers flare and prejudices surface, one juror, played by Henry Fonda, challenges his fellow jurors to reexamine the evidence and consider the possibility of reasonable doubt. Through heated debate and intense scrutiny, the jurors confront their own biases and confrontations, ultimately striving for justice in the face of overwhelming pressure.'
WHERE titletext = '12 Angry Men';
UPDATE movies
SET synopsis = 'Based on the true story of Oskar Schindler, a German businessman who saved over a thousand Jewish refugees during the Holocaust, ''Schindler''s List'' is a harrowing portrayal of one man''s heroic efforts to defy the atrocities of Nazi Germany. As Schindler risks everything to protect his workers from the horrors of concentration camps, he grapples with his own complicity and embarks on a journey of redemption and salvation amidst the darkest chapter in human history.'
WHERE titletext = 'Schindler''s List';
UPDATE movies
SET synopsis = 'In the epic conclusion to the ''Lord of the Rings'' trilogy, Frodo and Sam continue their perilous journey to Mount Doom to destroy the One Ring and thwart the dark lord Sauron''s reign of terror over Middle-earth. Meanwhile, Aragorn leads the forces of men in a final, desperate stand against Sauron''s armies in the climactic Battle of Pelennor Fields. As the fate of Middle-earth hangs in the balance, friendships are tested, sacrifices are made, and heroes rise to fulfill their destinies in this breathtaking tale of courage, fellowship, and the enduring power of hope.'
WHERE titletext = 'The Lord of the Rings: The Return of the King';
UPDATE movies
SET synopsis = 'The heartwarming tale of a simple-minded but kind-hearted man who inadvertently becomes an integral part of some of the most defining moments in American history. From his childhood in Alabama to his experiences in the Vietnam War and beyond, Forrest''s journey is marked by love, loss, and unexpected triumphs. With his unwavering optimism and unyielding spirit, Forrest proves that sometimes, the most extraordinary adventures come from the simplest of lives.'
WHERE titletext = 'Forrest Gump';
UPDATE movies
SET synopsis = 'In this provocative exploration of masculinity and existentialism, an unnamed narrator disillusioned with consumerism and modern society forms an underground fight club with the charismatic Tyler Durden, who embodies everything he desires to be. As the fight club evolves into a nihilistic movement, the narrator becomes increasingly entangled in Tyler''s anarchist ideology, leading to a shocking revelation that blurs the lines between reality and madness. In a world where nothing is as it seems, the narrator must confront his own identity and the consequences of his actions in a visceral and mind-bending journey of self-discovery.'
WHERE titletext = 'Fight Club';


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

CREATE TABLE articles (
	article_id SERIAL,
	title varchar(128) NOT NULL,
	author varchar(50) NOT NULL,
	body varchar(8000) NOT NULL,
	CONSTRAINT PK_articles PRIMARY KEY (article_id)
);

INSERT INTO articles (title, author, body)
VALUES
('Actor Mike Lever''s Brush with the Law: Knife Incident in Public School Zone Raises Eyebrows' , 'SilverScreenScoop', 'In a shocking turn of events, up-and-coming actor Mike Lever found himself thrust into the spotlight for all the wrong reasons. The promising star, known for his captivating performances on screen, recently made headlines for an incident that has left fans and the public alike in disbelief.

Reports have surfaced that Lever was apprehended by local authorities after being found in possession of a knife within a public school zone. The incident, which occurred in the bustling heart of the city, has sparked concern and speculation among both industry insiders and the general public.

Witnesses recount a tense scene as law enforcement officials swarmed the area, responding to reports of suspicious behavior. Lever, known for his affable demeanor and charming presence, was allegedly discovered with the weapon in his possession during a routine inspection.

As news of the incident spreads like wildfire across social media platforms and news outlets, fans and colleagues alike are left grappling with disbelief and uncertainty. Many are left questioning the circumstances surrounding Lever''s involvement in such a troubling situation, with some expressing shock and disappointment at the revelation.

In the wake of the incident, representatives for Lever have remained tight-lipped, offering no official statement or comment on the matter. However, speculation runs rampant as fans and industry insiders alike await further developments in this unfolding saga.

For Lever, whose star was on the rise, the fallout from this incident remains uncertain. As the glare of the spotlight intensifies, the young actor finds himself navigating uncharted territory, facing scrutiny and judgment from both the public and those within the entertainment industry.

Only time will tell how Lever''s career will weather this storm and whether he can emerge from this setback unscathed. But one thing is certain: this unexpected twist in the actor''s journey serves as a sobering reminder of the unpredictable nature of fame and the precarious balance between success and scandal in the cutthroat world of Hollywood.'),


('Steven Seagal''s Surprise Side Hustle: The Untold Story Behind His Unexpected Second Career', 'Lexicon Luminator', 'In a plot twist worthy of one of his own action-packed films, martial arts legend Steven Seagal has been unmasked as a master of a completely unexpected domain—a world far removed from the glitz and glamour of Hollywood. Sources close to the enigmatic star have lifted the lid on a clandestine second career that has remained shrouded in secrecy until now.

Beneath the veneer of his tough-guy persona, it seems that Seagal has been quietly cultivating a passion for a wholly unexpected pursuit: gourmet cooking. Yes, you read that correctly—Steven Seagal, the martial arts maestro renowned for his bone-crunching fight scenes, has been quietly honing his skills as a culinary virtuoso behind closed doors.

Insiders reveal that Seagal''s journey into the culinary arts began as a hobby, a creative outlet to balance the intensity of his on-screen persona. But what started as a simple pastime soon evolved into a full-blown obsession, with the actor-turned-chef immersing himself in the world of haute cuisine with gusto.

According to those in the know, Seagal''s culinary repertoire extends far beyond the basics, with the actor boasting a flair for exotic flavors and innovative cooking techniques. From delicate sushi creations to mouthwatering fusion dishes, Seagal''s culinary creations have garnered praise from those lucky enough to sample his gastronomic delights.

While Seagal''s pivot from martial arts master to master chef may come as a surprise to many, those closest to him attest to his unwavering dedication and passion for his newfound craft. Friends and colleagues marvel at the actor''s culinary prowess, describing his transformation into a culinary virtuoso as nothing short of remarkable.

As whispers of Seagal''s secret second career begin to circulate, speculation abounds about the actor''s future culinary endeavors. Could we see Seagal swap the silver screen for the kitchen spotlight? Only time will tell, but one thing is certain: Steven Seagal''s unexpected journey from action hero to culinary connoisseur is a testament to the power of reinvention and the pursuit of passion beyond the confines of Hollywood.'),


('Code Commandos: A Cinematic Journey Through the Tech Bootcamp Trenches','Lexi Byte','In a riveting departure from the traditional war genre, ''Code Commandos'' storms onto the silver screen, offering audiences a gritty and thought-provoking exploration of a different kind of battleground—the intense world of a coding bootcamp. Drawing inspiration from the iconic war film ''Full Metal Jacket,'' ''Code Commandos'' delivers a visceral and immersive cinematic experience that sheds light on the trials and triumphs of aspiring software engineers.

Set against the backdrop of a bustling metropolis teeming with technological innovation, the film plunges viewers into the heart of ''Byte Bootcamp,'' a no-holds-barred coding academy where dreams of mastering the digital frontier collide with the harsh realities of the tech industry. Helmed by visionary director Ava DuVernay, ''Code Commandos'' juxtaposes the adrenaline-fueled rush of code creation with the sobering challenges faced by those daring enough to embark on this perilous journey.

At the center of the narrative is a diverse ensemble cast of aspiring coders, each grappling with their own demons as they navigate the unforgiving terrain of the bootcamp experience. Leading the charge is Sergeant Maya Thompson, portrayed with unyielding intensity by Academy Award nominee Viola Davis. With a commanding presence and razor-sharp wit, Sergeant Thompson guides her recruits through the crucible of coding challenges, pushing them to their limits in pursuit of programming prowess.

But lurking in the shadows of ''Byte Bootcamp'' is a sinister figure known only as "The Knife Master," a mysterious and malevolent presence who wields a razor-sharp blade with deadly precision. Played with chilling menace by acclaimed character actor Javier Bardem, The Knife Master is a ruthless taskmaster whose brutal training methods push the bootcamp members to their breaking point.

As tensions escalate and rivalries simmer, ''Code Commandos'' paints a vivid portrait of camaraderie and competition in equal measure, showcasing the bonds forged and broken in the crucible of the bootcamp experience. With its pulse-pounding action sequences and poignant character-driven drama, the film invites audiences to ponder the timeless question: what does it truly mean to be a warrior in the digital age?

With ''Code Commandos,'' Ava DuVernay boldly redefines the war film genre for a new generation, offering a fresh and insightful perspective on the modern battlefield of technology. As the credits roll and the lights come up, viewers are left with a newfound appreciation for the unsung heroes of the coding world—and a renewed sense of awe for the power of perseverance in the face of adversity.');


--test data ends here
COMMIT TRANSACTION;
