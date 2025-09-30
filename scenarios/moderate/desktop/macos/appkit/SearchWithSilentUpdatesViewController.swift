import Cocoa
class SearchWithSilentUpdatesViewController: NSViewController {
    // MARK: - UI Elements
    private let scrollView = NSScrollView()
    private let contentView = NSView()
    private let searchTextField = NSTextField()
    private let searchButton = NSButton()
    private let loadingIndicator = NSProgressIndicator()
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
        // Subtitle
        // Search Text Field
        searchTextField.placeholderString = "Type to search..."
        searchTextField.font = NSFont.systemFont(ofSize: 16)
        searchTextField.target = self
        searchTextField.action = #selector(searchTextChanged)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchTextField)
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
        // Results Count
        // Loading Indicator
        loadingIndicator.style = .spinning
        loadingIndicator.isHidden = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            // Content View
            // Title
            // Subtitle
            // Search Text Field
            // Search Button
            // Results Title
            // Results Count
            // Loading Indicator
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
        } else {
            hideSuggestions()
        }
    }
    private func hideSuggestions() {
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
            if self.results.count > 0 {
            } else {
            }
        }
    }
}
            return suggestions.count
        } else {
            return results.count
        }
    }
}
            let suggestion = suggestions[row]
            let textField = NSTextField()
            textField.stringValue = "\(suggestion.title)\n\(suggestion.category) • \(suggestion.author)"
            textField.isBordered = false
            textField.backgroundColor = .clear
            textField.font = NSFont.systemFont(ofSize: 14)
            cellView.textField = textField
            return cellView
        } else {
            let result = results[row]
            let textField = NSTextField()
            textField.stringValue = "\(result.title)\nCategory: \(result.category)\nAuthor: \(result.author)"
            textField.isBordered = false
            textField.backgroundColor = .clear
            textField.font = NSFont.systemFont(ofSize: 14)
            cellView.textField = textField
            return cellView
        }
    }
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