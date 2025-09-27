<script>
  export let data
  
  let mapData = null
  let selectedLocation = null
  let showInfoWindow = false
  let searchQuery = ''
  let selectedCategory = ''
  let selectedLayer = 'traffic'
  let showLayers = false
  let showLegend = false
  let currentZoom = 1
  let mapCenter = { x: 50, y: 50 }
  
  $: {
    if (data) {
      mapData = JSON.parse(data)
    }
  }
  
  function selectLocation(location) {
    selectedLocation = location
    showInfoWindow = true
  }
  
  function closeInfoWindow() {
    showInfoWindow = false
    selectedLocation = null
  }
  
  function handleSearch() {
    if (searchQuery) {
      const location = mapData?.locations.find(loc =>
        loc.name.toLowerCase().includes(searchQuery.toLowerCase())
      )
      if (location) {
        selectLocation(location)
      } else {
        alert('Location not found')
      }
    }
  }
  
  function toggleLayer(layer) {
    selectedLayer = layer
  }
  
  function getCurrentLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        position => {
          alert(`Current location: ${position.coords.latitude}, ${position.coords.longitude}`)
        },
        error => {
          alert('Unable to get current location')
        }
      )
    } else {
      alert('Geolocation is not supported')
    }
  }
  
  function showDirections() {
    if (selectedLocation) {
      alert(`Getting directions to ${selectedLocation.name}`)
    } else {
      alert('Please select a location first')
    }
  }
  
  function exportMap() {
    alert('Exporting map...')
  }
  
  function shareMap() {
    alert('Sharing map...')
  }
  
  function resetMap() {
    currentZoom = 1
    mapCenter = { x: 50, y: 50 }
    closeInfoWindow()
  }
  
  function toggleFullscreen() {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen()
    } else {
      document.exitFullscreen()
    }
  }
  
  function getCategoryColor(category) {
    const colors = {
      attraction: '#45b7d1',
      hotel: '#4ecdc4',
      restaurant: '#ff6b6b',
      shopping: '#96ceb4',
      transport: '#feca57'
    }
    return colors[category] || '#6c757d'
  }
</script>

