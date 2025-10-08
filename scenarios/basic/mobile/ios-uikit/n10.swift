import UIKit

class MissingImageAltTextViewController: UIViewController {
    
    private var products: [Product] = []
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    private func setupData() {
        products = [
            Product(
                id: 1,
                name: "Wireless Headphones",
                brand: "TechBrand",
                price: 199.99,
                originalPrice: 249.99,
                rating: 4.5,
                reviewCount: 128,
                imageURL: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300",
                category: "Electronics",
                description: "High-quality wireless headphones with noise cancellation",
                isOnSale: true
            ),
            Product(
                id: 2,
                name: "Running Shoes",
                brand: "SportBrand",
                price: 129.99,
                originalPrice: 129.99,
                rating: 4.8,
                reviewCount: 89,
                imageURL: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300",
                category: "Sports",
                description: "Comfortable running shoes with advanced cushioning",
                isOnSale: false
            ),
            Product(
                id: 3,
                name: "Smart Watch",
                brand: "TechBrand",
                price: 299.99,
                originalPrice: 399.99,
                rating: 4.3,
                reviewCount: 156,
                imageURL: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300",
                category: "Electronics",
                description: "Advanced smartwatch with fitness tracking",
                isOnSale: true
            ),
            Product(
                id: 4,
                name: "Coffee Maker",
                brand: "HomeBrand",
                price: 89.99,
                originalPrice: 89.99,
                rating: 4.6,
                reviewCount: 203,
                imageURL: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=300",
                category: "Home",
                description: "Programmable coffee maker with multiple options",
                isOnSale: false
            ),
            Product(
                id: 5,
                name: "Programming Book",
                brand: "BookBrand",
                price: 49.99,
                originalPrice: 59.99,
                rating: 4.7,
                reviewCount: 92,
                imageURL: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300",
                category: "Books",
                description: "Comprehensive guide to modern programming",
                isOnSale: true
            ),
            Product(
                id: 6,
                name: "T-Shirt",
                brand: "FashionBrand",
                price: 24.99,
                originalPrice: 24.99,
                rating: 4.2,
                reviewCount: 67,
                imageURL: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300",
                category: "Clothing",
                description: "Comfortable cotton t-shirt in various colors",
                isOnSale: false
            )
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "E-Commerce Store"
        
        // Search bar
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search products..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Category filter
        let categoryScrollView = UIScrollView()
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryScrollView)
        
        let categoryStackView = UIStackView()
        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 12
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryScrollView.addSubview(categoryStackView)
        
        let categories = ["All", "Electronics", "Sports", "Home", "Books", "Clothing"]
        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            button.layer.cornerRadius = 20
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            button.addTarget(self, action: #selector(categoryTapped(_:)), for: .touchUpInside)
            categoryStackView.addArrangedSubview(button)
        }
        
        // Collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // Filter and sort controls
        let controlsStackView = UIStackView()
        controlsStackView.axis = .horizontal
        controlsStackView.distribution = .fillEqually
        controlsStackView.spacing = 12
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlsStackView)
        
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        filterButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        filterButton.layer.cornerRadius = 8
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        controlsStackView.addArrangedSubview(filterButton)
        
        let sortButton = UIButton(type: .system)
        sortButton.setTitle("Sort", for: .normal)
        sortButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sortButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        sortButton.layer.cornerRadius = 8
        sortButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        controlsStackView.addArrangedSubview(sortButton)
        
        let viewToggleButton = UIButton(type: .system)
        viewToggleButton.setTitle("Grid", for: .normal)
        viewToggleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        viewToggleButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        viewToggleButton.layer.cornerRadius = 8
        viewToggleButton.addTarget(self, action: #selector(viewToggleTapped), for: .touchUpInside)
        controlsStackView.addArrangedSubview(viewToggleButton)
        
        // Results count
        let resultsLabel = UILabel()
        resultsLabel.text = "\(products.count) products found"
        resultsLabel.font = UIFont.systemFont(ofSize: 14)
        resultsLabel.textColor = .secondaryLabel
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryScrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            categoryScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 16),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor, constant: -16),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            categoryStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor),
            
            controlsStackView.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor, constant: 8),
            controlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            controlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            controlsStackView.heightAnchor.constraint(equalToConstant: 40),
            
            resultsLabel.topAnchor.constraint(equalTo: controlsStackView.bottomAnchor, constant: 8),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func categoryTapped(_ sender: UIButton) {
        // Reset all buttons
        for subview in view.subviews {
            if let stackView = subview as? UIStackView {
                for arrangedSubview in stackView.arrangedSubviews {
                    if let button = arrangedSubview as? UIButton {
                        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
                        button.setTitleColor(.systemBlue, for: .normal)
                    }
                }
            }
        }
        
        // Highlight selected button
        sender.backgroundColor = .systemBlue
        sender.setTitleColor(.white, for: .normal)
        
        // Filter products by category
        let selectedCategory = sender.title(for: .normal) ?? "All"
        if selectedCategory == "All" {
            // Show all products
        } else {
            // Filter by category
        }
    }
    
    @objc private func filterTapped() {
        let alert = UIAlertController(title: "Filter Products", message: "Select filters to apply", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Price: Low to High", style: .default) { _ in
            // Apply price filter
        })
        
        alert.addAction(UIAlertAction(title: "Price: High to Low", style: .default) { _ in
            // Apply price filter
        })
        
        alert.addAction(UIAlertAction(title: "Rating: 4+ Stars", style: .default) { _ in
            // Apply rating filter
        })
        
        alert.addAction(UIAlertAction(title: "On Sale Only", style: .default) { _ in
            // Apply sale filter
        })
        
        alert.addAction(UIAlertAction(title: "Clear Filters", style: .destructive) { _ in
            // Clear all filters
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func sortTapped() {
        let alert = UIAlertController(title: "Sort Products", message: "Choose sorting option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Name A-Z", style: .default) { _ in
            // Sort by name
        })
        
        alert.addAction(UIAlertAction(title: "Name Z-A", style: .default) { _ in
            // Sort by name reverse
        })
        
        alert.addAction(UIAlertAction(title: "Price Low to High", style: .default) { _ in
            // Sort by price
        })
        
        alert.addAction(UIAlertAction(title: "Price High to Low", style: .default) { _ in
            // Sort by price reverse
        })
        
        alert.addAction(UIAlertAction(title: "Rating High to Low", style: .default) { _ in
            // Sort by rating
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func viewToggleTapped() {
        // Toggle between grid and list view
    }
}

// MARK: - UICollectionViewDataSource
extension MissingImageAltTextViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MissingImageAltTextViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]
        let detailVC = ProductDetailViewController()
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MissingImageAltTextViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - (padding * 3)
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 280)
    }
}

