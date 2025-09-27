import UIKit

class SocialMediaFeedViewController: UIViewController {
    
    // MARK: - Properties
    private var posts: [Post] = []
    private var currentFilter: FilterType = .all
    private var unreadNotifications = 3
    private var isLoading = false
    
    enum FilterType: String, CaseIterable {
        case all = "all"
        case following = "following"
        case trending = "trending"
    }
    
    // MARK: - UI Components
    private lazy var filterSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: FilterType.allCases.map { $0.rawValue.capitalized })
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(systemName: "newspaper")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "No posts yet"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = "Be the first to share something!"
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let createButton = UIButton(type: .system)
        createButton.setTitle("Create Post", for: .normal)
        createButton.addTarget(self, action: #selector(createPostTapped), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            createButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    private lazy var floatingActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(createPostTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Data
    private let samplePosts = [
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
        )
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPosts()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Social Feed"
        
        // Navigation bar setup
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationsTapped)),
            UIBarButtonItem(image: UIImage(systemName: "chart.line.uptrend.xyaxis"), style: .plain, target: self, action: #selector(trendingTapped))
        ]
        
        // Add subviews
        view.addSubview(filterSegmentedControl)
        view.addSubview(postsTableView)
        view.addSubview(loadingIndicator)
        view.addSubview(emptyStateView)
        view.addSubview(floatingActionButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Filter Segmented Control
            filterSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Posts Table View
            postsTableView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 16),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Loading Indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Empty State View
            emptyStateView.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 16),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Floating Action Button
            floatingActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            floatingActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingActionButton.widthAnchor.constraint(equalToConstant: 56),
            floatingActionButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Data Loading
    private func loadPosts() {
        isLoading = true
        loadingIndicator.startAnimating()
        postsTableView.isHidden = true
        emptyStateView.isHidden = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.posts = self.samplePosts
            self.isLoading = false
            self.loadingIndicator.stopAnimating()
            self.postsTableView.isHidden = false
            self.postsTableView.reloadData()
            self.updateEmptyState()
        }
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !posts.isEmpty
    }
    
    // MARK: - Actions
    @objc private func filterChanged() {
        currentFilter = FilterType.allCases[filterSegmentedControl.selectedSegmentIndex]
        // In a real implementation, this would filter posts
    }
    
    @objc private func notificationsTapped() {
        let alert = UIAlertController(title: "Notifications", message: "You have \(unreadNotifications) unread notifications", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func trendingTapped() {
        let alert = UIAlertController(title: "Trending", message: "Top trending topics", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func createPostTapped() {
        let alert = UIAlertController(title: "Create Post", message: "What's on your mind?", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Write something..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Post", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.createPost(content: text)
            }
        })
        present(alert, animated: true)
    }
    
    private func createPost(content: String) {
        let newPost = Post(
            id: UUID().uuidString,
            user: User(
                id: "current-user",
                name: "You",
                username: "@you",
                avatar: "👤",
                verified: false
            ),
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
        postsTableView.reloadData()
        updateEmptyState()
    }
    
    private func toggleLike(_ postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
            postsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    private func toggleBookmark(_ postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].isBookmarked.toggle()
            postsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}

// MARK: - UITableViewDataSource
extension SocialMediaFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.configure(with: post) { [weak self] in
            self?.toggleLike(post.id)
        } onComment: { [weak self] in
            self?.showComments(for: post)
        } onShare: { [weak self] in
            self?.sharePost(post)
        } onBookmark: { [weak self] in
            self?.toggleBookmark(post.id)
        }
        return cell
    }
    
    private func showComments(for post: Post) {
        let alert = UIAlertController(title: "Comments", message: "Comments for: \(post.title)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func sharePost(_ post: Post) {
        let alert = UIAlertController(title: "Share", message: "Sharing: \(post.title)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension SocialMediaFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = posts[indexPath.row]
        
        let alert = UIAlertController(title: post.user.name, message: post.content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Post Table View Cell
class PostTableViewCell: UITableViewCell {
    private let userAvatarLabel = UILabel()
    private let userNameLabel = UILabel()
    private let userUsernameLabel = UILabel()
    private let verifiedIconLabel = UILabel()
    private let timestampLabel = UILabel()
    private let contentLabel = UILabel()
    private let imageLabel = UILabel()
    private let locationLabel = UILabel()
    private let likesButton = UIButton(type: .system)
    private let commentsButton = UIButton(type: .system)
    private let sharesButton = UIButton(type: .system)
    private let bookmarkButton = UIButton(type: .system)
    
    var onLike: (() -> Void)?
    var onComment: (() -> Void)?
    var onShare: (() -> Void)?
    var onBookmark: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        userAvatarLabel.font = UIFont.systemFont(ofSize: 32)
        userAvatarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userUsernameLabel.font = UIFont.systemFont(ofSize: 14)
        userUsernameLabel.textColor = .secondaryLabel
        userUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        verifiedIconLabel.font = UIFont.systemFont(ofSize: 12)
        verifiedIconLabel.textColor = .systemBlue
        verifiedIconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timestampLabel.font = UIFont.systemFont(ofSize: 12)
        timestampLabel.textColor = .secondaryLabel
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageLabel.font = UIFont.systemFont(ofSize: 48)
        imageLabel.textAlignment = .center
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        locationLabel.textColor = .secondaryLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        likesButton.setTitleColor(.systemGray, for: .normal)
        likesButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        likesButton.translatesAutoresizingMaskIntoConstraints = false
        
        commentsButton.setTitleColor(.systemGray, for: .normal)
        commentsButton.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        commentsButton.translatesAutoresizingMaskIntoConstraints = false
        
        sharesButton.setTitleColor(.systemGray, for: .normal)
        sharesButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        sharesButton.translatesAutoresizingMaskIntoConstraints = false
        
        bookmarkButton.setTitleColor(.systemGray, for: .normal)
        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(userAvatarLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userUsernameLabel)
        contentView.addSubview(verifiedIconLabel)
        contentView.addSubview(timestampLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likesButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(sharesButton)
        contentView.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            userAvatarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            userAvatarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userAvatarLabel.widthAnchor.constraint(equalToConstant: 48),
            userAvatarLabel.heightAnchor.constraint(equalToConstant: 48),
            
            userNameLabel.topAnchor.constraint(equalTo: userAvatarLabel.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userAvatarLabel.trailingAnchor, constant: 12),
            
            verifiedIconLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            verifiedIconLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 4),
            
            userUsernameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2),
            userUsernameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            timestampLabel.topAnchor.constraint(equalTo: userUsernameLabel.bottomAnchor, constant: 2),
            timestampLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: userAvatarLabel.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            imageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageLabel.heightAnchor.constraint(equalToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            likesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            commentsButton.centerYAnchor.constraint(equalTo: likesButton.centerYAnchor),
            commentsButton.leadingAnchor.constraint(equalTo: likesButton.trailingAnchor, constant: 24),
            
            sharesButton.centerYAnchor.constraint(equalTo: likesButton.centerYAnchor),
            sharesButton.leadingAnchor.constraint(equalTo: commentsButton.trailingAnchor, constant: 24),
            
            bookmarkButton.centerYAnchor.constraint(equalTo: likesButton.centerYAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with post: Post, onLike: @escaping () -> Void, onComment: @escaping () -> Void, onShare: @escaping () -> Void, onBookmark: @escaping () -> Void) {
        self.onLike = onLike
        self.onComment = onComment
        self.onShare = onShare
        self.onBookmark = onBookmark
        
        userAvatarLabel.text = post.user.avatar
        userNameLabel.text = post.user.name
        userUsernameLabel.text = post.user.username
        verifiedIconLabel.text = post.user.verified ? "✓" : ""
        timestampLabel.text = post.timestamp
        contentLabel.text = post.content
        imageLabel.text = post.image.isEmpty ? nil : post.image
        locationLabel.text = post.location.isEmpty ? nil : "📍 \(post.location)"
        
        likesButton.setTitle("❤️ \(post.likes)", for: .normal)
        likesButton.tintColor = post.isLiked ? .systemRed : .systemGray
        
        commentsButton.setTitle("💬 \(post.comments)", for: .normal)
        sharesButton.setTitle("🔄 \(post.shares)", for: .normal)
        bookmarkButton.setTitle(post.isBookmarked ? "🔖" : "📌", for: .normal)
    }
    
    @objc private func likeTapped() {
        onLike?()
    }
    
    @objc private func commentTapped() {
        onComment?()
    }
    
    @objc private func shareTapped() {
        onShare?()
    }
    
    @objc private func bookmarkTapped() {
        onBookmark?()
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
        return content.prefix(50) + (content.count > 50 ? "..." : "")
    }
}