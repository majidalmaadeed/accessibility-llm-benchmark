import SwiftUI
import AppKit

struct RichTextEditor: View {
    @State private var text = ""
    @State private var selectedRange: NSRange = NSRange(location: 0, length: 0)
    @State private var fontSize: CGFloat = 16
    @State private var fontFamily = "Arial"
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderlined = false
    @State private var textColor = Color.primary
    @State private var backgroundColor = Color.clear
    @State private var alignment: NSTextAlignment = .left
    @State private var wordCount = 0
    @State private var characterCount = 0
    @State private var paragraphCount = 0
    @State private var currentZoom: CGFloat = 100
    @State private var showingFontPanel = false
    @State private var showingColorPanel = false
    @State private var showingExportOptions = false
    @State private var undoStack: [String] = []
    @State private var redoStack: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            toolbarView
            
            // Main Content
            HStack(spacing: 0) {
                // Editor
                editorView
                
                // Side Panel
                sidePanelView
            }
            
            // Status Bar
            statusBarView
        }
        .onAppear {
            updateStatistics()
        }
        .onChange(of: text) { _ in
            updateStatistics()
            saveToUndoStack()
        }
    }
    
    private var toolbarView: some View {
        HStack(spacing: 12) {
            // File Operations
            Group {
                Button("New") { newDocument() }
                Button("Open") { openDocument() }
                Button("Save") { saveDocument() }
                Button("Save As") { saveAsDocument() }
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Undo/Redo
            Group {
                Button("↶") { undo() }
                    .disabled(undoStack.count <= 1)
                Button("↷") { redo() }
                    .disabled(redoStack.isEmpty)
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Formatting
            Group {
                Button("B") { toggleBold() }
                    .fontWeight(.bold)
                    .background(isBold ? Color.accentColor.opacity(0.3) : Color.clear)
                
                Button("I") { toggleItalic() }
                    .italic()
                    .background(isItalic ? Color.accentColor.opacity(0.3) : Color.clear)
                
                Button("U") { toggleUnderline() }
                    .underline()
                    .background(isUnderlined ? Color.accentColor.opacity(0.3) : Color.clear)
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Font Controls
            Group {
                Picker("Font Size", selection: $fontSize) {
                    ForEach([8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 36, 48, 72], id: \.self) { size in
                        Text("\(size)").tag(CGFloat(size))
                    }
                }
                .frame(width: 80)
                
                Picker("Font Family", selection: $fontFamily) {
                    ForEach(["Arial", "Calibri", "Times New Roman", "Courier New", "Georgia", "Verdana", "Tahoma"], id: \.self) { family in
                        Text(family).tag(family)
                    }
                }
                .frame(width: 120)
            }
            
            Divider()
            
            // Colors
            Group {
                Button("A") { showingColorPanel = true }
                    .foregroundColor(textColor)
                
                Button("🖍") { showingColorPanel = true }
                    .background(backgroundColor)
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Alignment
            Group {
                Button("⬅") { alignment = .left }
                    .background(alignment == .left ? Color.accentColor.opacity(0.3) : Color.clear)
                
                Button("⬆") { alignment = .center }
                    .background(alignment == .center ? Color.accentColor.opacity(0.3) : Color.clear)
                
                Button("➡") { alignment = .right }
                    .background(alignment == .right ? Color.accentColor.opacity(0.3) : Color.clear)
                
                Button("⬌") { alignment = .justified }
                    .background(alignment == .justified ? Color.accentColor.opacity(0.3) : Color.clear)
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Lists
            Group {
                Button("•") { insertBulletList() }
                Button("1.") { insertNumberedList() }
            }
            .buttonStyle(.bordered)
            
            Divider()
            
            // Insert
            Group {
                Button("🖼") { insertImage() }
                Button("⊞") { insertTable() }
                Button("🔗") { insertLink() }
            }
            .buttonStyle(.bordered)
            
            Spacer()
            
            // Zoom
            Group {
                Button("-") { zoomOut() }
                Text("\(Int(currentZoom))%")
                    .frame(width: 40)
                Button("+") { zoomIn() }
            }
            .buttonStyle(.bordered)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    private var editorView: some View {
        VStack(spacing: 0) {
            // Quick Styles
            quickStylesView
            
            // Text Editor
            TextEditor(text: $text)
                .font(.custom(fontFamily, size: fontSize))
                .foregroundColor(textColor)
                .background(backgroundColor)
                .padding(16)
                .scaleEffect(currentZoom / 100)
        }
    }
    
    private var quickStylesView: some View {
        HStack(spacing: 8) {
            Text("Quick Styles")
                .font(.headline)
                .padding(.leading, 16)
            
            Button("Heading 1") { applyHeadingStyle(size: 24, weight: .bold) }
            Button("Heading 2") { applyHeadingStyle(size: 20, weight: .bold) }
            Button("Heading 3") { applyHeadingStyle(size: 18, weight: .bold) }
            Button("Normal") { applyHeadingStyle(size: 16, weight: .regular) }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    private var sidePanelView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Document Statistics
            statisticsView
            
            // Recent Files
            recentFilesView
            
            // Zoom Control
            zoomControlView
        }
        .frame(width: 250)
        .padding(16)
        .background(Color(.controlBackgroundColor))
    }
    
    private var statisticsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Document Statistics")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Words: \(wordCount)")
            Text("Characters: \(characterCount)")
            Text("Paragraphs: \(paragraphCount)")
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var recentFilesView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Files")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 4) {
                Button("Document1.docx") { }
                Button("Report.docx") { }
                Button("Notes.docx") { }
            }
            .buttonStyle(.plain)
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var zoomControlView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Zoom")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack {
                Button("-") { zoomOut() }
                Text("\(Int(currentZoom))%")
                    .frame(maxWidth: .infinity)
                Button("+") { zoomIn() }
            }
        }
        .padding(12)
        .background(Color(.windowBackgroundColor))
        .cornerRadius(8)
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Ready")
            
            Spacer()
            
            Text("Position: \(selectedRange.location)")
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.controlBackgroundColor))
    }
    
    // MARK: - Methods
    private func updateStatistics() {
        let words = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
        let characters = text.count
        let paragraphs = text.components(separatedBy: .newlines).count
        
        wordCount = words
        characterCount = characters
        paragraphCount = paragraphs
    }
    
    private func saveToUndoStack() {
        undoStack.append(text)
        redoStack.removeAll()
        
        if undoStack.count > 50 {
            undoStack.removeFirst()
        }
    }
    
    private func undo() {
        guard undoStack.count > 1 else { return }
        redoStack.append(undoStack.removeLast())
        text = undoStack.last ?? ""
    }
    
    private func redo() {
        guard !redoStack.isEmpty else { return }
        let textToRestore = redoStack.removeLast()
        undoStack.append(textToRestore)
        text = textToRestore
    }
    
    private func toggleBold() {
        isBold.toggle()
        // In a real implementation, this would apply bold formatting to selected text
    }
    
    private func toggleItalic() {
        isItalic.toggle()
        // In a real implementation, this would apply italic formatting to selected text
    }
    
    private func toggleUnderline() {
        isUnderlined.toggle()
        // In a real implementation, this would apply underline formatting to selected text
    }
    
    private func applyHeadingStyle(size: CGFloat, weight: Font.Weight) {
        fontSize = size
        // In a real implementation, this would apply the style to selected text
    }
    
    private func insertBulletList() {
        text += "\n• List item\n"
    }
    
    private func insertNumberedList() {
        text += "\n1. List item\n"
    }
    
    private func insertImage() {
        text += "\n[Image placeholder]\n"
    }
    
    private func insertTable() {
        text += "\n[Table placeholder - 3x3]\n"
    }
    
    private func insertLink() {
        text += "[Link text](URL)"
    }
    
    private func zoomIn() {
        currentZoom = min(currentZoom + 10, 200)
    }
    
    private func zoomOut() {
        currentZoom = max(currentZoom - 10, 50)
    }
    
    // MARK: - File Operations
    private func newDocument() {
        text = ""
        undoStack.removeAll()
        redoStack.removeAll()
    }
    
    private func openDocument() {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["rtf", "txt"]
        panel.allowsMultipleSelection = false
        
        if panel.runModal() == .OK, let url = panel.url {
            do {
                text = try String(contentsOf: url)
            } catch {
                print("Error opening file: \(error)")
            }
        }
    }
    
    private func saveDocument() {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["rtf", "txt"]
        panel.nameFieldStringValue = "Document"
        
        if panel.runModal() == .OK, let url = panel.url {
            do {
                try text.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                print("Error saving file: \(error)")
            }
        }
    }
    
    private func saveAsDocument() {
        saveDocument()
    }
}

