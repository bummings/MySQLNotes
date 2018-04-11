--use these with the book-data.sql injection

--concat, etc
--in which we concat first name space last name yknow
SELECT CONCAT (author_fname, ' ', author_lname) FROM books;

--concat_ws WITH SEPERATOR: 'Faux $ Kno', 'Loro $ Ipso'
SELECT CONCAT_ws (' $ ', author_fname, author_lname) FROM books;



--substring, etc / mysql ain't zero-based.
--in which we substring data in our table, yknow- return 5 chars from each
--mind yr spacing on substring args

SELECT SUBSTRING(title, 1, 5) FROM books;

--finish string from the third spot
SELECT SUBSTRING(title, 3) FROM books;

--start from the third to last letter
SELECT SUBSTRING(title, -3) FROM books;


--chain these together you sonofabitch / mind your quotation marx
SELECT CONCAT(SUBSTRING(title, 1, 10), "...") FROM books;
SELECT CONCAT(SUBSTRING(title, 1, 5), ".....") AS "lol" FROM books;


--replace, etc
--in which we replace chars or strings with something else, you fkn idiot
SELECT REPLACE ('hello', 'l', 7);
SELECT REPLACE ('coffee bread cheese milk', ' ', ' and ');

SELECT REPLACE (title, 'e', '3') FROM books;


--reverse, etc
SELECT REVERSE ('gimme 20 bucks bruh');

--charlength, etc
--in which we mow your wife's lawn
SELECT CHAR_LENGTH ('good mornin');

--upper & lower
SELECT UPPER('ay bruh');
SELECT LOWER('YO CUZ');
SELECT UPPER(title) FROM books;


--EXERCISES
--reverse, uppercase the string, please
SELECT UPPER(REVERSE('Say bruh wanna make 20 bucks'));

--replace spaces in book titles with '->'
SELECT REPLACE (title, ' ', '->') FROM books;

--print a list of both author first name and reverse author first name
SELECT author_lname AS "forwards", REVERSE(author_lname) as "backwards" FROM books;

--print a single column of full name with space in CAPS
SELECT CONCAT_ws(" ", UPPER(author_fname), UPPER(author_lname)) as 'caps' FROM books;

--print a blurb with book title and release year
SELECT CONCAT(title, ' was released in ', released_year) AS 'blurb' FROM books;

--print a list of book name with character count of title
SELECT title AS 'author', CHAR_LENGTH(title) AS 'characterz' FROM books;

--print a list of a condensed title, author and quanity
SELECT CONCAT(SUBSTRING(title, 1, 10), "...") FROM books;

SELECT CONCAT(SUBSTRING(title, 1, 10), "...") AS title, CONCAT(author_lname, ', ', author_fname) AS author, CONCAT(stock_quantity, ' in stock') AS quantity FROM books;