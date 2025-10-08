import SwiftUI

struct ComplexSearchInterface: View {
    @State private var searchText = ""
    @State private var allResults: [SearchResult] = []
    @State private var filteredResults: [SearchResult] = []
    @State private var activeFilters: [String] = []
    @State private var currentSort = "Relevance"
    @State private var currentCategory = "All"
    @State private var currentPage = 1
    @State private var resultsPerPage = 25
    @State private var totalPages = 1
    @State private var showingAdvancedSearch = false
    @State private var selectedResult: SearchResult?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Search Bar
            searchBarView
            
            // Filters
            filtersView
            
            // Results
            resultsView
            
            // Pagination
            paginationView
            
            // Status Bar
            statusBarView
        }
        .onAppear {
            loadSampleData()
            performSearch()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Advanced Search")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(20)
        .background(Color.accentColor)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search for files, documents, images...", text: $searchText)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        performSearch()
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
            
            Button("Advanced") {
                showingAdvancedSearch = true
            }
            .buttonStyle(.bordered)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
    
    private var filtersView: some View {
        VStack(spacing: 16) {
            // Main Filters
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Category")
                        .font(.headline)
                    Picker("Category", selection: $currentCategory) {
                        Text("All").tag("All")
                        Text("Documents").tag("Documents")
                        Text("Images").tag("Images")
                        Text("Videos").tag("Videos")
                        Text("Audio").tag("Audio")
                        Text("Archives").tag("Archives")
                    }
                    .pickerStyle(.menu)
                    .frame(width: 140)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sort by")
                        .font(.headline)
                    Picker("Sort by", selection: $currentSort) {
                        Text("Relevance").tag("Relevance")
                        Text("Date").tag("Date")
                        Text("Name").tag("Name")
                        Text("Size").tag("Size")
                        Text("Type").tag("Type")
                        Text("Rating").tag("Rating")
                    }
                    .pickerStyle(.menu)
                    .frame(width: 140)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("View")
                        .font(.headline)
                    Picker("View", selection: .constant("List")) {
                        Text("List").tag("List")
                        Text("Grid").tag("Grid")
                        Text("Compact").tag("Compact")
                    }
                    .pickerStyle(.menu)
                    .frame(width: 120)
                }
                
                Spacer()
                
                Button("Clear All") {
                    clearFilters()
                }
                .buttonStyle(.bordered)
            }
            
            // Quick Filters
            HStack(spacing: 8) {
                Text("Quick Filters:")
                    .font(.headline)
                
                FilterButton(title: "Recent", isActive: activeFilters.contains("Recent")) {
                    toggleFilter("Recent")
                }
                
                FilterButton(title: "Large Files", isActive: activeFilters.contains("Large Files")) {
                    toggleFilter("Large Files")
                }
                
                FilterButton(title: "Images Only", isActive: activeFilters.contains("Images Only")) {
                    toggleFilter("Images Only")
                }
                
                FilterButton(title: "Videos Only", isActive: activeFilters.contains("Videos Only")) {
                    toggleFilter("Videos Only")
                }
                
                FilterButton(title: "Free", isActive: activeFilters.contains("Free")) {
                    toggleFilter("Free")
                }
                
                FilterButton(title: "Premium", isActive: activeFilters.contains("Premium")) {
                    toggleFilter("Premium")
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color(.controlBackgroundColor))
    }
    
    private var resultsView: some View {
        VStack(spacing: 0) {
            // Results Header
            HStack {
                Text("\(filteredResults.count) results found")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack {
                    Text("Results per page:")
                    Picker("Results per page", selection: $resultsPerPage) {
                        Text("10").tag(10)
                        Text("25").tag(25)
                        Text("50").tag(50)
                        Text("100").tag(100)
                    }
                    .pickerStyle(.menu)
                    .frame(width: 80)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            
            // Results List
            if filteredResults.isEmpty {
                emptyStateView
            } else {
                resultsListView
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 64))
                .foregroundColor(.secondary)
            
            Text("No results found")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Try adjusting your search terms or filters")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.controlBackgroundColor))
    }
    
    private var resultsListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(pagedResults, id: \.id) { result in
                    SearchResultCard(result: result) {
                        selectedResult = result
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var paginationView: some View {
        HStack {
            Button("⏮") {
                firstPage()
            }
            .disabled(currentPage <= 1)
            
            Button("◀") {
                previousPage()
            }
            .disabled(currentPage <= 1)
            
            Spacer()
            
            Text("Page \(currentPage) of \(totalPages)")
                .font(.subheadline)
            
            Spacer()
            
            Button("▶") {
                nextPage()
            }
            .disabled(currentPage >= totalPages)
            
            Button("⏭") {
                lastPage()
            }
            .disabled(currentPage >= totalPages)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color(.controlBackgroundColor))
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Ready")
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    // MARK: - Computed Properties
    private var pagedResults: [SearchResult] {
        let startIndex = (currentPage - 1) * resultsPerPage
        let endIndex = min(startIndex + resultsPerPage, filteredResults.count)
        return Array(filteredResults[startIndex..<endIndex])
    }
    
    // MARK: - Methods
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
    
    private func performSearch() {
        let query = searchText.lowercased()
        
        filteredResults = allResults.filter { result in
            query.isEmpty ||
            result.title.lowercased().contains(query) ||
            result.description.lowercased().contains(query) ||
            result.category.lowercased().contains(query)
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
        
        updatePagination()
    }
    
    private func updatePagination() {
        totalPages = max(1, Int(ceil(Double(filteredResults.count) / Double(resultsPerPage))))
        currentPage = min(currentPage, totalPages)
        currentPage = max(1, currentPage)
    }
    
    private func toggleFilter(_ filter: String) {
        if activeFilters.contains(filter) {
            activeFilters.removeAll { $0 == filter }
        } else {
            activeFilters.append(filter)
        }
        performSearch()
    }
    
    private func clearFilters() {
        activeFilters.removeAll()
        currentCategory = "All"
        searchText = ""
        performSearch()
    }
    
    private func firstPage() {
        currentPage = 1
    }
    
    private func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
        }
    }
    
    private func nextPage() {
        if currentPage < totalPages {
            currentPage += 1
        }
    }
    
    private func lastPage() {
        currentPage = totalPages
    }
}

// MARK: - Supporting Views
struct FilterButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .buttonStyle(.bordered)
        .background(isActive ? Color.accentColor.opacity(0.3) : Color.clear)
    }
}

struct SearchResultCard: View {
    let result: SearchResult
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Text(result.icon)
                .font(.system(size: 32))
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(result.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(result.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 16) {
                    Text(result.category)
                        .font(.caption)
                        .foregroundColor(.accentColor)
                    
                    Text(result.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text(String(format: "%.1f", result.rating))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(result.size)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Price/Actions
            VStack(alignment: .trailing, spacing: 8) {
                Text(result.price > 0 ? String(format: "$%.2f", result.price) : "Free")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack(spacing: 8) {
                    ActionButton(icon: "eye", action: { previewResult(result) })
                    ActionButton(icon: "arrow.down", action: { downloadResult(result) })
                    ActionButton(icon: "bookmark", action: { bookmarkResult(result) })
                }
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(8)
        .onTapGesture {
            onTap()
        }
    }
    
    private func previewResult(_ result: SearchResult) {
        // Preview implementation
    }
    
    private func downloadResult(_ result: SearchResult) {
        // Download implementation
    }
    
    private func bookmarkResult(_ result: SearchResult) {
        // Bookmark implementation
    }
}

struct ActionButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 16))
        }
        .buttonStyle(.bordered)
        .frame(width: 32, height: 32)
    }
}

