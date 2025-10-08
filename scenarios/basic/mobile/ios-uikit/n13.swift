import UIKit

class MissingSkipLinkViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Company Website"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Navigation header
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Hero section
        let heroView = createHeroSection()
        contentView.addSubview(heroView)
        
        // Main content
        let mainContentView = createMainContent()
        contentView.addSubview(mainContentView)
        
        // Sidebar
        let sidebarView = createSidebar()
        contentView.addSubview(sidebarView)
        
        // Footer
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
            
            heroView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            heroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            mainContentView.topAnchor.constraint(equalTo: heroView.bottomAnchor, constant: 20),
            mainContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainContentView.trailingAnchor.constraint(equalTo: sidebarView.leadingAnchor, constant: -20),
            
            sidebarView.topAnchor.constraint(equalTo: heroView.bottomAnchor, constant: 20),
            sidebarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sidebarView.widthAnchor.constraint(equalToConstant: 250),
            
            footerView.topAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoLabel = UILabel()
        logoLabel.text = "Company Logo"
        logoLabel.font = UIFont.boldSystemFont(ofSize: 24)
        logoLabel.textColor = .white
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(logoLabel)
        
        let navigationStackView = UIStackView()
        navigationStackView.axis = .horizontal
        navigationStackView.spacing = 20
        navigationStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(navigationStackView)
        
        let navItems = ["Home", "About", "Services", "Products", "Contact"]
        for item in navItems {
            let button = UIButton(type: .system)
            button.setTitle(item, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(navigationTapped(_:)), for: .touchUpInside)
            navigationStackView.addArrangedSubview(button)
        }
        
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("🔍", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            logoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            logoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            navigationStackView.leadingAnchor.constraint(equalTo: logoLabel.trailingAnchor, constant: 40),
            navigationStackView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return headerView
    }
    
    private func createHeroSection() -> UIView {
        let heroView = UIView()
        heroView.backgroundColor = .systemGray6
        heroView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Our Company"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "We provide innovative solutions for your business needs"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(subtitleLabel)
        
        let ctaButton = UIButton(type: .system)
        ctaButton.setTitle("Learn More", for: .normal)
        ctaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.backgroundColor = .systemBlue
        ctaButton.layer.cornerRadius = 25
        ctaButton.addTarget(self, action: #selector(learnMoreTapped), for: .touchUpInside)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(ctaButton)
        
        NSLayoutConstraint.activate([
            heroView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: heroView.centerYAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: heroView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: heroView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: heroView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: heroView.trailingAnchor, constant: -20),
            
            ctaButton.centerXAnchor.constraint(equalTo: heroView.centerXAnchor),
            ctaButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            ctaButton.widthAnchor.constraint(equalToConstant: 150),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return heroView
    }
    
    private func createMainContent() -> UIView {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Our Services"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "We offer a comprehensive range of services designed to help your business grow and succeed in today's competitive market."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        let servicesStackView = UIStackView()
        servicesStackView.axis = .vertical
        servicesStackView.spacing = 16
        servicesStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(servicesStackView)
        
        let services = [
            ("Consulting", "Strategic business consulting to help you make informed decisions"),
            ("Development", "Custom software development tailored to your specific needs"),
            ("Support", "24/7 technical support to keep your systems running smoothly"),
            ("Training", "Comprehensive training programs for your team")
        ]
        
        for (title, description) in services {
            let serviceView = createServiceItem(title: title, description: description)
            servicesStackView.addArrangedSubview(serviceView)
        }
        
        let newsTitleLabel = UILabel()
        newsTitleLabel.text = "Latest News"
        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsTitleLabel)
        
        let newsStackView = UIStackView()
        newsStackView.axis = .vertical
        newsStackView.spacing = 12
        newsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsStackView)
        
        let newsItems = [
            ("Company Expansion", "We're excited to announce our expansion into new markets..."),
            ("Product Launch", "Introducing our latest product that will revolutionize..."),
            ("Partnership", "We're proud to partner with industry leaders to...")
        ]
        
        for (title, excerpt) in newsItems {
            let newsView = createNewsItem(title: title, excerpt: excerpt)
            newsStackView.addArrangedSubview(newsView)
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 800),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            servicesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            servicesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            servicesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            newsTitleLabel.topAnchor.constraint(equalTo: servicesStackView.bottomAnchor, constant: 40),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            newsStackView.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 16),
            newsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
        
        return contentView
    }
    
    private func createServiceItem(title: String, description: String) -> UIView {
        let serviceView = UIView()
        serviceView.backgroundColor = .systemGray6
        serviceView.layer.cornerRadius = 12
        serviceView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceView.addSubview(descriptionLabel)
        
        let learnMoreButton = UIButton(type: .system)
        learnMoreButton.setTitle("Learn More", for: .normal)
        learnMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        learnMoreButton.setTitleColor(.systemBlue, for: .normal)
        learnMoreButton.addTarget(self, action: #selector(serviceLearnMoreTapped), for: .touchUpInside)
        learnMoreButton.translatesAutoresizingMaskIntoConstraints = false
        serviceView.addSubview(learnMoreButton)
        
        NSLayoutConstraint.activate([
            serviceView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: serviceView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: serviceView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: serviceView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: serviceView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: serviceView.trailingAnchor, constant: -16),
            
            learnMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            learnMoreButton.leadingAnchor.constraint(equalTo: serviceView.leadingAnchor, constant: 16),
            learnMoreButton.bottomAnchor.constraint(lessThanOrEqualTo: serviceView.bottomAnchor, constant: -16)
        ])
        
        return serviceView
    }
    
    private func createNewsItem(title: String, excerpt: String) -> UIView {
        let newsView = UIView()
        newsView.backgroundColor = .white
        newsView.layer.cornerRadius = 8
        newsView.layer.shadowColor = UIColor.black.cgColor
        newsView.layer.shadowOffset = CGSize(width: 0, height: 1)
        newsView.layer.shadowRadius = 2
        newsView.layer.shadowOpacity = 0.1
        newsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsView.addSubview(titleLabel)
        
        let excerptLabel = UILabel()
        excerptLabel.text = excerpt
        excerptLabel.font = UIFont.systemFont(ofSize: 14)
        excerptLabel.textColor = .secondaryLabel
        excerptLabel.numberOfLines = 0
        excerptLabel.translatesAutoresizingMaskIntoConstraints = false
        newsView.addSubview(excerptLabel)
        
        let readMoreButton = UIButton(type: .system)
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        readMoreButton.setTitleColor(.systemBlue, for: .normal)
        readMoreButton.addTarget(self, action: #selector(newsReadMoreTapped), for: .touchUpInside)
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        newsView.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            newsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: newsView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: newsView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: newsView.trailingAnchor, constant: -12),
            
            excerptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            excerptLabel.leadingAnchor.constraint(equalTo: newsView.leadingAnchor, constant: 12),
            excerptLabel.trailingAnchor.constraint(equalTo: newsView.trailingAnchor, constant: -12),
            
            readMoreButton.topAnchor.constraint(equalTo: excerptLabel.bottomAnchor, constant: 8),
            readMoreButton.leadingAnchor.constraint(equalTo: newsView.leadingAnchor, constant: 12),
            readMoreButton.bottomAnchor.constraint(lessThanOrEqualTo: newsView.bottomAnchor, constant: -12)
        ])
        
        return newsView
    }
    
    private func createSidebar() -> UIView {
        let sidebarView = UIView()
        sidebarView.backgroundColor = .systemGray6
        sidebarView.layer.cornerRadius = 12
        sidebarView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Quick Links"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sidebarView.addSubview(titleLabel)
        
        let linksStackView = UIStackView()
        linksStackView.axis = .vertical
        linksStackView.spacing = 12
        linksStackView.translatesAutoresizingMaskIntoConstraints = false
        sidebarView.addSubview(linksStackView)
        
        let links = [
            "Company Overview",
            "Our Team",
            "Careers",
            "Press Releases",
            "Investor Relations",
            "Privacy Policy",
            "Terms of Service",
            "Contact Information"
        ]
        
        for link in links {
            let linkButton = UIButton(type: .system)
            linkButton.setTitle(link, for: .normal)
            linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            linkButton.setTitleColor(.systemBlue, for: .normal)
            linkButton.contentHorizontalAlignment = .leading
            linkButton.addTarget(self, action: #selector(sidebarLinkTapped(_:)), for: .touchUpInside)
            linksStackView.addArrangedSubview(linkButton)
        }
        
        let contactTitleLabel = UILabel()
        contactTitleLabel.text = "Contact Us"
        contactTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contactTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        sidebarView.addSubview(contactTitleLabel)
        
        let contactInfoLabel = UILabel()
        contactInfoLabel.text = "Email: info@company.com\nPhone: (555) 123-4567\nAddress: 123 Business St, City, State 12345"
        contactInfoLabel.font = UIFont.systemFont(ofSize: 12)
        contactInfoLabel.textColor = .secondaryLabel
        contactInfoLabel.numberOfLines = 0
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        sidebarView.addSubview(contactInfoLabel)
        
        NSLayoutConstraint.activate([
            sidebarView.heightAnchor.constraint(greaterThanOrEqualToConstant: 600),
            
            titleLabel.topAnchor.constraint(equalTo: sidebarView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: sidebarView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: sidebarView.trailingAnchor, constant: -16),
            
            linksStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            linksStackView.leadingAnchor.constraint(equalTo: sidebarView.leadingAnchor, constant: 16),
            linksStackView.trailingAnchor.constraint(equalTo: sidebarView.trailingAnchor, constant: -16),
            
            contactTitleLabel.topAnchor.constraint(equalTo: linksStackView.bottomAnchor, constant: 30),
            contactTitleLabel.leadingAnchor.constraint(equalTo: sidebarView.leadingAnchor, constant: 16),
            contactTitleLabel.trailingAnchor.constraint(equalTo: sidebarView.trailingAnchor, constant: -16),
            
            contactInfoLabel.topAnchor.constraint(equalTo: contactTitleLabel.bottomAnchor, constant: 8),
            contactInfoLabel.leadingAnchor.constraint(equalTo: sidebarView.leadingAnchor, constant: 16),
            contactInfoLabel.trailingAnchor.constraint(equalTo: sidebarView.trailingAnchor, constant: -16),
            contactInfoLabel.bottomAnchor.constraint(lessThanOrEqualTo: sidebarView.bottomAnchor, constant: -20)
        ])
        
        return sidebarView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemGray5
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(stackView)
        
        let sections = [
            ("Company", ["About", "Team", "Careers", "News"]),
            ("Services", ["Consulting", "Development", "Support", "Training"]),
            ("Resources", ["Documentation", "Blog", "FAQ", "Help Center"]),
            ("Legal", ["Privacy", "Terms", "Cookies", "Accessibility"])
        ]
        
        for (title, links) in sections {
            let sectionView = createFooterSection(title: title, links: links)
            stackView.addArrangedSubview(sectionView)
        }
        
        let copyrightLabel = UILabel()
        copyrightLabel.text = "© 2024 Company Name. All rights reserved."
        copyrightLabel.font = UIFont.systemFont(ofSize: 14)
        copyrightLabel.textColor = .secondaryLabel
        copyrightLabel.textAlignment = .center
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(copyrightLabel)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            copyrightLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            copyrightLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            copyrightLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            copyrightLabel.bottomAnchor.constraint(lessThanOrEqualTo: footerView.bottomAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    private func createFooterSection(title: String, links: [String]) -> UIView {
        let sectionView = UIView()
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(stackView)
        
        for link in links {
            let linkButton = UIButton(type: .system)
            linkButton.setTitle(link, for: .normal)
            linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            linkButton.setTitleColor(.systemBlue, for: .normal)
            linkButton.contentHorizontalAlignment = .leading
            linkButton.addTarget(self, action: #selector(footerLinkTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(linkButton)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sectionView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor)
        ])
        
        return sectionView
    }
    
    // MARK: - Actions
    @objc private func navigationTapped(_ sender: UIButton) {
        let title = sender.title(for: .normal) ?? ""
        let alert = UIAlertController(title: title, message: "Navigating to \(title) page...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func searchTapped() {
        let alert = UIAlertController(title: "Search", message: "Opening search functionality...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func learnMoreTapped() {
        let alert = UIAlertController(title: "Learn More", message: "Discover more about our company and services...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func serviceLearnMoreTapped() {
        let alert = UIAlertController(title: "Service Details", message: "Learn more about this service...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func newsReadMoreTapped() {
        let alert = UIAlertController(title: "News Article", message: "Read the full article...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func sidebarLinkTapped(_ sender: UIButton) {
        let title = sender.title(for: .normal) ?? ""
        let alert = UIAlertController(title: title, message: "Opening \(title)...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func footerLinkTapped(_ sender: UIButton) {
        let title = sender.title(for: .normal) ?? ""
        let alert = UIAlertController(title: title, message: "Opening \(title)...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
