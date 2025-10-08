import Cocoa
import MapKit

class InteractiveMap: NSViewController {
    
    // MARK: - Properties
    private var allLocations: [MapLocation] = []
    private var searchResults: [MapLocation] = []
    private var bookmarks: [MapLocation] = []
    private var currentMapType = "Standard"
    private var currentZoom: Double = 10
    private var centerLat = 37.7749
    private var centerLng = -122.4194
    private var showUserLocation = true
    private var showMapControls = true
    private var trafficEnabled = false
    private var transitEnabled = false
    private var bikeLanesEnabled = false
    
    // MARK: - UI Elements
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextField: NSSearchField!
    @IBOutlet weak var myLocationButton: NSButton!
    @IBOutlet weak var mapTypeComboBox: NSComboBox!
    @IBOutlet weak var layersButton: NSButton!
    @IBOutlet weak var bookmarksButton: NSButton!
    @IBOutlet weak var zoomInButton: NSButton!
    @IBOutlet weak var zoomOutButton: NSButton!
    @IBOutlet weak var centerButton: NSButton!
    @IBOutlet weak var searchResultsTableView: NSTableView!
    @IBOutlet weak var locationDetailsView: NSView!
    @IBOutlet weak var locationDetailsLabel: NSTextField!
    @IBOutlet weak var getDirectionsButton: NSButton!
    @IBOutlet weak var shareLocationButton: NSButton!
    @IBOutlet weak var saveLocationButton: NSButton!
    @IBOutlet weak var reportIssueButton: NSButton!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var coordinatesLabel: NSTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleData()
        setupMapMarkers()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure map view
        mapView.delegate = self
        mapView.showsUserLocation = showUserLocation
        mapView.showsCompass = true
        mapView.showsScale = true
        
        // Configure search field
        searchTextField.target = self
        searchTextField.action = #selector(searchFieldAction)
        
        // Configure buttons
        myLocationButton.target = self
        myLocationButton.action = #selector(myLocationButtonTapped)
        
        layersButton.target = self
        layersButton.action = #selector(layersButtonTapped)
        
        bookmarksButton.target = self
        bookmarksButton.action = #selector(bookmarksButtonTapped)
        
        zoomInButton.target = self
        zoomInButton.action = #selector(zoomInButtonTapped)
        
        zoomOutButton.target = self
        zoomOutButton.action = #selector(zoomOutButtonTapped)
        
        centerButton.target = self
        centerButton.action = #selector(centerButtonTapped)
        
        getDirectionsButton.target = self
        getDirectionsButton.action = #selector(getDirectionsButtonTapped)
        
        shareLocationButton.target = self
        shareLocationButton.action = #selector(shareLocationButtonTapped)
        
        saveLocationButton.target = self
        saveLocationButton.action = #selector(saveLocationButtonTapped)
        
        reportIssueButton.target = self
        reportIssueButton.action = #selector(reportIssueButtonTapped)
        
        // Configure combo box
        mapTypeComboBox.addItems(withObjectValues: ["Standard", "Satellite", "Hybrid", "Terrain"])
        mapTypeComboBox.selectItem(at: 0)
        mapTypeComboBox.target = self
        mapTypeComboBox.action = #selector(mapTypeChanged)
        
        // Configure table view
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchResultsTableView.target = self
        searchResultsTableView.doubleAction = #selector(locationDoubleClicked)
        
        // Configure location details
        locationDetailsLabel.isEditable = false
        locationDetailsLabel.isBordered = false
        locationDetailsLabel.backgroundColor = NSColor.clear
        locationDetailsLabel.alignment = .left
        
