import SwiftUI
import MapKit

struct InteractiveMap: View {
    @State private var mapType: MapType = .standard
    @State private var zoomLevel: Double = 10
    @State private var centerLat = 37.7749
    @State private var centerLng = -122.4194
    @State private var searchQuery = ""
    @State private var searchResults: [MapLocation] = []
    @State private var isLoading = false
    @State private var showUserLocation = true
    @State private var showMapControls = true
    @State private var trafficEnabled = false
    @State private var transitEnabled = false
    @State private var bikeLanesEnabled = false
    @State private var showSearchResults = false
    @State private var showLocationDetails = false
    @State private var showLayers = false
    @State private var showBookmarks = false
    @State private var selectedLocation: MapLocation?
    @State private var bookmarks: [MapLocation] = []
    
    enum MapType: String, CaseIterable {
        case standard = "standard"
        case satellite = "satellite"
        case hybrid = "hybrid"
        case terrain = "terrain"
        
        var icon: String {
            switch self {
            case .standard: return "map"
            case .satellite: return "satellite"
            case .hybrid: return "layers"
            case .terrain: return "terrain"
            }
        }
    }
    
    private let sampleLocations = [
        MapLocation(
            id: "1",
            name: "Golden Gate Bridge",
            address: "Golden Gate Bridge, San Francisco, CA",
            lat: 37.8199,
            lng: -122.4783,
            type: "landmark",
            rating: 4.8,
            description: "Famous suspension bridge spanning the Golden Gate strait.",
            category: "Tourist Attraction",
            price: 0,
            hours: "24/7",
            phone: "(415) 921-5858"
        ),
        MapLocation(
            id: "2",
            name: "Fisherman's Wharf",
            address: "Pier 39, San Francisco, CA",
            lat: 37.8087,
            lng: -122.4098,
            type: "attraction",
            rating: 4.2,
            description: "Popular tourist destination with shops, restaurants, and sea lions.",
            category: "Shopping & Dining",
            price: 0,
            hours: "9:00 AM - 10:00 PM",
            phone: "(415) 705-5500"
        ),
        MapLocation(
            id: "3",
            name: "Alcatraz Island",
            address: "Alcatraz Island, San Francisco, CA",
            lat: 37.8270,
            lng: -122.4230,
            type: "landmark",
            rating: 4.6,
            description: "Former federal prison, now a popular tourist attraction.",
            category: "Historical Site",
            price: 45,
            hours: "9:00 AM - 6:30 PM",
            phone: "(415) 561-4926"
        ),
        MapLocation(
            id: "4",
            name: "Lombard Street",
            address: "Lombard St, San Francisco, CA",
            lat: 37.8021,
            lng: -122.4187,
            type: "landmark",
            rating: 4.3,
            description: "Famous steep, winding street with eight hairpin turns.",
            category: "Tourist Attraction",
            price: 0,
            hours: "24/7",
            phone: "N/A"
        ),
        MapLocation(
            id: "5",
            name: "Union Square",
            address: "Union Square, San Francisco, CA",
            lat: 37.7880,
            lng: -122.4074,
            type: "shopping",
            rating: 4.1,
            description: "Major shopping and entertainment district in downtown San Francisco.",
            category: "Shopping District",
            price: 0,
            hours: "10:00 AM - 9:00 PM",
            phone: "N/A"
        )
    ]
    
