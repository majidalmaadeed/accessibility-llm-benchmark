import UIKit

class InaccessibleTooltipViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var tooltipView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Help Center"
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Header
        let headerView = createHeaderView()
        contentView.addSubview(headerView)
        
        // Help sections
        let generalHelpView = createGeneralHelpView()
        contentView.addSubview(generalHelpView)
        
        let advancedHelpView = createAdvancedHelpView()
        contentView.addSubview(advancedHelpView)
        
        let troubleshootingView = createTroubleshootingView()
        contentView.addSubview(troubleshootingView)
        
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
            
            generalHelpView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            generalHelpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            generalHelpView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            advancedHelpView.topAnchor.constraint(equalTo: generalHelpView.bottomAnchor, constant: 20),
            advancedHelpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advancedHelpView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            troubleshootingView.topAnchor.constraint(equalTo: advancedHelpView.bottomAnchor, constant: 20),
            troubleshootingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            troubleshootingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: troubleshootingView.bottomAnchor, constant: 20),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Help Center"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Get help and support for your questions"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -20)
        ])
        
        return headerView
    }
    
    private func createGeneralHelpView() -> UIView {
        let helpView = UIView()
        helpView.backgroundColor = .systemBackground
        helpView.layer.cornerRadius = 12
        helpView.layer.shadowColor = UIColor.black.cgColor
        helpView.layer.shadowOffset = CGSize(width: 0, height: 2)
        helpView.layer.shadowRadius = 4
        helpView.layer.shadowOpacity = 0.1
        helpView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "General Help"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(stackView)
        
        let gettingStartedItem = createHelpItem(
            title: "Getting Started",
            description: "Learn the basics of using our application",
            hasTooltip: true,
            tooltipText: "This guide will walk you through the essential features and help you get up and running quickly."
        )
        stackView.addArrangedSubview(gettingStartedItem)
        
        let userGuideItem = createHelpItem(
            title: "User Guide",
            description: "Comprehensive guide to all features",
            hasTooltip: true,
            tooltipText: "Detailed documentation covering every aspect of the application with step-by-step instructions."
        )
        stackView.addArrangedSubview(userGuideItem)
        
        let faqItem = createHelpItem(
            title: "Frequently Asked Questions",
            description: "Common questions and answers",
            hasTooltip: true,
            tooltipText: "Find quick answers to the most commonly asked questions about our service."
        )
        stackView.addArrangedSubview(faqItem)
        
        NSLayoutConstraint.activate([
            helpView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: helpView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -20)
        ])
        
        return helpView
    }
    
    private func createAdvancedHelpView() -> UIView {
        let helpView = UIView()
        helpView.backgroundColor = .systemBackground
        helpView.layer.cornerRadius = 12
        helpView.layer.shadowColor = UIColor.black.cgColor
        helpView.layer.shadowOffset = CGSize(width: 0, height: 2)
        helpView.layer.shadowRadius = 4
        helpView.layer.shadowOpacity = 0.1
        helpView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Advanced Features"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(stackView)
        
        let apiItem = createHelpItem(
            title: "API Documentation",
            description: "Developer resources and API reference",
            hasTooltip: true,
            tooltipText: "Complete API documentation with examples, endpoints, and integration guides for developers."
        )
        stackView.addArrangedSubview(apiItem)
        
        let customizationItem = createHelpItem(
            title: "Customization Options",
            description: "Advanced settings and preferences",
            hasTooltip: true,
            tooltipText: "Learn how to customize the application to fit your specific needs and workflow."
        )
        stackView.addArrangedSubview(customizationItem)
        
        let integrationItem = createHelpItem(
            title: "Third-Party Integrations",
            description: "Connect with external services",
            hasTooltip: true,
            tooltipText: "Set up integrations with popular third-party services to extend functionality."
        )
        stackView.addArrangedSubview(integrationItem)
        
        NSLayoutConstraint.activate([
            helpView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: helpView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -20)
        ])
        
        return helpView
    }
    
    private func createTroubleshootingView() -> UIView {
        let helpView = UIView()
        helpView.backgroundColor = .systemBackground
        helpView.layer.cornerRadius = 12
        helpView.layer.shadowColor = UIColor.black.cgColor
        helpView.layer.shadowOffset = CGSize(width: 0, height: 2)
        helpView.layer.shadowRadius = 4
        helpView.layer.shadowOpacity = 0.1
        helpView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Troubleshooting"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        helpView.addSubview(stackView)
        
        let commonIssuesItem = createHelpItem(
            title: "Common Issues",
            description: "Solutions to frequent problems",
            hasTooltip: true,
            tooltipText: "Quick fixes for the most common issues users encounter, with step-by-step solutions."
        )
        stackView.addArrangedSubview(commonIssuesItem)
        
        let contactSupportItem = createHelpItem(
            title: "Contact Support",
            description: "Get help from our support team",
            hasTooltip: true,
            tooltipText: "Reach out to our support team for personalized assistance with any issues you're experiencing."
        )
        stackView.addArrangedSubview(contactSupportItem)
        
        let systemRequirementsItem = createHelpItem(
            title: "System Requirements",
            description: "Check compatibility and requirements",
            hasTooltip: true,
            tooltipText: "Verify that your system meets the minimum requirements for optimal performance."
        )
        stackView.addArrangedSubview(systemRequirementsItem)
        
        NSLayoutConstraint.activate([
            helpView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: helpView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -20)
        ])
        
        return helpView
    }
    
    private func createHelpItem(title: String, description: String, hasTooltip: Bool, tooltipText: String) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(descriptionLabel)
        
        let actionButton = UIButton(type: .system)
        actionButton.setTitle("View", for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        actionButton.setTitleColor(.systemBlue, for: .normal)
        actionButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        actionButton.layer.cornerRadius = 6
        actionButton.addTarget(self, action: #selector(helpItemTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(actionButton)
        
        > UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemGray6
        footerView.layer.cornerRadius = 12
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Still Need Help?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Our support team is here to help you 24/7"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(descriptionLabel)
        
        let contactButton = UIButton(type: .system)
        contactButton.setTitle("Contact Support", for: .normal)
        contactButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.backgroundColor = .systemBlue
        contactButton.layer.cornerRadius = 25
        contactButton.addTarget(self, action: #selector(contactSupportTapped), for: .touchUpInside)
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            contactButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            contactButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: 160),
            contactButton.heightAnchor.constraint(equalToConstant: 50),
            contactButton.bottomAnchor.constraint(lessThanOrEqualTo: footerView.bottomAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    