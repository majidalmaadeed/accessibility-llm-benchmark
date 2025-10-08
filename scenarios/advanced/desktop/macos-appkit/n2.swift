import Cocoa

class ComplexSearchInterface: NSViewController {
    
    // MARK: - Properties
    private var allResults: [SearchResult] = []
    private var filteredResults: [SearchResult] = []
    private var activeFilters: [String] = []
    private var currentSort = "Relevance"
    private var currentCategory = "All"
    private var currentPage = 1
    private var resultsPerPage = 25
    private var totalPages = 1
    
    // MARK: - UI Elements
    @IBOutlet weak var searchTextField: NSSearchField!
    @IBOutlet weak var advancedSearchButton: NSButton!
    @IBOutlet weak var categoryComboBox: NSComboBox!
    @IBOutlet weak var sortComboBox: NSComboBox!
    @IBOutlet weak var viewModeComboBox: NSComboBox!
    @IBOutlet weak var clearFiltersButton: NSButton!
    @IBOutlet weak var recentFilterButton: NSButton!
    @IBOutlet weak var largeFilesFilterButton: NSButton!
    @IBOutlet weak var imagesFilterButton: NSButton!
    @IBOutlet weak var videosFilterButton: NSButton!
    @IBOutlet weak var freeFilterButton: NSButton!
    @IBOutlet weak var premiumFilterButton: NSButton!
    @IBOutlet weak var resultsCountLabel: NSTextField!
    @IBOutlet weak var resultsPerPageComboBox: NSComboBox!
    @IBOutlet weak var resultsTableView: NSTableView!
    @IBOutlet weak var emptyStateView: NSView!
    @IBOutlet weak var emptyStateLabel: NSTextField!
    @IBOutlet weak var firstPageButton: NSButton!
    @IBOutlet weak var previousPageButton: NSButton!
    @IBOutlet weak var nextPageButton: NSButton!
    @IBOutlet weak var lastPageButton: NSButton!
    @IBOutlet weak var pageInfoLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleData()
        updateResults()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure search field
        searchTextField.target = self
        searchTextField.action = #selector(searchFieldAction)
        
        // Configure buttons
        advancedSearchButton.target = self
        advancedSearchButton.action = #selector(advancedSearchButtonTapped)
        
        clearFiltersButton.target = self
        clearFiltersButton.action = #selector(clearFiltersButtonTapped)
        
        // Configure filter buttons
        recentFilterButton.target = self
        recentFilterButton.action = #selector(recentFilterButtonTapped)
        largeFilesFilterButton.target = self
        largeFilesFilterButton.action = #selector(largeFilesFilterButtonTapped)
        imagesFilterButton.target = self
        imagesFilterButton.action = #selector(imagesFilterButtonTapped)
        videosFilterButton.target = self
        videosFilterButton.action = #selector(videosFilterButtonTapped)
        freeFilterButton.target = self
        freeFilterButton.action = #selector(freeFilterButtonTapped)
        premiumFilterButton.target = self
        premiumFilterButton.action = #selector(premiumFilterButtonTapped)
        
        // Configure combo boxes
        categoryComboBox.addItems(withObjectValues: ["All", "Documents", "Images", "Videos", "Audio", "Archives"])
        categoryComboBox.selectItem(at: 0)
        categoryComboBox.target = self
        categoryComboBox.action = #selector(categoryChanged)
        
        sortComboBox.addItems(withObjectValues: ["Relevance", "Date", "Name", "Size", "Type", "Rating"])
        sortComboBox.selectItem(at: 0)
        sortComboBox.target = self
        sortComboBox.action = #selector(sortChanged)
        
        viewModeComboBox.addItems(withObjectValues: ["List", "Grid", "Compact"])
        viewModeComboBox.selectItem(at: 0)
        viewModeComboBox.target = self
        viewModeComboBox.action = #selector(viewModeChanged)
        
        resultsPerPageComboBox.addItems(withObjectValues: [10, 25, 50, 100])
        resultsPerPageComboBox.selectItem(at: 1) // 25
        resultsPerPageComboBox.target = self
        resultsPerPageComboBox.action = #selector(resultsPerPageChanged)
        
        // Configure table view
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        resultsTableView.target = self
        resultsTableView.doubleAction = #selector(resultDoubleClicked)
        
        // Configure pagination buttons
        firstPageButton.target = self
        firstPageButton.action = #selector(firstPageButtonTapped)
        previousPageButton.target = self
        previousPageButton.action = #selector(previousPageButtonTapped)
        nextPageButton.target = self
        nextPageButton.action = #selector(nextPageButtonTapped)
        lastPageButton.target = self
        lastPageButton.action = #selector(lastPageButtonTapped)
        
