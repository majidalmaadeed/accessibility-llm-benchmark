import Cocoa

class SilentLoadingState: NSViewController {
    
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var exportButton: NSButton!
    @IBOutlet weak var generateReportButton: NSButton!
    @IBOutlet weak var loadingView: NSView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var loadingLabel: NSTextField!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    @IBOutlet weak var progressLabel: NSTextField!
    
    @IBOutlet weak var dataSummaryStackView: NSStackView!
    @IBOutlet weak var recentActivityStackView: NSStackView!
    @IBOutlet weak var dataTableView: NSTableView!
    
    private var isLoading = false
    private var loadingProgress = 0.0
    private var progressTimer: Timer?
    
    private var dataRecords: [DataRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Action Buttons
        refreshButton.title = "Refresh Data"
        refreshButton.font = NSFont.boldSystemFont(ofSize: 16)
        refreshButton.bezelStyle = .rounded
        refreshButton.target = self
        refreshButton.action = #selector(refreshTapped)
        
        exportButton.title = "Export Data"
        exportButton.font = NSFont.boldSystemFont(ofSize: 16)
        exportButton.bezelStyle = .rounded
        exportButton.target = self
        exportButton.action = #selector(exportTapped)
        
        generateReportButton.title = "Generate Report"
        generateReportButton.font = NSFont.boldSystemFont(ofSize: 16)
        generateReportButton.bezelStyle = .rounded
        generateReportButton.target = self
        generateReportButton.action = #selector(generateReportTapped)
        
        // Loading View - SILENT LOADING STATE
        loadingView.wantsLayer = true
        loadingView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        loadingView.layer?.cornerRadius = 8
        loadingView.layer?.shadowOpacity = 0.2
        loadingView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        loadingView.layer?.shadowRadius = 4
        loadingView.isHidden = true
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        progressIndicator.style = .spinning
        progressIndicator.controlSize = .large
        progressIndicator.startAnimation(nil)
        
        loadingLabel.stringValue = "Loading..."
        loadingLabel.font = NSFont.boldSystemFont(ofSize: 18)
        loadingLabel.textColor = .secondaryLabelColor
        loadingLabel.alignment = .center
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        progressBar.style = .bar
        progressBar.minValue = 0
        progressBar.maxValue = 100
        progressBar.doubleValue = 0
        
        progressLabel.stringValue = "0%"
        progressLabel.font = NSFont.systemFont(ofSize: 12)
        progressLabel.textColor = .secondaryLabelColor
        progressLabel.alignment = .center
        
        // Data Summary
        setupDataSummary()
        
        // Recent Activity
        setupRecentActivity()
        
        // Data Table View
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.target = self
        dataTableView.doubleAction = #selector(recordDoubleClicked)
    }
    
    private func setupDataSummary() {
        let summaryItems = [
            ("📊", "Total Records", "1,234", NSColor.systemBlue),
            ("✅", "Completed", "987", NSColor.systemGreen),
            ("⏳", "Pending", "247", NSColor.systemOrange)
        ]
        
        for (icon, title, value, color) in summaryItems {
            let summaryView = createSummaryView(icon: icon, title: title, value: value, color: color)
            dataSummaryStackView.addArrangedSubview(summaryView)
        }
    }
    
