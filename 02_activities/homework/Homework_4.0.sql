SELECT 
COALESCE(product_name, '') || ', ' || 
COALESCE(product_size, '') || ' (' || 
COALESCE(product_qty_type, 'unit') || ')'
FROM product;

SELECT customer_id, market_date, 
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM customer_purchases;

SELECT customer_id, market_date, 
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
FROM customer_purchases;

WITH RankedVisits AS (
    SELECT customer_id, market_date, 
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS visit_number
    FROM customer_purchases
)
SELECT customer_id, market_date
FROM RankedVisits
WHERE visit_number = 1;

SELECT customer_id, product_id, market_date, quantity, 
       COUNT(*) OVER (PARTITION BY customer_id, product_id) AS product_purchase_count
FROM customer_purchases;

SELECT product_name,
       TRIM(SUBSTR(product_name, INSTR(product_name, '-') + 1)) AS description
FROM product
WHERE INSTR(product_name, '-') > 0;

WITH SalesPerDay AS (
    SELECT market_date, 
           SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),
RankedSales AS (
    SELECT market_date, total_sales,
           RANK() OVER (ORDER BY total_sales DESC) AS best_day_rank,
           RANK() OVER (ORDER BY total_sales ASC) AS worst_day_rank
    FROM SalesPerDay
)
SELECT market_date, total_sales, 'Best Day' AS category
FROM RankedSales
WHERE best_day_rank = 1

UNION

SELECT market_date, total_sales, 'Worst Day' AS category
FROM RankedSales
WHERE worst_day_rank = 1;
