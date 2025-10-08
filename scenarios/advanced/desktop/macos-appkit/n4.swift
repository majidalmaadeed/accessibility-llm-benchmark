import Cocoa

class RichTextEditor: NSViewController {
    
    > 0 {
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
