BEGIN TRANSACTION;

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
--adds values from prior users into account db also
INSERT INTO accounts(account_id) VALUES (1);
INSERT INTO accounts(account_id) VALUES (2);

--user test data
INSERT INTO favorites (account_id, movie_id) VALUES (1, 10);
INSERT INTO favorites (account_id, movie_id) VALUES (1, 5);
INSERT INTO favorites (account_id, movie_id) VALUES (1, 2);
INSERT INTO favorites (account_id, movie_id) VALUES (1,4);

INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 3);
INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 2);
INSERT INTO favorite_genres (account_id, genre_id) VALUES (1, 5);


--even more test data
INSERT INTO reviews(account_id, rating, review, movie_id) VALUES (1, 5, 'Awesome job, great movie!! I would give it more if I could!!!!', 7);
INSERT INTO reviews(account_id, rating, review, movie_id) VALUES (1, 1, 'This was the absolute worst piece of trash movie Ive ever seen in my life. Please give me my time back.', 3);
INSERT INTO reviews(account_id, rating, review, movie_id) VALUES (2, 4, 'Yeah it was pretty good. Dont listen to the haters even if its controversial, they just didnt get it.', 3);
INSERT INTO reviews(account_id, rating, review, movie_id) VALUES (1, 3, 'A pretty cool adventure story, but isnt really to miss by not watching it.', 2);


COMMIT TRANSACTION;
