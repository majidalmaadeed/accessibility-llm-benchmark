import UIKit

class StatusByShapeOnlyViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var documents: [Document] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    private func setupData() {
        documents = [
            Document(
                id: 1,
                title: "Project Proposal",
                author: "John Smith",
                date: Date().addingTimeInterval(-86400 * 3),
                status: .pending,
                type: .proposal
            ),
            Document(
                id: 2,
                title: "Financial Report Q3",
                author: "Sarah Johnson",
                date: Date().addingTimeInterval(-86400 * 7),
                status: .approved,
                type: .report
            ),
            Document(
                id: 3,
                title: "Contract Agreement",
                author: "Mike Wilson",
                date: Date().addingTimeInterval(-86400 * 1),
                status: .rejected,
                type: .contract
            ),
            Document(
                id: 4,
                title: "Meeting Minutes",
                author: "Emily Davis",
                date: Date().addingTimeInterval(-86400 * 5),
                status: .approved,
                type: .minutes
            ),
            Document(
                id: 5,
                title: "Budget Planning",
                author: "David Brown",
                date: Date().addingTimeInterval(-86400 * 2),
                status: .pending,
                type: .budget
            ),
            Document(
                id: 6,
                title: "Policy Update",
                author: "Lisa Anderson",
                date: Date().addingTimeInterval(-86400 * 10),
                status: .approved,
                type: .policy
            ),
            Document(
                id: 7,
                title: "Technical Specification",
                author: "Robert Taylor",
                date: Date().addingTimeInterval(-86400 * 4),
                status: .rejected,
                type: .specification
            ),
            Document(
                id: 8,
                title: "User Manual",
                author: "Jennifer Martinez",
                date: Date().addingTimeInterval(-86400 * 6),
                status: .pending,
                type: .manual
            )
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Document Management"
        
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
        
        // Filter controls
        let filterView = createFilterView()
        contentView.addSubview(filterView)
        
        // Document list
        let documentListView = createDocumentList()
        contentView.addSubview(documentListView)
        
        // Summary section
        let summaryView = createSummaryView()
        contentView.addSubview(summaryView)
        
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
            
            filterView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            filterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            documentListView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 20),
            documentListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            documentListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            summaryView.topAnchor.constraint(equalTo: documentListView.bottomAnchor, constant: 20),
            summaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBlue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Document Approval System"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Manage and track document approvals"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
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
    
    private func createFilterView() -> UIView {
        let filterView = UIView()
        filterView.backgroundColor = .systemBackground
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Filter Documents"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        filterView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        filterView.addSubview(stackView)
        
        let statusButton = UIButton(type: .system)
        statusButton.setTitle("Status", for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        statusButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        statusButton.layer.cornerRadius = 8
        statusButton.addTarget(self, action: #selector(statusFilterTapped), for: .touchUpInside)
        stackView.addArrangedSubview(statusButton)
        
        let typeButton = UIButton(type: .system)
        typeButton.setTitle("Type", for: .normal)
        typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        typeButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        typeButton.layer.cornerRadius = 8
        typeButton.addTarget(self, action: #selector(typeFilterTapped), for: .touchUpInside)
        stackView.addArrangedSubview(typeButton)
        
        let dateButton = UIButton(type: .system)
        dateButton.setTitle("Date", for: .normal)
        dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        dateButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        dateButton.layer.cornerRadius = 8
        dateButton.addTarget(self, action: #selector(dateFilterTapped), for: .touchUpInside)
        stackView.addArrangedSubview(dateButton)
        
        NSLayoutConstraint.activate([
            filterView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return filterView
    }
    
    private func createDocumentList() -> UIView {
        let listView = UIView()
        listView.backgroundColor = .systemBackground
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Documents"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(stackView)
        
        for document in documents {
            let documentView = createDocumentItem(document)
            stackView.addArrangedSubview(documentView)
        }
        
        NSLayoutConstraint.activate([
            listView.heightAnchor.constraint(greaterThanOrEqualToConstant: 600),
            
            titleLabel.topAnchor.constraint(equalTo: listView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: listView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: listView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: listView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: listView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: listView.bottomAnchor, constant: -20)
        ])
        
        return listView
    }
    
    private func createDocumentItem(_ document: Document) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 12
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = document.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        let authorLabel = UILabel()
        authorLabel.text = "By \(document.author)"
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = .secondaryLabel
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(authorLabel)
        
        let dateLabel = UILabel()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: document.date)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .tertiaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(dateLabel)
        
        // Status indicator using only shape (circle vs square)
        let statusView = createStatusIndicator(for: document.status)
        itemView.addSubview(statusView)
        
        let typeLabel = UILabel()
        typeLabel.text = document.type.rawValue.capitalized
        typeLabel.font = UIFont.systemFont(ofSize: 12)
        typeLabel.textColor = .systemBlue
        typeLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        typeLabel.textAlignment = .center
        typeLabel.layer.cornerRadius = 4
        typeLabel.clipsToBounds = true
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(typeLabel)
        
        // Action buttons
        let actionStackView = UIStackView()
        actionStackView.axis = .horizontal
        actionStackView.spacing = 8
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(actionStackView)
        
        let viewButton = UIButton(type: .system)
        viewButton.setTitle("View", for: .normal)
        viewButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        viewButton.setTitleColor(.systemBlue, for: .normal)
        viewButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        viewButton.layer.cornerRadius = 6
        viewButton.addTarget(self, action: #selector(viewDocumentTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(viewButton)
        
        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        editButton.setTitleColor(.systemOrange, for: .normal)
        editButton.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        editButton.layer.cornerRadius = 6
        editButton.addTarget(self, action: #selector(editDocumentTapped), for: .touchUpInside)
        actionStackView.addArrangedSubview(editButton)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusView.leadingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusView.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusView.leadingAnchor, constant: -8),
            
            statusView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            statusView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -12),
            statusView.widthAnchor.constraint(equalToConstant: 20),
            statusView.heightAnchor.constraint(equalToConstant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 4),
            typeLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -12),
            typeLabel.widthAnchor.constraint(equalToConstant: 80),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            actionStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            actionStackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 12),
            actionStackView.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor, constant: -12)
        ])
        
