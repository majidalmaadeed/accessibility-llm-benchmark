import UIKit
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
    private let dropdownButton = UIButton(type: .system)
    private let collectionView: UICollectionView
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
        // Description
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
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            // Content View
            // Title
            // Description
            // Dropdown Button
            // Collection View
        ])
    }
    }
    // MARK: - Actions
    @objc private func dropdownButtonTapped() {
        toggleDropdown()
    }
    private func toggleDropdown() {
        isOpen.toggle()
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
        toggleDropdown()
        updateResults()
    }
    private func updateResults() {
        collectionView.reloadData()
    }
}
        return options.count
    }
        let option = options[indexPath.row]
        cell.backgroundColor = UIColor.clear
        if selectedValue == option.value {
            cell.backgroundColor = UIColor.systemBlue
        } else {
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
}
        let option = options[indexPath.row]
        selectOption(value: option.value, text: option.text, index: indexPath.row)
    }
}
// MARK: - UICollectionViewDataSource
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
    // Collection view delegate methods can be added here if needed
}
// MARK: - ProductCell
class ProductCell: UICollectionViewCell {
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
        NSLayoutConstraint.activate([
        ])
    }
    func configure(with product: Product) {
    }
}
// MARK: - Product Model
struct Product {
    let name: String
    let category: String
}