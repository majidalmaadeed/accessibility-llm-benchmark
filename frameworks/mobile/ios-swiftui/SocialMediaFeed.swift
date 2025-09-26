import SwiftUI

struct SocialMediaFeed: View {
    @State private var posts: [SocialPost] = []
    @State private var showCreatePost: Bool = false
    @State private var isLoading: Bool = false
    @State private var currentFilter: FeedFilter = .all
    @State private var unreadNotifications: Int = 3
    @State private var newPost = PostDraft()
    @State private var isPublishing: Bool = false
    @State private var newComment: [UUID: String] = [:]
    @State private var showPostMenu: UUID? = nil
    @State private var selectedPost: SocialPost? = nil
    
    let filters: [FeedFilter] = [.all, .following, .trending]
    let trendingTopics = [
        TrendingTopic(name: "technology", count: 12500),
        TrendingTopic(name: "design", count: 8900),
        TrendingTopic(name: "programming", count: 15600),
        TrendingTopic(name: "startup", count: 6700),
        TrendingTopic(name: "innovation", count: 4200)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                filterView
                
                if isLoading {
                    loadingView
                } else if posts.isEmpty {
                    emptyStateView
                } else {
                    feedView
                }
            }
            .navigationTitle("Social Feed")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadPosts()
            }
        }
        .sheet(isPresented: $showCreatePost) {
            CreatePostView(
                post: $newPost,
                isPublishing: $isPublishing,
                onPublish: { publishPost() }
            )
        }
        .sheet(item: $selectedPost) { post in
            PostDetailView(post: post)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Social Feed")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { showCreatePost = true }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: { loadPosts() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .buttonStyle(.bordered)
                    
                    ZStack {
                        Button(action: { /* Show notifications */ }) {
                            Image(systemName: "bell")
                        }
                        .buttonStyle(.bordered)
                        
                        if unreadNotifications > 0 {
                            Text("\(unreadNotifications)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 12, y: -12)
                        }
                    }
                }
            }
            
            Text("Stay connected with your network")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var filterView: some View {
        HStack {
            ForEach(filters, id: \.self) { filter in
                Button(filter.displayName) {
                    currentFilter = filter
                    loadPosts()
                }
                .buttonStyle(filter == currentFilter ? .borderedProminent : .bordered)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading posts...")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No posts yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Be the first to share something with your network")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Create Post") {
                showCreatePost = true
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var feedView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(filteredPosts) { post in
                    PostCardView(
                        post: post,
                        newComment: Binding(
                            get: { newComment[post.id] ?? "" },
                            set: { newComment[post.id] = $0 }
                        ),
                        showMenu: showPostMenu == post.id,
                        onLike: { toggleLike(post.id) },
                        onShare: { sharePost(post) },
                        onComment: { toggleComment(post.id) },
                        onAddComment: { addComment(post.id) },
                        onShowMenu: { showPostMenu = showPostMenu == post.id ? nil : post.id },
                        onSelectPost: { selectedPost = post }
                    )
                }
            }
            .padding()
        }
    }
    
    // MARK: - Computed Properties
    
    private var filteredPosts: [SocialPost] {
        var filtered = posts
        
        switch currentFilter {
        case .all:
            break
        case .following:
            // Filter to show only posts from followed users
            break
        case .trending:
            filtered = filtered.sorted { (post1, post2) in
                let engagement1 = post1.likes + post1.shares + post1.comments.count
                let engagement2 = post2.likes + post2.shares + post2.comments.count
                return engagement1 > engagement2
            }
        }
        
        return filtered
    }
    
    // MARK: - Methods
    
    private func loadPosts() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            posts = generateSamplePosts()
            isLoading = false
        }
    }
    
    private func publishPost() {
        guard !newPost.content.isEmpty else { return }
        
        isPublishing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let newPostData = SocialPost(
                id: UUID(),
                user: currentUser,
                content: newPost.content,
                image: newPost.image,
                location: newPost.location,
                timestamp: Date(),
                likes: 0,
                shares: 0,
                comments: [],
                isLiked: false,
                isShared: false
            )
            
            posts.insert(newPostData, at: 0)
            newPost = PostDraft()
            isPublishing = false
            showCreatePost = false
        }
    }
    
    private func toggleLike(_ postId: UUID) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
        }
    }
    
    private func sharePost(_ post: SocialPost) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isShared.toggle()
            posts[index].shares += posts[index].isShared ? 1 : -1
        }
    }
    
    private func toggleComment(_ postId: UUID) {
        // Toggle comment section visibility
    }
    
    private func addComment(_ postId: UUID) {
        guard let commentText = newComment[postId], !commentText.isEmpty else { return }
        
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            let newCommentData = PostComment(
                id: UUID(),
                user: currentUser,
                text: commentText,
                timestamp: Date()
            )
            
            posts[index].comments.append(newCommentData)
            newComment[postId] = ""
        }
    }
    
    private func generateSamplePosts() -> [SocialPost] {
        [
            SocialPost(
                id: UUID(),
                user: User(
                    id: UUID(),
                    name: "Jane Smith",
                    username: "janesmith",
                    avatar: "person.circle.fill",
                    isFollowing: false
                ),
                content: "Just finished building an amazing new feature for our app! The team collaboration has been incredible. #coding #teamwork #innovation",
                image: "photo.fill",
                location: "San Francisco, CA",
                timestamp: Date().addingTimeInterval(-2 * 3600),
                likes: 24,
                shares: 8,
                comments: [
                    PostComment(
                        id: UUID(),
                        user: currentUser,
                        text: "Great work! Looking forward to seeing it in action.",
                        timestamp: Date().addingTimeInterval(-1 * 3600)
                    )
                ],
                isLiked: false,
                isShared: false
            ),
            SocialPost(
                id: UUID(),
                user: User(
                    id: UUID(),
                    name: "Mike Johnson",
                    username: "mikej",
                    avatar: "person.circle.fill",
                    isFollowing: false
                ),
                content: "Beautiful sunset from my office window today. Sometimes you need to take a moment to appreciate the little things. 🌅",
                image: "photo.fill",
                location: "New York, NY",
                timestamp: Date().addingTimeInterval(-4 * 3600),
                likes: 156,
                shares: 23,
                comments: [],
                isLiked: true,
                isShared: false
            ),
            SocialPost(
                id: UUID(),
                user: User(
                    id: UUID(),
                    name: "Sarah Wilson",
                    username: "sarahw",
                    avatar: "person.circle.fill",
                    isFollowing: true
                ),
                content: "Excited to announce that our startup just secured Series A funding! 🎉 Thank you to all our supporters and the amazing team that made this possible.",
                image: nil,
                location: "Austin, TX",
                timestamp: Date().addingTimeInterval(-6 * 3600),
                likes: 89,
                shares: 45,
                comments: [
                    PostComment(
                        id: UUID(),
                        user: User(
                            id: UUID(),
                            name: "Jane Smith",
                            username: "janesmith",
                            avatar: "person.circle.fill",
                            isFollowing: false
                        ),
                        text: "Congratulations! This is amazing news! 🎉",
                        timestamp: Date().addingTimeInterval(-5 * 3600)
                    ),
                    PostComment(
                        id: UUID(),
                        user: User(
                            id: UUID(),
                            name: "Mike Johnson",
                            username: "mikej",
                            avatar: "person.circle.fill",
                            isFollowing: false
                        ),
                        text: "Well deserved! Your product is incredible.",
                        timestamp: Date().addingTimeInterval(-4 * 3600)
                    )
                ],
                isLiked: false,
                isShared: true
            )
        ]
    }
    
    private var currentUser: User {
        User(
            id: UUID(),
            name: "John Doe",
            username: "johndoe",
            avatar: "person.circle.fill",
            isFollowing: false
        )
    }
}

