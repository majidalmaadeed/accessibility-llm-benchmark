import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';

interface MapLocation {
  id: string;
  name: string;
  address: string;
  lat: number;
  lng: number;
  type: string;
  rating: number;
  description: string;
  category: string;
  price: number;
  hours: string;
  phone: string;
}

interface MapType {
  value: string;
  label: string;
  icon: string;
}

@Component({
  selector: 'app-interactive-map',
  templateUrl: './interactive-map.page.html',
  styleUrls: ['./interactive-map.page.scss'],
})
export class InteractiveMapPage implements OnInit {
  mapType = 'standard';
  zoomLevel = 10;
  centerLat = 37.7749;
  centerLng = -122.4194;
  searchQuery = '';
  searchResults: MapLocation[] = [];
  isLoading = false;
  showUserLocation = true;
  showMapControls = true;
  trafficEnabled = false;
  transitEnabled = false;
  bikeLanesEnabled = false;
  showSearchResults = false;
  showLocationDetails = false;
  showLayers = false;
  showBookmarks = false;
  selectedLocation: MapLocation | null = null;
  bookmarks: MapLocation[] = [];

  mapTypes: MapType[] = [
    { value: 'standard', label: 'Standard', icon: 'map' },
    { value: 'satellite', label: 'Satellite', icon: 'satellite' },
    { value: 'hybrid', label: 'Hybrid', icon: 'layers' },
    { value: 'terrain', label: 'Terrain', icon: 'terrain' }
  ];

  sampleLocations: MapLocation[] = [
    {
      id: '1',
      name: 'Golden Gate Bridge',
      address: 'Golden Gate Bridge, San Francisco, CA',
      lat: 37.8199,
      lng: -122.4783,
      type: 'landmark',
      rating: 4.8,
      description: 'Famous suspension bridge spanning the Golden Gate strait.',
      category: 'Tourist Attraction',
      price: 0,
      hours: '24/7',
      phone: '(415) 921-5858'
    },
    {
      id: '2',
      name: 'Fisherman\'s Wharf',
      address: 'Pier 39, San Francisco, CA',
      lat: 37.8087,
      lng: -122.4098,
      type: 'attraction',
      rating: 4.2,
      description: 'Popular tourist destination with shops, restaurants, and sea lions.',
      category: 'Shopping & Dining',
      price: 0,
      hours: '9:00 AM - 10:00 PM',
      phone: '(415) 705-5500'
    },
    {
      id: '3',
      name: 'Alcatraz Island',
      address: 'Alcatraz Island, San Francisco, CA',
      lat: 37.8270,
      lng: -122.4230,
      type: 'landmark',
      rating: 4.6,
      description: 'Former federal prison, now a popular tourist attraction.',
      category: 'Historical Site',
      price: 45,
      hours: '9:00 AM - 6:30 PM',
      phone: '(415) 561-4926'
    },
    {
      id: '4',
      name: 'Lombard Street',
      address: 'Lombard St, San Francisco, CA',
      lat: 37.8021,
      lng: -122.4187,
      type: 'landmark',
      rating: 4.3,
      description: 'Famous steep, winding street with eight hairpin turns.',
      category: 'Tourist Attraction',
      price: 0,
      hours: '24/7',
      phone: 'N/A'
    },
    {
      id: '5',
      name: 'Union Square',
      address: 'Union Square, San Francisco, CA',
      lat: 37.7880,
      lng: -122.4074,
      type: 'shopping',
      rating: 4.1,
      description: 'Major shopping and entertainment district in downtown San Francisco.',
      category: 'Shopping District',
      price: 0,
      hours: '10:00 AM - 9:00 PM',
      phone: 'N/A'
    }
  ];

  userLocation = {
    lat: 37.7749,
    lng: -122.4194
  };

  constructor(
    private alertController: AlertController,
    private modalController: ModalController
  ) {}

  ngOnInit() {
    // Initialize map
  }

