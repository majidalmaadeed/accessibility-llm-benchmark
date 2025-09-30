import UIKit

class RightClickOnlyMenuViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var fileItems: [FileItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    private func setupData() {
        fileItems = [
            FileItem(
                id: 1,
                name: "Project Proposal.docx",
                type: .document,
                size: "2.4 MB",
                date: Date().addingTimeInterval(-86400 * 2),
                isSelected: false
            ),
            FileItem(
                id: 2,
                name: "Budget Spreadsheet.xlsx",
                type: .spreadsheet,
                size: "1.8 MB",
                date: Date().addingTimeInterval(-86400 * 5),
                isSelected: false
            ),
            FileItem(
                id: 3,
                name: "Presentation.pptx",
                type: .presentation,
                size: "5.2 MB",
                date: Date().addingTimeInterval(-86400 * 1),
                isSelected: false
            ),
            FileItem(
                id: 4,
                name: "Meeting Notes.txt",
                type: .text,
                size: "156 KB",
                date: Date().addingTimeInterval(-86400 * 3),
                isSelected: false
            ),
            FileItem(
                id: 5,
                name: "Design Mockup.png",
                type: .image,
                size: "3.1 MB",
                date: Date().addingTimeInterval(-86400 * 7),
                isSelected: false
            ),
            FileItem(
                id: 6,
                name: "Code Archive.zip",
                type: .archive,
                size: "12.5 MB",
                date: Date().addingTimeInterval(-86400 * 10),
                isSelected: false
            )
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "File Manager"
        
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
        
        // Toolbar
        let toolbarView = createToolbarView()
        contentView.addSubview(toolbarView)
        
        // File list
        let fileListView = createFileListView()
        contentView.addSubview(fileListView)
        
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
            
            toolbarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            toolbarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            fileListView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: 20),
            fileListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fileListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: fileListView.bottomAnchor, constant: 20),
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
        titleLabel.text = "File Manager"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Manage your files and documents"
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
    
    private func createToolbarView() -> UIView {
        let toolbarView = UIView()
        toolbarView.backgroundColor = .systemBackground
        toolbarView.layer.cornerRadius = 12
        toolbarView.layer.shadowColor = UIColor.black.cgColor
        toolbarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        toolbarView.layer.shadowRadius = 4
        toolbarView.layer.shadowOpacity = 0.1
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.addSubview(stackView)
        
        let newButton = createToolbarButton(title: "New", icon: "plus", action: #selector(newTapped))
        let uploadButton = createToolbarButton(title: "Upload", icon: "arrow.up.circle", action: #selector(uploadTapped))
        let downloadButton = createToolbarButton(title: "Download", icon: "arrow.down.circle", action: #selector(downloadTapped))
        let shareButton = createToolbarButton(title: "Share", icon: "square.and.arrow.up", action: #selector(shareTapped))
        
        stackView.addArrangedSubview(newButton)
        stackView.addArrangedSubview(uploadButton)
        stackView.addArrangedSubview(downloadButton)
        stackView.addArrangedSubview(shareButton)
        
        NSLayoutConstraint.activate([
            toolbarView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.topAnchor.constraint(equalTo: toolbarView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: toolbarView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: toolbarView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: -16)
        ])
        
        return toolbarView
    }
    
    private func createToolbarButton(title: String, icon: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stackView)
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return button
    }
    
    private func createFileListView() -> UIView {
        let listView = UIView()
        listView.backgroundColor = .systemBackground
        listView.layer.cornerRadius = 12
        listView.layer.shadowColor = UIColor.black.cgColor
        listView.layer.shadowOffset = CGSize(width: 0, height: 2)
        listView.layer.shadowRadius = 4
        listView.layer.shadowOpacity = 0.1
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Files"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        listView.addSubview(stackView)
        
        for fileItem in fileItems {
            let fileView = createFileItemView(fileItem)
            stackView.addArrangedSubview(fileView)
        }
        
        NSLayoutConstraint.activate([
            listView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
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
    
    private func createFileItemView(_ fileItem: FileItem) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = .systemGray6
        itemView.layer.cornerRadius = 8
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: fileItem.type.iconName)
        iconImageView.tintColor = fileItem.type.color
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(iconImageView)
        
        let nameLabel = UILabel()
        nameLabel.text = fileItem.name
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(nameLabel)
        
        let detailsLabel = UILabel()
        detailsLabel.text = "\(fileItem.size) • \(formatDate(fileItem.date))"
        detailsLabel.font = UIFont.systemFont(ofSize: 14)
        detailsLabel.textColor = .secondaryLabel
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(detailsLabel)
        
        let moreButton = UIButton(type: .system)
        moreButton.setTitle("⋯", for: .normal)
        moreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        moreButton.setTitleColor(.systemGray, for: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        itemView.addSubview(moreButton)
        
        // Add long press gesture for right-click simulation
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(fileItemLongPressed(_:)))
        longPressGesture.minimumPressDuration = 0.5
        itemView.addGestureRecognizer(longPressGesture)
        itemView.tag = fileItem.id
        
        // Add tap gesture for selection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fileItemTapped(_:)))
        itemView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            itemView.heightAnchor.constraint(equalToConstant: 60),
            
            iconImageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: moreButton.leadingAnchor, constant: -8),
            
            detailsLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            detailsLabel.trailingAnchor.constraint(lessThanOrEqualTo: moreButton.leadingAnchor, constant: -8),
            detailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: itemView.bottomAnchor, constant: -12),
            
            moreButton.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16),
            moreButton.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            moreButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return itemView
    }
    
    private func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .systemGray6
        footerView.layer.cornerRadius = 12
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let infoLabel = UILabel()
        infoLabel.text = "Right-click on files for additional options"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .secondaryLabel
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(infoLabel)
        
        let warningLabel = UILabel()
        warningLabel.text = "⚠️ Some functions are only available via right-click menu"
        warningLabel.font = UIFont.systemFont(ofSize: 12)
        warningLabel.textColor = .systemOrange
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 80),
            
            infoLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            
            warningLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            warningLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            warningLabel.bottomAnchor.constraint(lessThanOrEqualTo: footerView.bottomAnchor, constant: -16)
        ])
        
        return footerView
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    // MARK: - Context Menu Methods
    @objc private func fileItemLongPressed(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let fileId = gesture.view?.tag ?? 0
        guard let fileItem = fileItems.first(where: { $0.id == fileId }) else { return }
        
        showContextMenu(for: fileItem)
    }
    
    @objc private func fileItemTapped(_ gesture: UITapGestureRecognizer) {
        let fileId = gesture.view?.tag ?? 0
        guard let fileItem = fileItems.first(where: { $0.id == fileId }) else { return }
        
        // Toggle selection
        if let index = fileItems.firstIndex(where: { $0.id == fileId }) {
            fileItems[index].isSelected.toggle()
            updateFileItemAppearance(gesture.view!, isSelected: fileItems[index].isSelected)
        }
    }
    
    private func updateFileItemAppearance(_ view: UIView, isSelected: Bool) {
        view.backgroundColor = isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : .systemGray6
        view.layer.borderWidth = isSelected ? 2 : 0
        view.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
    
    private func showContextMenu(for fileItem: FileItem) {
        let alert = UIAlertController(title: fileItem.name, message: "Select an action", preferredStyle: .actionSheet)
        
        // Essential functions only available via right-click
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteFile(fileItem)
        })
        
        alert.addAction(UIAlertAction(title: "Rename", style: .default) { _ in
            self.renameFile(fileItem)
        })
        
        alert.addAction(UIAlertAction(title: "Move to Trash", style: .destructive) { _ in
            self.moveToTrash(fileItem)
        })
        
        alert.addAction(UIAlertAction(title: "Properties", style: .default) { _ in
            self.showProperties(fileItem)
        })
        
        alert.addAction(UIAlertAction(title: "Copy Path", style: .default) { _ in
            self.copyPath(fileItem)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad
        if let popover = alert.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - File Actions
    private func deleteFile(_ fileItem: FileItem) {
        let alert = UIAlertController(
            title: "Delete File",
            message: "Are you sure you want to permanently delete '\(fileItem.name)'?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            // Remove from array
            if let index = self.fileItems.firstIndex(where: { $0.id == fileItem.id }) {
                self.fileItems.remove(at: index)
                self.refreshFileList()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func renameFile(_ fileItem: FileItem) {
        let alert = UIAlertController(title: "Rename File", message: "Enter new name:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = fileItem.name
        }
        alert.addAction(UIAlertAction(title: "Rename", style: .default) { _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                if let index = self.fileItems.firstIndex(where: { $0.id == fileItem.id }) {
                    self.fileItems[index].name = newName
                    self.refreshFileList()
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func moveToTrash(_ fileItem: FileItem) {
        let alert = UIAlertController(
            title: "Move to Trash",
            message: "Move '\(fileItem.name)' to trash?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Move to Trash", style: .destructive) { _ in
            // Move to trash logic
            self.showAlert(title: "Moved to Trash", message: "File moved to trash successfully")
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showProperties(_ fileItem: FileItem) {
        let alert = UIAlertController(
            title: "File Properties",
            message: "Name: \(fileItem.name)\nType: \(fileItem.type.rawValue)\nSize: \(fileItem.size)\nDate: \(formatDate(fileItem.date))",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func copyPath(_ fileItem: FileItem) {
        let path = "/Documents/\(fileItem.name)"
        UIPasteboard.general.string = path
        showAlert(title: "Path Copied", message: "File path copied to clipboard")
    }
    
    private func refreshFileList() {
        // Refresh the file list view
        // This would typically reload the table view or collection view
        showAlert(title: "File List Updated", message: "File list has been refreshed")
    }
    
    // MARK: - Toolbar Actions
    @objc private func newTapped() {
        showAlert(title: "New File", message: "Creating new file...")
    }
    
    @objc private func uploadTapped() {
        showAlert(title: "Upload", message: "Opening file upload dialog...")
    }
    
    @objc private func downloadTapped() {
        showAlert(title: "Download", message: "Starting download...")
    }
    
    @objc private func shareTapped() {
        showAlert(title: "Share", message: "Opening share dialog...")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Data Models
struct FileItem {
    let id: Int
    var name: String
    let type: FileType
    let size: String
    let date: Date
    var isSelected: Bool
}

enum FileType: String, CaseIterable {
    case document = "Document"
    case spreadsheet = "Spreadsheet"
    case presentation = "Presentation"
    case text = "Text"
    case image = "Image"
    case archive = "Archive"
    
    var iconName: String {
        switch self {
        case .document: return "doc"
        case .spreadsheet: return "tablecells"
        case .presentation: return "rectangle.stack"
        case .text: return "text.alignleft"
        case .image: return "photo"
        case .archive: return "archivebox"
        }
    }
    
    var color: UIColor {
        switch self {
        case .document: return .systemBlue
        case .spreadsheet: return .systemGreen
        case .presentation: return .systemOrange
        case .text: return .systemGray
        case .image: return .systemPurple
        case .archive: return .systemBrown
        }
    }
}
