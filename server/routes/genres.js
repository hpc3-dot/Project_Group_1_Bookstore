import { Router } from 'express';
import { pool } from '../db.js';
import { asyncHandler } from '../middleware/errors.js';

const router = Router();

// genres for the dropdown
router.get('/', asyncHandler(async (req, res) => {
  const { rows } = await pool.query(`
    SELECT g.genre_id, g.genre_name,
           COUNT(bg.book_id)::int AS book_count
    FROM genres g
    LEFT JOIN book_genres bg ON bg.genre_id = g.genre_id
    GROUP BY g.genre_id, g.genre_name
    ORDER BY g.genre_name
  `);
  res.json({ genres: rows });
}));

export default router;