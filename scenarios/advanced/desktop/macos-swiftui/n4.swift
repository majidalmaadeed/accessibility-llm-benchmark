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
            > 50 {
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
        