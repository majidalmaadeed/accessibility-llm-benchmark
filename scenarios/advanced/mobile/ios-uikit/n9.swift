import UIKit

class ShoppingCartSystemViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var summaryView: UIView!
    private var promoCodeField: UITextField!
    private var promoCodeButton: UIButton!
    private var checkoutButton: UIButton!
    private var subtotalLabel: UILabel!
    private var taxLabel: UILabel!
    private var shippingLabel: UILabel!
    private var discountLabel: UILabel!
    private var totalLabel: UILabel!
    
    private var cartItems: [CartItem] = []
    private var promoCode: String = ""
    private var appliedPromo: PromoCode? = nil
    private var showPromoField: Bool = false
    private var isCheckingOut: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCartItems()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Shopping Cart"
        
        setupTableView()
        setupSummaryView()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: "CartItemCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupSummaryView() {
        summaryView = UIView()
        summaryView.backgroundColor = .systemGray6
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Order Summary"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtotalLabel = UILabel()
        subtotalLabel.text = "Subtotal: $0.00"
        subtotalLabel.font = UIFont.systemFont(ofSize: 16)
        subtotalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        taxLabel = UILabel()
        taxLabel.text = "Tax: $0.00"
        taxLabel.font = UIFont.systemFont(ofSize: 16)
        taxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        shippingLabel = UILabel()
        shippingLabel.text = "Shipping: $5.99"
        shippingLabel.font = UIFont.systemFont(ofSize: 16)
        shippingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        discountLabel = UILabel()
        discountLabel.text = ""
        discountLabel.font = UIFont.systemFont(ofSize: 16)
        discountLabel.textColor = .systemGreen
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray4
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        totalLabel = UILabel()
        totalLabel.text = "Total: $0.00"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        promoCodeField = UITextField()
        promoCodeField.placeholder = "Enter promo code"
        promoCodeField.borderStyle = .roundedRect
        promoCodeField.translatesAutoresizingMaskIntoConstraints = false
        
        promoCodeButton = UIButton(type: .system)
        promoCodeButton.setTitle("Apply", for: .normal)
        promoCodeButton.backgroundColor = .systemBlue
        promoCodeButton.setTitleColor(.white, for: .normal)
        promoCodeButton.layer.cornerRadius = 8
        promoCodeButton.addTarget(self, action: #selector(applyPromoCode), for: .touchUpInside)
        promoCodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkoutButton = UIButton(type: .system)
        checkoutButton.setTitle("Proceed to Checkout", for: .normal)
        checkoutButton.backgroundColor = .systemGreen
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 8
        checkoutButton.addTarget(self, action: #selector(proceedToCheckout), for: .touchUpInside)
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, subtotalLabel, taxLabel, shippingLabel, discountLabel, separatorView, totalLabel, promoCodeField, promoCodeButton, checkoutButton].forEach {
            summaryView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            subtotalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtotalLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            subtotalLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            taxLabel.topAnchor.constraint(equalTo: subtotalLabel.bottomAnchor, constant: 8),
            taxLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            taxLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            shippingLabel.topAnchor.constraint(equalTo: taxLabel.bottomAnchor, constant: 8),
            shippingLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            shippingLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            discountLabel.topAnchor.constraint(equalTo: shippingLabel.bottomAnchor, constant: 8),
            discountLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            discountLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            separatorView.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 16),
            separatorView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            totalLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16),
            totalLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            promoCodeField.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 16),
            promoCodeField.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            promoCodeField.trailingAnchor.constraint(equalTo: promoCodeButton.leadingAnchor, constant: -8),
            
            promoCodeButton.centerYAnchor.constraint(equalTo: promoCodeField.centerYAnchor),
            promoCodeButton.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            promoCodeButton.widthAnchor.constraint(equalToConstant: 80),
            promoCodeButton.heightAnchor.constraint(equalToConstant: 36),
            
            checkoutButton.topAnchor.constraint(equalTo: promoCodeField.bottomAnchor, constant: 16),
            checkoutButton.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 44),
            checkoutButton.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryView.topAnchor),
            
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Data Management
    
    private func loadCartItems() {
        cartItems = [
            CartItem(
                id: UUID(),
                name: "Wireless Headphones",
                price: 99.99,
                quantity: 1,
                image: "headphones",
                description: "High-quality wireless headphones with noise cancellation"
            ),
            CartItem(
                id: UUID(),
                name: "Smart Watch",
                price: 299.99,
                quantity: 1,
                image: "applewatch",
                description: "Advanced smartwatch with health monitoring"
            ),
            CartItem(
                id: UUID(),
                name: "Phone Case",
                price: 24.99,
                quantity: 2,
                image: "case",
                description: "Protective phone case with wireless charging"
            )
        ]
        
        tableView.reloadData()
        updateSummary()
    }
    
    private func updateSummary() {
        let subtotal = cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        let tax = subtotal * 0.08
        let shipping = 5.99
        let discount = appliedPromo?.discount ?? 0
        let total = subtotal + tax + shipping - discount
        
        subtotalLabel.text = "Subtotal: \(formatCurrency(subtotal))"
        taxLabel.text = "Tax: \(formatCurrency(tax))"
        shippingLabel.text = "Shipping: \(formatCurrency(shipping))"
        
        if discount > 0 {
            discountLabel.text = "Discount (\(appliedPromo?.code ?? "")): -\(formatCurrency(discount))"
        } else {
            discountLabel.text = ""
        }
        
        totalLabel.text = "Total: \(formatCurrency(total))"
    }
    
    // MARK: - Actions
    
    @objc private func applyPromoCode() {
        guard let code = promoCodeField.text, !code.isEmpty else { return }
        
        let validPromos = [
            PromoCode(code: "SAVE10", discount: 10.0, description: "Save $10 on your order"),
            PromoCode(code: "WELCOME", discount: 15.0, description: "Welcome discount - Save $15"),
            PromoCode(code: "FREESHIP", discount: 5.99, description: "Free shipping on your order")
        ]
        
        if let promo = validPromos.first(where: { $0.code.uppercased() == code.uppercased() }) {
            appliedPromo = promo
            promoCodeField.text = ""
            updateSummary()
            
            let alert = UIAlertController(title: "Promo Code Applied!", message: promo.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Invalid Promo Code", message: "The promo code you entered is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc private func proceedToCheckout() {
        isCheckingOut = true
        checkoutButton.setTitle("Processing...", for: .normal)
        checkoutButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isCheckingOut = false
            self.checkoutButton.setTitle("Proceed to Checkout", for: .normal)
            self.checkoutButton.isEnabled = true
            
            let alert = UIAlertController(title: "Order Placed!", message: "Your order has been placed successfully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func updateCartItem(_ item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index] = item
            tableView.reloadData()
            updateSummary()
        }
    }
    
    private func removeCartItem(_ id: UUID) {
        cartItems.removeAll { $0.id == id }
        tableView.reloadData()
        updateSummary()
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}

// MARK: - UITableViewDataSource

extension ShoppingCartSystemViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemTableViewCell
        let item = cartItems[indexPath.row]
        
        cell.configure(with: item)
        cell.onUpdate = { [weak self] updatedItem in
            self?.updateCartItem(updatedItem)
        }
        cell.onRemove = { [weak self] in
            self?.removeCartItem(item.id)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ShoppingCartSystemViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - Supporting Views

class CartItemTableViewCell: UITableViewCell {
    
    private let itemImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let quantityStepper = UIStepper()
    private let quantityLabel = UILabel()
    private let removeButton = UIButton(type: .system)
    
    var onUpdate: ((CartItem) -> Void)?
    var onRemove: (() -> Void)?
    
    private var currentItem: CartItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        itemImageView.backgroundColor = .systemGray6
        itemImageView.layer.cornerRadius = 8
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.textColor = .systemBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        quantityStepper.minimumValue = 1
        quantityStepper.maximumValue = 10
        quantityStepper.addTarget(self, action: #selector(quantityChanged(_:)), for: .valueChanged)
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        
        quantityLabel.font = UIFont.systemFont(ofSize: 16)
        quantityLabel.textAlignment = .center
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(.systemRed, for: .normal)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        [itemImageView, nameLabel, descriptionLabel, priceLabel, quantityStepper, quantityLabel, removeButton].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            
            quantityStepper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            quantityStepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            quantityLabel.topAnchor.constraint(equalTo: quantityStepper.bottomAnchor, constant: 8),
            quantityLabel.centerXAnchor.constraint(equalTo: quantityStepper.centerXAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 30),
            
            removeButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 8),
            removeButton.centerXAnchor.constraint(equalTo: quantityStepper.centerXAnchor),
            removeButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with item: CartItem) {
        currentItem = item
        
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = formatCurrency(item.price)
        quantityStepper.value = Double(item.quantity)
        quantityLabel.text = "\(item.quantity)"
        
        // Set placeholder image
        itemImageView.image = UIImage(systemName: item.image)
    }
    
    @objc private func quantityChanged(_ sender: UIStepper) {
        guard var item = currentItem else { return }
        
        item.quantity = Int(sender.value)
        quantityLabel.text = "\(item.quantity)"
        
        onUpdate?(item)
    }
    
    @objc private func removeButtonTapped() {
        onRemove?()
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}

// MARK: - Supporting Types

struct CartItem {
    let id: UUID
    let name: String
    let price: Double
    var quantity: Int
    let image: String
    let description: String
}

struct PromoCode {
    let code: String
    let discount: Double
    let description: String
}
