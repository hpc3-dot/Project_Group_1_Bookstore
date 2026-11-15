-- =====================================================
-- Indexed case-insensitive book searching
-- =====================================================

-- Enable trigram-based text searching
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- =====================================================
-- CREATE SEARCH INDEXES
-- =====================================================

-- Index for case-insensitive title searches
CREATE INDEX IF NOT EXISTS idx_books_title_trgm
ON books
USING GIN (title gin_trgm_ops);

-- Index for case-insensitive author searches
CREATE INDEX IF NOT EXISTS idx_authors_name_trgm
ON authors
USING GIN (author_name gin_trgm_ops);

-- =====================================================
-- SEARCH 1: SEARCH BOOKS BY TITLE
-- Expected result: Dune
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
FROM books b
JOIN authors a
    ON b.author_id = a.author_id
WHERE b.title ILIKE '%DUNE%'
ORDER BY b.title;

-- =====================================================
-- SEARCH 2: SEARCH BOOKS BY AUTHOR
-- Expected result: Dune by Frank Herbert
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
FROM books b
JOIN authors a
    ON b.author_id = a.author_id
WHERE a.author_name ILIKE '%HERBERT%'
ORDER BY b.title;

-- =====================================================
-- SEARCH 3: SEARCH BY TITLE OR AUTHOR
-- Example search: 'gaiman'
-- =====================================================

SELECT
    b.book_id,
    b.title,
    a.author_name,
    b.published_year
FROM books b
JOIN authors a
    ON b.author_id = a.author_id
WHERE
    b.title ILIKE '%gaiman%'
    OR a.author_name ILIKE '%gaiman%'
ORDER BY b.title;

-- =====================================================
-- VERIFY SEARCH INDEXES
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
