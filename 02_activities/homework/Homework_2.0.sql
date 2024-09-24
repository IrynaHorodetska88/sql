SELECT *
FROM customer;

SELECT *
FROM customer
ORDER BY customer_last_name, customer_first_name
LIMIT 10;

SELECT *
FROM customer_purchases
WHERE product_id IN (4, 9);

SELECT *, (quantity * cost_to_customer_per_qty) AS price
FROM customer_purchases
WHERE vendor_id >= 8 AND vendor_id <= 10;

SELECT product_id, product_name,
CASE WHEN product_qty_type = 'unit' THEN 'unit' 
	 ELSE 'bulk'
END AS product_qty_type_condensed
FROM product;

SELECT product_id, product_name,
CASE WHEN product_qty_type = 'unit' THEN 'unit' 
	 ELSE 'bulk'
END AS product_qty_type_condensed,
CASE WHEN LOWER(product_name) LIKE '%pepper%' THEN 1
ELSE 0
END AS pepper_flag
FROM product;

SELECT v.vendor_id, v.vendor_name, v.vendor_type, v.vendor_owner_first_name, v.vendor_owner_last_name, vba.booth_number, vba.market_date
FROM
vendor v
INNER JOIN vendor_booth_assignments vba
ON
v.vendor_id = vba.vendor_id
ORDER BY
v.vendor_name,
vba.market_date;
