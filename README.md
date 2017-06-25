# CS364-Lab5
MySQL stored procedure - Uses classicmodels DB

Create an Invoice
 
In this lab you will write a stored procedure to create an invoice for sales from classmodels. <br />
Format is not that important but do the best you can.  The stored procedure should take the order number as an input parameter and create an invoice with this information.  Use an alternate delimiter in your procedure. <br />
 
Sales Info <br />
\<sales person name\> <br />
\<sales person  address\> <br />
\<sales person city\> <br />
\<sales person country\> <br />
 
Order Number <br />
\<order number\> <br />
\<order date\> <br />
\<shipped date\> <br />
 
Customer Info <br />
\<customer name\> <br />
\<contact name\> <br />
\<shipping address (all relevant info)\> <br />
 
Detail Lines for the Order (notice order line number) <br />
“All one line” \<item number\>, \<product code\>, \<product name\>, \<msrp\>, \<quantity ordered\>, \<priceEach\>,<br /> \<extended price\>, \<discount from MSRP\> <br />
 
Order Totals <br />
\<order total\> <br />
\<6 % tax\> <br />
\<order grand total\> <br />
