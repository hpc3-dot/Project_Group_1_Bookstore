import books from '/public/bookstore-assets/books.json';
import Book from './Book';

function BookCase(setPage) {
    return (
        <div className="bookCase">
            {books.map((book) => (
                <Book
                    key={book.book_id}
                    title={book.title}
                    author={book.author}
                    cover_art={book.cover_art}
                    currentPage={setPage}
                />
            ))}
        </div>
    )
}

export default BookCase;