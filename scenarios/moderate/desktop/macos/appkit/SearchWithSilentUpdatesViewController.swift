import Cocoa

class SearchWithSilentUpdatesViewController: NSViewController {
    
    // MARK: - UI Elements
    private let scrollView = NSScrollView()
    private let contentView = NSView()
    private let titleLabel = NSTextField()
    private let subtitleLabel = NSTextField()
    private let searchLabel = NSTextField()
    private let searchTextField = NSTextField()
    private let suggestionsTableView = NSTableView()
    private let searchButton = NSButton()
    private let resultsTitleLabel = NSTextField()
    private let resultsCountLabel = NSTextField()
    private let resultsTableView = NSTableView()
    private let loadingIndicator = NSProgressIndicator()
    private let loadingLabel = NSTextField()
    private let noResultsLabel = NSTextField()
    private let emptyStateLabel = NSTextField()
    
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
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0).cgColor
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.documentView = contentView
        
        // Title
        titleLabel.stringValue = "Search Interface"
        titleLabel.font = NSFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Subtitle
        subtitleLabel.stringValue = "Search for content using the input field below. Suggestions will appear as you type."
        subtitleLabel.font = NSFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        subtitleLabel.isEditable = false
        subtitleLabel.isBordered = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        
        // Search Label
        searchLabel.stringValue = "Search for content:"
        searchLabel.font = NSFont.boldSystemFont(ofSize: 18)
        searchLabel.textColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        searchLabel.isEditable = false
        searchLabel.isBordered = false
        searchLabel.backgroundColor = .clear
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchLabel)
        
        // Search Text Field
        searchTextField.placeholderString = "Type to search..."
        searchTextField.font = NSFont.systemFont(ofSize: 16)
        searchTextField.target = self
        searchTextField.action = #selector(searchTextChanged)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchTextField)
        
        // Suggestions Table View
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        suggestionsTableView.headerView = nil
        suggestionsTableView.intercellSpacing = NSSize(width: 0, height: 1)
        suggestionsTableView.isHidden = true
        suggestionsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(suggestionsTableView)
        
        // Search Button
        searchButton.title = "Search"
        searchButton.font = NSFont.boldSystemFont(ofSize: 16)
        searchButton.bezelStyle = .rounded
        searchButton.target = self
        searchButton.action = #selector(searchButtonClicked)
        searchButton.isEnabled = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchButton)
        
        // Results Title
        resultsTitleLabel.stringValue = "Search Results"
        resultsTitleLabel.font = NSFont.boldSystemFont(ofSize: 20)
        resultsTitleLabel.textColor = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        resultsTitleLabel.isEditable = false
        resultsTitleLabel.isBordered = false
        resultsTitleLabel.backgroundColor = .clear
        resultsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsTitleLabel)
        
        // Results Count
        resultsCountLabel.font = NSFont.systemFont(ofSize: 14)
        resultsCountLabel.textColor = NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        resultsCountLabel.isEditable = false
        resultsCountLabel.isBordered = false
        resultsCountLabel.backgroundColor = .clear
        resultsCountLabel.isHidden = true
        resultsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsCountLabel)
        
        // Results Table View
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.headerView = nil
        resultsTableView.intercellSpacing = NSSize(width: 0, height: 1)
        resultsTableView.isHidden = true
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsTableView)
        
        // Loading Indicator
        loadingIndicator.style = .spinning
        loadingIndicator.isHidden = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        
        // Loading Label
        loadingLabel.stringValue = "Searching..."
        loadingLabel.font = NSFont.systemFont(ofSize: 16)
        loadingLabel.textColor = NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        loadingLabel.isEditable = false
        loadingLabel.isBordered = false
        loadingLabel.backgroundColor = .clear
        loadingLabel.isHidden = true
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingLabel)
        
        // No Results Label
        noResultsLabel.font = NSFont.systemFont(ofSize: 16)
        noResultsLabel.textColor = NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        noResultsLabel.isEditable = false
        noResultsLabel.isBordered = false
        noResultsLabel.backgroundColor = .clear
        noResultsLabel.isHidden = true
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noResultsLabel)
        
        // Empty State Label
        emptyStateLabel.stringValue = "Enter a search term to find content"
        emptyStateLabel.font = NSFont.systemFont(ofSize: 16)
        emptyStateLabel.textColor = NSColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        emptyStateLabel.isEditable = false
        emptyStateLabel.isBordered = false
        emptyStateLabel.backgroundColor = .clear
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyStateLabel)
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
            searchTextField.heightAnchor.constraint(equalToConstant: 32),
            
            // Suggestions Table View
            suggestionsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 4),
            suggestionsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            suggestionsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            suggestionsTableView.heightAnchor.constraint(equalToConstant: 200),
            
            // Search Button
            searchButton.topAnchor.constraint(equalTo: suggestionsTableView.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            searchButton.heightAnchor.constraint(equalToConstant: 32),
            
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
            
            resultsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    
    // MARK: - Actions
    @objc private func searchTextChanged() {
        let query = searchTextField.stringValue
        
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
    
    @objc private func searchButtonClicked() {
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
        
        let query = searchTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty { return }
        
        isLoading = true
        searchButton.isEnabled = false
        searchButton.title = "Searching..."
        
        // Hide all result states
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimation(nil)
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
            self.searchButton.title = "Search"
            self.loadingIndicator.stopAnimation(nil)
            self.loadingIndicator.isHidden = true
            self.loadingLabel.isHidden = true
            
            if self.results.count > 0 {
                self.resultsCountLabel.stringValue = "Found \(self.results.count) result\(self.results.count == 1 ? "" : "s")"
                self.resultsCountLabel.isHidden = false
                self.resultsTableView.reloadData()
                self.resultsTableView.isHidden = false
                
            } else {
                self.noResultsLabel.stringValue = "No results found for \"\(query)\""
                self.noResultsLabel.isHidden = false
                
            }
        }
    }
}

// MARK: - NSTableViewDataSource
extension SearchWithSilentUpdatesViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == suggestionsTableView {
            return suggestions.count
        } else {
            return results.count
        }
    }
}

// MARK: - NSTableViewDelegate
extension SearchWithSilentUpdatesViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableView == suggestionsTableView {
            let suggestion = suggestions[row]
            let cellView = NSTableCellView()
            let textField = NSTextField()
            textField.stringValue = "\(suggestion.title)\n\(suggestion.category) • \(suggestion.author)"
            textField.isEditable = false
            textField.isBordered = false
            textField.backgroundColor = .clear
            textField.font = NSFont.systemFont(ofSize: 14)
            cellView.textField = textField
            return cellView
        } else {
            let result = results[row]
            let cellView = NSTableCellView()
            let textField = NSTextField()
            textField.stringValue = "\(result.title)\nCategory: \(result.category)\nAuthor: \(result.author)"
            textField.isEditable = false
            textField.isBordered = false
            textField.backgroundColor = .clear
            textField.font = NSFont.systemFont(ofSize: 14)
            cellView.textField = textField
            return cellView
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let tableView = notification.object as? NSTableView else { return }
        
        if tableView == suggestionsTableView && tableView.selectedRow >= 0 {
            let suggestion = suggestions[tableView.selectedRow]
            searchTextField.stringValue = suggestion.title
            hideSuggestions()
            performSearch()
        }
    }
}

// MARK: - Data Model
struct SearchResult {
    let id: Int
    let title: String
    let category: String
    let author: String
}