    private let userLocation = MapLocation(
        id: "user",
        name: "Your Location",
        address: "Current Location",
        lat: 37.7749,
        lng: -122.4194,
        type: "user",
        rating: 0,
        description: "Your current location",
        category: "User",
        price: 0,
        hours: "24/7",
        phone: "N/A"
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                searchBarView
                
                // Map Type Selector
                mapTypeSelectorView
                
                // Map Area
                mapAreaView
                
                // Bottom Controls
                bottomControlsView
            }
            .navigationTitle("Interactive Map")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showSearchResults) {
                SearchResultsView(
                    results: searchResults,
                    isPresented: $showSearchResults
                ) { location in
                    onLocationSelected(location)
                }
            }
            .sheet(isPresented: $showLocationDetails) {
                if let location = selectedLocation {
                    LocationDetailsView(
                        location: location,
                        isPresented: $showLocationDetails
                    ) {
                        onBookmarkLocation(location)
                    }
                }
            }
            .sheet(isPresented: $showLayers) {
                LayersView(
                    trafficEnabled: $trafficEnabled,
                    transitEnabled: $transitEnabled,
                    bikeLanesEnabled: $bikeLanesEnabled,
                    showUserLocation: $showUserLocation,
                    isPresented: $showLayers
                )
            }
            .sheet(isPresented: $showBookmarks) {
                BookmarksView(
                    bookmarks: $bookmarks,
                    isPresented: $showBookmarks
                ) { location in
                    onBookmarkSelected(location)
                }
            }
        }
    }
    
    private var searchBarView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search for places...", text: $searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        performSearch()
                    }
                
                if !searchQuery.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Button("Search") {
                performSearch()
            }
            .foregroundColor(.blue)
            .fontWeight(.semibold)
        }
        .padding()
    }
    
    private var mapTypeSelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(MapType.allCases, id: \.self) { type in
                    Button(action: { mapType = type }) {
                        HStack {
                            Image(systemName: type.icon)
                            Text(type.rawValue.capitalized)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(mapType == type ? Color.blue : Color(.systemGray5))
                        .foregroundColor(mapType == type ? .white : .primary)
                        .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
    
    private var mapAreaView: some View {
        ZStack {
            // Map Placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .overlay(
                    VStack {
                        Image(systemName: "map")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Interactive Map")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(coordinatesText)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Zoom: \(Int(zoomLevel))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                )
                .frame(height: 400)
            
            // Map Markers
            ForEach(sampleLocations, id: \.id) { location in
                MapMarkerView(location: location) {
                    onMarkerClicked(location)
                }
                .position(
                    x: getMarkerX(location.lng),
                    y: getMarkerY(location.lat)
                )
            }
            
            // User Location Marker
            if showUserLocation {
                UserLocationMarker()
                    .position(
                        x: getMarkerX(userLocation.lng),
                        y: getMarkerY(userLocation.lat)
                    )
            }
            
            // Map Controls
            if showMapControls {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Button(action: onZoomInClicked) {
                                Image(systemName: "plus")
                                    .font(.title3)
                            }
                            .frame(width: 40, height: 40)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 2)
                            
                            Button(action: onZoomOutClicked) {
                                Image(systemName: "minus")
                                    .font(.title3)
                            }
                            .frame(width: 40, height: 40)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 2)
                            
                            Button(action: onCenterMapClicked) {
                                Image(systemName: "location")
                                    .font(.title3)
                            }
                            .frame(width: 40, height: 40)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 2)
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
    
    private var bottomControlsView: some View {
        HStack {
            Button(action: { showLayers = true }) {
                VStack {
                    Image(systemName: "layers")
                    Text("Layers")
                        .font(.caption)
                }
            }
            .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: { showBookmarks = true }) {
                VStack {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                        .font(.caption)
                }
            }
            .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: { showMapControls.toggle() }) {
                VStack {
                    Image(systemName: "gearshape")
                    Text("Controls")
                        .font(.caption)
                }
            }
            .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
    }
    
    // MARK: - Computed Properties
    
    private var coordinatesText: String {
        String(format: "%.4f, %.4f", centerLat, centerLng)
    }
    
    // MARK: - Helper Methods
    
    private func getMarkerX(_ lng: Double) -> CGFloat {
        // Convert longitude to percentage for display
        let normalizedLng = (lng + 122.5) / 0.5
        return CGFloat(normalizedLng * 100)
    }
    
    private func getMarkerY(_ lat: Double) -> CGFloat {
        // Convert latitude to percentage for display
        let normalizedLat = (37.8 - lat) / 0.5
        return CGFloat(normalizedLat * 100)
    }
    
    private func getMarkerColor(_ type: String) -> Color {
        switch type {
        case "landmark": return .red
        case "attraction": return .teal
        case "shopping": return .blue
        case "restaurant": return .green
        case "hotel": return .yellow
        default: return .purple
        }
    }
    
    private func performSearch() {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            searchResults = sampleLocations.filter { location in
                location.name.localizedCaseInsensitiveContains(searchQuery) ||
                location.address.localizedCaseInsensitiveContains(searchQuery) ||
                location.category.localizedCaseInsensitiveContains(searchQuery)
            }
            
            if !searchResults.isEmpty {
                showSearchResults = true
            }
            
            isLoading = false
        }
    }
    
    private func clearSearch() {
        searchQuery = ""
        searchResults = []
        showSearchResults = false
    }
    
    // MARK: - Actions
    
    private func onMarkerClicked(_ location: MapLocation) {
        centerLat = location.lat
        centerLng = location.lng
        selectedLocation = location
        showLocationDetails = true
    }
    
    private func onLocationSelected(_ location: MapLocation) {
        centerLat = location.lat
        centerLng = location.lng
        selectedLocation = location
        showSearchResults = false
        showLocationDetails = true
    }
    
    private func onBookmarkLocation(_ location: MapLocation) {
        bookmarks.append(location)
        showLocationDetails = false
    }
    
    private func onBookmarkSelected(_ location: MapLocation) {
        centerLat = location.lat
        centerLng = location.lng
        selectedLocation = location
        showBookmarks = false
        showLocationDetails = true
    }
    
    private func onZoomInClicked() {
        zoomLevel = min(zoomLevel + 1, 20)
    }
    
    private func onZoomOutClicked() {
        zoomLevel = max(zoomLevel - 1, 1)
    }
    
    private func onCenterMapClicked() {
        centerLat = 37.7749
        centerLng = -122.4194
    }
}

// MARK: - Supporting Views

struct MapMarkerView: View {
    let location: MapLocation
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "mappin")
                .font(.title2)
                .foregroundColor(getMarkerColor(location.type))
                .background(
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: 32, height: 32)
                        .shadow(radius: 2)
                )
        }
    }
    
    private func getMarkerColor(_ type: String) -> Color {
        switch type {
        case "landmark": return .red
        case "attraction": return .teal
        case "shopping": return .blue
        case "restaurant": return .green
        case "hotel": return .yellow
        default: return .purple
        }
    }
}