// MARK: - Advanced Search View
struct AdvancedSearchView: View {
    @Binding var isPresented: Bool
    @State private var searchText = ""
    @State private var category = "All"
    @State private var sortBy = "Relevance"
    @State private var minPrice = 0.0
    @State private var maxPrice = 1000.0
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var minRating = 0.0
    @State private var maxRating = 5.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Advanced Search")
                .font(.title)
                .fontWeight(.bold)
            
            Form {
                TextField("Search Text", text: $searchText)
                
                Picker("Category", selection: $category) {
                    Text("All").tag("All")
                    Text("Documents").tag("Documents")
                    Text("Images").tag("Images")
                    Text("Videos").tag("Videos")
                }
                
                Picker("Sort By", selection: $sortBy) {
                    Text("Relevance").tag("Relevance")
                    Text("Date").tag("Date")
                    Text("Name").tag("Name")
                    Text("Size").tag("Size")
                    Text("Rating").tag("Rating")
                }
                
                HStack {
                    Text("Price Range:")
                    TextField("Min", value: $minPrice, format: .currency(code: "USD"))
                    Text("to")
                    TextField("Max", value: $maxPrice, format: .currency(code: "USD"))
                }
                
                HStack {
                    Text("Date Range:")
                    DatePicker("From", selection: $startDate, displayedComponents: .date)
                    DatePicker("To", selection: $endDate, displayedComponents: .date)
                }
                
                HStack {
                    Text("Rating Range:")
                    Slider(value: $minRating, in: 0...5, step: 0.1)
                    Text("\(minRating, specifier: "%.1f")")
                    Text("to")
                    Slider(value: $maxRating, in: 0...5, step: 0.1)
                    Text("\(maxRating, specifier: "%.1f")")
                }
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Button("Search") {
                    // Apply advanced search
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 500, height: 600)
    }
}

// MARK: - Search Result Model
struct SearchResult: Identifiable {
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

// MARK: - Preview
struct ComplexSearchInterface_Previews: PreviewProvider {
    static var previews: some View {
        ComplexSearchInterface()
    }
}
