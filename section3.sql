--count
SELECT COUNT(*) FROM books;

--display distinct author_fnames count // mind yr spacing bruh
SELECT COUNT(DISTINCT author_fname) FROM books;

--display distinct author count, first AND last name
SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;

--display all books with 'the' in it's title
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';



-- G R O U P I N G
--this will count how many entries are for each distinct author, first name considered as well (Harris)
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;

--display books released grouped by year
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) were released.') FROM books GROUP BY released_year;


--min/max
SELECT Min(released_year) FROM books;
SELECT Min(pages) FROM books;
SELECT Max(stock_quantity) FROM books;

--say, display highest page count WITH it's title
--why this is problematic: 2 queries are happening.
SELECT * FROM books WHERE pages = (SELECT Max(pages) FROM books);
--ORDERBY does the same thing but with one query
SELECT title, pages FROM books ORDER BY pages ASC LIMIT 1;

--min/max with GROUP BY
--display author's full name and the year of their first book
SELECT author_fname, author_lname, Min(released_year) FROM books GROUP BY author_fname, author_lname;
--display longest book by authors, cleaner version after
SELECT author_fname, author_lname, Max(pages) FROM books GROUP BY author_fname, author_lname;
-- cleaned up version
-- SELECT CONCAT(author_fname, ' ', author_lname) AS author, Max(pages) AS 'longest book' FROM books GROUP BY author_fname, author_lname;


--sum: for example, display the sum of all pages in all books in the database
SELECT Sum(pages) FROM books;
--display the sum of all pages each author has written
SELECT CONCAT(author_fname, ' ', author_lname) AS author, Sum(pages) FROM books GROUP BY author_lname, author_fname;
SELECT author_fname, author_lname, Sum(pages) FROM books GROUP BY author_lname, author_fname;


--avg
SELECT AVG(released_year) FROM books;
--calculate the average of stock quantity for books released in the same year
SELECT AVG(stock_quantity) FROM books GROUP BY released_year;


--E X E R C I S E S
--print the number of books in the database
SELECT count(*) FROM books;

--print out how many books were released in each year
SELECT DISTINCT COUNT(*), released_year FROM books GROUP BY released_year;

--print out how many books in stock
SELECT Sum(stock_quantity) FROM books;

--find the average released_year for each author
SELECT AVG(released_year), author_lname FROM books GROUP BY author_lname;

--find the full name of the author who wrote the longest book
SELECT CONCAT(author_fname, ' ', author_lname) FROM books ORDER BY pages DESC LIMIT 1;
--or
SELECT CONCAT(author_fname, ' ', author_lname) FROM books WHERE pages = (SELECT Max(pages) FROM books);

SELECT released_year AS 'year', COUNT(*) AS '# books', AVG(pages) AS 'avg pages' from BOOKS GROUP BY released_year;