struct UserLocationMarker: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .font(.title2)
            .foregroundColor(.blue)
            .background(
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 24, height: 24)
                    .shadow(radius: 2)
            )
    }
}

struct SearchResultsView: View {
    let results: [MapLocation]
    @Binding var isPresented: Bool
    let onLocationSelected: (MapLocation) -> Void
    
    var body: some View {
        NavigationView {
            List(results, id: \.id) { location in
                Button(action: {
                    onLocationSelected(location)
                }) {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(location.address)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Search Results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct LocationDetailsView: View {
    let location: MapLocation
    @Binding var isPresented: Bool
    let onBookmark: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(location.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(location.address)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", location.rating))
                                .fontWeight(.medium)
                        }
                    }
                }
                
                Section("Description") {
                    Text(location.description)
                }
                
                Section("Details") {
                    DetailRow(title: "Category", value: location.category)
                    DetailRow(title: "Hours", value: location.hours)
                    if location.price > 0 {
                        DetailRow(title: "Price", value: "$\(String(format: "%.0f", location.price))")
                    }
                    if location.phone != "N/A" {
                        DetailRow(title: "Phone", value: location.phone)
                    }
                }
            }
            .navigationTitle("Location Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Bookmark") {
                        onBookmark()
                    }
                }
            }
        }
    }
}

struct LayersView: View {
    @Binding var trafficEnabled: Bool
    @Binding var transitEnabled: Bool
    @Binding var bikeLanesEnabled: Bool
    @Binding var showUserLocation: Bool
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section("Map Layers") {
                    Toggle("Traffic", isOn: $trafficEnabled)
                    Toggle("Transit", isOn: $transitEnabled)
                    Toggle("Bike Lanes", isOn: $bikeLanesEnabled)
                    Toggle("User Location", isOn: $showUserLocation)
                }
            }
            .navigationTitle("Layers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct BookmarksView: View {
    @Binding var bookmarks: [MapLocation]
    @Binding var isPresented: Bool
    let onBookmarkSelected: (MapLocation) -> Void
    
    var body: some View {
        NavigationView {
            Group {
                if bookmarks.isEmpty {
                    VStack {
                        Image(systemName: "bookmark")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No bookmarks yet")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("Bookmark locations to see them here")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(bookmarks, id: \.id) { bookmark in
                        Button(action: {
                            onBookmarkSelected(bookmark)
                        }) {
                            HStack {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.blue)
                                VStack(alignment: .leading) {
                                    Text(bookmark.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(bookmark.address)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

// MARK: - Data Models

struct MapLocation: Identifiable {
    let id: String
    let name: String
    let address: String
    let lat: Double
    let lng: Double
    let type: String
    let rating: Double
    let description: String
    let category: String
    let price: Double
    let hours: String
    let phone: String
}

#Preview {
    InteractiveMap()
}