<div class="map-container">
  <div class="map-header">
    <h1>Interactive Map</h1>
    <div class="map-controls">
      <button class="control-btn" on:click={toggleFullscreen}>⛶</button>
      <button class="control-btn" on:click={resetMap}>🏠</button>
      <button class="control-btn" on:click={shareMap}>📤</button>
    </div>
  </div>
  
  <div class="map-content">
    <div class="map-sidebar">
      <div class="sidebar-section">
        <h3>Search Location</h3>
        <div class="search-box">
          <input type="text" 
                 bind:value={searchQuery}
                 on:keyup={(e) => e.key === 'Enter' && handleSearch()}
                 placeholder="Search for places...">
          <button class="search-btn" on:click={handleSearch}>🔍</button>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Filter by Category</h3>
        <div class="filter-group">
          <label>Category</label>
          <select bind:value={selectedCategory}>
            <option value="">All Categories</option>
            <option value="attraction">Attractions</option>
            <option value="hotel">Hotels</option>
            <option value="restaurant">Restaurants</option>
            <option value="shopping">Shopping</option>
            <option value="transport">Transport</option>
          </select>
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Map Layers</h3>
        <div class="layer-controls">
          {#each mapData?.layers || [] as layer}
            <div class="layer-item" on:click={() => toggleLayer(layer)}>
              <input type="checkbox" checked={selectedLayer === layer}>
              <span class="layer-name">{layer}</span>
              <div class="layer-color" style="background: {getCategoryColor(layer)};"></div>
            </div>
          {/each}
        </div>
      </div>
      
      <div class="sidebar-section">
        <h3>Quick Actions</h3>
        <button class="control-btn" on:click={getCurrentLocation}>📍 My Location</button>
        <button class="control-btn" on:click={showDirections}>🗺️ Directions</button>
        <button class="control-btn" on:click={exportMap}>💾 Export Map</button>
      </div>
    </div>
    
    <div class="map-main">
      <div class="map-canvas">
        {#each mapData?.locations || [] as location}
          <div class="map-marker {location.category}" 
               style="left: {location.x}%; top: {location.y}%;"
               on:click={() => selectLocation(location)}>
          </div>
        {/each}
      </div>
      
      <div class="map-zoom-controls">
        <button class="zoom-btn" on:click={() => currentZoom = Math.min(currentZoom * 1.2, 3)}>+</button>
        <button class="zoom-btn" on:click={() => currentZoom = Math.max(currentZoom / 1.2, 0.5)}>-</button>
      </div>
      
      <div class="map-layers">
        <div class="layer-toggle">
          <input type="checkbox" id="showMarkers" checked>
          <label for="showMarkers">Show Markers</label>
        </div>
        <div class="layer-toggle">
          <input type="checkbox" id="showLabels" checked>
          <label for="showLabels">Show Labels</label>
        </div>
      </div>
      
      <div class="map-legend">
        <div class="legend-title">Legend</div>
        {#each mapData?.locations || [] as location}
          <div class="legend-item">
            <div class="legend-color" style="background: {getCategoryColor(location.category)};"></div>
            <span class="legend-text">{location.category}</span>
          </div>
        {/each}
      </div>
      
      <div class="map-coordinates">Lat: 40.7128, Lng: -74.0060</div>
    </div>
  </div>
</div>

{#if showInfoWindow && selectedLocation}
  <div class="info-window">
    <div class="info-window-content">
      <div class="info-window-header">
        <h3>{selectedLocation.name}</h3>
        <button class="close-btn" on:click={closeInfoWindow}>&times;</button>
      </div>
      <div class="info-window-body">
        <p><strong>Address:</strong> {selectedLocation.address}</p>
        <p><strong>Category:</strong> {selectedLocation.category}</p>
        <div class="info-actions">
          <button class="info-btn" on:click={showDirections}>Directions</button>
          <button class="info-btn primary" on:click={() => alert('View details')}>View Details</button>
        </div>
      </div>
    </div>
  </div>
{/if}

<style>
  .map-container {
    max-width: 1400px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .map-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .map-header h1 {
    margin: 0;
    font-size: 24px;
  }
  
  .map-controls {
    display: flex;
    gap: 10px;
  }
  
  .control-btn {
    padding: 8px 16px;
    background: rgba(255,255,255,0.2);
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
  }
  
  .control-btn:hover {
    background: rgba(255,255,255,0.3);
  }
  
  .map-content {
    display: flex;
    height: 600px;
  }
  
  .map-sidebar {
    width: 300px;
    background: #f8f9fa;
    border-right: 1px solid #e9ecef;
    padding: 20px;
    overflow-y: auto;
  }
  
  .sidebar-section {
    margin-bottom: 25px;
  }
  
  .sidebar-section h3 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 15px;
    color: #333;
  }
  
  .search-box {
    position: relative;
    margin-bottom: 20px;
  }
  
  .search-box input {
    width: 100%;
    padding: 10px 40px 10px 15px;
    border: 1px solid #ddd;
    border-radius: 25px;
    font-size: 14px;
    outline: none;
  }
  
  .search-box input:focus {
    border-color: #007bff;
  }
  
  .search-btn {
    position: absolute;
    right: 5px;
    top: 50%;
    transform: translateY(-50%);
    width: 30px;
    height: 30px;
    border: none;
    background: #007bff;
    color: white;
    border-radius: 50%;
    cursor: pointer;
    font-size: 12px;
  }
  
  .filter-group {
    margin-bottom: 20px;
  }
  
  .filter-group label {
    display: block;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: 600;
    color: #333;
  }
  
  .filter-group select {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
  
  .layer-controls {
    background: white;
    border: 1px solid #e9ecef;
    border-radius: 6px;
    padding: 15px;
  }
  
  .layer-item {
    display: flex;
    align-items: center;
    padding: 8px 0;
    cursor: pointer;
  }
  
  .layer-item input[type="checkbox"] {
    margin-right: 10px;
  }
  
  .layer-name {
    font-size: 14px;
    color: #333;
    flex: 1;
  }
  
  .layer-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-left: 10px;
  }
  
  .map-main {
    flex: 1;
    position: relative;
    background: #e9ecef;
  }
  
  .map-canvas {
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, #f0f0f0 25%, transparent 25%), 
                linear-gradient(-45deg, #f0f0f0 25%, transparent 25%), 
                linear-gradient(45deg, transparent 75%, #f0f0f0 75%), 
                linear-gradient(-45deg, transparent 75%, #f0f0f0 75%);
    background-size: 20px 20px;
    background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
    position: relative;
    overflow: hidden;
  }
  
  .map-marker {
    position: absolute;
    width: 20px;
    height: 20px;
    border: 2px solid white;
    border-radius: 50%;
    cursor: pointer;
    transform: translate(-50%, -50%);
    z-index: 10;
  }
  
  .map-marker:hover {
    transform: translate(-50%, -50%) scale(1.2);
  }
  
  .map-marker.attraction {
    background: #45b7d1;
  }
  
  .map-marker.hotel {
    background: #4ecdc4;
  }
  
  .map-marker.restaurant {
    background: #ff6b6b;
  }
  
  .map-marker.shopping {
    background: #96ceb4;
  }
  
  .map-marker.transport {
    background: #feca57;
  }
  
  .map-zoom-controls {
    position: absolute;
    top: 20px;
    right: 20px;
    display: flex;
    flex-direction: column;
    gap: 5px;
    z-index: 100;
  }
  
  .zoom-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    font-weight: bold;
  }
  
  .zoom-btn:hover {
    background: #f8f9fa;
  }
  
  .map-layers {
    position: absolute;
    bottom: 20px;
    left: 20px;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 10px;
    z-index: 100;
  }
  
  .layer-toggle {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 8px;
  }
  
  .layer-toggle:last-child {
    margin-bottom: 0;
  }
  
  .layer-toggle input[type="checkbox"] {
    margin: 0;
  }
  
  .layer-toggle label {
    font-size: 12px;
    color: #333;
    cursor: pointer;
  }
  
  .map-legend {
    position: absolute;
    bottom: 20px;
    right: 20px;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    padding: 15px;
    z-index: 100;
  }
  
  .legend-title {
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 10px;
    color: #333;
  }
  
  .legend-item {
    display: flex;
    align-items: center;
    margin-bottom: 5px;
  }
  
  .legend-item:last-child {
    margin-bottom: 0;
  }
  
  .legend-color {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-right: 8px;
  }
  
  .legend-text {
    font-size: 12px;
    color: #666;
  }
  
  .map-coordinates {
    position: absolute;
    top: 20px;
    left: 20px;
    background: rgba(0,0,0,0.7);
    color: white;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 12px;
    z-index: 100;
  }
  
  .info-window {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 1000;
    max-width: 300px;
  }
  
  .info-window-content {
    padding: 20px;
  }
  
  .info-window-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .info-window-header h3 {
    margin: 0;
    color: #333;
    font-size: 18px;
  }
  
  .close-btn {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: #666;
  }
  
  .info-window-body p {
    margin: 0 0 10px 0;
    color: #666;
    font-size: 14px;
  }
  
  .info-actions {
    display: flex;
    gap: 10px;
    margin-top: 15px;
  }
  
  .info-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
  }
  
  .info-btn:hover {
    background: #f8f9fa;
  }
  
  .info-btn.primary {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }
  
  .info-btn.primary:hover {
    background: #0056b3;
  }
</style>
