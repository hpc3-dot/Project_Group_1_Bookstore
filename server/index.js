import 'dotenv/config';
import express from 'express';
import booksRouter from './routes/books.js';
import authorsRouter from './routes/authors.js';
import genresRouter from './routes/genres.js';
import { errorHandler } from './middleware/errors.js';

const app = express();
const PORT = Number(process.env.PORT) || 3000;

app.use(express.json());

if (process.env.NODE_ENV !== 'production') {
  app.use((req, res, next) => {
    console.log(`${req.method} ${req.originalUrl}`);
    next();
  });
}

app.get('/health', (req, res) => {
  res.json({ ok: true, service: 'bookstore-api' });
});

app.use('/books', booksRouter);
app.use('/authors', authorsRouter);
app.use('/genres', genresRouter);

app.use((req, res) => {
  res.status(404).json({
    error: `No route for ${req.method} ${req.originalUrl}`,
  });
});

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Bookstore API listening on http://localhost:${PORT}`);
});