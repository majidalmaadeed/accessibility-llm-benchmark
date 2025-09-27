import UIKit

class InteractiveMapViewController: UIViewController {
    private var searchQuery = ""
    private var selectedLocation: MapLocation?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for places..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var mapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mapPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "🗺️ Interactive Map"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Interactive Map"
        
        view.addSubview(searchBar)
        view.addSubview(mapView)
        mapView.addSubview(mapPlaceholder)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 400),
            
            mapPlaceholder.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            mapPlaceholder.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
        ])
    }
    
    private func performSearch() {
        // Simulate search
        let alert = UIAlertController(title: "Search", message: "Searching for: \(searchQuery)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension InteractiveMapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.text ?? ""
        performSearch()
    }
}

struct MapLocation {
    let id: String
    let name: String
    let address: String
}