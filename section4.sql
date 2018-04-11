-- datatypes, cont.
-- varchar vs char, what's the difference: CHAR has a fixed length
-- char(5) -> only five characters allowed


-- decimal- two arguments: first for how many digits total, second for decimals
-- i.e. DECIMAL(5,2) would max at 999.99, min at 000.01
-- if the number entered exceeds the max, the value will be reduced to the max

-- float and double- store larger numbers using less space however this comes at the cost of percision. Floats has percision issues after 7 digits, doubles with 15. generally this will not be an issue with more reasonable numbers, like prices, etc.

-- date- value with a date but no time: yyyy/mm/dd
-- time- value with time but, haha, no date: hh:mm:ss
-- datetime- yeh bruh you already know: yyyy/mm/dd hh:mm:ss

CREATE TABLE people (
  name VARCHAR(100),
  birthdate DATE,
  birthtime TIME,
  birthdatetime DATETIME
);

INSERT INTO people (name, birthdate, birthtime, birthdatetime) VALUES ('fauxkno', '1986-08-04', '05:45:31','1986-08-04 05:45:31');

INSERT INTO people (name, birthdate, birthtime, birthdatetime) VALUES ('loroipso', '2004-04-20', '04:20:00', '2004-04-20 04:20:00');

--using current time variables
CURDATE() --date
CURTIME() --time
NOW() --datetime

--in conjunction with insert statements, thus:
INSERT INTO people (name, birthdate, birthtime, birthdatetime) VALUES ('bummings', CURDATE(), CURTIME(), NOW());

--formatting dates & times are cool and all
DAY()
DAYNAME()
DAYOFWEEK()
DAYOFYEAR()
MONTHNAME()
-- thus 
SELECT name, birthdate, DAYNAME(birthdate) FROM people;

-- DATETIME will work with all these formatting techniques, instead of returning null for time or date.

-- DAYFORMAT is the real MVP however
SELECT DATE_FORMAT(birthdatetime, '%m %d %Y') FROM people;
SELECT DATE_FORMAT(birthdatetime, 'born in the month of %M') FROM people;
SELECT DATE_FORMAT(birthdatetime, '%m %d, %Y at %h:%m') FROM people;



--DATE ARITHMETIC
DATEDIFF()
DATE_ADD()
+/-

--using DATEDIFF for the difference between 2 dates
SELECT name, birthdate, DATEDIFF(NOW(), birthdatetime) AS bruh FROM people;

--using DATE_ADD to, well, add time to a fixed date
SELECT birthdatetime AS brb, DATE_ADD(birthdatetime, INTERVAL 30 SECOND) AS lol FROM people;

SELECT birthdatetime, DATE_ADD(birthdatetime, INTERVAL 1 MONTH) FROM people;

--or, use + / - shorthand 'cause you slick like that
--and, more importantly, you can CHAIN UNITS TOGETHER
--so, basic:
SELECT birthdatetime, birthdatetime + INTERVAL 10 DAY FROM people;
SELECT birthdatetime, birthdatetime - INTERVAL 6 DAY FROM people;

--now with multiple time units

SELECT birthdatetime AS I, birthdatetime + INTERVAL 6 DAY + INTERVAL 12 HOUR AS II FROM people;




--TIMESTAMPS, CUZ --------------
--timestamp and datetime store the same date formats, however!
--timestamp goes from 1970 - 2038. datetime is 1000 - 9999.
--timestamp uses less memory- 4 bytes vs 8 bytes for datetime.

CREATE TABLE comments (
  content VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO comments (content) VALUES ('bruh where my 20 bucks');
INSERT INTO comments (content) VALUES ('two copies of Deadringer');

SELECT * FROM comments ORDER BY created_at;

--upon using an UPDATE statement to modify something, the timestamp will update, isn't that remarkable

CREATE TABLE comments2 (
  content VARCHAR(9000),
  changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW();
);

UPDATE comments2 SET content='alisa wood appears' WHERE content='alisa wood walked into the room';
--you can then ORDER BY date modified, which is cool i guess!!
SELECT * from comments2 ORDER BY changed_at DESC;



--E X E R C I S E S

CREATE TABLE inventory (
  item_name VARCHAR(420),
  price DECIMAL(7,2),
  quantity INT
);

-- datetime v timestamp
--datetime extends longer years, timestamp is only 1970-2035,
--less memory, tho


--display present moment as mm/dd/yyyy
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');

--display present moment as Month numberTH at hh:mm
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%m');

CREATE TABLE tweets (
  content VARCHAR (144),
  username VARCHAR(30),
  created_on TIMESTAMP DEFAULT NOW() 
);

SELECT title FROM books WHERE released_year > 2005;