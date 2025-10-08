import SwiftUI

struct RichTextEditor: View {
    @State private var content = ""
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderline = false
    @State private var fontSize: CGFloat = 16
    @State private var textColor = Color.primary
    @State private var backgroundColor = Color(.systemBackground)
    @State private var alignment: TextAlignment = .leading
    @State private var showWordCount = false
    @State private var isUndoAvailable = false
    @State private var isRedoAvailable = false
    @State private var history: [String] = [""]
    @State private var historyIndex = 0
    @State private var showFontSizePicker = false
    @State private var showColorPicker = false
    @State private var showInsertMenu = false
    @State private var colorPickerType: ColorPickerType = .text
    
    enum TextAlignment: String, CaseIterable {
        case leading = "leading"
        case center = "center"
        case trailing = "trailing"
    }
    
    enum ColorPickerType {
        case text
        case background
    }
    
    private let fontSizes: [CGFloat] = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48]
    private let colors: [Color] = [
        .primary, .secondary, .red, .orange, .yellow, .green, .blue, .purple, .pink, .white
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Toolbar
                toolbarView
                
                // Word Count Panel
                if showWordCount {
                    wordCountPanel
                }
                
                // Editor
                editorView
            }
            .navigationTitle("Rich Text Editor")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSaveClicked()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Export") {
                        onExportClicked()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Stats") {
                        onStatsClicked()
                    }
                }
            }
            .sheet(isPresented: $showFontSizePicker) {
                FontSizePickerView(selectedSize: $fontSize, isPresented: $showFontSizePicker)
            }
            .sheet(isPresented: $showColorPicker) {
                ColorPickerView(
                    selectedColor: colorPickerType == .text ? $textColor : $backgroundColor,
                    colorType: colorPickerType,
                    isPresented: $showColorPicker
                )
            }
            .sheet(isPresented: $showInsertMenu) {
                InsertMenuView(isPresented: $showInsertMenu) { insertType in
                    onInsertItem(insertType)
                }
            }
            .onAppear {
                updateHistory()
            }
        }
    }
    
    private var toolbarView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                // Undo/Redo Group
                undoRedoGroup
                
                Divider()
                
                // Formatting Group
                formattingGroup
                
                Divider()
                
                // Font Size Group
                fontSizeGroup
                
                Divider()
                
                // Alignment Group
                alignmentGroup
                
                Divider()
                
                // Insert Group
                insertGroup
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
    }
    
    private var undoRedoGroup: some View {
        HStack(spacing: 8) {
            Button(action: onUndoClicked) {
                Image(systemName: "arrow.uturn.backward")
                    .font(.title2)
            }
            .disabled(!isUndoAvailable)
            .foregroundColor(isUndoAvailable ? .blue : .gray)
            
            Button(action: onRedoClicked) {
                Image(systemName: "arrow.uturn.forward")
                    .font(.title2)
            }
            .disabled(!isRedoAvailable)
            .foregroundColor(isRedoAvailable ? .blue : .gray)
        }
    }
    
    private var formattingGroup: some View {
        HStack(spacing: 8) {
            Button(action: onBoldClicked) {
                Image(systemName: "bold")
                    .font(.title2)
            }
            .foregroundColor(isBold ? .blue : .primary)
            .background(isBold ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(4)
            
            Button(action: onItalicClicked) {
                Image(systemName: "italic")
                    .font(.title2)
            }
            .foregroundColor(isItalic ? .blue : .primary)
            .background(isItalic ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(4)
            
            Button(action: onUnderlineClicked) {
                Image(systemName: "underline")
                    .font(.title2)
            }
            .foregroundColor(isUnderline ? .blue : .primary)
            .background(isUnderline ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(4)
        }
    }
    
    private var fontSizeGroup: some View {
        HStack(spacing: 8) {
            Button(action: { showFontSizePicker = true }) {
                Text("\(Int(fontSize))pt")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemGray5))
                    .cornerRadius(4)
            }
            
            Button(action: { 
                colorPickerType = .text
                showColorPicker = true 
            }) {
                Circle()
                    .fill(textColor)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
            
            Button(action: { 
                colorPickerType = .background
                showColorPicker = true 
            }) {
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
        }
    }
    
    private var alignmentGroup: some View {
        HStack(spacing: 8) {
            ForEach(TextAlignment.allCases, id: \.self) { align in
                Button(action: { alignment = align }) {
                    Image(systemName: alignmentIcon(for: align))
                        .font(.title2)
                }
                .foregroundColor(alignment == align ? .blue : .primary)
                .background(alignment == align ? Color.blue.opacity(0.1) : Color.clear)
                .cornerRadius(4)
            }
        }
    }
    
    private var insertGroup: some View {
        HStack(spacing: 8) {
            Button(action: { showInsertMenu = true }) {
                Image(systemName: "plus")
                    .font(.title2)
            }
            
            Button(action: onStatsClicked) {
                Image(systemName: "chart.bar")
                    .font(.title2)
            }
        }
    }
    
    private var wordCountPanel: some View {
        HStack {
            Spacer()
            Text("Words: \(wordCount) | Characters: \(charCount)")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
    }
    
    private var editorView: some View {
        TextEditor(text: $content)
            .font(.system(size: fontSize))
            .foregroundColor(textColor)
            .background(backgroundColor)
            .multilineTextAlignment(alignment)
            .padding()
            .onChange(of: content) { _ in
                onContentChanged()
            }
    }
    
    // MARK: - Computed Properties
    
    private var wordCount: Int {
        let words = content.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
        return words.count
    }
    
    private var charCount: Int {
        content.count
    }
    
    // MARK: - Helper Methods
    
    private func alignmentIcon(for alignment: TextAlignment) -> String {
        switch alignment {
        case .leading: return "text.alignleft"
        case .center: return "text.aligncenter"
        case .trailing: return "text.alignright"
        }
    }
    
    private func updateHistory() {
        let newHistory = Array(history.prefix(historyIndex + 1))
        newHistory.append(content)
        history = newHistory
        historyIndex = newHistory.count - 1
        isUndoAvailable = historyIndex > 0
        isRedoAvailable = historyIndex < newHistory.count - 1
    }
    
    private func onContentChanged() {
        updateHistory()
    }
    
    // MARK: - Actions
    
    private func onSaveClicked() {
        // Handle save
        print("Save clicked")
    }
    
    private func onExportClicked() {
        // Handle export
        print("Export clicked")
    }
    
    private func onStatsClicked() {
        showWordCount.toggle()
    }
    
    private func onUndoClicked() {
        if historyIndex > 0 {
            historyIndex -= 1
            content = history[historyIndex]
            isUndoAvailable = historyIndex > 0
            isRedoAvailable = true
        }
    }
    
    private func onRedoClicked() {
        if historyIndex < history.count - 1 {
            historyIndex += 1
            content = history[historyIndex]
            isUndoAvailable = true
            isRedoAvailable = historyIndex < history.count - 1
        }
    }
    
    private func onBoldClicked() {
        isBold.toggle()
        // In a real implementation, this would apply bold formatting to selected text
    }
    
    private func onItalicClicked() {
        isItalic.toggle()
        // In a real implementation, this would apply italic formatting to selected text
    }
    
    private func onUnderlineClicked() {
        isUnderline.toggle()
        // In a real implementation, this would apply underline formatting to selected text
    }
    
    private func onInsertItem(_ type: InsertType) {
        switch type {
        case .image:
            content += "\n[Image placeholder]\n"
        case .link:
            content += "\n[Link placeholder]\n"
        case .table:
            content += "\n[Table placeholder]\n"
        case .list:
            content += "\n• List item\n"
        }
        updateHistory()
    }
}

// MARK: - Supporting Views

struct FontSizePickerView: View {
    @Binding var selectedSize: CGFloat
    @Binding var isPresented: Bool
    
    private let fontSizes: [CGFloat] = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fontSizes, id: \.self) { size in
                    Button(action: {
                        selectedSize = size
                        isPresented = false
                    }) {
                        HStack {
                            Text("\(Int(size))pt")
                                .font(.system(size: size))
                            Spacer()
                            if selectedSize == size {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("Font Size")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    let colorType: ColorPickerType
    @Binding var isPresented: Bool
    
    private let colors: [Color] = [
        .primary, .secondary, .red, .orange, .yellow, .green, .blue, .purple, .pink, .white
    ]
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 16) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        isPresented = false
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle()
                                    .stroke(Color(.systemGray4), lineWidth: 2)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 3)
                                    .opacity(selectedColor == color ? 1 : 0)
                            )
                    }
                }
            }
            .padding()
            .navigationTitle(colorType == .text ? "Text Color" : "Background Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct InsertMenuView: View {
    @Binding var isPresented: Bool
    let onInsert: (InsertType) -> Void
    
    enum InsertType {
        case image
        case link
        case table
        case list
    }
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                InsertMenuItem(
                    icon: "photo",
                    title: "Image",
                    action: { onInsert(.image); isPresented = false }
                )
                
                InsertMenuItem(
                    icon: "link",
                    title: "Link",
                    action: { onInsert(.link); isPresented = false }
                )
                
                InsertMenuItem(
                    icon: "table",
                    title: "Table",
                    action: { onInsert(.table); isPresented = false }
                )
                
                InsertMenuItem(
                    icon: "list.bullet",
                    title: "List",
                    action: { onInsert(.list); isPresented = false }
                )
            }
            .padding()
            .navigationTitle("Insert")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct InsertMenuItem: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RichTextEditor()
}