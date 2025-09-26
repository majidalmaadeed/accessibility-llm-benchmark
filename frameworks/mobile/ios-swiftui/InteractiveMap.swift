import SwiftUI
import MapKit

struct InteractiveMap: View {
    @State private var searchQuery: String = ""
    @State private var mapView: MapViewType = .standard
    @State private var activeLayers: Set<MapLayer> = [.restaurants, .hotels, .attractions]
    @State private var selectedCategory: String = "All"
    @State private var selectedDistance: Double = 10.0
    @State private var selectedRating: Double = 0.0
    @State private var selectedLocation: MapLocation? = nil
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var zoomLevel: Double = 1.0
    @State private var showFilters: Bool = false
    @State private var showLocationDetails: Bool = false
    @State private var isLoading: Bool = false
    
    let mapLayers: [MapLayer] = [.restaurants, .hotels, .attractions, .gasStations, .hospitals, .schools]
    let categories = ["All", "Restaurants", "Hotels", "Attractions", "Shopping", "Entertainment"]
    let mapViewTypes: [MapViewType] = [.standard, .satellite, .hybrid]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                searchView
                
                if showFilters {
                    filtersView
                }
                
                mapView
                
                if showLocationDetails, let location = selectedLocation {
                    locationDetailsView(location)
                }
            }
            .navigationTitle("Interactive Map")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Interactive Map")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: showFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { centerOnCurrentLocation() }) {
                        Image(systemName: "location")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { resetView() }) {
                        Image(systemName: "house")
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            HStack {
                Text("Map View")
                    .font(.headline)
                
                Spacer()
                
                Picker("Map View", selection: $mapView) {
                    ForEach(mapViewTypes, id: \.self) { viewType in
                        Text(viewType.displayName).tag(viewType)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
    }
    
    private var searchView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search locations...", text: $searchQuery)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        searchLocation()
                    }
                
                if !searchQuery.isEmpty {
                    Button(action: { clearSearch() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            Button(action: { searchLocation() }) {
                Text("Search")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .disabled(searchQuery.isEmpty)
        }
        .padding(.horizontal)
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Map Layers")
                    .font(.headline)
                Spacer()
                Button("Clear All") {
                    activeLayers.removeAll()
                }
                .buttonStyle(.bordered)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(mapLayers, id: \.self) { layer in
                    LayerToggle(
                        layer: layer,
                        isActive: activeLayers.contains(layer)
                    ) {
                        toggleLayer(layer)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Category")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Distance: \(String(format: "%.1f", selectedDistance)) miles")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Slider(value: $selectedDistance, in: 1...50, step: 1)
                    .accentColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Minimum Rating: \(selectedRating > 0 ? String(format: "%.1f", selectedRating) : "Any")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Slider(value: $selectedRating, in: 0...5, step: 0.5)
                    .accentColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var mapView: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: visibleLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    MapMarker(
                        location: location,
                        isSelected: selectedLocation?.id == location.id
                    ) {
                        selectLocation(location)
                    }
                }
            }
            .mapStyle(mapStyle)
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Button(action: { zoomIn() }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.bordered)
                        .frame(width: 44, height: 44)
                        
                        Button(action: { zoomOut() }) {
                            Image(systemName: "minus")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.bordered)
                        .frame(width: 44, height: 44)
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Lat: \(String(format: "%.4f", region.center.latitude))")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text("Lng: \(String(format: "%.4f", region.center.longitude))")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text("Zoom: \(String(format: "%.1f", zoomLevel))x")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    
                    Spacer()
                }
            }
            .padding()
        }
        .onTapGesture { location in
            handleMapTap(at: location)
        }
    }
    
    private func locationDetailsView(_ location: MapLocation) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(location.category)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: { showLocationDetails = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.blue)
                    Text(location.address)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(String(format: "%.1f", location.rating))/5")
                        .font(.subheadline)
                    Text("(\(location.reviewCount) reviews)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text(location.hours)
                        .font(.subheadline)
                }
                
                if !location.phone.isEmpty {
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.blue)
                        Text(location.phone)
                            .font(.subheadline)
                    }
                }
            }
            
            HStack(spacing: 12) {
                Button("Get Directions") {
                    getDirections(to: location)
                }
                .buttonStyle(.borderedProminent)
                
                Button("Call") {
                    callLocation(location)
                }
                .buttonStyle(.bordered)
                
                Button("Share") {
                    shareLocation(location)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding()
    }
    
    // MARK: - Computed Properties
    
    private var mapStyle: MapStyle {
        switch mapView {
        case .standard:
            return .standard
        case .satellite:
            return .satellite
        case .hybrid:
            return .hybrid
        }
    }
    
    private var visibleLocations: [MapLocation] {
        sampleLocations.filter { location in
            activeLayers.contains(location.layer) &&
            (selectedCategory == "All" || location.category == selectedCategory) &&
            location.rating >= selectedRating
        }
    }
    
    private var sampleLocations: [MapLocation] {
        [
            MapLocation(
                id: UUID(),
                name: "Central Park",
                address: "Central Park, New York, NY 10024",
                category: "Attractions",
                rating: 4.8,
                reviewCount: 1250,
                coordinate: CLLocationCoordinate2D(latitude: 40.7829, longitude: -73.9654),
                layer: .attractions,
                phone: "(212) 310-6600",
                hours: "6:00 AM - 1:00 AM"
            ),
            MapLocation(
                id: UUID(),
                name: "The Plaza Hotel",
                address: "768 5th Ave, New York, NY 10019",
                category: "Hotels",
                rating: 4.6,
                reviewCount: 890,
                coordinate: CLLocationCoordinate2D(latitude: 40.7648, longitude: -73.9748),
                layer: .hotels,
                phone: "(212) 759-3000",
                hours: "24/7"
            ),
            MapLocation(
                id: UUID(),
                name: "Joe's Pizza",
                address: "7 Carmine St, New York, NY 10014",
                category: "Restaurants",
                rating: 4.4,
                reviewCount: 567,
                coordinate: CLLocationCoordinate2D(latitude: 40.7306, longitude: -74.0023),
                layer: .restaurants,
                phone: "(212) 366-1182",
                hours: "10:00 AM - 2:00 AM"
            ),
            MapLocation(
                id: UUID(),
                name: "Times Square",
                address: "Times Square, New York, NY 10036",
                category: "Attractions",
                rating: 4.2,
                reviewCount: 2100,
                coordinate: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855),
                layer: .attractions,
                phone: "(212) 768-1560",
                hours: "24/7"
            ),
            MapLocation(
                id: UUID(),
                name: "Brooklyn Bridge",
                address: "Brooklyn Bridge, New York, NY 10038",
                category: "Attractions",
                rating: 4.7,
                reviewCount: 980,
                coordinate: CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969),
                layer: .attractions,
                phone: "N/A",
                hours: "24/7"
            )
        ]
    }
    
    // MARK: - Methods
    
    private func searchLocation() {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let foundLocation = sampleLocations.first(where: { 
                $0.name.localizedCaseInsensitiveContains(searchQuery) 
            }) {
                selectLocation(foundLocation)
                centerOnLocation(foundLocation)
            }
            isLoading = false
        }
    }
    
    private func clearSearch() {
        searchQuery = ""
    }
    
    private func toggleLayer(_ layer: MapLayer) {
        if activeLayers.contains(layer) {
            activeLayers.remove(layer)
        } else {
            activeLayers.insert(layer)
        }
    }
    
    private func selectLocation(_ location: MapLocation) {
        selectedLocation = location
        showLocationDetails = true
    }
    
    private func centerOnLocation(_ location: MapLocation) {
        withAnimation(.easeInOut(duration: 1.0)) {
            region.center = location.coordinate
            region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        }
    }
    
    private func centerOnCurrentLocation() {
        // Center on current location
        withAnimation(.easeInOut(duration: 1.0)) {
            region.center = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
            region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        }
    }
    
    private func resetView() {
        withAnimation(.easeInOut(duration: 1.0)) {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            zoomLevel = 1.0
            selectedLocation = nil
            showLocationDetails = false
        }
    }
    
    private func zoomIn() {
        withAnimation(.easeInOut(duration: 0.3)) {
            region.span.latitudeDelta *= 0.5
            region.span.longitudeDelta *= 0.5
            zoomLevel *= 2
        }
    }
    
    private func zoomOut() {
        withAnimation(.easeInOut(duration: 0.3)) {
            region.span.latitudeDelta *= 2
            region.span.longitudeDelta *= 2
            zoomLevel *= 0.5
        }
    }
    
    private func handleMapTap(at location: CGPoint) {
        selectedLocation = nil
        showLocationDetails = false
    }
    
    private func getDirections(to location: MapLocation) {
        // Open directions in Maps app
        print("Getting directions to \(location.name)")
    }
    
    private func callLocation(_ location: MapLocation) {
        if !location.phone.isEmpty {
            print("Calling \(location.phone)")
        }
    }
    
    private func shareLocation(_ location: MapLocation) {
        print("Sharing \(location.name)")
    }
}

