import Cocoa

class RightClickOnlyMenu: NSViewController {
    
    @IBOutlet weak var toolbarStackView: NSStackView!
    @IBOutlet weak var filesTableView: NSTableView!
    @IBOutlet weak var selectedItemLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    
    private var files: [FileItem] = []
    private var selectedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadFiles()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Toolbar
        setupToolbar()
        
        // Files Table View
        filesTableView.dataSource = self
        filesTableView.delegate = self
        filesTableView.target = self
        filesTableView.doubleAction = #selector(fileDoubleClicked)
        
        // Status Labels
        selectedItemLabel.font = NSFont.systemFont(ofSize: 12)
        selectedItemLabel.textColor = .secondaryLabelColor
        
        statusLabel.font = NSFont.systemFont(ofSize: 12)
        statusLabel.textColor = .secondaryLabelColor
    }
    
    private func setupToolbar() {
        let toolbarButtons = [
            ("📁", "New Folder", #selector(newFolderTapped)),
            ("📄", "New File", #selector(newFileTapped)),
            ("📤", "Upload", #selector(uploadTapped)),
            ("📥", "Download", #selector(downloadTapped))
        ]
        
        for (icon, tooltip, action) in toolbarButtons {
            let button = NSButton()
            button.title = icon
            button.font = NSFont.systemFont(ofSize: 16)
            button.toolTip = tooltip
            button.target = self
            button.action = action
            button.wantsLayer = true
            button.layer?.backgroundColor = NSColor.systemGray.cgColor
            button.layer?.cornerRadius = 8
            button.contentTintColor = .white
            
            toolbarStackView.addArrangedSubview(button)
        }
    }
    
    private func loadFiles() {
        files = [
            FileItem(name: "document.pdf", type: "PDF", size: "2.5 MB", lastModified: "2 hours ago", isFolder: false),
            FileItem(name: "Projects", type: "Folder", size: "15 items", lastModified: "1 day ago", isFolder: true),
            FileItem(name: "image.jpg", type: "JPEG", size: "1.2 MB", lastModified: "3 hours ago", isFolder: false),
            FileItem(name: "spreadsheet.xlsx", type: "Excel", size: "850 KB", lastModified: "1 day ago", isFolder: false),
            FileItem(name: "audio.mp3", type: "MP3", size: "4.2 MB", lastModified: "2 days ago", isFolder: false)
        ]
        filesTableView.reloadData()
    }
    
    @objc private func newFolderTapped() {
        // Handle new folder
        let alert = NSAlert()
        alert.messageText = "New Folder"
        alert.informativeText = "New folder created!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func newFileTapped() {
        // Handle new file
        let alert = NSAlert()
        alert.messageText = "New File"
        alert.informativeText = "New file created!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func uploadTapped() {
        // Handle upload
        let alert = NSAlert()
        alert.messageText = "Upload Files"
        alert.informativeText = "Upload functionality activated!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func downloadTapped() {
        // Handle download
        let alert = NSAlert()
        alert.messageText = "Download Files"
        alert.informativeText = "Download functionality activated!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func fileDoubleClicked() {
        let selectedRow = filesTableView.selectedRow
        if selectedRow >= 0 && selectedRow < files.count {
            let file = files[selectedRow]
            showFileDetails(file)
        }
    }
    
    private func showFileDetails(_ file: FileItem) {
        let alert = NSAlert()
        alert.messageText = "File Details"
        alert.informativeText = """
        Name: \(file.name)
        Type: \(file.type)
        Size: \(file.size)
        Last Modified: \(file.lastModified)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - NSTableViewDataSource
extension RightClickOnlyMenu: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return files.count
    }
}

// MARK: - NSTableViewDelegate
extension RightClickOnlyMenu: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let file = files[row]
        
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            switch column.identifier.rawValue {
            case "icon":
                let imageView = NSImageView()
                imageView.image = NSImage(named: file.isFolder ? "folder_icon" : "file_icon")
                imageView.imageScaling = .scaleProportionallyUpOrDown
                cellView.addSubview(imageView)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    imageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 24),
                    imageView.heightAnchor.constraint(equalToConstant: 24)
                ])
                
            case "name":
                let stackView = NSStackView()
                stackView.orientation = .vertical
                stackView.spacing = 4
                stackView.alignment = .leading
                
                let nameLabel = NSTextField()
                nameLabel.stringValue = file.name
                nameLabel.font = NSFont.boldSystemFont(ofSize: 14)
                nameLabel.isEditable = false
                nameLabel.isBordered = false
                nameLabel.backgroundColor = .clear
                
                let infoLabel = NSTextField()
                infoLabel.stringValue = "\(file.type) • \(file.size) • Modified \(file.lastModified)"
                infoLabel.font = NSFont.systemFont(ofSize: 12)
                infoLabel.textColor = .secondaryLabelColor
                infoLabel.isEditable = false
                infoLabel.isBordered = false
                infoLabel.backgroundColor = .clear
                
                stackView.addArrangedSubview(nameLabel)
                stackView.addArrangedSubview(infoLabel)
                
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
        
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        cellView.menu = createContextMenu(for: file, at: row)
        
        return cellView
    }
    
    private func createContextMenu(for file: FileItem, at row: Int) -> NSMenu {
        let menu = NSMenu()
        
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        let openItem = NSMenuItem(title: "Open", action: #selector(openFileTapped), keyEquivalent: "")
        openItem.target = self
        openItem.tag = row
        menu.addItem(openItem)
        
        let renameItem = NSMenuItem(title: "Rename", action: #selector(renameFileTapped), keyEquivalent: "")
        renameItem.target = self
        renameItem.tag = row
        menu.addItem(renameItem)
        
        let copyItem = NSMenuItem(title: "Copy", action: #selector(copyFileTapped), keyEquivalent: "")
        copyItem.target = self
        copyItem.tag = row
        menu.addItem(copyItem)
        
        let moveItem = NSMenuItem(title: "Move", action: #selector(moveFileTapped), keyEquivalent: "")
        moveItem.target = self
        moveItem.tag = row
        menu.addItem(moveItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        let deleteItem = NSMenuItem(title: "Delete", action: #selector(deleteFileTapped), keyEquivalent: "")
        deleteItem.target = self
        deleteItem.tag = row
        deleteItem.attributedTitle = NSAttributedString(string: "Delete", attributes: [.foregroundColor: NSColor.systemRed])
        menu.addItem(deleteItem)
        
        return menu
    }
    
    @objc private func viewButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            showFileDetails(file)
        }
    }
    
    @objc private func editButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // Handle edit
            let alert = NSAlert()
            alert.messageText = "Edit File"
            alert.informativeText = "Edit: \(file.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func downloadButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // Handle download
            let alert = NSAlert()
            alert.messageText = "Download File"
            alert.informativeText = "Download: \(file.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    // MARK: - Context Menu Actions
    @objc private func openFileTapped(_ sender: NSMenuItem) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            showFileDetails(file)
        }
    }
    
    @objc private func renameFileTapped(_ sender: NSMenuItem) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // Handle rename
            let alert = NSAlert()
            alert.messageText = "Rename File"
            alert.informativeText = "Rename: \(file.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func copyFileTapped(_ sender: NSMenuItem) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // Handle copy
            let alert = NSAlert()
            alert.messageText = "Copy File"
            alert.informativeText = "Copy: \(file.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func moveFileTapped(_ sender: NSMenuItem) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // Handle move
            let alert = NSAlert()
            alert.messageText = "Move File"
            alert.informativeText = "Move: \(file.name)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func deleteFileTapped(_ sender: NSMenuItem) {
        let row = sender.tag
        if row >= 0 && row < files.count {
            let file = files[row]
            // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
            let alert = NSAlert()
            alert.messageText = "Delete File"
            alert.informativeText = "Are you sure you want to delete '\(file.name)'? This action cannot be undone."
            alert.addButton(withTitle: "Delete")
            alert.addButton(withTitle: "Cancel")
            
            let response = alert.runModal()
            if response == .alertFirstButtonReturn {
                // Handle delete
                files.remove(at: row)
                filesTableView.reloadData()
            }
        }
    }
}

// MARK: - File Item Model
struct FileItem {
    let name: String
    let type: String
    let size: String
    let lastModified: String
    let isFolder: Bool
}

// MARK: - Storyboard Support
extension RightClickOnlyMenu {
    static func instantiate() -> RightClickOnlyMenu {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "RightClickOnlyMenu") as! RightClickOnlyMenu
    }
}
