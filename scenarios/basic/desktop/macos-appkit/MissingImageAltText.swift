import Cocoa

class MissingImageAltText: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var categorySegmentedControl: NSSegmentedControl!
    @IBOutlet weak var searchField: NSSearchField!
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProducts()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Category Filter
        categorySegmentedControl.segmentCount = 5
        categorySegmentedControl.setLabel("All", forSegment: 0)
        categorySegmentedControl.setLabel("Electronics", forSegment: 1)
        categorySegmentedControl.setLabel("Clothing", forSegment: 2)
        categorySegmentedControl.setLabel("Home", forSegment: 3)
        categorySegmentedControl.setLabel("Sports", forSegment: 4)
        categorySegmentedControl.target = self
        categorySegmentedControl.action = #selector(categoryChanged)
        
        // Search Field
        searchField.placeholderString = "Search products..."
        searchField.target = self
        searchField.action = #selector(searchChanged)
        
        // Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        
        // Register Collection View Item
        collectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("ProductItem"))
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
            Product(name: "Wireless Headphones", price: "$99.99", originalPrice: "$149.99", rating: 4.5, imageName: "headphones"),
            Product(name: "Smart Watch", price: "$299.99", originalPrice: "$399.99", rating: 4.8, imageName: "smartwatch"),
            Product(name: "Portable Speaker", price: "$79.99", originalPrice: "$99.99", rating: 4.3, imageName: "speaker"),
            Product(name: "Gaming Mouse", price: "$59.99", originalPrice: "$79.99", rating: 4.6, imageName: "mouse"),
            Product(name: "Mechanical Keyboard", price: "$129.99", originalPrice: "$179.99", rating: 4.7, imageName: "keyboard"),
            Product(name: "USB-C Hub", price: "$49.99", originalPrice: "$69.99", rating: 4.2, imageName: "hub")
        ]
        collectionView.reloadData()
    }
    
    @objc private func categoryChanged() {
        // Handle category change
        collectionView.reloadData()
    }
    
    @objc private func searchChanged() {
        // Handle search change
        collectionView.reloadData()
    }
}

// MARK: - NSCollectionViewDataSource
extension MissingImageAltText: NSCollectionViewDataSource {
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
extension MissingImageAltText: NSCollectionViewDelegate {
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
        
        // Product Image - MISSING IMAGE ALT TEXT - Product image without alternative text
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
        // MISSING IMAGE ALT TEXT - Product image without alternative text
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
extension MissingImageAltText {
    static func instantiate() -> MissingImageAltText {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "MissingImageAltText") as! MissingImageAltText
    }
}
