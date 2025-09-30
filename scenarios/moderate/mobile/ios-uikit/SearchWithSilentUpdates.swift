import UIKit
class SearchWithSilentUpdatesViewController: UIViewController {
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchTextField = UITextField()
    private let searchButton = UIButton()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
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
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        // Title
        // Subtitle
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
        // Search Button
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        searchButton.layer.cornerRadius = 4
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.isEnabled = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchButton)
        // Results Title
        // Results Count
        // Loading Indicator
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
    }
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        ])
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
        } else {
            hideSuggestions()
        }
    }
    private func hideSuggestions() {
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
            let suggestion = suggestions[indexPath.row]
            cell.configure(with: suggestion)
            return cell
        } else {
            let result = results[indexPath.row]
            cell.configure(with: result)
            return cell
        }
    }
}
            let suggestion = suggestions[indexPath.row]
            searchTextField.text = suggestion.title
            hideSuggestions()
            performSearch()
        }
    }
}
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        NSLayoutConstraint.activate([
        ])
    }
    func configure(with suggestion: SearchResult) {
    }
}
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        NSLayoutConstraint.activate([
        ])
    }
    func configure(with result: SearchResult) {
    }
}
// MARK: - Data Model
struct SearchResult {
    let id: Int
    let title: String
    let category: String
    let author: String
}