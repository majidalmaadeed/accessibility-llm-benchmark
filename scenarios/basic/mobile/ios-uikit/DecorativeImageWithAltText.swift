import UIKit

class DecorativeImageWithAltTextViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Product Showcase"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header section
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Product showcase section
        let showcaseView = createShowcaseView()
        contentView.addSubview(showcaseView)
        
        // Features section
        let featuresView = createFeaturesView()
        contentView.addSubview(featuresView)
        
        // Footer section
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
            
            showcaseView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            showcaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            showcaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            featuresView.topAnchor.constraint(equalTo: showcaseView.bottomAnchor),
            featuresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: featuresView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Decorative border image with unnecessary descriptive alt text
        let decorativeBorderImageView = UIImageView()
        decorativeBorderImageView.image = createDecorativeBorderImage()
        decorativeBorderImageView.contentMode = .scaleToFill
        decorativeBorderImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(decorativeBorderImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Premium Products"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Discover our exclusive collection"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(subtitleLabel)
        
        // Decorative corner images with unnecessary alt text
        let topLeftCornerImageView = UIImageView()
        topLeftCornerImageView.image = createCornerImage()
        topLeftCornerImageView.contentMode = .scaleAspectFit
        topLeftCornerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(topLeftCornerImageView)
        
        let topRightCornerImageView = UIImageView()
        topRightCornerImageView.image = createCornerImage()
        topRightCornerImageView.contentMode = .scaleAspectFit
        topRightCornerImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        topRightCornerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(topRightCornerImageView)
        
        let bottomLeftCornerImageView = UIImageView()
        bottomLeftCornerImageView.image = createCornerImage()
        bottomLeftCornerImageView.contentMode = .scaleAspectFit
        bottomLeftCornerImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
        bottomLeftCornerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(bottomLeftCornerImageView)
        
        let bottomRightCornerImageView = UIImageView()
        bottomRightCornerImageView.image = createCornerImage()
        bottomRightCornerImageView.contentMode = .scaleAspectFit
        bottomRightCornerImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
        bottomRightCornerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(bottomRightCornerImageView)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            decorativeBorderImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            decorativeBorderImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            decorativeBorderImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            decorativeBorderImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20),
            
            topLeftCornerImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            topLeftCornerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            topLeftCornerImageView.widthAnchor.constraint(equalToConstant: 30),
            topLeftCornerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            topRightCornerImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            topRightCornerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            topRightCornerImageView.widthAnchor.constraint(equalToConstant: 30),
            topRightCornerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            bottomLeftCornerImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            bottomLeftCornerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            bottomLeftCornerImageView.widthAnchor.constraint(equalToConstant: 30),
            bottomLeftCornerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            bottomRightCornerImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            bottomRightCornerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            bottomRightCornerImageView.widthAnchor.constraint(equalToConstant: 30),
            bottomRightCornerImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return headerView
    }
    
    private func createShowcaseView() -> UIView {
        let showcaseView = UIView()
        showcaseView.backgroundColor = .systemBackground
        showcaseView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Featured Products"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        showcaseView.addSubview(titleLabel)
        
        // Product grid
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        showcaseView.addSubview(stackView)
        
        for i in 1...3 {
            let productView = createProductView(number: i)
            stackView.addArrangedSubview(productView)
        }
        
        NSLayoutConstraint.activate([
            showcaseView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
            titleLabel.topAnchor.constraint(equalTo: showcaseView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: showcaseView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: showcaseView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: showcaseView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: showcaseView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: showcaseView.bottomAnchor, constant: -20)
        ])
        
        return showcaseView
    }
    
    private func createProductView(number: Int) -> UIView {
        let productView = UIView()
        productView.backgroundColor = .systemGray6
        productView.layer.cornerRadius = 12
        productView.translatesAutoresizingMaskIntoConstraints = false
        
        // Decorative background pattern with unnecessary alt text
        let backgroundPatternImageView = UIImageView()
        backgroundPatternImageView.image = createPatternImage()
        backgroundPatternImageView.contentMode = .scaleAspectFill
        backgroundPatternImageView.alpha = 0.1
        backgroundPatternImageView.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(backgroundPatternImageView)
        
        let productImageView = UIImageView()
        productImageView.image = UIImage(systemName: "cube.box")
        productImageView.tintColor = .systemBlue
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(productImageView)
        
        let productNameLabel = UILabel()
        productNameLabel.text = "Product \(number)"
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        productNameLabel.textAlignment = .center
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(productNameLabel)
        
        let productDescriptionLabel = UILabel()
        productDescriptionLabel.text = "High-quality product with excellent features and performance."
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        productDescriptionLabel.textColor = .secondaryLabel
        productDescriptionLabel.textAlignment = .center
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(productDescriptionLabel)
        
        // Decorative separator with unnecessary alt text
        let separatorImageView = UIImageView()
        separatorImageView.image = createSeparatorImage()
        separatorImageView.contentMode = .scaleAspectFit
        separatorImageView.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(separatorImageView)
        
        let priceLabel = UILabel()
        priceLabel.text = "$\(99 + number * 50)"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textColor = .systemBlue
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        productView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productView.heightAnchor.constraint(equalToConstant: 120),
            
            backgroundPatternImageView.topAnchor.constraint(equalTo: productView.topAnchor),
            backgroundPatternImageView.leadingAnchor.constraint(equalTo: productView.leadingAnchor),
            backgroundPatternImageView.trailingAnchor.constraint(equalTo: productView.trailingAnchor),
            backgroundPatternImageView.bottomAnchor.constraint(equalTo: productView.bottomAnchor),
            
            productImageView.centerXAnchor.constraint(equalTo: productView.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: productView.topAnchor, constant: 15),
            productImageView.widthAnchor.constraint(equalToConstant: 40),
            productImageView.heightAnchor.constraint(equalToConstant: 40),
            
            productNameLabel.centerXAnchor.constraint(equalTo: productView.centerXAnchor),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: productView.leadingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: productView.trailingAnchor, constant: -10),
            
            productDescriptionLabel.centerXAnchor.constraint(equalTo: productView.centerXAnchor),
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productDescriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: productView.leadingAnchor, constant: 10),
            productDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: productView.trailingAnchor, constant: -10),
            
            separatorImageView.centerXAnchor.constraint(equalTo: productView.centerXAnchor),
            separatorImageView.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 8),
            separatorImageView.widthAnchor.constraint(equalToConstant: 60),
            separatorImageView.heightAnchor.constraint(equalToConstant: 2),
            
            priceLabel.centerXAnchor.constraint(equalTo: productView.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: productView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: productView.trailingAnchor, constant: -10)
        ])
        
        return productView
    }
    
    private func createFeaturesView() -> UIView {
        let featuresView = UIView()
        featuresView.backgroundColor = .systemGray6
        featuresView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Why Choose Us?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        featuresView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        featuresView.addSubview(stackView)
        
        let features = [
            ("Quality", "Premium materials and craftsmanship"),
            ("Service", "24/7 customer support"),
            ("Innovation", "Cutting-edge technology")
        ]
        
        for (title, description) in features {
            let featureView = createFeatureItemView(title: title, description: description)
            stackView.addArrangedSubview(featureView)
        }
        
        NSLayoutConstraint.activate([
            featuresView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: featuresView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: featuresView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: featuresView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: featuresView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: featuresView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: -20)
        ])
        
        return featuresView
    }
    
    private func createFeatureItemView(title: String, description: String) -> UIView {
        let featureView = UIView()
        featureView.backgroundColor = .white
        featureView.layer.cornerRadius = 8
        featureView.translatesAutoresizingMaskIntoConstraints = false
        
        // Decorative icon background with unnecessary alt text
        let iconBackgroundImageView = UIImageView()
        iconBackgroundImageView.image = createIconBackgroundImage()
        iconBackgroundImageView.contentMode = .scaleAspectFill
        iconBackgroundImageView.alpha = 0.3
        iconBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(iconBackgroundImageView)
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "star.fill")
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            featureView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            iconBackgroundImageView.topAnchor.constraint(equalTo: featureView.topAnchor),
            iconBackgroundImageView.leadingAnchor.constraint(equalTo: featureView.leadingAnchor),
            iconBackgroundImageView.trailingAnchor.constraint(equalTo: featureView.trailingAnchor),
            iconBackgroundImageView.bottomAnchor.constraint(equalTo: featureView.bottomAnchor),
            
            iconImageView.leadingAnchor.constraint(equalTo: featureView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: featureView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: featureView.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: featureView.trailingAnchor, constant: -15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: featureView.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: featureView.bottomAnchor, constant: -15)
        ])
        
        return featureView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemBackground
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Decorative footer pattern with unnecessary alt text
        let footerPatternImageView = UIImageView()
        footerPatternImageView.image = createFooterPatternImage()
        footerPatternImageView.contentMode = .scaleAspectFill
        footerPatternImageView.alpha = 0.5
        footerPatternImageView.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(footerPatternImageView)
        
        let copyrightLabel = UILabel()
        copyrightLabel.text = "© 2024 Company Name. All rights reserved."
        copyrightLabel.font = UIFont.systemFont(ofSize: 14)
        copyrightLabel.textColor = .secondaryLabel
        copyrightLabel.textAlignment = .center
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(copyrightLabel)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 80),
            
            footerPatternImageView.topAnchor.constraint(equalTo: footerView.topAnchor),
            footerPatternImageView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            footerPatternImageView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            footerPatternImageView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            
            copyrightLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            copyrightLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            copyrightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: footerView.leadingAnchor, constant: 20),
            copyrightLabel.trailingAnchor.constraint(lessThanOrEqualTo: footerView.trailingAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    // MARK: - Image Creation Methods
    private func createDecorativeBorderImage() -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Create a decorative border pattern
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(2)
        
        // Draw decorative border
        for i in 0..<4 {
            let rect = CGRect(x: 5 + i * 2, y: 5 + i * 2, width: size.width - 10 - i * 4, height: size.height - 10 - i * 4)
            context.stroke(rect)
        }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func createCornerImage() -> UIImage? {
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(UIColor.white.withAlphaComponent(0.3).cgColor)
        context.fillEllipse(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func createPatternImage() -> UIImage? {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(UIColor.systemBlue.withAlphaComponent(0.1).cgColor)
        context.fillEllipse(in: CGRect(x: 10, y: 10, width: 30, height: 30))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func createSeparatorImage() -> UIImage? {
        let size = CGSize(width: 60, height: 2)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(UIColor.systemBlue.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func createIconBackgroundImage() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(UIColor.systemBlue.withAlphaComponent(0.1).cgColor)
        context.fillEllipse(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func createFooterPatternImage() -> UIImage? {
        let size = CGSize(width: 100, height: 20)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setStrokeColor(UIColor.systemGray.withAlphaComponent(0.3).cgColor)
        context.setLineWidth(1)
        
        for i in 0..<10 {
            let x = CGFloat(i) * 10
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: size.height))
        }
        context.strokePath()
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
