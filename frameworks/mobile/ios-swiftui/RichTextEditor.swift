import SwiftUI

struct RichTextEditor: View {
    @State private var text: String = ""
    @State private var selectedRange: NSRange = NSRange(location: 0, length: 0)
    @State private var isBold: Bool = false
    @State private var isItalic: Bool = false
    @State private var isUnderline: Bool = false
    @State private var fontSize: CGFloat = 16
    @State private var textColor: Color = .primary
    @State private var backgroundColor: Color = .clear
    @State private var alignment: TextAlignment = .leading
    @State private var showStylePanel: Bool = false
    @State private var showMediaPicker: Bool = false
    @State private var showLinkDialog: Bool = false
    @State private var linkURL: String = ""
    @State private var linkText: String = ""
    @State private var wordCount: Int = 0
    @State private var characterCount: Int = 0
    @State private var undoStack: [String] = []
    @State private var redoStack: [String] = []
    @State private var canUndo: Bool = false
    @State private var canRedo: Bool = false
    
    let fontSizes: [CGFloat] = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48]
    let textColors: [Color] = [.primary, .red, .blue, .green, .orange, .purple, .pink, .brown]
    let backgroundColors: [Color] = [.clear, .yellow, .green, .blue, .red, .orange, .purple, .gray]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                toolbarView
                
                if showStylePanel {
                    stylePanelView
                }
                
                editorView
                
                statusBarView
            }
            .navigationTitle("Rich Text Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Save document
                    }
                }
            }
        }
        .sheet(isPresented: $showMediaPicker) {
            MediaPickerView { mediaType in
                insertMedia(mediaType)
            }
        }
        .alert("Insert Link", isPresented: $showLinkDialog) {
            TextField("Link Text", text: $linkText)
            TextField("URL", text: $linkURL)
            Button("Insert") {
                insertLink()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    private var toolbarView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Button(action: { undo() }) {
                    Image(systemName: "arrow.uturn.backward")
                }
                .buttonStyle(.bordered)
                .disabled(!canUndo)
                
                Button(action: { redo() }) {
                    Image(systemName: "arrow.uturn.forward")
                }
                .buttonStyle(.bordered)
                .disabled(!canRedo)
                
                Divider()
                
                Button(action: { toggleBold() }) {
                    Image(systemName: "bold")
                }
                .buttonStyle(.bordered)
                .foregroundColor(isBold ? .blue : .primary)
                
                Button(action: { toggleItalic() }) {
                    Image(systemName: "italic")
                }
                .buttonStyle(.bordered)
                .foregroundColor(isItalic ? .blue : .primary)
                
                Button(action: { toggleUnderline() }) {
                    Image(systemName: "underline")
                }
                .buttonStyle(.bordered)
                .foregroundColor(isUnderline ? .blue : .primary)
                
                Divider()
                
                Button(action: { showStylePanel.toggle() }) {
                    Image(systemName: "textformat")
                }
                .buttonStyle(.bordered)
                .foregroundColor(showStylePanel ? .blue : .primary)
                
                Button(action: { showMediaPicker = true }) {
                    Image(systemName: "photo")
                }
                .buttonStyle(.bordered)
                
                Button(action: { showLinkDialog = true }) {
                    Image(systemName: "link")
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(Color(.systemGray6))
            
            HStack(spacing: 16) {
                Button(action: { setAlignment(.leading) }) {
                    Image(systemName: "text.alignleft")
                }
                .buttonStyle(.bordered)
                .foregroundColor(alignment == .leading ? .blue : .primary)
                
                Button(action: { setAlignment(.center) }) {
                    Image(systemName: "text.aligncenter")
                }
                .buttonStyle(.bordered)
                .foregroundColor(alignment == .center ? .blue : .primary)
                
                Button(action: { setAlignment(.trailing) }) {
                    Image(systemName: "text.alignright")
                }
                .buttonStyle(.bordered)
                .foregroundColor(alignment == .trailing ? .blue : .primary)
                
                Divider()
                
                Button(action: { insertBulletList() }) {
                    Image(systemName: "list.bullet")
                }
                .buttonStyle(.bordered)
                
                Button(action: { insertNumberedList() }) {
                    Image(systemName: "list.number")
                }
                .buttonStyle(.bordered)
                
                Button(action: { insertQuote() }) {
                    Image(systemName: "quote.bubble")
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(Color(.systemGray6))
        }
    }
    
    private var stylePanelView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Font Size")
                    .font(.headline)
                
                Spacer()
                
                Picker("Font Size", selection: $fontSize) {
                    ForEach(fontSizes, id: \.self) { size in
                        Text("\(Int(size))").tag(size)
                    }
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Text Color")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 8), spacing: 8) {
                    ForEach(textColors, id: \.self) { color in
                        Button(action: { textColor = color }) {
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(textColor == color ? Color.blue : Color.clear, lineWidth: 3)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Background Color")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 8), spacing: 8) {
                    ForEach(backgroundColors, id: \.self) { color in
                        Button(action: { backgroundColor = color }) {
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(backgroundColor == color ? Color.blue : Color.clear, lineWidth: 3)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var editorView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $text)
                    .font(.system(size: fontSize))
                    .foregroundColor(textColor)
                    .background(backgroundColor)
                    .multilineTextAlignment(alignment)
                    .onChange(of: text) { newValue in
                        updateCounts()
                        saveToUndoStack()
                    }
                    .onTapGesture { location in
                        handleTextSelection(at: location)
                    }
                    .frame(minHeight: 400)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            }
            .padding()
        }
    }
    
    private var statusBarView: some View {
        HStack {
            Text("Words: \(wordCount)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("Characters: \(characterCount)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("Font: \(Int(fontSize))pt")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // MARK: - Methods
    
    private func toggleBold() {
        isBold.toggle()
        applyFormatting()
    }
    
    private func toggleItalic() {
        isItalic.toggle()
        applyFormatting()
    }
    
    private func toggleUnderline() {
        isUnderline.toggle()
        applyFormatting()
    }
    
    private func setAlignment(_ newAlignment: TextAlignment) {
        alignment = newAlignment
    }
    
    private func insertBulletList() {
        let bulletText = "• "
        insertText(bulletText)
    }
    
    private func insertNumberedList() {
        let numberedText = "1. "
        insertText(numberedText)
    }
    
    private func insertQuote() {
        let quoteText = "\"\""
        insertText(quoteText)
    }
    
    private func insertMedia(_ mediaType: MediaType) {
        let mediaText = "[\(mediaType.rawValue.capitalized)]"
        insertText(mediaText)
    }
    
    private func insertLink() {
        let linkText = "[\(linkText)](\(linkURL))"
        insertText(linkText)
        linkText = ""
        linkURL = ""
    }
    
    private func insertText(_ textToInsert: String) {
        let newText = text + textToInsert
        text = newText
        updateCounts()
        saveToUndoStack()
    }
    
    private func applyFormatting() {
        // Apply formatting to selected text
        updateCounts()
        saveToUndoStack()
    }
    
    private func handleTextSelection(at location: CGPoint) {
        // Handle text selection and cursor position
    }
    
    private func updateCounts() {
        wordCount = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
        characterCount = text.count
    }
    
    private func saveToUndoStack() {
        undoStack.append(text)
        if undoStack.count > 50 {
            undoStack.removeFirst()
        }
        canUndo = undoStack.count > 1
    }
    
    private func undo() {
        guard undoStack.count > 1 else { return }
        
        let currentText = undoStack.removeLast()
        redoStack.append(currentText)
        
        if let previousText = undoStack.last {
            text = previousText
            updateCounts()
        }
        
        canUndo = undoStack.count > 1
        canRedo = !redoStack.isEmpty
    }
    
    private func redo() {
        guard !redoStack.isEmpty else { return }
        
        let textToRedo = redoStack.removeLast()
        undoStack.append(textToRedo)
        text = textToRedo
        updateCounts()
        
        canUndo = undoStack.count > 1
        canRedo = !redoStack.isEmpty
    }
}

struct MediaPickerView: View {
    let onSelect: (MediaType) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Insert Media")
                    .font(.title2)
                    .fontWeight(.bold)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ForEach(MediaType.allCases, id: \.self) { mediaType in
                        Button(action: {
                            onSelect(mediaType)
                            dismiss()
                        }) {
                            VStack(spacing: 12) {
                                Image(systemName: mediaType.icon)
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                                
                                Text(mediaType.rawValue.capitalized)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Media")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Types

enum MediaType: String, CaseIterable {
    case image = "image"
    case video = "video"
    case audio = "audio"
    case file = "file"
    
    var icon: String {
        switch self {
        case .image: return "photo"
        case .video: return "video"
        case .audio: return "music.note"
        case .file: return "doc"
        }
    }
}

struct RichTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        RichTextEditor()
    }
}