// MARK: - Supporting Views

struct MapMarker: View {
    let location: MapLocation
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(markerColor)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.blue : Color.white, lineWidth: 2)
                    )
                
                Image(systemName: location.icon)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
            }
            
            if isSelected {
                Text(location.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(8)
            }
        }
        .onTapGesture {
            onTap()
        }
    }
    
    private var markerColor: Color {
        switch location.layer {
        case .restaurants: return .orange
        case .hotels: return .blue
        case .attractions: return .green
        case .gasStations: return .red
        case .hospitals: return .pink
        case .schools: return .purple
        }
    }
}

struct LayerToggle: View {
    let layer: MapLayer
    let isActive: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: layer.icon)
                    .foregroundColor(isActive ? .white : .blue)
                
                Text(layer.displayName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(isActive ? .white : .primary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isActive ? Color.blue : Color(.systemGray5))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Supporting Types

enum MapViewType: CaseIterable {
    case standard, satellite, hybrid
    
    var displayName: String {
        switch self {
        case .standard: return "Standard"
        case .satellite: return "Satellite"
        case .hybrid: return "Hybrid"
        }
    }
}

enum MapLayer: CaseIterable, Hashable {
    case restaurants, hotels, attractions, gasStations, hospitals, schools
    
    var displayName: String {
        switch self {
        case .restaurants: return "Restaurants"
        case .hotels: return "Hotels"
        case .attractions: return "Attractions"
        case .gasStations: return "Gas Stations"
        case .hospitals: return "Hospitals"
        case .schools: return "Schools"
        }
    }
    
    var icon: String {
        switch self {
        case .restaurants: return "fork.knife"
        case .hotels: return "bed.double"
        case .attractions: return "star"
        case .gasStations: return "fuelpump"
        case .hospitals: return "cross"
        case .schools: return "graduationcap"
        }
    }
}

struct MapLocation: Identifiable {
    let id: UUID
    let name: String
    let address: String
    let category: String
    let rating: Double
    let reviewCount: Int
    let coordinate: CLLocationCoordinate2D
    let layer: MapLayer
    let phone: String
    let hours: String
    
    var icon: String {
        switch layer {
        case .restaurants: return "fork.knife"
        case .hotels: return "bed.double"
        case .attractions: return "star"
        case .gasStations: return "fuelpump"
        case .hospitals: return "cross"
        case .schools: return "graduationcap"
        }
    }
}

struct InteractiveMap_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveMap()
    }
}
