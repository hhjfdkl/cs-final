BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS account;

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE account(
username varchar(50) NOT NULL UNIQUE,
	user_id int,
	user_description varchar(500),
	
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

COMMIT TRANSACTION;
