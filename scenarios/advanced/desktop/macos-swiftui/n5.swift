import SwiftUI

struct SocialMediaFeed: View {
    @State private var posts: [Post] = []
    @State private var allPosts: [Post] = []
    @State private var currentFilter = "All"
    @State private var unreadNotifications = 3
    @State private var createPostText = ""
    @State private var showingCreatePost = false
    @State private var showingNotifications = false
    @State private var showingTrending = false
    @State private var selectedPost: Post?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            // Create Post
            createPostView
            
            // Posts Feed
            postsFeedView
            
            // Status Bar
            statusBarView
        }
        .onAppear {
            loadSamplePosts()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Social Media Feed")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 12) {
                Picker("Filter", selection: $currentFilter) {
                    Text("All").tag("All")
                    Text("Following").tag("Following")
                    Text("Trending").tag("Trending")
                }
                .pickerStyle(.menu)
                .frame(width: 140)
                
                Button("🔔") {
                    showingNotifications = true
                }
                .buttonStyle(.bordered)
                .overlay(
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .offset(x: 8, y: -8)
                        .opacity(unreadNotifications > 0 ? 1 : 0)
                )
                
                Button("📈") {
                    showingTrending = true
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(20)
        .background(Color.accentColor)
    }
    
    private var createPostView: some View {
        HStack(spacing: 16) {
            // Avatar
            Circle()
                .fill(Color.accentColor)
                .frame(width: 48, height: 48)
                .overlay(
                    Text("👤")
                        .font(.title2)
                )
            
            // Text Field
            HStack {
                TextField("What's on your mind?", text: $createPostText, axis: .vertical)
                    .textFieldStyle(.plain)
                    .lineLimit(1...4)
                
                Button("Post") {
                    createPost()
                }
                .buttonStyle(.borderedProminent)
                .disabled(createPostText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color(.controlBackgroundColor))
    }
    
    private var postsFeedView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(posts, id: \.id) { post in
                    PostCard(post: post) { action in
                        handlePostAction(action, for: post)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Ready")
            
            Spacer()
            
            Text("\(posts.count) posts")
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    // MARK: - Methods
    private func loadSamplePosts() {
        allPosts = [
            Post(
                id: "1",
                user: User(id: "user1", name: "John Doe", username: "@johndoe", avatar: "👨‍💻", verified: true),
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
                user: User(id: "user2", name: "Sarah Wilson", username: "@sarahw", avatar: "👩‍🎨", verified: false),
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
                user: User(id: "user3", name: "Mike Chen", username: "@mikechen", avatar: "👨‍💼", verified: true),
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
                user: User(id: "user4", name: "Emma Davis", username: "@emmad", avatar: "👩‍🔬", verified: false),
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
                user: User(id: "user5", name: "Alex Rodriguez", username: "@alexr", avatar: "👨‍🎓", verified: false),
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
        
        posts = allPosts
    }
    
    private func createPost() {
        let content = createPostText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !content.isEmpty else { return }
        
        let newPost = Post(
            id: UUID().uuidString,
            user: User(id: "current-user", name: "You", username: "@you", avatar: "👤", verified: false),
            content: content,
            image: "",
            location: "",
            timestamp: "now",
            likes: 0,
            comments: 0,
            shares: 0,
            isLiked: false,
            isBookmarked: false,
            privacy: "public"
        )
        
        posts.insert(newPost, at: 0)
        allPosts.insert(newPost, at: 0)
        createPostText = ""
    }
    
    private func handlePostAction(_ action: PostAction, for post: Post) {
        switch action {
        case .like:
            toggleLike(for: post)
        case .comment:
            showComments(for: post)
        case .share:
            sharePost(post)
        case .bookmark:
            toggleBookmark(for: post)
        }
    }
    
    private func toggleLike(for post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
            
            // Update in allPosts as well
            if let allPostsIndex = allPosts.firstIndex(where: { $0.id == post.id }) {
                allPosts[allPostsIndex].isLiked = posts[index].isLiked
                allPosts[allPostsIndex].likes = posts[index].likes
            }
        }
    }
    
    private func showComments(for post: Post) {
        selectedPost = post
        // In a real implementation, this would show a comments view
    }
    
    private func sharePost(_ post: Post) {
        // Share implementation
    }
    
    private func toggleBookmark(for post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isBookmarked.toggle()
            
            // Update in allPosts as well
            if let allPostsIndex = allPosts.firstIndex(where: { $0.id == post.id }) {
                allPosts[allPostsIndex].isBookmarked = posts[index].isBookmarked
            }
        }
    }
}

// MARK: - Supporting Views
struct PostCard: View {
    let post: Post
    let onAction: (PostAction) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                // Avatar
                Text(post.user.avatar)
                    .font(.title)
                
                // User Info
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(post.user.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        if post.user.verified {
                            Image(systemName: "checkmark.circle.fill")
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
            }
            
            // Content
            Text(post.content)
                .font(.body)
            
            // Image
            if !post.image.isEmpty {
                Text(post.image)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.controlBackgroundColor))
                    .cornerRadius(8)
            }
            
            // Location
            if !post.location.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Text(post.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Actions
            HStack(spacing: 16) {
                ActionButton(
                    icon: post.isLiked ? "heart.fill" : "heart",
                    text: "\(post.likes)",
                    color: post.isLiked ? .red : .secondary
                ) {
                    onAction(.like)
                }
                
                ActionButton(
                    icon: "message",
                    text: "\(post.comments)",
                    color: .secondary
                ) {
                    onAction(.comment)
                }
                
                ActionButton(
                    icon: "arrow.clockwise",
                    text: "\(post.shares)",
                    color: .secondary
                ) {
                    onAction(.share)
                }
                
                ActionButton(
                    icon: post.isBookmarked ? "bookmark.fill" : "bookmark",
                    text: "",
                    color: post.isBookmarked ? .blue : .secondary
                ) {
                    onAction(.bookmark)
                }
                
                Spacer()
            }
        }
        .padding(16)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(12)
    }
}

struct ActionButton: View {
    let icon: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                
                if !text.isEmpty {
                    Text(text)
                        .font(.caption)
                }
            }
            .foregroundColor(color)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Notifications View
struct NotificationsView: View {
    @Binding var isPresented: Bool
    let unreadCount: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Notifications")
                .font(.title)
                .fontWeight(.bold)
            
            Text("You have \(unreadCount) unread notifications")
                .font(.body)
                .foregroundColor(.secondary)
            
            // In a real implementation, this would show actual notifications
            VStack(alignment: .leading, spacing: 8) {
                NotificationRow(title: "New like on your post", time: "2m ago")
                NotificationRow(title: "John Doe commented on your post", time: "5m ago")
                NotificationRow(title: "Sarah Wilson shared your post", time: "1h ago")
            }
            
            HStack {
                Button("Mark All Read") {
                    // Mark all as read
                }
                .buttonStyle(.bordered)
                
                Button("Close") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 400, height: 300)
    }
}

struct NotificationRow: View {
    let title: String
    let time: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(8)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(6)
    }
}

// MARK: - Trending View
struct TrendingView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 12) {
                TrendingTopic(topic: "#ReactNative", posts: "2.3K posts")
                TrendingTopic(topic: "#MobileDev", posts: "1.8K posts")
                TrendingTopic(topic: "#Tech", posts: "3.1K posts")
                TrendingTopic(topic: "#Startup", posts: "1.2K posts")
                TrendingTopic(topic: "#Innovation", posts: "956 posts")
            }
            
            HStack {
                Button("Close") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
        }
        .padding(20)
        .frame(width: 300, height: 250)
    }
}

struct TrendingTopic: View {
    let topic: String
    let posts: String
    
    var body: some View {
        HStack {
            Text(topic)
                .font(.headline)
                .foregroundColor(.accentColor)
            
            Spacer()
            
            Text(posts)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color(.controlBackgroundColor))
        .cornerRadius(6)
    }
}

// MARK: - Models
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
    
    var title: String {
        return content.count > 50 ? String(content.prefix(50)) + "..." : content
    }
}

enum PostAction {
    case like
    case comment
    case share
    case bookmark
}

// MARK: - Preview
struct SocialMediaFeed_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaFeed()
    }
}
