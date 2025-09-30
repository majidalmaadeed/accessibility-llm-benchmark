import Cocoa

class FlashingAdvertisement: NSViewController {
    
    @IBOutlet weak var flashBanner: NSView!
    @IBOutlet weak var flashIconLabel: NSTextField!
    @IBOutlet weak var flashTitleLabel: NSTextField!
    @IBOutlet weak var flashMessageLabel: NSTextField!
    @IBOutlet weak var flashCountLabel: NSTextField!
    @IBOutlet weak var pauseButton: NSButton!
    @IBOutlet weak var productsCollectionView: NSCollectionView!
    
    private var products: [Product] = []
    private var flashCount = 0
    private var isFlashing = true
    private var flashTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProducts()
        startFlashAnimation()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // FLASHING ADVERTISEMENT - FLASHING 5 TIMES PER SECOND
        flashBanner.wantsLayer = true
        flashBanner.layer?.backgroundColor = NSColor.systemRed.cgColor
        flashBanner.layer?.cornerRadius = 8
        
        flashIconLabel.stringValue = "🔥"
        flashIconLabel.font = NSFont.systemFont(ofSize: 24)
        flashIconLabel.textColor = .white
        
        flashTitleLabel.stringValue = "FLASH SALE!"
        flashTitleLabel.font = NSFont.boldSystemFont(ofSize: 20)
        flashTitleLabel.textColor = .white
        
        flashMessageLabel.stringValue = "Up to 50% OFF!"
        flashMessageLabel.font = NSFont.systemFont(ofSize: 16)
        flashMessageLabel.textColor = .white
        
        flashCountLabel.stringValue = "Flashes: 0"
        flashCountLabel.font = NSFont.boldSystemFont(ofSize: 12)
        flashCountLabel.textColor = .white
        flashCountLabel.wantsLayer = true
        flashCountLabel.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.2).cgColor
        flashCountLabel.layer?.cornerRadius = 6
        
        pauseButton.title = "⏸️"
        pauseButton.font = NSFont.systemFont(ofSize: 20)
        pauseButton.target = self
        pauseButton.action = #selector(pauseButtonTapped)
        
        // Products Collection View
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.collectionViewLayout = createLayout()
        productsCollectionView.register(ProductCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("ProductItem"))
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
            Product(name: "Wireless Headphones", price: "$99.99", originalPrice: "$149.99", rating: 4.5, imageName: "headphones", isOutOfStock: false),
            Product(name: "Smart Watch", price: "$299.99", originalPrice: "$399.99", rating: 4.8, imageName: "smartwatch", isOutOfStock: false),
            Product(name: "Portable Speaker", price: "$79.99", originalPrice: "$99.99", rating: 4.3, imageName: "speaker", isOutOfStock: true),
            Product(name: "Gaming Mouse", price: "$59.99", originalPrice: "$79.99", rating: 4.6, imageName: "mouse", isOutOfStock: false),
            Product(name: "Mechanical Keyboard", price: "$129.99", originalPrice: "$179.99", rating: 4.7, imageName: "keyboard", isOutOfStock: false),
            Product(name: "USB-C Hub", price: "$49.99", originalPrice: "$69.99", rating: 4.2, imageName: "hub", isOutOfStock: false)
        ]
        productsCollectionView.reloadData()
    }
    
    private func startFlashAnimation() {
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            guard let self = self, self.isFlashing else { return }
            
            self.flashCount += 1
            self.flashCountLabel.stringValue = "Flashes: \(self.flashCount)"
            
            // Toggle between red and orange
            let currentColor = self.flashBanner.layer?.backgroundColor
            let newColor = currentColor == NSColor.systemRed.cgColor ? NSColor.systemOrange.cgColor : NSColor.systemRed.cgColor
            self.flashBanner.layer?.backgroundColor = newColor
        }
    }
    
    @objc private func pauseButtonTapped() {
        isFlashing.toggle()
        pauseButton.title = isFlashing ? "⏸️" : "▶️"
        
        if !isFlashing {
            flashTimer?.invalidate()
        } else {
            startFlashAnimation()
        }
    }
    
    deinit {
        flashTimer?.invalidate()
    }
}

// MARK: - NSCollectionViewDataSource
extension FlashingAdvertisement: NSCollectionViewDataSource {
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
extension FlashingAdvertisement: NSCollectionViewDelegate {
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
    let isOutOfStock: Bool
}

// MARK: - Product Collection View Item
class ProductCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var productImageView: NSImageView!
    @IBOutlet weak var outOfStockOverlay: NSView!
    @IBOutlet weak var outOfStockLabel: NSTextField!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var ratingLabel: NSTextField!
    @IBOutlet weak var priceLabel: NSTextField!
    @IBOutlet weak var originalPriceLabel: NSTextField!
    @IBOutlet weak var saveLabel: NSTextField!
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
        
        // Out of Stock Overlay
        outOfStockOverlay.wantsLayer = true
        outOfStockOverlay.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.7).cgColor
        outOfStockOverlay.layer?.cornerRadius = 8
        
        outOfStockLabel.stringValue = "Out of Stock"
        outOfStockLabel.font = NSFont.boldSystemFont(ofSize: 12)
        outOfStockLabel.textColor = .white
        outOfStockLabel.alignment = .center
        
        // Labels
        nameLabel.font = NSFont.boldSystemFont(ofSize: 16)
        ratingLabel.font = NSFont.systemFont(ofSize: 12)
        priceLabel.font = NSFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .systemGreen
        originalPriceLabel.font = NSFont.systemFont(ofSize: 14)
        originalPriceLabel.textColor = .secondaryLabelColor
        
        // Save Label
        saveLabel.font = NSFont.boldSystemFont(ofSize: 10)
        saveLabel.textColor = .white
        saveLabel.wantsLayer = true
        saveLabel.layer?.backgroundColor = NSColor.systemGreen.cgColor
        saveLabel.layer?.cornerRadius = 4
        
        // Add to Cart Button
        addToCartButton.title = "Add to Cart"
        addToCartButton.bezelStyle = .rounded
        addToCartButton.target = self
        addToCartButton.action = #selector(addToCartTapped)
    }
    
    func configure(with product: Product) {
        productImageView.image = NSImage(named: product.imageName)
        
        outOfStockOverlay.isHidden = !product.isOutOfStock
        
        nameLabel.stringValue = product.name
        ratingLabel.stringValue = "⭐ \(product.rating)"
        priceLabel.stringValue = product.price
        originalPriceLabel.stringValue = product.originalPrice
        
        // Calculate savings
        let originalPrice = Double(product.originalPrice.replacingOccurrences(of: "$", with: "")) ?? 0
        let currentPrice = Double(product.price.replacingOccurrences(of: "$", with: "")) ?? 0
        let savings = originalPrice - currentPrice
        saveLabel.stringValue = "Save $\(Int(savings))"
        
        addToCartButton.isEnabled = !product.isOutOfStock
        addToCartButton.title = product.isOutOfStock ? "Out of Stock" : "Add to Cart"
    }
    
    @objc private func addToCartTapped() {
        // Handle add to cart
    }
}

// MARK: - Storyboard Support
extension FlashingAdvertisement {
    static func instantiate() -> FlashingAdvertisement {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "FlashingAdvertisement") as! FlashingAdvertisement
    }
}