// MARK: - Export Options View
struct ExportOptionsView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Export Options")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                Button("Export as PDF") {
                    exportPDF()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Export as Word Document") {
                    exportWord()
                }
                .buttonStyle(.bordered)
                
                Button("Export as HTML") {
                    exportHTML()
                }
                .buttonStyle(.bordered)
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
        }
        .padding(20)
        .frame(width: 300, height: 200)
    }
    
    private func exportPDF() {
        // PDF export implementation
        isPresented = false
    }
    
    private func exportWord() {
        // Word export implementation
        isPresented = false
    }
    
    private func exportHTML() {
        // HTML export implementation
        isPresented = false
    }
}

// MARK: - Font Panel View
struct FontPanelView: View {
    @Binding var isPresented: Bool
    @Binding var selectedFont: String
    @Binding var selectedSize: CGFloat
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Font")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Font Family")
                    .font(.headline)
                
                Picker("Font Family", selection: $selectedFont) {
                    ForEach(["Arial", "Calibri", "Times New Roman", "Courier New", "Georgia", "Verdana", "Tahoma"], id: \.self) { font in
                        Text(font).tag(font)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Font Size")
                    .font(.headline)
                
                HStack {
                    Slider(value: $selectedSize, in: 8...72, step: 1)
                    Text("\(Int(selectedSize))")
                        .frame(width: 30)
                }
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Button("Apply") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 300, height: 250)
    }
}

// MARK: - Color Panel View
struct ColorPanelView: View {
    @Binding var isPresented: Bool
    @Binding var selectedColor: Color
    let isTextColor: Bool
    
    private let colors: [Color] = [
        .black, .red, .green, .blue, .yellow, .orange, .purple, .gray
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isTextColor ? "Text Color" : "Background Color")
                .font(.title)
                .fontWeight(.bold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        isPresented = false
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(selectedColor == color ? Color.primary : Color.clear, lineWidth: 2)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
        }
        .padding(20)
        .frame(width: 200, height: 250)
    }
}

// MARK: - Preview
struct RichTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        RichTextEditor()
    }
}
