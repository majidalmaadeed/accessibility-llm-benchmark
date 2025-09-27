import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import './App.css';
import Home from './components/Home';
import DataTable from './components/DataTable';
import Wizard from './components/Wizard';
import Dashboard from './components/Dashboard';
import MediaPlayer from './components/MediaPlayer';
import ShoppingCart from './components/ShoppingCart';
import Calendar from './components/Calendar';
import RichTextEditor from './components/RichTextEditor';
import SearchInterface from './components/SearchInterface';
import InteractiveMap from './components/InteractiveMap';
import SocialFeed from './components/SocialFeed';

function App() {
  return (
    <Router>
      <div className="App">
        <nav className="navbar">
          <div className="container">
            <Link to="/" className="navbar-brand">
              Accessibility Benchmark - React
            </Link>
            <div className="navbar-nav">
              <Link to="/" className="nav-link">Home</Link>
              <Link to="/data-table" className="nav-link">Data Table</Link>
              <Link to="/wizard" className="nav-link">Wizard</Link>
              <Link to="/dashboard" className="nav-link">Dashboard</Link>
              <Link to="/media-player" className="nav-link">Media Player</Link>
              <Link to="/shopping-cart" className="nav-link">Shopping Cart</Link>
              <Link to="/calendar" className="nav-link">Calendar</Link>
              <Link to="/rich-text-editor" className="nav-link">Rich Text Editor</Link>
              <Link to="/search-interface" className="nav-link">Search Interface</Link>
              <Link to="/interactive-map" className="nav-link">Interactive Map</Link>
              <Link to="/social-feed" className="nav-link">Social Feed</Link>
            </div>
          </div>
        </nav>

        <main className="main-content">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/data-table" element={<DataTable />} />
            <Route path="/wizard" element={<Wizard />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/media-player" element={<MediaPlayer />} />
            <Route path="/shopping-cart" element={<ShoppingCart />} />
            <Route path="/calendar" element={<Calendar />} />
            <Route path="/rich-text-editor" element={<RichTextEditor />} />
            <Route path="/search-interface" element={<SearchInterface />} />
            <Route path="/interactive-map" element={<InteractiveMap />} />
            <Route path="/social-feed" element={<SocialFeed />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;
