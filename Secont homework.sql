-- =========================
-- DROP OLD TABLES
-- =========================

DROP TABLE IF EXISTS cafeteria_menu_item;
DROP TABLE IF EXISTS kitchen_station;
DROP TABLE IF EXISTS menu_category;

-- =========================
-- CATEGORY TABLE
-- =========================

CREATE TABLE menu_category (
    id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL UNIQUE
);

-- =========================
-- KITCHEN STATION TABLE
-- =========================

CREATE TABLE kitchen_station (
    id SERIAL PRIMARY KEY,

    prep_station_code TEXT NOT NULL UNIQUE
        CHECK (prep_station_code ~ '^K-[A-Z]{4}$'),

    kitchen_section TEXT NOT NULL
);

-- =========================
-- MAIN TABLE
-- =========================

CREATE TABLE cafeteria_menu_item (
    id SERIAL PRIMARY KEY,

    code TEXT NOT NULL UNIQUE,

    dish_name TEXT NOT NULL,

    short_label TEXT,

    category_id INTEGER NOT NULL
        REFERENCES menu_category(id),

    station_id INTEGER NOT NULL
        REFERENCES kitchen_station(id),

    spice_level INTEGER
        CHECK (spice_level BETWEEN 1 AND 5),

    price_eur NUMERIC(10,2)
        CHECK (price_eur >= 0),

    added_to_menu DATE NOT NULL,

    last_restocked_at TIMESTAMPTZ
        DEFAULT CURRENT_TIMESTAMP,

    dietary_note TEXT,

    is_late_night BOOLEAN NOT NULL DEFAULT FALSE,

    remake_count INTEGER
        CHECK (remake_count >= 0)
);

-- =========================
-- CATEGORY DATA
-- =========================

INSERT INTO menu_category (category_name)
VALUES
('Pizza'),
('Burger'),
('Salad'),
('Soup'),
('Sides'),
('Grill'),
('Dessert'),
('Wraps'),
('Fry meal'),
('Pasta'),
('Snack'),
('Rice bowl');

-- =========================
-- STATION DATA
-- =========================

INSERT INTO kitchen_station (
    prep_station_code,
    kitchen_section
)
VALUES
('K-ALFA', 'Hollow brick oven'),
('K-BETA', 'Cold prep'),
('K-GAMM', 'Steam counter'),
('K-DELT', 'Fry station');

-- =========================
-- MENU ITEMS
-- =========================

INSERT INTO cafeteria_menu_item (
    code,
    dish_name,
    short_label,
    category_id,
    station_id,
    spice_level,
    price_eur,
    added_to_menu,
    last_restocked_at,
    dietary_note,
    is_late_night,
    remake_count
)
 VALUES
('FD-001', 'Diavola Pizza', 'Diav', 1, 1, 4, 10.50, '2024-03-10', '2025-01-15 08:30:00+00', 'vegetarian', FALSE, 0),

('FD-002', 'Beef Burger', NULL, 2, 2, 4, 11.00, '2023-11-02', '2025-01-14 22:10:00+00', NULL, FALSE, 3),

('FD-003', 'Caesar Salad', 'Caesar', 3, 2, 1, 7.25, '2024-07-21', '2025-01-16 06:00:00+00', 'contains fish', FALSE, 1),

('FD-004', 'Tom Yum Soup', 'Tom Yum', 4, 3, 5, 8.90, '2022-05-18', '2025-01-16 03:45:00+00', 'shrimp', TRUE, 7),

('FD-005', 'Chili Cheese Fries', 'Chili', 5, 4, 4, 6.20, '2025-01-01', '2025-01-15 12:00:00+00', 'spicy', FALSE, 0),

('FD-006', 'Chicken Tikka', NULL, 6, 1, 4, 12.40, '2024-09-09', '2025-01-14 18:20:00+00', 'dairy', TRUE, 2),

('FD-007', 'Chocolate Cake', 'Cake', 7, 3, 1, 5.99, '2023-01-30', '2025-01-16 01:00:00+00', 'nuts', TRUE, 4),

('FD-008', 'Veggie Wrap', 'Wrap', 8, 2, 4, 6.75, '2024-04-04', '2025-01-15 09:15:00+00', 'vegan', FALSE, 0),

('FD-009', 'Spicy Chicken Wings', 'Wings', 6, 3, 4, 10.50, '2023-08-08', '2025-01-16 04:00:00+00', NULL, TRUE, 5),

('FD-010', 'Greek Salad', NULL, 3, 2, 4, 8.00, '2024-12-12', '2025-01-15 14:30:00+00', 'cheese', FALSE, 1),

('FD-011', 'Marinara Pizza', 'Marinara', 1, 1, 4, 8.50, '2024-03-11', '2025-01-15 08:35:00+00', 'vegan', FALSE, 0),

('FD-012', 'Fish and Chips', 'F&C', 9, 4, 4, 13.00, '2021-06-06', '2025-01-10 10:10:00+00', 'fish', FALSE, 12),