        // Set initial map region
        let initialLocation = CLLocation(latitude: centerLat, longitude: centerLng)
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: false)
        
        updateMapInfo()
    }
    
    // MARK: - Data Loading
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
        mapView.removeAnnotations(mapView.annotations)
        
        for location in allLocations {
            let annotation = MapAnnotation(location: location)
            mapView.addAnnotation(annotation)
        }
        
        updateMapInfo()
    }
    
    private func updateMapInfo() {
        let mapTypeText = currentMapType
        coordinatesLabel.stringValue = "Lat: \(String(format: "%.4f", centerLat)), Lng: \(String(format: "%.4f", centerLng))"
    }
    
    // MARK: - Search
    private func performSearch() {
        let query = searchTextField.stringValue.lowercased()
        
        if query.isEmpty {
            searchResultsTableView.isHidden = true
            return
        }
        
        searchResults = allLocations.filter { location in
            location.name.lowercased().contains(query) ||
            location.address.lowercased().contains(query) ||
            location.category.lowercased().contains(query)
        }
        
        searchResultsTableView.reloadData()
        searchResultsTableView.isHidden = false
        
        statusLabel.stringValue = "Found \(searchResults.count) results"
    }
    
    // MARK: - Actions
    @objc private func searchFieldAction() {
        performSearch()
    }
    
    @objc private func myLocationButtonTapped() {
        centerLat = 37.7749
        centerLng = -122.4194
        currentZoom = 10
        
        let location = CLLocation(latitude: centerLat, longitude: centerLng)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        statusLabel.stringValue = "Centered on your location"
    }
    
    @objc private func mapTypeChanged() {
        currentMapType = mapTypeComboBox.stringValue
        
        switch currentMapType {
        case "Satellite":
            mapView.mapType = .satellite
        case "Hybrid":
            mapView.mapType = .hybrid
        case "Terrain":
            mapView.mapType = .hybridFlyover
        default:
            mapView.mapType = .standard
        }
        
        updateMapInfo()
        statusLabel.stringValue = "Map type changed to \(currentMapType)"
    }
    
    @objc private func layersButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Map Layers"
        alert.informativeText = "Layer options:\n• Traffic: \(trafficEnabled ? "On" : "Off")\n• Transit: \(transitEnabled ? "On" : "Off")\n• Bike Lanes: \(bikeLanesEnabled ? "On" : "Off")\n• User Location: \(showUserLocation ? "On" : "Off")"
        alert.addButton(withTitle: "Apply")
        alert.addButton(withTitle: "Cancel")
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            // In a real implementation, this would apply layer settings
            statusLabel.stringValue = "Map layers updated"
        }
    }
    
    @objc private func bookmarksButtonTapped() {
        if bookmarks.isEmpty {
            let alert = NSAlert()
            alert.messageText = "Bookmarks"
            alert.informativeText = "No bookmarks yet.\nBookmark locations to see them here."
            alert.runModal()
        } else {
            let alert = NSAlert()
            alert.messageText = "Bookmarks"
            alert.informativeText = bookmarks.map { $0.name }.joined(separator: "\n")
            alert.runModal()
        }
    }
    
    @objc private func zoomInButtonTapped() {
        currentZoom = min(currentZoom + 1, 20)
        let region = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 10000 / currentZoom, longitudinalMeters: 10000 / currentZoom)
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func zoomOutButtonTapped() {
        currentZoom = max(currentZoom - 1, 1)
        let region = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 10000 / currentZoom, longitudinalMeters: 10000 / currentZoom)
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func centerButtonTapped() {
        centerLat = 37.7749
        centerLng = -122.4194
        currentZoom = 10
        
        let location = CLLocation(latitude: centerLat, longitude: centerLng)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        statusLabel.stringValue = "Map centered"
    }
    
    @objc private func getDirectionsButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Get Directions"
        alert.informativeText = "Turn-by-turn directions would be displayed here."
        alert.runModal()
    }
    
    @objc private func shareLocationButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Share Location"
        alert.informativeText = "Location sharing options would be displayed here."
        alert.runModal()
    }
    
    @objc private func saveLocationButtonTapped() {
        let selectedRow = searchResultsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < searchResults.count {
            let location = searchResults[selectedRow]
            if !bookmarks.contains(where: { $0.id == location.id }) {
                bookmarks.append(location)
                let alert = NSAlert()
                alert.messageText = "Bookmark"
                alert.informativeText = "Location '\(location.name)' bookmarked!"
                alert.runModal()
            } else {
                let alert = NSAlert()
                alert.messageText = "Bookmark"
                alert.informativeText = "Location already bookmarked."
                alert.runModal()
            }
        } else {
            let alert = NSAlert()
            alert.messageText = "Bookmark"
            alert.informativeText = "Please select a location first."
            alert.runModal()
        }
    }
    
    @objc private func reportIssueButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Report Issue"
        alert.informativeText = "Report issue form would be displayed here."
        alert.runModal()
    }
    
    @objc private func locationDoubleClicked() {
        let selectedRow = searchResultsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < searchResults.count {
            let location = searchResults[selectedRow]
            showLocationDetails(location)
        }
    }
    
    private func showLocationDetails(_ location: MapLocation) {
        let details = """
        \(location.name)
        
        \(location.description)
        
        Type: \(location.type)
        Rating: \(String(format: "%.1f/5", location.rating))
        Price: \(location.price > 0 ? String(format: "$%.0f", location.price) : "Free")
        Hours: \(location.hours)
        \(location.phone != "N/A" ? "Phone: \(location.phone)" : "")
        """
        
        locationDetailsLabel.stringValue = details
    }
}

