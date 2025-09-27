import UIKit

class ComplexSearchInterfaceViewController: UIViewController {
    
    // MARK: - Properties
    private var searchQuery = ""
    private var searchResults: [SearchResult] = []
    private var isLoading = false
    private var selectedFilters = Set<String>()
    private var sortOption = "relevance"
    private var viewMode: ViewMode = .list
    private var selectedCategory = "All"
    
    enum ViewMode: String, CaseIterable {
        case list = "list"
        case grid = "grid"
        case compact = "compact"
    }
    
    // MARK: - UI Components
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for anything..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var filtersScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var filtersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sortPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var viewModeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ViewMode.allCases.map { $0.rawValue.capitalized })
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(viewModeChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "No results found"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = "Try adjusting your search terms or filters"
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("Clear all filters", for: .normal)
        clearButton.addTarget(self, action: #selector(clearFiltersTapped), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            clearButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    // MARK: - Data
    private let filters = [
        Filter(id: "recent", name: "Recent", type: "date"),
        Filter(id: "large", name: "Large Files", type: "size"),
        Filter(id: "images", name: "Images Only", type: "type"),
        Filter(id: "videos", name: "Videos Only", type: "type"),
        Filter(id: "free", name: "Free", type: "price")
    ]
    
    private let sortOptions = ["relevance", "date", "name", "size", "type", "rating"]
    
    private let sampleResults = [
        SearchResult(
            id: "1",
            title: "React Native Development Guide",
            description: "Comprehensive guide to building mobile apps with React Native",
            type: "document",
            category: "Documents",
            size: "2.5 MB",
            sizeValue: 2.5,
            date: "2024-01-15",
            rating: 4.8,
            price: 0,
            image: "📄",
            url: "https://example.com/react-native-guide"
        ),
        SearchResult(
            id: "2",
            title: "Mobile UI Design Patterns",
            description: "Best practices for mobile user interface design",
            type: "image",
            category: "Images",
            size: "1.2 MB",
            sizeValue: 1.2,
            date: "2024-01-14",
            rating: 4.6,
            price: 29.99,
            image: "🖼️",
            url: "https://example.com/ui-patterns"
        ),
        SearchResult(
            id: "3",
            title: "JavaScript Tutorial Series",
            description: "Complete JavaScript tutorial for beginners",
            type: "video",
            category: "Videos",
            size: "150 MB",
            sizeValue: 150,
            date: "2024-01-13",
            rating: 4.9,
            price: 49.99,
            image: "🎥",
            url: "https://example.com/js-tutorial"
        )
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        
        // Add subviews
        view.addSubview(searchBar)
        view.addSubview(filtersScrollView)
        view.addSubview(sortPicker)
        view.addSubview(viewModeSegmentedControl)
        view.addSubview(resultsTableView)
        view.addSubview(loadingIndicator)
        view.addSubview(emptyStateView)
        
        filtersScrollView.addSubview(filtersStackView)
        
        setupFilters()
        setupConstraints()
    }
    
    private func setupFilters() {
        // Add filter buttons
        for filter in filters {
            let button = UIButton(type: .system)
            button.setTitle(filter.name, for: .normal)
            button.backgroundColor = .systemGray5
            button.layer.cornerRadius = 16
            button.addTarget(self, action: #selector(filterTapped(_:)), for: .touchUpInside)
            button.tag = filters.firstIndex(where: { $0.id == filter.id }) ?? 0
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            filtersStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Search Bar
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Filters Scroll View
            filtersScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            filtersScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            // Filters Stack View
            filtersStackView.topAnchor.constraint(equalTo: filtersScrollView.topAnchor, constant: 4),
            filtersStackView.leadingAnchor.constraint(equalTo: filtersScrollView.leadingAnchor, constant: 16),
            filtersStackView.trailingAnchor.constraint(equalTo: filtersScrollView.trailingAnchor, constant: -16),
            filtersStackView.bottomAnchor.constraint(equalTo: filtersScrollView.bottomAnchor, constant: -4),
            
            // Sort Picker
            sortPicker.topAnchor.constraint(equalTo: filtersScrollView.bottomAnchor, constant: 8),
            sortPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortPicker.widthAnchor.constraint(equalToConstant: 120),
            sortPicker.heightAnchor.constraint(equalToConstant: 100),
            
            // View Mode Segmented Control
            viewModeSegmentedControl.topAnchor.constraint(equalTo: filtersScrollView.bottomAnchor, constant: 8),
            viewModeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            viewModeSegmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            // Results Table View
            resultsTableView.topAnchor.constraint(equalTo: sortPicker.bottomAnchor, constant: 16),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Loading Indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Empty State View
            emptyStateView.topAnchor.constraint(equalTo: sortPicker.bottomAnchor, constant: 16),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func filterTapped(_ sender: UIButton) {
        let filter = filters[sender.tag]
        
        if selectedFilters.contains(filter.id) {
            selectedFilters.remove(filter.id)
            sender.backgroundColor = .systemGray5
        } else {
            selectedFilters.insert(filter.id)
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
        }
        
        performSearch()
    }
    
    @objc private func viewModeChanged() {
        viewMode = ViewMode.allCases[viewModeSegmentedControl.selectedSegmentIndex]
        // In a real implementation, this would change the view mode
    }
    
    @objc private func clearFiltersTapped() {
        selectedFilters.removeAll()
        searchQuery = ""
        searchBar.text = ""
        searchResults = []
        resultsTableView.reloadData()
        updateEmptyState()
    }
    
    // MARK: - Helper Methods
    private func performSearch() {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            resultsTableView.reloadData()
            updateEmptyState()
            return
        }
        
        isLoading = true
        loadingIndicator.startAnimating()
        resultsTableView.isHidden = true
        emptyStateView.isHidden = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.searchResults = self.getFilteredResults()
            self.isLoading = false
            self.loadingIndicator.stopAnimating()
            self.resultsTableView.isHidden = false
            self.resultsTableView.reloadData()
            self.updateEmptyState()
        }
    }
    
    private func getFilteredResults() -> [SearchResult] {
        var filteredResults = sampleResults
        
        // Apply search query filter
        if !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredResults = filteredResults.filter { result in
                result.title.localizedCaseInsensitiveContains(self.searchQuery) ||
                result.description.localizedCaseInsensitiveContains(self.searchQuery)
            }
        }
        
        // Apply selected filters
        for filterId in selectedFilters {
            let filter = filters.first { $0.id == filterId }
            guard let filter = filter else { continue }
            
            switch filter.type {
            case "type":
                let type = filterId.replacingOccurrences(of: "s", with: "")
                filteredResults = filteredResults.filter { $0.type == type }
            case "price":
                if filterId == "free" {
                    filteredResults = filteredResults.filter { $0.price == 0 }
                }
            case "size":
                if filterId == "large" {
                    filteredResults = filteredResults.filter { $0.sizeValue > 1 }
                }
            case "date":
                if filterId == "recent" {
                    let recentDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
                    filteredResults = filteredResults.filter { result in
                        let resultDate = ISO8601DateFormatter().date(from: result.date + "T00:00:00Z") ?? Date.distantPast
                        return resultDate > recentDate
                    }
                }
            default:
                break
            }
        }
        
        return filteredResults
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !searchResults.isEmpty || searchQuery.isEmpty
    }
}

// MARK: - UISearchBarDelegate
extension ComplexSearchInterfaceViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        performSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch()
    }
}

