-- Homework 03 starter — e-commerce sample data (no FOREIGN KEY constraints).
-- Run as-is before Part 1 and Part 2.

DROP TABLE IF EXISTS order_shipment;
DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS shop_order;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS product_tag;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS customer_profile;
DROP TABLE IF EXISTS customer;

-- =========================
-- TABLES WITH PRIMARY + FOREIGN KEYS
-- =========================

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    email TEXT,
    full_name TEXT,
    created_at TIMESTAMPTZ
);

CREATE TABLE customer_profile (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER UNIQUE REFERENCES customer(id),
    loyalty_tier TEXT,
    newsletter_opt_in BOOLEAN
);

CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name TEXT,
    slug TEXT
);

CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES category(id),
    sku TEXT,
    name TEXT,
    unit_price NUMERIC(10,2),
    is_active BOOLEAN
);

CREATE TABLE tag (
    id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE product_tag (
    product_id INTEGER REFERENCES product(id),
    tag_id INTEGER REFERENCES tag(id),
    PRIMARY KEY (product_id, tag_id)
);

CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(id),
    line1 TEXT,
    city TEXT,
    country_code TEXT,
    is_default BOOLEAN
);

CREATE TABLE shop_order (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(id),
    order_number TEXT,
    placed_at TIMESTAMPTZ,
    status TEXT,
    shipping_address_id INTEGER REFERENCES address(id)
);

CREATE TABLE order_line (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES shop_order(id),
    product_id INTEGER REFERENCES product(id),
    quantity INTEGER,
    line_total NUMERIC(10,2)
);

CREATE TABLE order_shipment (
    id SERIAL PRIMARY KEY,
    order_id INTEGER UNIQUE REFERENCES shop_order(id),
    carrier TEXT,
    tracking_code TEXT,
    shipped_at TIMESTAMPTZ
);