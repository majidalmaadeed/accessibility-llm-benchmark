import UIKit

class SmallTouchTargetViewController: UIViewController {
    
    private var posts: [SocialPost] = []
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    private func setupData() {
        posts = [
            SocialPost(
                id: 1,
                username: "john_doe",
                displayName: "John Doe",
                content: "Just finished an amazing hike in the mountains! The views were incredible. #hiking #nature #adventure",
                timestamp: Date().addingTimeInterval(-3600),
                likes: 42,
                comments: 8,
                shares: 3,
                isLiked: false,
                userImageURL: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100",
                postImageURL: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400"
            ),
            SocialPost(
                id: 2,
                username: "jane_smith",
                displayName: "Jane Smith",
                content: "Working on a new project today. Excited to share the results soon! 💻✨",
                timestamp: Date().addingTimeInterval(-7200),
                likes: 28,
                comments: 5,
                shares: 1,
                isLiked: true,
                userImageURL: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100",
                postImageURL: nil
            ),
            SocialPost(
                id: 3,
                username: "mike_wilson",
                displayName: "Mike Wilson",
                content: "Coffee break time! This new café has the best espresso in town. ☕",
                timestamp: Date().addingTimeInterval(-10800),
                likes: 15,
                comments: 3,
                shares: 0,
                isLiked: false,
                userImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
                postImageURL: "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400"
            ),
            SocialPost(
                id: 4,
                username: "sarah_jones",
                displayName: "Sarah Jones",
                content: "Beautiful sunset from my balcony tonight. Sometimes the simple moments are the most precious. 🌅",
                timestamp: Date().addingTimeInterval(-14400),
                likes: 67,
                comments: 12,
                shares: 5,
                isLiked: false,
                userImageURL: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100",
                postImageURL: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400"
            ),
            SocialPost(
                id: 5,
                username: "alex_brown",
                displayName: "Alex Brown",
                content: "Just finished reading an amazing book. Highly recommend it to anyone interested in personal development!",
                timestamp: Date().addingTimeInterval(-18000),
                likes: 23,
                comments: 7,
                shares: 2,
                isLiked: true,
                userImageURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
                postImageURL: nil
            )
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Social Feed"
        
        // Navigation bar setup
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.register(SocialPostCell.self, forCellReuseIdentifier: "SocialPostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension SmallTouchTargetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialPostCell", for: indexPath) as! SocialPostCell
        let post = posts[indexPath.row]
        cell.configure(with: post) { [weak self] action, post in
            self?.handlePostAction(action, for: post)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SmallTouchTargetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - Post Actions
extension SmallTouchTargetViewController {
    private func handlePostAction(_ action: PostAction, for post: SocialPost) {
        switch action {
        case .like:
            toggleLike(for: post)
        case .comment:
            showComments(for: post)
        case .share:
            sharePost(post)
        case .profile:
            showProfile(for: post)
        }
    }
    
    private func toggleLike(for post: SocialPost) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    private func showComments(for post: SocialPost) {
        let alert = UIAlertController(title: "Comments", message: "Comments feature coming soon!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func sharePost(_ post: SocialPost) {
        let activityVC = UIActivityViewController(activityItems: [post.content], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    private func showProfile(for post: SocialPost) {
        let alert = UIAlertController(title: "Profile", message: "Profile for \(post.displayName)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Social Post Cell
class SocialPostCell: UITableViewCell {
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let timestampLabel = UILabel()
    private let contentLabel = UILabel()
    private let postImageView = UIImageView()
    private let actionStackView = UIStackView()
    private let likeButton = UIButton(type: .system)
    private let commentButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let moreButton = UIButton(type: .system)
    
    private var post: SocialPost?
    private var actionHandler: ((PostAction, SocialPost) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .systemBackground
        
        // Container view
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        // Profile image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .systemGray5
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(profileImageView)
        
        // Name label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        
        // Username label
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(usernameLabel)
        
        // Timestamp label
        timestampLabel.font = UIFont.systemFont(ofSize: 12)
        timestampLabel.textColor = .tertiaryLabel
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(timestampLabel)
        
        // Content label
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentLabel)
        
        // Post image
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.layer.cornerRadius = 8
        postImageView.backgroundColor = .systemGray6
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(postImageView)
        
        // Action stack view
        actionStackView.axis = .horizontal
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 0
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(actionStackView)
        
        // Like button - Small touch target (20x20)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .systemGray
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(likeButton)
        
        // Comment button - Small touch target (20x20)
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.tintColor = .systemGray
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(commentButton)
        
        // Share button - Small touch target (20x20)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemGray
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(shareButton)
        
        // More button - Small touch target (20x20)
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .systemGray
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(moreButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timestampLabel.leadingAnchor, constant: -8),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timestampLabel.leadingAnchor, constant: -8),
            
            timestampLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            timestampLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            postImageView.heightAnchor.constraint(equalToConstant: 200),
            
            actionStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            actionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            actionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            actionStackView.heightAnchor.constraint(equalToConstant: 20), // Small height for small touch targets
            
            // Small touch targets - 20x20 points
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            commentButton.widthAnchor.constraint(equalToConstant: 20),
            commentButton.heightAnchor.constraint(equalToConstant: 20),
            shareButton.widthAnchor.constraint(equalToConstant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 20),
            moreButton.widthAnchor.constraint(equalToConstant: 20),
            moreButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with post: SocialPost, actionHandler: @escaping (PostAction, SocialPost) -> Void) {
        self.post = post
        self.actionHandler = actionHandler
        
        nameLabel.text = post.displayName
        usernameLabel.text = "@\(post.username)"
        contentLabel.text = post.content
        
        // Format timestamp
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        timestampLabel.text = formatter.localizedString(for: post.timestamp, relativeTo: Date())
        
        // Load profile image
        if let url = URL(string: post.userImageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }.resume()
        }
        
        // Load post image if available
        if let imageURL = post.postImageURL, let url = URL(string: imageURL) {
            postImageView.isHidden = false
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.postImageView.image = image
                    }
                }
            }.resume()
        } else {
            postImageView.isHidden = true
        }
        
        // Update like button
        updateLikeButton()
    }
    
    private func updateLikeButton() {
        guard let post = post else { return }
        
        if post.isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .systemGray
        }
    }
    
    @objc private func likeButtonTapped() {
        guard let post = post else { return }
        actionHandler?(.like, post)
    }
    
    @objc private func commentButtonTapped() {
        guard let post = post else { return }
        actionHandler?(.comment, post)
    }
    
    @objc private func shareButtonTapped() {
        guard let post = post else { return }
        actionHandler?(.share, post)
    }
    
    @objc private func moreButtonTapped() {
        guard let post = post else { return }
        actionHandler?(.profile, post)
    }
}

// MARK: - Data Models
struct SocialPost {
    let id: Int
    let username: String
    let displayName: String
    let content: String
    let timestamp: Date
    var likes: Int
    let comments: Int
    let shares: Int
    var isLiked: Bool
    let userImageURL: String
    let postImageURL: String?
}

enum PostAction {
    case like
    case comment
    case share
    case profile
}
