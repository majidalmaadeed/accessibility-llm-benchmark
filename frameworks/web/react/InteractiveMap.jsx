import React, { useState, useRef, useEffect } from 'react';
import './InteractiveMap.css';

const InteractiveMap = () => {
  const mapRef = useRef(null);
  const [mapCenter, setMapCenter] = useState({ lat: 40.7128, lng: -74.0060 }); // New York City
  const [zoom, setZoom] = useState(10);
  const [markers, setMarkers] = useState([
    {
      id: 1,
      lat: 40.7589,
      lng: -73.9851,
      title: 'Times Square',
      type: 'attraction',
      description: 'Famous commercial intersection and tourist destination'
    },
    {
      id: 2,
      lat: 40.7829,
      lng: -73.9654,
      title: 'Central Park',
      type: 'park',
      description: 'Large public park in Manhattan'
    },
    {
      id: 3,
      lat: 40.6892,
      lng: -74.0445,
      title: 'Statue of Liberty',
      type: 'monument',
      description: 'Iconic symbol of freedom and democracy'
    },
    {
      id: 4,
      lat: 40.7505,
      lng: -73.9934,
      title: 'Empire State Building',
      type: 'building',
      description: 'Famous Art Deco skyscraper'
    },
    {
      id: 5,
      lat: 40.7614,
      lng: -73.9776,
      title: 'Broadway Theater',
      type: 'entertainment',
      description: 'Historic theater district'
    }
  ]);

  const [selectedMarker, setSelectedMarker] = useState(null);
  const [showInfoWindow, setShowInfoWindow] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [filteredMarkers, setFilteredMarkers] = useState(markers);
  const [showLayers, setShowLayers] = useState(false);
  const [activeLayers, setActiveLayers] = useState({
    attractions: true,
    parks: true,
    monuments: true,
    buildings: true,
    entertainment: true,
    traffic: false,
    weather: false
  });
  const [showSearchOverlay, setShowSearchOverlay] = useState(false);
  const [searchResults, setSearchResults] = useState([]);
  const [isSearching, setIsSearching] = useState(false);
  const [mapStyle, setMapStyle] = useState('default'); // default, satellite, terrain

  const markerTypes = {
    attraction: { color: '#4caf50', icon: '🎯' },
    park: { color: '#8bc34a', icon: '🌳' },
    monument: { color: '#ff9800', icon: '🏛️' },
    building: { color: '#2196f3', icon: '🏢' },
    entertainment: { color: '#9c27b0', icon: '🎭' }
  };

  const mapStyles = [
    { id: 'default', name: 'Default', preview: '🗺️' },
    { id: 'satellite', name: 'Satellite', preview: '🛰️' },
    { id: 'terrain', name: 'Terrain', preview: '🏔️' }
  ];

  useEffect(() => {
    filterMarkers();
  }, [activeLayers, markers]);

  const filterMarkers = () => {
    const filtered = markers.filter(marker => {
      const layerKey = marker.type === 'attraction' ? 'attractions' : 
                      marker.type === 'park' ? 'parks' :
                      marker.type === 'monument' ? 'monuments' :
                      marker.type === 'building' ? 'buildings' :
                      marker.type === 'entertainment' ? 'entertainment' : marker.type;
      return activeLayers[layerKey];
    });
    setFilteredMarkers(filtered);
  };

  const handleMarkerClick = (marker) => {
    setSelectedMarker(marker);
    setShowInfoWindow(true);
    setMapCenter({ lat: marker.lat, lng: marker.lng });
    setZoom(15);
  };

  const handleMapClick = (event) => {
    if (event.target === mapRef.current) {
      setShowInfoWindow(false);
      setSelectedMarker(null);
    }
  };

  const handleZoomIn = () => {
    setZoom(prev => Math.min(prev + 1, 20));
  };

  const handleZoomOut = () => {
    setZoom(prev => Math.max(prev - 1, 1));
  };

  const handleLayerToggle = (layer) => {
    setActiveLayers(prev => ({
      ...prev,
      [layer]: !prev[layer]
    }));
  };

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;

    setIsSearching(true);
    setShowSearchOverlay(true);

    // Simulate API search
    setTimeout(() => {
      const results = markers.filter(marker =>
        marker.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        marker.description.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setSearchResults(results);
      setIsSearching(false);
    }, 1000);
  };

  const handleSearchResultClick = (result) => {
    setMapCenter({ lat: result.lat, lng: result.lng });
    setZoom(15);
    setShowSearchOverlay(false);
    setSearchQuery('');
    setSearchResults([]);
  };

  const addCustomMarker = (event) => {
    const rect = mapRef.current.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    
    // Convert screen coordinates to lat/lng (simplified)
    const lat = mapCenter.lat + (rect.height / 2 - y) * (0.01 / zoom);
    const lng = mapCenter.lng + (x - rect.width / 2) * (0.01 / zoom);
    
    const newMarker = {
      id: Date.now(),
      lat,
      lng,
      title: 'Custom Location',
      type: 'attraction',
      description: 'User-added marker'
    };
    
    setMarkers(prev => [...prev, newMarker]);
  };

  const removeMarker = (markerId) => {
    setMarkers(prev => prev.filter(marker => marker.id !== markerId));
    if (selectedMarker && selectedMarker.id === markerId) {
      setShowInfoWindow(false);
      setSelectedMarker(null);
    }
  };

  const getMarkerPosition = (marker) => {
    // Convert lat/lng to screen coordinates (simplified)
    const rect = mapRef.current?.getBoundingClientRect();
    if (!rect) return { x: 0, y: 0 };
    
    const x = rect.width / 2 + (marker.lng - mapCenter.lng) * (zoom * 10);
    const y = rect.height / 2 - (marker.lat - mapCenter.lat) * (zoom * 10);
    
    return { x, y };
  };

  return (
    <div className="interactive-map">
      <div className="map-header">
        <h1>Interactive Map</h1>
        <div className="map-controls">
          <div className="search-container">
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search locations..."
              className="search-input"
            />
            <button onClick={handleSearch} className="search-btn">
              🔍
            </button>
          </div>
          
          <div className="map-style-selector">
            <select
              value={mapStyle}
              onChange={(e) => setMapStyle(e.target.value)}
            >
              {mapStyles.map(style => (
                <option key={style.id} value={style.id}>
                  {style.preview} {style.name}
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>

      <div className="map-container">
        <div className="map-sidebar">
          <div className="sidebar-section">
            <h3>Map Layers</h3>
            <button 
              onClick={() => setShowLayers(!showLayers)}
              className="layers-toggle"
            >
              {showLayers ? 'Hide' : 'Show'} Layers
            </button>
            
            {showLayers && (
              <div className="layers-panel">
                {Object.entries(activeLayers).map(([layer, active]) => (
                  <label key={layer} className="layer-item">
                    <input
                      type="checkbox"
                      checked={active}
                      onChange={() => handleLayerToggle(layer)}
                    />
                    <span className="layer-name">
                      {layer.charAt(0).toUpperCase() + layer.slice(1)}
                    </span>
                  </label>
                ))}
              </div>
            )}
          </div>

          <div className="sidebar-section">
            <h3>Quick Actions</h3>
            <div className="quick-actions">
              <button onClick={() => setMapCenter({ lat: 40.7128, lng: -74.0060 })}>
                Reset View
              </button>
              <button onClick={() => setZoom(10)}>
                Default Zoom
              </button>
              <button onClick={() => setShowInfoWindow(false)}>
                Clear Selection
              </button>
            </div>
          </div>

          <div className="sidebar-section">
            <h3>Map Info</h3>
            <div className="map-info">
              <div className="info-item">
                <span>Center:</span>
                <span>{mapCenter.lat.toFixed(4)}, {mapCenter.lng.toFixed(4)}</span>
              </div>
              <div className="info-item">
                <span>Zoom:</span>
                <span>{zoom}</span>
              </div>
              <div className="info-item">
                <span>Markers:</span>
                <span>{filteredMarkers.length}</span>
              </div>
            </div>
          </div>
        </div>

        <div className="map-main">
          <div 
            ref={mapRef}
            className="map-display"
            onClick={handleMapClick}
            onDoubleClick={addCustomMarker}
          >
            {/* Map background simulation */}
            <div className="map-background" style={{ 
              backgroundImage: `url('https://via.placeholder.com/800x600/4caf50/fff?text=Map+View')`,
              transform: `scale(${zoom / 10})`
            }}>
              {/* Render markers */}
              {filteredMarkers.map(marker => {
                const position = getMarkerPosition(marker);
                const markerType = markerTypes[marker.type];
                
                return (
                  <div
                    key={marker.id}
                    className="map-marker"
                    style={{
                      left: `${position.x}px`,
                      top: `${position.y}px`,
                      backgroundColor: markerType.color
                    }}
                    onClick={(e) => {
                      e.stopPropagation();
                      handleMarkerClick(marker);
                    }}
                    title={marker.title}
                  >
                    <span className="marker-icon">{markerType.icon}</span>
                  </div>
                );
              })}
            </div>

            {/* Zoom controls */}
            <div className="zoom-controls">
              <button onClick={handleZoomIn} className="zoom-btn">
                +
              </button>
              <button onClick={handleZoomOut} className="zoom-btn">
                −
              </button>
            </div>

            {/* Info window */}
            {showInfoWindow && selectedMarker && (
              <div className="info-window">
                <div className="info-header">
                  <h4>{selectedMarker.title}</h4>
                  <button 
                    onClick={() => setShowInfoWindow(false)}
                    className="close-btn"
                  >
                    ✕
                  </button>
                </div>
                <div className="info-content">
                  <div className="info-type">
                    Type: {selectedMarker.type}
                  </div>
                  <div className="info-description">
                    {selectedMarker.description}
                  </div>
                  <div className="info-coordinates">
                    {selectedMarker.lat.toFixed(4)}, {selectedMarker.lng.toFixed(4)}
                  </div>
                </div>
                <div className="info-actions">
                  <button onClick={() => removeMarker(selectedMarker.id)}>
                    Remove
                  </button>
                  <button onClick={() => setMapCenter({ lat: selectedMarker.lat, lng: selectedMarker.lng })}>
                    Center
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Search overlay */}
      {showSearchOverlay && (
        <div className="search-overlay">
          <div className="search-results">
            <div className="search-header">
              <h3>Search Results</h3>
              <button 
                onClick={() => setShowSearchOverlay(false)}
                className="close-btn"
              >
                ✕
              </button>
            </div>
            
            {isSearching ? (
              <div className="search-loading">
                <div className="loading-spinner"></div>
                <span>Searching...</span>
              </div>
            ) : (
              <div className="search-results-list">
                {searchResults.length > 0 ? (
                  searchResults.map(result => (
                    <div
                      key={result.id}
                      className="search-result-item"
                      onClick={() => handleSearchResultClick(result)}
                    >
                      <div className="result-title">{result.title}</div>
                      <div className="result-description">{result.description}</div>
                      <div className="result-type">{result.type}</div>
                    </div>
                  ))
                ) : (
                  <div className="no-results">
                    No results found for "{searchQuery}"
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      <div className="map-footer">
        <div className="map-instructions">
          <span>Click markers to view details • Double-click map to add marker • Use zoom controls to navigate</span>
        </div>
        <div className="map-legend">
          {Object.entries(markerTypes).map(([type, config]) => (
            <div key={type} className="legend-item">
              <div 
                className="legend-color" 
                style={{ backgroundColor: config.color }}
              >
                {config.icon}
              </div>
              <span>{type}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default InteractiveMap;
