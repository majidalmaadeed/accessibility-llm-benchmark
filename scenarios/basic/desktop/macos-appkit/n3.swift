import Cocoa

class DecorativeImageWithAltText: NSViewController {
    
    @IBOutlet weak var heroImageView: NSImageView!
    @IBOutlet weak var decorativeBorderImageView: NSImageView!
    @IBOutlet weak var decorativeCornerImageView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var subtitleLabel: NSTextField!
    @IBOutlet weak var categorySegmentedControl: NSSegmentedControl!
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
        
        // Hero Section with Decorative Images
        setupHeroSection()
        
        // Category Filter
        categorySegmentedControl.segmentCount = 5
        categorySegmentedControl.setLabel("All", forSegment: 0)
        categorySegmentedControl.setLabel("Electronics", forSegment: 1)
        categorySegmentedControl.setLabel("Clothing", forSegment: 2)
        categorySegmentedControl.setLabel("Home", forSegment: 3)
        categorySegmentedControl.setLabel("Sports", forSegment: 4)
        categorySegmentedControl.target = self
        categorySegmentedControl.action = #selector(categoryChanged)
        
        // Products Collection View
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.collectionViewLayout = createLayout()
        productsCollectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("ProductItem"))
    }
    
    private func setupHeroSection() {
        // Hero Background
        heroImageView.image = NSImage(named: "hero_background")
        heroImageView.imageScaling = .scaleProportionallyUpOrDown
        heroImageView.wantsLayer = true
        heroImageView.layer?.cornerRadius = 8
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        decorativeBorderImageView.image = NSImage(named: "decorative_border")
        decorativeBorderImageView.imageScaling = .scaleProportionallyUpOrDown
        decorativeBorderImageView.alphaValue = 0.3
        decorativeBorderImageView.wantsLayer = true
        decorativeBorderImageView.layer?.cornerRadius = 8
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative corner element has unnecessary descriptive alt text
        decorativeCornerImageView.image = NSImage(named: "decorative_corner")
        decorativeCornerImageView.imageScaling = .scaleProportionallyUpOrDown
        decorativeCornerImageView.wantsLayer = true
        decorativeCornerImageView.layer?.cornerRadius = 4
        
        // Title and Subtitle
        titleLabel.stringValue = "Discover Amazing Products"
        titleLabel.font = NSFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.alignment = .center
        
        subtitleLabel.stringValue = "Find the perfect items for your needs"
        subtitleLabel.font = NSFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.alphaValue = 0.7
        subtitleLabel.alignment = .center
    }
    
    private func createLayout() -> NSCollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return NSCollectionViewCompositionalLayout(section: section)
    }
    
    private func loadProducts() {
        products = [
            Product(name: "Wireless Headphones", price: "$99.99", originalPrice: "$149.99", rating: 4.5, imageName: "headphones"),
            Product(name: "Smart Watch", price: "$299.99", originalPrice: "$399.99", rating: 4.8, imageName: "smartwatch"),
            Product(name: "Portable Speaker", price: "$79.99", originalPrice: "$99.99", rating: 4.3, imageName: "speaker"),
            Product(name: "Gaming Mouse", price: "$59.99", originalPrice: "$79.99", rating: 4.6, imageName: "mouse"),
            Product(name: "Mechanical Keyboard", price: "$129.99", originalPrice: "$179.99", rating: 4.7, imageName: "keyboard"),
            Product(name: "USB-C Hub", price: "$49.99", originalPrice: "$69.99", rating: 4.2, imageName: "hub")
        ]
        productsCollectionView.reloadData()
    }
    
    @objc private func categoryChanged() {
        // Handle category change
        productsCollectionView.reloadData()
    }
}

// MARK: - NSCollectionViewDataSource
extension DecorativeImageWithAltText: NSCollectionViewDataSource {
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
extension DecorativeImageWithAltText: NSCollectionViewDelegate {
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
    @IBOutlet weak var decorativeBorderImageView: NSImageView!
    @IBOutlet weak var decorativeCornerImageView: NSImageView!
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
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border pattern has unnecessary descriptive alt text
        decorativeBorderImageView.image = NSImage(named: "decorative_border")
        decorativeBorderImageView.imageScaling = .scaleProportionallyUpOrDown
        decorativeBorderImageView.alphaValue = 0.3
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative corner element has unnecessary descriptive alt text
        decorativeCornerImageView.image = NSImage(named: "decorative_corner")
        decorativeCornerImageView.imageScaling = .scaleProportionallyUpOrDown
        
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
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border pattern has unnecessary descriptive alt text
        decorativeBorderImageView.image = NSImage(named: "decorative_border")
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative corner element has unnecessary descriptive alt text
        decorativeCornerImageView.image = NSImage(named: "decorative_corner")
        
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
extension DecorativeImageWithAltText {
    static func instantiate() -> DecorativeImageWithAltText {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "DecorativeImageWithAltText") as! DecorativeImageWithAltText
    }
}
