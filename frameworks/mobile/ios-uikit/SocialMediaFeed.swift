import UIKit

class SocialMediaFeedViewController: UIViewController {
    
    // MARK: - Properties
    
    private var feedTableView: UITableView!
    private var composeButton: UIButton!
    private var refreshControl: UIRefreshControl!
    private var loadingIndicator: UIActivityIndicatorView!
    private var notificationBadge: UILabel!
    
    private var posts: [SocialMediaPost] = []
    private var isLoading: Bool = false
    private var hasMorePosts: Bool = true
    private var currentPage: Int = 1
    private var selectedPost: SocialMediaPost?
    private var showNotifications: Bool = false
    private var unreadCount: Int = 0
    private var isRefreshing: Bool = false
    private var lastRefreshTime: Date?
    private var userProfile: UserProfile?
    private var feedType: FeedType = .all
    private var sortOrder: SortOrder = .newest
    
    enum FeedType {
        case all, following, trending, mentions
    }
    
    enum SortOrder {
        case newest, popular, relevant
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFeedTableView()
        setupComposeButton()
        setupRefreshControl()
        setupLoadingIndicator()
        setupNotificationBadge()
        setupConstraints()
        setupNavigationBar()
        loadInitialPosts()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Social Feed"
    }
    
    private func setupFeedTableView() {
        feedTableView = UITableView()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        feedTableView.separatorStyle = .none
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedTableView)
    }
    
    private func setupComposeButton() {
        composeButton = UIButton(type: .system)
        composeButton.setTitle("✏️", for: .normal)
        composeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        composeButton.backgroundColor = .systemBlue
        composeButton.layer.cornerRadius = 25
        composeButton.layer.shadowColor = UIColor.black.cgColor
        composeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        composeButton.layer.shadowRadius = 4
        composeButton.layer.shadowOpacity = 0.2
        composeButton.addTarget(self, action: #selector(composePost), for: .touchUpInside)
        composeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(composeButton)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        feedTableView.refreshControl = refreshControl
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
    }
    
    private func setupNotificationBadge() {
        notificationBadge = UILabel()
        notificationBadge.backgroundColor = .systemRed
        notificationBadge.textColor = .white
        notificationBadge.font = UIFont.boldSystemFont(ofSize: 12)
        notificationBadge.textAlignment = .center
        notificationBadge.layer.cornerRadius = 10
        notificationBadge.clipsToBounds = true
        notificationBadge.isHidden = true
        notificationBadge.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationBadge)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            composeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            composeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            composeButton.widthAnchor.constraint(equalToConstant: 50),
            composeButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            notificationBadge.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            notificationBadge.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notificationBadge.widthAnchor.constraint(equalToConstant: 20),
            notificationBadge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupNavigationBar() {
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterOptions))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(showSortOptions))
        let profileButton = UIBarButtonItem(title: "👤", style: .plain, target: self, action: #selector(showProfile))
        
        navigationItem.leftBarButtonItems = [profileButton]
        navigationItem.rightBarButtonItems = [sortButton, filterButton]
    }
    
    // MARK: - Data Loading
    
    private func loadInitialPosts() {
        isLoading = true
        loadingIndicator.startAnimating()
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.posts = self.generateSamplePosts()
            self.feedTableView.reloadData()
            self.isLoading = false
            self.loadingIndicator.stopAnimating()
        }
    }
    
    private func loadMorePosts() {
        guard !isLoading && hasMorePosts else { return }
        
        isLoading = true
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let newPosts = self.generateSamplePosts()
            self.posts.append(contentsOf: newPosts)
            self.feedTableView.reloadData()
            self.isLoading = false
            self.currentPage += 1
            
            if self.currentPage >= 5 {
                self.hasMorePosts = false
            }
        }
    }
    
    private func generateSamplePosts() -> [SocialMediaPost] {
        let samplePosts = [
            SocialMediaPost(id: "1", author: "John Doe", username: "@johndoe", content: "Just finished an amazing hike! The views were incredible. #hiking #nature", timestamp: Date(), likes: 42, shares: 8, comments: 12, isLiked: false, isShared: false, imageURL: "hike_image.jpg"),
            SocialMediaPost(id: "2", author: "Jane Smith", username: "@janesmith", content: "Working on a new project. Can't wait to share it with everyone! 🚀", timestamp: Date().addingTimeInterval(-3600), likes: 28, shares: 5, comments: 7, isLiked: true, isShared: false, imageURL: nil),
            SocialMediaPost(id: "3", author: "Mike Johnson", username: "@mikej", content: "Beautiful sunset from my balcony tonight. Sometimes the simple moments are the best. 🌅", timestamp: Date().addingTimeInterval(-7200), likes: 67, shares: 15, comments: 23, isLiked: false, isShared: true, imageURL: "sunset_image.jpg")
        ]
        return samplePosts
    }
    
    // MARK: - Actions
    
    @objc private func composePost() {
        let alert = UIAlertController(title: "Compose Post", message: "What's on your mind?", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Share your thoughts..."
        }
        
        alert.addAction(UIAlertAction(title: "Post", style: .default) { _ in
            if let content = alert.textFields?[0].text, !content.isEmpty {
                self.createNewPost(content: content)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func refreshFeed() {
        isRefreshing = true
        lastRefreshTime = Date()
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.posts = self.generateSamplePosts()
            self.feedTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.isRefreshing = false
        }
    }
    
    @objc private func showFilterOptions() {
        let alert = UIAlertController(title: "Filter Feed", message: "Choose what to see", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Posts", style: .default) { _ in
            self.feedType = .all
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Following", style: .default) { _ in
            self.feedType = .following
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Trending", style: .default) { _ in
            self.feedType = .trending
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Mentions", style: .default) { _ in
            self.feedType = .mentions
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func showSortOptions() {
        let alert = UIAlertController(title: "Sort Feed", message: "Choose sort order", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Newest First", style: .default) { _ in
            self.sortOrder = .newest
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Most Popular", style: .default) { _ in
            self.sortOrder = .popular
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Most Relevant", style: .default) { _ in
            self.sortOrder = .relevant
            self.loadInitialPosts()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func showProfile() {
        // Show user profile
    }
    
    private func createNewPost(content: String) {
        let newPost = SocialMediaPost(id: UUID().uuidString, author: "You", username: "@you", content: content, timestamp: Date(), likes: 0, shares: 0, comments: 0, isLiked: false, isShared: false, imageURL: nil)
        posts.insert(newPost, at: 0)
        feedTableView.reloadData()
    }
    
    private func toggleLike(for post: SocialMediaPost) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
            feedTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    private func toggleShare(for post: SocialMediaPost) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isShared.toggle()
            posts[index].shares += posts[index].isShared ? 1 : -1
            feedTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension SocialMediaFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && hasMorePosts {
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedPost = posts[indexPath.row]
        // Show post details
    }
}

// MARK: - PostTableViewCellDelegate

extension SocialMediaFeedViewController: PostTableViewCellDelegate {
    
    func didTapLike(on post: SocialMediaPost) {
        toggleLike(for: post)
    }
    
    func didTapShare(on post: SocialMediaPost) {
        toggleShare(for: post)
    }
    
    func didTapComment(on post: SocialMediaPost) {
        // Show comments
    }
    
    func didTapUser(on post: SocialMediaPost) {
        // Show user profile
    }
}

// MARK: - Supporting Models

struct SocialMediaPost {
    let id: String
    let author: String
    let username: String
    let content: String
    let timestamp: Date
    var likes: Int
    var shares: Int
    let comments: Int
    var isLiked: Bool
    var isShared: Bool
    let imageURL: String?
}

struct UserProfile {
    let id: String
    let name: String
    let username: String
    let bio: String
    let followers: Int
    let following: Int
    let posts: Int
    let avatarURL: String?
}

// MARK: - Supporting Views

protocol PostTableViewCellDelegate: AnyObject {
    func didTapLike(on post: SocialMediaPost)
    func didTapShare(on post: SocialMediaPost)
    func didTapComment(on post: SocialMediaPost)
    func didTapUser(on post: SocialMediaPost)
}

class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: SocialMediaPost?
    
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let timestampLabel = UILabel()
    private let contentLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let commentButton = UIButton(type: .system)
    private let likeCountLabel = UILabel()
    private let shareCountLabel = UILabel()
    private let commentCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [avatarImageView, nameLabel, usernameLabel, timestampLabel, contentLabel, postImageView, likeButton, shareButton, commentButton, likeCountLabel, shareCountLabel, commentCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .systemGray5
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.textColor = .secondaryLabel
        timestampLabel.font = UIFont.systemFont(ofSize: 12)
        timestampLabel.textColor = .secondaryLabel
        
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.numberOfLines = 0
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.layer.cornerRadius = 8
        
        likeButton.setTitle("❤️", for: .normal)
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        
        shareButton.setTitle("🔄", for: .normal)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        commentButton.setTitle("💬", for: .normal)
        commentButton.addTarget(self, action: #selector(commentTapped), for: .touchUpInside)
        
        [likeCountLabel, shareCountLabel, commentCountLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .secondaryLabel
        }
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            
            usernameLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            
            timestampLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            timestampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            likeButton.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            
            likeCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 4),
            
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 16),
            
            shareCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            shareCountLabel.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 4),
            
            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: shareCountLabel.trailingAnchor, constant: 16),
            
            commentCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentCountLabel.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 4),
            commentCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with post: SocialMediaPost) {
        self.post = post
        
        nameLabel.text = post.author
        usernameLabel.text = post.username
        contentLabel.text = post.content
        likeCountLabel.text = "\(post.likes)"
        shareCountLabel.text = "\(post.shares)"
        commentCountLabel.text = "\(post.comments)"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        timestampLabel.text = formatter.string(from: post.timestamp)
        
        likeButton.setTitle(post.isLiked ? "❤️" : "🤍", for: .normal)
        shareButton.setTitle(post.isShared ? "🔄" : "↻", for: .normal)
        
        postImageView.isHidden = post.imageURL == nil
    }
    
    @objc private func likeTapped() {
        guard let post = post else { return }
        delegate?.didTapLike(on: post)
    }
    
    @objc private func shareTapped() {
        guard let post = post else { return }
        delegate?.didTapShare(on: post)
    }
    
    @objc private func commentTapped() {
        guard let post = post else { return }
        delegate?.didTapComment(on: post)
    }
}
