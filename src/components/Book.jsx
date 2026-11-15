

function Book({setPage, ...props}) {
    const coverArt = `https://covers.openlibrary.org/b/isbn/${props.isbn}-L.jpg`
    return (
        <div className="book">
            <img className="bookCover" src={props.cover_art} alt={props.title} /> 
            <div className="bookInfo">
                <p>Rating:</p>
                <a href="#" onClick={(e) => {e.preventDefault();setPage('details', props)}} className="navStyle">View More</a>
                {/* This book card has the title. */}
            </div>
        </div>
    )
}

export default Book;