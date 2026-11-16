import {useState, useEffect} from 'react';


function SearchBox({ searchValues, setSearchValues }) {
  const [filtersVisible, setFiltersVisible] = useState(false);
  const [genres, setGenres] = useState([]);

  useEffect(() => {
      
    //Fetch genre list from api
     async function fetchGenres() {
        try {
          const response = await fetch('/api/genres');
          const data = await response.json();
          setGenres(data.genres);
        } catch (error) {
          console.error('Error fetching genres:', error);
        }
      }
    fetchGenres();
  }, []);
  function displayFilters() {
    if (filtersVisible) {
      setFiltersVisible(false);
    } else  
    setFiltersVisible(true);
  }
  return(
    <div className="searchBox">
      <input type="text" placeholder="Search for a book..." value={searchValues.searchText}  onChange={(e) =>setSearchValues({...searchValues,searchText: e.target.value})}/>
      <a href="#" className="navStyle" onClick={(e) => {e.preventDefault();displayFilters(e)}}>Filters</a>
        {filtersVisible && (
          <div className="filters">
          <select value={searchValues.genre}onChange={(e) =>setSearchValues({...searchValues, genre: e.target.value}) }>
            <option value="">Select a genre</option>
                {genres.map((genre) => ( <option key={genre.genre_id} value={genre.genre_name}> {genre.genre_name} </option>))} 
          </select>
          <select>
            <option value="">Rating</option>
            <option value="5">5 Stars</option>
            <option value="4">4 Stars</option>
            <option value="3">3 Stars</option>
            <option value="2">2 Stars</option>
            <option value="1">1 Star</option>
          </select>
        </div>
        )}
    </div>
  )
}
  
export default SearchBox;