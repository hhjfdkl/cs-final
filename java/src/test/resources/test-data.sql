BEGIN TRANSACTION;

INSERT INTO users (username,password_hash,role) VALUES ('user1','user1','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user2','user2','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user3','user3','ROLE_USER');



--adds values from prior users into account db also
INSERT INTO accounts(account_id) VALUES (1);
INSERT INTO accounts(account_id) VALUES (2);
INSERT INTO accounts(account_id) VALUES (3);

--user test data
INSERT INTO favorites (account_id, movie_id) VALUES (1, 10);
INSERT INTO favorites (account_id, movie_id) VALUES (1, 5);
INSERT INTO favorites (account_id, movie_id) VALUES (1, 2);
INSERT INTO favorites (account_id, movie_id) VALUES (1,4);

INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 3);
INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 2);
INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 5);

COMMIT TRANSACTION;