        // Configure empty state
        emptyStateLabel.stringValue = "No results found\nTry adjusting your search terms or filters"
        emptyStateLabel.alignment = .center
    }
    
    // MARK: - Data Loading
    private func loadSampleData() {
        allResults = [
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
                price: 0.0,
                icon: "📄",
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
                icon: "🖼️",
                url: "https://example.com/ui-patterns"
            ),
            SearchResult(
                id: "3",
                title: "JavaScript Tutorial Series",
                description: "Complete JavaScript tutorial for beginners",
                type: "video",
                category: "Videos",
                size: "150 MB",
                sizeValue: 150.0,
                date: "2024-01-13",
                rating: 4.9,
                price: 49.99,
                icon: "🎥",
                url: "https://example.com/js-tutorial"
            ),
            SearchResult(
                id: "4",
                title: "Web Development News",
                description: "Latest news and updates in web development",
                type: "news",
                category: "News",
                size: "500 KB",
                sizeValue: 0.5,
                date: "2024-01-12",
                rating: 4.3,
                price: 0.0,
                icon: "📰",
                url: "https://example.com/web-news"
            ),
            SearchResult(
                id: "5",
                title: "E-commerce Product Catalog",
                description: "Complete product catalog for online store",
                type: "product",
                category: "Products",
                size: "5.8 MB",
                sizeValue: 5.8,
                date: "2024-01-11",
                rating: 4.5,
                price: 99.99,
                icon: "🛍️",
                url: "https://example.com/product-catalog"
            ),
            SearchResult(
                id: "6",
                title: "Database Design Principles",
                description: "Fundamental concepts of database design and optimization",
                type: "document",
                category: "Documents",
                size: "3.2 MB",
                sizeValue: 3.2,
                date: "2024-01-10",
                rating: 4.7,
                price: 0.0,
                icon: "📄",
                url: "https://example.com/database-design"
            ),
            SearchResult(
                id: "7",
                title: "Cloud Architecture Diagrams",
                description: "Visual representations of cloud infrastructure patterns",
                type: "image",
                category: "Images",
                size: "2.1 MB",
                sizeValue: 2.1,
                date: "2024-01-09",
                rating: 4.4,
                price: 19.99,
                icon: "🖼️",
                url: "https://example.com/cloud-diagrams"
            ),
            SearchResult(
                id: "8",
                title: "Machine Learning Course",
                description: "Complete course on machine learning algorithms and applications",
                type: "video",
                category: "Videos",
                size: "2.5 GB",
                sizeValue: 2500.0,
                date: "2024-01-08",
                rating: 4.9,
                price: 199.99,
                icon: "🎥",
                url: "https://example.com/ml-course"
            )
        ]
    }
    
    // MARK: - Search
    private func performSearch() {
        let searchText = searchTextField.stringValue.lowercased()
        
        filteredResults = allResults.filter { result in
            searchText.isEmpty ||
            result.title.lowercased().contains(searchText) ||
            result.description.lowercased().contains(searchText) ||
            result.category.lowercased().contains(searchText)
        }
        
        // Apply category filter
        if currentCategory != "All" {
            filteredResults = filteredResults.filter { $0.category == currentCategory }
        }
        
        // Apply active filters
        for filter in activeFilters {
            switch filter {
            case "Recent":
                let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                filteredResults = filteredResults.filter { result in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    if let date = formatter.date(from: result.date) {
                        return date >= weekAgo
                    }
                    return false
                }
            case "Large Files":
                filteredResults = filteredResults.filter { $0.sizeValue > 10.0 }
            case "Images Only":
                filteredResults = filteredResults.filter { $0.type == "image" }
            case "Videos Only":
                filteredResults = filteredResults.filter { $0.type == "video" }
            case "Free":
                filteredResults = filteredResults.filter { $0.price == 0.0 }
            case "Premium":
                filteredResults = filteredResults.filter { $0.price > 0.0 }
            default:
                break
            }
        }
        
        // Apply sorting
        switch currentSort {
        case "Date":
            filteredResults.sort { $0.date > $1.date }
        case "Name":
            filteredResults.sort { $0.title < $1.title }
        case "Size":
            filteredResults.sort { $0.sizeValue > $1.sizeValue }
        case "Type":
            filteredResults.sort { $0.type < $1.type }
        case "Rating":
            filteredResults.sort { $0.rating > $1.rating }
        default: // Relevance
            filteredResults.sort { $0.rating > $1.rating }
        }
        
        updateResults()
    }
    
    private func updateResults() {
        let totalResults = filteredResults.count
        totalPages = max(1, Int(ceil(Double(totalResults) / Double(resultsPerPage))))
        
        if currentPage > totalPages {
            currentPage = totalPages
        }
        if currentPage < 1 {
            currentPage = 1
        }
        
        let startIndex = (currentPage - 1) * resultsPerPage
        let endIndex = min(startIndex + resultsPerPage, totalResults)
        let pagedResults = Array(filteredResults[startIndex..<endIndex])
        
        resultsTableView.reloadData()
        resultsCountLabel.stringValue = "\(totalResults) results found"
        pageInfoLabel.stringValue = "Page \(currentPage) of \(totalPages)"
        
        if totalResults == 0 {
            resultsTableView.isHidden = true
            emptyStateView.isHidden = false
        } else {
            resultsTableView.isHidden = false
            emptyStateView.isHidden = true
        }
        
        updatePaginationButtons()
    }
    
    private func updatePaginationButtons() {
        firstPageButton.isEnabled = currentPage > 1
        previousPageButton.isEnabled = currentPage > 1
        nextPageButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
    }
    
    // MARK: - Actions
    @objc private func searchFieldAction() {
        performSearch()
    }
    
    @objc private func advancedSearchButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Advanced Search"
        alert.informativeText = "Advanced search options would be implemented here."
        alert.runModal()
    }
    
    @objc private func categoryChanged() {
        currentCategory = categoryComboBox.stringValue
        performSearch()
    }
    
    @objc private func sortChanged() {
        currentSort = sortComboBox.stringValue
        performSearch()
    }
    
    @objc private func viewModeChanged() {
        let viewMode = viewModeComboBox.stringValue
        statusLabel.stringValue = "View mode changed to \(viewMode)"
    }
    
    @objc private func clearFiltersButtonTapped() {
        activeFilters.removeAll()
        currentCategory = "All"
        categoryComboBox.selectItem(at: 0)
        searchTextField.stringValue = ""
        performSearch()
    }
    
    @objc private func recentFilterButtonTapped() {
        toggleFilter("Recent", recentFilterButton)
    }
    
    @objc private func largeFilesFilterButtonTapped() {
        toggleFilter("Large Files", largeFilesFilterButton)
    }
    
    @objc private func imagesFilterButtonTapped() {
        toggleFilter("Images Only", imagesFilterButton)
    }
    
    @objc private func videosFilterButtonTapped() {
        toggleFilter("Videos Only", videosFilterButton)
    }
    
    @objc private func freeFilterButtonTapped() {
        toggleFilter("Free", freeFilterButton)
    }
    
    @objc private func premiumFilterButtonTapped() {
        toggleFilter("Premium", premiumFilterButton)
    }
    
    private func toggleFilter(_ filter: String, _ button: NSButton) {
        if activeFilters.contains(filter) {
            activeFilters.removeAll { $0 == filter }
            button.layer?.backgroundColor = NSColor.clear.cgColor
        } else {
            activeFilters.append(filter)
            button.layer?.backgroundColor = NSColor.systemBlue.cgColor
        }
        performSearch()
    }
    
    @objc private func resultsPerPageChanged() {
        if let newPerPage = resultsPerPageComboBox.objectValueOfSelectedItem as? Int {
            resultsPerPage = newPerPage
            currentPage = 1
            updateResults()
        }
    }
    
    @objc private func resultDoubleClicked() {
        let selectedRow = resultsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < filteredResults.count {
            let result = filteredResults[selectedRow]
            showResultDetails(result)
        }
    }
    
    private func showResultDetails(_ result: SearchResult) {
        let alert = NSAlert()
        alert.messageText = result.title
        alert.informativeText = """
        \(result.description)
        
        Type: \(result.type)
        Category: \(result.category)
        Size: \(result.size)
        Date: \(result.date)
        Rating: \(String(format: "%.1f/5", result.rating))
        Price: \(result.price > 0 ? String(format: "$%.2f", result.price) : "Free")
        """
        alert.addButton(withTitle: "Close")
        alert.addButton(withTitle: "Open")
        alert.runModal()
    }
    
    // MARK: - Pagination
    @objc private func firstPageButtonTapped() {
        currentPage = 1
        updateResults()
    }
    
    @objc private func previousPageButtonTapped() {
        if currentPage > 1 {
            currentPage -= 1
            updateResults()
        }
    }
    
    @objc private func nextPageButtonTapped() {
        if currentPage < totalPages {
            currentPage += 1
            updateResults()
        }
    }
    
    @objc private func lastPageButtonTapped() {
        currentPage = totalPages
        updateResults()
    }
}

