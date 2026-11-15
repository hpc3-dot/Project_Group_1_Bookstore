import { Router } from 'express';
import { pool } from '../db.js';
import { asyncHandler } from '../middleware/errors.js';

const router = Router();

// authors
router.get('/', asyncHandler(async (req, res) => {
  const { rows } = await pool.query(`
    SELECT a.author_id, a.author_name,
           COUNT(b.book_id)::int AS book_count
    FROM authors a
    LEFT JOIN books b ON b.author_id = a.author_id
    GROUP BY a.author_id, a.author_name
    ORDER BY a.author_name
  `);
  res.json({ authors: rows });
}));

export default router;