        return itemView
    }
    
    private func createStatusIndicator(for status: DocumentStatus) -> UIView {
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        // Status indicated only by shape - no color coding or text
        switch status {
        case .approved:
            // Circle for approved
            statusView.backgroundColor = .systemGray
            statusView.layer.cornerRadius = 10
        case .pending:
            // Square for pending
            statusView.backgroundColor = .systemGray
            statusView.layer.cornerRadius = 0
        case .rejected:
            // Circle for rejected (same as approved - no distinction)
            statusView.backgroundColor = .systemGray
            statusView.layer.cornerRadius = 10
        }
        
        return statusView
    }
    
    private func createSummaryView() -> UIView {
        let summaryView = UIView()
        summaryView.backgroundColor = .systemGray6
        summaryView.layer.cornerRadius = 12
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Summary"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.addSubview(stackView)
        
        let approvedCount = documents.filter { $0.status == .approved }.count
        let pendingCount = documents.filter { $0.status == .pending }.count
        let rejectedCount = documents.filter { $0.status == .rejected }.count
        
        let approvedView = createSummaryItem(title: "Approved", count: approvedCount, shape: .circle)
        let pendingView = createSummaryItem(title: "Pending", count: pendingCount, shape: .square)
        let rejectedView = createSummaryItem(title: "Rejected", count: rejectedCount, shape: .circle)
        
        stackView.addArrangedSubview(approvedView)
        stackView.addArrangedSubview(pendingView)
        stackView.addArrangedSubview(rejectedView)
        
        NSLayoutConstraint.activate([
            summaryView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -16)
        ])
        
        return summaryView
    }
    
    private func createSummaryItem(title: String, count: Int, shape: StatusShape) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .white
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let countLabel = UILabel()
        countLabel.text = "\(count)"
        countLabel.font = UIFont.boldSystemFont(ofSize: 24)
        countLabel.textAlignment = .center
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(countLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .secondaryLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(titleLabel)
        
        // Status shape indicator
        let shapeView = UIView()
        shapeView.backgroundColor = .systemGray
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        
        if shape == .circle {
            shapeView.layer.cornerRadius = 8
        } else {
            shapeView.layer.cornerRadius = 0
        }
        
        itemView.addSubview(shapeView)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(equalToConstant: 80),
            
            countLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            countLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -8),
            
            shapeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            shapeView.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            shapeView.widthAnchor.constraint(equalToConstant: 16),
            shapeView.heightAnchor.constraint(equalToConstant: 16),
            shapeView.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor, constant: -8)
        ])
        
        return itemView
    }
    
    // MARK: - Actions
    @objc private func statusFilterTapped() {
        let alert = UIAlertController(title: "Filter by Status", message: "Select status to filter", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Statuses", style: .default) { _ in
            // Show all documents
        })
        
        alert.addAction(UIAlertAction(title: "Approved (Circle)", style: .default) { _ in
            // Filter approved documents
        })
        
        alert.addAction(UIAlertAction(title: "Pending (Square)", style: .default) { _ in
            // Filter pending documents
        })
        
        alert.addAction(UIAlertAction(title: "Rejected (Circle)", style: .default) { _ in
            // Filter rejected documents
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func typeFilterTapped() {
        let alert = UIAlertController(title: "Filter by Type", message: "Select document type to filter", preferredStyle: .actionSheet)
        
        let types = Array(Set(documents.map { $0.type.rawValue })).sorted()
        
        alert.addAction(UIAlertAction(title: "All Types", style: .default) { _ in
            // Show all documents
        })
        
        for type in types {
            alert.addAction(UIAlertAction(title: type.capitalized, style: .default) { _ in
                // Filter by type
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func dateFilterTapped() {
        let alert = UIAlertController(title: "Filter by Date", message: "Select date range to filter", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Dates", style: .default) { _ in
            // Show all documents
        })
        
        alert.addAction(UIAlertAction(title: "Last 7 Days", style: .default) { _ in
            // Filter last 7 days
        })
        
        alert.addAction(UIAlertAction(title: "Last 30 Days", style: .default) { _ in
            // Filter last 30 days
        })
        
        alert.addAction(UIAlertAction(title: "This Year", style: .default) { _ in
            // Filter this year
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func viewDocumentTapped() {
        let alert = UIAlertController(title: "View Document", message: "Opening document viewer...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func editDocumentTapped() {
        let alert = UIAlertController(title: "Edit Document", message: "Opening document editor...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Data Models
struct Document {
    let id: Int
    let title: String
    let author: String
    let date: Date
    let status: DocumentStatus
    let type: DocumentType
}

enum DocumentStatus {
    case approved
    case pending
    case rejected
}

enum DocumentType: String, CaseIterable {
    case proposal = "proposal"
    case report = "report"
    case contract = "contract"
    case minutes = "minutes"
    case budget = "budget"
    case policy = "policy"
    case specification = "specification"
    case manual = "manual"
}

enum StatusShape {
    case circle
    case square
}
