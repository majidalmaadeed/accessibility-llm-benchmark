import Cocoa
    // MARK: - UI Elements
    @IBOutlet weak var openModalButton: NSButton!
    @IBOutlet weak var modalWindow: NSWindow!
    @IBOutlet weak var modalOverlay: NSView!
    @IBOutlet weak var closeModalButton: NSButton!
    @IBOutlet weak var themeComboBox: NSComboBox!
    @IBOutlet weak var languageComboBox: NSComboBox!
    @IBOutlet weak var notificationsComboBox: NSComboBox!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var saveButton: NSButton!
    // MARK: - State
    private var isModalOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        // Configure open modal button
        openModalButton.title = "Open Settings Modal"
        openModalButton.target = self
        openModalButton.action = #selector(openModalClicked)
        // Configure modal overlay
        modalOverlay.isHidden = true
        modalOverlay.wantsLayer = true
        modalOverlay.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.5).cgColor
        // Configure close modal button
        closeModalButton.title = "×"
        closeModalButton.target = self
        closeModalButton.action = #selector(closeModalClicked)
        // Configure combo boxes
        themeComboBox.addItems(withObjectValues: ["Light", "Dark", "Auto"])
        themeComboBox.selectItem(at: 0)
        languageComboBox.addItems(withObjectValues: ["English", "Spanish", "French"])
        languageComboBox.selectItem(at: 0)
        notificationsComboBox.addItems(withObjectValues: ["All", "Important Only", "None"])
        notificationsComboBox.selectItem(at: 0)
        // Configure action buttons
        cancelButton.title = "Cancel"
        cancelButton.target = self
        cancelButton.action = #selector(cancelClicked)
        saveButton.title = "Save Settings"
        saveButton.target = self
        saveButton.action = #selector(saveClicked)
    }
        // Basic setup only
    }
    @objc private func openModalClicked() {
        guard !isModalOpen else { return }
        // Show modal
        modalOverlay.isHidden = false
        isModalOpen = true
        themeComboBox.becomeFirstResponder()
        // Should handle Escape key to close modal
    }
    @objc private func closeModalClicked() {
        closeModal()
    }
    @objc private func cancelClicked() {
        closeModal()
    }
    @objc private func saveClicked() {
        // Simulate saving settings
        let alert = NSAlert()
        alert.messageText = "Success"
        alert.informativeText = "Settings saved successfully!"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
        closeModal()
    }
    private func closeModal() {
        guard isModalOpen else { return }
        // Hide modal
        modalOverlay.isHidden = true
        isModalOpen = false
        } else {
            openModalButton.becomeFirstResponder()
        }
    }
    override func keyDown(with event: NSEvent) {
        // Should close modal when Escape key is pressed
        // Should only work when modal is open
        if event.keyCode == 53 && isModalOpen { // Escape key
            closeModal()
            return
        }
        super.keyDown(with: event)
    }
    // Should implement methods to:
}
/*
 • Escape key not handled: Modal doesn't close when Escape is pressed
 How to Fix:
 • Handle Escape key to close modal
 */