('FD-013', 'Miso Soup', NULL, 4, 3, 1, 4.20, '2024-02-28', '2025-01-16 07:07:00+00', 'soy', TRUE, 2),

('FD-014', 'Penne Arrabiata', 'Arrabiata', 10, 1, 4, 9.00, '2024-10-10', '2025-01-15 16:00:00+00', 'vegetarian', FALSE, 0),

('FD-015', 'Energy Bar', 'Bar', 11, 3, 1, 2.50, '2025-01-05', '2025-01-16 00:00:01+00', 'gluten', TRUE, 0),

('FD-016', 'Kimchi Fried Rice', 'KFR', 12, 3, 4, 9.80, '2024-06-01', '2025-01-16 11:00:00+00', 'egg', FALSE, 1),

('FD-017', 'Jalapeño Poppers', 'Poppers', 5, 4, 4, 7.10, '2024-08-15', '2025-01-15 19:00:00+00', 'dairy', TRUE, 2),

('FD-018', 'Lamb Vindaloo', 'Vindaloo', 6, 1, 5, 14.20, '2023-04-20', '2025-01-16 02:00:00+00', NULL, TRUE, 3),

('FD-019', 'Buffalo Cauliflower', 'Buffalo', 5, 4, 4, 7.90, '2024-11-11', '2025-01-15 17:45:00+00', 'vegan', FALSE, 0),

('FD-020', 'Shrimp Tacos', 'Tacos', 6, 3, 4, 12.90, '2024-05-05', '2025-01-16 05:30:00+00', 'shellfish', TRUE, 1);

-- =========================
-- PART 2 — SELECT QUERIES
-- =========================

-- Task 1: Very spicy
SELECT
    code,
    dish_name,
    price_eur,
    spice_level
FROM cafeteria_menu_item
WHERE spice_level >= 4
ORDER BY price_eur DESC, dish_name ASC;

-- Task 2: Oven section (contains "Hollow", case-insensitive)
SELECT
    cmi.code,
    cmi.dish_name,
    mc.category_name,
    ks.kitchen_section
FROM cafeteria_menu_item cmi
JOIN menu_category mc
    ON cmi.category_id = mc.id
JOIN kitchen_station ks
    ON cmi.station_id = ks.id
WHERE ks.kitchen_section ILIKE '%hollow%'
ORDER BY mc.category_name, cmi.code;

-- Task 3: Late-night trouble
SELECT
    code,
    dish_name,
    remake_count
FROM cafeteria_menu_item
WHERE is_late_night = TRUE
    AND remake_count > 0
ORDER BY remake_count DESC;

-- Task 4: Mid price band (5 < price < 12)
SELECT
    code,
    dish_name,
    price_eur,
    added_to_menu
FROM cafeteria_menu_item
WHERE price_eur > 5
    AND price_eur < 12
ORDER BY added_to_menu ASC;

-- Task 5: Restock check
SELECT
    code,
    dish_name,
    last_restocked_at
FROM cafeteria_menu_item
WHERE last_restocked_at < '2025-01-16 00:00:00+00'
ORDER BY last_restocked_at ASC;

-- Task 6: Group stats
SELECT
    mc.category_name,
    COUNT(*) AS total_dishes,
    ROUND(AVG(cmi.price_eur), 2) AS avg_price
FROM cafeteria_menu_item cmi
JOIN menu_category mc
    ON cmi.category_id = mc.id
GROUP BY mc.category_name
HAVING COUNT(*) >= 2
ORDER BY total_dishes DESC, mc.category_name ASC;

-- Task 7: Station workload
SELECT
    ks.prep_station_code,
    SUM(cmi.remake_count) AS total_remakes,
    COUNT(DISTINCT cmi.category_id) AS category_count
FROM cafeteria_menu_item cmi
JOIN kitchen_station ks
    ON cmi.station_id = ks.id
GROUP BY ks.prep_station_code
ORDER BY total_remakes DESC;

-- Task 8: Menu size
SELECT
    COUNT(*) AS total_dishes
FROM cafeteria_menu_item;

-- Task 9: Average heat
SELECT
    ROUND(AVG(spice_level), 2) AS avg_spice_level
FROM cafeteria_menu_item;

-- Task 10: Total remakes
SELECT
    SUM(remake_count) AS total_remakes
FROM cafeteria_menu_item;

-- Task 11: Price range
SELECT
    MIN(price_eur) AS min_price,
    MAX(price_eur) AS max_price
FROM cafeteria_menu_item;

-- Task 12: Kitchen sections count
SELECT
    COUNT(DISTINCT kitchen_section) AS total_sections
FROM kitchen_station;

-- Task 13: Late-night tally
SELECT
    COUNT(*) AS late_night_dishes
FROM cafeteria_menu_item
WHERE is_late_night = TRUE;

-- Task 14: Second page of spicy dishes (page size = 5)
SELECT
    code,
    dish_name,
    price_eur,
    spice_level
FROM cafeteria_menu_item
WHERE spice_level >= 4
ORDER BY price_eur DESC, dish_name ASC
LIMIT 5 OFFSET 5;