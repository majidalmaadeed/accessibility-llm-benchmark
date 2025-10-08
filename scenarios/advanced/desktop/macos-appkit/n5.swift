import Cocoa

class SocialMediaFeed: NSViewController {
    
    // MARK: - Properties
    private var posts: [Post] = []
    private var allPosts: [Post] = []
    private var currentFilter = "All"
    private var unreadNotifications = 3
    
    // MARK: - UI Elements
    @IBOutlet weak var filterComboBox: NSComboBox!
    @IBOutlet weak var notificationsButton: NSButton!
    @IBOutlet weak var trendingButton: NSButton!
    @IBOutlet weak var createPostTextField: NSTextField!
    @IBOutlet weak var createPostButton: NSButton!
    @IBOutlet weak var postsScrollView: NSScrollView!
    @IBOutlet weak var postsStackView: NSStackView!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var postCountLabel: NSTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSamplePosts()
        updatePostsDisplay()
        updateNotificationBadge()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure combo box
        filterComboBox.addItems(withObjectValues: ["All", "Following", "Trending"])
        filterComboBox.selectItem(at: 0)
        filterComboBox.target = self
        filterComboBox.action = #selector(filterChanged)
        
        // Configure buttons
        notificationsButton.target = self
        notificationsButton.action = #selector(notificationsButtonTapped)
        
        trendingButton.target = self
        trendingButton.action = #selector(trendingButtonTapped)
        
        createPostButton.target = self
        createPostButton.action = #selector(createPostButtonTapped)
        
        // Configure text field
        createPostTextField.target = self
        createPostTextField.action = #selector(createPostTextFieldAction)
        
        // Configure stack view
        postsStackView.orientation = .vertical
        postsStackView.spacing = 16
        postsStackView.alignment = .fill
        postsStackView.distribution = .fill
        
