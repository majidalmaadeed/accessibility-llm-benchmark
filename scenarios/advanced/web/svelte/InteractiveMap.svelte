<script>
  import { onMount } from 'svelte';
  
  let mapContainer;
  let selectedLayer = 'all';
  let showLayers = false;
  let showSearch = false;
  let searchQuery = '';
  let searchResults = [];
  let selectedMarker = null;
  let showInfoWindow = false;
  let infoWindowData = null;
  let zoomLevel = 1;
  let mapCenter = { x: 400, y: 300 };
  let isDragging = false;
  let dragStart = { x: 0, y: 0 };
  let isLoading = false;

  const mapLayers = [
    { id: 'all', name: 'All Layers', color: '#4caf50', visible: true },
    { id: 'restaurants', name: 'Restaurants', color: '#ff9800', visible: true },
    { id: 'hotels', name: 'Hotels', color: '#2196f3', visible: true },
    { id: 'attractions', name: 'Attractions', color: '#9c27b0', visible: true },
    { id: 'transport', name: 'Transport', color: '#f44336', visible: true }
  ];

  const mapMarkers = [
    {
      id: 1,
      name: 'Central Park',
      type: 'attractions',
      position: { x: 200, y: 150 },
      description: 'Large public park in Manhattan',
      rating: 4.8,
      address: 'New York, NY 10024',
      phone: '(212) 310-6600',
      website: 'https://www.centralparknyc.org'
    },
    {
      id: 2,
      name: 'The Plaza Hotel',
      type: 'hotels',
      position: { x: 300, y: 200 },
      description: 'Luxury hotel in Manhattan',
      rating: 4.6,
      address: '768 5th Ave, New York, NY 10019',
      phone: '(212) 759-3000',
      website: 'https://www.theplazany.com'
    },
    {
      id: 3,
      name: 'Times Square',
      type: 'attractions',
      position: { x: 400, y: 250 },
      description: 'Famous commercial intersection',
      rating: 4.5,
      address: 'Times Square, New York, NY 10036',
      phone: '(212) 768-1560',
      website: 'https://www.timessquarenyc.org'
    },
    {
      id: 4,
      name: 'Grand Central Terminal',
      type: 'transport',
      position: { x: 350, y: 300 },
      description: 'Historic train station',
      rating: 4.7,
      address: '89 E 42nd St, New York, NY 10017',
      phone: '(212) 340-2210',
      website: 'https://www.grandcentralterminal.com'
    },
    {
      id: 5,
      name: 'The Metropolitan Museum',
      type: 'attractions',
      position: { x: 250, y: 100 },
      description: 'World-renowned art museum',
      rating: 4.9,
      address: '1000 5th Ave, New York, NY 10028',
      phone: '(212) 535-7710',
      website: 'https://www.metmuseum.org'
    },
    {
      id: 6,
      name: 'Le Bernardin',
      type: 'restaurants',
      position: { x: 450, y: 180 },
      description: 'Michelin-starred seafood restaurant',
      rating: 4.8,
      address: '155 W 51st St, New York, NY 10019',
      phone: '(212) 554-1515',
      website: 'https://www.le-bernardin.com'
    },
    {
      id: 7,
      name: 'Brooklyn Bridge',
      type: 'attractions',
      position: { x: 500, y: 350 },
      description: 'Historic suspension bridge',
      rating: 4.6,
      address: 'Brooklyn Bridge, New York, NY 10038',
      phone: '(212) 639-9675',
      website: 'https://www.nyc.gov/html/dot/html/bridges/brooklyn.shtml'
    },
    {
      id: 8,
      name: 'Penn Station',
      type: 'transport',
      position: { x: 380, y: 320 },
      description: 'Major transportation hub',
      rating: 4.2,
      address: '234 W 31st St, New York, NY 10001',
      phone: '(212) 630-6400',
      website: 'https://www.njtransit.com'
    }
  ];

  const searchSuggestions = [
    'Central Park',
    'Times Square',
    'Brooklyn Bridge',
    'Metropolitan Museum',
    'Grand Central',
    'The Plaza Hotel',
    'Le Bernardin',
    'Penn Station'
  ];

  $: visibleMarkers = mapMarkers.filter(marker => {
    if (selectedLayer === 'all') return true;
    return marker.type === selectedLayer;
  });

  $: filteredResults = searchResults.filter(result => 
    result.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  onMount(() => {
    setupMap();
  });

  function setupMap() {
    if (mapContainer) {
      mapContainer.addEventListener('mousedown', handleMouseDown);
      mapContainer.addEventListener('mousemove', handleMouseMove);
      mapContainer.addEventListener('mouseup', handleMouseUp);
      mapContainer.addEventListener('wheel', handleWheel);
    }
  }

  function handleMouseDown(event) {
    isDragging = true;
    dragStart = { x: event.clientX - mapCenter.x, y: event.clientY - mapCenter.y };
  }

  function handleMouseMove(event) {
    if (isDragging) {
      mapCenter = {
        x: event.clientX - dragStart.x,
        y: event.clientY - dragStart.y
      };
    }
  }

  function handleMouseUp() {
    isDragging = false;
  }

  function handleWheel(event) {
    event.preventDefault();
    const delta = event.deltaY > 0 ? -0.1 : 0.1;
    zoomLevel = Math.max(0.5, Math.min(2, zoomLevel + delta));
  }

  function handleMarkerClick(marker) {
    selectedMarker = marker;
    infoWindowData = marker;
    showInfoWindow = true;
  }

  function handleSearch() {
    if (!searchQuery.trim()) {
      searchResults = [];
      return;
    }

    isLoading = true;
    setTimeout(() => {
      searchResults = mapMarkers.filter(marker => 
        marker.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        marker.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
        marker.address.toLowerCase().includes(searchQuery.toLowerCase())
      );
      isLoading = false;
    }, 500);
  }

  function handleSuggestionClick(suggestion) {
    searchQuery = suggestion;
    handleSearch();
  }

  function handleSearchResultClick(result) {
    const marker = mapMarkers.find(m => m.id === result.id);
    if (marker) {
      mapCenter = { x: marker.position.x, y: marker.position.y };
      zoomLevel = 1.5;
      handleMarkerClick(marker);
    }
  }

  function handleLayerToggle(layerId) {
    const layer = mapLayers.find(l => l.id === layerId);
    if (layer) {
      layer.visible = !layer.visible;
    }
  }

  function handleZoomIn() {
    zoomLevel = Math.min(2, zoomLevel + 0.2);
  }

  function handleZoomOut() {
    zoomLevel = Math.max(0.5, zoomLevel - 0.2);
  }

  function handleResetView() {
    mapCenter = { x: 400, y: 300 };
    zoomLevel = 1;
  }

  function getMarkerColor(type) {
    const layer = mapLayers.find(l => l.id === type);
    return layer ? layer.color : '#666';
  }

  function getMarkerIcon(type) {
    switch (type) {
      case 'restaurants': return '🍽️';
      case 'hotels': return '🏨';
      case 'attractions': return '🎯';
      case 'transport': return '🚇';
      default: return '📍';
    }
  }

  function formatRating(rating) {
    return '★'.repeat(Math.floor(rating)) + '☆'.repeat(5 - Math.floor(rating));
  }

  function closeInfoWindow() {
    showInfoWindow = false;
    selectedMarker = null;
    infoWindowData = null;
  }

  function getMarkerStyle(marker) {
    const layer = mapLayers.find(l => l.id === marker.type);
    const isVisible = layer ? layer.visible : true;
    const opacity = isVisible ? 1 : 0.3;
    
    return `
      position: absolute;
      left: ${marker.position.x}px;
      top: ${marker.position.y}px;
      transform: translate(-50%, -50%);
      opacity: ${opacity};
    `;
  }

  function getMapStyle() {
    return `
      transform: translate(${mapCenter.x}px, ${mapCenter.y}px) scale(${zoomLevel});
      transform-origin: center center;
    `;
  }
</script>

<div class="interactive-map">
  <div class="map-header">
    <h1>Interactive Map</h1>
    <div class="map-controls">
      <button 
        on:click={() => showSearch = !showSearch}
        class="control-btn"
      >
        {showSearch ? 'Hide' : 'Show'} Search
      </button>
      <button 
        on:click={() => showLayers = !showLayers}
        class="control-btn"
      >
        {showLayers ? 'Hide' : 'Show'} Layers
      </button>
      <button 
        on:click={handleResetView}
        class="control-btn"
      >
        Reset View
      </button>
    </div>
  </div>

  <div class="map-container">
    <div class="map-sidebar">
      {#if showLayers}
        <div class="layers-panel">
          <h3>Map Layers</h3>
          <div class="layers-list">
            {#each mapLayers as layer}
              <div class="layer-item">
                <label class="layer-checkbox">
                  <input
                    type="checkbox"
                    checked={layer.visible}
                    on:change={() => handleLayerToggle(layer.id)}
                  />
                  <span 
                    class="layer-color"
                    style="background-color: {layer.color}"
                  />
                  <span class="layer-name">{layer.name}</span>
                </label>
              </div>
            {/each}
          </div>
        </div>
      {/if}

      {#if showSearch}
        <div class="search-panel">
          <h3>Search Locations</h3>
          <div class="search-input-container">
            <input
              type="text"
              bind:value={searchQuery}
              on:input={handleSearch}
              placeholder="Search for places..."
              class="search-input"
            />
            <button 
              on:click={handleSearch}
              disabled={isLoading}
              class="search-btn"
            >
              {isLoading ? '⏳' : '🔍'}
            </button>
          </div>
          
          {#if searchQuery && searchSuggestions.length > 0}
            <div class="suggestions">
              <div class="suggestions-header">Suggestions</div>
              {#each searchSuggestions as suggestion}
                <div 
                  class="suggestion-item"
                  on:click={() => handleSuggestionClick(suggestion)}
                >
                  💡 {suggestion}
                </div>
              {/each}
            </div>
          {/if}

          {#if searchResults.length > 0}
            <div class="search-results">
              <div class="results-header">Search Results</div>
              {#each searchResults as result}
                <div 
                  class="result-item"
                  on:click={() => handleSearchResultClick(result)}
                >
                  <div class="result-icon">{getMarkerIcon(result.type)}</div>
                  <div class="result-info">
                    <div class="result-name">{result.name}</div>
                    <div class="result-description">{result.description}</div>
                    <div class="result-rating">{formatRating(result.rating)}</div>
                  </div>
                </div>
              {/each}
            </div>
          {/if}
        </div>
      {/if}

      <div class="map-info">
        <h3>Map Information</h3>
        <div class="info-item">
          <span class="info-label">Zoom Level:</span>
          <span class="info-value">{Math.round(zoomLevel * 100)}%</span>
        </div>
        <div class="info-item">
          <span class="info-label">Visible Markers:</span>
          <span class="info-value">{visibleMarkers.length}</span>
        </div>
        <div class="info-item">
          <span class="info-label">Total Locations:</span>
          <span class="info-value">{mapMarkers.length}</span>
        </div>
      </div>
    </div>

    <div class="map-main">
      <div 
        class="map-display"
        bind:this={mapContainer}
        style={getMapStyle()}
      >
        <div class="map-background">
          <div class="map-grid"></div>
        </div>
        
        {#each visibleMarkers as marker}
          <div 
            class="map-marker"
            style={getMarkerStyle(marker)}
            on:click={() => handleMarkerClick(marker)}
          >
            <div 
              class="marker-icon"
              style="background-color: {getMarkerColor(marker.type)}"
            >
              {getMarkerIcon(marker.type)}
            </div>
            <div class="marker-label">{marker.name}</div>
          </div>
        {/each}
      </div>

      <div class="zoom-controls">
        <button 
          on:click={handleZoomIn}
          class="zoom-btn"
          title="Zoom In"
        >
          +
        </button>
        <button 
          on:click={handleZoomOut}
          class="zoom-btn"
          title="Zoom Out"
        >
          −
        </button>
      </div>

      {#if showInfoWindow && infoWindowData}
        <div class="info-window">
          <div class="info-header">
            <h4>{infoWindowData.name}</h4>
            <button 
              on:click={closeInfoWindow}
              class="close-btn"
            >
              ✕
            </button>
          </div>
          <div class="info-content">
            <div class="info-type">
              {infoWindowData.type.toUpperCase()}
            </div>
            <div class="info-description">
              {infoWindowData.description}
            </div>
            <div class="info-rating">
              <span class="rating-stars">{formatRating(infoWindowData.rating)}</span>
              <span class="rating-value">{infoWindowData.rating}</span>
            </div>
            <div class="info-address">
              📍 {infoWindowData.address}
            </div>
            <div class="info-phone">
              📞 {infoWindowData.phone}
            </div>
            <div class="info-website">
              🌐 <a href={infoWindowData.website} target="_blank">Visit Website</a>
            </div>
          </div>
          <div class="info-actions">
            <button class="action-btn">Directions</button>
            <button class="action-btn">Save</button>
            <button class="action-btn">Share</button>
          </div>
        </div>
      {/if}
    </div>
  </div>

  <div class="map-footer">
    <div class="map-instructions">
      <span>Click and drag to pan • Scroll to zoom • Click markers for details</span>
    </div>
    <div class="map-legend">
      {#each mapLayers as layer}
        <div class="legend-item">
          <div 
            class="legend-color"
            style="background-color: {layer.color}"
          />
          <span class="legend-label">{layer.name}</span>
        </div>
      {/each}
    </div>
  </div>
</div>

<style>
  .interactive-map {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }

  .map-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e0e0e0;
  }

  .map-header h1 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .map-controls {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .control-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .control-btn:hover {
    background: #45a049;
  }

  .map-container {
    display: grid;
    grid-template-columns: 300px 1fr;
    gap: 20px;
    height: 600px;
  }

  .map-sidebar {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 20px;
    overflow-y: auto;
  }

  .layers-panel,
  .search-panel,
  .map-info {
    margin-bottom: 25px;
  }

  .layers-panel h3,
  .search-panel h3,
  .map-info h3 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 16px;
    font-weight: 600;
  }

  .layers-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .layer-item {
    display: flex;
    align-items: center;
  }

  .layer-checkbox {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
  }

  .layer-checkbox input[type="checkbox"] {
    margin: 0;
  }

  .layer-color {
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 2px solid white;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
  }

  .layer-name {
    font-weight: 500;
  }

  .search-input-container {
    display: flex;
    gap: 8px;
    margin-bottom: 15px;
  }

  .search-input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.3s ease;
  }

  .search-input:focus {
    outline: none;
    border-color: #4caf50;
  }

  .search-btn {
    padding: 8px 12px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.3s ease;
  }

  .search-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .search-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .suggestions {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    margin-bottom: 15px;
  }

  .suggestions-header {
    padding: 8px 12px;
    background: #f8f9fa;
    font-weight: 600;
    font-size: 12px;
    color: #666;
    border-bottom: 1px solid #e0e0e0;
  }

  .suggestion-item {
    padding: 8px 12px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: background-color 0.3s ease;
  }

  .suggestion-item:hover {
    background: #f0f8ff;
  }

  .search-results {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    max-height: 200px;
    overflow-y: auto;
  }

  .results-header {
    padding: 8px 12px;
    background: #f8f9fa;
    font-weight: 600;
    font-size: 12px;
    color: #666;
    border-bottom: 1px solid #e0e0e0;
  }

  .result-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border-bottom: 1px solid #f0f0f0;
  }

  .result-item:hover {
    background: #f0f8ff;
  }

  .result-item:last-child {
    border-bottom: none;
  }

  .result-icon {
    font-size: 16px;
  }

  .result-info {
    flex: 1;
    min-width: 0;
  }

  .result-name {
    font-weight: 600;
    color: #333;
    font-size: 14px;
    margin-bottom: 2px;
  }

  .result-description {
    font-size: 12px;
    color: #666;
    margin-bottom: 2px;
  }

  .result-rating {
    font-size: 11px;
    color: #ff9800;
  }

  .map-info {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    padding: 15px;
  }

  .info-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 4px 0;
    font-size: 12px;
    color: #666;
  }

  .info-label {
    font-weight: 600;
  }

  .info-value {
    color: #333;
  }

  .map-main {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: relative;
  }

  .map-display {
    position: relative;
    width: 100%;
    height: 100%;
    background: #e8f5e8;
    overflow: hidden;
    cursor: grab;
  }

  .map-display:active {
    cursor: grabbing;
  }

  .map-background {
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, #e8f5e8 25%, #f0f8f0 25%, #f0f8f0 50%, #e8f5e8 50%, #e8f5e8 75%, #f0f8f0 75%);
    background-size: 20px 20px;
  }

  .map-grid {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
      linear-gradient(rgba(0, 0, 0, 0.1) 1px, transparent 1px),
      linear-gradient(90deg, rgba(0, 0, 0, 0.1) 1px, transparent 1px);
    background-size: 20px 20px;
  }

  .map-marker {
    position: absolute;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .map-marker:hover {
    transform: translate(-50%, -50%) scale(1.2);
    z-index: 10;
  }

  .marker-icon {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    border: 3px solid white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    transition: all 0.3s ease;
  }

  .marker-label {
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 11px;
    font-weight: 600;
    white-space: nowrap;
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none;
  }

  .map-marker:hover .marker-label {
    opacity: 1;
  }

  .zoom-controls {
    position: absolute;
    top: 15px;
    right: 15px;
    display: flex;
    flex-direction: column;
    gap: 5px;
    z-index: 5;
  }

  .zoom-btn {
    width: 40px;
    height: 40px;
    background: white;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .zoom-btn:hover {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .info-window {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    z-index: 20;
    min-width: 250px;
    max-width: 300px;
  }

  .info-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    background: #4caf50;
    color: white;
    border-radius: 8px 8px 0 0;
  }

  .info-header h4 {
    margin: 0;
    font-size: 16px;
    font-weight: 600;
  }

  .close-btn {
    background: none;
    border: none;
    color: white;
    cursor: pointer;
    font-size: 16px;
    padding: 4px;
    border-radius: 3px;
    transition: background-color 0.3s ease;
  }

  .close-btn:hover {
    background: rgba(255, 255, 255, 0.2);
  }

  .info-content {
    padding: 15px;
  }

  .info-type {
    font-size: 12px;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 8px;
  }

  .info-description {
    font-size: 14px;
    color: #333;
    line-height: 1.4;
    margin-bottom: 10px;
  }

  .info-rating {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-bottom: 8px;
  }

  .rating-stars {
    color: #ff9800;
    font-size: 14px;
  }

  .rating-value {
    font-size: 12px;
    color: #666;
    font-weight: 600;
  }

  .info-address,
  .info-phone,
  .info-website {
    font-size: 12px;
    color: #666;
    margin-bottom: 4px;
  }

  .info-website a {
    color: #4caf50;
    text-decoration: none;
  }

  .info-website a:hover {
    text-decoration: underline;
  }

  .info-actions {
    display: flex;
    gap: 8px;
    padding: 15px;
    border-top: 1px solid #e0e0e0;
  }

  .action-btn {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
    border-radius: 4px;
    font-size: 12px;
    color: #333;
    transition: all 0.3s ease;
  }

  .action-btn:hover {
    background: #f5f5f5;
  }

  .action-btn:first-child:hover {
    background: #f44336;
    color: white;
    border-color: #f44336;
  }

  .action-btn:last-child:hover {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .map-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #e0e0e0;
    font-size: 12px;
    color: #666;
  }

  .map-instructions {
    flex: 1;
  }

  .map-legend {
    display: flex;
    gap: 15px;
  }

  .legend-item {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .legend-color {
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 2px solid white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 8px;
    color: white;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
  }

  @media (max-width: 768px) {
    .interactive-map {
      padding: 15px;
    }
    
    .map-header {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .map-controls {
      justify-content: center;
    }
    
    .map-container {
      grid-template-columns: 1fr;
      height: auto;
    }
    
    .map-sidebar {
      order: 2;
      height: auto;
    }
    
    .map-main {
      order: 1;
      height: 400px;
    }
    
    .map-footer {
      flex-direction: column;
      gap: 15px;
      align-items: stretch;
    }
    
    .map-legend {
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .map-controls {
      gap: 8px;
    }
    
    .map-main {
      height: 300px;
    }
    
    .info-window {
      min-width: 200px;
      max-width: 250px;
    }
    
    .map-legend {
      flex-wrap: wrap;
      gap: 8px;
    }
  }
</style>
