import Cocoa

class GenericLinkText: NSViewController {
    
    @IBOutlet weak var featuredArticleView: NSView!
    @IBOutlet weak var featuredImageView: NSImageView!
    @IBOutlet weak var featuredLabel: NSTextField!
    @IBOutlet weak var featuredTitleLabel: NSTextField!
    @IBOutlet weak var featuredContentLabel: NSTextField!
    @IBOutlet weak var authorView: NSView!
    @IBOutlet weak var authorImageView: NSImageView!
    @IBOutlet weak var authorNameLabel: NSTextField!
    @IBOutlet weak var publishDateLabel: NSTextField!
    @IBOutlet weak var readTimeLabel: NSTextField!
    @IBOutlet weak var readMoreButton: NSButton!
    
    @IBOutlet weak var categorySegmentedControl: NSSegmentedControl!
    @IBOutlet weak var articlesTableView: NSTableView!
    
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadArticles()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Featured Article
        setupFeaturedArticle()
        
        // Category Filter
        categorySegmentedControl.segmentCount = 5
        categorySegmentedControl.setLabel("All", forSegment: 0)
        categorySegmentedControl.setLabel("Technology", forSegment: 1)
        categorySegmentedControl.setLabel("Design", forSegment: 2)
        categorySegmentedControl.setLabel("Business", forSegment: 3)
        categorySegmentedControl.setLabel("Science", forSegment: 4)
        categorySegmentedControl.target = self
        categorySegmentedControl.action = #selector(categoryChanged)
        
