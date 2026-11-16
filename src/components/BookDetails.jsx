


function Details({ setPage, selectedBook }) {
    const coverArt = `https://covers.openlibrary.org/b/isbn/${selectedBook.isbn}-L.jpg`;
    return (
        <>
        <div className="bookDetails">
            {selectedBook && (
                <>
                <div className="bookDetailsImg">
                    <img src={coverArt} alt={selectedBook.title} />
                </div>
                <div className="bookDetailsInfo">
                    <h4>{selectedBook.title}</h4>
                    <p><strong>Author:</strong> {selectedBook.author}</p>
                    <p><strong>Description:</strong> {selectedBook.description}</p>
                    <p><strong>Published:</strong> {selectedBook.year}</p>
                    <div className="bookDetailsRating">
                    <p><strong>Rating:Ratings and reviews are set for next rollout</strong> {selectedBook.rating}</p>
                    <h2>Reviews:</h2>
                    <h2>Add a Review:</h2>
                    { /*will add review functions in next phase */ }
                </div>
                </div>
                </>
            )}
        </div>
         
            <a href="#" className="navStyle" onClick={() => setPage('home')}>Back to Home</a>
        </>
    )
}

export default Details;