import SwiftUI

struct SocialMediaFeed: View {
    @State private var posts: [Post] = []
    @State private var currentFilter: FilterType = .all
    @State private var unreadNotifications = 3
    @State private var isLoading = false
    @State private var showCreatePost = false
    @State private var showPostDetails = false
    @State private var selectedPost: Post?
    @State private var newPost = NewPost()
    
    enum FilterType: String, CaseIterable {
        case all = "all"
        case following = "following"
        case trending = "trending"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Tabs
                filterTabsView
                
                // Posts List
                if isLoading {
                    loadingView
                } else if posts.isEmpty {
                    emptyStateView
                } else {
                    postsListView
                }
            }
            .navigationTitle("Social Feed")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onNotificationsClicked) {
                        ZStack {
                            Image(systemName: "bell")
                            if unreadNotifications > 0 {
                                Text("\(unreadNotifications)")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onTrendingClicked) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            .sheet(isPresented: $showCreatePost) {
                CreatePostView(
                    newPost: $newPost,
                    isPresented: $showCreatePost
                ) {
                    publishPost()
                }
            }
            .sheet(isPresented: $showPostDetails) {
                if let post = selectedPost {
                    PostDetailsView(
                        post: post,
                        isPresented: $showPostDetails
                    )
                }
            }
            .onAppear {
                loadPosts()
            }
        }
        .overlay(
            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showCreatePost = true }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                }
            }
        )
    }
    
    private var filterTabsView: some View {
        Picker("Filter", selection: $currentFilter) {
            ForEach(FilterType.allCases, id: \.self) { filter in
                Text(filter.rawValue.capitalized).tag(filter)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.2)
            Text("Loading posts...")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "newspaper")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            Text("No posts yet")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Be the first to share something!")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Create Post") {
                showCreatePost = true
            }
            .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    private var postsListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(posts, id: \.id) { post in
                    PostCardView(post: post) {
                        selectedPost = post
                        showPostDetails = true
                    } onLike: {
                        toggleLike(post.id)
                    } onComment: {
                        selectedPost = post
                        showPostDetails = true
                    } onShare: {
                        sharePost(post)
                    } onBookmark: {
                        toggleBookmark(post.id)
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadPosts() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            posts = generateSamplePosts()
            isLoading = false
        }
    }
    
    private func generateSamplePosts() -> [Post] {
        [
            Post(
                id: "1",
                user: User(
                    id: "user1",
                    name: "John Doe",
                    username: "@johndoe",
                    avatar: "👨‍💻",
                    verified: true
                ),
                content: "Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech",
                image: "📱",
                location: "San Francisco, CA",
                timestamp: "2h ago",
                likes: 42,
                comments: 8,
                shares: 3,
                isLiked: false,
                isBookmarked: false,
                privacy: "public"
            ),
            Post(
                id: "2",
                user: User(
                    id: "user2",
                    name: "Sarah Wilson",
                    username: "@sarahw",
                    avatar: "👩‍🎨",
                    verified: false
                ),
                content: "Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅",
                image: "🌅",
                location: "New York, NY",
                timestamp: "4h ago",
                likes: 28,
                comments: 5,
                shares: 1,
                isLiked: true,
                isBookmarked: false,
                privacy: "public"
            ),
            Post(
                id: "3",
                user: User(
                    id: "user3",
                    name: "Mike Chen",
                    username: "@mikechen",
                    avatar: "👨‍💼",
                    verified: true
                ),
                content: "Excited to announce our new product launch! After months of hard work, we're finally ready to share it with the world. #Startup #Innovation",
                image: "🚀",
                location: "Austin, TX",
                timestamp: "6h ago",
                likes: 156,
                comments: 23,
                shares: 12,
                isLiked: false,
                isBookmarked: true,
                privacy: "public"
            ),
            Post(
                id: "4",
                user: User(
                    id: "user4",
                    name: "Emma Davis",
                    username: "@emmad",
                    avatar: "👩‍🔬",
                    verified: false
                ),
                content: "Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?",
                image: "🤖",
                location: "Boston, MA",
                timestamp: "8h ago",
                likes: 73,
                comments: 15,
                shares: 7,
                isLiked: true,
                isBookmarked: false,
                privacy: "public"
            ),
            Post(
                id: "5",
                user: User(
                    id: "user5",
                    name: "Alex Rodriguez",
                    username: "@alexr",
                    avatar: "👨‍🎓",
                    verified: false
                ),
                content: "Coffee and code - the perfect combination for a productive day! ☕️💻",
                image: "☕️",
                location: "Seattle, WA",
                timestamp: "10h ago",
                likes: 34,
                comments: 6,
                shares: 2,
                isLiked: false,
                isBookmarked: false,
                privacy: "public"
            )
        ]
    }
    
    // MARK: - Actions
    
    private func onNotificationsClicked() {
        // Handle notifications
        print("Notifications clicked")
    }
    
    private func onTrendingClicked() {
        // Handle trending
        print("Trending clicked")
    }
    
    private func publishPost() {
        let post = Post(
            id: UUID().uuidString,
            user: User(
                id: "current-user",
                name: "You",
                username: "@you",
                avatar: "👤",
                verified: false
            ),
            content: newPost.content,
            image: newPost.image,
            location: newPost.location,
            timestamp: "now",
            likes: 0,
            comments: 0,
            shares: 0,
            isLiked: false,
            isBookmarked: false,
            privacy: newPost.privacy
        )
        
        posts.insert(post, at: 0)
        newPost = NewPost()
    }
    
    private func toggleLike(_ postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
        }
    }
    
    private func sharePost(_ post: Post) {
        // Handle share
        print("Sharing post: \(post.content)")
    }
    
    private func toggleBookmark(_ postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isBookmarked.toggle()
        }
    }
}