        // Articles Table View
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        articlesTableView.target = self
        articlesTableView.doubleAction = #selector(articleDoubleClicked)
    }
    
    private func setupFeaturedArticle() {
        featuredArticleView.wantsLayer = true
        featuredArticleView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        featuredArticleView.layer?.cornerRadius = 8
        featuredArticleView.layer?.shadowOpacity = 0.2
        featuredArticleView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        featuredArticleView.layer?.shadowRadius = 4
        
        // Featured Image
        featuredImageView.image = NSImage(named: "featured_article")
        featuredImageView.imageScaling = .scaleProportionallyUpOrDown
        featuredImageView.wantsLayer = true
        featuredImageView.layer?.cornerRadius = 8
        
        // Featured Label
        featuredLabel.stringValue = "Featured"
        featuredLabel.font = NSFont.boldSystemFont(ofSize: 12)
        featuredLabel.textColor = .systemBlue
        featuredLabel.wantsLayer = true
        featuredLabel.layer?.backgroundColor = NSColor.systemBlue.withAlphaComponent(0.2).cgColor
        featuredLabel.layer?.cornerRadius = 6
        
        // Featured Title
        featuredTitleLabel.stringValue = "Building Scalable React Native Applications"
        featuredTitleLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        featuredTitleLabel.maximumNumberOfLines = 0
        
        // Featured Content
        featuredContentLabel.stringValue = "Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs."
        featuredContentLabel.font = NSFont.systemFont(ofSize: 16)
        featuredContentLabel.textColor = .secondaryLabelColor
        featuredContentLabel.maximumNumberOfLines = 0
        
        // Author Section
        authorImageView.image = NSImage(named: "author_placeholder")
        authorImageView.imageScaling = .scaleProportionallyUpOrDown
        authorImageView.wantsLayer = true
        authorImageView.layer?.cornerRadius = 16
        authorImageView.layer?.backgroundColor = NSColor.systemBlue.cgColor
        
        authorNameLabel.stringValue = "Alex Thompson"
        authorNameLabel.font = NSFont.boldSystemFont(ofSize: 14)
        
        publishDateLabel.stringValue = "January 20, 2024"
        publishDateLabel.font = NSFont.systemFont(ofSize: 12)
        publishDateLabel.textColor = .secondaryLabelColor
        
        readTimeLabel.stringValue = "12 min read"
        readTimeLabel.font = NSFont.systemFont(ofSize: 12)
        readTimeLabel.textColor = .secondaryLabelColor
        
        // GENERIC LINK TEXT - "Read more" without context
        readMoreButton.title = "Read more"
        readMoreButton.font = NSFont.boldSystemFont(ofSize: 16)
        readMoreButton.bezelStyle = .rounded
        readMoreButton.target = self
        readMoreButton.action = #selector(readMoreTapped)
    }
    
    private func loadArticles() {
        articles = [
            Article(category: "Technology", title: "Understanding Flutter Performance Optimization", content: "Learn how to optimize your Flutter applications for better performance and user experience.", author: "John Smith", date: "2024-01-15", readTime: "15 min", imageName: "flutter_article"),
            Article(category: "Design", title: "Mobile UI/UX Design Best Practices", content: "Essential design principles for creating intuitive and accessible mobile interfaces.", author: "Sarah Johnson", date: "2024-01-12", readTime: "12 min", imageName: "design_article"),
            Article(category: "Technology", title: "Cross-Platform Development Strategies", content: "Compare different approaches to building apps that work across multiple platforms.", author: "Mike Chen", date: "2024-01-10", readTime: "18 min", imageName: "crossplatform_article"),
            Article(category: "Business", title: "Startup Funding Strategies", content: "Navigate the complex world of startup funding and investment opportunities.", author: "Emily Davis", date: "2024-01-08", readTime: "20 min", imageName: "business_article"),
            Article(category: "Science", title: "Artificial Intelligence in Healthcare", content: "Exploring the latest advances in AI applications for medical diagnosis and treatment.", author: "Dr. Robert Kim", date: "2024-01-05", readTime: "25 min", imageName: "science_article")
        ]
        articlesTableView.reloadData()
    }
    
    @objc private func categoryChanged() {
        // Handle category change
        articlesTableView.reloadData()
    }
    
    @objc private func readMoreTapped() {
        // Handle read more
        let alert = NSAlert()
        alert.messageText = "Read More"
        alert.informativeText = "This would open the full article content."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func articleDoubleClicked() {
        let selectedRow = articlesTableView.selectedRow
        if selectedRow >= 0 && selectedRow < articles.count {
            let article = articles[selectedRow]
            showArticleDetails(article)
        }
    }
    
    private func showArticleDetails(_ article: Article) {
        let alert = NSAlert()
        alert.messageText = article.title
        alert.informativeText = """
        Category: \(article.category)
        Author: \(article.author)
        Date: \(article.date)
        Read Time: \(article.readTime)
        
        \(article.content)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - NSTableViewDataSource
extension GenericLinkText: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return articles.count
    }
}

// MARK: - NSTableViewDelegate
extension GenericLinkText: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let article = articles[row]
        
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            switch column.identifier.rawValue {
            case "image":
                let imageView = NSImageView()
                imageView.image = NSImage(named: article.imageName)
                imageView.imageScaling = .scaleProportionallyUpOrDown
                imageView.wantsLayer = true
                imageView.layer?.cornerRadius = 4
                cellView.addSubview(imageView)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    imageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 60),
                    imageView.heightAnchor.constraint(equalToConstant: 40)
                ])
                
            case "content":
                let stackView = NSStackView()
                stackView.orientation = .vertical
                stackView.spacing = 4
                stackView.alignment = .leading
                
                // Category Label
                let categoryLabel = NSTextField()
                categoryLabel.stringValue = article.category
                categoryLabel.font = NSFont.boldSystemFont(ofSize: 10)
                categoryLabel.textColor = .white
                categoryLabel.wantsLayer = true
                categoryLabel.layer?.backgroundColor = NSColor.systemBlue.cgColor
                categoryLabel.layer?.cornerRadius = 4
                categoryLabel.isEditable = false
                categoryLabel.isBordered = false
                categoryLabel.backgroundColor = .clear
                
                // Title Label
                let titleLabel = NSTextField()
                titleLabel.stringValue = article.title
                titleLabel.font = NSFont.boldSystemFont(ofSize: 14)
                titleLabel.isEditable = false
                titleLabel.isBordered = false
                titleLabel.backgroundColor = .clear
                titleLabel.maximumNumberOfLines = 2
                
                // Content Label
                let contentLabel = NSTextField()
                contentLabel.stringValue = article.content
                contentLabel.font = NSFont.systemFont(ofSize: 12)
                contentLabel.textColor = .secondaryLabelColor
                contentLabel.isEditable = false
                contentLabel.isBordered = false
                contentLabel.backgroundColor = .clear
                contentLabel.maximumNumberOfLines = 2
                
                // Author and Date
                let authorDateLabel = NSTextField()
                authorDateLabel.stringValue = "By \(article.author) • \(article.date)"
                authorDateLabel.font = NSFont.systemFont(ofSize: 10)
                authorDateLabel.textColor = .secondaryLabelColor
                authorDateLabel.isEditable = false
                authorDateLabel.isBordered = false
                authorDateLabel.backgroundColor = .clear
                
                stackView.addArrangedSubview(categoryLabel)
                stackView.addArrangedSubview(titleLabel)
                stackView.addArrangedSubview(contentLabel)
                stackView.addArrangedSubview(authorDateLabel)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
                ])
                
            case "actions":
                let stackView = NSStackView()
                stackView.orientation = .horizontal
                stackView.spacing = 8
                
                // GENERIC LINK TEXT - "Read more" without context
                let readMoreButton = NSButton()
                readMoreButton.title = "Read more"
                readMoreButton.font = NSFont.boldSystemFont(ofSize: 12)
                readMoreButton.bezelStyle = .rounded
                readMoreButton.target = self
                readMoreButton.action = #selector(readMoreTapped)
                readMoreButton.tag = row
                
                let shareButton = NSButton()
                shareButton.title = "↗️"
                shareButton.font = NSFont.systemFont(ofSize: 16)
                shareButton.target = self
                shareButton.action = #selector(shareButtonTapped)
                shareButton.tag = row
                
                stackView.addArrangedSubview(readMoreButton)
                stackView.addArrangedSubview(shareButton)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8)
                ])
            default:
                break
            }
        }
        
        return cellView
    }
    
    @objc private func shareButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < articles.count {
            let article = articles[row]
            // Handle share
            let alert = NSAlert()
            alert.messageText = "Share Article"
            alert.informativeText = "Share: \(article.title)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
}

// MARK: - Article Model
struct Article {
    let category: String
    let title: String
    let content: String
    let author: String
    let date: String
    let readTime: String
    let imageName: String
}

// MARK: - Storyboard Support
extension GenericLinkText {
    static func instantiate() -> GenericLinkText {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "GenericLinkText") as! GenericLinkText
    }
}
