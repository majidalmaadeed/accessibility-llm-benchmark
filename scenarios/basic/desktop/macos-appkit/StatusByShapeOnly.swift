import Cocoa

class StatusByShapeOnly: NSViewController {
    
    @IBOutlet weak var filterSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var documentsTableView: NSTableView!
    @IBOutlet weak var totalLabel: NSTextField!
    @IBOutlet weak var sortInfoLabel: NSTextField!
    
    private var documents: [Document] = []
    private var filteredDocuments: [Document] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDocuments()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Filter Options
        filterSegmentedControl.segmentCount = 4
        filterSegmentedControl.setLabel("All", forSegment: 0)
        filterSegmentedControl.setLabel("Pending", forSegment: 1)
        filterSegmentedControl.setLabel("Approved", forSegment: 2)
        filterSegmentedControl.setLabel("Rejected", forSegment: 3)
        filterSegmentedControl.target = self
        filterSegmentedControl.action = #selector(filterChanged)
        
        // Documents Table View
        documentsTableView.dataSource = self
        documentsTableView.delegate = self
        documentsTableView.target = self
        documentsTableView.doubleAction = #selector(documentDoubleClicked)
        
        // Status Labels
        totalLabel.font = NSFont.boldSystemFont(ofSize: 14)
        sortInfoLabel.font = NSFont.systemFont(ofSize: 12)
        sortInfoLabel.textColor = .secondaryLabelColor
    }
    
    private func loadDocuments() {
        documents = [
            Document(name: "Project Proposal Q1 2024", department: "Marketing", size: "2.5 MB", type: "PDF", lastModified: "2024-01-15 14:30", status: .pending),
            Document(name: "Budget Report 2023", department: "Finance", size: "1.8 MB", type: "Excel", lastModified: "2024-01-12 09:15", status: .approved),
            Document(name: "Employee Handbook v2.1", department: "HR", size: "3.2 MB", type: "PDF", lastModified: "2024-01-10 16:45", status: .rejected),
            Document(name: "Technical Specifications", department: "Engineering", size: "4.1 MB", type: "PDF", lastModified: "2024-01-08 11:20", status: .pending),
            Document(name: "Marketing Strategy 2024", department: "Marketing", size: "2.8 MB", type: "PDF", lastModified: "2024-01-05 13:10", status: .approved),
            Document(name: "Security Audit Report", department: "IT", size: "1.5 MB", type: "PDF", lastModified: "2024-01-03 10:30", status: .rejected)
        ]
        filteredDocuments = documents
        updateUI()
    }
    
    private func updateUI() {
        documentsTableView.reloadData()
        totalLabel.stringValue = "Total Documents: \(filteredDocuments.count)"
        sortInfoLabel.stringValue = "Sort by: Name ↓"
    }
    
    @objc private func filterChanged() {
        let selectedFilter = filterSegmentedControl.selectedSegment
        switch selectedFilter {
        case 0: // All
            filteredDocuments = documents
        case 1: // Pending
            filteredDocuments = documents.filter { $0.status == .pending }
        case 2: // Approved
            filteredDocuments = documents.filter { $0.status == .approved }
        case 3: // Rejected
            filteredDocuments = documents.filter { $0.status == .rejected }
        default:
            filteredDocuments = documents
        }
        updateUI()
    }
    
    @objc private func documentDoubleClicked() {
        let selectedRow = documentsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < filteredDocuments.count {
            let document = filteredDocuments[selectedRow]
            showDocumentDetails(document)
        }
    }
    
    private func showDocumentDetails(_ document: Document) {
        let alert = NSAlert()
        alert.messageText = "Document Details"
        alert.informativeText = """
        Name: \(document.name)
        Department: \(document.department)
        Size: \(document.size)
        Type: \(document.type)
        Last Modified: \(document.lastModified)
        Status: \(document.status.rawValue)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - NSTableViewDataSource
extension StatusByShapeOnly: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filteredDocuments.count
    }
}

// MARK: - NSTableViewDelegate
extension StatusByShapeOnly: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let document = filteredDocuments[row]
        
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            switch column.identifier.rawValue {
            case "status":
                // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
                let statusView = NSView()
                statusView.wantsLayer = true
                
                let shapeView = NSView()
                shapeView.wantsLayer = true
                
                switch document.status {
                case .approved:
                    // STATUS BY SHAPE ONLY - Approved status shown as square
                    shapeView.layer?.backgroundColor = NSColor.systemGreen.cgColor
                    shapeView.layer?.cornerRadius = 0 // Square
                case .rejected:
                    // STATUS BY SHAPE ONLY - Rejected status shown as circle
                    shapeView.layer?.backgroundColor = NSColor.systemRed.cgColor
                    shapeView.layer?.cornerRadius = 12 // Circle
                case .pending:
                    // STATUS BY SHAPE ONLY - Pending status shown as circle
                    shapeView.layer?.backgroundColor = NSColor.systemYellow.cgColor
                    shapeView.layer?.cornerRadius = 12 // Circle
                }
                
                statusView.addSubview(shapeView)
                cellView.addSubview(statusView)
                
                shapeView.translatesAutoresizingMaskIntoConstraints = false
                statusView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    statusView.widthAnchor.constraint(equalToConstant: 24),
                    statusView.heightAnchor.constraint(equalToConstant: 24),
                    
                    shapeView.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
                    shapeView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
                    shapeView.widthAnchor.constraint(equalToConstant: 24),
                    shapeView.heightAnchor.constraint(equalToConstant: 24)
                ])
                
            case "document":
                let stackView = NSStackView()
                stackView.orientation = .vertical
                stackView.spacing = 4
                stackView.alignment = .leading
                
                // Document Name
                let nameLabel = NSTextField()
                nameLabel.stringValue = document.name
                nameLabel.font = NSFont.boldSystemFont(ofSize: 16)
                nameLabel.isEditable = false
                nameLabel.isBordered = false
                nameLabel.backgroundColor = .clear
                
                // Document Info
                let infoLabel = NSTextField()
                infoLabel.stringValue = "\(document.department) • \(document.size) • \(document.type)"
                infoLabel.font = NSFont.systemFont(ofSize: 12)
                infoLabel.textColor = .secondaryLabelColor
                infoLabel.isEditable = false
                infoLabel.isBordered = false
                infoLabel.backgroundColor = .clear
                
                // Last Modified
                let modifiedLabel = NSTextField()
                modifiedLabel.stringValue = "Last modified: \(document.lastModified)"
                modifiedLabel.font = NSFont.systemFont(ofSize: 12)
                modifiedLabel.textColor = .secondaryLabelColor
                modifiedLabel.isEditable = false
                modifiedLabel.isBordered = false
                modifiedLabel.backgroundColor = .clear
                
                stackView.addArrangedSubview(nameLabel)
                stackView.addArrangedSubview(infoLabel)
                stackView.addArrangedSubview(modifiedLabel)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
                ])
                
            case "actions":
                let stackView = NSStackView()
                stackView.orientation = .horizontal
                stackView.spacing = 8
                
                let viewButton = NSButton()
                viewButton.title = "👁️"
                viewButton.font = NSFont.systemFont(ofSize: 16)
                viewButton.target = self
                viewButton.action = #selector(viewButtonTapped)
                viewButton.tag = row
                
                let editButton = NSButton()
                editButton.title = "✏️"
                editButton.font = NSFont.systemFont(ofSize: 16)
                editButton.target = self
                editButton.action = #selector(editButtonTapped)
                editButton.tag = row
                
                let downloadButton = NSButton()
                downloadButton.title = "📤"
                downloadButton.font = NSFont.systemFont(ofSize: 16)
                downloadButton.target = self
                downloadButton.action = #selector(downloadButtonTapped)
                downloadButton.tag = row
                
                stackView.addArrangedSubview(viewButton)
                stackView.addArrangedSubview(editButton)
                stackView.addArrangedSubview(downloadButton)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8)
                ])
                
            default:
                break
            }
        }
        
        return cellView
    }
    
    @objc private func viewButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < filteredDocuments.count {
            let document = filteredDocuments[row]
            showDocumentDetails(document)
        }
    }
    
    @objc private func editButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < filteredDocuments.count {
            let document = filteredDocuments[row]
            // Handle edit
            let alert = NSAlert()
            alert.messageText = "Edit Document"
            alert.informativeText = "Edit: \(document.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func downloadButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < filteredDocuments.count {
            let document = filteredDocuments[row]
            // Handle download
            let alert = NSAlert()
            alert.messageText = "Download Document"
            alert.informativeText = "Download: \(document.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
}

// MARK: - Document Model
struct Document {
    let name: String
    let department: String
    let size: String
    let type: String
    let lastModified: String
    let status: DocumentStatus
}

enum DocumentStatus: String, CaseIterable {
    case pending = "Pending"
    case approved = "Approved"
    case rejected = "Rejected"
}

// MARK: - Storyboard Support
extension StatusByShapeOnly {
    static func instantiate() -> StatusByShapeOnly {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "StatusByShapeOnly") as! StatusByShapeOnly
    }
}
