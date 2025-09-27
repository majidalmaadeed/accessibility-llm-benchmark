import React, { useState } from 'react';

const InteractiveMap = () => {
  const [selectedLocation, setSelectedLocation] = useState(null);
  const [mapLayers, setMapLayers] = useState({
    satellite: false,
    traffic: false,
    weather: false,
    points: true
  });
  const [searchLocation, setSearchLocation] = useState('');
  const [mapCenter, setMapCenter] = useState({ lat: 40.7128, lng: -74.0060 });
  const [zoomLevel, setZoomLevel] = useState(10);
  const [markers, setMarkers] = useState([
    { id: 1, lat: 40.7589, lng: -73.9851, title: 'Central Park', type: 'park', description: 'Large public park in Manhattan' },
    { id: 2, lat: 40.7505, lng: -73.9934, title: 'Times Square', type: 'landmark', description: 'Famous commercial intersection' },
    { id: 3, lat: 40.6892, lng: -74.0445, title: 'Statue of Liberty', type: 'monument', description: 'Iconic symbol of freedom' },
    { id: 4, lat: 40.7614, lng: -73.9776, title: 'Museum of Modern Art', type: 'museum', description: 'World-renowned art museum' },
    { id: 5, lat: 40.7505, lng: -73.9934, title: 'Broadway Theater', type: 'entertainment', description: 'Historic theater district' }
  ]);
  const [routes, setRoutes] = useState([]);
  const [showRouteModal, setShowRouteModal] = useState(false);
  const [routeStart, setRouteStart] = useState('');
  const [routeEnd, setRouteEnd] = useState('');

  const handleMapClick = (lat, lng) => {
    setSelectedLocation({ lat, lng });
  };

  const handleMarkerClick = (marker) => {
    setSelectedLocation(marker);
  };

  const toggleLayer = (layer) => {
    setMapLayers(prev => ({
      ...prev,
      [layer]: !prev[layer]
    }));
  };

  const searchForLocation = () => {
    if (searchLocation) {
      // Simulate geocoding
      const mockResults = [
        { lat: 40.7128, lng: -74.0060, title: 'New York City' },
        { lat: 40.7589, lng: -73.9851, title: 'Central Park, New York' },
        { lat: 40.7505, lng: -73.9934, title: 'Times Square, New York' }
      ];
      
      const result = mockResults.find(r => 
        r.title.toLowerCase().includes(searchLocation.toLowerCase())
      );
      
      if (result) {
        setMapCenter(result);
        setSelectedLocation(result);
      } else {
        alert('Location not found');
      }
    }
  };

  const addMarker = () => {
    if (selectedLocation && !selectedLocation.id) {
      const newMarker = {
        id: Date.now(),
        lat: selectedLocation.lat,
        lng: selectedLocation.lng,
        title: `Marker ${markers.length + 1}`,
        type: 'custom',
        description: 'Custom marker'
      };
      setMarkers([...markers, newMarker]);
    }
  };

  const removeMarker = (markerId) => {
    setMarkers(markers.filter(m => m.id !== markerId));
  };

  const calculateRoute = () => {
    if (routeStart && routeEnd) {
      const startMarker = markers.find(m => m.title.toLowerCase().includes(routeStart.toLowerCase()));
      const endMarker = markers.find(m => m.title.toLowerCase().includes(routeEnd.toLowerCase()));
      
      if (startMarker && endMarker) {
        const newRoute = {
          id: Date.now(),
          start: startMarker,
          end: endMarker,
          distance: Math.random() * 10 + 1, // Mock distance
          duration: Math.random() * 30 + 5 // Mock duration
        };
        setRoutes([...routes, newRoute]);
        setShowRouteModal(false);
        setRouteStart('');
        setRouteEnd('');
      } else {
        alert('Please select valid start and end points');
      }
    }
  };

  const clearRoutes = () => {
    setRoutes([]);
  };

  const exportMapData = () => {
    const data = {
      center: mapCenter,
      zoom: zoomLevel,
      markers: markers,
      routes: routes,
      layers: mapLayers
    };
    
    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'map-data.json';
    a.click();
    window.URL.revokeObjectURL(url);
  };

  const getMarkerIcon = (type) => {
    const icons = {
      park: '🌳',
      landmark: '🏛️',
      monument: '🗽',
      museum: '🏛️',
      entertainment: '🎭',
      custom: '📍'
    };
    return icons[type] || '📍';
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Interactive Map</h1>
        <p className="page-subtitle">
          Interactive map with markers and layers
        </p>
      </div>

      <div className="card">
        <div style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }}>
          <div style={{ flex: 1 }}>
            <input
              type="text"
              className="form-control"
              placeholder="Search for a location..."
              value={searchLocation}
              onChange={(e) => setSearchLocation(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && searchForLocation()}
            />
          </div>
          <button className="btn" onClick={searchForLocation}>
            Search
          </button>
          <button className="btn btn-secondary" onClick={addMarker}>
            Add Marker
          </button>
          <button className="btn btn-secondary" onClick={() => setShowRouteModal(true)}>
            Plan Route
          </button>
          <button className="btn btn-secondary" onClick={exportMapData}>
            Export
          </button>
        </div>

        <div className="map-controls">
          <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
            <label>
              <input
                type="checkbox"
                checked={mapLayers.satellite}
                onChange={() => toggleLayer('satellite')}
              />
              Satellite View
            </label>
            <label>
              <input
                type="checkbox"
                checked={mapLayers.traffic}
                onChange={() => toggleLayer('traffic')}
              />
              Traffic
            </label>
            <label>
              <input
                type="checkbox"
                checked={mapLayers.weather}
                onChange={() => toggleLayer('weather')}
              />
              Weather
            </label>
            <label>
              <input
                type="checkbox"
                checked={mapLayers.points}
                onChange={() => toggleLayer('points')}
              />
              Points of Interest
            </label>
          </div>
        </div>
      </div>

      <div className="grid grid-2">
        <div className="card">
          <h2>Map</h2>
          <div className="map-container">
            <div style={{ 
              height: '400px', 
              background: 'linear-gradient(45deg, #e3f2fd 25%, #f5f5f5 25%, #f5f5f5 50%, #e3f2fd 50%, #e3f2fd 75%, #f5f5f5 75%)',
              backgroundSize: '20px 20px',
              position: 'relative',
              borderRadius: '8px',
              border: '1px solid #ddd',
              cursor: 'crosshair'
            }}>
              <div style={{ 
                position: 'absolute', 
                top: '50%', 
                left: '50%', 
                transform: 'translate(-50%, -50%)',
                color: '#666',
                textAlign: 'center'
              }}>
                <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>🗺️</div>
                <div>Interactive Map</div>
                <div style={{ fontSize: '0.9rem', marginTop: '0.5rem' }}>
                  Click to add markers, drag to pan
                </div>
              </div>
              
              {mapLayers.points && markers.map(marker => (
                <div
                  key={marker.id}
                  style={{
                    position: 'absolute',
                    left: `${50 + (marker.lng - mapCenter.lng) * 100}%`,
                    top: `${50 - (marker.lat - mapCenter.lat) * 100}%`,
                    fontSize: '1.5rem',
                    cursor: 'pointer',
                    zIndex: 10
                  }}
                  onClick={() => handleMarkerClick(marker)}
                  title={marker.title}
                >
                  {getMarkerIcon(marker.type)}
                </div>
              ))}
              
              {routes.map(route => (
                <div
                  key={route.id}
                  style={{
                    position: 'absolute',
                    left: '50%',
                    top: '50%',
                    width: '2px',
                    height: '100px',
                    background: '#007bff',
                    transform: 'translate(-50%, -50%) rotate(45deg)',
                    zIndex: 5
                  }}
                />
              ))}
            </div>
            
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '1rem' }}>
              <div style={{ display: 'flex', gap: '0.5rem' }}>
                <button 
                  className="btn btn-secondary"
                  onClick={() => setZoomLevel(Math.max(1, zoomLevel - 1))}
                >
                  -
                </button>
                <span style={{ padding: '0.5rem 1rem', background: '#f8f9fa', borderRadius: '4px' }}>
                  Zoom: {zoomLevel}
                </span>
                <button 
                  className="btn btn-secondary"
                  onClick={() => setZoomLevel(Math.min(20, zoomLevel + 1))}
                >
                  +
                </button>
              </div>
              <div style={{ fontSize: '0.9rem', color: '#666' }}>
                Center: {mapCenter.lat.toFixed(4)}, {mapCenter.lng.toFixed(4)}
              </div>
            </div>
          </div>
        </div>

        <div className="card">
          <h2>Markers & Routes</h2>
          <div style={{ maxHeight: '400px', overflowY: 'auto' }}>
            <div style={{ marginBottom: '1rem' }}>
              <h3 style={{ fontSize: '1.1rem', marginBottom: '0.5rem' }}>Markers ({markers.length})</h3>
              {markers.map(marker => (
                <div key={marker.id} style={{ 
                  display: 'flex', 
                  justifyContent: 'space-between', 
                  alignItems: 'center',
                  padding: '0.5rem',
                  borderBottom: '1px solid #eee'
                }}>
                  <div>
                    <div style={{ fontWeight: '600' }}>
                      {getMarkerIcon(marker.type)} {marker.title}
                    </div>
                    <div style={{ fontSize: '0.9rem', color: '#666' }}>
                      {marker.lat.toFixed(4)}, {marker.lng.toFixed(4)}
                    </div>
                  </div>
                  <button
                    className="btn btn-secondary"
                    onClick={() => removeMarker(marker.id)}
                    style={{ fontSize: '0.8rem', padding: '0.25rem 0.5rem' }}
                  >
                    Remove
                  </button>
                </div>
              ))}
            </div>
            
            <div>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}>
                <h3 style={{ fontSize: '1.1rem', margin: 0 }}>Routes ({routes.length})</h3>
                <button
                  className="btn btn-secondary"
                  onClick={clearRoutes}
                  style={{ fontSize: '0.8rem', padding: '0.25rem 0.5rem' }}
                >
                  Clear All
                </button>
              </div>
              {routes.map(route => (
                <div key={route.id} style={{ 
                  padding: '0.5rem',
                  borderBottom: '1px solid #eee',
                  fontSize: '0.9rem'
                }}>
                  <div style={{ fontWeight: '600' }}>
                    {route.start.title} → {route.end.title}
                  </div>
                  <div style={{ color: '#666' }}>
                    Distance: {route.distance.toFixed(1)} km | Duration: {route.duration.toFixed(0)} min
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {selectedLocation && (
        <div className="card">
          <h2>Location Details</h2>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
            <div>
              <h3 style={{ margin: '0 0 0.5rem 0' }}>
                {selectedLocation.title || 'Selected Location'}
              </h3>
              <p style={{ margin: '0 0 0.5rem 0', color: '#666' }}>
                {selectedLocation.description || 'No description available'}
              </p>
              <div style={{ fontSize: '0.9rem', color: '#666' }}>
                Coordinates: {selectedLocation.lat.toFixed(6)}, {selectedLocation.lng.toFixed(6)}
              </div>
            </div>
            <button
              className="btn btn-secondary"
              onClick={() => setSelectedLocation(null)}
            >
              Close
            </button>
          </div>
        </div>
      )}

      {showRouteModal && (
        <div className="modal">
          <div className="modal-content">
            <div className="modal-header">
              <h3 className="modal-title">Plan Route</h3>
              <button className="modal-close" onClick={() => setShowRouteModal(false)}>
                ×
              </button>
            </div>
            <div className="form-group">
              <label className="form-label">Start Point</label>
              <select
                className="form-control"
                value={routeStart}
                onChange={(e) => setRouteStart(e.target.value)}
              >
                <option value="">Select start point</option>
                {markers.map(marker => (
                  <option key={marker.id} value={marker.title}>
                    {marker.title}
                  </option>
                ))}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">End Point</label>
              <select
                className="form-control"
                value={routeEnd}
                onChange={(e) => setRouteEnd(e.target.value)}
              >
                <option value="">Select end point</option>
                {markers.map(marker => (
                  <option key={marker.id} value={marker.title}>
                    {marker.title}
                  </option>
                ))}
              </select>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowRouteModal(false)}>
                Cancel
              </button>
              <button className="btn" onClick={calculateRoute}>
                Calculate Route
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default InteractiveMap;