        // Setup menu
        setupMenu()
    }
    
    private func setupMenu() {
        // File menu
        let fileMenu = NSMenu(title: "File")
        fileMenu.addItem(NSMenuItem(title: "New Post", action: #selector(createPostButtonTapped), keyEquivalent: "n"))
        fileMenu.addItem(NSMenuItem(title: "Export Feed", action: #selector(exportFeed), keyEquivalent: "e"))
        
        // Edit menu
        let editMenu = NSMenu(title: "Edit")
        editMenu.addItem(NSMenuItem(title: "Copy Post", action: #selector(copyPost), keyEquivalent: "c"))
        editMenu.addItem(NSMenuItem(title: "Paste Post", action: #selector(pastePost), keyEquivalent: "v"))
        
        // View menu
        let viewMenu = NSMenu(title: "View")
        viewMenu.addItem(NSMenuItem(title: "Refresh Feed", action: #selector(refreshFeed), keyEquivalent: "r"))
        viewMenu.addItem(NSMenuItem(title: "Show Notifications", action: #selector(notificationsButtonTapped), keyEquivalent: ""))
        viewMenu.addItem(NSMenuItem(title: "Show Trending", action: #selector(trendingButtonTapped), keyEquivalent: ""))
    }
    
    // MARK: - Data Loading
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
    
    // MARK: - UI Updates
    private func updatePostsDisplay() {
        // Clear existing posts
        postsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for post in posts {
            let postView = createPostView(for: post)
            postsStackView.addArrangedSubview(postView)
        }
        
        postCountLabel.stringValue = "\(posts.count) posts"
    }
    
    private func createPostView(for post: Post) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.borderWidth = 1
        containerView.layer?.borderColor = NSColor.separatorColor.cgColor
        
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        // Header with user info
        let headerStack = NSStackView()
        headerStack.orientation = .horizontal
        headerStack.spacing = 12
        headerStack.alignment = .centerY
        
        let avatarLabel = NSTextField(labelWithString: post.user.avatar)
        avatarLabel.font = NSFont.systemFont(ofSize: 24)
        avatarLabel.isEditable = false
        avatarLabel.isBordered = false
        avatarLabel.backgroundColor = NSColor.clear
        
        let userInfoStack = NSStackView()
        userInfoStack.orientation = .vertical
        userInfoStack.spacing = 2
        userInfoStack.alignment = .leading
        
        let nameStack = NSStackView()
        nameStack.orientation = .horizontal
        nameStack.spacing = 4
        nameStack.alignment = .centerY
        
        let nameLabel = NSTextField(labelWithString: post.user.name)
        nameLabel.font = NSFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.isEditable = false
        nameLabel.isBordered = false
        nameLabel.backgroundColor = NSColor.clear
        
        let verifiedLabel = NSTextField(labelWithString: post.user.verified ? "✓" : "")
        verifiedLabel.font = NSFont.systemFont(ofSize: 14)
        verifiedLabel.textColor = NSColor.systemBlue
        verifiedLabel.isEditable = false
        verifiedLabel.isBordered = false
        verifiedLabel.backgroundColor = NSColor.clear
        
        let usernameLabel = NSTextField(labelWithString: post.user.username)
        usernameLabel.font = NSFont.systemFont(ofSize: 14)
        usernameLabel.textColor = NSColor.secondaryLabelColor
        usernameLabel.isEditable = false
        usernameLabel.isBordered = false
        usernameLabel.backgroundColor = NSColor.clear
        
        let timestampLabel = NSTextField(labelWithString: post.timestamp)
        timestampLabel.font = NSFont.systemFont(ofSize: 14)
        timestampLabel.textColor = NSColor.secondaryLabelColor
        timestampLabel.isEditable = false
        timestampLabel.isBordered = false
        timestampLabel.backgroundColor = NSColor.clear
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(verifiedLabel)
        
        userInfoStack.addArrangedSubview(nameStack)
        userInfoStack.addArrangedSubview(usernameLabel)
        userInfoStack.addArrangedSubview(timestampLabel)
        
        headerStack.addArrangedSubview(avatarLabel)
        headerStack.addArrangedSubview(userInfoStack)
        headerStack.addArrangedSubview(NSView()) // Spacer
        
        // Content
        let contentLabel = NSTextField(labelWithString: post.content)
        contentLabel.font = NSFont.systemFont(ofSize: 16)
        contentLabel.isEditable = false
        contentLabel.isBordered = false
        contentLabel.backgroundColor = NSColor.clear
        contentLabel.maximumNumberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        
        // Image (if present)
        var imageLabel: NSTextField?
        if !post.image.isEmpty {
            imageLabel = NSTextField(labelWithString: post.image)
            imageLabel?.font = NSFont.systemFont(ofSize: 48)
            imageLabel?.isEditable = false
            imageLabel?.isBordered = false
            imageLabel?.backgroundColor = NSColor.clear
            imageLabel?.alignment = .center
        }
        
        // Location
        var locationLabel: NSTextField?
        if !post.location.isEmpty {
            locationLabel = NSTextField(labelWithString: "📍 \(post.location)")
            locationLabel?.font = NSFont.systemFont(ofSize: 14)
            locationLabel?.textColor = NSColor.secondaryLabelColor
            locationLabel?.isEditable = false
            locationLabel?.isBordered = false
            locationLabel?.backgroundColor = NSColor.clear
        }
        
        // Actions
        let actionsStack = NSStackView()
        actionsStack.orientation = .horizontal
        actionsStack.spacing = 16
        actionsStack.alignment = .centerY
        actionsStack.distribution = .fillEqually
        
        let likeButton = NSButton(title: "❤️ \(post.likes)", target: self, action: #selector(likeButtonTapped))
        likeButton.tag = posts.firstIndex(where: { $0.id == post.id }) ?? 0
        likeButton.bezelStyle = .roundRect
        likeButton.font = NSFont.systemFont(ofSize: 14)
        if post.isLiked {
            likeButton.layer?.backgroundColor = NSColor.systemPink.cgColor
        }
        
        let commentButton = NSButton(title: "💬 \(post.comments)", target: self, action: #selector(commentButtonTapped))
        commentButton.tag = posts.firstIndex(where: { $0.id == post.id }) ?? 0
        commentButton.bezelStyle = .roundRect
        commentButton.font = NSFont.systemFont(ofSize: 14)
        
        let shareButton = NSButton(title: "🔄 \(post.shares)", target: self, action: #selector(shareButtonTapped))
        shareButton.tag = posts.firstIndex(where: { $0.id == post.id }) ?? 0
        shareButton.bezelStyle = .roundRect
        shareButton.font = NSFont.systemFont(ofSize: 14)
        
        let bookmarkButton = NSButton(title: post.isBookmarked ? "🔖" : "📌", target: self, action: #selector(bookmarkButtonTapped))
        bookmarkButton.tag = posts.firstIndex(where: { $0.id == post.id }) ?? 0
        bookmarkButton.bezelStyle = .roundRect
        bookmarkButton.font = NSFont.systemFont(ofSize: 14)
        if post.isBookmarked {
            bookmarkButton.layer?.backgroundColor = NSColor.systemBlue.cgColor
        }
        
        actionsStack.addArrangedSubview(likeButton)
        actionsStack.addArrangedSubview(commentButton)
        actionsStack.addArrangedSubview(shareButton)
        actionsStack.addArrangedSubview(bookmarkButton)
        
        // Add all elements to main stack
        stackView.addArrangedSubview(headerStack)
        stackView.addArrangedSubview(contentLabel)
        
        if let imageLabel = imageLabel {
            stackView.addArrangedSubview(imageLabel)
        }
        
        if let locationLabel = locationLabel {
            stackView.addArrangedSubview(locationLabel)
        }
        
        stackView.addArrangedSubview(actionsStack)
        
        // Add stack view to container
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func updateNotificationBadge() {
        if unreadNotifications > 0 {
            notificationsButton.layer?.backgroundColor = NSColor.systemRed.cgColor
            notificationsButton.layer?.cornerRadius = 4
        } else {
            notificationsButton.layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
    
    // MARK: - Actions
    @objc private func filterChanged() {
        currentFilter = filterComboBox.stringValue
        filterPosts()
    }
    
    private func filterPosts() {
        // In a real implementation, this would filter posts based on the selected filter
        posts = allPosts
        updatePostsDisplay()
    }
    
    @objc private func notificationsButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Notifications"
        alert.informativeText = "You have \(unreadNotifications) unread notifications"
        alert.runModal()
    }
    
    @objc private func trendingButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Trending"
        alert.informativeText = "Top trending topics:\n#ReactNative\n#MobileDev\n#Tech\n#Startup\n#Innovation"
        alert.runModal()
    }
    
    @objc private func createPostTextFieldAction() {
        createPostButton.isEnabled = !createPostTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    @objc private func createPostButtonTapped() {
        let content = createPostTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
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
        createPostTextField.stringValue = ""
        createPostButton.isEnabled = false
        updatePostsDisplay()
    }
    
    @objc private func likeButtonTapped(_ sender: NSButton) {
        let postIndex = sender.tag
        guard postIndex < posts.count else { return }
        
        posts[postIndex].isLiked.toggle()
        posts[postIndex].likes += posts[postIndex].isLiked ? 1 : -1
        
        // Update in allPosts as well
        if let allPostsIndex = allPosts.firstIndex(where: { $0.id == posts[postIndex].id }) {
            allPosts[allPostsIndex].isLiked = posts[postIndex].isLiked
            allPosts[allPostsIndex].likes = posts[postIndex].likes
        }
        
        updatePostsDisplay()
    }
    
    @objc private func commentButtonTapped(_ sender: NSButton) {
        let postIndex = sender.tag
        guard postIndex < posts.count else { return }
        
        let post = posts[postIndex]
        let alert = NSAlert()
        alert.messageText = "Comments"
        alert.informativeText = "Comments for: \(post.user.name)\n\n\(post.content)"
        alert.runModal()
    }
    
    @objc private func shareButtonTapped(_ sender: NSButton) {
        let postIndex = sender.tag
        guard postIndex < posts.count else { return }
        
        let post = posts[postIndex]
        let alert = NSAlert()
        alert.messageText = "Share"
        alert.informativeText = "Sharing: \(post.title)"
        alert.runModal()
    }
    
    @objc private func bookmarkButtonTapped(_ sender: NSButton) {
        let postIndex = sender.tag
        guard postIndex < posts.count else { return }
        
        posts[postIndex].isBookmarked.toggle()
        
        // Update in allPosts as well
        if let allPostsIndex = allPosts.firstIndex(where: { $0.id == posts[postIndex].id }) {
            allPosts[allPostsIndex].isBookmarked = posts[postIndex].isBookmarked
        }
        
        updatePostsDisplay()
    }
    
    // MARK: - Menu Actions
    @objc private func exportFeed() {
        let alert = NSAlert()
        alert.messageText = "Export Feed"
        alert.informativeText = "Feed export functionality would be implemented here."
        alert.runModal()
    }
    
    @objc private func copyPost() {
        let selectedRow = postsStackView.arrangedSubviews.count - 1 // Last post for demo
        if selectedRow >= 0 && selectedRow < posts.count {
            let post = posts[selectedRow]
            let pasteboard = NSPasteboard.general
            pasteboard.clearContents()
            pasteboard.setString(post.content, forType: .string)
        }
    }
    
    @objc private func pastePost() {
        let pasteboard = NSPasteboard.general
        if let content = pasteboard.string(forType: .string) {
            createPostTextField.stringValue = content
            createPostButton.isEnabled = !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    @objc private func refreshFeed() {
        // Simulate refresh
        statusLabel.stringValue = "Feed refreshed"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.statusLabel.stringValue = "Ready"
        }
    }
}

// MARK: - User Model
struct User {
    let id: String
    let name: String
    let username: String
    let avatar: String
    let verified: Bool
}

// MARK: - Post Model
struct Post {
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
