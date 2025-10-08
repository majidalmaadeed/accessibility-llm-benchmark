import Cocoa

class SmallTouchTarget: NSViewController {
    
    @IBOutlet weak var tabSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var postsScrollView: NSScrollView!
    @IBOutlet weak var postsStackView: NSStackView!
    
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPosts()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Tab Navigation
        tabSegmentedControl.segmentCount = 3
        tabSegmentedControl.setLabel("Following", forSegment: 0)
        tabSegmentedControl.setLabel("Discover", forSegment: 1)
        tabSegmentedControl.setLabel("Trending", forSegment: 2)
        tabSegmentedControl.target = self
        tabSegmentedControl.action = #selector(tabChanged)
        
        // Posts Scroll View
        postsScrollView.hasVerticalScroller = true
        postsScrollView.hasHorizontalScroller = false
        postsScrollView.autohidesScrollers = true
        
        // Posts Stack View
        postsStackView.orientation = .vertical
        postsStackView.spacing = 16
        postsStackView.alignment = .fill
        postsStackView.distribution = .fill
    }
    
    private func loadPosts() {
        posts = [
            Post(username: "john_doe", timeAgo: "2h", content: "Beautiful sunset from my hike today! 🏔️ #nature #photography", likes: 42, comments: 8, isLiked: false, isBookmarked: false),
            Post(username: "sarah_j", timeAgo: "4h", content: "Just finished reading an amazing book! Highly recommend it to everyone.", likes: 28, comments: 12, isLiked: false, isBookmarked: false),
            Post(username: "mike_chen", timeAgo: "6h", content: "Working on a new project. Excited to share the results soon!", likes: 15, comments: 3, isLiked: false, isBookmarked: false)
        ]
        createPostViews()
    }
    
    private func createPostViews() {
        // Clear existing views
        postsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for post in posts {
            let postView = createPostView(for: post)
            postsStackView.addArrangedSubview(postView)
        }
    }
    
    private func createPostView(for post: Post) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.shadowOpacity = 0.2
        containerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        containerView.layer?.shadowRadius = 4
        
        // Profile Section
        let profileView = NSView()
        
        let profileImageView = NSImageView()
        profileImageView.image = NSImage(named: "profile_placeholder")
        profileImageView.imageScaling = .scaleProportionallyUpOrDown
        profileImageView.wantsLayer = true
        profileImageView.layer?.cornerRadius = 20
        profileImageView.layer?.backgroundColor = NSColor.systemBlue.cgColor
        
        let usernameLabel = NSTextField()
        usernameLabel.stringValue = post.username
        usernameLabel.font = NSFont.boldSystemFont(ofSize: 16)
        usernameLabel.isEditable = false
        usernameLabel.isBordered = false
        usernameLabel.backgroundColor = .clear
        
        let timeLabel = NSTextField()
        timeLabel.stringValue = post.timeAgo
        timeLabel.font = NSFont.systemFont(ofSize: 12)
        timeLabel.textColor = .secondaryLabelColor
        timeLabel.isEditable = false
        timeLabel.isBordered = false
        timeLabel.backgroundColor = .clear
        
        // SMALL TOUCH TARGET - Only 20x20px on mobile interface
        let moreButton = NSButton()
        moreButton.title = "⋯"
        moreButton.font = NSFont.systemFont(ofSize: 20)
        moreButton.target = self
        moreButton.action = #selector(moreButtonTapped)
        moreButton.frame = NSRect(x: 0, y: 0, width: 20, height: 20) // SMALL TOUCH TARGET
        moreButton.wantsLayer = true
        moreButton.layer?.backgroundColor = NSColor.systemGray.cgColor
        moreButton.layer?.cornerRadius = 4
        
        profileView.addSubview(profileImageView)
        profileView.addSubview(usernameLabel)
        profileView.addSubview(timeLabel)
        profileView.addSubview(moreButton)
        
        // Post Image
        let postImageView = NSImageView()
        postImageView.image = NSImage(named: "post_placeholder")
        postImageView.imageScaling = .scaleProportionallyUpOrDown
        postImageView.wantsLayer = true
        postImageView.layer?.cornerRadius = 8
        
        // Post Actions
        let actionsView = NSView()
        
        // SMALL TOUCH TARGET - Only 20x20px
        let likeButton = NSButton()
        likeButton.title = post.isLiked ? "♥" : "♡"
        likeButton.font = NSFont.systemFont(ofSize: 16)
        likeButton.target = self
        likeButton.action = #selector(likeButtonTapped)
        likeButton.frame = NSRect(x: 0, y: 0, width: 20, height: 20) // SMALL TOUCH TARGET
        likeButton.contentTintColor = post.isLiked ? .systemRed : .systemGray
        
        // SMALL TOUCH TARGET - Only 20x20px
        let commentButton = NSButton()
        commentButton.title = "💬"
        commentButton.font = NSFont.systemFont(ofSize: 16)
        commentButton.target = self
        commentButton.action = #selector(commentButtonTapped)
        commentButton.frame = NSRect(x: 0, y: 0, width: 20, height: 20) // SMALL TOUCH TARGET
        
        // SMALL TOUCH TARGET - Only 20x20px
        let shareButton = NSButton()
        shareButton.title = "↗️"
        shareButton.font = NSFont.systemFont(ofSize: 16)
        shareButton.target = self
        shareButton.action = #selector(shareButtonTapped)
        shareButton.frame = NSRect(x: 0, y: 0, width: 20, height: 20) // SMALL TOUCH TARGET
        
        // SMALL TOUCH TARGET - Only 20x20px
        let bookmarkButton = NSButton()
        bookmarkButton.title = post.isBookmarked ? "🔖" : "🔖"
        bookmarkButton.font = NSFont.systemFont(ofSize: 16)
        bookmarkButton.target = self
        bookmarkButton.action = #selector(bookmarkButtonTapped)
        bookmarkButton.frame = NSRect(x: 0, y: 0, width: 20, height: 20) // SMALL TOUCH TARGET
        bookmarkButton.contentTintColor = post.isBookmarked ? .systemBlue : .systemGray
        
        actionsView.addSubview(likeButton)
        actionsView.addSubview(commentButton)
        actionsView.addSubview(shareButton)
        actionsView.addSubview(bookmarkButton)
        
        // Likes Count
        let likesLabel = NSTextField()
        likesLabel.stringValue = "\(post.likes) likes"
        likesLabel.font = NSFont.boldSystemFont(ofSize: 14)
        likesLabel.isEditable = false
        likesLabel.isBordered = false
        likesLabel.backgroundColor = .clear
        
        // Post Content
        let contentLabel = NSTextField()
        contentLabel.stringValue = "\(post.username) \(post.content)"
        contentLabel.font = NSFont.systemFont(ofSize: 14)
        contentLabel.isEditable = false
        contentLabel.isBordered = false
        contentLabel.backgroundColor = .clear
        contentLabel.maximumNumberOfLines = 0
        
        // Comments Link
        let commentsLink = NSTextField()
        commentsLink.stringValue = "View all \(post.comments) comments"
        commentsLink.font = NSFont.systemFont(ofSize: 12)
        commentsLink.textColor = .secondaryLabelColor
        commentsLink.isEditable = false
        commentsLink.isBordered = false
        commentsLink.backgroundColor = .clear
        
        // Add all views to container
        containerView.addSubview(profileView)
        containerView.addSubview(postImageView)
        containerView.addSubview(actionsView)
        containerView.addSubview(likesLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(commentsLink)
        
        // Set up constraints
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLink.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Profile Section
            profileView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            profileView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            profileView.heightAnchor.constraint(equalToConstant: 40),
            
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            usernameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 8),
            timeLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            
            moreButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            moreButton.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 20),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            
            // Post Image
            postImageView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            postImageView.heightAnchor.constraint(equalToConstant: 300),
            
            // Actions
            actionsView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            actionsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            actionsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            actionsView.heightAnchor.constraint(equalToConstant: 20),
            
            likeButton.leadingAnchor.constraint(equalTo: actionsView.leadingAnchor),
            likeButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            commentButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor),
            commentButton.widthAnchor.constraint(equalToConstant: 20),
            commentButton.heightAnchor.constraint(equalToConstant: 20),
            
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 16),
            shareButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 20),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: actionsView.trailingAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            
            // Likes
            likesLabel.topAnchor.constraint(equalTo: actionsView.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Content
            contentLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Comments
            commentsLink.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            commentsLink.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            commentsLink.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            commentsLink.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    @objc private func tabChanged() {
        // Handle tab change
        createPostViews()
    }
    
    @objc private func moreButtonTapped() {
        // Handle more button
    }
    
    @objc private func likeButtonTapped() {
        // Handle like button
    }
    
    @objc private func commentButtonTapped() {
        // Handle comment button
    }
    
    @objc private func shareButtonTapped() {
        // Handle share button
    }
    
    @objc private func bookmarkButtonTapped() {
        // Handle bookmark button
    }
}

// MARK: - Post Model
struct Post {
    let username: String
    let timeAgo: String
    let content: String
    let likes: Int
    let comments: Int
    let isLiked: Bool
    let isBookmarked: Bool
}

// MARK: - Storyboard Support
extension SmallTouchTarget {
    static func instantiate() -> SmallTouchTarget {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "SmallTouchTarget") as! SmallTouchTarget
    }
}