// MARK: - Supporting Views

struct PostCardView: View {
    let post: Post
    let onTap: () -> Void
    let onLike: () -> Void
    let onComment: () -> Void
    let onShare: () -> Void
    let onBookmark: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Post Header
            postHeaderView
            
            // Post Content
            postContentView
            
            // Post Actions
            postActionsView
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onTapGesture {
            onTap()
        }
    }
    
    private var postHeaderView: some View {
        HStack(alignment: .top) {
            // User Avatar
            Text(post.user.avatar)
                .font(.system(size: 32))
                .frame(width: 48, height: 48)
                .background(Color(.systemGray6))
                .cornerRadius(24)
            
            // User Info
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(post.user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    if post.user.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }
                }
                
                Text(post.user.username)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(post.timestamp)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // More Button
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var postContentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.content)
                .font(.body)
                .lineSpacing(2)
            
            if !post.image.isEmpty {
                Text(post.image)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            if !post.location.isEmpty {
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(post.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var postActionsView: some View {
        HStack(spacing: 24) {
            Button(action: onLike) {
                HStack(spacing: 4) {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.isLiked ? .red : .gray)
                    Text("\(post.likes)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Button(action: onComment) {
                HStack(spacing: 4) {
                    Image(systemName: "bubble.right")
                        .foregroundColor(.gray)
                    Text("\(post.comments)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Button(action: onShare) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.2.squarepath")
                        .foregroundColor(.gray)
                    Text("\(post.shares)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: onBookmark) {
                Image(systemName: post.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(post.isBookmarked ? .blue : .gray)
            }
        }
        .padding(.top, 8)
        .padding(.horizontal, 4)
    }
}

struct CreatePostView: View {
    @Binding var newPost: NewPost
    @Binding var isPresented: Bool
    let onPublish: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // User Info
                HStack {
                    Text("👤")
                        .font(.system(size: 32))
                        .frame(width: 48, height: 48)
                        .background(Color(.systemGray6))
                        .cornerRadius(24)
                    
                    VStack(alignment: .leading) {
                        Text("You")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("What's on your mind?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
                
                // Content
                TextEditor(text: $newPost.content)
                    .font(.body)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Location
                HStack {
                    Image(systemName: "location")
                        .foregroundColor(.gray)
                    TextField("Add location", text: $newPost.location)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.horizontal)
                
                // Privacy
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.gray)
                    Picker("Privacy", selection: $newPost.privacy) {
                        Text("Public").tag("public")
                        Text("Friends Only").tag("friends")
                        Text("Private").tag("private")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        onPublish()
                        isPresented = false
                    }
                    .disabled(newPost.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

struct PostDetailsView: View {
    let post: Post
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Post Header
                    HStack {
                        Text(post.user.avatar)
                            .font(.system(size: 32))
                            .frame(width: 48, height: 48)
                            .background(Color(.systemGray6))
                            .cornerRadius(24)
                        
                        VStack(alignment: .leading) {
                            Text(post.user.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text(post.user.username)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(post.timestamp)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    // Post Content
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.content)
                            .font(.body)
                            .lineSpacing(2)
                        
                        if !post.image.isEmpty {
                            Text(post.image)
                                .font(.system(size: 48))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                        
                        if !post.location.isEmpty {
                            HStack {
                                Image(systemName: "location")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                Text(post.location)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    // Engagement Stats
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Engagement")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 16) {
                            Text("\(post.likes) likes")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(post.comments) comments")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(post.shares) shares")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Post Details")
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

// MARK: - Data Models

struct User {
    let id: String
    let name: String
    let username: String
    let avatar: String
    let verified: Bool
}

struct Post: Identifiable {
    let id: String
    let user: User
    let content: String
    let image: String
    let location: String
    let timestamp: String
    var likes: Int
    let comments: Int
    let shares: Int
    var isLiked: Bool
    var isBookmarked: Bool
    let privacy: String
    
    var hasImage: Bool {
        !image.isEmpty
    }
    
    var hasLocation: Bool {
        !location.isEmpty
    }
}

struct NewPost {
    var content: String = ""
    var image: String = ""
    var location: String = ""
    var privacy: String = "public"
}

#Preview {
    SocialMediaFeed()
}