

select movie_id, genres from movies ORDER BY movie_id ASC;

SELECT genres FROM movies WHERE movie_id = 1;

SELECT MAX(movie_id) AS total FROM movies;


SELECT genre_id FROM genres WHERE genre_name ILIKE 'drama';


SELECT genre_id FROM genres WHERE genre_name ILIKE 'Drama';


SELECT * from movie_to_genre;

--more test data
INSERT INTO movie_to_genre (movie_id, genre_id) VALUES
(1,8),(2,4),(2,8),(3,2),(3,4),(3,8),(4,8),(5,8),(5,14),(6,2),(6,8),(6,10),(7,4),(7,8),(8,2),(8,8),(8,10),(9,8),(9,3),(10,8),(11,2),(11,9),(12,2),(12,8),
(13,7),(13,10),(13,4),(14,2),(14,4),(14,5),(15,8),(16,7),(16,8),(16,11),(17,2),(17,7),(17,5),(18,7),(18,8),(18,9),(19,2),
(19,10),(19,7),(20,7),(20,8),(20,3),(21,8),(22,2),(22,9),(23,8),(24,12),(24,7),(24,8),(25,12),(25,4),(25,8),
(26,2),(26,10),(26,4),(27,10),(27,7),(27,11),(28,2),(28,10),(28,9),(29,8),(30,7),(30,8),(31,7),(31,11),(32,2),(32,11),
(33,7),(34,4),(34,8),(34,9),(35,7),(35,4),(35,13),(36,6),(37,8),(37,11),(38,10),(38,7),(39,7),(39,4),(39,8),
(40,8),(40,14),(40,1),(41,1),(41,13),(42,2),(42,8),(42,5),(43,10),(43,7),
(45,5),(45,13),(45,4),(46,8),(46,4),(46,13),(47,3),(47,7),(48,8),(48,5),(49,8),(49,7),(50,3),(50,7),(50,8),(51,4),(51,8),(51,3);



SELECT * from movie_to_genre WHERE movie_id = 20;

SELECT genres FROM movies WHERE movie_id = 1;

SELECT * from genres;


select titletext from movies;


CREATE TABLE articles (
	article_id SERIAL,
	title varchar(128) NOT NULL,
	author varchar(50) NOT NULL,
	body varchar(8000) NOT NULL,
	CONSTRAINT PK_articles PRIMARY KEY (article_id)
);

select * from articles where article_id = 7;


UPDATE articles 
SET body = E'First Line\nSecond line.' 
WHERE article_id = 7;

SET standard_conforming_strings=off;

INSERT INTO articles (title, author, body)
VALUES
('Lorem Ipsum: The Impact of Nullam Inceptos Risus on Ipsum Dolor', 'Marcus Lorem Ipsum', E'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam inceptos risus ac augue condimentum, eu feugiat velit tincidunt. Sed dapibus fringilla nunc, at consequat neque ultricies nec. Integer quis ipsum auctor, vehicula velit id, consequat ligula. Ut sit amet turpis ac nisi consequat aliquet. Nam varius sapien ac sapien fringilla, sed accumsan magna lacinia.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla at commodo sapien. Nulla facilisi. Proin at luctus lorem. Sed consectetur ex id nibh pellentesque, vel ultrices neque laoreet. Quisque condimentum est eget dolor viverra commodo. Nam ac eros consequat, ultrices quam vel, faucibus mauris.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at massa vel neque consectetur viverra. Sed eu fringilla lectus. Phasellus suscipit mauris ut ipsum efficitur, nec lacinia elit eleifend. Ut molestie, ipsum nec volutpat ullamcorper, velit augue pharetra ipsum, id tempus est arcu sed neque. Maecenas elementum nulla at mauris volutpat, eget vestibulum quam aliquet. Sed fermentum tortor id nunc dapibus, sed dictum enim lacinia. Nulla auctor tortor eget nunc facilisis aliquam.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean feugiat velit eu justo hendrerit, et convallis sapien fermentum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam sed libero id leo iaculis accumsan. Fusce nec sapien vel risus blandit varius. Mauris rhoncus, lorem eget feugiat finibus, nisi purus sodales odio, vel malesuada eros leo eget enim. Sed vestibulum, justo vel hendrerit auctor, ipsum arcu dignissim justo, a lobortis nibh libero et libero. Donec id risus vehicula, congue purus nec, vulputate lacus. Phasellus pharetra, sapien ac malesuada suscipit, enim neque auctor nisi, vel consequat mi elit eu lacus. Cras interdum, lorem non euismod consequat, odio arcu convallis metus, ut dignissim ligula augue nec ipsum. Nulla eget placerat mauris. Vivamus at libero odio.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam inceptos risus ac augue condimentum, eu feugiat velit tincidunt. Sed dapibus fringilla nunc, at consequat neque ultricies nec. Integer quis ipsum auctor, vehicula velit id, consequat ligula. Ut sit amet turpis ac nisi consequat aliquet. Nam varius sapien ac sapien fringilla, sed accumsan magna lacinia.')



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



select * from movies;

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

select titletext from movies order by movie_id;

UPDATE movies
SET synopsis = 'In Christopher Nolan''s mind-bending thriller, a skilled thief named Cobb leads a team into the world of dreams to implant an idea into the mind of a corporate heir. As they navigate layers of subconsciousness, facing obstacles and their own inner demons, Cobb grapples with his own guilt and longing for redemption amidst the surreal landscapes of the mind. With time running out and reality fracturing, the team must confront their deepest fears and desires in a high-stakes heist that blurs the line between dreams and reality.'
WHERE titletext = 'Inception';
UPDATE movies
SET synopsis = 'The second installment of the epic ''Lord of the Rings'' trilogy continues the journey of Frodo, Sam, and the Fellowship as they face new challenges and dangers in their quest to destroy the One Ring. Separated by fate, the members of the Fellowship must navigate their own perils: Aragorn, Legolas, and Gimli defend the kingdom of Rohan against the forces of darkness, while Frodo and Sam encounter the treacherous creature Gollum on their path to Mount Doom. With Middle-earth on the brink of war, alliances are forged and tested, and the fate of all hangs in the balance.'
WHERE titletext = 'The Lord of the Rings: The Two Towers';
UPDATE movies
SET synopsis = 'Set in the American South during the Great Depression, this Coen Brothers comedy follows three escaped convicts—Ulysses, Pete, and Delmar—as they embark on a journey to find buried treasure and reunite with Ulysses'' estranged wife. Along the way, they encounter a series of eccentric characters and improbable situations, including a blind prophet, a seductive sirens, and a political campaign. With a soundtrack of folk and bluegrass music, ''O Brother, Where Art Thou?'' is a whimsical odyssey through a bygone era of Americana.'
WHERE titletext = 'O Brother, Where Art Thou?';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';
UPDATE movies
SET synopsis = ''
WHERE titletext = '';