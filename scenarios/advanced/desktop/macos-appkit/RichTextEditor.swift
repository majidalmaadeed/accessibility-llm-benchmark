import Cocoa

class RichTextEditor: NSViewController {
    
    // MARK: - Properties
    private var undoStack: [String] = []
    private var redoStack: [String] = []
    private var currentZoom: CGFloat = 100
    private var isUpdating = false
    
    // MARK: - UI Elements
    @IBOutlet weak var textView: NSTextView!
    @IBOutlet weak var toolbar: NSToolbar!
    @IBOutlet weak var wordCountLabel: NSTextField!
    @IBOutlet weak var characterCountLabel: NSTextField!
    @IBOutlet weak var paragraphCountLabel: NSTextField!
    @IBOutlet weak var fontSizeComboBox: NSComboBox!
    @IBOutlet weak var fontFamilyComboBox: NSComboBox!
    @IBOutlet weak var boldButton: NSButton!
    @IBOutlet weak var italicButton: NSButton!
    @IBOutlet weak var underlineButton: NSButton!
    @IBOutlet weak var leftAlignButton: NSButton!
    @IBOutlet weak var centerAlignButton: NSButton!
    @IBOutlet weak var rightAlignButton: NSButton!
    @IBOutlet weak var justifyButton: NSButton!
    @IBOutlet weak var bulletListButton: NSButton!
    @IBOutlet weak var numberedListButton: NSButton!
    @IBOutlet weak var textColorButton: NSButton!
    @IBOutlet weak var backgroundColorButton: NSButton!
    @IBOutlet weak var insertImageButton: NSButton!
    @IBOutlet weak var insertTableButton: NSButton!
    @IBOutlet weak var insertLinkButton: NSButton!
    @IBOutlet weak var undoButton: NSButton!
    @IBOutlet weak var redoButton: NSButton!
    @IBOutlet weak var zoomLabel: NSTextField!
    @IBOutlet weak var zoomInButton: NSButton!
    @IBOutlet weak var zoomOutButton: NSButton!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var positionLabel: NSTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateStatistics()
        updateButtonStates()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Configure text view
        textView.delegate = self
        textView.isRichText = true
        textView.allowsUndo = true
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        
        // Configure toolbar buttons
        setupToolbarButtons()
        
        // Configure combo boxes
        setupComboBoxes()
        
