import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Modal,
  Alert,
  Dimensions,
  TextInput,
  Switch,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width, height } = Dimensions.get('window');

const InteractiveMap = () => {
  const [mapType, setMapType] = useState('standard'); // standard, satellite, hybrid, terrain
  const [zoomLevel, setZoomLevel] = useState(10);
  const [centerLocation, setCenterLocation] = useState({ lat: 37.7749, lng: -122.4194 });
  const [selectedLocation, setSelectedLocation] = useState(null);
  const [showLocationDetails, setShowLocationDetails] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [showSearchResults, setShowSearchResults] = useState(false);
  const [trafficEnabled, setTrafficEnabled] = useState(false);
  const [transitEnabled, setTransitEnabled] = useState(false);
  const [bikeLanesEnabled, setBikeLanesEnabled] = useState(false);
  const [showLayers, setShowLayers] = useState(false);
  const [showDirections, setShowDirections] = useState(false);
  const [directions, setDirections] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [userLocation, setUserLocation] = useState(null);
  const [showUserLocation, setShowUserLocation] = useState(true);
  const [bookmarks, setBookmarks] = useState([]);
  const [showBookmarks, setShowBookmarks] = useState(false);
  const [showMapControls, setShowMapControls] = useState(true);

  const mapTypes = [
    { value: 'standard', label: 'Standard', icon: 'map' },
    { value: 'satellite', label: 'Satellite', icon: 'globe' },
    { value: 'hybrid', label: 'Hybrid', icon: 'layers' },
    { value: 'terrain', label: 'Terrain', icon: 'mountain' },
  ];

  const sampleLocations = [
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
      phone: '(415) 921-5858',
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
      phone: '(415) 705-5500',
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
      phone: '(415) 561-4926',
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
      phone: 'N/A',
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
      phone: 'N/A',
    },
  ];

  const sampleDirections = [
    {
      step: 1,
      instruction: 'Head north on Market St',
      distance: '0.2 mi',
      duration: '2 min',
      icon: 'arrow-forward',
    },
    {
      step: 2,
      instruction: 'Turn right onto California St',
      distance: '0.5 mi',
      duration: '3 min',
      icon: 'arrow-forward',
    },
    {
      step: 3,
      instruction: 'Continue straight onto Lombard St',
      distance: '1.2 mi',
      duration: '8 min',
      icon: 'arrow-forward',
    },
    {
      step: 4,
      instruction: 'Arrive at destination',
      distance: '0 mi',
      duration: '0 min',
      icon: 'location',
    },
  ];

  useEffect(() => {
    // Simulate getting user location
    setTimeout(() => {
      setUserLocation({ lat: 37.7749, lng: -122.4194 });
    }, 1000);
  }, []);

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;

    setIsLoading(true);
    setShowSearchResults(true);

    // Simulate API call
    setTimeout(() => {
      const results = sampleLocations.filter(location =>
        location.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        location.address.toLowerCase().includes(searchQuery.toLowerCase()) ||
        location.category.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setSearchResults(results);
      setIsLoading(false);
    }, 1000);
  };

  const handleLocationSelect = (location) => {
    setSelectedLocation(location);
    setCenterLocation({ lat: location.lat, lng: location.lng });
    setShowSearchResults(false);
    setSearchQuery('');
  };

  const handleMapPress = (lat, lng) => {
    // Simulate getting location info from coordinates
    const mockLocation = {
      id: 'temp',
      name: 'Selected Location',
      address: `${lat.toFixed(4)}, ${lng.toFixed(4)}`,
      lat: lat,
      lng: lng,
      type: 'custom',
      rating: 0,
      description: 'Location selected on map',
      category: 'Custom Location',
      price: 0,
      hours: 'N/A',
      phone: 'N/A',
    };
    setSelectedLocation(mockLocation);
    setShowLocationDetails(true);
  };

  const handleGetDirections = () => {
    if (!selectedLocation) {
      Alert.alert('No Location Selected', 'Please select a location first');
      return;
    }
    setDirections(sampleDirections);
    setShowDirections(true);
  };

  const handleBookmarkLocation = () => {
    if (!selectedLocation) return;

    const bookmark = {
      id: Date.now().toString(),
      ...selectedLocation,
      dateAdded: new Date().toISOString(),
    };

    setBookmarks(prev => [...prev, bookmark]);
    Alert.alert('Bookmarked', 'Location added to bookmarks');
  };

  const handleRemoveBookmark = (bookmarkId) => {
    setBookmarks(prev => prev.filter(bookmark => bookmark.id !== bookmarkId));
  };

  const renderMapArea = () => (
    <View style={styles.mapContainer}>
      {/* Simulated Map View */}
      <View style={styles.mapView}>
        <Text style={styles.mapPlaceholder}>🗺️ Interactive Map</Text>
        <Text style={styles.mapCoordinates}>
          {centerLocation.lat.toFixed(4)}, {centerLocation.lng.toFixed(4)}
        </Text>
        <Text style={styles.mapZoom}>Zoom: {zoomLevel}</Text>
        
        {/* Simulated Map Markers */}
        {sampleLocations.map((location) => (
          <TouchableOpacity
            key={location.id}
            style={[
              styles.mapMarker,
              {
                left: (location.lng + 122.5) * 200,
                top: (37.8 - location.lat) * 200,
              },
            ]}
            onPress={() => handleLocationSelect(location)}
          >
            <View style={[
              styles.markerPin,
              { backgroundColor: getMarkerColor(location.type) }
            ]}>
              <Ionicons name="location" size={16} color="#fff" />
            </View>
          </TouchableOpacity>
        ))}

        {/* User Location Marker */}
        {userLocation && showUserLocation && (
          <View
            style={[
              styles.userLocationMarker,
              {
                left: (userLocation.lng + 122.5) * 200,
                top: (37.8 - userLocation.lat) * 200,
              },
            ]}
          >
            <View style={styles.userLocationPin}>
              <Ionicons name="person" size={12} color="#fff" />
            </View>
          </View>
        )}
      </View>

      {/* Map Controls */}
      {showMapControls && (
        <View style={styles.mapControls}>
          <TouchableOpacity
            style={styles.controlButton}
            onPress={() => setZoomLevel(prev => Math.min(prev + 1, 20))}
          >
            <Ionicons name="add" size={20} color="#333" />
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.controlButton}
            onPress={() => setZoomLevel(prev => Math.max(prev - 1, 1))}
          >
            <Ionicons name="remove" size={20} color="#333" />
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.controlButton}
            onPress={() => setCenterLocation({ lat: 37.7749, lng: -122.4194 })}
          >
            <Ionicons name="locate" size={20} color="#333" />
          </TouchableOpacity>
        </View>
      )}
    </View>
  );

  const getMarkerColor = (type) => {
    switch (type) {
      case 'landmark': return '#FF6B6B';
      case 'attraction': return '#4ECDC4';
      case 'shopping': return '#45B7D1';
      case 'restaurant': return '#96CEB4';
      case 'hotel': return '#FFEAA7';
      default: return '#A29BFE';
    }
  };

  const renderSearchBar = () => (
    <View style={styles.searchContainer}>
      <View style={styles.searchInputContainer}>
        <Ionicons name="search" size={20} color="#666" style={styles.searchIcon} />
        <TextInput
          style={styles.searchInput}
          placeholder="Search for places..."
          value={searchQuery}
          onChangeText={setSearchQuery}
          onSubmitEditing={handleSearch}
          placeholderTextColor="#999"
        />
        {searchQuery.length > 0 && (
          <TouchableOpacity
            onPress={() => {
              setSearchQuery('');
              setShowSearchResults(false);
            }}
            style={styles.clearButton}
          >
            <Ionicons name="close-circle" size={20} color="#666" />
          </TouchableOpacity>
        )}
      </View>
      
      <TouchableOpacity
        style={styles.searchButton}
        onPress={handleSearch}
      >
        <Ionicons name="search" size={20} color="#fff" />
      </TouchableOpacity>
    </View>
  );

  const renderSearchResults = () => (
    <Modal
      visible={showSearchResults}
      animationType="slide"
      onRequestClose={() => setShowSearchResults(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <Text style={styles.modalTitle}>Search Results</Text>
          <TouchableOpacity onPress={() => setShowSearchResults(false)}>
            <Ionicons name="close" size={24} color="#666" />
          </TouchableOpacity>
        </View>
        
        <ScrollView style={styles.searchResultsList}>
          {isLoading ? (
            <View style={styles.loadingContainer}>
              <Text style={styles.loadingText}>Searching...</Text>
            </View>
          ) : (
            searchResults.map((location) => (
              <TouchableOpacity
                key={location.id}
                style={styles.searchResultItem}
                onPress={() => handleLocationSelect(location)}
              >
                <View style={styles.searchResultIcon}>
                  <Ionicons name="location" size={20} color="#007AFF" />
                </View>
                <View style={styles.searchResultContent}>
                  <Text style={styles.searchResultName}>{location.name}</Text>
                  <Text style={styles.searchResultAddress}>{location.address}</Text>
                  <Text style={styles.searchResultCategory}>{location.category}</Text>
                </View>
                <Ionicons name="chevron-forward" size={20} color="#ccc" />
              </TouchableOpacity>
            ))
          )}
        </ScrollView>
      </View>
    </Modal>
  );

  const renderLocationDetails = () => (
    <Modal
      visible={showLocationDetails}
      animationType="slide"
      onRequestClose={() => setShowLocationDetails(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <Text style={styles.modalTitle}>Location Details</Text>
          <TouchableOpacity onPress={() => setShowLocationDetails(false)}>
            <Ionicons name="close" size={24} color="#666" />
          </TouchableOpacity>
        </View>
        
        {selectedLocation && (
          <ScrollView style={styles.locationDetailsContent}>
            <View style={styles.locationHeader}>
              <Text style={styles.locationName}>{selectedLocation.name}</Text>
              <View style={styles.locationRating}>
                <Ionicons name="star" size={16} color="#FFD700" />
                <Text style={styles.ratingText}>{selectedLocation.rating}</Text>
              </View>
            </View>
            
            <Text style={styles.locationAddress}>{selectedLocation.address}</Text>
            <Text style={styles.locationDescription}>{selectedLocation.description}</Text>
            
            <View style={styles.locationInfo}>
              <View style={styles.infoItem}>
                <Ionicons name="folder" size={16} color="#666" />
                <Text style={styles.infoText}>{selectedLocation.category}</Text>
              </View>
              
              {selectedLocation.price > 0 && (
                <View style={styles.infoItem}>
                  <Ionicons name="card" size={16} color="#666" />
                  <Text style={styles.infoText}>${selectedLocation.price}</Text>
                </View>
              )}
              
              <View style={styles.infoItem}>
                <Ionicons name="time" size={16} color="#666" />
                <Text style={styles.infoText}>{selectedLocation.hours}</Text>
              </View>
              
              {selectedLocation.phone !== 'N/A' && (
                <View style={styles.infoItem}>
                  <Ionicons name="call" size={16} color="#666" />
                  <Text style={styles.infoText}>{selectedLocation.phone}</Text>
                </View>
              )}
            </View>
            
            <View style={styles.locationActions}>
              <TouchableOpacity
                style={styles.actionButton}
                onPress={handleGetDirections}
              >
                <Ionicons name="navigate" size={20} color="#007AFF" />
                <Text style={styles.actionButtonText}>Directions</Text>
              </TouchableOpacity>
              
              <TouchableOpacity
                style={styles.actionButton}
                onPress={handleBookmarkLocation}
              >
                <Ionicons name="bookmark" size={20} color="#007AFF" />
                <Text style={styles.actionButtonText}>Bookmark</Text>
              </TouchableOpacity>
              
              <TouchableOpacity
                style={styles.actionButton}
                onPress={() => Alert.alert('Share', 'Share location functionality')}
              >
                <Ionicons name="share" size={20} color="#007AFF" />
                <Text style={styles.actionButtonText}>Share</Text>
              </TouchableOpacity>
            </View>
          </ScrollView>
        )}
      </View>
    </Modal>
  );

  const renderDirections = () => (
    <Modal
      visible={showDirections}
      animationType="slide"
      onRequestClose={() => setShowDirections(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <Text style={styles.modalTitle}>Directions</Text>
          <TouchableOpacity onPress={() => setShowDirections(false)}>
            <Ionicons name="close" size={24} color="#666" />
          </TouchableOpacity>
        </View>
        
        <ScrollView style={styles.directionsContent}>
          {directions.map((step, index) => (
            <View key={index} style={styles.directionStep}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>{step.step}</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepInstruction}>{step.instruction}</Text>
                <View style={styles.stepMeta}>
                  <Text style={styles.stepDistance}>{step.distance}</Text>
                  <Text style={styles.stepDuration}>{step.duration}</Text>
                </View>
              </View>
              <Ionicons name={step.icon} size={20} color="#007AFF" />
            </View>
          ))}
        </ScrollView>
      </View>
    </Modal>
  );

  const renderLayersPanel = () => (
    <Modal
      visible={showLayers}
      animationType="slide"
      onRequestClose={() => setShowLayers(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <Text style={styles.modalTitle}>Map Layers</Text>
          <TouchableOpacity onPress={() => setShowLayers(false)}>
            <Ionicons name="close" size={24} color="#666" />
          </TouchableOpacity>
        </View>
        
        <View style={styles.layersContent}>
          <View style={styles.layerItem}>
            <Text style={styles.layerLabel}>Traffic</Text>
            <Switch
              value={trafficEnabled}
              onValueChange={setTrafficEnabled}
            />
          </View>
          
          <View style={styles.layerItem}>
            <Text style={styles.layerLabel}>Transit</Text>
            <Switch
              value={transitEnabled}
              onValueChange={setTransitEnabled}
            />
          </View>
          
          <View style={styles.layerItem}>
            <Text style={styles.layerLabel}>Bike Lanes</Text>
            <Switch
              value={bikeLanesEnabled}
              onValueChange={setBikeLanesEnabled}
            />
          </View>
          
          <View style={styles.layerItem}>
            <Text style={styles.layerLabel}>User Location</Text>
            <Switch
              value={showUserLocation}
              onValueChange={setShowUserLocation}
            />
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderMapTypeSelector = () => (
    <View style={styles.mapTypeContainer}>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        {mapTypes.map((type) => (
          <TouchableOpacity
            key={type.value}
            style={[
              styles.mapTypeButton,
              mapType === type.value && styles.mapTypeButtonActive,
            ]}
            onPress={() => setMapType(type.value)}
          >
            <Ionicons
              name={type.icon}
              size={20}
              color={mapType === type.value ? '#fff' : '#666'}
            />
            <Text
              style={[
                styles.mapTypeText,
                mapType === type.value && styles.mapTypeTextActive,
              ]}
            >
              {type.label}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );

  const renderBottomControls = () => (
    <View style={styles.bottomControls}>
      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowLayers(true)}
      >
        <Ionicons name="layers" size={20} color="#333" />
        <Text style={styles.controlButtonText}>Layers</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowBookmarks(true)}
      >
        <Ionicons name="bookmark" size={20} color="#333" />
        <Text style={styles.controlButtonText}>Bookmarks</Text>
      </TouchableOpacity>
      
      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowMapControls(!showMapControls)}
      >
        <Ionicons name="settings" size={20} color="#333" />
        <Text style={styles.controlButtonText}>Controls</Text>
      </TouchableOpacity>
    </View>
  );

  return (
    <View style={styles.container}>
      {renderSearchBar()}
      {renderMapTypeSelector()}
      {renderMapArea()}
      {renderBottomControls()}
      {renderSearchResults()}
      {renderLocationDetails()}
      {renderDirections()}
      {renderLayersPanel()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  searchContainer: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
    gap: 12,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    paddingHorizontal: 12,
  },
  searchIcon: {
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    paddingVertical: 12,
    fontSize: 16,
    color: '#333',
  },
  clearButton: {
    padding: 4,
  },
  searchButton: {
    backgroundColor: '#007AFF',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  mapTypeContainer: {
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
    paddingVertical: 8,
  },
  mapTypeButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    marginHorizontal: 4,
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    gap: 6,
  },
  mapTypeButtonActive: {
    backgroundColor: '#007AFF',
  },
  mapTypeText: {
    fontSize: 14,
    color: '#666',
  },
  mapTypeTextActive: {
    color: '#fff',
  },
  mapContainer: {
    flex: 1,
    position: 'relative',
  },
  mapView: {
    flex: 1,
    backgroundColor: '#e8f4f8',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  mapPlaceholder: {
    fontSize: 24,
    color: '#666',
    marginBottom: 8,
  },
  mapCoordinates: {
    fontSize: 14,
    color: '#999',
    marginBottom: 4,
  },
  mapZoom: {
    fontSize: 12,
    color: '#999',
  },
  mapMarker: {
    position: 'absolute',
    width: 24,
    height: 24,
  },
  markerPin: {
    width: 24,
    height: 24,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  userLocationMarker: {
    position: 'absolute',
    width: 20,
    height: 20,
  },
  userLocationPin: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#fff',
  },
  mapControls: {
    position: 'absolute',
    right: 16,
    top: 16,
    gap: 8,
  },
  controlButton: {
    width: 40,
    height: 40,
    backgroundColor: '#fff',
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 4,
  },
  bottomControls: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    paddingVertical: 12,
    paddingHorizontal: 16,
    justifyContent: 'space-around',
  },
  controlButtonText: {
    fontSize: 12,
    color: '#333',
    marginTop: 4,
  },
  modalContainer: {
    flex: 1,
    backgroundColor: '#fff',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  searchResultsList: {
    flex: 1,
  },
  searchResultItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  searchResultIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  searchResultContent: {
    flex: 1,
  },
  searchResultName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  searchResultAddress: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  searchResultCategory: {
    fontSize: 12,
    color: '#999',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
  },
  locationDetailsContent: {
    flex: 1,
    padding: 16,
  },
  locationHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 8,
  },
  locationName: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
  },
  locationRating: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  ratingText: {
    fontSize: 16,
    color: '#333',
  },
  locationAddress: {
    fontSize: 16,
    color: '#666',
    marginBottom: 12,
  },
  locationDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
    marginBottom: 16,
  },
  locationInfo: {
    gap: 8,
    marginBottom: 24,
  },
  infoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  infoText: {
    fontSize: 14,
    color: '#666',
  },
  locationActions: {
    flexDirection: 'row',
    gap: 12,
  },
  actionButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    gap: 6,
  },
  actionButtonText: {
    fontSize: 14,
    color: '#007AFF',
    fontWeight: '500',
  },
  directionsContent: {
    flex: 1,
    padding: 16,
  },
  directionStep: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 16,
    gap: 12,
  },
  stepNumber: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
  },
  stepNumberText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: 'bold',
  },
  stepContent: {
    flex: 1,
  },
  stepInstruction: {
    fontSize: 16,
    color: '#333',
    marginBottom: 4,
  },
  stepMeta: {
    flexDirection: 'row',
    gap: 16,
  },
  stepDistance: {
    fontSize: 12,
    color: '#666',
  },
  stepDuration: {
    fontSize: 12,
    color: '#666',
  },
  layersContent: {
    padding: 16,
  },
  layerItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  layerLabel: {
    fontSize: 16,
    color: '#333',
  },
});

export default InteractiveMap;
