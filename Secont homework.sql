CREATE TABLE cafeteria_menu_item (
    id SERIAL PRIMARY KEY,

    code TEXT NOT NULL UNIQUE,

    dish_name TEXT NOT NULL,
    category TEXT NOT NULL,

    kitchen_section TEXT,

    spice_level INTEGER CHECK (spice_level BETWEEN 1 AND 5),

    price_eur NUMERIC(10, 2) CHECK (price_eur >= 0),

    added_to_menu DATE NOT NULL,

    last_restocked_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    dietary_note TEXT,

    is_late_night BOOLEAN NOT NULL DEFAULT FALSE,

    remake_count INTEGER CHECK (remake_count >= 0),

    prep_station_code TEXT NOT NULL
        CHECK (prep_station_code ~ '^K-[A-Z]{4}$'),

    short_label TEXT
);

INSERT INTO cafeteria_menu_item (
    code, dish_name, short_label, category, kitchen_section, spice_level,
    price_eur, added_to_menu, last_restocked_at, dietary_note,
    is_late_night, remake_count, prep_station_code
) VALUES
    ('FD-001', 'Diavola Pizza', 'Diav', 'Pizza', 'Hollow brick oven', 4, 10.50, '2024-03-10', '2025-01-15 08:30:00+00', 'vegetarian', FALSE, 0, 'K-ALFA'),
    ('FD-002', 'Beef Burger', NULL, 'Burger', 'Grill line', 4, 11.00, '2023-11-02', '2025-01-14 22:10:00+00', NULL, FALSE, 3, 'K-BETA'),
    ('FD-003', 'Caesar Salad', 'Caesar', 'Salad', 'Cold prep', 1, 7.25, '2024-07-21', '2025-01-16 06:00:00+00', 'contains fish', FALSE, 1, 'K-ALFA'),
    ('FD-004', 'Tom Yum Soup', 'Tom Yum', 'Soup', 'Steam counter', 5, 8.90, '2022-05-18', '2025-01-16 03:45:00+00', 'shrimp', TRUE, 7, 'K-GAMM'),
    ('FD-005', 'Chili Cheese Fries', 'Chili', 'Sides', 'Fry station', 4, 6.20, '2025-01-01', '2025-01-15 12:00:00+00', 'spicy', FALSE, 0, 'K-BETA'),
    ('FD-006', 'Chicken Tikka', NULL, 'Grill', 'Tandoor corner', 4, 12.40, '2024-09-09', '2025-01-14 18:20:00+00', 'dairy', TRUE, 2, 'K-ALFA'),
    ('FD-007', 'Chocolate Cake', 'Cake', 'Dessert', 'Pastry fridge', 1, 5.99, '2023-01-30', '2025-01-16 01:00:00+00', 'nuts', TRUE, 4, 'K-GAMM'),
    ('FD-008', 'Veggie Wrap', 'Wrap', 'Wraps', 'Cold prep', 4, 6.75, '2024-04-04', '2025-01-15 09:15:00+00', 'vegan', FALSE, 0, 'K-BETA'),
    ('FD-009', 'Spicy Chicken Wings', 'Wings', 'Grill', 'Grill line', 4, 10.50, '2023-08-08', '2025-01-16 04:00:00+00', NULL, TRUE, 5, 'K-GAMM'),
    ('FD-010', 'Greek Salad', NULL, 'Salad', 'Cold prep', 4, 8.00, '2024-12-12', '2025-01-15 14:30:00+00', 'cheese', FALSE, 1, 'K-ALFA'),
    ('FD-011', 'Marinara Pizza', 'Marinara', 'Pizza', 'Hollow brick oven', 4, 8.50, '2024-03-11', '2025-01-15 08:35:00+00', 'vegan', FALSE, 0, 'K-ALFA'),
    ('FD-012', 'Fish and Chips', 'F&C', 'Fry meal', 'Fry station', 4, 13.00, '2021-06-06', '2025-01-10 10:10:00+00', 'fish', FALSE, 12, 'K-DELT'),
    ('FD-013', 'Miso Soup', NULL, 'Soup', 'Steam counter', 1, 4.20, '2024-02-28', '2025-01-16 07:07:00+00', 'soy', TRUE, 2, 'K-BETA'),
    ('FD-014', 'Penne Arrabiata', 'Arrabiata', 'Pasta', 'Pasta station', 4, 9.00, '2024-10-10', '2025-01-15 16:00:00+00', 'vegetarian', FALSE, 0, 'K-ALFA'),
    ('FD-015', 'Energy Bar', 'Bar', 'Snack', 'Checkout shelf', 1, 2.50, '2025-01-05', '2025-01-16 00:00:01+00', 'gluten', TRUE, 0, 'K-GAMM'),
    ('FD-016', 'Kimchi Fried Rice', 'KFR', 'Rice bowl', 'Wok station', 4, 9.80, '2024-06-01', '2025-01-16 11:00:00+00', 'egg', FALSE, 1, 'K-GAMM'),
    ('FD-017', 'Jalapeño Poppers', 'Poppers', 'Sides', 'Fry station', 4, 7.10, '2024-08-15', '2025-01-15 19:00:00+00', 'dairy', TRUE, 2, 'K-BETA'),
    ('FD-018', 'Lamb Vindaloo', 'Vindaloo', 'Grill', 'Tandoor corner', 5, 14.20, '2023-04-20', '2025-01-16 02:00:00+00', NULL, TRUE, 3, 'K-ALFA'),
    ('FD-019', 'Buffalo Cauliflower', 'Buffalo', 'Sides', 'Fry station', 4, 7.90, '2024-11-11', '2025-01-15 17:45:00+00', 'vegan', FALSE, 0, 'K-BETA'),
    ('FD-020', 'Shrimp Tacos', 'Tacos', 'Grill', 'Grill line', 4, 12.90, '2024-05-05', '2025-01-16 05:30:00+00', 'shellfish', TRUE, 1, 'K-GAMM');

	-- =========================