// MARK: - UISearchBarDelegate
extension MissingImageAltTextViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter products based on search text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Product Cell
class ProductCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let priceLabel = UILabel()
    private let originalPriceLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let reviewCountLabel = UILabel()
    private let saleBadge = UILabel()
    private let addToCartButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.1
        
        // Product image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        // Sale badge
        saleBadge.text = "SALE"
        saleBadge.font = UIFont.boldSystemFont(ofSize: 12)
        saleBadge.textColor = .white
        saleBadge.backgroundColor = .systemRed
        saleBadge.textAlignment = .center
        saleBadge.layer.cornerRadius = 4
        saleBadge.clipsToBounds = true
        saleBadge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saleBadge)
        
        // Product name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        // Brand
        brandLabel.font = UIFont.systemFont(ofSize: 14)
        brandLabel.textColor = .secondaryLabel
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brandLabel)
        
        // Rating stack view
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 2
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingStackView)
        
        // Review count
        reviewCountLabel.font = UIFont.systemFont(ofSize: 12)
        reviewCountLabel.textColor = .secondaryLabel
        reviewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reviewCountLabel)
        
        // Price
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .systemBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        // Original price
        originalPriceLabel.font = UIFont.systemFont(ofSize: 14)
        originalPriceLabel.textColor = .secondaryLabel
        originalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(originalPriceLabel)
        
        // Add to cart button
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addToCartButton.backgroundColor = .systemBlue
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 6
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addToCartButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            saleBadge.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            saleBadge.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            saleBadge.widthAnchor.constraint(equalToConstant: 40),
            saleBadge.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            ratingStackView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            reviewCountLabel.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor),
            reviewCountLabel.leadingAnchor.constraint(equalTo: ratingStackView.trailingAnchor, constant: 4),
            reviewCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            originalPriceLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addToCartButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            addToCartButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        brandLabel.text = product.brand
        priceLabel.text = String(format: "$%.2f", product.price)
        
        if product.originalPrice > product.price {
            originalPriceLabel.text = String(format: "$%.2f", product.originalPrice)
            originalPriceLabel.attributedText = NSAttributedString(
                string: String(format: "$%.2f", product.originalPrice),
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            saleBadge.isHidden = false
        } else {
            originalPriceLabel.text = ""
            saleBadge.isHidden = true
        }
        
        // Load image
        if let url = URL(string: product.imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }.resume()
        }
        
        // Rating stars
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for i in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: i < Int(product.rating) ? "star.fill" : "star")
            starImageView.tintColor = .systemYellow
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
            ratingStackView.addArrangedSubview(starImageView)
        }
        
        reviewCountLabel.text = "(\(product.reviewCount))"
    }
    
    @objc private func addToCartTapped() {
        // Add to cart functionality
        print("Added to cart")
    }
}

// MARK: - Product Detail View Controller
class ProductDetailViewController: UIViewController {
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Product Details"
        
        guard let product = product else { return }
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Product image
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        // Product details
        let nameLabel = UILabel()
        nameLabel.text = product.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        let brandLabel = UILabel()
        brandLabel.text = product.brand
        brandLabel.font = UIFont.systemFont(ofSize: 18)
        brandLabel.textColor = .secondaryLabel
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brandLabel)
        
        let priceLabel = UILabel()
        priceLabel.text = String(format: "$%.2f", product.price)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 28)
        priceLabel.textColor = .systemBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = product.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        // Load image
        if let url = URL(string: product.imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }.resume()
        }
        
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
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Data Models
struct Product {
    let id: Int
    let name: String
    let brand: String
    let price: Double
    let originalPrice: Double
    let rating: Double
    let reviewCount: Int
    let imageURL: String
    let category: String
    let description: String
    let isOnSale: Bool
}