    private func setupRecentActivity() {
        let activities = [
            ("🟢", "Data refreshed", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("📤", "Data exported", "1 hour ago")
        ]
        
        for (icon, title, time) in activities {
            let activityView = createActivityView(icon: icon, title: title, time: time)
            recentActivityStackView.addArrangedSubview(activityView)
        }
    }
    
    private func createSummaryView(icon: String, title: String, value: String, color: NSColor) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.shadowOpacity = 0.2
        containerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        containerView.layer?.shadowRadius = 4
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 32)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 16)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let valueLabel = NSTextField()
        valueLabel.stringValue = value
        valueLabel.font = NSFont.boldSystemFont(ofSize: 24)
        valueLabel.textColor = color
        valueLabel.isEditable = false
        valueLabel.isBordered = false
        valueLabel.backgroundColor = .clear
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            iconLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 8),
            
            valueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func createActivityView(icon: String, title: String, time: String) -> NSView {
        let containerView = NSView()
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 16)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 14)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let timeLabel = NSTextField()
        timeLabel.stringValue = time
        timeLabel.font = NSFont.systemFont(ofSize: 12)
        timeLabel.textColor = .secondaryLabelColor
        timeLabel.isEditable = false
        timeLabel.isBordered = false
        timeLabel.backgroundColor = .clear
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            iconLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor)
        ])
        
        return containerView
    }
    
    private func loadData() {
        dataRecords = [
            DataRecord(id: 1, name: "Record 1", status: "Active", date: "2024-01-01"),
            DataRecord(id: 2, name: "Record 2", status: "Pending", date: "2024-01-02"),
            DataRecord(id: 3, name: "Record 3", status: "Active", date: "2024-01-03"),
            DataRecord(id: 4, name: "Record 4", status: "Pending", date: "2024-01-04"),
            DataRecord(id: 5, name: "Record 5", status: "Active", date: "2024-01-05")
        ]
        dataTableView.reloadData()
    }
    
    private func startLoading() {
        isLoading = true
        loadingView.isHidden = false
        loadingProgress = 0.0
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        progressIndicator.startAnimation(nil)
        progressBar.doubleValue = 0
        progressLabel.stringValue = "0%"
        
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.loadingProgress += 2.0
            self.progressBar.doubleValue = self.loadingProgress
            self.progressLabel.stringValue = "\(Int(self.loadingProgress))%"
            
            if self.loadingProgress >= 100.0 {
                self.progressTimer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.stopLoading()
                }
            }
        }
    }
    
    private func stopLoading() {
        isLoading = false
        loadingView.isHidden = true
        progressIndicator.stopAnimation(nil)
        progressTimer?.invalidate()
    }
    
    @objc private func refreshTapped() {
        startLoading()
    }
    
    @objc private func exportTapped() {
        startLoading()
    }
    
    @objc private func generateReportTapped() {
        startLoading()
    }
    
    @objc private func recordDoubleClicked() {
        let selectedRow = dataTableView.selectedRow
        if selectedRow >= 0 && selectedRow < dataRecords.count {
            let record = dataRecords[selectedRow]
            showRecordDetails(record)
        }
    }
    
    private func showRecordDetails(_ record: DataRecord) {
        let alert = NSAlert()
        alert.messageText = "Record Details"
        alert.informativeText = """
        ID: \(record.id)
        Name: \(record.name)
        Status: \(record.status)
        Date: \(record.date)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    deinit {
        progressTimer?.invalidate()
    }
}

// MARK: - NSTableViewDataSource
extension SilentLoadingState: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataRecords.count
    }
}

// MARK: - NSTableViewDelegate
extension SilentLoadingState: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let record = dataRecords[row]
        
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            switch column.identifier.rawValue {
            case "id":
                let textField = NSTextField()
                textField.stringValue = "\(record.id)"
                textField.font = NSFont.systemFont(ofSize: 14)
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear
                cellView.textField = textField
                
            case "name":
                let textField = NSTextField()
                textField.stringValue = record.name
                textField.font = NSFont.boldSystemFont(ofSize: 14)
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear
                cellView.textField = textField
                
            case "status":
                let textField = NSTextField()
                textField.stringValue = record.status
                textField.font = NSFont.systemFont(ofSize: 14)
                textField.textColor = record.status == "Active" ? .systemGreen : .systemOrange
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear
                cellView.textField = textField
                
            case "date":
                let textField = NSTextField()
                textField.stringValue = record.date
                textField.font = NSFont.systemFont(ofSize: 14)
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear
                cellView.textField = textField
                
            default:
                break
            }
        }
        
        return cellView
    }
}

// MARK: - Data Record Model
struct DataRecord {
    let id: Int
    let name: String
    let status: String
    let date: String
}

// MARK: - Storyboard Support
extension SilentLoadingState {
    static func instantiate() -> SilentLoadingState {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "SilentLoadingState") as! SilentLoadingState
    }
}
