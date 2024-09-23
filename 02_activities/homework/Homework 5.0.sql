WITH VendorProductInfo AS (
    SELECT v.vendor_name, 
           p.product_name, 
           vi.original_price
    FROM vendor_inventory vi
    JOIN vendor v ON vi.vendor_id = v.vendor_id
    JOIN product p ON vi.product_id = p.product_id
),
CustomerCount AS (
    SELECT COUNT(*) AS customer_count
    FROM customer
)
SELECT vpi.vendor_name, 
       vpi.product_name, 
       (5 * vpi.original_price * cc.customer_count) AS total_money
FROM VendorProductInfo vpi
CROSS JOIN CustomerCount cc
GROUP BY vpi.vendor_name, vpi.product_name;

CREATE TABLE product_units AS 
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type = 'unit';

INSERT INTO product_units (product_id, product_name, product_size, product_qty_type, snapshot_timestamp)
VALUES (999, 'Apple Pie', 'Large', 'unit', CURRENT_TIMESTAMP);

SELECT *
FROM product_units
WHERE product_name = 'Apple Pie'
ORDER BY snapshot_timestamp;

DELETE FROM product_units
WHERE product_name = 'Apple Pie'
AND snapshot_timestamp = (
    SELECT MIN(snapshot_timestamp) 
    FROM product_units
    WHERE product_name = 'Apple Pie'
);

ALTER TABLE product_units
ADD current_quantity INT;

SELECT vi.product_id, COALESCE(vi.quantity, 0) AS last_quantity
FROM vendor_inventory vi
WHERE vi.market_date = (
    SELECT MAX(market_date) 
    FROM vendor_inventory v2
    WHERE v2.product_id = vi.product_id
);

UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(vi.quantity, 0)
    FROM vendor_inventory vi
    WHERE vi.product_id = product_units.product_id
    AND vi.market_date = (
        SELECT MAX(market_date) 
        FROM vendor_inventory v2
        WHERE v2.product_id = vi.product_id
    )
)
WHERE product_units.product_id IN (
    SELECT DISTINCT product_id FROM vendor_inventory
);

