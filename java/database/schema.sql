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


COMMIT TRANSACTION;
