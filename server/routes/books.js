import { Router } from 'express';
import { pool } from '../db.js';
import { shapeBook } from '../utils/shape.js';
import { asyncHandler } from '../middleware/errors.js';

const router = Router();

const SORTS = {
  default: 'b.book_id ASC',
  title: 'b.title ASC',
  author: 'a.author_name ASC',
  year: 'b.published_year DESC, b.title ASC',
  newest: 'b.book_id DESC',
  rating: 'b.rating DESC NULLS LAST, b.title ASC',
};

function buildBookQuery({ q, genre, rating, sort, id, limit = 100, offset = 0 }) {
  const params = [];
  const conditions = [];

  if (id != null) {
    params.push(id);
    conditions.push(`b.book_id = $${params.length}`);
  }

  if (q) {
    params.push(`%${q}%`);
    conditions.push(
      `(b.title ILIKE $${params.length} OR a.author_name ILIKE $${params.length})`
    );
  }

  if (rating != null) {
    params.push(Number(rating));
    conditions.push(`b.rating >= $${params.length}`);
  }

  let having = '';
  if (genre) {
    params.push(genre);
    having = `HAVING bool_or(g.genre_name = $${params.length})`;
  }

  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const orderBy = SORTS[sort] || SORTS.default;

  params.push(Math.min(Math.max(Number(limit) || 100, 1), 200));
  const limitIdx = params.length;

  params.push(Math.max(Number(offset) || 0, 0));
  const offsetIdx = params.length;

  const sql = `
    SELECT
      b.book_id,
      b.title,
      a.author_name AS author,
      b.published_year,
      b.description,
      b.isbn,
      b.rating,
      b.rating_count,
      COALESCE(
        ARRAY_AGG(g.genre_name ORDER BY g.genre_name)
          FILTER (WHERE g.genre_name IS NOT NULL),
        '{}'
      ) AS genres
    FROM books b
    JOIN authors a ON a.author_id = b.author_id
    LEFT JOIN book_genres bg ON bg.book_id = b.book_id
    LEFT JOIN genres g ON g.genre_id = bg.genre_id
    ${where}
    GROUP BY b.book_id, b.title, a.author_name, b.published_year,
             b.description, b.isbn, b.rating, b.rating_count
    ${having}
    ORDER BY ${orderBy}
    LIMIT $${limitIdx} OFFSET $${offsetIdx}
  `;

  return { sql, params };
}

router.get('/', asyncHandler(async (req, res) => {
  const { q, genre, rating, sort, limit, offset } = req.query;

  const { sql, params } = buildBookQuery({
    q: q?.trim(),
    genre: genre?.trim(),
    rating: rating !== undefined && rating !== '' ? rating : null,
    sort,
    limit,
    offset,
  });

  const { rows } = await pool.query(sql, params);
  res.json({ books: rows.map(shapeBook) });
}));

router.get('/:id', asyncHandler(async (req, res) => {
  const id = Number(req.params.id);

  if (!Number.isInteger(id) || id < 1) {
    const err = new Error('Invalid book id');
    err.status = 400;
    throw err;
  }

  const { sql, params } = buildBookQuery({ id });
  const { rows } = await pool.query(sql, params);

  if (rows.length === 0) {
    const err = new Error('Book not found');
    err.status = 404;
    throw err;
  }

  res.json({ book: shapeBook(rows[0]) });
}));

export default router;