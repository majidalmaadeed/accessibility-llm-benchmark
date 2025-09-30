import Cocoa

class MissingSkipLink: NSViewController {
    
    @IBOutlet weak var tabSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var heroTitleLabel: NSTextField!
    @IBOutlet weak var heroSubtitleLabel: NSTextField!
    @IBOutlet weak var getStartedButton: NSButton!
    @IBOutlet weak var featuresStackView: NSStackView!
    @IBOutlet weak var productsCollectionView: NSCollectionView!
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProducts()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // MISSING SKIP LINK - Page navigation without skip-to-content link
        // Tab Navigation
        tabSegmentedControl.segmentCount = 4
        tabSegmentedControl.setLabel("Home", forSegment: 0)
        tabSegmentedControl.setLabel("Products", forSegment: 1)
        tabSegmentedControl.setLabel("About", forSegment: 2)
        tabSegmentedControl.setLabel("Contact", forSegment: 3)
        tabSegmentedControl.target = self
        tabSegmentedControl.action = #selector(tabChanged)
        
        // Hero Section
        heroTitleLabel.stringValue = "Welcome to Our Website"
        heroTitleLabel.font = NSFont.systemFont(ofSize: 32, weight: .bold)
        heroTitleLabel.alignment = .center
        
        heroSubtitleLabel.stringValue = "Discover amazing products and services"
        heroSubtitleLabel.font = NSFont.systemFont(ofSize: 18)
        heroSubtitleLabel.textColor = .secondaryLabelColor
        heroSubtitleLabel.alignment = .center
        
        getStartedButton.title = "Get Started"
        getStartedButton.font = NSFont.boldSystemFont(ofSize: 16)
        getStartedButton.bezelStyle = .rounded
        getStartedButton.target = self
        getStartedButton.action = #selector(getStartedTapped)
        
        // Features Section
        setupFeatures()
        
        // Products Collection View
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.collectionViewLayout = createLayout()
        productsCollectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("ProductItem"))
    }
    
    private func setupFeatures() {
        let features = [
            ("🚀", "Fast Performance", "Lightning-fast loading times"),
            ("🔒", "Secure", "Your data is safe with us"),
            ("💡", "Innovative", "Cutting-edge technology")
        ]
        
        for (icon, title, subtitle) in features {
            let featureView = createFeatureView(icon: icon, title: title, subtitle: subtitle)
            featuresStackView.addArrangedSubview(featureView)
        }
    }
    
    private func createFeatureView(icon: String, title: String, subtitle: String) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.shadowOpacity = 0.2
        containerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        containerView.layer?.shadowRadius = 4
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 32)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 16)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let subtitleLabel = NSTextField()
        subtitleLabel.stringValue = subtitle
        subtitleLabel.font = NSFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .secondaryLabelColor
        subtitleLabel.isEditable = false
        subtitleLabel.isBordered = false
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.alignment = .center
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            iconLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 8),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func createLayout() -> NSCollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return NSCollectionViewCompositionalLayout(section: section)
    }
    
    private func loadProducts() {
        products = [
            Product(name: "Product 1", price: "$99.99", originalPrice: "$149.99", rating: 4.5, imageName: "product1"),
            Product(name: "Product 2", price: "$199.99", originalPrice: "$249.99", rating: 4.8, imageName: "product2"),
            Product(name: "Product 3", price: "$299.99", originalPrice: "$399.99", rating: 4.7, imageName: "product3"),
            Product(name: "Product 4", price: "$79.99", originalPrice: "$99.99", rating: 4.3, imageName: "product4"),
            Product(name: "Product 5", price: "$129.99", originalPrice: "$179.99", rating: 4.6, imageName: "product5"),
            Product(name: "Product 6", price: "$49.99", originalPrice: "$69.99", rating: 4.2, imageName: "product6")
        ]
        productsCollectionView.reloadData()
    }
    
    @objc private func tabChanged() {
        // Handle tab change
        let selectedTab = tabSegmentedControl.selectedSegment
        switch selectedTab {
        case 0: // Home
            // Show home content
            break
        case 1: // Products
            // Show products content
            break
        case 2: // About
            // Show about content
            break
        case 3: // Contact
            // Show contact content
            break
        default:
            break
        }
    }
    
    @objc private func getStartedTapped() {
        // Handle get started
        let alert = NSAlert()
        alert.messageText = "Get Started"
        alert.informativeText = "Welcome! Let's get you started with our amazing products and services."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - NSCollectionViewDataSource
extension MissingSkipLink: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("ProductItem"), for: indexPath) as! ProductCollectionViewItem
        item.configure(with: products[indexPath.item])
        return item
    }
}

// MARK: - NSCollectionViewDelegate
extension MissingSkipLink: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        // Handle item selection
    }
}

// MARK: - Product Model
struct Product {
    let name: String
    let price: String
    let originalPrice: String
    let rating: Double
    let imageName: String
}

// MARK: - Product Collection View Item
class ProductCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var productImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var ratingLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    @IBOutlet weak var originalPriceLabel: NSTextField!
    @IBOutlet weak var addToCartButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        view.layer?.cornerRadius = 8
        view.layer?.shadowOpacity = 0.2
        view.layer?.shadowOffset = NSSize(width: 0, height: 2)
        view.layer?.shadowRadius = 4
        
        // Product Image
        productImageView.imageScaling = .scaleProportionallyUpOrDown
        productImageView.image = NSImage(named: "product_placeholder")
        
        // Labels
        nameLabel.font = NSFont.boldSystemFont(ofSize: 16)
        ratingLabel.font = NSFont.systemFont(ofSize: 12)
        priceLabel.font = NSFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .systemGreen
        originalPriceLabel.font = NSFont.systemFont(ofSize: 14)
        originalPriceLabel.textColor = .secondaryLabelColor
        
        // Add to Cart Button
        addToCartButton.title = "Add to Cart"
        addToCartButton.bezelStyle = .rounded
        addToCartButton.target = self
        addToCartButton.action = #selector(addToCartTapped)
    }
    
    func configure(with product: Product) {
        productImageView.image = NSImage(named: product.imageName)
        nameLabel.stringValue = product.name
        ratingLabel.stringValue = "⭐ \(product.rating)"
        priceLabel.stringValue = product.price
        originalPriceLabel.stringValue = product.originalPrice
    }
    
    @objc private func addToCartTapped() {
        // Handle add to cart
    }
}

// MARK: - Storyboard Support
extension MissingSkipLink {
    static func instantiate() -> MissingSkipLink {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "MissingSkipLink") as! MissingSkipLink
    }
}
