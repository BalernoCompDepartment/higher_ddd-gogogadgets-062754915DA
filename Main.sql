/* do not change the following three lines! */
.header on
.mode column
.read GoGoGadget.sql
/* do not change the above three lines! */

/* Searching and Sorting*/

/* Task One:	A list of all of the items that belong to the category ‘Boys Toys’. The list should include all item details.*/

SELECT *
FROM item
WHERE category = "Boys Toys" ;

/* Task Two:	A list of all items in each order. The list should show the order number, item description and price and should be in ascending order of order number.*/

SELECT custOrder.orderNo, item.description, item.price
FROM item, custOrder, orderItem
WHERE custOrder.orderNo = orderItem.orderNo AND orderItem.itemID = item.itemID
ORDER BY custOrder.orderNo ASC ;

/* Task Three:	A list of all the full names of all customers with a surname containing the letters 'em' along with the dates of their orders. The list should be in alphabetical order of surname; when two or more surnames are the same, they should be listed in alphabetical order of first name.*/

SELECT customer.surname LIKE "%em%", customer.forename, custOrder.orderDate
FROM customer, custOrder
WHERE customer.customerID = custOrder.customerID
ORDER BY surname ASC, forename ASC ;

/*Computed Fields*/

/* Task Four:	A list showing the order number, order date, item descriptions, quantities ordered and prices. A calculated field should be used to work out the total cost of each item (quantity x price in each order). The details should be listed in order of date, from oldest to most recent.*/

SELECT custOrder.orderNo, item.description, orderItem.quantity, item.price, (orderItem.quantity * item.price) AS "Total cost per item"
FROM custOrder, item, orderItem
WHERE item.itemID = orderItem.itemID AND orderItem.orderNo = custOrder.orderNo
GROUP BY custOrder.orderDate
ORDER BY custOrder.orderDate DESC ;

/* Task Five:	The company has decided to apply a 5% discount to any items whenever the minimum order quantity is 4. Create a list showing the relevant order numbers, the description of qualifying item, the quantity of the item ordered, the original price, the value of the discount and the discounted price.*/

SELECT custOrder.orderNo, item.description, orderItem.quantity, item.price, (item.price * 0.95) AS "Discounted price (5%)" 
FROM custOrder, item, orderItem
WHERE item.itemID = orderItem.itemID AND orderItem.orderNo = custOrder.orderNo AND orderItem.quantity = 4 ;

/*Grouping Data and Aggregate Functions*/

/* Task Six: A list showing details of all orders placed by Mari Singer. The list should show the order number, order date, description, quantity ordered, price and the total price of each item in the order. The list should be displayed with details of the most recent order first.*/


/* I changed one of your orders so that you can see it working! I will go change it back just in case it is needed later*/

SELECT custOrder.orderNo, custOrder.orderDate, item.description, orderItem.quantity, item.price, (item.price * orderItem.quantity) AS "Total Price"
FROM custOrder, item, orderItem, customer
WHERE item.itemID = orderItem.itemID AND custOrder.customerID = customer.customerID AND custOrder.orderNo = orderItem.orderNo AND customer.forename LIKE "%Mari%" AND customer.surname LIKE "%Singer%"
ORDER BY custOrder.orderDate ASC ;

/* Task Seven: A list showing each category with the number of items in each category. Details of the largest category should be listed first.*/

SELECT item.category, orderItem.quantity
FROM item, orderItem
WHERE item.itemID = orderItem.itemID
ORDER BY orderItem.quantity DESC ;

/* Task Eight: A list showing each order number, order date and the total cost of the order for all orders placed in January 2008. The details of the oldest order should be listed first.*/

SELECT custOrder.orderNo, custOrder.orderDate, (item.price * orderItem.quantity) AS "Total Cost"
FROM custOrder, item, orderItem
WHERE item.itemID = orderItem.itemID AND orderItem.orderNo = custOrder.orderNo AND custOrder.orderDate LIKE "%2008-01%"
GROUP BY custOrder.orderNo
ORDER BY custOrder.orderDate ASC ;

/*Additional Queries*/

/* Task Nine: A list showing the full name of all customers who have an email address provided by MobileLife.*/
/* Task Ten: A list showing the category, the number of orders placed and the total quantity of items in the 'Office Distractions' category that have been ordered.*/
/* Task Eleven: A list showing the name of each category and the average price of items that belong to that category.*/
/* Task Tweleve: A list showing each order number with the customer’s full name and the number of items ordered. The only orders shown should be those placed by customers whose surname contains the letters 'i' and 'g' separated by one other letter (the letter 'g' is not the last letter).*/
/* Task Thirteen: A list showing the customerID and postcode and the number of orders placed by the customer in 2008. Arrange the list so that the customer who placed the most orders is listed first; customers who placed the same number of orders should be listed alphabetically by postcode.*/
/* Task Fourteen:	The company is offering a 5% discount on all orders placed in December 2007.*/
/* Produce a list to show each order number and order date, the order totals before discount, the value of each order’s 5% discount and the overall totals after discount. Orders should be listed with the oldest order first. Where two or more orders are placed on the same day, they should be sorted by OrderNo in ascending order.*/