import SwiftUI

struct ComplexSearchInterface: View {
    @State private var searchQuery = ""
    @State private var searchResults: [SearchResult] = []
    @State private var isLoading = false
    @State private var selectedFilters = Set<String>()
    @State private var sortOption = "relevance"
    @State private var viewMode: ViewMode = .list
    @State private var selectedCategory = "All"
    @State private var minPrice = 0.0
    @State private var maxPrice = 1000.0
    @State private var showAdvancedFilters = false
    @State private var showResultDetails = false
    @State private var selectedResult: SearchResult?
    
    enum ViewMode: String, CaseIterable {
        case list = "list"
        case grid = "grid"
        case compact = "compact"
    }
    
    private let filters = [
        Filter(id: "recent", name: "Recent", type: "date"),
        Filter(id: "large", name: "Large Files", type: "size"),
        Filter(id: "images", name: "Images Only", type: "type"),
        Filter(id: "videos", name: "Videos Only", type: "type"),
        Filter(id: "documents", name: "Documents Only", type: "type"),
        Filter(id: "free", name: "Free", type: "price"),
        Filter(id: "premium", name: "Premium", type: "price")
    ]
    
    private let categories = [
        "All", "Documents", "Images", "Videos", "Audio", "Web Pages",
        "News", "Products", "People", "Locations"
    ]
    
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
            price: 0,
            image: "📰",
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
            image: "🛍️",
            url: "https://example.com/product-catalog"
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                searchBarView
                
                // Filters
                filtersView
                
                // Sort and View
                sortAndViewView
                
