/* AY IF YOU'RE EXPERIENCING MYSQL ERROR 1055 */
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
/* This is a setting that's messing you up with MySQL defaults post v5.6 that is requiring all fields of the joins in question, which somehow is a good idea?  */



/* primary keys & foreign keys */
/* using the example of customers and orders, one to many, so on- */

/* each customers within a customers table contains a *unique* primary key. this is coupled with, for  example, a orders database. each particular order is paired with a foreign key, which points to the particular customer's primary key. */

/* to link a foreign key to a primary key, you initialize it in the many's table and then specify that it's a foreign key, thereby referencing it to the one's table. */

/* convention suggests you would name the foreign key as nameOfTable_columnBeingEffected */


CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL (8,2),
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);



INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id) 
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);
       


/* 
Later, you would want to select an order, and then with the order ID, select the customer. This would be 2 selectors:
*/

SELECT * FROM customers WHERE last_name = "George";
SELECT * FROM orders WHERE customer_id = 1;

/* Instead we can combine them together: */

SELECT * FROM orders WHERE customer_id = 
  (
    SELECT id FROM customers
    WHERE last_name = 'George'
  );
 
/* 
Which is kinda verbose- but perfectly surmises the concept of
 ----  J O I N S  ----
*/

/* Here's an example of a particularly useless 
join- a CROSS JOIN, which takes every possible 
combination of both tables 'joined' together */

SELECT * FROM customers, orders; 

/* So instead, use joins to logically connect the order ID to
the customer ids, right?  Thus providing us with a table of all orders, connected properly. */


/* Also worth noting that dot notation is a thing and can be used to decree from different columns in different tables, like as different methods on a javascript object, etc etc */

/*   I M P L I C I T  I N N E R  J O I N    */
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;

/* Or condense this information more logically */

SELECT first_name, last_name, order_date, amount FROM customers, orders WHERE customers.id = orders.customer_id;


/* E X P L I C I T  I N N E R  J O I N       */
SELECT * FROM customers 
JOIN orders
  ON customers.id = orders.customer_id;

/* And, again, condensed for more logic */

SELECT first_name, last_name, order_date, amount FROM customers JOIN orders ON customers.id = orders.customer_id;
/*  Select something, join it with something else, on this condition. */


/* Formatted a bit more succinctly */
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
  ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders
  ON customers.id = orders.customer_id
GROUP BY orders.customer_id;



/* SO.
For an idiotic example, let's add the total of all orders. */

SELECT first_name, 
       last_name, 
       SUM(amount) AS total_spent 
FROM customers 
LEFT JOIN orders 
  ON customers.id = orders.customer_id 
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

/* Use IFNULL to display a number, 0 for example, 
when displaying a value of NULL */
SELECT first_name, 
       last_name, 
       IFNULL(SUM(amount), 0) AS total_spent
FROM customers 
LEFT JOIN orders
  ON customers.id = orders.customer_id 
GROUP BY orders.customer_id;
ORDER BY total_spent ASC;

/* also, never realized you could ORDER BY with an alias (total_spent)- that's pretty hype */

/* IN SUMMARY THUS FAR
   INNER JOINS-  only returning the exact overlap, the specific conditions met, nothing else.
   LEFT JOINS- select everything from the left side along with any matching records from the right side!
 */


/* The foreign key that is connected with a customer ID will prevent you from deleting the order or customer outright, because they're both linked together.

In order to provide the functionality to delete a customer and, in doing so, the orders associated with them, we add a line to our ORDERS table schema- */

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL (8,2),
  customer_id INT,
  FOREIGN KEY (customer_id)
    REFERENCES customers(id)
    ON DELETE CASCADE
);

/* ON DELETE CASCADE will cascade that deletion down to the individual orders, etc etc */



/* E X E R C I S E S  */




CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR (50)
);

CREATE TABLE papers (  
  title VARCHAR (500),
  grade INT,
  student_id INT,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade) VALUES 
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Thru the Ages', 94),
(2, 'De Montaigne and the Essay', 98),
(4, 'Borges and Magical Realism', 89);

/* print papers only from students who have submitted */

SELECT first_name, 
       title, 
       grade
FROM students
INNER JOIN papers
  ON students.id = papers.student_id
ORDER BY grade DESC;


/* print all students regardless if paper was submitted or not */

SELECT first_name, 
       title, 
       grade
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id;


/* print same as above, though with a 0 representing a null value */

SELECT first_name, 
       IFNULL(title, 'MISSING'), 
       IFNULL(grade, 0)
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id;


/* print each student's average paper grade */

SELECT first_name,
       IFNULL(AVG(grade), 0) AS average
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id
GROUP BY students.id;
ORDER BY grade DESC;


/* print the same as above but with a passing_status column: PASSING / FAILING */

SELECT first_name,
       IFNULL(AVG(grade), 0) AS average,
       CASE
          WHEN AVG(grade) >= 75 THEN 'PASSING'
          ELSE 'FAILING'
       END AS passing_status
FROM students
LEFT JOIN papers
  ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;