// MARK: - MKMapViewDelegate
extension InteractiveMap: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation else { return nil }
        
        let identifier = "MapAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let markerView = annotationView as? MKMarkerAnnotationView {
            markerView.markerTintColor = getCategoryColor(mapAnnotation.location.type)
            markerView.glyphText = getLocationIcon(mapAnnotation.location.type)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapAnnotation = view.annotation as? MapAnnotation {
            showLocationDetails(mapAnnotation.location)
        }
    }
    
    private func getLocationIcon(_ type: String) -> String {
        switch type {
        case "landmark": return "🏛️"
        case "attraction": return "🎡"
        case "shopping": return "🛍️"
        case "restaurant": return "🍽️"
        case "hotel": return "🏨"
        default: return "📍"
        }
    }
    
    private func getCategoryColor(_ type: String) -> NSColor {
        switch type {
        case "landmark": return .systemRed
        case "attraction": return .systemOrange
        case "shopping": return .systemGreen
        case "restaurant": return .systemBlue
        case "hotel": return .systemPurple
        default: return .systemGray
        }
    }
}

// MARK: - NSTableViewDataSource
extension InteractiveMap: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return searchResults.count
    }
}

// MARK: - NSTableViewDelegate
extension InteractiveMap: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let location = searchResults[row]
        
        let cell = NSTableCellView()
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        
        let nameLabel = NSTextField(labelWithString: location.name)
        nameLabel.font = NSFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.isEditable = false
        nameLabel.isBordered = false
        nameLabel.backgroundColor = NSColor.clear
        
        let addressLabel = NSTextField(labelWithString: location.address)
        addressLabel.font = NSFont.systemFont(ofSize: 12)
        addressLabel.textColor = NSColor.secondaryLabelColor
        addressLabel.isEditable = false
        addressLabel.isBordered = false
        addressLabel.backgroundColor = NSColor.clear
        
        let categoryLabel = NSTextField(labelWithString: location.category)
        categoryLabel.font = NSFont.systemFont(ofSize: 11)
        categoryLabel.textColor = NSColor.systemBlue
        categoryLabel.isEditable = false
        categoryLabel.isBordered = false
        categoryLabel.backgroundColor = NSColor.clear
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(categoryLabel)
        
        cell.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -4)
        ])
        
        return cell
    }
}

// MARK: - MapLocation Model
struct MapLocation {
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

// MARK: - MapAnnotation
class MapAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let location: MapLocation
    
    init(location: MapLocation) {
        self.location = location
        self.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        self.title = location.name
        self.subtitle = location.address
        super.init()
    }
}
