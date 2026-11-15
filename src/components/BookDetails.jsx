


function Details({ setPage, selectedBook }) {
    return (
        <div className="bookDetails">
            <h1>Book Details</h1>
            {selectedBook && (
                <>
                <div className="bookDetailsImg">
                    <img src={selectedBook.cover_art} alt={selectedBook.title} />
                </div>
                <div className="bookDetailsInfo">
                    <p><strong>Title:</strong> {selectedBook.title}</p>
                    <p><strong>Author:</strong> {selectedBook.author}</p>
                    <p><strong>Description:</strong> {selectedBook.description}</p>
                    <p><strong>Year:</strong> {selectedBook.year}</p>
                </div>
                </>
            )}
            <div className="bookDetailsRating">
                <p><strong>Rating:</strong> {selectedBook.rating}</p>
                <h2>Reviews:</h2>
                <h2>Add a Review:</h2>
                { /*will add review functions in next phase */ }
            </div>



            <a href="#" className="navStyle" onClick={() => setPage('home')}>Back to Home</a>
        </div>
    )
}

export default Details;