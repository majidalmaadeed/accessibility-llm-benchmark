import UIKit
import MapKit

class InteractiveMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var mapView: MKMapView!
    private var searchBar: UISearchBar!
    private var toolbarView: UIView!
    private var layerToggleView: UIView!
    private var markerInfoView: UIView!
    private var zoomControlsView: UIView!
    
    private var selectedMarker: MKAnnotation?
    private var mapLayers: [String: Bool] = ["satellite": false, "traffic": false, "transit": false]
    private var searchResults: [MKMapItem] = []
    private var customMarkers: [CustomAnnotation] = []
    private var currentLocation: CLLocation?
    private var isTrackingLocation: Bool = false
    private var mapType: MKMapType = .standard
    private var zoomLevel: Double = 0.0
    private var showTraffic: Bool = false
    private var showTransit: Bool = false
    private var showBuildings: Bool = true
    private var showPointsOfInterest: Bool = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        setupSearchBar()
        setupToolbarView()
        setupLayerToggleView()
        setupMarkerInfoView()
        setupZoomControlsView()
        setupConstraints()
        setupLocationManager()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Interactive Map"
        
        setupNavigationBar()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsTraffic = showTraffic
        mapView.showsTransit = showTransit
        mapView.showsBuildings = showBuildings
        mapView.showsPointsOfInterest = showPointsOfInterest
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search places..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupToolbarView() {
        toolbarView = UIView()
        toolbarView.backgroundColor = .systemGray6
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbarView)
        
        let mapTypeButton = createToolbarButton(title: "Map", action: #selector(toggleMapType))
        let locationButton = createToolbarButton(title: "📍", action: #selector(centerOnLocation))
        let addMarkerButton = createToolbarButton(title: "➕", action: #selector(addMarker))
        let clearMarkersButton = createToolbarButton(title: "🗑", action: #selector(clearMarkers))
        let directionsButton = createToolbarButton(title: "🧭", action: #selector(showDirections))
        
        let stackView = UIStackView(arrangedSubviews: [mapTypeButton, locationButton, addMarkerButton, clearMarkersButton, directionsButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        toolbarView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: toolbarView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: toolbarView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: toolbarView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupLayerToggleView() {
        layerToggleView = UIView()
        layerToggleView.backgroundColor = .systemGray6
        layerToggleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(layerToggleView)
        
        let satelliteToggle = createToggleButton(title: "Satellite", action: #selector(toggleSatellite))
        let trafficToggle = createToggleButton(title: "Traffic", action: #selector(toggleTraffic))
        let transitToggle = createToggleButton(title: "Transit", action: #selector(toggleTransit))
        let buildingsToggle = createToggleButton(title: "Buildings", action: #selector(toggleBuildings))
        let poiToggle = createToggleButton(title: "POI", action: #selector(togglePointsOfInterest))
        
        let stackView = UIStackView(arrangedSubviews: [satelliteToggle, trafficToggle, transitToggle, buildingsToggle, poiToggle])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        layerToggleView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layerToggleView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: layerToggleView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: layerToggleView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: layerToggleView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupMarkerInfoView() {
        markerInfoView = UIView()
        markerInfoView.backgroundColor = .systemBackground
        markerInfoView.layer.cornerRadius = 8
        markerInfoView.layer.shadowColor = UIColor.black.cgColor
        markerInfoView.layer.shadowOffset = CGSize(width: 0, height: 2)
        markerInfoView.layer.shadowRadius = 4
        markerInfoView.layer.shadowOpacity = 0.1
        markerInfoView.isHidden = true
        markerInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(markerInfoView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.addTarget(self, action: #selector(closeMarkerInfo), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, subtitleLabel, closeButton].forEach {
            markerInfoView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: markerInfoView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: markerInfoView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: markerInfoView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: markerInfoView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: markerInfoView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: markerInfoView.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: markerInfoView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupZoomControlsView() {
        zoomControlsView = UIView()
        zoomControlsView.backgroundColor = .systemGray6
        zoomControlsView.layer.cornerRadius = 20
        zoomControlsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomControlsView)
        
        let zoomInButton = createZoomButton(title: "+", action: #selector(zoomIn))
        let zoomOutButton = createZoomButton(title: "-", action: #selector(zoomOut))
        
        let stackView = UIStackView(arrangedSubviews: [zoomInButton, zoomOutButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        zoomControlsView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: zoomControlsView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: zoomControlsView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: zoomControlsView.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: zoomControlsView.bottomAnchor, constant: -4)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            toolbarView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            layerToggleView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor),
            layerToggleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layerToggleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: layerToggleView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            markerInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            markerInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            markerInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            zoomControlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            zoomControlsView.bottomAnchor.constraint(equalTo: markerInfoView.topAnchor, constant: -16),
            zoomControlsView.widthAnchor.constraint(equalToConstant: 40),
            zoomControlsView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareLocation))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupLocationManager() {
        // Setup location manager
    }
    
    // MARK: - Helper Methods
    
    private func createToolbarButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }
    
    private func createToggleButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }
    
    private func createZoomButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .systemBackground
        return button
    }
    
    // MARK: - Actions
    
    @objc private func toggleMapType() {
        switch mapType {
        case .standard:
            mapType = .satellite
        case .satellite:
            mapType = .hybrid
        case .hybrid:
            mapType = .standard
        @unknown default:
            mapType = .standard
        }
        mapView.mapType = mapType
    }
    
    @objc private func centerOnLocation() {
        // Center on user location
    }
    
    @objc private func addMarker() {
        let center = mapView.centerCoordinate
        let annotation = CustomAnnotation(coordinate: center, title: "Custom Marker", subtitle: "Added by user")
        mapView.addAnnotation(annotation)
        customMarkers.append(annotation)
    }
    
    @objc private func clearMarkers() {
        mapView.removeAnnotations(customMarkers)
        customMarkers.removeAll()
    }
    
    @objc private func showDirections() {
        // Show directions
    }
    
    @objc private func toggleSatellite() {
        mapLayers["satellite"]?.toggle()
    }
    
    @objc private func toggleTraffic() {
        showTraffic.toggle()
        mapView.showsTraffic = showTraffic
    }
    
    @objc private func toggleTransit() {
        showTransit.toggle()
        mapView.showsTransit = showTransit
    }
    
    @objc private func toggleBuildings() {
        showBuildings.toggle()
        mapView.showsBuildings = showBuildings
    }
    
    @objc private func togglePointsOfInterest() {
        showPointsOfInterest.toggle()
        mapView.showsPointsOfInterest = showPointsOfInterest
    }
    
    @objc private func closeMarkerInfo() {
        markerInfoView.isHidden = true
    }
    
    @objc private func zoomIn() {
        let region = mapView.region
        let newRegion = MKCoordinateRegion(center: region.center, span: MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 0.5, longitudeDelta: region.span.longitudeDelta * 0.5))
        mapView.setRegion(newRegion, animated: true)
    }
    
    @objc private func zoomOut() {
        let region = mapView.region
        let newRegion = MKCoordinateRegion(center: region.center, span: MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * 2.0, longitudeDelta: region.span.longitudeDelta * 2.0))
        mapView.setRegion(newRegion, animated: true)
    }
    
    @objc private func shareLocation() {
        // Share current location
    }
}

// MARK: - MKMapViewDelegate

extension InteractiveMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedMarker = view.annotation
        // Show marker info
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}

// MARK: - UISearchBarDelegate

extension InteractiveMapViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Handle search
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // Perform search
    }
}

// MARK: - Supporting Models

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
