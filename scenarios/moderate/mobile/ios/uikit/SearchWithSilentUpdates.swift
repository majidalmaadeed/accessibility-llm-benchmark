import UIKit

class SearchWithSilentUpdatesViewController: UIViewController {
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let searchLabel = UILabel()
    private let searchTextField = UITextField()
    private let suggestionsTableView = UITableView()
    private let searchButton = UIButton()
    private let resultsTitleLabel = UILabel()
    private let resultsCountLabel = UILabel()
    private let resultsTableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel = UILabel()
    private let noResultsLabel = UILabel()
    private let emptyStateLabel = UILabel()
    private let accessibilityInfoView = UIView()
    
    // MARK: - Data Properties
    private var suggestions: [SearchResult] = []
    private var results: [SearchResult] = []
    private var isLoading = false
    private var showSuggestions = false
    private var activeSuggestionIndex = -1
    
    private let mockData = [
        SearchResult(id: 1, title: "React Development Guide", category: "Books", author: "John Doe"),
        SearchResult(id: 2, title: "Vue.js Tutorial", category: "Books", author: "Jane Smith"),
        SearchResult(id: 3, title: "Angular Framework", category: "Books", author: "Bob Johnson"),
        SearchResult(id: 4, title: "JavaScript Fundamentals", category: "Books", author: "Alice Brown"),
        SearchResult(id: 5, title: "React Components", category: "Tutorials", author: "Charlie Wilson"),
        SearchResult(id: 6, title: "Vue Components", category: "Tutorials", author: "Diana Lee"),
        SearchResult(id: 7, title: "Angular Services", category: "Tutorials", author: "Eve Davis"),
        SearchResult(id: 8, title: "JavaScript ES6", category: "Tutorials", author: "Frank Miller")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupAccessibility()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Title
        titleLabel.text = "Search Interface"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Subtitle
        subtitleLabel.text = "Violation: Search input + suggestions dropdown + results area without announcements."
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        
        // Search Label
        searchLabel.text = "Search for content:"
        searchLabel.font = UIFont.boldSystemFont(ofSize: 18)
        searchLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchLabel)
        
