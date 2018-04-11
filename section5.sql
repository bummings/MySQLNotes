--without BETWEEN
SELECT title FROM books WHERE released_year >= 2005 && released_year < 2015;

--with BETWEEN
SELECT title FROM books WHERE released_year BETWEEN 2004 AND 2015;
--when using between, you have to use the AND keyword and not &&.

--NOT BETWEEN is a thing
SELECT released_year FROM books WHERE released_year NOT BETWEEN 1969 AND 1999;


--using the IN statement
--instead of this garbage
SELECT title, author_lname FROM books WHERE author_lname = "Smith" OR author_lname = "Carver";

--now, using IN
--you could also use NOT IN, figure it out bruh
SELECT title, author_lname FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

--all books from 2000+, odd years only
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year % 2 != 0;


--case statements
SELECT author_lname, 
  CASE
    WHEN released_year >= 2000 THEN 'Modern'
    ELSE '20th Century'
  END AS Genre
FROM books;

--two different ways to write the between statements
SELECT title,
  CASE 
    WHEN stock_quantity <= 50 THEN '$'
    WHEN stock_quantity <= 100 THEN "$$"
    WHEN stock_quantity BETWEEN 250 and 500 THEN "$$$"
    ELSE "$$$$"
  END AS stock
FROM books;



-- E X E R C I S E S

--select all books written before 1980
SELECT title, released_year FROM books WHERE released_year < 1980;

--select all books by Eggers or Chabon
SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers', 'Chabon');

--select all books published by Lahiri after 2000
SELECT title FROM books WHERE author_lname = "Lahiri" AND released_year >= 2000;

--select all books with a page count between 100 and 200
SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;

--select all books where author_lname begins with a C or an S
SELECT title, author_lname FROM books 
WHERE author_lname LIKE 'C%' OR 
author_lname LIKE 'S%';

--if title contains 'stories', catorgorize them at Shot Stories
--if titles are "Just Kids" or "A Heartbreaking Work", then memoir
--everything else: novel
SELECT title, 
  CASE
    WHEN title="Just Kids" THEN "Memoir"
    WHEN title="A Heartbreaking Work" THEN "Memoir"
    WHEN title LIKE "%stories%" THEN "Short Stories"
    ELSE 'Novel'
  END AS Type
FROM books;
