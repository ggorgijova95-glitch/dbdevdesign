-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    birth_date DATE,
    monthly_listeners INTEGER,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    duration_seconds INTEGER,
    release_date DATE,
    is_explicit BOOLEAN NOT NULL
);

CREATE TABLE playlists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    owner_name VARCHAR(100) NOT NULL,
    followers_count INTEGER,
    created_at DATE,
    is_public BOOLEAN NOT NULL
);


-- =========================
-- INSERT DATA - ARTISTS
-- =========================

INSERT INTO artists (name, country, birth_date, monthly_listeners, is_active) VALUES
('Taylor Swift', 'USA', '1989-12-13', 100000000, TRUE),
('Drake', 'Canada', '1986-10-24', 85000000, TRUE),
('Adele', 'UK', '1988-05-05', 60000000, TRUE),
('Eminem', 'USA', '1972-10-17', 70000000, TRUE),
('Rihanna', 'Barbados', '1988-02-20', 90000000, FALSE);


-- =========================
-- INSERT DATA - SONGS
-- =========================

INSERT INTO songs (title, artist_name, genre, duration_seconds, release_date, is_explicit) VALUES
('Blank Space', 'Taylor Swift', 'Pop', 231, '2014-11-10', FALSE),
('Gods Plan', 'Drake', 'Hip-Hop', 198, '2018-01-19', TRUE),
('Hello', 'Adele', 'Soul', 295, '2015-10-23', FALSE),
('Lose Yourself', 'Eminem', 'Rap', 326, '2002-10-28', TRUE),
('Diamonds', 'Rihanna', 'Pop', 225, '2012-09-27', FALSE),
('Shape of You', 'Ed Sheeran', 'Pop', 233, '2017-01-06', FALSE),
('Someone Like You', 'Adele', 'Ballad', 285, '2011-01-24', FALSE),
('Stan', 'Eminem', 'Rap', 404, '2000-12-09', TRUE),
('Hotline Bling', 'Drake', 'Hip-Hop', 267, '2015-07-31', FALSE),
('Anti-Hero', 'Taylor Swift', 'Pop', 200, '2022-10-21', FALSE);


-- =========================
-- INSERT DATA - PLAYLISTS
-- =========================

INSERT INTO playlists (name, description, owner_name, followers_count, created_at, is_public) VALUES
('Top Hits', 'Most popular songs right now', 'Gabriela', 1500, '2024-01-10', TRUE),
('Chill Vibes', 'Relaxing and calm music', 'Ana', 800, '2024-02-15', TRUE),
('Workout Mix', 'High energy songs for gym', 'Marko', 1200, '2024-03-01', FALSE);