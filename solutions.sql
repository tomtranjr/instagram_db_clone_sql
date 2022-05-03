-- 1. Find the 5 oldest users. 

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

    # +----+------------------+---------------------+
    # | id | username         | created_at          |
    # +----+------------------+---------------------+
    # | 80 | Darby_Herzog     | 2016-05-06 00:14:21 |
    # | 67 | Emilio_Bernier52 | 2016-05-06 13:04:30 |
    # | 63 | Elenor88         | 2016-05-08 01:30:41 |
    # | 95 | Nicole71         | 2016-05-09 17:30:22 |
    # | 38 | Jordyn.Jacobson2 | 2016-05-14 07:56:26 |
    # +----+------------------+---------------------+

-- 2. What day of the week do most users register on? 
-- We need to figure out when to schedule an ad campain

SELECT
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

    # +-----------+-------+
    # | day       | total |
    # +-----------+-------+
    # | Thursday  |    16 |
    # | Sunday    |    16 |
    # | Friday    |    15 |
    # | Monday    |    14 |
    # | Tuesday   |    14 |
    # | Wednesday |    13 |
    # | Saturday  |    12 |
    # +-----------+-------+
    
    
-- 3. Find the users who have never posted a photo
-- we want to target our inactive users with an email campain

SELECT 
    username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

    # +---------------------+
    # | username            |
    # +---------------------+
    # | Aniya_Hackett       |
    # | Bartholome.Bernhard |
    # | Bethany20           |
    # | Darby_Herzog        |
    # | David.Osinski47     |
    # | Duane60             |
    # | Esmeralda.Mraz57    |
    # | Esther.Zulauf61     |
    # | Franco_Keebler64    |
    # | Hulda.Macejkovic    |
    # | Jaclyn81            |
    # | Janelle.Nikolaus81  |
    # | Jessyca_West        |
    # | Julien_Schmidt      |
    # | Kasandra_Homenick   |
    # | Leslie67            |
    # | Linnea59            |
    # | Maxwell.Halvorson   |
    # | Mckenna17           |
    # | Mike.Auer39         |
    # | Morgan.Kassulke     |
    # | Nia_Haag            |
    # | Ollie_Ledner37      |
    # | Pearl7              |
    # | Rocio33             |
    # | Tierra.Trantow      |
    # +---------------------+
    

-- 4. Who has the single most liked photo? 

SELECT
    username,
    photos.id, 
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON photos.id = likes.photo_id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

    # +---------------+-----+---------------------+-------+
    # | username      | id  | image_url           | total |
    # +---------------+-----+---------------------+-------+
    # | Zack_Kemmer93 | 145 | https://jarret.name |    48 |
    # +---------------+-----+---------------------+-------+
    

-- 5. How many times does the average user post?

SELECT
(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

    # +--------+
    # | avg    |
    # +--------+
    # | 2.5700 |
    # +--------+
    
-- 6. What are the top 5 most commonly used hastags? 

SELECT 
    tags.tag_name,
    COUNT(*) AS Total
FROM photo_tags
INNER JOIN tags 
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id 
ORDER BY Total DESC
LIMIT 5;

    # +----------+-------+
    # | tag_name | Total |
    # +----------+-------+
    # | smile    |    59 |
    # | beach    |    42 |
    # | party    |    39 |
    # | fun      |    38 |
    # | concert  |    24 |
    # +----------+-------+
    
-- 7. Which users have liked all posts? 


SELECT
    username,
    user_id, 
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);

    # +--------------------+---------+-----------+
    # | username           | user_id | num_likes |
    # +--------------------+---------+-----------+
    # | Aniya_Hackett      |       5 |       257 |
    # | Jaclyn81           |      14 |       257 |
    # | Rocio33            |      21 |       257 |
    # | Maxwell.Halvorson  |      24 |       257 |
    # | Ollie_Ledner37     |      36 |       257 |
    # | Mckenna17          |      41 |       257 |
    # | Duane60            |      54 |       257 |
    # | Julien_Schmidt     |      57 |       257 |
    # | Mike.Auer39        |      66 |       257 |
    # | Nia_Haag           |      71 |       257 |
    # | Leslie67           |      75 |       257 |
    # | Janelle.Nikolaus81 |      76 |       257 |
    # | Bethany20          |      91 |       257 |
    # +--------------------+---------+-----------+