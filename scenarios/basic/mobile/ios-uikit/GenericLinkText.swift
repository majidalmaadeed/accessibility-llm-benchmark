import UIKit

class GenericLinkTextViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "News & Articles"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Featured article
        let featuredArticleView = createFeaturedArticle()
        contentView.addSubview(featuredArticleView)
        
        // Article list
        let articleListView = createArticleList()
        contentView.addSubview(articleListView)
        
        // Newsletter signup
        let newsletterView = createNewsletterSignup()
        contentView.addSubview(newsletterView)
        
        // Footer
        let footerView = createFooterView()
        contentView.addSubview(footerView)
        
        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            featuredArticleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            featuredArticleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredArticleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            articleListView.topAnchor.constraint(equalTo: featuredArticleView.bottomAnchor, constant: 20),
            articleListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            newsletterView.topAnchor.constraint(equalTo: articleListView.bottomAnchor, constant: 20),
            newsletterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsletterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: newsletterView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Tech News Daily"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Stay updated with the latest technology news and insights"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20)
        ])
        
        return headerView
    }
    
    private func createFeaturedArticle() -> UIView {
        let articleView = UIView()
        articleView.backgroundColor = .systemBackground
        articleView.layer.cornerRadius = 12
        articleView.layer.shadowColor = UIColor.black.cgColor
        articleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        articleView.layer.shadowRadius = 4
        articleView.layer.shadowOpacity = 0.1
        articleView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(imageView)
        
        let categoryLabel = UILabel()
        categoryLabel.text = "TECHNOLOGY"
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 12)
        categoryLabel.textColor = .systemBlue
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(categoryLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = "Revolutionary AI Technology Transforms Healthcare Industry"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(titleLabel)
        
        let excerptLabel = UILabel()
        excerptLabel.text = "A groundbreaking artificial intelligence system has been developed that can diagnose diseases with 99% accuracy, potentially revolutionizing how we approach healthcare and medical diagnosis."
        excerptLabel.font = UIFont.systemFont(ofSize: 16)
        excerptLabel.textColor = .secondaryLabel
        excerptLabel.numberOfLines = 0
        excerptLabel.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(excerptLabel)
        
        let authorLabel = UILabel()
        authorLabel.text = "By Sarah Johnson • 2 hours ago"
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = .tertiaryLabel
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(authorLabel)
        
        // Generic link text without context
        let readMoreButton = UIButton(type: .system)
        readMoreButton.setTitle("Read more", for: .normal)
        readMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        readMoreButton.setTitleColor(.systemBlue, for: .normal)
        readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        articleView.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            articleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
            imageView.topAnchor.constraint(equalTo: articleView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: articleView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: -16),
            
            excerptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            excerptLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            excerptLabel.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: excerptLabel.bottomAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: articleView.trailingAnchor, constant: -16),
            
            readMoreButton.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            readMoreButton.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 16),
            readMoreButton.bottomAnchor.constraint(lessThanOrEqualTo: articleView.bottomAnchor, constant: -16)
        ])
        
        return articleView
    }
    
    private func createArticleList() -> UIView {
        let listView = UIView()
        listView.backgroundColor = .systemBackground
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Latest Articles"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(stackView)
        
        let articles = [
            ("The Future of Quantum Computing", "Scientists make breakthrough in quantum computing research...", "Read more"),
            ("Cybersecurity Trends 2024", "New security threats and protection strategies...", "Read more"),
            ("Sustainable Technology Solutions", "How tech companies are going green...", "Read more"),
            ("Mobile App Development Trends", "Latest trends in mobile application development...", "Read more"),
            ("Cloud Computing Revolution", "How cloud technology is transforming businesses...", "Read more")
        ]
        
        for (title, excerpt, linkText) in articles {
            let articleItem = createArticleItem(title: title, excerpt: excerpt, linkText: linkText)
            stackView.addArrangedSubview(articleItem)
        }
        
        NSLayoutConstraint.activate([
            listView.heightAnchor.constraint(greaterThanOrEqualToConstant: 600),
            
            titleLabel.topAnchor.constraint(equalTo: listView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: listView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: listView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: listView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: listView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: listView.bottomAnchor, constant: -20)
        ])
        
        return listView
    }
    
    private func createArticleItem(title: String, excerpt: String, linkText: String) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        let excerptLabel = UILabel()
        excerptLabel.text = excerpt
        excerptLabel.font = UIFont.systemFont(ofSize: 14)
        excerptLabel.textColor = .secondaryLabel
        excerptLabel.numberOfLines = 0
        excerptLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(excerptLabel)
        
        // Generic link text without context
        let linkButton = UIButton(type: .system)
        linkButton.setTitle(linkText, for: .normal)
        linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        linkButton.setTitleColor(.systemBlue, for: .normal)
        linkButton.addTarget(self, action: #selector(articleLinkTapped), for: .touchUpInside)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -12),
            
            excerptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            excerptLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            excerptLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -12),
            
            linkButton.topAnchor.constraint(equalTo: excerptLabel.bottomAnchor, constant: 8),
            linkButton.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            linkButton.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor, constant: -12)
        ])
        
        return itemView
    }
    
    private func createNewsletterSignup() -> UIView {
        let newsletterView = UIView()
        newsletterView.backgroundColor = .systemBlue
        newsletterView.layer.cornerRadius = 12
        newsletterView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Stay Updated"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsletterView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Get the latest tech news delivered to your inbox"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.alpha = 0.9
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        newsletterView.addSubview(descriptionLabel)
        
        let emailTextField = UITextField()
        emailTextField.placeholder = "Enter your email address"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 8
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        emailTextField.leftViewMode = .always
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        newsletterView.addSubview(emailTextField)
        
        let subscribeButton = UIButton(type: .system)
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        subscribeButton.setTitleColor(.systemBlue, for: .normal)
        subscribeButton.backgroundColor = .white
        subscribeButton.layer.cornerRadius = 8
        subscribeButton.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        newsletterView.addSubview(subscribeButton)
        
        // Generic link text
        let privacyLink = UIButton(type: .system)
        privacyLink.setTitle("Privacy Policy", for: .normal)
        privacyLink.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        privacyLink.setTitleColor(.white, for: .normal)
        privacyLink.alpha = 0.8
        privacyLink.addTarget(self, action: #selector(privacyLinkTapped), for: .touchUpInside)
        privacyLink.translatesAutoresizingMaskIntoConstraints = false
        newsletterView.addSubview(privacyLink)
        
        NSLayoutConstraint.activate([
            newsletterView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: newsletterView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: newsletterView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: newsletterView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: newsletterView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: newsletterView.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: newsletterView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: newsletterView.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            subscribeButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            subscribeButton.centerXAnchor.constraint(equalTo: newsletterView.centerXAnchor),
            subscribeButton.widthAnchor.constraint(equalToConstant: 120),
            subscribeButton.heightAnchor.constraint(equalToConstant: 36),
            
            privacyLink.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 8),
            privacyLink.centerXAnchor.constraint(equalTo: newsletterView.centerXAnchor),
            privacyLink.bottomAnchor.constraint(lessThanOrEqualTo: newsletterView.bottomAnchor, constant: -20)
        ])
        
        return newsletterView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemBackground
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(stackView)
        
        let links = [
            ("About", "about"),
            ("Contact", "contact"),
            ("Terms", "terms"),
            ("Help", "help")
        ]
        
        for (title, action) in links {
            let linkButton = UIButton(type: .system)
            linkButton.setTitle(title, for: .normal)
            linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            linkButton.setTitleColor(.systemBlue, for: .normal)
            linkButton.addTarget(self, action: #selector(footerLinkTapped(_:)), for: .touchUpInside)
            linkButton.tag = links.firstIndex { $0.0 == title } ?? 0
            stackView.addArrangedSubview(linkButton)
        }
        
        let copyrightLabel = UILabel()
        copyrightLabel.text = "© 2024 Tech News Daily. All rights reserved."
        copyrightLabel.font = UIFont.systemFont(ofSize: 14)
        copyrightLabel.textColor = .secondaryLabel
        copyrightLabel.textAlignment = .center
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(copyrightLabel)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            copyrightLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            copyrightLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            copyrightLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            copyrightLabel.bottomAnchor.constraint(lessThanOrEqualTo: footerView.bottomAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    // MARK: - Actions
    @objc private func readMoreTapped() {
        let alert = UIAlertController(title: "Article", message: "Opening full article about AI technology in healthcare...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func articleLinkTapped() {
        let alert = UIAlertController(title: "Article", message: "Opening article...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func subscribeTapped() {
        let alert = UIAlertController(title: "Subscription", message: "Thank you for subscribing to our newsletter!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func privacyLinkTapped() {
        let alert = UIAlertController(title: "Privacy Policy", message: "Opening privacy policy...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func footerLinkTapped(_ sender: UIButton) {
        let titles = ["About", "Contact", "Terms", "Help"]
        let title = titles[sender.tag]
        
        let alert = UIAlertController(title: title, message: "Opening \(title.lowercased()) page...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
