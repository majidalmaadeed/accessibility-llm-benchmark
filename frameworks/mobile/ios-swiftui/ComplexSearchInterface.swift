import SwiftUI

struct ComplexSearchInterface: View {
    @State private var searchQuery: String = ""
    @State private var searchResults: [SearchResult] = []
    @State private var isLoading: Bool = false
    @State private var selectedFilters: Set<SearchFilter> = []
    @State private var sortOption: SortOption = .relevance
    @State private var currentPage: Int = 1
    @State private var totalPages: Int = 1
    @State private var showFilters: Bool = false
    @State private var searchHistory: [String] = []
    @State private var showHistory: Bool = false
    @State private var selectedResult: SearchResult? = nil
    @State private var viewMode: ViewMode = .list
    @State private var selectedCategory: String = "All"
    
    let categories = ["All", "Documents", "Images", "Videos", "Audio", "Web Pages", "News", "Products"]
    let sortOptions: [SortOption] = [.relevance, .date, .name, .size, .type]
    let filters: [SearchFilter] = [
        SearchFilter(id: "recent", name: "Recent", type: .date),
        SearchFilter(id: "large", name: "Large Files", type: .size),
        SearchFilter(id: "images", name: "Images Only", type: .type),
        SearchFilter(id: "videos", name: "Videos Only", type: .type),
        SearchFilter(id: "documents", name: "Documents Only", type: .type)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchHeaderView
                
                if showFilters {
                    filtersView
                }
                
                if showHistory {
                    historyView
                } else if isLoading {
                    loadingView
                } else if searchResults.isEmpty && !searchQuery.isEmpty {
                    noResultsView
                } else if searchResults.isEmpty {
                    emptyStateView
                } else {
                    resultsView
                }
                
                if !searchResults.isEmpty {
                    paginationView
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(item: $selectedResult) { result in
            SearchResultDetailView(result: result)
        }
    }
    
    private var searchHeaderView: some View {
        VStack(spacing: 12) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search everything...", text: $searchQuery)
                        .textFieldStyle(.plain)
                        .onSubmit {
                            performSearch()
                        }
                        .onChange(of: searchQuery) { newValue in
                            if newValue.isEmpty {
                                searchResults = []
                            }
                        }
                    
                    if !searchQuery.isEmpty {
                        Button(action: { clearSearch() }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Button(action: { performSearch() }) {
                    Text("Search")
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .disabled(searchQuery.isEmpty)
            }
            
            HStack {
                Button(action: { showHistory.toggle() }) {
                    HStack {
                        Image(systemName: "clock")
                        Text("History")
                    }
                }
                .buttonStyle(.bordered)
                
                Button(action: { showFilters.toggle() }) {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        Text("Filters")
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("Sort", selection: $sortOption) {
                    ForEach(sortOptions, id: \.self) { option in
                        Text(option.displayName).tag(option)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("View", selection: $viewMode) {
                    Image(systemName: "list.bullet").tag(ViewMode.list)
                    Image(systemName: "square.grid.2x2").tag(ViewMode.grid)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Filters")
                    .font(.headline)
                Spacer()
                Button("Clear All") {
                    selectedFilters.removeAll()
                }
                .buttonStyle(.bordered)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ForEach(filters, id: \.id) { filter in
                    FilterChip(
                        filter: filter,
                        isSelected: selectedFilters.contains(filter)
                    ) {
                        toggleFilter(filter)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Date Range")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack {
                    DatePicker("From", selection: .constant(Date().addingTimeInterval(-86400 * 30)), displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker("To", selection: .constant(Date()), displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("File Size")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack {
                    Text("0 MB")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Slider(value: .constant(50), in: 0...100)
                        .accentColor(.blue)
                    
                    Text("100+ MB")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var historyView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Searches")
                    .font(.headline)
                Spacer()
                Button("Clear History") {
                    searchHistory.removeAll()
                }
                .buttonStyle(.bordered)
            }
            
            if searchHistory.isEmpty {
                Text("No recent searches")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(searchHistory, id: \.self) { query in
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.secondary)
                                
                                Text(query)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Button(action: { selectFromHistory(query) }) {
                                    Image(systemName: "arrow.up.left")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .onTapGesture {
                                selectFromHistory(query)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Searching...")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Search Everything")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Enter a search term to find documents, images, videos, and more")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var noResultsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No Results Found")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Try adjusting your search terms or filters")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Clear Filters") {
                selectedFilters.removeAll()
                performSearch()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var resultsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(searchResults.count) results for \"\(searchQuery)\"")
                    .font(.headline)
                
                Spacer()
                
                Text("Page \(currentPage) of \(totalPages)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            if viewMode == .list {
                listResultsView
            } else {
                gridResultsView
            }
        }
    }
    
    private var listResultsView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(searchResults) { result in
                    SearchResultRowView(result: result) {
                        selectedResult = result
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var gridResultsView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(searchResults) { result in
                    SearchResultGridView(result: result) {
                        selectedResult = result
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var paginationView: some View {
        HStack {
            Button("← Previous") {
                previousPage()
            }
            .buttonStyle(.bordered)
            .disabled(currentPage == 1)
            
            Spacer()
            
            HStack(spacing: 8) {
                ForEach(visiblePages, id: \.self) { page in
                    Button("\(page)") {
                        goToPage(page)
                    }
                    .buttonStyle(page == currentPage ? .borderedProminent : .bordered)
                }
            }
            
            Spacer()
            
            Button("Next →") {
                nextPage()
            }
            .buttonStyle(.bordered)
            .disabled(currentPage == totalPages)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // MARK: - Computed Properties
    
    private var visiblePages: [Int] {
        let start = max(1, currentPage - 2)
        let end = min(totalPages, currentPage + 2)
        return Array(start...end)
    }
    
    // MARK: - Methods
    
    private func performSearch() {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true
        addToHistory(searchQuery)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            searchResults = generateSearchResults()
            totalPages = Int(ceil(Double(searchResults.count) / 10.0))
            currentPage = 1
            isLoading = false
        }
    }
    
    private func clearSearch() {
        searchQuery = ""
        searchResults = []
        currentPage = 1
    }
    
    private func toggleFilter(_ filter: SearchFilter) {
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
        performSearch()
    }
    
    private func selectFromHistory(_ query: String) {
        searchQuery = query
        showHistory = false
        performSearch()
    }
    
    private func addToHistory(_ query: String) {
        if !searchHistory.contains(query) {
            searchHistory.insert(query, at: 0)
            if searchHistory.count > 20 {
                searchHistory.removeLast()
            }
        }
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
    
    private func goToPage(_ page: Int) {
        currentPage = page
    }
    
    private func generateSearchResults() -> [SearchResult] {
        let sampleResults = [
            SearchResult(
                id: UUID(),
                title: "Project Proposal Document",
                description: "A comprehensive project proposal for the new mobile application development initiative.",
                type: .document,
                size: "2.4 MB",
                date: Date().addingTimeInterval(-86400 * 2),
                url: "https://example.com/proposal.pdf",
                thumbnail: "doc.fill"
            ),
            SearchResult(
                id: UUID(),
                title: "Team Meeting Recording",
                description: "Video recording of the weekly team meeting discussing project milestones and updates.",
                type: .video,
                size: "45.2 MB",
                date: Date().addingTimeInterval(-86400 * 1),
                url: "https://example.com/meeting.mp4",
                thumbnail: "video.fill"
            ),
            SearchResult(
                id: UUID(),
                title: "Product Screenshots",
                description: "High-resolution screenshots of the new user interface design and features.",
                type: .image,
                size: "8.7 MB",
                date: Date().addingTimeInterval(-86400 * 3),
                url: "https://example.com/screenshots.zip",
                thumbnail: "photo.fill"
            ),
            SearchResult(
                id: UUID(),
                title: "User Research Report",
                description: "Detailed analysis of user feedback and market research findings.",
                type: .document,
                size: "1.8 MB",
                date: Date().addingTimeInterval(-86400 * 5),
                url: "https://example.com/research.pdf",
                thumbnail: "doc.fill"
            ),
            SearchResult(
                id: UUID(),
                title: "Marketing Presentation",
                description: "PowerPoint presentation for the upcoming product launch and marketing strategy.",
                type: .presentation,
                size: "12.3 MB",
                date: Date().addingTimeInterval(-86400 * 7),
                url: "https://example.com/presentation.pptx",
                thumbnail: "doc.richtext.fill"
            )
        ]
        
        return sampleResults
    }
}

// MARK: - Supporting Views

struct FilterChip: View {
    let filter: SearchFilter
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: filter.icon)
                    .foregroundColor(isSelected ? .white : .blue)
                
                Text(filter.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray5))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct SearchResultRowView: View {
    let result: SearchResult
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: result.thumbnail)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(result.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text(result.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text(result.type.displayName)
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(result.size)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(formatDate(result.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: onTap) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onTapGesture {
            onTap()
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct SearchResultGridView: View {
    let result: SearchResult
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: result.thumbnail)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(result.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(result.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack {
                    Text(result.type.displayName)
                        .font(.caption2)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(result.size)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onTapGesture {
            onTap()
        }
    }
}

struct SearchResultDetailView: View {
    let result: SearchResult
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: result.thumbnail)
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .frame(width: 60, height: 60)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(result.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(result.type.displayName)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(result.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details")
                            .font(.headline)
                        
                        VStack(spacing: 8) {
                            DetailRow(label: "Type", value: result.type.displayName)
                            DetailRow(label: "Size", value: result.size)
                            DetailRow(label: "Date", value: formatDate(result.date))
                            DetailRow(label: "URL", value: result.url)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Button("Open") {
                            // Open file
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Download") {
                            // Download file
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Share") {
                            // Share file
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

// MARK: - Supporting Types

enum ViewMode {
    case list, grid
}

enum SortOption: CaseIterable {
    case relevance, date, name, size, type
    
    var displayName: String {
        switch self {
        case .relevance: return "Relevance"
        case .date: return "Date"
        case .name: return "Name"
        case .size: return "Size"
        case .type: return "Type"
        }
    }
}

struct SearchFilter: Hashable {
    let id: String
    let name: String
    let type: FilterType
    
    var icon: String {
        switch type {
        case .date: return "calendar"
        case .size: return "doc"
        case .type: return "folder"
        }
    }
}

enum FilterType {
    case date, size, type
}

struct SearchResult: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let type: ResultType
    let size: String
    let date: Date
    let url: String
    let thumbnail: String
}

enum ResultType {
    case document, image, video, audio, presentation, webPage
    
    var displayName: String {
        switch self {
        case .document: return "Document"
        case .image: return "Image"
        case .video: return "Video"
        case .audio: return "Audio"
        case .presentation: return "Presentation"
        case .webPage: return "Web Page"
        }
    }
}

struct ComplexSearchInterface_Previews: PreviewProvider {
    static var previews: some View {
        ComplexSearchInterface()
    }
}
