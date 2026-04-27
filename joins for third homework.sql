-- A1
SELECT p.name, c.name AS category_name
FROM product p
JOIN category c ON p.category_id = c.id;

-- A2
SELECT c.email, cp.loyalty_tier
FROM customer c
JOIN customer_profile cp ON c.id = cp.customer_id;

-- A3
SELECT o.order_number, c.full_name
FROM shop_order o
JOIN customer c ON o.customer_id = c.id;

-- A4
SELECT o.order_number, p.name, ol.quantity
FROM order_line ol
JOIN shop_order o ON ol.order_id = o.id
JOIN product p ON ol.product_id = p.id;

-- A5
SELECT t.name
FROM product p
JOIN product_tag pt ON p.id = pt.product_id
JOIN tag t ON pt.tag_id = t.id
WHERE p.name = 'Wireless earbuds';

-- B1
SELECT o.order_number, o.placed_at, c.email
FROM shop_order o
JOIN customer c ON o.customer_id = c.id
WHERE o.status = 'delivered';

-- B2
SELECT p.sku, p.unit_price
FROM product p
JOIN category c ON p.category_id = c.id
WHERE p.is_active = TRUE AND c.name = 'Books';

-- B3
SELECT c.email, cp.loyalty_tier
FROM customer c
JOIN customer_profile cp ON c.id = cp.customer_id
WHERE cp.newsletter_opt_in = TRUE;

-- B4
SELECT o.order_number, p.name, ol.line_total
FROM order_line ol
JOIN shop_order o ON ol.order_id = o.id
JOIN product p ON ol.product_id = p.id
WHERE ol.line_total > 50;

-- B5
SELECT c.full_name, a.line1, a.is_default
FROM address a
JOIN customer c ON a.customer_id = c.id
WHERE a.city = 'Skopje';

-- C1
SELECT c.full_name, COUNT(a.id) AS address_count
FROM customer c
LEFT JOIN address a ON c.id = a.customer_id
GROUP BY c.id, c.full_name;

-- C2
SELECT c.full_name, COUNT(o.id) AS order_count
FROM customer c
LEFT JOIN shop_order o ON c.id = o.customer_id
GROUP BY c.id, c.full_name;

-- C3
SELECT o.order_number, COUNT(ol.id) AS line_count
FROM shop_order o
LEFT JOIN order_line ol ON o.id = ol.order_id
GROUP BY o.id, o.order_number;

-- C4
SELECT c.name, COUNT(p.id) AS product_count
FROM category c
JOIN product p ON c.id = p.category_id
GROUP BY c.id, c.name
HAVING COUNT(p.id) >= 2;

-- C5
SELECT c.email
FROM customer c
JOIN address a ON c.id = a.customer_id
GROUP BY c.id, c.email
HAVING COUNT(a.id) > 1;

-- D1
SELECT p.name
FROM product p
JOIN product_tag pt ON p.id = pt.product_id
JOIN tag t ON pt.tag_id = t.id
WHERE t.name = 'bestseller';

-- D2
SELECT t.name, COUNT(pt.product_id) AS product_count
FROM tag t
LEFT JOIN product_tag pt ON t.id = pt.tag_id
GROUP BY t.id, t.name;

-- D3
SELECT p.name
FROM product p
LEFT JOIN product_tag pt ON p.id = pt.product_id
WHERE pt.product_id IS NULL;

-- D4
SELECT p.name, t.name
FROM product_tag pt
JOIN product p ON pt.product_id = p.id
JOIN tag t ON pt.tag_id = t.id;

-- D5
SELECT t.name
FROM tag t
LEFT JOIN product_tag pt ON t.id = pt.tag_id
WHERE pt.tag_id IS NULL;

-- E1
SELECT o.order_number, SUM(ol.line_total) AS total
FROM shop_order o
JOIN order_line ol ON o.id = ol.order_id
GROUP BY o.id, o.order_number;

