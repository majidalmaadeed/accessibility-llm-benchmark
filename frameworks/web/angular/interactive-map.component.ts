import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';

interface Marker {
  id: number;
  lat: number;
  lng: number;
  title: string;
  type: string;
  description: string;
}

interface MarkerType {
  color: string;
  icon: string;
}

interface MapStyle {
  id: string;
  name: string;
  preview: string;
}

@Component({
  selector: 'app-interactive-map',
  templateUrl: './interactive-map.component.html',
  styleUrls: ['./interactive-map.component.css']
})
export class InteractiveMapComponent implements OnInit {
  @ViewChild('mapRef', { static: false }) mapRef!: ElementRef<HTMLDivElement>;

  mapCenter: { lat: number; lng: number } = { lat: 40.7128, lng: -74.0060 };
  zoom: number = 10;
  markers: Marker[] = [
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
  ];
  selectedMarker: Marker | null = null;
  showInfoWindow: boolean = false;
  searchQuery: string = '';
  filteredMarkers: Marker[] = [];
  showLayers: boolean = false;
  activeLayers: { [key: string]: boolean } = {
    attractions: true,
    parks: true,
    monuments: true,
    buildings: true,
    entertainment: true,
    traffic: false,
    weather: false
  };
  showSearchOverlay: boolean = false;
  searchResults: Marker[] = [];
  isSearching: boolean = false;
  mapStyle: string = 'default';
  mapStyles: MapStyle[] = [
    { id: 'default', name: 'Default', preview: '🗺️' },
    { id: 'satellite', name: 'Satellite', preview: '🛰️' },
    { id: 'terrain', name: 'Terrain', preview: '🏔️' }
  ];
  markerTypes: { [key: string]: MarkerType } = {
    attraction: { color: '#4caf50', icon: '🎯' },
    park: { color: '#8bc34a', icon: '🌳' },
    monument: { color: '#ff9800', icon: '🏛️' },
    building: { color: '#2196f3', icon: '🏢' },
    entertainment: { color: '#9c27b0', icon: '🎭' }
  };

  constructor() { }

  ngOnInit(): void {
    this.filterMarkers();
  }

  filterMarkers(): void {
    this.filteredMarkers = this.markers.filter(marker => {
      const layerKey = marker.type === 'attraction' ? 'attractions' : 
                      marker.type === 'park' ? 'parks' :
                      marker.type === 'monument' ? 'monuments' :
                      marker.type === 'building' ? 'buildings' :
                      marker.type === 'entertainment' ? 'entertainment' : marker.type;
      return this.activeLayers[layerKey];
    });
  }

  handleMarkerClick(marker: Marker): void {
    this.selectedMarker = marker;
    this.showInfoWindow = true;
    this.mapCenter = { lat: marker.lat, lng: marker.lng };
    this.zoom = 15;
  }

  handleMapClick(event: MouseEvent): void {
    if (event.target === this.mapRef?.nativeElement) {
      this.showInfoWindow = false;
      this.selectedMarker = null;
    }
  }

  handleZoomIn(): void {
    this.zoom = Math.min(this.zoom + 1, 20);
  }

  handleZoomOut(): void {
    this.zoom = Math.max(this.zoom - 1, 1);
  }

  handleLayerToggle(layer: string): void {
    this.activeLayers[layer] = !this.activeLayers[layer];
  }

  async handleSearch(): Promise<void> {
    if (!this.searchQuery.trim()) return;

    this.isSearching = true;
    this.showSearchOverlay = true;

    setTimeout(() => {
      const results = this.markers.filter(marker =>
        marker.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        marker.description.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      this.searchResults = results;
      this.isSearching = false;
    }, 1000);
  }

  handleSearchResultClick(result: Marker): void {
    this.mapCenter = { lat: result.lat, lng: result.lng };
    this.zoom = 15;
    this.showSearchOverlay = false;
    this.searchQuery = '';
    this.searchResults = [];
  }

  addCustomMarker(event: MouseEvent): void {
    const rect = this.mapRef?.nativeElement?.getBoundingClientRect();
    if (!rect) return;

    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    
    const lat = this.mapCenter.lat + (rect.height / 2 - y) * (0.01 / this.zoom);
    const lng = this.mapCenter.lng + (x - rect.width / 2) * (0.01 / this.zoom);
    
    const newMarker: Marker = {
      id: Date.now(),
      lat,
      lng,
      title: 'Custom Location',
      type: 'attraction',
      description: 'User-added marker'
    };
    
    this.markers.push(newMarker);
  }

  removeMarker(markerId: number): void {
    this.markers = this.markers.filter(marker => marker.id !== markerId);
    if (this.selectedMarker && this.selectedMarker.id === markerId) {
      this.showInfoWindow = false;
      this.selectedMarker = null;
    }
  }

  getMarkerPosition(marker: Marker): { x: number; y: number } {
    const rect = this.mapRef?.nativeElement?.getBoundingClientRect();
    if (!rect) return { x: 0, y: 0 };
    
    const x = rect.width / 2 + (marker.lng - this.mapCenter.lng) * (this.zoom * 10);
    const y = rect.height / 2 - (marker.lat - this.mapCenter.lat) * (this.zoom * 10);
    
    return { x, y };
  }

  resetView(): void {
    this.mapCenter = { lat: 40.7128, lng: -74.0060 };
  }

  setDefaultZoom(): void {
    this.zoom = 10;
  }

  clearSelection(): void {
    this.showInfoWindow = false;
  }

  centerOnMarker(marker: Marker): void {
    this.mapCenter = { lat: marker.lat, lng: marker.lng };
  }

  onSearchQueryChange(): void {
    if (this.searchQuery.length > 2) {
      const filteredSuggestions = this.markers.filter(marker =>
        marker.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        marker.description.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      this.searchResults = filteredSuggestions.slice(0, 5);
      this.showSearchOverlay = true;
    } else {
      this.showSearchOverlay = false;
    }
  }

  getMarkerColor(marker: Marker): string {
    return this.markerTypes[marker.type]?.color || '#4caf50';
  }

  getMarkerIcon(marker: Marker): string {
    return this.markerTypes[marker.type]?.icon || '📍';
  }

  getLayerName(layer: string): string {
    return layer.charAt(0).toUpperCase() + layer.slice(1);
  }
}
