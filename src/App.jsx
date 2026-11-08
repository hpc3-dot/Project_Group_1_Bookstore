import { useState } from 'react'
import Header from './components/Header'
import './App.css'
import SearchBox from './components/SearchBox'
import Footer from './components/Footer'
import BookCase from './components/BookCase'

function App() {
  const [currentPage, setPage, ] = useState('home');
  return (
    
    <div className="App">
      <Header />
      <div className="container">
        <SearchBox />
        <BookCase currentPage={setPage} />
      </div>
      <Footer />
    </div>
  )
}


export default App