// MARK: - NSTableViewDataSource
extension ComplexSearchInterface: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        let startIndex = (currentPage - 1) * resultsPerPage
        let endIndex = min(startIndex + resultsPerPage, filteredResults.count)
        return endIndex - startIndex
    }
}

// MARK: - NSTableViewDelegate
extension ComplexSearchInterface: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let startIndex = (currentPage - 1) * resultsPerPage
        let result = filteredResults[startIndex + row]
        
        let cell = NSTableCellView()
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.spacing = 12
        stackView.alignment = .centerY
        
        // Icon
        let iconLabel = NSTextField(labelWithString: result.icon)
        iconLabel.font = NSFont.systemFont(ofSize: 24)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = NSColor.clear
        
        // Content
        let contentStack = NSStackView()
        contentStack.orientation = .vertical
        contentStack.spacing = 4
        contentStack.alignment = .leading
        
        let titleLabel = NSTextField(labelWithString: result.title)
        titleLabel.font = NSFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = NSColor.clear
        
        let descriptionLabel = NSTextField(labelWithString: result.description)
        descriptionLabel.font = NSFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = NSColor.secondaryLabelColor
        descriptionLabel.isEditable = false
        descriptionLabel.isBordered = false
        descriptionLabel.backgroundColor = NSColor.clear
        
        let metadataLabel = NSTextField(labelWithString: "\(result.category) • \(result.date) • ⭐ \(String(format: "%.1f", result.rating)) • \(result.size)")
        metadataLabel.font = NSFont.systemFont(ofSize: 11)
        metadataLabel.textColor = NSColor.secondaryLabelColor
        metadataLabel.isEditable = false
        metadataLabel.isBordered = false
        metadataLabel.backgroundColor = NSColor.clear
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(metadataLabel)
        
        // Price/Actions
        let rightStack = NSStackView()
        rightStack.orientation = .vertical
        rightStack.spacing = 8
        rightStack.alignment = .trailing
        
        let priceLabel = NSTextField(labelWithString: result.price > 0 ? String(format: "$%.2f", result.price) : "Free")
        priceLabel.font = NSFont.systemFont(ofSize: 14, weight: .bold)
        priceLabel.isEditable = false
        priceLabel.isBordered = false
        priceLabel.backgroundColor = NSColor.clear
        
        let actionsStack = NSStackView()
        actionsStack.orientation = .horizontal
        actionsStack.spacing = 4
        
        let previewButton = NSButton(title: "👁", target: self, action: #selector(previewButtonTapped))
        previewButton.tag = startIndex + row
        previewButton.bezelStyle = .roundRect
        previewButton.font = NSFont.systemFont(ofSize: 12)
        
        let downloadButton = NSButton(title: "⬇", target: self, action: #selector(downloadButtonTapped))
        downloadButton.tag = startIndex + row
        downloadButton.bezelStyle = .roundRect
        downloadButton.font = NSFont.systemFont(ofSize: 12)
        
        let bookmarkButton = NSButton(title: "🔖", target: self, action: #selector(bookmarkButtonTapped))
        bookmarkButton.tag = startIndex + row
        bookmarkButton.bezelStyle = .roundRect
        bookmarkButton.font = NSFont.systemFont(ofSize: 12)
        
        actionsStack.addArrangedSubview(previewButton)
        actionsStack.addArrangedSubview(downloadButton)
        actionsStack.addArrangedSubview(bookmarkButton)
        
        rightStack.addArrangedSubview(priceLabel)
        rightStack.addArrangedSubview(actionsStack)
        
        stackView.addArrangedSubview(iconLabel)
        stackView.addArrangedSubview(contentStack)
        stackView.addArrangedSubview(rightStack)
        
        cell.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8)
        ])
        
        return cell
    }
    
    @objc private func previewButtonTapped(_ sender: NSButton) {
        let result = filteredResults[sender.tag]
        let alert = NSAlert()
        alert.messageText = "Preview"
        alert.informativeText = "Preview: \(result.title)\n\n\(result.description)"
        alert.runModal()
    }
    
    @objc private func downloadButtonTapped(_ sender: NSButton) {
        let result = filteredResults[sender.tag]
        let alert = NSAlert()
        alert.messageText = "Download"
        alert.informativeText = "Downloading: \(result.title)"
        alert.runModal()
    }
    
    @objc private func bookmarkButtonTapped(_ sender: NSButton) {
        let result = filteredResults[sender.tag]
        let alert = NSAlert()
        alert.messageText = "Bookmark"
        alert.informativeText = "Bookmarked: \(result.title)"
        alert.runModal()
    }
}

// MARK: - SearchResult Model
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
    let icon: String
    let url: String
}
