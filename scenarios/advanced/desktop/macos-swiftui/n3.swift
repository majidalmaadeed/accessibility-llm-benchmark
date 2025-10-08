import SwiftUI
import MapKit

struct InteractiveMap: View {
    @State private var allLocations: [MapLocation] = []
    @State private var searchResults: [MapLocation] = []
    @State private var bookmarks: [MapLocation] = []
    @State private var searchText = ""
    @State private var currentMapType = "Standard"
    @State private var currentZoom: Double = 10
    @State private var centerLat = 37.7749
    @State private var centerLng = -122.4194
    @State private var showUserLocation = true
    @State private var trafficEnabled = false
    @State private var transitEnabled = false
    @State private var bikeLanesEnabled = false
    @State private var selectedLocation: MapLocation?
    @State private var showingLayers = false
    @State private var showingBookmarks = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Search Bar
            searchBarView
            
            // Main Content
            HStack(spacing: 0) {
                // Map Area
                mapView
                
                // Side Panel
                sidePanelView
            }
            
            // Status Bar
            statusBarView
        }
        .onAppear {
            loadSampleData()
            setupMapMarkers()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Interactive Map")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 12) {
                Picker("Map Type", selection: $currentMapType) {
                    Text("Standard").tag("Standard")
                    Text("Satellite").tag("Satellite")
                    Text("Hybrid").tag("Hybrid")
                    Text("Terrain").tag("Terrain")
                }
                .pickerStyle(.menu)
                .frame(width: 140)
                
                Button("Layers") {
                    showingLayers = true
                }
                .buttonStyle(.bordered)
                
                Button("Bookmarks") {
                    showingBookmarks = true
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(20)
        .background(Color.accentColor)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search for places, addresses, or businesses...", text: $searchText)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        performSearch()
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
            
            Button("📍") {
                centerOnUserLocation()
            }
            .buttonStyle(.bordered)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
    
    private var mapView: some View {
        VStack(spacing: 0) {
            // Map
            Map(coordinateRegion: $region, annotationItems: allLocations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    MapMarker(
                        title: location.name,
                        subtitle: location.address,
                        tint: categoryColor(location.type)
                    )
                }
            }
            .onTapGesture { location in
                // Handle map tap
            }
            
            // Map Controls
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Button("+") {
                            zoomIn()
                        }
                        .buttonStyle(MapControlButtonStyle())
                        
                        Button("-") {
                            zoomOut()
                        }
                        .buttonStyle(MapControlButtonStyle())
                        
                        Button("⌂") {
                            centerOnUserLocation()
                        }
                        .buttonStyle(MapControlButtonStyle())
                    }
                    .padding(12)
                }
            }
            
            // Map Info
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🗺️ \(currentMapType) Map")
                            .font(.headline)
                        Text("\(String(format: "%.4f", centerLat)), \(String(format: "%.4f", centerLng))")
                            .font(.caption)
                        Text("Zoom: \(Int(currentZoom))")
                            .font(.caption)
                    }
                    .padding(12)
                    .background(Color(.controlBackgroundColor).opacity(0.9))
                    .cornerRadius(8)
                    
                    Spacer()
                }
                .padding(12)
                
                Spacer()
            }
        }
    }
    
    private var sidePanelView: some View {
        VStack(spacing: 16) {
            // Search Results
            searchResultsView
            
            // Location Details
            locationDetailsView
            
            // Quick Actions
            quickActionsView
        }
        .frame(width: 320)
        .padding(16)
        .background(Color(.controlBackgroundColor))
    }
    
    private var searchResultsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Search Results")
                .font(.headline)
                .fontWeight(.bold)
            
            if searchResults.isEmpty {
                Text("No search results")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(searchResults, id: \.id) { location in
                            SearchResultRow(location: location) {
                                selectedLocation = location
                            }
                        }
                    }
                }
                .frame(maxHeight: 160)
            }
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var locationDetailsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Location Details")
                .font(.headline)
                .fontWeight(.bold)
            
            if let location = selectedLocation {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(location.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(location.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            DetailRow(icon: "tag", text: "Type: \(location.type)")
                            DetailRow(icon: "star", text: "Rating: \(String(format: "%.1f/5", location.rating))")
                            DetailRow(icon: "dollarsign", text: "Price: \(location.price > 0 ? String(format: "$%.0f", location.price) : "Free")")
                            DetailRow(icon: "clock", text: "Hours: \(location.hours)")
                            
                            if location.phone != "N/A" {
                                DetailRow(icon: "phone", text: "Phone: \(location.phone)")
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
            } else {
                Text("Select a location to view details")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var quickActionsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quick Actions")
                .font(.headline)
                .fontWeight(.bold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                ActionButton(title: "Get Directions", icon: "arrow.triangle.turn.up.right.diamond") {
                    getDirections()
                }
                
                ActionButton(title: "Share", icon: "square.and.arrow.up") {
                    shareLocation()
                }
                
                ActionButton(title: "Save", icon: "bookmark") {
                    saveLocation()
                }
                
                ActionButton(title: "Report", icon: "exclamationmark.triangle") {
                    reportIssue()
                }
            }
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Ready")
            
            Spacer()
            
            Text("Lat: \(String(format: "%.4f", centerLat)), Lng: \(String(format: "%.4f", centerLng))")
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    // MARK: - Methods
    private func loadSampleData() {
        allLocations = [
            MapLocation(
                id: "1",
                name: "Golden Gate Bridge",
                address: "Golden Gate Bridge, San Francisco, CA",
                latitude: 37.8199,
                longitude: -122.4783,
                type: "landmark",
                rating: 4.8,
                description: "Famous suspension bridge spanning the Golden Gate strait.",
                category: "Tourist Attraction",
                price: 0.0,
                hours: "24/7",
                phone: "(415) 921-5858"
            ),
            MapLocation(
                id: "2",
                name: "Fisherman's Wharf",
                address: "Pier 39, San Francisco, CA",
                latitude: 37.8087,
                longitude: -122.4098,
                type: "attraction",
                rating: 4.2,
                description: "Popular tourist destination with shops, restaurants, and sea lions.",
                category: "Shopping & Dining",
                price: 0.0,
                hours: "9:00 AM - 10:00 PM",
                phone: "(415) 705-5500"
            ),
            MapLocation(
                id: "3",
                name: "Alcatraz Island",
                address: "Alcatraz Island, San Francisco, CA",
                latitude: 37.8270,
                longitude: -122.4230,
                type: "landmark",
                rating: 4.6,
                description: "Former federal prison, now a popular tourist attraction.",
                category: "Historical Site",
                price: 45.0,
                hours: "9:00 AM - 6:30 PM",
                phone: "(415) 561-4926"
            ),
            MapLocation(
                id: "4",
                name: "Lombard Street",
                address: "Lombard St, San Francisco, CA",
                latitude: 37.8021,
                longitude: -122.4187,
                type: "landmark",
                rating: 4.3,
                description: "Famous steep, winding street with eight hairpin turns.",
                category: "Tourist Attraction",
                price: 0.0,
                hours: "24/7",
                phone: "N/A"
            ),
            MapLocation(
                id: "5",
                name: "Union Square",
                address: "Union Square, San Francisco, CA",
                latitude: 37.7880,
                longitude: -122.4074,
                type: "shopping",
                rating: 4.1,
                description: "Major shopping and entertainment district in downtown San Francisco.",
                category: "Shopping District",
                price: 0.0,
                hours: "10:00 AM - 9:00 PM",
                phone: "N/A"
            )
        ]
    }
    
    private func setupMapMarkers() {
        // Map markers are automatically set up by the Map view
    }
    
    private func performSearch() {
        let query = searchText.lowercased()
        
        if query.isEmpty {
            searchResults = []
        } else {
            searchResults = allLocations.filter { location in
                location.name.lowercased().contains(query) ||
                location.address.lowercased().contains(query) ||
                location.category.lowercased().contains(query)
            }
        }
    }
    
    private func centerOnUserLocation() {
        centerLat = 37.7749
        centerLng = -122.4194
        currentZoom = 10
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLng),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    private func zoomIn() {
        currentZoom = min(currentZoom + 1, 20)
        region.span.latitudeDelta *= 0.8
        region.span.longitudeDelta *= 0.8
    }
    
    private func zoomOut() {
        currentZoom = max(currentZoom - 1, 1)
        region.span.latitudeDelta *= 1.2
        region.span.longitudeDelta *= 1.2
    }
    
    private func getDirections() {
        // Directions implementation
    }
    
    private func shareLocation() {
        // Share implementation
    }
    
    private func saveLocation() {
        if let location = selectedLocation {
            if !bookmarks.contains(where: { $0.id == location.id }) {
                bookmarks.append(location)
            }
        }
    }
    
    private func reportIssue() {
        // Report issue implementation
    }
    
    private func categoryColor(_ type: String) -> Color {
        switch type {
        case "landmark": return .red
        case "attraction": return .orange
        case "shopping": return .green
        case "restaurant": return .blue
        case "hotel": return .purple
        default: return .gray
        }
    }
}

// MARK: - Supporting Views
struct MapControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.primary)
            .frame(width: 32, height: 32)
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SearchResultRow: View {
    let location: MapLocation
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(location.address)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(location.category)
                .font(.caption)
                .foregroundColor(.accentColor)
        }
        .padding(8)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(6)
        .onTapGesture {
            onTap()
        }
    }
}

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 16)
            
            Text(text)
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Layers View
struct LayersView: View {
    @Binding var isPresented: Bool
    @Binding var trafficEnabled: Bool
    @Binding var transitEnabled: Bool
    @Binding var bikeLanesEnabled: Bool
    @Binding var userLocationEnabled: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Map Layers")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Traffic", isOn: $trafficEnabled)
                Toggle("Transit", isOn: $transitEnabled)
                Toggle("Bike Lanes", isOn: $bikeLanesEnabled)
                Toggle("User Location", isOn: $userLocationEnabled)
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Button("Apply") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 300, height: 200)
    }
}

// MARK: - Bookmarks View
struct BookmarksView: View {
    @Binding var isPresented: Bool
    let bookmarks: [MapLocation]
    let onSelect: (MapLocation) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Bookmarks")
                .font(.title)
                .fontWeight(.bold)
            
            if bookmarks.isEmpty {
                Text("No bookmarks yet.\nBookmark locations to see them here.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                List(bookmarks, id: \.id) { bookmark in
                    Button(bookmark.name) {
                        onSelect(bookmark)
                        isPresented = false
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack {
                Button("Close") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
        }
        .padding(20)
        .frame(width: 300, height: 400)
    }
}

// MARK: - Map Location Model
struct MapLocation: Identifiable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let type: String
    let rating: Double
    let description: String
    let category: String
    let price: Double
    let hours: String
    let phone: String
}

// MARK: - Preview
struct InteractiveMap_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveMap()
    }
}
