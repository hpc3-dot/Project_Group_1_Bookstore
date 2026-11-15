import books from '/public/bookstore-assets/books.json';
import Book from './Book';
import { useState, useEffect } from 'react';

function BookCase({ setPage, searchValues }) {
    const [books, setbooks] = useState([]);
    const [errorMessage, setErrorMessage] = useState('');

    useEffect(() => {
        async function fetchBooks() {
            try{
                const response = await fetch('/public/bookstore-assets/books');
                const data = await response.json();
                setbooks(data);
                console.log(data);
            } catch (err) {
                setErrorMessage('Failed to fetch books. Please try again later.');
            }
        };
        fetchBooks();
    }, []);

    const filteredBooks = books.filter((book) => {
        const matchesSearch = book.title.toLowerCase().includes(searchValues.searchText.toLowerCase()) ||book.author.toLowerCase().includes(searchValues.searchText.toLowerCase());
        const matchesGenre = searchValues.genre === '' || book.genre === searchValues.genre;
        const matchesRating =searchValues.rating === '' || Number(book.rating) >= Number(searchValues.rating);
        return matchesSearch && matchesGenre && matchesRating;
});
    return (
        <div className="bookCase">
            <h4>Featured books</h4>
            <div className="bookCaseGrid">
            {errorMessage && <p className="error">{errorMessage}</p>}
            {filteredBooks.length === 0 && !errorMessage && <p>No books available.</p>}
            {filteredBooks.map((book) => (
                <Book
                    key={book.book_id}
                    title={book.title}
                    author={book.author}
                    isbn={book.isbn}
                    description={book.description}
                    year={book.year}
                    setPage={setPage}
                />
            ))}
            </div>
        </div>
    )
}

export default BookCase;