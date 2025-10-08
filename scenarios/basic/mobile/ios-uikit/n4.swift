import UIKit

class FlashingAdvertisementViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var flashingBanner: UIView!
    private var flashTimer: Timer?
    private var isFlashing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startFlashing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopFlashing()
    }
    
    deinit {
        stopFlashing()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Shopping Mall"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Flashing advertisement banner
        flashingBanner = createFlashingBanner()
        contentView.addSubview(flashingBanner)
        
        // Store directory
        let storeDirectoryView = createStoreDirectory()
        contentView.addSubview(storeDirectoryView)
        
        // Featured stores
        let featuredStoresView = createFeaturedStores()
        contentView.addSubview(featuredStoresView)
        
        // Events section
        let eventsView = createEventsSection()
        contentView.addSubview(eventsView)
        
        // Food court
        let foodCourtView = createFoodCourt()
        contentView.addSubview(foodCourtView)
        
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
            
            flashingBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            flashingBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flashingBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flashingBanner.heightAnchor.constraint(equalToConstant: 100),
            
            storeDirectoryView.topAnchor.constraint(equalTo: flashingBanner.bottomAnchor, constant: 20),
            storeDirectoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storeDirectoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            featuredStoresView.topAnchor.constraint(equalTo: storeDirectoryView.bottomAnchor, constant: 20),
            featuredStoresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredStoresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            eventsView.topAnchor.constraint(equalTo: featuredStoresView.bottomAnchor, constant: 20),
            eventsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            foodCourtView.topAnchor.constraint(equalTo: eventsView.bottomAnchor, constant: 20),
            foodCourtView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodCourtView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodCourtView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createFlashingBanner() -> UIView {
        let bannerView = UIView()
        bannerView.backgroundColor = UIColor.systemRed
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Sale text
        let saleLabel = UILabel()
        saleLabel.text = "🔥 MEGA SALE - UP TO 70% OFF! 🔥"
        saleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        saleLabel.textColor = .white
        saleLabel.textAlignment = .center
        saleLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerView.addSubview(saleLabel)
        
        // Subtitle
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Limited Time Offer - Shop Now!"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerView.addSubview(subtitleLabel)
        
        // Shop now button
        let shopNowButton = UIButton(type: .system)
        shopNowButton.setTitle("SHOP NOW", for: .normal)
        shopNowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        shopNowButton.setTitleColor(.systemRed, for: .normal)
        shopNowButton.backgroundColor = .white
        shopNowButton.layer.cornerRadius = 8
        shopNowButton.addTarget(self, action: #selector(shopNowTapped), for: .touchUpInside)
        shopNowButton.translatesAutoresizingMaskIntoConstraints = false
        bannerView.addSubview(shopNowButton)
        
        NSLayoutConstraint.activate([
            saleLabel.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            saleLabel.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor, constant: -15),
            saleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bannerView.leadingAnchor, constant: 20),
            saleLabel.trailingAnchor.constraint(lessThanOrEqualTo: bannerView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: saleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bannerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: bannerView.trailingAnchor, constant: -20),
            
            shopNowButton.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            shopNowButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            shopNowButton.widthAnchor.constraint(equalToConstant: 120),
            shopNowButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        return bannerView
    }
    
    private func createStoreDirectory() -> UIView {
        let directoryView = UIView()
        directoryView.backgroundColor = .systemBackground
        directoryView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Store Directory"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        directoryView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        directoryView.addSubview(stackView)
        
        let stores = [
            ("Fashion", "Level 1", "Clothing & Accessories"),
            ("Electronics", "Level 2", "Gadgets & Tech"),
            ("Home & Garden", "Level 1", "Furniture & Decor"),
            ("Beauty", "Level 2", "Cosmetics & Skincare"),
            ("Sports", "Level 3", "Athletic & Outdoor"),
            ("Books", "Level 2", "Books & Media")
        ]
        
        for (name, level, description) in stores {
            let storeView = createStoreItem(name: name, level: level, description: description)
            stackView.addArrangedSubview(storeView)
        }
        
        NSLayoutConstraint.activate([
            directoryView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: directoryView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: directoryView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: directoryView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: directoryView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: directoryView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: directoryView.bottomAnchor, constant: -20)
        ])
        
        return directoryView
    }
    
    private func createStoreItem(name: String, level: String, description: String) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(nameLabel)
        
        let levelLabel = UILabel()
        levelLabel.text = level
        levelLabel.font = UIFont.systemFont(ofSize: 14)
        levelLabel.textColor = .systemBlue
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(levelLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(descriptionLabel)
        
        let chevronImageView = UIImageView()
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = .systemGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
            
            levelLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            levelLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 2),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor, constant: -12),
            
            chevronImageView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        return itemView
    }
    
    private func createFeaturedStores() -> UIView {
        let featuredView = UIView()
        featuredView.backgroundColor = .systemBackground
        featuredView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Featured Stores"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredView.addSubview(titleLabel)
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        featuredView.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        let featuredStores = [
            ("Fashion Store", "New Collection", "20% Off"),
            ("Tech Hub", "Latest Gadgets", "Free Shipping"),
            ("Beauty Corner", "Premium Brands", "Buy 2 Get 1 Free"),
            ("Sports Zone", "Athletic Gear", "Up to 50% Off")
        ]
        
        for (name, subtitle, offer) in featuredStores {
            let storeCard = createFeaturedStoreCard(name: name, subtitle: subtitle, offer: offer)
            stackView.addArrangedSubview(storeCard)
        }
        
        NSLayoutConstraint.activate([
            featuredView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: featuredView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: featuredView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: featuredView.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: featuredView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: featuredView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: featuredView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        return featuredView
    }
    
    private func createFeaturedStoreCard(name: String, subtitle: String, offer: String) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .systemBlue
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(subtitleLabel)
        
        let offerLabel = UILabel()
        offerLabel.text = offer
        offerLabel.font = UIFont.boldSystemFont(ofSize: 12)
        offerLabel.textColor = .systemYellow
        offerLabel.textAlignment = .center
        offerLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(offerLabel)
        
        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 150),
            cardView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            offerLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            offerLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            offerLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            offerLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -16)
        ])
        
        return cardView
    }
    
    private func createEventsSection() -> UIView {
        let eventsView = UIView()
        eventsView.backgroundColor = .systemBackground
        eventsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Upcoming Events"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        eventsView.addSubview(stackView)
        
        let events = [
            ("Live Music Performance", "Today, 7:00 PM", "Main Atrium"),
            ("Kids Art Workshop", "Tomorrow, 2:00 PM", "Community Room"),
            ("Fashion Show", "This Weekend", "Fashion Court"),
            ("Food Tasting Event", "Next Week", "Food Court")
        ]
        
        for (title, time, location) in events {
            let eventView = createEventItem(title: title, time: time, location: location)
            stackView.addArrangedSubview(eventView)
        }
        
        NSLayoutConstraint.activate([
            eventsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: eventsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: eventsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: eventsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: eventsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: eventsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: eventsView.bottomAnchor, constant: -20)
        ])
        
        return eventsView
    }
    
    private func createEventItem(title: String, time: String, location: String) -> UIView {
        let eventView = UIView()
        eventView.backgroundColor = .systemGray6
        eventView.layer.cornerRadius = 8
        eventView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventView.addSubview(titleLabel)
        
        let timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .systemBlue
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventView.addSubview(timeLabel)
        
        let locationLabel = UILabel()
        locationLabel.text = location
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .secondaryLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        eventView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            eventView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: eventView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventView.trailingAnchor, constant: -16),
            
            timeLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventView.trailingAnchor, constant: -16),
            
            locationLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventView.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: eventView.bottomAnchor, constant: -8)
        ])
        
        return eventView
    }
    
    private func createFoodCourt() -> UIView {
        let foodCourtView = UIView()
        foodCourtView.backgroundColor = .systemBackground
        foodCourtView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Food Court"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        foodCourtView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        foodCourtView.addSubview(stackView)
        
        let restaurants = [
            ("Pizza Palace", "🍕"),
            ("Burger King", "🍔"),
            ("Sushi Bar", "🍣"),
            ("Coffee Shop", "☕")
        ]
        
        for (name, emoji) in restaurants {
            let restaurantView = createRestaurantCard(name: name, emoji: emoji)
            stackView.addArrangedSubview(restaurantView)
        }
        
        NSLayoutConstraint.activate([
            foodCourtView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: foodCourtView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: foodCourtView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: foodCourtView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: foodCourtView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: foodCourtView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: foodCourtView.bottomAnchor, constant: -20)
        ])
        
        return foodCourtView
    }
    
    private func createRestaurantCard(name: String, emoji: String) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .systemGray6
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 32)
        emojiLabel.textAlignment = .center
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(emojiLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: 80),
            
            emojiLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            emojiLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            
            nameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: cardView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12)
        ])
        
        return cardView
    }
    
    // MARK: - Flashing Animation
    private func startFlashing() {
        isFlashing = true
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.toggleBannerVisibility()
        }
    }
    
    private func stopFlashing() {
        isFlashing = false
        flashTimer?.invalidate()
        flashTimer = nil
    }
    
    private func toggleBannerVisibility() {
        guard isFlashing else { return }
        
        UIView.animate(withDuration: 0.1) {
            self.flashingBanner.alpha = self.flashingBanner.alpha == 1.0 ? 0.3 : 1.0
        }
    }
    
    @objc private func shopNowTapped() {
        let alert = UIAlertController(title: "Shop Now", message: "Redirecting to sale page...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
