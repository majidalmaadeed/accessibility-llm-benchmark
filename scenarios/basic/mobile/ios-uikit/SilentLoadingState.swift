import UIKit

class SilentLoadingStateViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var isLoading = false
    private var loadingTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        loadingTimer?.invalidate()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Data Dashboard"
        
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
        
        // Data sections
        let statsView = createStatsView()
        contentView.addSubview(statsView)
        
        let chartsView = createChartsView()
        contentView.addSubview(chartsView)
        
        let recentActivityView = createRecentActivityView()
        contentView.addSubview(recentActivityView)
        
        // Refresh button
        let refreshView = createRefreshView()
        contentView.addSubview(refreshView)
        
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
            
            statsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            statsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            chartsView.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 20),
            chartsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            recentActivityView.topAnchor.constraint(equalTo: chartsView.bottomAnchor, constant: 20),
            recentActivityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recentActivityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            refreshView.topAnchor.constraint(equalTo: recentActivityView.bottomAnchor, constant: 20),
            refreshView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            refreshView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            refreshView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Dashboard"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Real-time data and analytics"
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
    
    private func createStatsView() -> UIView {
        let statsView = UIView()
        statsView.backgroundColor = .systemBackground
        statsView.layer.cornerRadius = 12
        statsView.layer.shadowColor = UIColor.black.cgColor
        statsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        statsView.layer.shadowRadius = 4
        statsView.layer.shadowOpacity = 0.1
        statsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Key Metrics"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        statsView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        statsView.addSubview(stackView)
        
        let totalUsersCard = createStatCard(title: "Total Users", value: "1,234", trend: "+12%")
        let revenueCard = createStatCard(title: "Revenue", value: "$45,678", trend: "+8%")
        let ordersCard = createStatCard(title: "Orders", value: "567", trend: "+15%")
        
        stackView.addArrangedSubview(totalUsersCard)
        stackView.addArrangedSubview(revenueCard)
        stackView.addArrangedSubview(ordersCard)
        
        NSLayoutConstraint.activate([
            statsView.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.topAnchor.constraint(equalTo: statsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: statsView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: statsView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: statsView.bottomAnchor, constant: -20)
        ])
        
        return statsView
    }
    
    private func createStatCard(title: String, value: String, trend: String) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .systemGray6
        cardView.layer.cornerRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(valueLabel)
        
        let trendLabel = UILabel()
        trendLabel.text = trend
        trendLabel.font = UIFont.systemFont(ofSize: 12)
        trendLabel.textColor = .systemGreen
        trendLabel.textAlignment = .center
        trendLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(trendLabel)
        
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            
            trendLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            trendLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            trendLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            trendLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -8)
        ])
        
        return cardView
    }
    
    private func createChartsView() -> UIView {
        let chartsView = UIView()
        chartsView.backgroundColor = .systemBackground
        chartsView.layer.cornerRadius = 12
        chartsView.layer.shadowColor = UIColor.black.cgColor
        chartsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        chartsView.layer.shadowRadius = 4
        chartsView.layer.shadowOpacity = 0.1
        chartsView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Analytics Charts"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        chartsView.addSubview(titleLabel)
        
        // Silent loading spinner without screen reader announcement
        let loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner.color = .systemBlue
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        chartsView.addSubview(loadingSpinner)
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading chart data..."
        loadingLabel.font = UIFont.systemFont(ofSize: 16)
        loadingLabel.textColor = .secondaryLabel
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        chartsView.addSubview(loadingLabel)
        
        // Chart placeholder
        let chartPlaceholder = UIView()
        chartPlaceholder.backgroundColor = .systemGray6
        chartPlaceholder.layer.cornerRadius = 8
        chartPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        chartsView.addSubview(chartPlaceholder)
        
        let chartTitle = UILabel()
        chartTitle.text = "Sales Over Time"
        chartTitle.font = UIFont.boldSystemFont(ofSize: 16)
        chartTitle.textAlignment = .center
        chartTitle.translatesAutoresizingMaskIntoConstraints = false
        chartPlaceholder.addSubview(chartTitle)
        
        let chartSubtitle = UILabel()
        chartSubtitle.text = "Monthly revenue trends"
        chartSubtitle.font = UIFont.systemFont(ofSize: 14)
        chartSubtitle.textColor = .secondaryLabel
        chartSubtitle.textAlignment = .center
        chartSubtitle.translatesAutoresizingMaskIntoConstraints = false
        chartPlaceholder.addSubview(chartSubtitle)
        
        NSLayoutConstraint.activate([
            chartsView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: chartsView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: chartsView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: chartsView.trailingAnchor, constant: -20),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: chartsView.centerYAnchor, constant: -10),
            
            loadingLabel.centerXAnchor.constraint(equalTo: chartsView.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: loadingSpinner.bottomAnchor, constant: 8),
            loadingLabel.leadingAnchor.constraint(greaterThanOrEqualTo: chartsView.leadingAnchor, constant: 20),
            loadingLabel.trailingAnchor.constraint(lessThanOrEqualTo: chartsView.trailingAnchor, constant: -20),
            
            chartPlaceholder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            chartPlaceholder.leadingAnchor.constraint(equalTo: chartsView.leadingAnchor, constant: 20),
            chartPlaceholder.trailingAnchor.constraint(equalTo: chartsView.trailingAnchor, constant: -20),
            chartPlaceholder.bottomAnchor.constraint(equalTo: chartsView.bottomAnchor, constant: -20),
            
            chartTitle.centerXAnchor.constraint(equalTo: chartPlaceholder.centerXAnchor),
            chartTitle.centerYAnchor.constraint(equalTo: chartPlaceholder.centerYAnchor, constant: -10),
            chartTitle.leadingAnchor.constraint(greaterThanOrEqualTo: chartPlaceholder.leadingAnchor, constant: 16),
            chartTitle.trailingAnchor.constraint(lessThanOrEqualTo: chartPlaceholder.trailingAnchor, constant: -16),
            
            chartSubtitle.centerXAnchor.constraint(equalTo: chartPlaceholder.centerXAnchor),
            chartSubtitle.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: 4),
            chartSubtitle.leadingAnchor.constraint(greaterThanOrEqualTo: chartPlaceholder.leadingAnchor, constant: 16),
            chartSubtitle.trailingAnchor.constraint(lessThanOrEqualTo: chartPlaceholder.trailingAnchor, constant: -16)
        ])
        
        // Start loading animation
        loadingSpinner.startAnimating()
        
        // Simulate loading completion after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
            loadingLabel.isHidden = true
        }
        
        return chartsView
    }
    
    private func createRecentActivityView() -> UIView {
        let activityView = UIView()
        activityView.backgroundColor = .systemBackground
        activityView.layer.cornerRadius = 12
        activityView.layer.shadowColor = UIColor.black.cgColor
        activityView.layer.shadowOffset = CGSize(width: 0, height: 2)
        activityView.layer.shadowRadius = 4
        activityView.layer.shadowOpacity = 0.1
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Recent Activity"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        activityView.addSubview(titleLabel)
        
        // Silent loading state for activity list
        let loadingContainer = UIView()
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        activityView.addSubview(loadingContainer)
        
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.color = .systemBlue
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(activitySpinner)
        
        let activityLabel = UILabel()
        activityLabel.text = "Loading recent activity..."
        activityLabel.font = UIFont.systemFont(ofSize: 14)
        activityLabel.textColor = .secondaryLabel
        activityLabel.textAlignment = .center
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(activityLabel)
        
        // Activity list placeholder
        let activityList = UIView()
        activityList.backgroundColor = .systemGray6
        activityList.layer.cornerRadius = 8
        activityList.translatesAutoresizingMaskIntoConstraints = false
        activityView.addSubview(activityList)
        
        let listTitle = UILabel()
        listTitle.text = "Activity Feed"
        listTitle.font = UIFont.boldSystemFont(ofSize: 16)
        listTitle.textAlignment = .center
        listTitle.translatesAutoresizingMaskIntoConstraints = false
        activityList.addSubview(listTitle)
        
        let listSubtitle = UILabel()
        listSubtitle.text = "User actions and system events"
        listSubtitle.font = UIFont.systemFont(ofSize: 14)
        listSubtitle.textColor = .secondaryLabel
        listSubtitle.textAlignment = .center
        listSubtitle.translatesAutoresizingMaskIntoConstraints = false
        activityList.addSubview(listSubtitle)
        
        NSLayoutConstraint.activate([
            activityView.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: activityView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -20),
            
            loadingContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            loadingContainer.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            loadingContainer.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -20),
            loadingContainer.heightAnchor.constraint(equalToConstant: 40),
            
            activitySpinner.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor),
            activitySpinner.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor, constant: -8),
            
            activityLabel.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor),
            activityLabel.topAnchor.constraint(equalTo: activitySpinner.bottomAnchor, constant: 4),
            activityLabel.leadingAnchor.constraint(greaterThanOrEqualTo: loadingContainer.leadingAnchor, constant: 8),
            activityLabel.trailingAnchor.constraint(lessThanOrEqualTo: loadingContainer.trailingAnchor, constant: -8),
            
            activityList.topAnchor.constraint(equalTo: loadingContainer.bottomAnchor, constant: 16),
            activityList.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            activityList.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -20),
            activityList.bottomAnchor.constraint(equalTo: activityView.bottomAnchor, constant: -20),
            
            listTitle.centerXAnchor.constraint(equalTo: activityList.centerXAnchor),
            listTitle.centerYAnchor.constraint(equalTo: activityList.centerYAnchor, constant: -8),
            listTitle.leadingAnchor.constraint(greaterThanOrEqualTo: activityList.leadingAnchor, constant: 16),
            listTitle.trailingAnchor.constraint(lessThanOrEqualTo: activityList.trailingAnchor, constant: -16),
            
            listSubtitle.centerXAnchor.constraint(equalTo: activityList.centerXAnchor),
            listSubtitle.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 4),
            listSubtitle.leadingAnchor.constraint(greaterThanOrEqualTo: activityList.leadingAnchor, constant: 16),
            listSubtitle.trailingAnchor.constraint(lessThanOrEqualTo: activityList.trailingAnchor, constant: -16)
        ])
        
        // Start loading animation
        activitySpinner.startAnimating()
        
        // Simulate loading completion after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            activitySpinner.stopAnimating()
            activitySpinner.isHidden = true
            activityLabel.isHidden = true
        }
        
        return activityView
    }
    
    private func createRefreshView() -> UIView {
        let refreshView = UIView()
        refreshView.backgroundColor = .systemBackground
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setTitle("Refresh Data", for: .normal)
        refreshButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.backgroundColor = .systemBlue
        refreshButton.layer.cornerRadius = 25
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshView.addSubview(refreshButton)
        
        let lastUpdatedLabel = UILabel()
        lastUpdatedLabel.text = "Last updated: Just now"
        lastUpdatedLabel.font = UIFont.systemFont(ofSize: 14)
        lastUpdatedLabel.textColor = .secondaryLabel
        lastUpdatedLabel.textAlignment = .center
        lastUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshView.addSubview(lastUpdatedLabel)
        
        NSLayoutConstraint.activate([
            refreshView.heightAnchor.constraint(equalToConstant: 100),
            
            refreshButton.centerXAnchor.constraint(equalTo: refreshView.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: refreshView.topAnchor, constant: 20),
            refreshButton.widthAnchor.constraint(equalToConstant: 150),
            refreshButton.heightAnchor.constraint(equalToConstant: 50),
            
            lastUpdatedLabel.centerXAnchor.constraint(equalTo: refreshView.centerXAnchor),
            lastUpdatedLabel.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 8),
            lastUpdatedLabel.leadingAnchor.constraint(greaterThanOrEqualTo: refreshView.leadingAnchor, constant: 20),
            lastUpdatedLabel.trailingAnchor.constraint(lessThanOrEqualTo: refreshView.trailingAnchor, constant: -20),
            lastUpdatedLabel.bottomAnchor.constraint(lessThanOrEqualTo: refreshView.bottomAnchor, constant: -20)
        ])
        
        return refreshView
    }
    
    // MARK: - Actions
    @objc private func refreshTapped() {
        // Simulate refresh with silent loading
        isLoading = true
        
        // Show loading state without screen reader announcement
        let loadingView = UIView()
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        spinner.startAnimating()
        
        // Simulate refresh completion after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            spinner.stopAnimating()
            loadingView.removeFromSuperview()
            self.isLoading = false
            
            let alert = UIAlertController(title: "Refresh Complete", message: "Data has been updated successfully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
