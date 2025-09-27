<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Interactive Map</h1>
      <p class="page-subtitle">
        Interactive map with markers and layers
      </p>
    </div>

    <div class="card">
      <div style="display: flex; gap: 1rem; margin-bottom: 1rem">
        <div style="flex: 1">
          <input
            type="text"
            class="form-control"
            placeholder="Search for a location..."
            v-model="searchLocation"
            @keypress.enter="searchForLocation"
          />
        </div>
        <button class="btn" @click="searchForLocation">
          Search
        </button>
        <button class="btn btn-secondary" @click="addMarker">
          Add Marker
        </button>
        <button class="btn btn-secondary" @click="showRouteModal = true">
          Plan Route
        </button>
        <button class="btn btn-secondary" @click="exportMapData">
          Export
        </button>
      </div>

      <div class="map-controls">
        <div style="display: flex; gap: 1rem; flexWrap: wrap">
          <label>
            <input
              type="checkbox"
              v-model="mapLayers.satellite"
            />
            Satellite View
          </label>
          <label>
            <input
              type="checkbox"
              v-model="mapLayers.traffic"
            />
            Traffic
          </label>
          <label>
            <input
              type="checkbox"
              v-model="mapLayers.weather"
            />
            Weather
          </label>
          <label>
            <input
              type="checkbox"
              v-model="mapLayers.points"
            />
            Points of Interest
          </label>
        </div>
      </div>
    </div>

    <div class="grid grid-2">
      <div class="card">
        <h2>Map</h2>
        <div class="map-container">
          <div style="
            height: 400px;
            background: linear-gradient(45deg, #e3f2fd 25%, #f5f5f5 25%, #f5f5f5 50%, #e3f2fd 50%, #e3f2fd 75%, #f5f5f5 75%);
            background-size: 20px 20px;
            position: relative;
            borderRadius: 8px;
            border: 1px solid #ddd;
            cursor: crosshair
          ">
            <div style="
              position: absolute;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
              color: #666;
              text-align: center
            ">
              <div style="font-size: 2rem; margin-bottom: 1rem">🗺️</div>
              <div>Interactive Map</div>
              <div style="font-size: 0.9rem; margin-top: 0.5rem">
                Click to add markers, drag to pan
              </div>
            </div>
            
            <div
              v-for="marker in markers"
              :key="marker.id"
              v-show="mapLayers.points"
              :style="{
                position: 'absolute',
                left: 50 + (marker.lng - mapCenter.lng) * 100 + '%',
                top: 50 - (marker.lat - mapCenter.lat) * 100 + '%',
                fontSize: '1.5rem',
                cursor: 'pointer',
                zIndex: 10
              }"
              @click="handleMarkerClick(marker)"
              :title="marker.title"
            >
              {{ getMarkerIcon(marker.type) }}
            </div>
            
            <div
              v-for="route in routes"
              :key="route.id"
              :style="{
                position: 'absolute',
                left: '50%',
                top: '50%',
                width: '2px',
                height: '100px',
                background: '#007bff',
                transform: 'translate(-50%, -50%) rotate(45deg)',
                zIndex: 5
              }"
            />
          </div>
          
          <div style="display: flex; justifyContent: space-between; alignItems: center; margin-top: 1rem">
            <div style="display: flex; gap: 0.5rem">
              <button 
                class="btn btn-secondary"
                @click="zoomLevel = Math.max(1, zoomLevel - 1)"
              >
                -
              </button>
              <span style="padding: 0.5rem 1rem; background: #f8f9fa; borderRadius: 4px">
                Zoom: {{ zoomLevel }}
              </span>
              <button 
                class="btn btn-secondary"
                @click="zoomLevel = Math.min(20, zoomLevel + 1)"
              >
                +
              </button>
            </div>
            <div style="fontSize: 0.9rem; color: #666">
              Center: {{ mapCenter.lat.toFixed(4) }}, {{ mapCenter.lng.toFixed(4) }}
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <h2>Markers & Routes</h2>
        <div style="max-height: 400px; overflow-y: auto">
          <div style="margin-bottom: 1rem">
            <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem">Markers ({{ markers.length }})</h3>
            <div
              v-for="marker in markers"
              :key="marker.id"
              style="display: flex; justifyContent: space-between; alignItems: center; padding: 0.5rem; borderBottom: 1px solid #eee"
            >
              <div>
                <div style="font-weight: 600">
                  {{ getMarkerIcon(marker.type) }} {{ marker.title }}
                </div>
                <div style="font-size: 0.9rem; color: #666">
                  {{ marker.lat.toFixed(4) }}, {{ marker.lng.toFixed(4) }}
                </div>
              </div>
              <button
                class="btn btn-secondary"
                @click="removeMarker(marker.id)"
                style="font-size: 0.8rem; padding: 0.25rem 0.5rem"
              >
                Remove
              </button>
            </div>
          </div>
          
          <div>
            <div style="display: flex; justifyContent: space-between; alignItems: center; margin-bottom: 0.5rem">
              <h3 style="font-size: 1.1rem; margin: 0">Routes ({{ routes.length }})</h3>
              <button
                class="btn btn-secondary"
                @click="clearRoutes"
                style="font-size: 0.8rem; padding: 0.25rem 0.5rem"
              >
                Clear All
              </button>
            </div>
            <div
              v-for="route in routes"
              :key="route.id"
              style="padding: 0.5rem; borderBottom: 1px solid #eee; fontSize: 0.9rem"
            >
              <div style="font-weight: 600">
                {{ route.start.title }} → {{ route.end.title }}
              </div>
              <div style="color: #666">
                Distance: {{ route.distance.toFixed(1) }} km | Duration: {{ route.duration.toFixed(0) }} min
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="selectedLocation" class="card">
      <h2>Location Details</h2>
      <div style="display: flex; justifyContent: space-between; alignItems: flex-start">
        <div>
          <h3 style="margin: 0 0 0.5rem 0">
            {{ selectedLocation.title || 'Selected Location' }}
          </h3>
          <p style="margin: 0 0 0.5rem 0; color: #666">
            {{ selectedLocation.description || 'No description available' }}
          </p>
          <div style="fontSize: 0.9rem; color: #666">
            Coordinates: {{ selectedLocation.lat?.toFixed(6) || 'N/A' }}, {{ selectedLocation.lng?.toFixed(6) || 'N/A' }}
          </div>
        </div>
        <button
          class="btn btn-secondary"
          @click="selectedLocation = null"
        >
          Close
        </button>
      </div>
    </div>

    <div v-if="showRouteModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Plan Route</h3>
          <button class="modal-close" @click="showRouteModal = false">
            ×
          </button>
        </div>
        <div class="form-group">
          <label class="form-label">Start Point</label>
          <select
            class="form-control"
            v-model="routeStart"
          >
            <option value="">Select start point</option>
            <option
              v-for="marker in markers"
              :key="marker.id"
              :value="marker.title"
            >
              {{ marker.title }}
            </option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">End Point</label>
          <select
            class="form-control"
            v-model="routeEnd"
          >
            <option value="">Select end point</option>
            <option
              v-for="marker in markers"
              :key="marker.id"
              :value="marker.title"
            >
              {{ marker.title }}
            </option>
          </select>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showRouteModal = false">
            Cancel
          </button>
          <button class="btn" @click="calculateRoute">
            Calculate Route
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
      selectedLocation: null,
      mapLayers: {
        satellite: false,
        traffic: false,
        weather: false,
        points: true
      },
      searchLocation: '',
      mapCenter: { lat: 40.7128, lng: -74.0060 },
      zoomLevel: 10,
      markers: [
        { id: 1, lat: 40.7589, lng: -73.9851, title: 'Central Park', type: 'park', description: 'Large public park in Manhattan' },
        { id: 2, lat: 40.7505, lng: -73.9934, title: 'Times Square', type: 'landmark', description: 'Famous commercial intersection' },
        { id: 3, lat: 40.6892, lng: -74.0445, title: 'Statue of Liberty', type: 'monument', description: 'Iconic symbol of freedom' },
        { id: 4, lat: 40.7614, lng: -73.9776, title: 'Museum of Modern Art', type: 'museum', description: 'World-renowned art museum' },
        { id: 5, lat: 40.7505, lng: -73.9934, title: 'Broadway Theater', type: 'entertainment', description: 'Historic theater district' }
      ],
      routes: [],
      showRouteModal: false,
      routeStart: '',
      routeEnd: ''
    }
  },
  methods: {
    handleMapClick(lat, lng) {
      this.selectedLocation = { lat, lng }
    },
    handleMarkerClick(marker) {
      this.selectedLocation = marker
    },
    toggleLayer(layer) {
      this.mapLayers[layer] = !this.mapLayers[layer]
    },
    searchForLocation() {
      if (this.searchLocation) {
        const mockResults = [
          { lat: 40.7128, lng: -74.0060, title: 'New York City' },
          { lat: 40.7589, lng: -73.9851, title: 'Central Park, New York' },
          { lat: 40.7505, lng: -73.9934, title: 'Times Square, New York' }
        ]
        
        const result = mockResults.find(r => 
          r.title.toLowerCase().includes(this.searchLocation.toLowerCase())
        )
        
        if (result) {
          this.mapCenter = result
          this.selectedLocation = result
        } else {
          alert('Location not found')
        }
      }
    },
    addMarker() {
      if (this.selectedLocation && !this.selectedLocation.id) {
        const newMarker = {
          id: Date.now(),
          lat: this.selectedLocation.lat,
          lng: this.selectedLocation.lng,
          title: `Marker ${this.markers.length + 1}`,
          type: 'custom',
          description: 'Custom marker'
        }
        this.markers.push(newMarker)
      }
    },
    removeMarker(markerId) {
      this.markers = this.markers.filter(m => m.id !== markerId)
    },
    calculateRoute() {
      if (this.routeStart && this.routeEnd) {
        const startMarker = this.markers.find(m => m.title.toLowerCase().includes(this.routeStart.toLowerCase()))
        const endMarker = this.markers.find(m => m.title.toLowerCase().includes(this.routeEnd.toLowerCase()))
        
        if (startMarker && endMarker) {
          const newRoute = {
            id: Date.now(),
            start: startMarker,
            end: endMarker,
            distance: Math.random() * 10 + 1,
            duration: Math.random() * 30 + 5
          }
          this.routes.push(newRoute)
          this.showRouteModal = false
          this.routeStart = ''
          this.routeEnd = ''
        } else {
          alert('Please select valid start and end points')
        }
      }
    },
    clearRoutes() {
      this.routes = []
    },
    exportMapData() {
      const data = {
        center: this.mapCenter,
        zoom: this.zoomLevel,
        markers: this.markers,
        routes: this.routes,
        layers: this.mapLayers
      }
      
      const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' })
      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'map-data.json'
      a.click()
      window.URL.revokeObjectURL(url)
    },
    getMarkerIcon(type) {
      const icons = {
        park: '🌳',
        landmark: '🏛️',
        monument: '🗽',
        museum: '🏛️',
        entertainment: '🎭',
        custom: '📍'
      }
      return icons[type] || '📍'
    }
  }
}
</script>
