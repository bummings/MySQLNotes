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

