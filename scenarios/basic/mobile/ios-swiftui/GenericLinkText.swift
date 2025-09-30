import SwiftUI

struct GenericLinkText: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var showProfile = false
    @State private var notifications = 5
    @State private var selectedCategory = "all"
    @State private var showFilters = false
    @State private var selectedArticle: Article?
    @State private var bookmarkedArticles: [Article] = []
    @State private var showBookmarks = false
    @State private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var showLogin = false
    
    let categories = ["all", "technology", "business", "science", "health", "entertainment"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    HStack {
                        Text("NewsHub")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                showBookmarks = true
                            }) {
                                ZStack {
                                    Image(systemName: "bookmark")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                    
                                    if !bookmarkedArticles.isEmpty {
                                        Text("\(bookmarkedArticles.count)")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x: 8, y: -8)
                                    }
                                }
                            }
                            
                            Button(action: {
                                showProfile = true
                            }) {
                                Image(systemName: "person.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search articles...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.capitalized)
                                    .font(.subheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // Filter Controls
                HStack {
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filters")
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("\(filteredArticles.count) articles")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Articles List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredArticles) { article in
                            ArticleCard(
                                article: article,
                                onTap: {
                                    selectedArticle = article
                                },
                                onBookmark: {
                                    toggleBookmark(article)
                                },
                                isBookmarked: bookmarkedArticles.contains { $0.id == article.id }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterView()
            }
            .sheet(item: $selectedArticle) { article in
                ArticleDetailView(
                    article: article,
                    onBookmark: {
                        toggleBookmark(article)
                    },
                    isBookmarked: bookmarkedArticles.contains { $0.id == article.id }
                )
            }
            .sheet(isPresented: $showBookmarks) {
                BookmarksView(articles: $bookmarkedArticles)
            }
            .sheet(isPresented: $showProfile) {
                ProfileView(
                    isLoggedIn: $isLoggedIn,
                    username: $username,
                    password: $password,
                    showLogin: $showLogin
                )
            }
            .sheet(isPresented: $showLogin) {
                LoginView(
                    isLoggedIn: $isLoggedIn,
                    username: $username,
                    password: $password
                )
            }
        }
    }
    
    var filteredArticles: [Article] {
        var articles = sampleArticles
        
        if selectedCategory != "all" {
            articles = articles.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            articles = articles.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.summary.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return articles.sorted { $0.publishDate > $1.publishDate }
    }
    
    private func toggleBookmark(_ article: Article) {
        if let index = bookmarkedArticles.firstIndex(where: { $0.id == article.id }) {
            bookmarkedArticles.remove(at: index)
        } else {
            bookmarkedArticles.append(article)
        }
    }
}

struct ArticleCard: View {
    let article: Article
    let onTap: () -> Void
    let onBookmark: () -> Void
    let isBookmarked: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                // Article Image
                AsyncImage(url: URL(string: article.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    // Category and Date
                    HStack {
                        Text(article.category.capitalized)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(categoryColor(article.category))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        
                        Spacer()
                        
                        Text(article.publishDate, style: .relative)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Title
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                    
                    // Summary
                    Text(article.summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                    
                    // Author and Actions
                    HStack {
                        Text("By \(article.author)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                // Share
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            
                            Button(action: onBookmark) {
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                    .font(.caption)
                                    .foregroundColor(isBookmarked ? .blue : .gray)
                            }
                            
                            Button(action: onTap) {
                                Text("Read More")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "technology":
            return .blue
        case "business":
            return .green
        case "science":
            return .purple
        case "health":
            return .red
        case "entertainment":
            return .orange
        default:
            return .gray
        }
    }
}

struct ArticleDetailView: View {
    let article: Article
    let onBookmark: () -> Void
    let isBookmarked: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Article Image
                    AsyncImage(url: URL(string: article.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .font(.largeTitle)
                            )
                    }
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Category and Date
                        HStack {
                            Text(article.category.capitalized)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(categoryColor(article.category))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            
                            Spacer()
                            
                            Text(article.publishDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Title
                        Text(article.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        // Author and Reading Time
                        HStack {
                            Text("By \(article.author)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("\(article.readingTime) min read")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Summary
                        Text(article.summary)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                        
                        // Content
                        Text(article.content)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                        
                        // Tags
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tags:")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 100))
                            ], spacing: 8) {
                                ForEach(article.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        
                        // Action Buttons
                        HStack(spacing: 16) {
                            Button(action: onBookmark) {
                                HStack {
                                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                    Text(isBookmarked ? "Bookmarked" : "Bookmark")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isBookmarked ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(isBookmarked ? .white : .primary)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                // Share
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Article")
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
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "technology":
            return .blue
        case "business":
            return .green
        case "science":
            return .purple
        case "health":
            return .red
        case "entertainment":
            return .orange
        default:
            return .gray
        }
    }
}

struct BookmarksView: View {
    @Binding var articles: [Article]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if articles.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No bookmarks yet")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Save articles to read later")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(articles) { article in
                            HStack {
                                AsyncImage(url: URL(string: article.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(article.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    Text("By \(article.author)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    articles.removeAll { $0.id == article.id }
                                }) {
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookmarks")
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
}

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @Binding var showLogin: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoggedIn {
                    // Logged in view
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text("Welcome, \(username)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            Button(action: {
                                // Edit profile
                            }) {
                                HStack {
                                    Image(systemName: "pencil")
                                    Text("Edit Profile")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                // Settings
                            }) {
                                HStack {
                                    Image(systemName: "gear")
                                    Text("Settings")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isLoggedIn = false
                                username = ""
                                password = ""
                            }) {
                                HStack {
                                    Image(systemName: "power")
                                    Text("Logout")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                } else {
                    // Not logged in view
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("Welcome to NewsHub")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Sign in to personalize your news experience")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            showLogin = true
                        }) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
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
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Enter your credentials to continue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        SecureField("Enter your password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        performLogin()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Sign In")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(isLoading || username.isEmpty || password.isEmpty)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") {
                    showError = false
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func performLogin() {
        isLoading = true
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            
            if username.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields"
                showError = true
            } else if username == "test" && password == "password" {
                isLoggedIn = true
                dismiss()
            } else {
                errorMessage = "Invalid username or password"
                showError = true
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDateRange = "all"
    @State private var selectedAuthor = "all"
    @State private var selectedRating = 0.0
    @State private var showOnlyBookmarked = false
    
    let dateRanges = ["all", "today", "week", "month", "year"]
    let authors = ["all", "John Smith", "Sarah Johnson", "Mike Chen", "Emily Davis"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Date Range") {
                    Picker("Date Range", selection: $selectedDateRange) {
                        ForEach(dateRanges, id: \.self) { range in
                            Text(range.capitalized).tag(range)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Author") {
                    Picker("Author", selection: $selectedAuthor) {
                        ForEach(authors, id: \.self) { author in
                            Text(author).tag(author)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Rating") {
                    VStack {
                        HStack {
                            Text("Minimum Rating")
                            Spacer()
                            Text("\(selectedRating, specifier: "%.1f") stars")
                                .foregroundColor(.secondary)
                        }
                        
                        Slider(value: $selectedRating, in: 0...5, step: 0.5)
                    }
                }
                
                Section("Options") {
                    Toggle("Show Only Bookmarked", isOn: $showOnlyBookmarked)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedDateRange = "all"
                        selectedAuthor = "all"
                        selectedRating = 0.0
                        showOnlyBookmarked = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Data Models
struct Article: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let summary: String
    let content: String
    let author: String
    let category: String
    let publishDate: Date
    let readingTime: Int
    let imageURL: String
    let tags: [String]
    let rating: Double
    let viewCount: Int
}

let sampleArticles = [
    Article(
        title: "Revolutionary AI Technology Transforms Healthcare Industry",
        summary: "New artificial intelligence system shows promising results in early disease detection and treatment planning.",
        content: "In a groundbreaking development, researchers have unveiled a new AI system that can detect diseases with unprecedented accuracy. The technology uses advanced machine learning algorithms to analyze medical images and patient data, providing doctors with more accurate diagnoses and treatment recommendations. Early trials show a 95% accuracy rate in detecting various conditions, significantly improving patient outcomes and reducing healthcare costs. The system is expected to be deployed in hospitals nationwide by next year, marking a major milestone in the integration of AI into healthcare.",
        author: "Dr. Sarah Johnson",
        category: "technology",
        publishDate: Date().addingTimeInterval(-3600),
        readingTime: 5,
        imageURL: "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400",
        tags: ["AI", "Healthcare", "Technology", "Medical"],
        rating: 4.8,
        viewCount: 1250
    ),
    Article(
        title: "Global Climate Summit Reaches Historic Agreement",
        summary: "World leaders commit to ambitious carbon reduction targets and renewable energy investments.",
        content: "After weeks of intense negotiations, world leaders have reached a historic agreement on climate action. The new accord commits countries to reduce carbon emissions by 50% by 2030 and achieve net-zero emissions by 2050. The agreement also includes provisions for increased investment in renewable energy sources and support for developing nations in their transition to sustainable practices. Environmental groups have praised the agreement as a significant step forward in addressing the global climate crisis, while acknowledging that much work remains to be done.",
        author: "Michael Chen",
        category: "science",
        publishDate: Date().addingTimeInterval(-7200),
        readingTime: 7,
        imageURL: "https://images.unsplash.com/photo-1611273426858-450d8e3c9fce?w=400",
        tags: ["Climate", "Environment", "Politics", "Sustainability"],
        rating: 4.6,
        viewCount: 2100
    ),
    Article(
        title: "Stock Market Reaches All-Time High Amid Economic Recovery",
        summary: "Major indices surge as investors show confidence in post-pandemic economic growth.",
        content: "The stock market has reached new record highs as investors express confidence in the ongoing economic recovery. The S&P 500, Dow Jones, and NASDAQ all closed at record levels, driven by strong corporate earnings and positive economic indicators. Analysts attribute the surge to increased consumer spending, robust job growth, and continued government stimulus measures. While some experts warn of potential volatility ahead, the overall sentiment remains optimistic about the economy's trajectory.",
        author: "Emily Davis",
        category: "business",
        publishDate: Date().addingTimeInterval(-10800),
        readingTime: 4,
        imageURL: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=400",
        tags: ["Stock Market", "Economy", "Finance", "Investment"],
        rating: 4.4,
        viewCount: 1800
    ),
    Article(
        title: "Breakthrough in Cancer Treatment Shows Promising Results",
        summary: "New immunotherapy approach demonstrates significant improvement in patient survival rates.",
        content: "Researchers have reported a major breakthrough in cancer treatment using a novel immunotherapy approach. The new treatment, which combines targeted therapy with immune system enhancement, has shown remarkable results in clinical trials. Patients with previously untreatable cancers have experienced significant tumor reduction and improved survival rates. The treatment works by training the patient's own immune system to recognize and attack cancer cells more effectively. This development offers hope for millions of cancer patients worldwide and represents a significant advancement in personalized medicine.",
        author: "Dr. Lisa Brown",
        category: "health",
        publishDate: Date().addingTimeInterval(-14400),
        readingTime: 6,
        imageURL: "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=400",
        tags: ["Cancer", "Medicine", "Research", "Health"],
        rating: 4.9,
        viewCount: 3200
    ),
    Article(
        title: "New Streaming Service Launches with Exclusive Content",
        summary: "Major entertainment company enters the streaming market with original series and movies.",
        content: "A new streaming service has launched with an impressive lineup of original content and exclusive programming. The platform features award-winning series, blockbuster movies, and original documentaries from top creators. Subscribers will have access to thousands of hours of content, including both new releases and classic favorites. The service is available on multiple devices and offers various subscription tiers to suit different viewing preferences. Industry experts predict this will intensify competition in the already crowded streaming market.",
        author: "Tom Anderson",
        category: "entertainment",
        publishDate: Date().addingTimeInterval(-18000),
        readingTime: 3,
        imageURL: "https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?w=400",
        tags: ["Streaming", "Entertainment", "Movies", "TV Shows"],
        rating: 4.2,
        viewCount: 950
    ),
    Article(
        title: "Space Exploration Mission Discovers Water on Mars",
        summary: "Latest Mars rover mission confirms presence of liquid water beneath the planet's surface.",
        content: "In a historic discovery, NASA's latest Mars rover mission has confirmed the presence of liquid water beneath the planet's surface. Using advanced ground-penetrating radar technology, scientists have detected significant water deposits in the planet's polar regions. This discovery has major implications for future Mars exploration and the possibility of human colonization. The presence of water suggests that Mars may have once supported life and could potentially support future human settlements. Plans are already underway for follow-up missions to further study these water deposits and their potential for supporting life.",
        author: "Dr. Anna Garcia",
        category: "science",
        publishDate: Date().addingTimeInterval(-21600),
        readingTime: 8,
        imageURL: "https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=400",
        tags: ["Space", "Mars", "Water", "Exploration"],
        rating: 4.7,
        viewCount: 2800
    )
]

struct GenericLinkText_Previews: PreviewProvider {
    static var previews: some View {
        GenericLinkText()
    }
}