        // Setup menu
        setupMenu()
    }
    
    private func setupToolbarButtons() {
        // Undo/Redo
        undoButton.target = self
        undoButton.action = #selector(undoButtonTapped)
        redoButton.target = self
        redoButton.action = #selector(redoButtonTapped)
        
        // Formatting
        boldButton.target = self
        boldButton.action = #selector(boldButtonTapped)
        italicButton.target = self
        italicButton.action = #selector(italicButtonTapped)
        underlineButton.target = self
        underlineButton.action = #selector(underlineButtonTapped)
        
        // Alignment
        leftAlignButton.target = self
        leftAlignButton.action = #selector(leftAlignButtonTapped)
        centerAlignButton.target = self
        centerAlignButton.action = #selector(centerAlignButtonTapped)
        rightAlignButton.target = self
        rightAlignButton.action = #selector(rightAlignButtonTapped)
        justifyButton.target = self
        justifyButton.action = #selector(justifyButtonTapped)
        
        // Lists
        bulletListButton.target = self
        bulletListButton.action = #selector(bulletListButtonTapped)
        numberedListButton.target = self
        numberedListButton.action = #selector(numberedListButtonTapped)
        
        // Colors
        textColorButton.target = self
        textColorButton.action = #selector(textColorButtonTapped)
        backgroundColorButton.target = self
        backgroundColorButton.action = #selector(backgroundColorButtonTapped)
        
        // Insert
        insertImageButton.target = self
        insertImageButton.action = #selector(insertImageButtonTapped)
        insertTableButton.target = self
        insertTableButton.action = #selector(insertTableButtonTapped)
        insertLinkButton.target = self
        insertLinkButton.action = #selector(insertLinkButtonTapped)
        
        // Zoom
        zoomInButton.target = self
        zoomInButton.action = #selector(zoomInButtonTapped)
        zoomOutButton.target = self
        zoomOutButton.action = #selector(zoomOutButtonTapped)
    }
    
    private func setupComboBoxes() {
        // Font size
        fontSizeComboBox.addItems(withObjectValues: [8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 36, 48, 72])
        fontSizeComboBox.selectItem(at: 6) // 16pt
        fontSizeComboBox.target = self
        fontSizeComboBox.action = #selector(fontSizeChanged)
        
        // Font family
        fontFamilyComboBox.addItems(withObjectValues: ["Arial", "Calibri", "Times New Roman", "Courier New", "Georgia", "Verdana", "Tahoma"])
        fontFamilyComboBox.selectItem(at: 0) // Arial
        fontFamilyComboBox.target = self
        fontFamilyComboBox.action = #selector(fontFamilyChanged)
    }
    
    private func setupMenu() {
        // File menu
        let fileMenu = NSMenu(title: "File")
        fileMenu.addItem(NSMenuItem(title: "New", action: #selector(newDocument), keyEquivalent: "n"))
        fileMenu.addItem(NSMenuItem(title: "Open", action: #selector(openDocument), keyEquivalent: "o"))
        fileMenu.addItem(NSMenuItem(title: "Save", action: #selector(saveDocument), keyEquivalent: "s"))
        fileMenu.addItem(NSMenuItem(title: "Save As", action: #selector(saveAsDocument), keyEquivalent: "S"))
        fileMenu.addItem(NSMenuItem.separator())
        
        let exportMenu = NSMenu(title: "Export")
        exportMenu.addItem(NSMenuItem(title: "PDF", action: #selector(exportPDF), keyEquivalent: ""))
        exportMenu.addItem(NSMenuItem(title: "Word Document", action: #selector(exportWord), keyEquivalent: ""))
        exportMenu.addItem(NSMenuItem(title: "HTML", action: #selector(exportHTML), keyEquivalent: ""))
        let exportMenuItem = NSMenuItem(title: "Export", action: nil, keyEquivalent: "")
        exportMenuItem.submenu = exportMenu
        fileMenu.addItem(exportMenuItem)
        
        // Edit menu
        let editMenu = NSMenu(title: "Edit")
        editMenu.addItem(NSMenuItem(title: "Undo", action: #selector(undoButtonTapped), keyEquivalent: "z"))
        editMenu.addItem(NSMenuItem(title: "Redo", action: #selector(redoButtonTapped), keyEquivalent: "Z"))
        editMenu.addItem(NSMenuItem.separator())
        editMenu.addItem(NSMenuItem(title: "Cut", action: #selector(cut), keyEquivalent: "x"))
        editMenu.addItem(NSMenuItem(title: "Copy", action: #selector(copy), keyEquivalent: "c"))
        editMenu.addItem(NSMenuItem(title: "Paste", action: #selector(paste), keyEquivalent: "v"))
        
        // Format menu
        let formatMenu = NSMenu(title: "Format")
        formatMenu.addItem(NSMenuItem(title: "Font", action: #selector(showFontPanel), keyEquivalent: "t"))
        formatMenu.addItem(NSMenuItem(title: "Paragraph", action: #selector(showParagraphPanel), keyEquivalent: ""))
        formatMenu.addItem(NSMenuItem(title: "Styles", action: #selector(showStylesPanel), keyEquivalent: ""))
        
        // Insert menu
        let insertMenu = NSMenu(title: "Insert")
        insertMenu.addItem(NSMenuItem(title: "Image", action: #selector(insertImageButtonTapped), keyEquivalent: ""))
        insertMenu.addItem(NSMenuItem(title: "Table", action: #selector(insertTableButtonTapped), keyEquivalent: ""))
        insertMenu.addItem(NSMenuItem(title: "Link", action: #selector(insertLinkButtonTapped), keyEquivalent: ""))
        insertMenu.addItem(NSMenuItem(title: "List", action: #selector(insertListButtonTapped), keyEquivalent: ""))
        
        // View menu
        let viewMenu = NSMenu(title: "View")
        viewMenu.addItem(NSMenuItem(title: "Word Count", action: #selector(showWordCount), keyEquivalent: ""))
        viewMenu.addItem(NSMenuItem(title: "Zoom In", action: #selector(zoomInButtonTapped), keyEquivalent: "+"))
        viewMenu.addItem(NSMenuItem(title: "Zoom Out", action: #selector(zoomOutButtonTapped), keyEquivalent: "-"))
        viewMenu.addItem(NSMenuItem(title: "Reset Zoom", action: #selector(resetZoom), keyEquivalent: "0"))
    }
    
    // MARK: - Statistics
    private func updateStatistics() {
        guard !isUpdating else { return }
        
        let text = textView.string
        let words = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
        let characters = text.count
        let paragraphs = text.components(separatedBy: .newlines).count
        
        wordCountLabel.stringValue = "Words: \(words)"
        characterCountLabel.stringValue = "Characters: \(characters)"
        paragraphCountLabel.stringValue = "Paragraphs: \(paragraphs)"
    }
    
    private func updateButtonStates() {
        let selectedRange = textView.selectedRange()
        let textStorage = textView.textStorage!
        
        if selectedRange.length > 0 {
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            
            // Bold
            if let font = attributes[.font] as? NSFont {
                boldButton.state = font.fontDescriptor.symbolicTraits.contains(.bold) ? .on : .off
            }
            
            // Italic
            if let font = attributes[.font] as? NSFont {
                italicButton.state = font.fontDescriptor.symbolicTraits.contains(.italic) ? .on : .off
            }
            
            // Underline
            if let underline = attributes[.underlineStyle] as? Int {
                underlineButton.state = underline > 0 ? .on : .off
            }
        }
    }
    
    private func saveToUndoStack() {
        let text = textView.string
        undoStack.append(text)
        redoStack.removeAll()
        
        if undoStack.count > 50 {
            undoStack.removeFirst()
        }
    }
    
    // MARK: - Actions
    @objc private func undoButtonTapped() {
        if undoStack.count > 1 {
            redoStack.append(undoStack.removeLast())
            let text = undoStack.last ?? ""
            textView.string = text
            updateStatistics()
        }
    }
    
    @objc private func redoButtonTapped() {
        if !redoStack.isEmpty {
            let text = redoStack.removeLast()
            undoStack.append(text)
            textView.string = text
            updateStatistics()
        }
    }
    
    @objc private func boldButtonTapped() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0 {
            let textStorage = textView.textStorage!
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            let font = attributes[.font] as? NSFont ?? NSFont.systemFont(ofSize: 16)
            
            let newFont: NSFont
            if font.fontDescriptor.symbolicTraits.contains(.bold) {
                newFont = NSFontManager.shared.convert(font, toNotHaveTrait: .boldFontMask)
            } else {
                newFont = NSFontManager.shared.convert(font, toHaveTrait: .boldFontMask)
            }
            
            textStorage.addAttribute(.font, value: newFont, range: selectedRange)
        }
    }
    
    @objc private func italicButtonTapped() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0 {
            let textStorage = textView.textStorage!
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            let font = attributes[.font] as? NSFont ?? NSFont.systemFont(ofSize: 16)
            
            let newFont: NSFont
            if font.fontDescriptor.symbolicTraits.contains(.italic) {
                newFont = NSFontManager.shared.convert(font, toNotHaveTrait: .italicFontMask)
            } else {
                newFont = NSFontManager.shared.convert(font, toHaveTrait: .italicFontMask)
            }
            
            textStorage.addAttribute(.font, value: newFont, range: selectedRange)
        }
    }
    
    @objc private func underlineButtonTapped() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0 {
            let textStorage = textView.textStorage!
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            let underline = attributes[.underlineStyle] as? Int ?? 0
            
            if underline > 0 {
                textStorage.removeAttribute(.underlineStyle, range: selectedRange)
            } else {
                textStorage.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: selectedRange)
            }
        }
    }
    
    @objc private func leftAlignButtonTapped() {
        setAlignment(.left)
    }
    
    @objc private func centerAlignButtonTapped() {
        setAlignment(.center)
    }
    
    @objc private func rightAlignButtonTapped() {
        setAlignment(.right)
    }
    
    @objc private func justifyButtonTapped() {
        setAlignment(.justified)
    }
    
    private func setAlignment(_ alignment: NSTextAlignment) {
        let selectedRange = textView.selectedRange()
        let textStorage = textView.textStorage!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        textStorage.addAttribute(.paragraphStyle, value: paragraphStyle, range: selectedRange)
    }
    
    @objc private func bulletListButtonTapped() {
        toggleListStyle(.bullet)
    }
    
    @objc private func numberedListButtonTapped() {
        toggleListStyle(.decimal)
    }
    
    private func toggleListStyle(_ markerType: NSTextList.MarkerFormat) {
        let selectedRange = textView.selectedRange()
        let textStorage = textView.textStorage!
        
        let paragraphStyle = NSMutableParagraphStyle()
        let textList = NSTextList(markerFormat: markerType, options: 0)
        paragraphStyle.textLists = [textList]
        
        textStorage.addAttribute(.paragraphStyle, value: paragraphStyle, range: selectedRange)
    }
    
    @objc private func textColorButtonTapped() {
        let colorPanel = NSColorPanel.shared
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(textColorChanged))
        colorPanel.makeKeyAndOrderFront(nil)
    }
    
    @objc private func backgroundColorButtonTapped() {
        let colorPanel = NSColorPanel.shared
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(backgroundColorChanged))
        colorPanel.makeKeyAndOrderFront(nil)
    }
    
    @objc private func textColorChanged() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0 {
            let textStorage = textView.textStorage!
            textStorage.addAttribute(.foregroundColor, value: NSColorPanel.shared.color, range: selectedRange)
        }
    }
    
    @objc private func backgroundColorChanged() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0 {
            let textStorage = textView.textStorage!
            textStorage.addAttribute(.backgroundColor, value: NSColorPanel.shared.color, range: selectedRange)
        }
    }
    
    @objc private func insertImageButtonTapped() {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["png", "jpg", "jpeg", "gif", "bmp"]
        openPanel.allowsMultipleSelection = false
        
        openPanel.begin { response in
            if response == .OK, let url = openPanel.url {
                let selectedRange = self.textView.selectedRange()
                let textStorage = self.textView.textStorage!
                textStorage.replaceCharacters(in: selectedRange, with: "[Image: \(url.lastPathComponent)]")
            }
        }
    }
    
    @objc private func insertTableButtonTapped() {
        let selectedRange = textView.selectedRange()
        let textStorage = textView.textStorage!
        textStorage.replaceCharacters(in: selectedRange, with: "\n[Table placeholder - 3x3]\n")
    }
    
    @objc private func insertLinkButtonTapped() {
        let alert = NSAlert()
        alert.messageText = "Insert Link"
        alert.informativeText = "Enter link text and URL:"
        
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        textField.placeholderString = "Link text"
        alert.accessoryView = textField
        
        let urlField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        urlField.placeholderString = "URL"
        alert.accessoryView = urlField
        
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        if alert.runModal() == .alertFirstButtonReturn {
            let linkText = textField.stringValue
            let url = urlField.stringValue
            let selectedRange = textView.selectedRange()
            let textStorage = textView.textStorage!
            textStorage.replaceCharacters(in: selectedRange, with: "[\(linkText)](\(url))")
        }
    }
    
    @objc private func insertListButtonTapped() {
        let selectedRange = textView.selectedRange()
        let textStorage = textView.textStorage!
        textStorage.replaceCharacters(in: selectedRange, with: "\n• List item\n")
    }
    
    @objc private func fontSizeChanged() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0, let fontSize = fontSizeComboBox.objectValueOfSelectedItem as? Int {
            let textStorage = textView.textStorage!
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            let font = attributes[.font] as? NSFont ?? NSFont.systemFont(ofSize: 16)
            let newFont = NSFontManager.shared.convert(font, toSize: CGFloat(fontSize))
            textStorage.addAttribute(.font, value: newFont, range: selectedRange)
        }
    }
    
    @objc private func fontFamilyChanged() {
        let selectedRange = textView.selectedRange()
        if selectedRange.length > 0, let fontFamily = fontFamilyComboBox.stringValue as String? {
            let textStorage = textView.textStorage!
            let attributes = textStorage.attributes(at: selectedRange.location, effectiveRange: nil)
            let font = attributes[.font] as? NSFont ?? NSFont.systemFont(ofSize: 16)
            let newFont = NSFont(name: fontFamily, size: font.pointSize) ?? font
            textStorage.addAttribute(.font, value: newFont, range: selectedRange)
        }
    }
    
    @objc private func zoomInButtonTapped() {
        currentZoom = min(currentZoom + 10, 200)
        updateZoom()
    }
    
    @objc private func zoomOutButtonTapped() {
        currentZoom = max(currentZoom - 10, 50)
        updateZoom()
    }
    
    @objc private func resetZoom() {
        currentZoom = 100
        updateZoom()
    }
    
    private func updateZoom() {
        zoomLabel.stringValue = "\(Int(currentZoom))%"
        textView.scaleUnitSquare(to: NSSize(width: currentZoom / 100, height: currentZoom / 100))
    }
    
    // MARK: - Menu Actions
    @objc private func newDocument() {
        textView.string = ""
        undoStack.removeAll()
        redoStack.removeAll()
        updateStatistics()
    }
    
    @objc private func openDocument() {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["rtf", "txt"]
        openPanel.allowsMultipleSelection = false
        
        openPanel.begin { response in
            if response == .OK, let url = openPanel.url {
                do {
                    let content = try String(contentsOf: url)
                    self.textView.string = content
                    self.updateStatistics()
                } catch {
                    let alert = NSAlert(error: error)
                    alert.runModal()
                }
            }
        }
    }
    
    @objc private func saveDocument() {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["rtf", "txt"]
        savePanel.nameFieldStringValue = "Document"
        
        savePanel.begin { response in
            if response == .OK, let url = savePanel.url {
                do {
                    try self.textView.string.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    let alert = NSAlert(error: error)
                    alert.runModal()
                }
            }
        }
    }
    
    @objc private func saveAsDocument() {
        saveDocument()
    }
    
    @objc private func exportPDF() {
        let alert = NSAlert()
        alert.messageText = "Export PDF"
        alert.informativeText = "PDF export functionality would be implemented here."
        alert.runModal()
    }
    
    @objc private func exportWord() {
        let alert = NSAlert()
        alert.messageText = "Export Word"
        alert.informativeText = "Word export functionality would be implemented here."
        alert.runModal()
    }
    
    @objc private func exportHTML() {
        let alert = NSAlert()
        alert.messageText = "Export HTML"
        alert.informativeText = "HTML export functionality would be implemented here."
        alert.runModal()
    }
    
    @objc private func cut() {
        textView.cut(nil)
    }
    
    @objc private func copy() {
        textView.copy(nil)
    }
    
    @objc private func paste() {
        textView.paste(nil)
    }
    
    @objc private func showFontPanel() {
        NSFontManager.shared.orderFrontFontPanel(nil)
    }
    
    @objc private func showParagraphPanel() {
        let alert = NSAlert()
        alert.messageText = "Paragraph"
        alert.informativeText = "Paragraph dialog would be implemented here."
        alert.runModal()
    }
    
    @objc private func showStylesPanel() {
        let alert = NSAlert()
        alert.messageText = "Styles"
        alert.informativeText = "Styles dialog would be implemented here."
        alert.runModal()
    }
    
    @objc private func showWordCount() {
        let alert = NSAlert()
        alert.messageText = "Document Statistics"
        alert.informativeText = "\(wordCountLabel.stringValue)\n\(characterCountLabel.stringValue)\n\(paragraphCountLabel.stringValue)"
        alert.runModal()
    }
}

// MARK: - NSTextViewDelegate
extension RichTextEditor: NSTextViewDelegate {
    func textDidChange(_ notification: Notification) {
        if !isUpdating {
            saveToUndoStack()
            updateStatistics()
        }
    }
    
    func textViewDidChangeSelection(_ notification: Notification) {
        updateButtonStates()
        
        // Update position in status bar
        let selectedRange = textView.selectedRange()
        positionLabel.stringValue = "Position: \(selectedRange.location)"
    }
}
