CREATE TABLE authors (
    author_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    author_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE genres (
    genre_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,
    published_year INTEGER NOT NULL,
    description TEXT NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,

    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id),

    CONSTRAINT chk_published_year
        CHECK (published_year BETWEEN 1000 AND 2100)
);

CREATE TABLE book_genres (
    book_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, genre_id),

    CONSTRAINT fk_book_genres_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_book_genres_genre
        FOREIGN KEY (genre_id)
        REFERENCES genres(genre_id)
);