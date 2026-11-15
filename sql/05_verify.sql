-- =====================================================
-- Purpose: Verify database tables, relationships,
-- book records, and indexed searching.
--
-- Database: bookstore
-- PostgreSQL 17
-- =====================================================


-- =====================================================
-- TEST 1: VERIFY DATABASE RECORD COUNTS
-- Expecting: 20 authors, 43 genres, 20 books,
-- and 62 book-genre relationships.
-- =====================================================

SELECT
    (SELECT COUNT(*) FROM authors) AS total_authors,
    (SELECT COUNT(*) FROM genres) AS total_genres,
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM book_genres) AS total_relationships;


-- =====================================================
-- TEST 2: VERIFY BOOK IDS ARE CONSECUTIVE
-- Expecting: 20 books, IDs 1 through 20.
-- =====================================================

SELECT
    COUNT(*) AS total_books,
    MIN(book_id) AS lowest_id,
    MAX(book_id) AS highest_id,
    COUNT(DISTINCT book_id) AS unique_ids,
    COUNT(DISTINCT book_id) = 20
        AND MIN(book_id) = 1
        AND MAX(book_id) = 20
        AS ids_valid
FROM books;


-- =====================================================
-- TEST 3: VERIFY BOOK-AUTHOR RELATIONSHIPS
-- Expecting: 20 books with valid authors.
-- =====================================================

SELECT
    COUNT(*) AS books_with_authors
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id;


-- =====================================================
-- TEST 4: VERIFY EACH BOOK HAS ITS GENRES
-- Expecting: 20 rows.
-- Most books have 3 genres.
-- Fun Home and The Rings of Saturn have 4.
-- =====================================================

SELECT
    b.book_id,
    b.title,
    COUNT(bg.genre_id) AS genre_count
FROM books b
LEFT JOIN book_genres bg
    ON b.book_id = bg.book_id
GROUP BY b.book_id, b.title
ORDER BY b.book_id;


-- =====================================================
-- TEST 5: CHECK FOR BOOKS WITHOUT GENRES
-- Expecting: 0 rows.
-- =====================================================

SELECT
    b.book_id,
    b.title
FROM books b
LEFT JOIN book_genres bg
    ON b.book_id = bg.book_id
WHERE bg.book_id IS NULL;


-- =====================================================
-- TEST 6: VERIFY CASE-INSENSITIVE SEARCH
-- Expecting: Dune by Frank Herbert.
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
WHERE
    b.title ILIKE '%DUNE%'
    OR a.author_name ILIKE '%HERBERT%'
ORDER BY b.book_id;


-- =====================================================
-- TEST 7: VERIFY SEARCH INDEXES
-- Expecting: 2 rows.
-- =====================================================

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname IN (
      'idx_books_title_trgm',
      'idx_authors_name_trgm'
  )
ORDER BY indexname;

-- =====================================================
-- TEST 8: CHECK FOR DATA QUALITY PROBLEMS
-- Expecting: all three counts equal 0.
-- =====================================================

SELECT
    (
        SELECT COUNT(*)
        FROM (
            SELECT title
            FROM books
            GROUP BY title
            HAVING COUNT(*) > 1
        ) duplicates
    ) AS duplicate_titles,

    (
        SELECT COUNT(*)
        FROM books
        WHERE description IS NULL
           OR TRIM(description) = ''
    ) AS missing_descriptions,

    (
        SELECT COUNT(*)
        FROM (
            SELECT
                b.book_id,
                COUNT(bg.genre_id) AS genre_count
            FROM books b
            LEFT JOIN book_genres bg
                ON b.book_id = bg.book_id
            GROUP BY b.book_id
            HAVING COUNT(bg.genre_id) NOT IN (3, 4)
        ) invalid_counts
    ) AS invalid_genre_counts;

-- =====================================================
-- TEST 9: VERIFY ISBN DATA
-- Expecting: 20 books, 20 ISBNs, 20 unique ISBNs
-- =====================================================

SELECT
    COUNT(*) AS total_books,
    COUNT(isbn) AS books_with_isbn,
    COUNT(DISTINCT isbn) AS unique_isbns,
    COUNT(*) = 20
        AND COUNT(isbn) = 20
        AND COUNT(DISTINCT isbn) = 20
        AS isbn_valid
FROM books;