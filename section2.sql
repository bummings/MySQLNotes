--only list books from distinct years
SELECT DISTINCT released_year FROM books;

--distinct authors with the same first or last name
SELECT DISTINCT author_fname, author_lname FROM books;

--limit results
SELECT title FROM books LIMIT 3;

--arrange by released year (descending), limit results to 5
SELECT title, released_year FROM books ORDER BY 2 DESC LIMIT 5;

--LIKE uses wildcards to filter results: first names containing 'da'
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';

--modify %s to manipulate wildcard selection- result ends in 'da'
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da';

--%s mark where wildcard query begins- results that begin with 'the'
SELECT title, author_fname FROM books WHERE title LIKE 'the%';

--underscores to count characters- return books with quantity in hundreds only
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '___';
--books done gon' sell out
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '_';

--use an escape character to specify results that include % or _
SELECT title FROM books WHERE title LIKE '%\%%';




--EXERCISES EXERCISES EXERCISES

--select all titles with 'stories'
SELECT title FROM books WHERE title LIKE '%stories%';

--print a summary of the 3 most recent releases
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

--display all authors with a space in their last name
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

--find the 3 books with the lowest stock
SELECT title, released_year, stock_quantity FROM books ORDER BY 3 ASC LIMIT 3;

--print title and last name sorted first by lastname and then title
SELECT title, author_lname FROM books ORDER BY author_lname, title;

--scream about your favorite author, which is everyone
SELECT CONCAT('MY FAVORITE AUTHOR IS ', UPPER(author_fname), ' ', UPPER(author_lname)) AS yell FROM books ORDER BY author_lname;

