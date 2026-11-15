export function shapeBook(row) {
  const genres = row.genres || [];

  return {
    id: row.book_id,
    title: row.title,
    author: row.author,
    genre: genres[0] || null,
    genres: genres,
    year: row.published_year,
    description: row.description,
    isbn: row.isbn,
    rating: row.rating ?? null,
    rating_count: row.rating_count ?? 0,

    book_id: row.book_id,
    published_year: row.published_year,
  };
}