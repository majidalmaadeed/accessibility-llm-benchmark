import Cocoa

class InsufficientButtonSpacing: NSViewController {
    
    @IBOutlet weak var actionButtonsStackView: NSStackView!
    @IBOutlet weak var formattingButtonsStackView: NSStackView!
    @IBOutlet weak var quickActionsStackView: NSStackView!
    @IBOutlet weak var documentTitleField: NSTextField!
    @IBOutlet weak var documentContentTextView: NSTextView!
    
    private var isEditing = false
    private var isDeleting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Document Title
        documentTitleField.stringValue = "Sample Document"
        documentTitleField.font = NSFont.systemFont(ofSize: 18, weight: .bold)
        documentTitleField.isEditable = !isEditing
        
        // Document Content
        documentContentTextView.string = "This is a sample document content. You can edit this text when in edit mode. The document contains various sections and formatting options."
        documentContentTextView.font = NSFont.systemFont(ofSize: 14)
        documentContentTextView.isEditable = !isEditing
        
        // Action Buttons - INSUFFICIENT BUTTON SPACING
        setupActionButtons()
        
        // Formatting Options - INSUFFICIENT BUTTON SPACING
        setupFormattingButtons()
        
        // Quick Actions - INSUFFICIENT BUTTON SPACING
        setupQuickActionButtons()
    }
    
    private func setupActionButtons() {
        // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
        let actionButtons = [
            ("Save", #selector(saveTapped), NSColor.systemBlue),
            ("Edit", #selector(editTapped), NSColor.systemGreen),
            ("Delete", #selector(deleteTapped), NSColor.systemRed),
            ("Share", #selector(shareTapped), NSColor.systemOrange),
            ("Print", #selector(printTapped), NSColor.systemPurple)
        ]
        
        for (title, action, color) in actionButtons {
            let button = NSButton()
            button.title = title
            button.font = NSFont.boldSystemFont(ofSize: 16)
            button.bezelStyle = .rounded
            button.target = self
            button.action = action
            button.wantsLayer = true
            button.layer?.backgroundColor = color.cgColor
            button.contentTintColor = .white
            
            actionButtonsStackView.addArrangedSubview(button)
        }
        
        // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
        actionButtonsStackView.spacing = 2
    }
    
    private func setupFormattingButtons() {
        // INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
        let formattingButtons = [
            ("B", #selector(boldTapped), "Bold"),
            ("I", #selector(italicTapped), "Italic"),
            ("U", #selector(underlineTapped), "Underline"),
            ("A", #selector(alignLeftTapped), "Align Left"),
            ("A", #selector(alignCenterTapped), "Align Center"),
            ("A", #selector(alignRightTapped), "Align Right")
        ]
        
        for (title, action, tooltip) in formattingButtons {
            let button = NSButton()
            button.title = title
            button.font = NSFont.boldSystemFont(ofSize: 16)
            button.bezelStyle = .rounded
            button.target = self
            button.action = action
            button.toolTip = tooltip
            button.wantsLayer = true
            button.layer?.backgroundColor = NSColor.systemBlue.cgColor
            button.contentTintColor = .white
            
            formattingButtonsStackView.addArrangedSubview(button)
        }
        
        // INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
        formattingButtonsStackView.spacing = 2
    }
    
    private func setupQuickActionButtons() {
        // INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart
        let quickActions = [
            ("📄", #selector(newDocumentTapped), "New Document"),
            ("📁", #selector(openFolderTapped), "Open Folder"),
            ("💾", #selector(saveTapped), "Save"),
            ("🖨️", #selector(printTapped), "Print"),
            ("📤", #selector(exportTapped), "Export"),
            ("🔍", #selector(searchTapped), "Search")
        ]
        
        for (title, action, tooltip) in quickActions {
            let button = NSButton()
            button.title = title
            button.font = NSFont.systemFont(ofSize: 16)
            button.bezelStyle = .rounded
            button.target = self
            button.action = action
            button.toolTip = tooltip
            button.wantsLayer = true
            button.layer?.backgroundColor = NSColor.systemGray.cgColor
            button.contentTintColor = .white
            
            quickActionsStackView.addArrangedSubview(button)
        }
        
        // INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart
        quickActionsStackView.spacing = 2
    }
    
    // MARK: - Action Button Methods
    @objc private func saveTapped() {
        // Handle save
        let alert = NSAlert()
        alert.messageText = "Save Document"
        alert.informativeText = "Document saved successfully!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func editTapped() {
        isEditing.toggle()
        documentTitleField.isEditable = !isEditing
        documentContentTextView.isEditable = !isEditing
        
        // Update edit button title
        if let editButton = actionButtonsStackView.arrangedSubviews.first(where: { ($0 as? NSButton)?.title == "Edit" }) as? NSButton {
            editButton.title = isEditing ? "Done" : "Edit"
        }
    }
    
    @objc private func deleteTapped() {
        isDeleting.toggle()
        let alert = NSAlert()
        alert.messageText = "Delete Document"
        alert.informativeText = isDeleting ? "Document deleted!" : "Are you sure you want to delete this document?"
        alert.addButton(withTitle: "OK")
        if !isDeleting {
            alert.addButton(withTitle: "Cancel")
        }
        alert.runModal()
    }
    
    @objc private func shareTapped() {
        // Handle share
        let alert = NSAlert()
        alert.messageText = "Share Document"
        alert.informativeText = "Document shared successfully!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func printTapped() {
        // Handle print
        let alert = NSAlert()
        alert.messageText = "Print Document"
        alert.informativeText = "Document sent to printer!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    // MARK: - Formatting Button Methods
    @objc private func boldTapped() {
        // Handle bold
        let alert = NSAlert()
        alert.messageText = "Bold Formatting"
        alert.informativeText = "Bold formatting applied!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func italicTapped() {
        // Handle italic
        let alert = NSAlert()
        alert.messageText = "Italic Formatting"
        alert.informativeText = "Italic formatting applied!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func underlineTapped() {
        // Handle underline
        let alert = NSAlert()
        alert.messageText = "Underline Formatting"
        alert.informativeText = "Underline formatting applied!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func alignLeftTapped() {
        // Handle align left
        let alert = NSAlert()
        alert.messageText = "Align Left"
        alert.informativeText = "Text aligned to left!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func alignCenterTapped() {
        // Handle align center
        let alert = NSAlert()
        alert.messageText = "Align Center"
        alert.informativeText = "Text aligned to center!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func alignRightTapped() {
        // Handle align right
        let alert = NSAlert()
        alert.messageText = "Align Right"
        alert.informativeText = "Text aligned to right!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    // MARK: - Quick Action Button Methods
    @objc private func newDocumentTapped() {
        // Handle new document
        let alert = NSAlert()
        alert.messageText = "New Document"
        alert.informativeText = "New document created!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func openFolderTapped() {
        // Handle open folder
        let alert = NSAlert()
        alert.messageText = "Open Folder"
        alert.informativeText = "Folder opened!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func exportTapped() {
        // Handle export
        let alert = NSAlert()
        alert.messageText = "Export Document"
        alert.informativeText = "Document exported successfully!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func searchTapped() {
        // Handle search
        let alert = NSAlert()
        alert.messageText = "Search Document"
        alert.informativeText = "Search functionality activated!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - Storyboard Support
extension InsufficientButtonSpacing {
    static func instantiate() -> InsufficientButtonSpacing {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "InsufficientButtonSpacing") as! InsufficientButtonSpacing
    }
}
