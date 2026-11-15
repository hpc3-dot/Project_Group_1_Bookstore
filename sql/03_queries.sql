-- =====================================================
-- QUERY 1: DISPLAY ALL BOOKS WITH THEIR AUTHORS
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
ORDER BY b.book_id;


-- =====================================================
-- QUERY 2: DISPLAY BOOKS WITH AUTHORS AND GENRES
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year,
    g.genre_name
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
INNER JOIN book_genres bg
    ON b.book_id = bg.book_id
INNER JOIN genres g
    ON bg.genre_id = g.genre_id
ORDER BY b.book_id, g.genre_name;


-- =====================================================
-- QUERY 3: DISPLAY EACH BOOK WITH ALL ITS GENRES
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year,
    STRING_AGG(
        g.genre_name,
        ', ' ORDER BY g.genre_name
    ) AS genres
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
INNER JOIN book_genres bg
    ON b.book_id = bg.book_id
INNER JOIN genres g
    ON bg.genre_id = g.genre_id
GROUP BY
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
ORDER BY b.book_id;


-- =====================================================
-- QUERY 4: FIND BOOKS BY GENRE
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
INNER JOIN book_genres bg
    ON b.book_id = bg.book_id
INNER JOIN genres g
    ON bg.genre_id = g.genre_id
WHERE g.genre_name = 'Science Fiction'
ORDER BY b.title;


-- =====================================================
-- QUERY 5: DISPLAY COMPLETE DETAILS FOR ONE BOOK
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year,
    b.description,
    STRING_AGG(
        g.genre_name,
        ', ' ORDER BY g.genre_name
    ) AS genres
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
INNER JOIN book_genres bg
    ON b.book_id = bg.book_id
INNER JOIN genres g
    ON bg.genre_id = g.genre_id
WHERE b.title = 'Dune'
GROUP BY
    b.book_id,
    b.title,
    a.author_name,
    b.published_year,
    b.description;