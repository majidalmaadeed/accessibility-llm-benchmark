import UIKit

class ComplexSearchInterfaceViewController: UIViewController {
    
    // MARK: - Properties
    
    private var searchBar: UISearchBar!
    private var filterView: UIView!
    private var resultsTableView: UITableView!
    private var sortSegmentedControl: UISegmentedControl!
    private var viewToggleSegmentedControl: UISegmentedControl!
    private var paginationView: UIView!
    private var loadingIndicator: UIActivityIndicatorView!
    
    private var searchQuery: String = ""
    private var selectedFilters: [String: Any] = [:]
    private var sortOption: String = "relevance"
    private var viewMode: String = "list"
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var isLoading: Bool = false
    private var searchResults: [SearchResult] = []
    
    let sortOptions = ["relevance", "date", "title", "rating"]
    let viewModes = ["list", "grid", "compact"]
    let filterCategories = ["category", "date", "rating", "price", "location"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setupFilterView()
        setupResultsTableView()
        setupPaginationView()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        
        setupNavigationBar()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupFilterView() {
        filterView = UIView()
        filterView.backgroundColor = .systemGray6
        filterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterView)
        
        let filterLabel = UILabel()
        filterLabel.text = "Filters"
        filterLabel.font = UIFont.boldSystemFont(ofSize: 16)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let categoryButton = createFilterButton(title: "Category", action: #selector(showCategoryFilter))
        let dateButton = createFilterButton(title: "Date", action: #selector(showDateFilter))
        let ratingButton = createFilterButton(title: "Rating", action: #selector(showRatingFilter))
        let priceButton = createFilterButton(title: "Price", action: #selector(showPriceFilter))
        let locationButton = createFilterButton(title: "Location", action: #selector(showLocationFilter))
        
        let stackView = UIStackView(arrangedSubviews: [categoryButton, dateButton, ratingButton, priceButton, locationButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [filterLabel, stackView].forEach {
            filterView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 16),
            filterLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 16),
            filterLabel.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupResultsTableView() {
        resultsTableView = UITableView()
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsTableView)
        
        setupSortAndViewControls()
    }
    
    private func setupSortAndViewControls() {
        let controlView = UIView()
        controlView.backgroundColor = .systemGray6
        controlView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlView)
        
        let sortLabel = UILabel()
        sortLabel.text = "Sort by:"
        sortLabel.font = UIFont.systemFont(ofSize: 14)
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sortSegmentedControl = UISegmentedControl(items: sortOptions)
        sortSegmentedControl.selectedSegmentIndex = 0
        sortSegmentedControl.addTarget(self, action: #selector(sortChanged), for: .valueChanged)
        sortSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let viewLabel = UILabel()
        viewLabel.text = "View:"
        viewLabel.font = UIFont.systemFont(ofSize: 14)
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewToggleSegmentedControl = UISegmentedControl(items: viewModes)
        viewToggleSegmentedControl.selectedSegmentIndex = 0
        viewToggleSegmentedControl.addTarget(self, action: #selector(viewModeChanged), for: .valueChanged)
        viewToggleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        [sortLabel, sortSegmentedControl, viewLabel, viewToggleSegmentedControl].forEach {
            controlView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            sortLabel.topAnchor.constraint(equalTo: controlView.topAnchor, constant: 8),
            sortLabel.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 16),
            
            sortSegmentedControl.centerYAnchor.constraint(equalTo: sortLabel.centerYAnchor),
            sortSegmentedControl.leadingAnchor.constraint(equalTo: sortLabel.trailingAnchor, constant: 8),
            sortSegmentedControl.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -16),
            
            viewLabel.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 8),
            viewLabel.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: 16),
            
            viewToggleSegmentedControl.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor),
            viewToggleSegmentedControl.leadingAnchor.constraint(equalTo: viewLabel.trailingAnchor, constant: 8),
            viewToggleSegmentedControl.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -16),
            viewToggleSegmentedControl.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupPaginationView() {
        paginationView = UIView()
        paginationView.backgroundColor = .systemGray6
        paginationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paginationView)
        
        let prevButton = UIButton(type: .system)
        prevButton.setTitle("Previous", for: .normal)
        prevButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        
        let pageLabel = UILabel()
        pageLabel.text = "Page 1 of 1"
        pageLabel.font = UIFont.systemFont(ofSize: 14)
        pageLabel.textAlignment = .center
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        [prevButton, pageLabel, nextButton].forEach {
            paginationView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalTo: paginationView.leadingAnchor, constant: 16),
            prevButton.centerYAnchor.constraint(equalTo: paginationView.centerYAnchor),
            
            pageLabel.centerXAnchor.constraint(equalTo: paginationView.centerXAnchor),
            pageLabel.centerYAnchor.constraint(equalTo: paginationView.centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: paginationView.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: paginationView.centerYAnchor),
            
            paginationView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            resultsTableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: paginationView.topAnchor),
            
            paginationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paginationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paginationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearFilters))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    // MARK: - Helper Methods
    
    private func createFilterButton(title: String, action: Selector) -> UIButton {
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
    
    private func performSearch() {
        isLoading = true
        // Simulate search
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.resultsTableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @objc private func showCategoryFilter() {
        // Show category filter
    }
    
    @objc private func showDateFilter() {
        // Show date filter
    }
    
    @objc private func showRatingFilter() {
        // Show rating filter
    }
    
    @objc private func showPriceFilter() {
        // Show price filter
    }
    
    @objc private func showLocationFilter() {
        // Show location filter
    }
    
    @objc private func sortChanged() {
        sortOption = sortOptions[sortSegmentedControl.selectedSegmentIndex]
        performSearch()
    }
    
    @objc private func viewModeChanged() {
        viewMode = viewModes[viewToggleSegmentedControl.selectedSegmentIndex]
        resultsTableView.reloadData()
    }
    
    @objc private func previousPage() {
        guard currentPage > 1 else { return }
        currentPage -= 1
        performSearch()
    }
    
    @objc private func nextPage() {
        guard currentPage < totalPages else { return }
        currentPage += 1
        performSearch()
    }
    
    @objc private func clearFilters() {
        selectedFilters.removeAll()
        performSearch()
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

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ComplexSearchInterfaceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultTableViewCell
        let result = searchResults[indexPath.row]
        cell.configure(with: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle result selection
    }
}

// MARK: - Supporting Models

struct SearchResult {
    let id: String
    let title: String
    let description: String
    let category: String
    let date: Date
    let rating: Double
    let price: Double?
    let location: String?
    let imageURL: String?
}

// MARK: - Supporting Views

class SearchResultTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let categoryLabel = UILabel()
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [titleLabel, descriptionLabel, categoryLabel, ratingLabel, priceLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2
        
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = .systemBlue
        
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        ratingLabel.textColor = .systemOrange
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textColor = .systemGreen
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 16),
            
            priceLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with result: SearchResult) {
        titleLabel.text = result.title
        descriptionLabel.text = result.description
        categoryLabel.text = result.category
        ratingLabel.text = "★ \(result.rating)"
        priceLabel.text = result.price != nil ? "$\(result.price!)" : nil
        dateLabel.text = DateFormatter.localizedString(from: result.date, dateStyle: .short, timeStyle: .none)
    }
}
