

function Book({setPage, ...props}) {
    return (
        <div className="book">
            <h5>{props.title}</h5>
            <div className="bookInfo">
                <img src={props.cover_art} alt={props.title} /> 
                <p>{props.author}</p>
                <p>Rating:</p>
                <a href="#" onClick={(e) => {e.preventDefault();setPage('details')}} className="navStyle">View More</a>
            
            </div>
        </div>
    )
}

export default Book;