-- E2
SELECT c.name, AVG(p.unit_price) AS avg_price
FROM category c
JOIN product p ON c.id = p.category_id
WHERE p.is_active = TRUE
GROUP BY c.id, c.name;

-- E3
SELECT o.order_number, p.name, ol.line_total
FROM order_line ol
JOIN shop_order o ON ol.order_id = o.id
JOIN product p ON ol.product_id = p.id
ORDER BY ol.line_total DESC
LIMIT 1;

-- E4
SELECT c.email, SUM(ol.line_total) AS total_spent
FROM customer c
JOIN shop_order o ON c.id = o.customer_id
JOIN order_line ol ON o.id = ol.order_id
GROUP BY c.id, c.email;

-- E5
SELECT o.order_number, SUM(ol.line_total) AS total
FROM shop_order o
JOIN order_line ol ON o.id = ol.order_id
GROUP BY o.id, o.order_number
HAVING SUM(ol.line_total) > 100;

-- F1
SELECT order_number, placed_at, status
FROM shop_order
WHERE EXTRACT(YEAR FROM placed_at) = 2025
ORDER BY placed_at DESC;

-- F2
SELECT o.order_number, c.email
FROM shop_order o
JOIN customer c ON o.customer_id = c.id
ORDER BY o.placed_at ASC
LIMIT 1;

-- F3
SELECT name, unit_price
FROM product
WHERE is_active = TRUE
AND unit_price < (
    SELECT AVG(unit_price)
    FROM product
    WHERE is_active = TRUE
);

-- G1
SELECT c.email
FROM customer c
LEFT JOIN customer_profile cp ON c.id = cp.customer_id
WHERE cp.id IS NULL;

-- G2
SELECT o.order_number, o.status
FROM shop_order o
LEFT JOIN order_shipment os ON o.id = os.order_id
WHERE os.id IS NULL;

-- G3
SELECT c.name
FROM category c
LEFT JOIN product p ON c.id = p.category_id
WHERE p.id IS NULL;

-- H1
SELECT o.order_number, os.tracking_code, os.carrier
FROM shop_order o
JOIN order_shipment os ON o.id = os.order_id
WHERE o.status = 'delivered';

-- H2
SELECT o.order_number, c.full_name, a.city
FROM shop_order o
JOIN customer c ON o.customer_id = c.id
JOIN address a ON o.shipping_address_id = a.id;

-- H3
SELECT DISTINCT c.email
FROM customer c
JOIN customer_profile cp ON c.id = cp.customer_id
JOIN shop_order o ON c.id = o.customer_id
WHERE cp.loyalty_tier = 'gold';

-- H4
SELECT customer_id
FROM customer_profile
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- I1
SELECT cat.name, SUM(ol.line_total) AS total
FROM order_line ol
JOIN product p ON ol.product_id = p.id
JOIN category cat ON p.category_id = cat.id
GROUP BY cat.id, cat.name;

-- I2
SELECT c.email, SUM(ol.line_total) AS total_spent
FROM customer c
JOIN shop_order o ON c.id = o.customer_id
JOIN order_line ol ON o.id = ol.order_id
GROUP BY c.id, c.email
ORDER BY total_spent DESC
LIMIT 1;

-- I3
SELECT DISTINCT p1.name AS product1, p2.name AS product2
FROM order_line ol1
JOIN order_line ol2 
  ON ol1.order_id = ol2.order_id 
 AND ol1.product_id < ol2.product_id
JOIN product p1 ON ol1.product_id = p1.id
JOIN product p2 ON ol2.product_id = p2.id;

-- I4
SELECT DATE_TRUNC('month', placed_at) AS month, COUNT(*) AS order_count
FROM shop_order
WHERE EXTRACT(YEAR FROM placed_at) = 2024
GROUP BY month
ORDER BY month;

-- I5
SELECT DISTINCT shipping_address_id
FROM shop_order o
LEFT JOIN address a ON o.shipping_address_id = a.id
WHERE a.id IS NULL;