-- PART 2 — SELECT QUERIES
-- =========================

-- Task 1: Very spicy
SELECT code, dish_name, price_eur, spice_level
FROM cafeteria_menu_item
WHERE spice_level >= 4
ORDER BY price_eur DESC, dish_name ASC;

-- Task 2: Oven section (contains "Hollow", case-insensitive)
SELECT code, dish_name, category, kitchen_section
FROM cafeteria_menu_item
WHERE kitchen_section ILIKE '%hollow%'
ORDER BY category, code;

-- Task 3: Late-night trouble
SELECT code, dish_name, remake_count
FROM cafeteria_menu_item
WHERE is_late_night = TRUE AND remake_count > 0
ORDER BY remake_count DESC;

-- Task 4: Mid price band (5 < price < 12)
SELECT code, dish_name, price_eur, added_to_menu
FROM cafeteria_menu_item
WHERE price_eur > 5 AND price_eur < 12
ORDER BY added_to_menu ASC;

-- Task 5: Restock check
SELECT code, dish_name, last_restocked_at
FROM cafeteria_menu_item
WHERE last_restocked_at < '2025-01-16 00:00:00+00'
ORDER BY last_restocked_at ASC;

-- Task 6: Group stats
SELECT 
    category,
    COUNT(*) AS total_dishes,
    ROUND(AVG(price_eur), 2) AS avg_price
FROM cafeteria_menu_item
GROUP BY category
HAVING COUNT(*) >= 2
ORDER BY total_dishes DESC, category ASC;

-- Task 7: Station workload
SELECT 
    prep_station_code,
    SUM(remake_count) AS total_remakes,
    COUNT(DISTINCT category) AS category_count
FROM cafeteria_menu_item
GROUP BY prep_station_code
ORDER BY total_remakes DESC;

-- Task 8: Menu size
SELECT COUNT(*) AS total_dishes
FROM cafeteria_menu_item;

-- Task 9: Average heat
SELECT ROUND(AVG(spice_level), 2) AS avg_spice_level
FROM cafeteria_menu_item;

-- Task 10: Total remakes
SELECT SUM(remake_count) AS total_remakes
FROM cafeteria_menu_item;

-- Task 11: Price range
SELECT 
    MIN(price_eur) AS min_price,
    MAX(price_eur) AS max_price
FROM cafeteria_menu_item;

-- Task 12: Kitchen sections count
SELECT COUNT(DISTINCT kitchen_section) AS total_sections
FROM cafeteria_menu_item;

-- Task 13: Late-night tally
SELECT COUNT(*) AS late_night_dishes
FROM cafeteria_menu_item
WHERE is_late_night = TRUE;

-- Task 14: Second page of spicy dishes (page size = 5)
SELECT code, dish_name, price_eur, spice_level
FROM cafeteria_menu_item
WHERE spice_level >= 4
ORDER BY price_eur DESC, dish_name ASC
LIMIT 5 OFFSET 5;