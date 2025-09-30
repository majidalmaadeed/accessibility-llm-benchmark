import SwiftUI
struct SearchWithSilentUpdates: View {
    @State private var query = ""
    @State private var suggestions: [SearchResult] = []
    @State private var results: [SearchResult] = []
    @State private var isLoading = false
    @State private var showSuggestions = false
    @State private var activeSuggestionIndex = -1
    let mockData = [
        SearchResult(id: 1, title: "React Development Guide", category: "Books", author: "John Doe"),
        SearchResult(id: 2, title: "Vue.js Tutorial", category: "Books", author: "Jane Smith"),
        SearchResult(id: 3, title: "Angular Framework", category: "Books", author: "Bob Johnson"),
        SearchResult(id: 4, title: "JavaScript Fundamentals", category: "Books", author: "Alice Brown"),
        SearchResult(id: 5, title: "React Components", category: "Tutorials", author: "Charlie Wilson"),
        SearchResult(id: 6, title: "Vue Components", category: "Tutorials", author: "Diana Lee"),
        SearchResult(id: 7, title: "Angular Services", category: "Tutorials", author: "Eve Davis"),
        SearchResult(id: 8, title: "JavaScript ES6", category: "Tutorials", author: "Frank Miller")
    ]
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Search Interface")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Search for content using the input field below. Suggestions will appear as you type.")
                    .font(.body)
                    .foregroundColor(.secondary)
                // Search Input Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Search for content:")
                        .font(.headline)
                        .fontWeight(.bold)
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Type to search...", text: $query)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: query) { _ in
                                handleInput()
                            }
                            .onSubmit {
                                handleSearch()
                            }
                        // Suggestions Dropdown
                        if showSuggestions && !suggestions.isEmpty {
                            VStack(spacing: 0) {
                                ForEach(Array(suggestions.enumerated()), id: \.offset) { index, suggestion in
                                    Button(action: {
                                        handleSuggestionClick(suggestion)
                                    }) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(suggestion.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Text("\(suggestion.category) • \(suggestion.author)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(index == activeSuggestionIndex ? Color(.systemGray5) : Color.clear)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    if index < suggestions.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        }
                    }
                    Button(action: handleSearch) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Searching..." : "Search")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoading ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(isLoading || query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                // Results Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Search Results")
                        .font(.title2)
                        .fontWeight(.bold)
                    if isLoading {
                        VStack {
                            ProgressView()
                            Text("Searching...")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else if !results.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Found \(results.count) result\(results.count == 1 ? "" : "s")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            ScrollView {
                                LazyVStack(spacing: 12) {
                                    ForEach(results) { result in
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(result.title)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                            Text("Category: \(result.category)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            Text("Author: \(result.author)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .frame(maxHeight: 400)
                        }
                    } else if !query.isEmpty {
                        VStack {
                            Text("No results found for \"\(query)\"")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else {
                        VStack {
                            Text("Enter a search term to find content")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            if showSuggestions {
                showSuggestions = false
                activeSuggestionIndex = -1
            }
        }
    }
    private func handleInput() {
        if query.count > 1 {
            let filtered = mockData.filter { item in
                item.title.lowercased().contains(query.lowercased()) ||
                item.category.lowercased().contains(query.lowercased()) ||
                item.author.lowercased().contains(query.lowercased())
            }
            suggestions = Array(filtered.prefix(5))
            showSuggestions = true
            activeSuggestionIndex = -1
        } else {
            suggestions = []
            showSuggestions = false
            activeSuggestionIndex = -1
        }
    }
    private func handleSearch() {
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let filtered = mockData.filter { item in
                item.title.lowercased().contains(query.lowercased()) ||
                item.category.lowercased().contains(query.lowercased()) ||
                item.author.lowercased().contains(query.lowercased())
            }
            results = filtered
            isLoading = false
            showSuggestions = false
            activeSuggestionIndex = -1
        }
    }
    private func handleSuggestionClick(_ suggestion: SearchResult) {
        query = suggestion.title
        showSuggestions = false
        activeSuggestionIndex = -1
        handleSearch()
    }
}
struct SearchResult: Identifiable {
    let id: Int
    let title: String
    let category: String
    let author: String
}
// MARK: - Preview
struct SearchWithSilentUpdates_Previews: PreviewProvider {
    static var previews: some View {
        SearchWithSilentUpdates()
            .previewDisplayName("Search With Silent Updates")
    }
}