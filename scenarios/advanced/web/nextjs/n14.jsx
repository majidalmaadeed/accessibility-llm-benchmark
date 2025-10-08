'use client';

import { useState, useRef, useEffect } from 'react';
import styles from './InteractiveMap.module.css';

const InteractiveMap = () => {
  const mapRef = useRef(null);
  const [mapCenter, setMapCenter] = useState({ lat: 40.7128, lng: -74.0060 });
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
  const [filteredMarkers, setFilteredMarkers] = useState([]);
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
  const [mapStyle, setMapStyle] = useState('default');

  const mapStyles = [
    { id: 'default', name: 'Default', preview: '🗺️' },
    { id: 'satellite', name: 'Satellite', preview: '🛰️' },
    { id: 'terrain', name: 'Terrain', preview: '🏔️' }
  ];

  const markerTypes = {
    attraction: { color: '#4caf50', icon: '🎯' },
    park: { color: '#8bc34a', icon: '🌳' },
    monument: { color: '#ff9800', icon: '🏛️' },
    building: { color: '#2196f3', icon: '🏢' },
    entertainment: { color: '#9c27b0', icon: '🎭' }
  };

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
    const rect = mapRef.current?.getBoundingClientRect();
    if (!rect) return;

    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    
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
    const rect = mapRef.current?.getBoundingClientRect();
    if (!rect) return { x: 0, y: 0 };
    
    const x = rect.width / 2 + (marker.lng - mapCenter.lng) * (zoom * 10);
    const y = rect.height / 2 - (marker.lat - mapCenter.lat) * (zoom * 10);
    
    return { x, y };
  };

  const resetView = () => {
    setMapCenter({ lat: 40.7128, lng: -74.0060 });
  };

  const setDefaultZoom = () => {
    setZoom(10);
  };

  const clearSelection = () => {
    setShowInfoWindow(false);
  };

  const centerOnMarker = (marker) => {
    setMapCenter({ lat: marker.lat, lng: marker.lng });
  };

  const onSearchQueryChange = () => {
    if (searchQuery.length > 2) {
      const filteredSuggestions = markers.filter(marker =>
        marker.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        marker.description.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setSearchResults(filteredSuggestions.slice(0, 5));
      setShowSearchOverlay(true);
    } else {
      setShowSearchOverlay(false);
    }
  };

  const getMarkerColor = (marker) => {
    return markerTypes[marker.type]?.color || '#4caf50';
  };

  const getMarkerIcon = (marker) => {
    return markerTypes[marker.type]?.icon || '📍';
  };

  const getLayerName = (layer) => {
    return layer.charAt(0).toUpperCase() + layer.slice(1);
  };

  return (
    <div className={styles.interactiveMap}>
      <div className={styles.mapHeader}>
        <h1>Interactive Map</h1>
        <div className={styles.mapControls}>
          <div className={styles.searchContainer}>
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => {
                setSearchQuery(e.target.value);
                onSearchQueryChange();
              }}
              placeholder="Search locations..."
              className={styles.searchInput}
            />
            <button onClick={handleSearch} className={styles.searchBtn}>🔍</button>
          </div>
          
          <div className={styles.mapStyleSelector}>
            <select 
              value={mapStyle}
              onChange={(e) => setMapStyle(e.target.value)}
              className={styles.styleSelect}
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

      <div className={styles.mapContainer}>
        <div className={styles.mapSidebar}>
          <div className={styles.sidebarSection}>
            <h3>Map Layers</h3>
            <button 
              onClick={() => setShowLayers(!showLayers)}
              className={styles.layersToggle}
            >
              {showLayers ? 'Hide' : 'Show'} Layers
            </button>
            
            {showLayers && (
              <div className={styles.layersPanel}>
                {Object.entries(activeLayers).map(([layer, active]) => (
                  <label key={layer} className={styles.layerItem}>
                    <input
                      type="checkbox"
                      checked={active}
                      onChange={() => handleLayerToggle(layer)}
                    />
                    <span className={styles.layerName}>
                      {getLayerName(layer)}
                    </span>
                  </label>
                ))}
              </div>
            )}
          </div>

          <div className={styles.sidebarSection}>
            <h3>Quick Actions</h3>
            <div className={styles.quickActions}>
              <button onClick={resetView} className={styles.actionBtn}>Reset View</button>
              <button onClick={setDefaultZoom} className={styles.actionBtn}>Default Zoom</button>
              <button onClick={clearSelection} className={styles.actionBtn}>Clear Selection</button>
            </div>
          </div>

          <div className={styles.sidebarSection}>
            <h3>Map Info</h3>
            <div className={styles.mapInfo}>
              <div className={styles.infoItem}>
                <span>Center:</span>
                <span>{mapCenter.lat.toFixed(4)}, {mapCenter.lng.toFixed(4)}</span>
              </div>
              <div className={styles.infoItem}>
                <span>Zoom:</span>
                <span>{zoom}</span>
              </div>
              <div className={styles.infoItem}>
                <span>Markers:</span>
                <span>{filteredMarkers.length}</span>
              </div>
            </div>
          </div>
        </div>

        <div className={styles.mapMain}>
          <div 
            ref={mapRef}
            className={styles.mapDisplay}
            onClick={handleMapClick}
            onDoubleClick={addCustomMarker}
          >
            <div 
              className={styles.mapBackground} 
              style={{
                backgroundImage: 'url(\'https://via.placeholder.com/800x600/4caf50/fff?text=Map+View\')',
                transform: `scale(${zoom / 10})`
              }}
            >
              {filteredMarkers.map((marker) => {
                const position = getMarkerPosition(marker);
                return (
                  <div
                    key={marker.id}
                    className={styles.mapMarker}
                    style={{
                      left: position.x,
                      top: position.y,
                      backgroundColor: getMarkerColor(marker)
                    }}
                    onClick={(e) => {
                      handleMarkerClick(marker);
                      e.stopPropagation();
                    }}
                    title={marker.title}
                  >
                    <span className={styles.markerIcon}>{getMarkerIcon(marker)}</span>
                  </div>
                );
              })}
            </div>

            <div className={styles.zoomControls}>
              <button onClick={handleZoomIn} className={styles.zoomBtn}>+</button>
              <button onClick={handleZoomOut} className={styles.zoomBtn}>−</button>
            </div>

            {showInfoWindow && selectedMarker && (
              <div className={styles.infoWindow}>
                <div className={styles.infoHeader}>
                  <h4>{selectedMarker.title}</h4>
                  <button 
                    onClick={() => setShowInfoWindow(false)} 
                    className={styles.closeBtn}
                  >
                    ✕
                  </button>
                </div>
                <div className={styles.infoContent}>
                  <div className={styles.infoType}>Type: {selectedMarker.type}</div>
                  <div className={styles.infoDescription}>{selectedMarker.description}</div>
                  <div className={styles.infoCoordinates}>
                    {selectedMarker.lat.toFixed(4)}, {selectedMarker.lng.toFixed(4)}
                  </div>
                </div>
                <div className={styles.infoActions}>
                  <button onClick={() => removeMarker(selectedMarker.id)} className={styles.actionBtn}>
                    Remove
                  </button>
                  <button onClick={() => centerOnMarker(selectedMarker)} className={styles.actionBtn}>
                    Center
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {showSearchOverlay && (
        <div className={styles.searchOverlay}>
          <div className={styles.searchResults}>
            <div className={styles.searchHeader}>
              <h3>Search Results</h3>
              <button 
                onClick={() => setShowSearchOverlay(false)} 
                className={styles.closeBtn}
              >
                ✕
              </button>
            </div>
            
            {isSearching ? (
              <div className={styles.searchLoading}>
                <div className={styles.loadingSpinner}></div>
                <span>Searching...</span>
              </div>
            ) : (
              <div className={styles.searchResultsList}>
                {searchResults.length > 0 ? (
                  searchResults.map((result) => (
                    <div
                      key={result.id}
                      className={styles.searchResultItem}
                      onClick={() => handleSearchResultClick(result)}
                    >
                      <div className={styles.resultTitle}>{result.title}</div>
                      <div className={styles.resultDescription}>{result.description}</div>
                      <div className={styles.resultType}>{result.type}</div>
                    </div>
                  ))
                ) : (
                  <div className={styles.noResults}>
                    No results found for "{searchQuery}"
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      <div className={styles.mapFooter}>
        <div className={styles.mapInstructions}>
          <span>Click markers to view details • Double-click map to add marker • Use zoom controls to navigate</span>
        </div>
        <div className={styles.mapLegend}>
          {Object.entries(markerTypes).map(([type, config]) => (
            <div key={type} className={styles.legendItem}>
              <div 
                className={styles.legendColor} 
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