  get coordinatesText(): string {
    return `${this.centerLat.toFixed(4)}, ${this.centerLng.toFixed(4)}`;
  }

  onSearchInput() {
    // Debounce search input
    setTimeout(() => {
      this.performSearch();
    }, 300);
  }

  onSearchClear() {
    this.searchQuery = '';
    this.searchResults = [];
    this.showSearchResults = false;
  }

  onSearchClicked() {
    this.performSearch();
  }

  async performSearch() {
    if (!this.searchQuery.trim()) {
      return;
    }

    this.isLoading = true;

    // Simulate API call
    setTimeout(() => {
      this.searchResults = this.sampleLocations.filter(location =>
        location.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        location.address.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        location.category.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      
      if (this.searchResults.length > 0) {
        this.showSearchResults = true;
      }
      
      this.isLoading = false;
    }, 1000);
  }

  onMapTypeChanged(type: string) {
    this.mapType = type;
  }

  onMarkerClicked(location: MapLocation) {
    this.centerLat = location.lat;
    this.centerLng = location.lng;
    this.selectedLocation = location;
    this.showLocationDetails = true;
  }

  onLocationSelected(location: MapLocation) {
    this.centerLat = location.lat;
    this.centerLng = location.lng;
    this.selectedLocation = location;
    this.showSearchResults = false;
    this.showLocationDetails = true;
  }

  onSearchResultsDismissed() {
    this.showSearchResults = false;
  }

  onLocationDetailsDismissed() {
    this.showLocationDetails = false;
  }

  async onGetDirections() {
    const alert = await this.alertController.create({
      header: 'Directions',
      message: 'Turn-by-turn directions would be displayed here',
      buttons: ['OK']
    });
    await alert.present();
  }

  async onBookmarkLocation() {
    if (!this.selectedLocation) return;

    const bookmark = { ...this.selectedLocation };
    this.bookmarks.push(bookmark);
    this.showLocationDetails = false;

    const alert = await this.alertController.create({
      header: 'Bookmarked',
      message: 'Location added to bookmarks',
      buttons: ['OK']
    });
    await alert.present();
  }

  onZoomInClicked() {
    this.zoomLevel = Math.min(this.zoomLevel + 1, 20);
  }

  onZoomOutClicked() {
    this.zoomLevel = Math.max(this.zoomLevel - 1, 1);
  }

  onCenterMapClicked() {
    this.centerLat = 37.7749;
    this.centerLng = -122.4194;
  }

  onLayersClicked() {
    this.showLayers = true;
  }

  onLayersDismissed() {
    this.showLayers = false;
  }

  onBookmarksClicked() {
    this.showBookmarks = true;
  }

  onBookmarksDismissed() {
    this.showBookmarks = false;
  }

  onBookmarkSelected(bookmark: MapLocation) {
    this.centerLat = bookmark.lat;
    this.centerLng = bookmark.lng;
    this.selectedLocation = bookmark;
    this.showBookmarks = false;
    this.showLocationDetails = true;
  }

  onRemoveBookmark(bookmarkId: string) {
    this.bookmarks = this.bookmarks.filter(bookmark => bookmark.id !== bookmarkId);
  }

  onControlsClicked() {
    this.showMapControls = !this.showMapControls;
  }

  getMarkerX(lng: number): number {
    // Convert longitude to percentage for display
    return ((lng + 122.5) / 0.5) * 100;
  }

  getMarkerY(lat: number): number {
    // Convert latitude to percentage for display
    return ((37.8 - lat) / 0.5) * 100;
  }

  getMarkerColor(type: string): string {
    switch (type) {
      case 'landmark': return '#FF6B6B';
      case 'attraction': return '#4ECDC4';
      case 'shopping': return '#45B7D1';
      case 'restaurant': return '#96CEB4';
      case 'hotel': return '#FFEAA7';
      default: return '#A29BFE';
    }
  }
}
