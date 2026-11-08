import {useState} from 'react';


function SearchBox() {
  const [searchText, setSearchText] = useState('');
  const [filtersVisible, setFiltersVisible] = useState(false);
  function handleSearch(e) {
    setSearchText(e.target.value);
  }

  function displayFilters() {
    if (filtersVisible) {
      setFiltersVisible(false);
    } else  
    setFiltersVisible(true);
  }
  return(
    <div className="searchBox">
      <input 
        type="text" 
        placeholder="Search for a book..." 
        value={searchText} 
        onChange={handleSearch}
      />
      <a href="#" className="navStyle" onClick={(e) => {e.preventDefault();handleSearch(searchText)}}>Search</a>
      <a href="#" className="navStyle" onClick={(e) => {e.preventDefault();displayFilters(e)}}>Filters</a>
      {filtersVisible && (
        <div className="filters">
          <select>
            <option value="">Genre</option>
            <option value="author">Author</option>
            <option value="title">Title</option>
          </select>
        </div>)}
    </div>
  )
}
  
export default SearchBox;