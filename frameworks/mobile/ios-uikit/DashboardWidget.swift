import UIKit

class DashboardWidgetViewController: UIViewController {
    
    // MARK: - Properties
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var headerView: UIView!
    private var controlsView: UIView!
    private var metricsContainerView: UIView!
    private var chartContainerView: UIView!
    private var statsContainerView: UIView!
    
    private var selectedTimeRange: TimeRange = .week
    private var selectedMetric: Metric = .revenue
    private var selectedChartType: ChartType = .line
    private var showFilters: Bool = false
    private var isLoading: Bool = false
    
    let timeRanges: [TimeRange] = [.day, .week, .month, .quarter, .year]
    let metrics: [Metric] = [.revenue, .users, .orders, .conversion]
    let chartTypes: [ChartType] = [.line, .bar, .area, .pie]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Analytics Dashboard"
        
        setupScrollView()
        setupHeaderView()
        setupControlsView()
        setupMetricsContainer()
        setupChartContainer()
        setupStatsContainer()
        setupConstraints()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    private func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = .systemGray6
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Analytics Dashboard"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Real-time insights and analytics"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Filters", for: .normal)
        filterButton.addTarget(self, action: #selector(toggleFilters), for: .touchUpInside)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        let exportButton = UIButton(type: .system)
        exportButton.setTitle("Export", for: .normal)
        exportButton.backgroundColor = .systemBlue
        exportButton.setTitleColor(.white, for: .normal)
        exportButton.layer.cornerRadius = 8
        exportButton.addTarget(self, action: #selector(exportData), for: .touchUpInside)
        exportButton.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, subtitleLabel, filterButton, exportButton].forEach {
            headerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            filterButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: exportButton.leadingAnchor, constant: -12),
            filterButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 80),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            
            exportButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            exportButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            exportButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            exportButton.widthAnchor.constraint(equalToConstant: 80),
            exportButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func setupControlsView() {
        controlsView = UIView()
        controlsView.backgroundColor = .systemGray6
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(controlsView)
        
        let timeRangeLabel = UILabel()
        timeRangeLabel.text = "Time Range"
        timeRangeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        timeRangeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let timeRangeSegmentedControl = UISegmentedControl(items: timeRanges.map { $0.displayName })
        timeRangeSegmentedControl.selectedSegmentIndex = timeRanges.firstIndex(of: selectedTimeRange) ?? 0
        timeRangeSegmentedControl.addTarget(self, action: #selector(timeRangeChanged(_:)), for: .valueChanged)
        timeRangeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let metricLabel = UILabel()
        metricLabel.text = "Metric"
        metricLabel.font = UIFont.boldSystemFont(ofSize: 16)
        metricLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let metricPicker = UIPickerView()
        metricPicker.delegate = self
        metricPicker.dataSource = self
        metricPicker.translatesAutoresizingMaskIntoConstraints = false
        
        [timeRangeLabel, timeRangeSegmentedControl, metricLabel, metricPicker].forEach {
            controlsView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timeRangeLabel.topAnchor.constraint(equalTo: controlsView.topAnchor, constant: 16),
            timeRangeLabel.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            timeRangeLabel.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            
            timeRangeSegmentedControl.topAnchor.constraint(equalTo: timeRangeLabel.bottomAnchor, constant: 8),
            timeRangeSegmentedControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            timeRangeSegmentedControl.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            
            metricLabel.topAnchor.constraint(equalTo: timeRangeSegmentedControl.bottomAnchor, constant: 16),
            metricLabel.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            metricLabel.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            
            metricPicker.topAnchor.constraint(equalTo: metricLabel.bottomAnchor, constant: 8),
            metricPicker.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            metricPicker.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            metricPicker.heightAnchor.constraint(equalToConstant: 100),
            metricPicker.bottomAnchor.constraint(equalTo: controlsView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupMetricsContainer() {
        metricsContainerView = UIView()
        metricsContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(metricsContainerView)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let metrics = [
            MetricData(title: "Total Revenue", value: 125000, change: 12.5, changeType: .positive, icon: "dollarsign.circle"),
            MetricData(title: "Active Users", value: 15420, change: 8.2, changeType: .positive, icon: "person.2"),
            MetricData(title: "Orders", value: 3420, change: -2.1, changeType: .negative, icon: "cart"),
            MetricData(title: "Conversion Rate", value: 3.2, change: 0.8, changeType: .positive, icon: "percent")
        ]
        
        for metric in metrics {
            let metricView = createMetricCard(metric: metric)
            stackView.addArrangedSubview(metricView)
        }
        
        metricsContainerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: metricsContainerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: metricsContainerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: metricsContainerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: metricsContainerView.bottomAnchor)
        ])
    }
    
    private func setupChartContainer() {
        chartContainerView = UIView()
        chartContainerView.backgroundColor = .systemBackground
        chartContainerView.layer.cornerRadius = 12
        chartContainerView.layer.shadowColor = UIColor.black.cgColor
        chartContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        chartContainerView.layer.shadowRadius = 4
        chartContainerView.layer.shadowOpacity = 0.1
        chartContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chartContainerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "\(selectedMetric.displayName) Trend"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let chartView = UIView()
        chartView.backgroundColor = .systemGray6
        chartView.layer.cornerRadius = 8
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        let chartLabel = UILabel()
        chartLabel.text = "Interactive Chart View"
        chartLabel.font = UIFont.systemFont(ofSize: 16)
        chartLabel.textColor = .secondaryLabel
        chartLabel.textAlignment = .center
        chartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, chartView, chartLabel].forEach {
            chartContainerView.addSubview($0)
        }
        
        chartView.addSubview(chartLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: chartContainerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor, constant: -16),
            
            chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            chartView.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor, constant: 16),
            chartView.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor, constant: -16),
            chartView.heightAnchor.constraint(equalToConstant: 200),
            
            chartLabel.centerXAnchor.constraint(equalTo: chartView.centerXAnchor),
            chartLabel.centerYAnchor.constraint(equalTo: chartView.centerYAnchor),
            
            chartContainerView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupStatsContainer() {
        statsContainerView = UIView()
        statsContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsContainerView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Detailed Statistics"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stats = [
            StatData(title: "Average Order Value", value: "$36.50", subtitle: "Up 5.2% from last period"),
            StatData(title: "Bounce Rate", value: "42.3%", subtitle: "Down 2.1% from last period"),
            StatData(title: "Session Duration", value: "4m 32s", subtitle: "Up 12.5% from last period"),
            StatData(title: "Page Views", value: "89,420", subtitle: "Up 8.7% from last period")
        ]
        
        for stat in stats {
            let statView = createStatRow(stat: stat)
            stackView.addArrangedSubview(statView)
        }
        
        [titleLabel, stackView].forEach {
            statsContainerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: statsContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: statsContainerView.bottomAnchor)
        ])
    }
    
    private func setupConstraints() {
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
            
            controlsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            controlsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            controlsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            metricsContainerView.topAnchor.constraint(equalTo: controlsView.bottomAnchor, constant: 16),
            metricsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            metricsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            metricsContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            chartContainerView.topAnchor.constraint(equalTo: metricsContainerView.bottomAnchor, constant: 16),
            chartContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chartContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statsContainerView.topAnchor.constraint(equalTo: chartContainerView.bottomAnchor, constant: 16),
            statsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Helper Methods
    
    private func createMetricCard(metric: MetricData) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 0.1
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = metric.icon
        iconLabel.font = UIFont.systemFont(ofSize: 24)
        iconLabel.textColor = .systemBlue
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = metric.title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .secondaryLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = formatMetricValue(metric.value)
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let changeLabel = UILabel()
        let changeText = metric.changeType == .positive ? "+" : ""
        changeLabel.text = "\(changeText)\(String(format: "%.1f", metric.change))%"
        changeLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        changeLabel.textColor = metric.changeType == .positive ? .systemGreen : .systemRed
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [iconLabel, titleLabel, valueLabel, changeLabel].forEach {
            cardView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            iconLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: iconLabel.leadingAnchor, constant: -8),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: iconLabel.leadingAnchor, constant: -8),
            
            changeLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            changeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            changeLabel.trailingAnchor.constraint(lessThanOrEqualTo: iconLabel.leadingAnchor, constant: -8),
            changeLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12)
        ])
        
        return cardView
    }
    
    private func createStatRow(stat: StatData) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = .systemBackground
        rowView.layer.cornerRadius = 8
        rowView.layer.shadowColor = UIColor.black.cgColor
        rowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        rowView.layer.shadowRadius = 2
        rowView.layer.shadowOpacity = 0.05
        rowView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = stat.title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = stat.subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = stat.value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, subtitleLabel, valueLabel].forEach {
            rowView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: rowView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: rowView.bottomAnchor, constant: -12),
            
            valueLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: rowView.trailingAnchor, constant: -12)
        ])
        
        return rowView
    }
    
    private func formatMetricValue(_ value: Double) -> String {
        if value >= 1000000 {
            return String(format: "%.1fM", value / 1000000)
        } else if value >= 1000 {
            return String(format: "%.1fK", value / 1000)
        } else {
            return String(format: "%.1f", value)
        }
    }
    
    // MARK: - Data Management
    
    private func loadData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
        }
    }
    
    // MARK: - Actions
    
    @objc private func toggleFilters() {
        showFilters.toggle()
        // Show/hide filter view
    }
    
    @objc private func exportData() {
        print("Exporting data")
    }
    
    @objc private func timeRangeChanged(_ sender: UISegmentedControl) {
        selectedTimeRange = timeRanges[sender.selectedSegmentIndex]
        loadData()
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension DashboardWidgetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return metrics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return metrics[row].displayName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMetric = metrics[row]
        loadData()
    }
}

// MARK: - Supporting Types

enum TimeRange: CaseIterable {
    case day, week, month, quarter, year
    
    var displayName: String {
        switch self {
        case .day: return "Day"
        case .week: return "Week"
        case .month: return "Month"
        case .quarter: return "Quarter"
        case .year: return "Year"
        }
    }
}

enum Metric: CaseIterable {
    case revenue, users, orders, conversion
    
    var displayName: String {
        switch self {
        case .revenue: return "Revenue"
        case .users: return "Users"
        case .orders: return "Orders"
        case .conversion: return "Conversion Rate"
        }
    }
}

enum ChartType: CaseIterable {
    case line, bar, area, pie
    
    var displayName: String {
        switch self {
        case .line: return "Line"
        case .bar: return "Bar"
        case .area: return "Area"
        case .pie: return "Pie"
        }
    }
}

struct MetricData {
    let title: String
    let value: Double
    let change: Double
    let changeType: ChangeType
    let icon: String
}

struct StatData {
    let title: String
    let value: String
    let subtitle: String
}

enum ChangeType {
    case positive, negative
}