                // Results
                resultsView
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showAdvancedFilters) {
                AdvancedFiltersView(
                    selectedCategory: $selectedCategory,
                    minPrice: $minPrice,
                    maxPrice: $maxPrice,
                    isPresented: $showAdvancedFilters
                ) {
                    applyFilters()
                }
            }
            .sheet(isPresented: $showResultDetails) {
                if let result = selectedResult {
                    ResultDetailsView(result: result, isPresented: $showResultDetails)
                }
            }
        }
    }
    
    private var searchBarView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search for anything...", text: $searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        performSearch()
                    }
                
                if !searchQuery.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Button("Search") {
                performSearch()
            }
            .foregroundColor(.blue)
            .fontWeight(.semibold)
        }
        .padding()
    }
    
    private var filtersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button(action: { showAdvancedFilters = true }) {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease")
                        Text("Filters")
                        if selectedFiltersCount > 0 {
                            Text("\(selectedFiltersCount)")
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(showAdvancedFilters ? Color.blue : Color(.systemGray5))
                    .foregroundColor(showAdvancedFilters ? .white : .primary)
                    .cornerRadius(16)
                }
                
                ForEach(filters, id: \.id) { filter in
                    FilterChip(
                        filter: filter,
                        isSelected: selectedFilters.contains(filter.id)
                    ) {
                        toggleFilter(filter.id)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
    
    private var sortAndViewView: some View {
        HStack {
            HStack {
                Text("Sort by:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Picker("Sort", selection: $sortOption) {
                    Text("Relevance").tag("relevance")
                    Text("Date").tag("date")
                    Text("Name").tag("name")
                    Text("Size").tag("size")
                    Text("Type").tag("type")
                    Text("Rating").tag("rating")
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                ForEach(ViewMode.allCases, id: \.self) { mode in
                    Button(action: { viewMode = mode }) {
                        Image(systemName: viewModeIcon(for: mode))
                            .font(.title3)
                    }
                    .foregroundColor(viewMode == mode ? .blue : .gray)
                    .padding(8)
                    .background(viewMode == mode ? Color.blue.opacity(0.1) : Color.clear)
                    .cornerRadius(6)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var resultsView: some View {
        Group {
            if isLoading {
                loadingView
            } else if searchResults.isEmpty && !searchQuery.isEmpty {
                emptyStateView
            } else if searchResults.isEmpty {
                initialStateView
            } else {
                resultsListView
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.2)
            Text("Searching...")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            Text("No results found")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Try adjusting your search terms or filters")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Clear all filters") {
                clearAllFilters()
            }
            .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    private var initialStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            Text("Search for anything")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Enter a search term to find documents, images, videos, and more")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    private var resultsListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(searchResults, id: \.id) { result in
                    ResultCardView(result: result) {
                        selectedResult = result
                        showResultDetails = true
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Computed Properties
    
    private var selectedFiltersCount: Int {
        selectedFilters.count
    }
    
    // MARK: - Helper Methods
    
    private func viewModeIcon(for mode: ViewMode) -> String {
        switch mode {
        case .list: return "list.bullet"
        case .grid: return "square.grid.2x2"
        case .compact: return "line.3.horizontal"
        }
    }
    
    private func performSearch() {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            searchResults = getFilteredResults()
            isLoading = false
        }
    }
    
    private func getFilteredResults() -> [SearchResult] {
        var filteredResults = sampleResults
        
        // Apply search query filter
        if !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredResults = filteredResults.filter { result in
                result.title.localizedCaseInsensitiveContains(searchQuery) ||
                result.description.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        
        // Apply category filter
        if selectedCategory != "All" {
            filteredResults = filteredResults.filter { $0.category == selectedCategory }
        }
        
        // Apply price range filter
        filteredResults = filteredResults.filter { result in
            result.price >= minPrice && result.price <= maxPrice
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
                } else if filterId == "premium" {
                    filteredResults = filteredResults.filter { $0.price > 0 }
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
        
        // Apply sorting
        switch sortOption {
        case "date":
            filteredResults.sort { $0.date > $1.date }
        case "name":
            filteredResults.sort { $0.title < $1.title }
        case "size":
            filteredResults.sort { $0.sizeValue > $1.sizeValue }
        case "type":
            filteredResults.sort { $0.type < $1.type }
        case "rating":
            filteredResults.sort { $0.rating > $1.rating }
        default:
            break // relevance - keep original order
        }
        
        return filteredResults
    }
    
    private func clearSearch() {
        searchQuery = ""
        searchResults = []
    }
    
    private func toggleFilter(_ filterId: String) {
        if selectedFilters.contains(filterId) {
            selectedFilters.remove(filterId)
        } else {
            selectedFilters.insert(filterId)
        }
        performSearch()
    }
    
    private func clearAllFilters() {
        selectedFilters.removeAll()
        selectedCategory = "All"
        minPrice = 0
        maxPrice = 1000
        performSearch()
    }
    
    private func applyFilters() {
        performSearch()
    }
}

// MARK: - Supporting Views

struct FilterChip: View {
    let filter: Filter
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(filter.name)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(16)
        }
    }
}

struct ResultCardView: View {
    let result: SearchResult
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Result Icon
                Text(result.image)
                    .font(.system(size: 32))
                    .frame(width: 48, height: 48)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Result Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(result.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(result.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    // Metadata
                    HStack(spacing: 16) {
                        Label(result.category, systemImage: "folder")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label(result.date, systemImage: "clock")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label(String(format: "%.1f", result.rating), systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label(result.size, systemImage: "doc")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if result.price > 0 {
                        Text("$\(String(format: "%.2f", result.price))")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AdvancedFiltersView: View {
    @Binding var selectedCategory: String
    @Binding var minPrice: Double
    @Binding var maxPrice: Double
    @Binding var isPresented: Bool
    let onApply: () -> Void
    
    private let categories = [
        "All", "Documents", "Images", "Videos", "Audio", "Web Pages",
        "News", "Products", "People", "Locations"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Price Range") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Minimum Price: $\(Int(minPrice))")
                        Slider(value: $minPrice, in: 0...1000, step: 10)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Maximum Price: $\(Int(maxPrice))")
                        Slider(value: $maxPrice, in: 0...1000, step: 10)
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All") {
                        selectedCategory = "All"
                        minPrice = 0
                        maxPrice = 1000
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        onApply()
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct ResultDetailsView: View {
    let result: SearchResult
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(result.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(result.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Details") {
                    DetailRow(title: "Type", value: result.type.capitalized)
                    DetailRow(title: "Category", value: result.category)
                    DetailRow(title: "Size", value: result.size)
                    DetailRow(title: "Date", value: result.date)
                    DetailRow(title: "Rating", value: String(format: "%.1f/5", result.rating))
                    DetailRow(title: "Price", value: result.price > 0 ? "$\(String(format: "%.2f", result.price))" : "Free")
                }
            }
            .navigationTitle("Result Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

// MARK: - Data Models

struct Filter {
    let id: String
    let name: String
    let type: String
}

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
    let image: String
    let url: String
}

#Preview {
    ComplexSearchInterface()
}