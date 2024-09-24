SELECT vendor_id, COUNT(*) AS booth_rental_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

SELECT c.customer_first_name, c.customer_last_name, SUM(s.cost_to_customer_per_qty) AS total_spent
FROM customer c
JOIN customer_purchases s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_first_name, c.customer_last_name
HAVING SUM(s.cost_to_customer_per_qty) > 2000
ORDER BY c.customer_last_name, c.customer_first_name;

CREATE TABLE temp.new_vendor AS
SELECT * FROM vendor;

INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomas Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

SELECT customer_id, 
       strftime('%m', market_date) AS month, 
       strftime('%Y', market_date) AS year
FROM customer_purchases;

SELECT customer_id, 
       SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE strftime('%m', market_date) = '04'  -- April (month 04)
  AND strftime('%Y', market_date) = '2022' -- Year 2022
GROUP BY customer_id;