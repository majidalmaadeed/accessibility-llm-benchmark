import UIKit

class CustomDropdownNavigationViewController: UIViewController {
    
    // MARK: - Properties
    private var isOpen = false
    private var selectedValue = "all"
    private var selectedText = "All Categories"
    private var currentIndex = 0
    
    private let options = [
        (value: "all", text: "All Categories"),
        (value: "electronics", text: "Electronics"),
        (value: "clothing", text: "Clothing"),
        (value: "books", text: "Books"),
        (value: "home", text: "Home & Garden")
    ]
    
    private let products: [String: [Product]] = [
        "all": [
            Product(name: "iPhone 15", category: "Electronics"),
            Product(name: "MacBook Pro", category: "Electronics"),
            Product(name: "Cotton T-Shirt", category: "Clothing"),
            Product(name: "JavaScript Guide", category: "Books"),
            Product(name: "Garden Tools", category: "Home & Garden")
        ],
        "electronics": [
            Product(name: "iPhone 15", category: "Electronics"),
            Product(name: "MacBook Pro", category: "Electronics")
        ],
        "clothing": [
            Product(name: "Cotton T-Shirt", category: "Clothing")
        ],
        "books": [
            Product(name: "JavaScript Guide", category: "Books")
        ],
        "home": [
            Product(name: "Garden Tools", category: "Home & Garden")
        ]
    ]
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let filterLabel = UILabel()
    private let dropdownButton = UIButton(type: .system)
    private let dropdownTableView = UITableView()
    private let resultsLabel = UILabel()
    private let collectionView: UICollectionView
    private let accessibilityInfoLabel = UILabel()
    
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 100)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAccessibility()
        updateResults()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        
        // Scroll View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Title
        titleLabel.text = "Product Filter - Custom Dropdown Accessibility Violation"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Description
        descriptionLabel.text = "Violation: Custom dropdown lacks proper keyboard navigation, ARIA attributes, and screen reader support."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor.secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        // Filter Label
        filterLabel.text = "Filter by Category:"
        filterLabel.font = UIFont.boldSystemFont(ofSize: 18)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(filterLabel)
        
        // Dropdown Button
        dropdownButton.setTitle(selectedText, for: .normal)
        dropdownButton.backgroundColor = UIColor.systemGray6
        dropdownButton.layer.borderWidth = 2
        dropdownButton.layer.borderColor = UIColor.systemGray4.cgColor
        dropdownButton.layer.cornerRadius = 8
        dropdownButton.contentHorizontalAlignment = .left
        dropdownButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        dropdownButton.addTarget(self, action: #selector(dropdownButtonTapped), for: .touchUpInside)
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dropdownButton)
        
        // Dropdown Table View
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        dropdownTableView.backgroundColor = UIColor.systemBackground
        dropdownTableView.layer.borderWidth = 2
        dropdownTableView.layer.borderColor = UIColor.systemBlue.cgColor
        dropdownTableView.layer.cornerRadius = 8
        dropdownTableView.isHidden = true
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dropdownTableView)
        
        // Results Label
        resultsLabel.text = "Filtered Results"
        resultsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(resultsLabel)
        
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        
        // Accessibility Info
        accessibilityInfoLabel.text = """
        Accessibility Issues:
        • Incomplete keyboard navigation: Arrow keys don't navigate through options
        • Missing ARIA attributes: No aria-activedescendant or proper role attributes
        • Focus management: Focus doesn't move to options when dropdown opens
        • Screen reader announcements: No announcements when selection changes
        • Escape key handling: Escape doesn't close dropdown
        • Tab order: Options are not in proper tab sequence
        
        How to Fix:
        • Add aria-activedescendant to track focused option
        • Implement arrow key navigation (Up/Down)
        • Add aria-selected to indicate selected state
        • Handle Escape key to close dropdown
        • Add aria-live region for selection announcements
        • Ensure proper focus management when opening/closing
        """
        accessibilityInfoLabel.font = UIFont.systemFont(ofSize: 14)
        accessibilityInfoLabel.numberOfLines = 0
        accessibilityInfoLabel.backgroundColor = UIColor.systemGray6
        accessibilityInfoLabel.layer.cornerRadius = 8
        accessibilityInfoLabel.textAlignment = .left
        accessibilityInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accessibilityInfoLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Filter Label
            filterLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Dropdown Button
            dropdownButton.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 8),
            dropdownButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dropdownButton.widthAnchor.constraint(equalToConstant: 200),
            dropdownButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Dropdown Table View
            dropdownTableView.topAnchor.constraint(equalTo: dropdownButton.bottomAnchor),
            dropdownTableView.leadingAnchor.constraint(equalTo: dropdownButton.leadingAnchor),
            dropdownTableView.trailingAnchor.constraint(equalTo: dropdownButton.trailingAnchor),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 220),
            
            // Results Label
            resultsLabel.topAnchor.constraint(equalTo: dropdownButton.bottomAnchor, constant: 30),
            resultsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Collection View
            collectionView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            // Accessibility Info
            accessibilityInfoLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            accessibilityInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            accessibilityInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            accessibilityInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupAccessibility() {
        dropdownButton.accessibilityLabel = "Category filter"
        dropdownButton.accessibilityHint = "Double tap to open dropdown"
        dropdownButton.accessibilityValue = selectedText
        dropdownButton.accessibilityTraits = .button
    }
    
    // MARK: - Actions
    @objc private func dropdownButtonTapped() {
        toggleDropdown()
    }
    
    private func toggleDropdown() {
        isOpen.toggle()
        dropdownTableView.isHidden = !isOpen
        
        if isOpen {
            dropdownButton.layer.borderColor = UIColor.systemBlue.cgColor
            dropdownButton.layer.cornerRadius = 8
            dropdownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            dropdownButton.layer.borderColor = UIColor.systemGray4.cgColor
            dropdownButton.layer.cornerRadius = 8
            dropdownButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    private func selectOption(value: String, text: String, index: Int) {
        selectedValue = value
        selectedText = text
        currentIndex = index
        
        dropdownButton.setTitle(selectedText, for: .normal)
        dropdownButton.accessibilityValue = selectedText
        
        toggleDropdown()
        updateResults()
        
        // Accessibility announcement
        UIAccessibility.post(notification: .announcement, argument: "Selected \(text)")
    }
    
    private func updateResults() {
        collectionView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CustomDropdownNavigationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        let option = options[indexPath.row]
        
        cell.textLabel?.text = option.text
        cell.backgroundColor = UIColor.clear
        
        if selectedValue == option.value {
            cell.backgroundColor = UIColor.systemBlue
            cell.textLabel?.textColor = UIColor.white
            cell.accessibilityTraits = .selected
        } else {
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.label
            cell.accessibilityTraits = []
        }
        
        cell.accessibilityLabel = option.text
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CustomDropdownNavigationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = options[indexPath.row]
        selectOption(value: option.value, text: option.text, index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension CustomDropdownNavigationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products[selectedValue]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[selectedValue]![indexPath.item]
        cell.configure(with: product)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CustomDropdownNavigationViewController: UICollectionViewDelegate {
    // Collection view delegate methods can be added here if needed
}

// MARK: - ProductCell
class ProductCell: UICollectionViewCell {
    private let nameLabel = UILabel()
    private let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 8
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = UIColor.secondaryLabel
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        categoryLabel.text = product.category
    }
}

// MARK: - Product Model
struct Product {
    let name: String
    let category: String
}