<template>
  <div class="interactive-map">
    <div class="map-header">
      <h1>Interactive Map</h1>
      <div class="map-controls">
        <div class="search-box">
          <input
            v-model="searchQuery"
            @keyup.enter="searchLocation"
            type="text"
            placeholder="Search locations..."
            class="search-input"
          />
          <button 
            @click="searchLocation"
            class="search-btn"
          >
            🔍
          </button>
        </div>
        
        <div class="view-controls">
          <button 
            @click="setMapView('satellite')"
            :class="{ active: mapView === 'satellite' }"
            class="view-btn"
          >
            Satellite
          </button>
          <button 
            @click="setMapView('terrain')"
            :class="{ active: mapView === 'terrain' }"
            class="view-btn"
          >
            Terrain
          </button>
          <button 
            @click="setMapView('street')"
            :class="{ active: mapView === 'street' }"
            class="view-btn"
          >
            Street
          </button>
        </div>
      </div>
    </div>

    <div class="map-container">
      <div class="map-sidebar">
        <div class="layers-panel">
          <h3>Map Layers</h3>
          <div class="layer-options">
            <label 
              v-for="layer in mapLayers"
              :key="layer.id"
              class="layer-option"
            >
              <input
                v-model="activeLayers"
                type="checkbox"
                :value="layer.id"
              />
              <span class="layer-name">{{ layer.name }}</span>
              <span class="layer-count">({{ layer.count }})</span>
            </label>
          </div>
        </div>

        <div class="filters-panel">
          <h3>Filters</h3>
          <div class="filter-group">
            <label class="filter-label">Category</label>
            <select v-model="selectedCategory" class="filter-select">
              <option value="">All Categories</option>
              <option
                v-for="category in categories"
                :key="category.value"
                :value="category.value"
              >
                {{ category.label }} ({{ category.count }})
              </option>
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Distance</label>
            <select v-model="selectedDistance" class="filter-select">
              <option value="1">Within 1 mile</option>
              <option value="5">Within 5 miles</option>
              <option value="10">Within 10 miles</option>
              <option value="25">Within 25 miles</option>
              <option value="50">Within 50 miles</option>
            </select>
          </div>
          
          <div class="filter-group">
            <label class="filter-label">Rating</label>
            <div class="rating-filter">
              <label 
                v-for="rating in ratingOptions"
                :key="rating.value"
                class="rating-option"
              >
                <input
                  v-model="selectedRating"
                  type="radio"
                  :value="rating.value"
                  name="rating"
                />
                <div class="stars">
                  <span 
                    v-for="i in 5"
                    :key="i"
                    class="star"
                    :class="{ filled: i <= rating.value }"
                  >
                    ★
                  </span>
                </div>
                <span class="rating-text">{{ rating.label }}</span>
              </label>
            </div>
          </div>
        </div>

        <div class="results-panel">
          <h3>Search Results</h3>
          <div class="results-list">
            <div 
              v-for="location in filteredLocations"
              :key="location.id"
              class="result-item"
              :class="{ active: selectedLocation?.id === location.id }"
              @click="selectLocation(location)"
            >
              <div class="result-image">
                <img :src="location.image" :alt="location.name" />
              </div>
              <div class="result-content">
                <h4 class="result-name">{{ location.name }}</h4>
                <p class="result-address">{{ location.address }}</p>
                <div class="result-meta">
                  <span class="result-category">{{ location.category }}</span>
                  <span class="result-distance">{{ location.distance }} mi</span>
                </div>
                <div class="result-rating">
                  <div class="stars">
                    <span 
                      v-for="i in 5"
                      :key="i"
                      class="star"
                      :class="{ filled: i <= location.rating }"
                    >
                      ★
                    </span>
                  </div>
                  <span class="rating-value">{{ location.rating }}/5</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="map-area">
        <div class="map-canvas" ref="mapCanvas">
          <div class="map-placeholder">
            <div class="map-grid">
              <div 
                v-for="row in 20"
                :key="row"
                class="grid-row"
              >
                <div 
                  v-for="col in 30"
                  :key="col"
                  class="grid-cell"
                  :class="{ 
                    'has-marker': hasMarkerAt(row, col),
                    'highlighted': isHighlighted(row, col)
                  }"
                  @click="handleMapClick(row, col)"
                />
              </div>
            </div>
            
            <div 
              v-for="marker in visibleMarkers"
              :key="marker.id"
              class="map-marker"
              :style="{ 
                left: marker.x + '%', 
                top: marker.y + '%',
                '--marker-color': marker.color
              }"
              @click="selectLocation(marker)"
            >
              <div class="marker-icon">{{ marker.icon }}</div>
              <div class="marker-label">{{ marker.name }}</div>
            </div>
          </div>
        </div>

        <div class="map-zoom-controls">
          <button 
            @click="zoomIn"
            class="zoom-btn"
            title="Zoom In"
          >
            +
          </button>
          <button 
            @click="zoomOut"
            class="zoom-btn"
            title="Zoom Out"
          >
            −
          </button>
          <button 
            @click="resetView"
            class="zoom-btn"
            title="Reset View"
          >
            ⌂
          </button>
        </div>

        <div class="map-info">
          <div class="coordinates">
            Lat: {{ currentLat.toFixed(4) }}, Lng: {{ currentLng.toFixed(4) }}
          </div>
          <div class="zoom-level">
            Zoom: {{ zoomLevel }}x
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedLocation" class="location-details">
      <div class="details-header">
        <h3>{{ selectedLocation.name }}</h3>
        <button 
          @click="selectedLocation = null"
          class="close-btn"
        >
          ✕
        </button>
      </div>
      
      <div class="details-content">
        <div class="location-image">
          <img :src="selectedLocation.image" :alt="selectedLocation.name" />
        </div>
        
        <div class="location-info">
          <div class="info-row">
            <span class="info-label">Address:</span>
            <span class="info-value">{{ selectedLocation.address }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">Category:</span>
            <span class="info-value">{{ selectedLocation.category }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">Rating:</span>
            <span class="info-value">
              <div class="stars">
                <span 
                  v-for="i in 5"
                  :key="i"
                  class="star"
                  :class="{ filled: i <= selectedLocation.rating }"
                >
                  ★
                </span>
              </div>
              {{ selectedLocation.rating }}/5 ({{ selectedLocation.reviewCount }} reviews)
            </span>
          </div>
          <div class="info-row">
            <span class="info-label">Distance:</span>
            <span class="info-value">{{ selectedLocation.distance }} miles</span>
          </div>
          <div class="info-row">
            <span class="info-label">Phone:</span>
            <span class="info-value">{{ selectedLocation.phone }}</span>
          </div>
          <div class="info-row">
            <span class="info-label">Hours:</span>
            <span class="info-value">{{ selectedLocation.hours }}</span>
          </div>
        </div>
        
        <div class="location-actions">
          <button 
            @click="getDirections"
            class="action-btn directions"
          >
            🧭 Get Directions
          </button>
          <button 
            @click="callLocation"
            class="action-btn call"
          >
            📞 Call
          </button>
          <button 
            @click="shareLocation"
            class="action-btn share"
          >
            📤 Share
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'InteractiveMap',
  data() {
    return {
      searchQuery: '',
      mapView: 'street',
      activeLayers: ['restaurants', 'hotels', 'attractions'],
      selectedCategory: '',
      selectedDistance: '10',
      selectedRating: 0,
      selectedLocation: null,
      currentLat: 40.7128,
      currentLng: -74.0060,
      zoomLevel: 1,
      mapLayers: [
        { id: 'restaurants', name: 'Restaurants', count: 45 },
        { id: 'hotels', name: 'Hotels', count: 23 },
        { id: 'attractions', name: 'Attractions', count: 18 },
        { id: 'gas_stations', name: 'Gas Stations', count: 12 },
        { id: 'hospitals', name: 'Hospitals', count: 8 },
        { id: 'schools', name: 'Schools', count: 15 }
      ],
      categories: [
        { value: 'restaurant', label: 'Restaurants', count: 45 },
        { value: 'hotel', label: 'Hotels', count: 23 },
        { value: 'attraction', label: 'Attractions', count: 18 },
        { value: 'shopping', label: 'Shopping', count: 32 },
        { value: 'entertainment', label: 'Entertainment', count: 15 }
      ],
      ratingOptions: [
        { value: 0, label: 'Any Rating' },
        { value: 4, label: '4+ Stars' },
        { value: 3, label: '3+ Stars' },
        { value: 2, label: '2+ Stars' },
        { value: 1, label: '1+ Stars' }
      ],
      locations: [
        {
          id: 1,
          name: 'Central Park',
          address: 'Central Park, New York, NY 10024',
          category: 'attraction',
          rating: 4.8,
          reviewCount: 1250,
          distance: 0.5,
          phone: '(212) 310-6600',
          hours: '6:00 AM - 1:00 AM',
          image: 'https://via.placeholder.com/300x200/4caf50/fff?text=Central+Park',
          x: 45,
          y: 35,
          color: '#4caf50',
          icon: '🌳'
        },
        {
          id: 2,
          name: 'The Plaza Hotel',
          address: '768 5th Ave, New York, NY 10019',
          category: 'hotel',
          rating: 4.6,
          reviewCount: 890,
          distance: 0.8,
          phone: '(212) 759-3000',
          hours: '24/7',
          image: 'https://via.placeholder.com/300x200/2196f3/fff?text=Plaza+Hotel',
          x: 52,
          y: 28,
          color: '#2196f3',
          icon: '🏨'
        },
        {
          id: 3,
          name: 'Joe\'s Pizza',
          address: '7 Carmine St, New York, NY 10014',
          category: 'restaurant',
          rating: 4.4,
          reviewCount: 567,
          distance: 1.2,
          phone: '(212) 366-1182',
          hours: '10:00 AM - 2:00 AM',
          image: 'https://via.placeholder.com/300x200/ff9800/fff?text=Joe+Pizza',
          x: 38,
          y: 42,
          color: '#ff9800',
          icon: '🍕'
        },
        {
          id: 4,
          name: 'Times Square',
          address: 'Times Square, New York, NY 10036',
          category: 'attraction',
          rating: 4.2,
          reviewCount: 2100,
          distance: 1.5,
          phone: '(212) 768-1560',
          hours: '24/7',
          image: 'https://via.placeholder.com/300x200/9c27b0/fff?text=Times+Square',
          x: 48,
          y: 45,
          color: '#9c27b0',
          icon: '🎭'
        },
        {
          id: 5,
          name: 'Brooklyn Bridge',
          address: 'Brooklyn Bridge, New York, NY 10038',
          category: 'attraction',
          rating: 4.7,
          reviewCount: 980,
          distance: 2.1,
          phone: 'N/A',
          hours: '24/7',
          image: 'https://via.placeholder.com/300x200/f44336/fff?text=Brooklyn+Bridge',
          x: 25,
          y: 55,
          color: '#f44336',
          icon: '🌉'
        }
      ]
    }
  },
  computed: {
    visibleMarkers() {
      return this.locations.filter(location => 
        this.activeLayers.includes(location.category) &&
        (!this.selectedCategory || location.category === this.selectedCategory) &&
        (!this.selectedRating || location.rating >= this.selectedRating)
      )
    },
    filteredLocations() {
      return this.locations.filter(location => 
        (!this.selectedCategory || location.category === this.selectedCategory) &&
        (!this.selectedRating || location.rating >= this.selectedRating) &&
        location.distance <= parseFloat(this.selectedDistance)
      )
    }
  },
  methods: {
    searchLocation() {
      if (this.searchQuery.trim()) {
        console.log('Searching for:', this.searchQuery)
        const foundLocation = this.locations.find(loc => 
          loc.name.toLowerCase().includes(this.searchQuery.toLowerCase())
        )
        if (foundLocation) {
          this.selectLocation(foundLocation)
          this.centerOnLocation(foundLocation)
        }
      }
    },
    setMapView(view) {
      this.mapView = view
      console.log('Map view changed to:', view)
    },
    selectLocation(location) {
      this.selectedLocation = location
    },
    centerOnLocation(location) {
      this.currentLat = location.lat || 40.7128
      this.currentLng = location.lng || -74.0060
      console.log('Centering on:', location.name)
    },
    handleMapClick(row, col) {
      console.log('Map clicked at:', row, col)
      this.selectedLocation = null
    },
    hasMarkerAt(row, col) {
      return this.visibleMarkers.some(marker => 
        Math.abs(marker.x - col * 3.33) < 2 && 
        Math.abs(marker.y - row * 5) < 2
      )
    },
    isHighlighted(row, col) {
      return this.selectedLocation && 
        Math.abs(this.selectedLocation.x - col * 3.33) < 2 && 
        Math.abs(this.selectedLocation.y - row * 5) < 2
    },
    zoomIn() {
      this.zoomLevel = Math.min(this.zoomLevel + 0.5, 3)
      console.log('Zoomed in to:', this.zoomLevel)
    },
    zoomOut() {
      this.zoomLevel = Math.max(this.zoomLevel - 0.5, 0.5)
      console.log('Zoomed out to:', this.zoomLevel)
    },
    resetView() {
      this.zoomLevel = 1
      this.currentLat = 40.7128
      this.currentLng = -74.0060
      this.selectedLocation = null
      console.log('View reset')
    },
    getDirections() {
      if (this.selectedLocation) {
        console.log('Getting directions to:', this.selectedLocation.name)
        alert(`Getting directions to ${this.selectedLocation.name}`)
      }
    },
    callLocation() {
      if (this.selectedLocation && this.selectedLocation.phone) {
        console.log('Calling:', this.selectedLocation.phone)
        alert(`Calling ${this.selectedLocation.phone}`)
      }
    },
    shareLocation() {
      if (this.selectedLocation) {
        console.log('Sharing:', this.selectedLocation.name)
        alert(`Sharing ${this.selectedLocation.name}`)
      }
    }
  }
}
</script>

<style scoped>
.interactive-map {
  max-width: 1400px;
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
  gap: 20px;
  align-items: center;
}

.search-box {
  display: flex;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  overflow: hidden;
}

.search-input {
  padding: 8px 12px;
  border: none;
  outline: none;
  font-size: 14px;
  width: 200px;
}

.search-input::placeholder {
  color: #999;
}

.search-btn {
  padding: 8px 12px;
  background: #4caf50;
  color: white;
  border: none;
  cursor: pointer;
  font-size: 14px;
}

.search-btn:hover {
  background: #45a049;
}

.view-controls {
  display: flex;
  gap: 5px;
}

.view-btn {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.view-btn:hover {
  background: #f0f0f0;
  border-color: #4caf50;
}

.view-btn.active {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.map-container {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 20px;
  height: 600px;
}

.map-sidebar {
  background: #f8f9fa;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  overflow-y: auto;
}

.layers-panel,
.filters-panel,
.results-panel {
  margin-bottom: 25px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.layers-panel:last-child,
.filters-panel:last-child,
.results-panel:last-child {
  border-bottom: none;
  margin-bottom: 0;
}

.layers-panel h3,
.filters-panel h3,
.results-panel h3 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 16px;
}

.layer-options {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.layer-option {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 14px;
}

.layer-name {
  color: #333;
}

.layer-count {
  color: #666;
  font-size: 12px;
}

.filter-group {
  margin-bottom: 15px;
}

.filter-label {
  display: block;
  margin-bottom: 5px;
  font-weight: 600;
  color: #333;
  font-size: 12px;
}

.filter-select {
  width: 100%;
  padding: 6px 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 12px;
  background: white;
  cursor: pointer;
}

.filter-select:focus {
  outline: none;
  border-color: #4caf50;
}

.rating-filter {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.rating-option {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 12px;
}

.stars {
  display: flex;
  gap: 1px;
}

.star {
  color: #ddd;
  font-size: 12px;
}

.star.filled {
  color: #ffc107;
}

.rating-text {
  color: #333;
}

.results-list {
  max-height: 200px;
  overflow-y: auto;
}

.result-item {
  display: flex;
  gap: 10px;
  padding: 10px;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.result-item:hover {
  border-color: #4caf50;
  background: #f8f9fa;
}

.result-item.active {
  border-color: #4caf50;
  background: #e8f5e8;
}

.result-image {
  width: 50px;
  height: 50px;
  border-radius: 4px;
  overflow: hidden;
  flex-shrink: 0;
}

.result-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.result-content {
  flex: 1;
  min-width: 0;
}

.result-name {
  margin: 0 0 4px 0;
  color: #333;
  font-size: 14px;
  font-weight: 600;
  line-height: 1.2;
}

.result-address {
  margin: 0 0 6px 0;
  color: #666;
  font-size: 11px;
  line-height: 1.2;
}

.result-meta {
  display: flex;
  gap: 8px;
  margin-bottom: 4px;
  font-size: 10px;
  color: #999;
}

.result-category {
  text-transform: capitalize;
}

.result-rating {
  display: flex;
  align-items: center;
  gap: 4px;
}

.rating-value {
  font-size: 10px;
  color: #333;
  font-weight: 600;
}

.map-area {
  position: relative;
  background: #f0f8ff;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
}

.map-canvas {
  width: 100%;
  height: 100%;
  position: relative;
}

.map-placeholder {
  width: 100%;
  height: 100%;
  position: relative;
  background: linear-gradient(45deg, #e8f5e8 25%, transparent 25%), 
              linear-gradient(-45deg, #e8f5e8 25%, transparent 25%), 
              linear-gradient(45deg, transparent 75%, #e8f5e8 75%), 
              linear-gradient(-45deg, transparent 75%, #e8f5e8 75%);
  background-size: 20px 20px;
  background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
}

.map-grid {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.grid-row {
  display: flex;
  flex: 1;
}

.grid-cell {
  flex: 1;
  border: 1px solid rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.grid-cell:hover {
  background: rgba(76, 175, 80, 0.1);
}

.grid-cell.has-marker {
  background: rgba(76, 175, 80, 0.2);
}

.grid-cell.highlighted {
  background: rgba(255, 193, 7, 0.3);
}

.map-marker {
  position: absolute;
  transform: translate(-50%, -50%);
  cursor: pointer;
  z-index: 10;
}

.marker-icon {
  width: 30px;
  height: 30px;
  background: var(--marker-color, #4caf50);
  border: 2px solid white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
  transition: transform 0.3s ease;
}

.map-marker:hover .marker-icon {
  transform: scale(1.2);
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
  white-space: nowrap;
  margin-top: 5px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.map-marker:hover .marker-label {
  opacity: 1;
}

.map-zoom-controls {
  position: absolute;
  top: 20px;
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 5px;
  z-index: 20;
}

.zoom-btn {
  width: 40px;
  height: 40px;
  border: 1px solid #ddd;
  background: white;
  border-radius: 6px;
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
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

.map-info {
  position: absolute;
  bottom: 20px;
  left: 20px;
  background: rgba(0, 0, 0, 0.8);
  color: white;
  padding: 8px 12px;
  border-radius: 4px;
  font-size: 11px;
  z-index: 20;
}

.coordinates,
.zoom-level {
  margin: 2px 0;
}

.location-details {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 500px;
  max-height: 80vh;
  overflow-y: auto;
  z-index: 1000;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.details-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.details-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.close-btn {
  background: none;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: #666;
}

.details-content {
  padding: 20px;
}

.location-image {
  width: 100%;
  height: 200px;
  border-radius: 6px;
  overflow: hidden;
  margin-bottom: 20px;
}

.location-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.location-info {
  margin-bottom: 20px;
}

.info-row {
  display: flex;
  margin-bottom: 10px;
  font-size: 14px;
}

.info-label {
  font-weight: 600;
  color: #333;
  width: 80px;
  flex-shrink: 0;
}

.info-value {
  color: #666;
  flex: 1;
}

.location-actions {
  display: flex;
  gap: 10px;
}

.action-btn {
  flex: 1;
  padding: 10px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.action-btn.directions {
  background: #4caf50;
  color: white;
}

.action-btn.directions:hover {
  background: #45a049;
}

.action-btn.call {
  background: #2196f3;
  color: white;
}

.action-btn.call:hover {
  background: #1976d2;
}

.action-btn.share {
  background: #ff9800;
  color: white;
}

.action-btn.share:hover {
  background: #f57c00;
}

@media (max-width: 1024px) {
  .map-container {
    grid-template-columns: 250px 1fr;
    height: 500px;
  }
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
    flex-direction: column;
    gap: 15px;
  }
  
  .search-box {
    width: 100%;
  }
  
  .search-input {
    width: 100%;
  }
  
  .view-controls {
    justify-content: center;
  }
  
  .map-container {
    grid-template-columns: 1fr;
    height: 400px;
  }
  
  .map-sidebar {
    order: 2;
    height: 300px;
  }
  
  .map-area {
    order: 1;
  }
  
  .location-details {
    width: 95%;
    max-height: 70vh;
  }
  
  .location-actions {
    flex-direction: column;
  }
}

@media (max-width: 480px) {
  .interactive-map {
    padding: 10px;
  }
  
  .map-container {
    height: 350px;
  }
  
  .map-sidebar {
    height: 250px;
  }
  
  .result-item {
    flex-direction: column;
    text-align: center;
  }
  
  .result-image {
    width: 100%;
    height: 80px;
  }
  
  .map-zoom-controls {
    top: 10px;
    right: 10px;
  }
  
  .zoom-btn {
    width: 35px;
    height: 35px;
    font-size: 16px;
  }
  
  .map-info {
    bottom: 10px;
    left: 10px;
    font-size: 10px;
  }
}
</style>