        // Search Text Field
        searchTextField.placeholder = "Type to search..."
        searchTextField.borderStyle = .roundedRect
        searchTextField.font = UIFont.systemFont(ofSize: 16)
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0).cgColor
        searchTextField.layer.cornerRadius = 4
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchTextField)
        
        // Suggestions Table View
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        suggestionsTableView.register(SuggestionTableViewCell.self, forCellReuseIdentifier: "SuggestionCell")
        suggestionsTableView.isHidden = true
        suggestionsTableView.layer.borderWidth = 2
        suggestionsTableView.layer.borderColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0).cgColor
        suggestionsTableView.layer.cornerRadius = 4
        suggestionsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(suggestionsTableView)
        
        // Search Button
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        searchButton.layer.cornerRadius = 4
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.isEnabled = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchButton)
        
        // Results Title
        resultsTitleLabel.text = "Search Results"
        resultsTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultsTitleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        resultsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsTitleLabel)
        
        // Results Count
        resultsCountLabel.font = UIFont.systemFont(ofSize: 14)
        resultsCountLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        resultsCountLabel.isHidden = true
        resultsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsCountLabel)
        
        // Results Table View
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "ResultCell")
        resultsTableView.isHidden = true
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsTableView)
        
        // Loading Indicator
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        
        // Loading Label
        loadingLabel.text = "Searching..."
        loadingLabel.font = UIFont.systemFont(ofSize: 16)
        loadingLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        loadingLabel.textAlignment = .center
        loadingLabel.isHidden = true
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingLabel)
        
        // No Results Label
        noResultsLabel.font = UIFont.systemFont(ofSize: 16)
        noResultsLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        noResultsLabel.textAlignment = .center
        noResultsLabel.isHidden = true
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noResultsLabel)
        
        // Empty State Label
        emptyStateLabel.text = "Enter a search term to find content"
        emptyStateLabel.font = UIFont.systemFont(ofSize: 16)
        emptyStateLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyStateLabel)
        
        // Accessibility Info View
        setupAccessibilityInfoView()
    }
    
    private func setupAccessibilityInfoView() {
        accessibilityInfoView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.94, alpha: 1.0)
        accessibilityInfoView.layer.cornerRadius = 4
        accessibilityInfoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accessibilityInfoView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        accessibilityInfoView.addSubview(stackView)
        
        let issuesTitle = UILabel()
        issuesTitle.text = "Accessibility Issues:"
        issuesTitle.font = UIFont.boldSystemFont(ofSize: 18)
        issuesTitle.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        stackView.addArrangedSubview(issuesTitle)
        
        let issuesText = UILabel()
        issuesText.text = """
        • Missing live region: No announcements when search results change
        • Incomplete ARIA attributes: Suggestions lack proper aria-activedescendant
        • No keyboard navigation: Arrow keys don't navigate through suggestions
        • Missing announcements: Screen readers don't announce result count changes
        • No loading state announcement: Loading state not announced to screen readers
        • Missing suggestion selection: No aria-selected state management
        """
        issuesText.font = UIFont.systemFont(ofSize: 14)
        issuesText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        issuesText.numberOfLines = 0
        stackView.addArrangedSubview(issuesText)
        
        let fixesTitle = UILabel()
        fixesTitle.text = "How to Fix:"
        fixesTitle.font = UIFont.boldSystemFont(ofSize: 18)
        fixesTitle.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        stackView.addArrangedSubview(fixesTitle)
        
        let fixesText = UILabel()
        fixesText.text = """
        • Add aria-live="polite" region for result announcements
        • Implement aria-activedescendant for suggestion navigation
        • Add arrow key navigation (Up/Down) through suggestions
        • Announce result count changes ("Found X results")
        • Add loading state announcements
        • Implement proper aria-selected state management
        """
        fixesText.font = UIFont.systemFont(ofSize: 14)
        fixesText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        fixesText.numberOfLines = 0
        stackView.addArrangedSubview(fixesText)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: accessibilityInfoView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: accessibilityInfoView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: accessibilityInfoView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: accessibilityInfoView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Search Label
            searchLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            searchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            searchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Search Text Field
            searchTextField.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Suggestions Table View
            suggestionsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 4),
            suggestionsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            suggestionsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            suggestionsTableView.heightAnchor.constraint(equalToConstant: 200),
            
            // Search Button
            searchButton.topAnchor.constraint(equalTo: suggestionsTableView.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Results Title
            resultsTitleLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 30),
            resultsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            resultsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Results Count
            resultsCountLabel.topAnchor.constraint(equalTo: resultsTitleLabel.bottomAnchor, constant: 16),
            resultsCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            resultsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Results Table View
            resultsTableView.topAnchor.constraint(equalTo: resultsCountLabel.bottomAnchor, constant: 16),
            resultsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            resultsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            resultsTableView.heightAnchor.constraint(equalToConstant: 300),
            
            // Loading Indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: resultsTitleLabel.bottomAnchor, constant: 50),
            
            // Loading Label
            loadingLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 16),
            loadingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            loadingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // No Results Label
            noResultsLabel.topAnchor.constraint(equalTo: resultsTitleLabel.bottomAnchor, constant: 50),
            noResultsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            noResultsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Empty State Label
            emptyStateLabel.topAnchor.constraint(equalTo: resultsTitleLabel.bottomAnchor, constant: 50),
            emptyStateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            emptyStateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            // Accessibility Info View
            accessibilityInfoView.topAnchor.constraint(equalTo: resultsTableView.bottomAnchor, constant: 20),
            accessibilityInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            accessibilityInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            accessibilityInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupAccessibility() {
        // MISSING: Proper accessibility setup
        // Should set up ARIA attributes, live regions, and keyboard navigation
    }
    
    // MARK: - Actions
    @objc private func searchTextChanged() {
        let query = searchTextField.text ?? ""
        
        if query.count > 1 {
            let filtered = mockData.filter { item in
                item.title.lowercased().contains(query.lowercased()) ||
                item.category.lowercased().contains(query.lowercased()) ||
                item.author.lowercased().contains(query.lowercased())
            }
            suggestions = Array(filtered.prefix(5))
            showSuggestions = true
            activeSuggestionIndex = -1
            updateSuggestions()
        } else {
            suggestions = []
            showSuggestions = false
            activeSuggestionIndex = -1
            hideSuggestions()
        }
        
        searchButton.isEnabled = !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading
    }
    
    @objc private func searchButtonTapped() {
        performSearch()
    }
    
    private func updateSuggestions() {
        if suggestions.count > 0 {
            suggestionsTableView.isHidden = false
            suggestionsTableView.reloadData()
        } else {
            hideSuggestions()
        }
    }
    
    private func hideSuggestions() {
        suggestionsTableView.isHidden = true
    }
    
    private func performSearch() {
        if isLoading { return }
        
        let query = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if query.isEmpty { return }
        
        isLoading = true
        searchButton.isEnabled = false
        searchButton.setTitle("Searching...", for: .normal)
        
        // Hide all result states
        loadingIndicator.startAnimating()
        loadingLabel.isHidden = false
        resultsCountLabel.isHidden = true
        resultsTableView.isHidden = true
        noResultsLabel.isHidden = true
        emptyStateLabel.isHidden = true
        hideSuggestions()
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let filtered = self.mockData.filter { item in
                item.title.lowercased().contains(query.lowercased()) ||
                item.category.lowercased().contains(query.lowercased()) ||
                item.author.lowercased().contains(query.lowercased())
            }
            
            self.results = filtered
            self.isLoading = false
            self.searchButton.isEnabled = true
            self.searchButton.setTitle("Search", for: .normal)
            self.loadingIndicator.stopAnimating()
            self.loadingLabel.isHidden = true
            
            if self.results.count > 0 {
                self.resultsCountLabel.text = "Found \(self.results.count) result\(self.results.count == 1 ? "" : "s")"
                self.resultsCountLabel.isHidden = false
                self.resultsTableView.reloadData()
                self.resultsTableView.isHidden = false
                
                // MISSING: Screen reader announcement of results
                // Should announce "Found X results"
            } else {
                self.noResultsLabel.text = "No results found for \"\(query)\""
                self.noResultsLabel.isHidden = false
                
                // MISSING: Screen reader announcement of no results
                // Should announce "No results found"
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchWithSilentUpdatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == suggestionsTableView {
            return suggestions.count
        } else {
            return results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == suggestionsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionTableViewCell
            let suggestion = suggestions[indexPath.row]
            cell.configure(with: suggestion)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
            let result = results[indexPath.row]
            cell.configure(with: result)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchWithSilentUpdatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == suggestionsTableView {
            let suggestion = suggestions[indexPath.row]
            searchTextField.text = suggestion.title
            hideSuggestions()
            performSearch()
        }
    }
}

// MARK: - Custom Table View Cells
class SuggestionTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let metaLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        metaLabel.font = UIFont.systemFont(ofSize: 12)
        metaLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        metaLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(metaLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            metaLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            metaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            metaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            metaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with suggestion: SearchResult) {
        titleLabel.text = suggestion.title
        metaLabel.text = "\(suggestion.category) • \(suggestion.author)"
    }
}

class ResultTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let authorLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with result: SearchResult) {
        titleLabel.text = result.title
        categoryLabel.text = "Category: \(result.category)"
        authorLabel.text = "Author: \(result.author)"
    }
}

// MARK: - Data Model
struct SearchResult {
    let id: Int
    let title: String
    let category: String
    let author: String
}