// MARK: - UIPickerViewDataSource
extension ComplexSearchInterfaceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
}

// MARK: - UIPickerViewDelegate
extension ComplexSearchInterfaceViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row].capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sortOption = sortOptions[row]
        performSearch()
    }
}

// MARK: - UITableViewDataSource
extension ComplexSearchInterfaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        let result = searchResults[indexPath.row]
        cell.configure(with: result)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ComplexSearchInterfaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = searchResults[indexPath.row]
        
        let alert = UIAlertController(title: result.title, message: result.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
            // Handle open action
        })
        present(alert, animated: true)
    }
}

// MARK: - Search Result Table View Cell
class SearchResultTableViewCell: UITableViewCell {
    private let iconLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let metadataLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        iconLabel.font = UIFont.systemFont(ofSize: 32)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        metadataLabel.font = UIFont.systemFont(ofSize: 12)
        metadataLabel.textColor = .tertiaryLabel
        metadataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        priceLabel.textColor = .systemBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(metadataLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 48),
            iconLabel.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            metadataLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            metadataLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            metadataLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: metadataLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with result: SearchResult) {
        iconLabel.text = result.image
        titleLabel.text = result.title
        descriptionLabel.text = result.description
        metadataLabel.text = "\(result.category) • \(result.date) • ⭐ \(String(format: "%.1f", result.rating)) • \(result.size)"
        priceLabel.text = result.price > 0 ? "$\(String(format: "%.2f", result.price))" : "Free"
    }
}

// MARK: - Data Models
struct Filter {
    let id: String
    let name: String
    let type: String
}

struct SearchResult {
    let id: String
    let title: String
    let description: String
    let type: String
    let category: String
    let size: String
    let sizeValue: Double
    let date: String
    let rating: Double
    let price: Double
    let image: String
    let url: String
}
