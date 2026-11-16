

function Book({setPage, ...props}) {
    const coverArt = `https://covers.openlibrary.org/b/isbn/${props.isbn}-L.jpg`
    return (
        <div className="book">
           
            <img className="bookCover" src={coverArt} alt={props.title} /> 
            <div className="bookInfo">
                <h4>{props.title}</h4>
                <p><strong>Author:</strong> {props.author}</p>
                {/* <p>Rating:</p> */}
                <a href="#" onClick={(e) => {e.preventDefault();setPage('details', props)}} className="navStyle">View More</a>
                {/* This book card has the title. */}
            </div>
        </div>
    )
}

export default Book;