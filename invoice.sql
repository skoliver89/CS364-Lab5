DELIMITER $$

DROP PROCEDURE IF EXISTS oliverInvoice$$

CREATE PROCEDURE oliverInvoice(IN oNum INT)

BEGIN
#SELECT '' AS 'Sales Info';

SELECT CONCAT(firstName, ' ', lastName) INTO @name 
FROM employees WHERE employeeNumber IN (
	SELECT salesRepEmployeeNumber FROM customers WHERE customerNumber IN (
		SELECT customerNumber FROM orders WHERE orderNumber = onum
	)
);

SELECT CONCAT(COALESCE(addressLine1, ''), ' ',  COALESCE(addressLine2, '')) INTO @addr 
FROM offices WHERE officeCode IN (
	SELECT officeCode FROM employees WHERE employeeNumber IN (
		SELECT salesRepEmployeeNumber FROM customers WHERE customerNumber IN (
			SELECT customerNumber FROM orders WHERE orderNumber = oNum
		)
	)
);

SELECT city INTO @city 
FROM offices WHERE officeCode IN (
        SELECT officeCode FROM employees WHERE employeeNumber IN (
                SELECT salesRepEmployeeNumber FROM customers WHERE customerNumber IN (
                        SELECT customerNumber FROM orders WHERE orderNumber = oNum
		)
	)
);

SELECT country INTO @cnty
FROM offices WHERE officeCode IN (
        SELECT officeCode FROM employees WHERE employeeNumber IN (
                SELECT salesRepEmployeeNumber FROM customers WHERE customerNumber IN (
                        SELECT customerNumber FROM orders WHERE orderNumber = oNum
                )
        )
);

SELECT 	@name AS 'Sales Rep Name', @addr AS 'Office Address', 
	@city AS 'Office City', @cnty AS 'Office Country';
##---------------------------------------------------------------------------------------

#SELECT '' AS 'Order Info';

SELECT orderNumber INTO @number FROM orders WHERE orderNumber = oNum;

SELECT orderDate INTO @oDate FROM orders WHERE orderNumber = oNum;

SELECT shippedDate INTO @ship FROM orders WHERE orderNumber = oNum;

SELECT @number AS 'Order Number', @oDate AS 'Order Date', 
	@ship AS 'Shipped Date';
##---------------------------------------------------------------------------------------

#SELECT '' AS 'Customer Info';

SELECT customerName INTO @custName FROM customers WHERE customerNumber IN (
	SELECT customerNumber FROM orders WHERE orderNumber = oNum
);

SELECT CONCAT(contactFirstName, ' ', contactLastName) INTO @conName 
FROM customers WHERE customerNumber IN (
	SELECT customerNumber FROM orders WHERE orderNumber = oNum
);

SELECT CONCAT(addressLine1, ' ', COALESCE(addressLine2, ''), ' ', city, ' ',
	COALESCE(state, ''), ' ', COALESCE(postalCode, ''), 
	' | ', country) INTO @shipAddr
FROM customers WHERE customerNumber IN (
	SELECT customerNumber FROM orders WHERE orderNumber = oNum
);


SELECT 	@custName AS 'Customer Name', @conName AS 'Contact Name', 
	@shipAddr AS 'Shipping Address';
##---------------------------------------------------------------------------------------

#SELECT '' AS 'Detail Lines For the Order';

SELECT p.productCode, p.productName, p.MSRP, o.quantityOrdered, o.priceEach,
(o.priceEach*o.quantityOrdered) AS 'Extended Price', 
((MSRP-o.priceEach)*quantityOrdered) AS 'Discount'
FROM products p, orderdetails o 
WHERE p.productCode = o.productCode
AND o.orderNumber = oNum; 

##---------------------------------------------------------------------------------------

#SELECT '' AS 'Order Totals';
SELECT SUM(priceEach*quantityOrdered) INTO @orderTotal FROM orderdetails
WHERE orderNumber = oNum;

SELECT ROUND((SUM(priceEach*quantityOrdered)*0.06), 2) INTO @tax FROM orderdetails
WHERE orderNumber = oNum;

SELECT @orderTotal AS 'Order Total', @tax AS '6% Tax', 
	ROUND((@orderTotal+@tax), 2) AS 'Grand Total';
##---------------------------------------------------------------------------------------
END$$

DELIMITER ;