// MARK: - Supporting Views

struct PostCardView: View {
    let post: SocialPost
    @Binding var newComment: String
    let showMenu: Bool
    let onLike: () -> Void
    let onShare: () -> Void
    let onComment: () -> Void
    let onAddComment: () -> Void
    let onShowMenu: () -> Void
    let onSelectPost: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Post Header
            HStack {
                Image(systemName: post.user.avatar)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("@\(post.user.username) • \(formatTime(post.timestamp))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: onShowMenu) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            
            // Post Content
            VStack(alignment: .leading, spacing: 8) {
                Text(post.content)
                    .font(.body)
                    .lineLimit(nil)
                
                if let image = post.image {
                    Image(systemName: image)
                        .font(.system(size: 200))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                if let location = post.location {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.secondary)
                        Text(location)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Post Actions
            HStack(spacing: 20) {
                Button(action: onLike) {
                    HStack(spacing: 4) {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(post.isLiked ? .red : .secondary)
                        Text("\(post.likes)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(.plain)
                
                Button(action: onComment) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left")
                            .foregroundColor(.secondary)
                        Text("\(post.comments.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(.plain)
                
                Button(action: onShare) {
                    HStack(spacing: 4) {
                        Image(systemName: post.isShared ? "arrow.2.squarepath.fill" : "arrow.2.squarepath")
                            .foregroundColor(post.isShared ? .blue : .secondary)
                        Text("\(post.shares)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            
            // Comments Section
            if !post.comments.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(post.comments) { comment in
                        CommentView(comment: comment)
                    }
                }
            }
            
            // Add Comment
            HStack {
                Image(systemName: currentUser.avatar)
                    .font(.caption)
                    .foregroundColor(.blue)
                    .frame(width: 24, height: 24)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                TextField("Write a comment...", text: $newComment)
                    .textFieldStyle(.roundedBorder)
                
                Button("Post") {
                    onAddComment()
                }
                .buttonStyle(.bordered)
                .disabled(newComment.isEmpty)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onSelectPost()
        }
    }
    
    private var currentUser: User {
        User(
            id: UUID(),
            name: "John Doe",
            username: "johndoe",
            avatar: "person.circle.fill",
            isFollowing: false
        )
    }
    
    private func formatTime(_ date: Date) -> String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(date)
        
        if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "\(minutes)m"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return "\(hours)h"
        } else {
            let days = Int(timeInterval / 86400)
            return "\(days)d"
        }
    }
}

struct CommentView: View {
    let comment: PostComment
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: comment.user.avatar)
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(comment.user.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(comment.text)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text(formatTime(comment.timestamp))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(date)
        
        if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "\(minutes)m"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return "\(hours)h"
        } else {
            let days = Int(timeInterval / 86400)
            return "\(days)d"
        }
    }
}

struct CreatePostView: View {
    @Binding var post: PostDraft
    @Binding var isPublishing: Bool
    let onPublish: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .frame(width: 40, height: 40)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("John Doe")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("@johndoe")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                TextEditor(text: $post.content)
                    .font(.body)
                    .frame(minHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                
                if let image = post.image {
                    Image(systemName: image)
                        .font(.system(size: 100))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                HStack {
                    Button("Add Photo") {
                        // Add photo logic
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Add Location") {
                        post.location = "Current Location"
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Text("\(post.content.count)/280")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isPublishing ? "Publishing..." : "Post") {
                        onPublish()
                    }
                    .disabled(post.content.isEmpty || isPublishing)
                }
            }
        }
    }
}

struct PostDetailView: View {
    let post: SocialPost
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Post content would go here
                    Text("Post Details")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(post.content)
                        .font(.body)
                }
                .padding()
            }
            .navigationTitle("Post")
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

// MARK: - Supporting Types

enum FeedFilter: CaseIterable {
    case all, following, trending
    
    var displayName: String {
        switch self {
        case .all: return "All"
        case .following: return "Following"
        case .trending: return "Trending"
        }
    }
}

struct User {
    let id: UUID
    let name: String
    let username: String
    let avatar: String
    let isFollowing: Bool
}

struct SocialPost: Identifiable {
    let id: UUID
    let user: User
    let content: String
    let image: String?
    let location: String?
    let timestamp: Date
    let likes: Int
    let shares: Int
    let comments: [PostComment]
    let isLiked: Bool
    let isShared: Bool
}

struct PostComment: Identifiable {
    let id: UUID
    let user: User
    let text: String
    let timestamp: Date
}

struct PostDraft {
    var content: String = ""
    var image: String? = nil
    var location: String? = nil
}

struct TrendingTopic {
    let name: String
    let count: Int
}

struct SocialMediaFeed_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaFeed()
    }
}
