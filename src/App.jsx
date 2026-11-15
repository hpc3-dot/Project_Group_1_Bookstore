import { useState } from 'react'
import Header from './components/Header'
import './App.css'
import SearchBox from './components/SearchBox'
import Footer from './components/Footer'
import BookCase from './components/BookCase'
import Details from './components/BookDetails'

function App() {
  const [currentPage, setPage] = useState('home');
  const [selectedBook, setSelectedBook] = useState(null);
  const [searchValues, setSearchValues] = useState({searchText: '', genre: '', rating: ''});

  return (
    
    <div className="App">
      <Header />
      <div className="container">
        
        {currentPage === 'home' && (
          <>
            <SearchBox searchValues={searchValues} setSearchValues={setSearchValues} />
            <BookCase setPage={(page, book) => { setSelectedBook(book); setPage(page); }} searchValues={searchValues} />
          </>
        )}
        {currentPage === 'details' &&  <Details setPage={setPage} selectedBook={selectedBook} />}

         
      </div>  
      <Footer />
    </div>
  )
}


export default App;
