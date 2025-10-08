#!/usr/bin/env python3

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QTextEdit, QPushButton, QComboBox,
                             QLabel, QSpinBox, QColorDialog, QFontDialog,
                             QFileDialog, QMessageBox, QFrame, QSplitter,
                             QListWidget, QListWidgetItem, QSlider, QGroupBox,
                             QToolBar, QAction, QMenuBar, QStatusBar)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont, QTextCharFormat, QTextCursor, QTextListFormat, QColor, QIcon
from PyQt5.QtPrintSupport import QPrintDialog, QPrinter

class RichTextEditor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Rich Text Editor")
        self.setGeometry(100, 100, 1200, 800)
        
        # Data
        self.current_file = None
        self.undo_stack = []
        self.redo_stack = []
        self.current_zoom = 100
        self.is_bold = False
        self.is_italic = False
        self.is_underlined = False
        self.font_size = 16
        self.font_family = "Arial"
        self.text_color = QColor(0, 0, 0)
        self.bg_color = QColor(255, 255, 255)
        self.alignment = Qt.AlignLeft
        
        # Create UI
        self.create_ui()
        
        # Update statistics
        self.update_statistics()
    
    def create_ui(self):
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QHBoxLayout()
        central_widget.setLayout(main_layout)
        
        # Create menu bar
        self.create_menu_bar()
        
        # Create toolbar
        self.create_toolbar()
        
        # Create splitter for main content
        splitter = QSplitter(Qt.Horizontal)
        main_layout.addWidget(splitter)
        
        # Text editor
        self.create_text_editor(splitter)
        
        # Side panel
        self.create_side_panel(splitter)
        
        # Status bar
        self.create_status_bar()
    
    def create_menu_bar(self):
        menubar = self.menuBar()
        
        # File menu
        file_menu = menubar.addMenu('File')
        
        new_action = QAction('New', self)
        new_action.setShortcut('Ctrl+N')
        new_action.triggered.connect(self.new_document)
        file_menu.addAction(new_action)
        
        open_action = QAction('Open', self)
        open_action.setShortcut('Ctrl+O')
        open_action.triggered.connect(self.open_document)
        file_menu.addAction(open_action)
        
        save_action = QAction('Save', self)
        save_action.setShortcut('Ctrl+S')
        save_action.triggered.connect(self.save_document)
        file_menu.addAction(save_action)
        
        save_as_action = QAction('Save As', self)
        save_as_action.setShortcut('Ctrl+Shift+S')
        save_as_action.triggered.connect(self.save_as_document)
        file_menu.addAction(save_as_action)
        
        file_menu.addSeparator()
        
        export_menu = file_menu.addMenu('Export')
        
        pdf_action = QAction('PDF', self)
        pdf_action.triggered.connect(self.export_pdf)
        export_menu.addAction(pdf_action)
        
        word_action = QAction('Word Document', self)
        word_action.triggered.connect(self.export_word)
        export_menu.addAction(word_action)
        
        html_action = QAction('HTML', self)
        html_action.triggered.connect(self.export_html)
        export_menu.addAction(html_action)
        
        # Edit menu
        edit_menu = menubar.addMenu('Edit')
        
        undo_action = QAction('Undo', self)
        undo_action.setShortcut('Ctrl+Z')
        undo_action.triggered.connect(self.undo)
        edit_menu.addAction(undo_action)
        
        redo_action = QAction('Redo', self)
        redo_action.setShortcut('Ctrl+Y')
        redo_action.triggered.connect(self.redo)
        edit_menu.addAction(redo_action)
        
        edit_menu.addSeparator()
        
        cut_action = QAction('Cut', self)
        cut_action.setShortcut('Ctrl+X')
        cut_action.triggered.connect(self.cut)
        edit_menu.addAction(cut_action)
        
        copy_action = QAction('Copy', self)
        copy_action.setShortcut('Ctrl+C')
        copy_action.triggered.connect(self.copy)
        edit_menu.addAction(copy_action)
        
        paste_action = QAction('Paste', self)
        paste_action.setShortcut('Ctrl+V')
        paste_action.triggered.connect(self.paste)
        edit_menu.addAction(paste_action)
        
        # Format menu
        format_menu = menubar.addMenu('Format')
        
        font_action = QAction('Font', self)
        font_action.setShortcut('Ctrl+T')
        font_action.triggered.connect(self.show_font_dialog)
        format_menu.addAction(font_action)
        
        paragraph_action = QAction('Paragraph', self)
        paragraph_action.triggered.connect(self.show_paragraph_dialog)
        format_menu.addAction(paragraph_action)
        
        styles_action = QAction('Styles', self)
        styles_action.triggered.connect(self.show_styles_dialog)
        format_menu.addAction(styles_action)
        
        # View menu
        view_menu = menubar.addMenu('View')
        
        zoom_in_action = QAction('Zoom In', self)
        zoom_in_action.setShortcut('Ctrl+=')
        zoom_in_action.triggered.connect(self.zoom_in)
        view_menu.addAction(zoom_in_action)
        
        zoom_out_action = QAction('Zoom Out', self)
        zoom_out_action.setShortcut('Ctrl+-')
        zoom_out_action.triggered.connect(self.zoom_out)
        view_menu.addAction(zoom_out_action)
        
        reset_zoom_action = QAction('Reset Zoom', self)
        reset_zoom_action.setShortcut('Ctrl+0')
        reset_zoom_action.triggered.connect(self.reset_zoom)
        view_menu.addAction(reset_zoom_action)
    
    def create_toolbar(self):
        toolbar = QToolBar()
        self.addToolBar(toolbar)
        
        # File operations
        new_action = QAction('New', self)
        new_action.triggered.connect(self.new_document)
        toolbar.addAction(new_action)
        
        open_action = QAction('Open', self)
        open_action.triggered.connect(self.open_document)
        toolbar.addAction(open_action)
        
        save_action = QAction('Save', self)
        save_action.triggered.connect(self.save_document)
        toolbar.addAction(save_action)
        
        toolbar.addSeparator()
        
        # Undo/Redo
        undo_action = QAction('Undo', self)
        undo_action.triggered.connect(self.undo)
        toolbar.addAction(undo_action)
        
        redo_action = QAction('Redo', self)
        redo_action.triggered.connect(self.redo)
        toolbar.addAction(redo_action)
        
        toolbar.addSeparator()
        
        # Formatting
        self.bold_action = QAction('B', self)
        self.bold_action.setCheckable(True)
        self.bold_action.triggered.connect(self.toggle_bold)
        toolbar.addAction(self.bold_action)
        
        self.italic_action = QAction('I', self)
        self.italic_action.setCheckable(True)
        self.italic_action.triggered.connect(self.toggle_italic)
        toolbar.addAction(self.italic_action)
        
        self.underline_action = QAction('U', self)
        self.underline_action.setCheckable(True)
        self.underline_action.triggered.connect(self.toggle_underline)
        toolbar.addAction(self.underline_action)
        
        toolbar.addSeparator()
        
        # Font controls
        font_size_label = QLabel("Size:")
        toolbar.addWidget(font_size_label)
        
        self.font_size_combo = QComboBox()
        font_sizes = [8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 36, 48, 72]
        for size in font_sizes:
            self.font_size_combo.addItem(str(size))
        self.font_size_combo.setCurrentText(str(self.font_size))
        self.font_size_combo.currentTextChanged.connect(self.on_font_size_changed)
        toolbar.addWidget(self.font_size_combo)
        
        self.font_family_combo = QComboBox()
        font_families = ["Arial", "Calibri", "Times New Roman", "Courier New", "Georgia", "Verdana", "Tahoma"]
        for family in font_families:
            self.font_family_combo.addItem(family)
        self.font_family_combo.setCurrentText(self.font_family)
        self.font_family_combo.currentTextChanged.connect(self.on_font_family_changed)
        toolbar.addWidget(self.font_family_combo)
        
        toolbar.addSeparator()
        
        # Colors
        text_color_action = QAction('A', self)
        text_color_action.triggered.connect(self.show_text_color_dialog)
        toolbar.addAction(text_color_action)
        
        bg_color_action = QAction('🖍', self)
        bg_color_action.triggered.connect(self.show_bg_color_dialog)
        toolbar.addAction(bg_color_action)
        
        toolbar.addSeparator()
        
        # Alignment
        self.align_left_action = QAction('⬅', self)
        self.align_left_action.setCheckable(True)
        self.align_left_action.triggered.connect(self.align_left)
        toolbar.addAction(self.align_left_action)
        
        self.align_center_action = QAction('⬆', self)
        self.align_center_action.setCheckable(True)
        self.align_center_action.triggered.connect(self.align_center)
        toolbar.addAction(self.align_center_action)
        
        self.align_right_action = QAction('➡', self)
        self.align_right_action.setCheckable(True)
        self.align_right_action.triggered.connect(self.align_right)
        toolbar.addAction(self.align_right_action)
        
        self.align_justify_action = QAction('⬌', self)
        self.align_justify_action.setCheckable(True)
        self.align_justify_action.triggered.connect(self.align_justify)
        toolbar.addAction(self.align_justify_action)
        
        toolbar.addSeparator()
        
        # Lists
        bullet_action = QAction('•', self)
        bullet_action.triggered.connect(self.insert_bullet_list)
        toolbar.addAction(bullet_action)
        
        numbered_action = QAction('1.', self)
        numbered_action.triggered.connect(self.insert_numbered_list)
        toolbar.addAction(numbered_action)
        
        toolbar.addSeparator()
        
        # Insert
        image_action = QAction('🖼', self)
        image_action.triggered.connect(self.insert_image)
        toolbar.addAction(image_action)
        
        table_action = QAction('⊞', self)
        table_action.triggered.connect(self.insert_table)
        toolbar.addAction(table_action)
        
        link_action = QAction('🔗', self)
        link_action.triggered.connect(self.insert_link)
        toolbar.addAction(link_action)
        
        toolbar.addSeparator()
        
        # Zoom
        zoom_out_action = QAction('-', self)
        zoom_out_action.triggered.connect(self.zoom_out)
        toolbar.addAction(zoom_out_action)
        
        self.zoom_label = QLabel(f"{self.current_zoom}%")
        toolbar.addWidget(self.zoom_label)
        
        zoom_in_action = QAction('+', self)
        zoom_in_action.triggered.connect(self.zoom_in)
        toolbar.addAction(zoom_in_action)
    
    def create_text_editor(self, parent):
        # Text editor
        self.text_edit = QTextEdit()
        self.text_edit.setFont(QFont(self.font_family, self.font_size))
        self.text_edit.textChanged.connect(self.on_text_changed)
        self.text_edit.cursorPositionChanged.connect(self.on_cursor_position_changed)
        parent.addWidget(self.text_edit)
    
    def create_side_panel(self, parent):
        side_panel = QWidget()
        side_panel.setMaximumWidth(250)
        side_panel.setMinimumWidth(250)
        
        layout = QVBoxLayout()
        side_panel.setLayout(layout)
        
        # Document Statistics
        stats_group = QGroupBox("Document Statistics")
        stats_layout = QVBoxLayout()
        stats_group.setLayout(stats_layout)
        
        self.word_count_label = QLabel("Words: 0")
        self.char_count_label = QLabel("Characters: 0")
        self.para_count_label = QLabel("Paragraphs: 0")
        
        stats_layout.addWidget(self.word_count_label)
        stats_layout.addWidget(self.char_count_label)
        stats_layout.addWidget(self.para_count_label)
        
        layout.addWidget(stats_group)
        
        # Quick Styles
        styles_group = QGroupBox("Quick Styles")
        styles_layout = QVBoxLayout()
        styles_group.setLayout(styles_layout)
        
        h1_btn = QPushButton("Heading 1")
        h1_btn.clicked.connect(self.apply_heading1)
        styles_layout.addWidget(h1_btn)
        
        h2_btn = QPushButton("Heading 2")
        h2_btn.clicked.connect(self.apply_heading2)
        styles_layout.addWidget(h2_btn)
        
        h3_btn = QPushButton("Heading 3")
        h3_btn.clicked.connect(self.apply_heading3)
        styles_layout.addWidget(h3_btn)
        
        normal_btn = QPushButton("Normal")
        normal_btn.clicked.connect(self.apply_normal)
        styles_layout.addWidget(normal_btn)
        
        layout.addWidget(styles_group)
        
        # Recent Files
        recent_group = QGroupBox("Recent Files")
        recent_layout = QVBoxLayout()
        recent_group.setLayout(recent_layout)
        
        self.recent_list = QListWidget()
        recent_files = ["Document1.docx", "Report.docx", "Notes.docx"]
        for file in recent_files:
            self.recent_list.addItem(file)
        self.recent_list.itemClicked.connect(self.on_recent_file_clicked)
        recent_layout.addWidget(self.recent_list)
        
        layout.addWidget(recent_group)
        
        # Zoom Control
        zoom_group = QGroupBox("Zoom")
        zoom_layout = QVBoxLayout()
        zoom_group.setLayout(zoom_layout)
        
        zoom_layout_h = QHBoxLayout()
        
        zoom_out_btn = QPushButton("-")
        zoom_out_btn.clicked.connect(self.zoom_out)
        zoom_layout_h.addWidget(zoom_out_btn)
        
        self.zoom_slider = QSlider(Qt.Horizontal)
        self.zoom_slider.setMinimum(50)
        self.zoom_slider.setMaximum(200)
        self.zoom_slider.setValue(self.current_zoom)
        self.zoom_slider.valueChanged.connect(self.on_zoom_changed)
        zoom_layout_h.addWidget(self.zoom_slider)
        
        zoom_in_btn = QPushButton("+")
        zoom_in_btn.clicked.connect(self.zoom_in)
        zoom_layout_h.addWidget(zoom_in_btn)
        
        zoom_layout.addLayout(zoom_layout_h)
        
        layout.addWidget(zoom_group)
        
        layout.addStretch()
        
        parent.addWidget(side_panel)
    
    def create_status_bar(self):
        self.status_bar = QStatusBar()
        self.setStatusBar(self.status_bar)
        
        self.status_label = QLabel("Ready")
        self.position_label = QLabel("Position: 0")
        
        self.status_bar.addWidget(self.status_label)
        self.status_bar.addPermanentWidget(self.position_label)
    
    def update_statistics(self):
        text = self.text_edit.toPlainText()
        words = len(text.split())
        characters = len(text)
        paragraphs = len([p for p in text.split('\n') if p.strip()])
        
        self.word_count_label.setText(f"Words: {words}")
        self.char_count_label.setText(f"Characters: {characters}")
        self.para_count_label.setText(f"Paragraphs: {paragraphs}")
    
    def save_to_undo_stack(self):
        text = self.text_edit.toPlainText()
        self.undo_stack.append(text)
        self.redo_stack.clear()
        
        if len(self.undo_stack) > 50:
            self.undo_stack.pop(0)
    
    # Event handlers
    def on_text_changed(self):
        self.update_statistics()
        self.save_to_undo_stack()
    
    def on_cursor_position_changed(self):
        cursor = self.text_edit.textCursor()
        position = cursor.position()
        self.position_label.setText(f"Position: {position}")
    
    def new_document(self):
        self.text_edit.clear()
        self.undo_stack.clear()
        self.redo_stack.clear()
        self.current_file = None
        self.status_label.setText("New document created")
    
    def open_document(self):
        file_path, _ = QFileDialog.getOpenFileName(self, "Open File", "", "Text Files (*.txt);;Rich Text Files (*.rtf);;All Files (*)")
        if file_path:
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                self.text_edit.setPlainText(content)
                self.current_file = file_path
                self.status_label.setText(f"Opened: {file_path}")
            except Exception as e:
                QMessageBox.critical(self, "Error", f"Error opening file: {e}")
    
    def save_document(self):
        if self.current_file:
            self.save_to_file(self.current_file)
        else:
            self.save_as_document()
    
    def save_as_document(self):
        file_path, _ = QFileDialog.getSaveFileName(self, "Save File", "", "Text Files (*.txt);;Rich Text Files (*.rtf);;All Files (*)")
        if file_path:
            self.save_to_file(file_path)
            self.current_file = file_path
    
    def save_to_file(self, file_path):
        try:
            content = self.text_edit.toPlainText()
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            self.status_label.setText(f"Saved: {file_path}")
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Error saving file: {e}")
    
    def undo(self):
        if len(self.undo_stack) > 1:
            self.redo_stack.append(self.undo_stack.pop())
            text = self.undo_stack[-1]
            self.text_edit.setPlainText(text)
    
    def redo(self):
        if self.redo_stack:
            text = self.redo_stack.pop()
            self.undo_stack.append(text)
            self.text_edit.setPlainText(text)
    
    def toggle_bold(self):
        self.is_bold = self.bold_action.isChecked()
        self.apply_formatting()
    
    def toggle_italic(self):
        self.is_italic = self.italic_action.isChecked()
        self.apply_formatting()
    
    def toggle_underline(self):
        self.is_underlined = self.underline_action.isChecked()
        self.apply_formatting()
    
    def apply_formatting(self):
        cursor = self.text_edit.textCursor()
        if cursor.hasSelection():
            format = QTextCharFormat()
            format.setFontWeight(QFont.Bold if self.is_bold else QFont.Normal)
            format.setFontItalic(self.is_italic)
            format.setFontUnderline(self.is_underlined)
            cursor.mergeCharFormat(format)
    
    def on_font_size_changed(self, size):
        self.font_size = int(size)
        self.update_font()
    
    def on_font_family_changed(self, family):
        self.font_family = family
        self.update_font()
    
    def update_font(self):
        font = QFont(self.font_family, self.font_size)
        self.text_edit.setFont(font)
    
    def show_text_color_dialog(self):
        color = QColorDialog.getColor(self.text_color, self)
        if color.isValid():
            self.text_color = color
            self.apply_text_color()
    
    def show_bg_color_dialog(self):
        color = QColorDialog.getColor(self.bg_color, self)
        if color.isValid():
            self.bg_color = color
            self.apply_bg_color()
    
    def apply_text_color(self):
        cursor = self.text_edit.textCursor()
        if cursor.hasSelection():
            format = QTextCharFormat()
            format.setForeground(self.text_color)
            cursor.mergeCharFormat(format)
    
    def apply_bg_color(self):
        cursor = self.text_edit.textCursor()
        if cursor.hasSelection():
            format = QTextCharFormat()
            format.setBackground(self.bg_color)
            cursor.mergeCharFormat(format)
    
    def align_left(self):
        self.alignment = Qt.AlignLeft
        self.update_alignment()
        self.update_alignment_buttons()
    
    def align_center(self):
        self.alignment = Qt.AlignCenter
        self.update_alignment()
        self.update_alignment_buttons()
    
    def align_right(self):
        self.alignment = Qt.AlignRight
        self.update_alignment()
        self.update_alignment_buttons()
    
    def align_justify(self):
        self.alignment = Qt.AlignJustify
        self.update_alignment()
        self.update_alignment_buttons()
    
    def update_alignment(self):
        cursor = self.text_edit.textCursor()
        format = QTextCharFormat()
        format.setAlignment(self.alignment)
        cursor.mergeBlockFormat(format)
    
    def update_alignment_buttons(self):
        self.align_left_action.setChecked(self.alignment == Qt.AlignLeft)
        self.align_center_action.setChecked(self.alignment == Qt.AlignCenter)
        self.align_right_action.setChecked(self.alignment == Qt.AlignRight)
        self.align_justify_action.setChecked(self.alignment == Qt.AlignJustify)
    
    def insert_bullet_list(self):
        cursor = self.text_edit.textCursor()
        cursor.insertText("\n• List item\n")
    
    def insert_numbered_list(self):
        cursor = self.text_edit.textCursor()
        cursor.insertText("\n1. List item\n")
    
    def insert_image(self):
        file_path, _ = QFileDialog.getOpenFileName(self, "Select Image", "", "Image Files (*.png *.jpg *.jpeg *.gif *.bmp)")
        if file_path:
            cursor = self.text_edit.textCursor()
            cursor.insertText(f"[Image: {file_path.split('/')[-1]}]")
    
    def insert_table(self):
        cursor = self.text_edit.textCursor()
        cursor.insertText("\n[Table placeholder - 3x3]\n")
    
    def insert_link(self):
        from PyQt5.QtWidgets import QInputDialog
        
        text, ok1 = QInputDialog.getText(self, 'Insert Link', 'Link text:')
        if ok1:
            url, ok2 = QInputDialog.getText(self, 'Insert Link', 'URL:')
            if ok2:
                cursor = self.text_edit.textCursor()
                cursor.insertText(f"[{text}]({url})")
    
    def apply_heading1(self):
        self.font_size = 24
        self.is_bold = True
        self.update_font()
        self.bold_action.setChecked(True)
    
    def apply_heading2(self):
        self.font_size = 20
        self.is_bold = True
        self.update_font()
        self.bold_action.setChecked(True)
    
    def apply_heading3(self):
        self.font_size = 18
        self.is_bold = True
        self.update_font()
        self.bold_action.setChecked(True)
    
    def apply_normal(self):
        self.font_size = 16
        self.is_bold = False
        self.is_italic = False
        self.update_font()
        self.bold_action.setChecked(False)
        self.italic_action.setChecked(False)
    
    def on_recent_file_clicked(self, item):
        self.status_label.setText(f"Opening {item.text()}")
    
    def zoom_in(self):
        self.current_zoom = min(self.current_zoom + 10, 200)
        self.update_zoom()
    
    def zoom_out(self):
        self.current_zoom = max(self.current_zoom - 10, 50)
        self.update_zoom()
    
    def reset_zoom(self):
        self.current_zoom = 100
        self.update_zoom()
    
    def on_zoom_changed(self, value):
        self.current_zoom = value
        self.update_zoom()
    
    def update_zoom(self):
        self.zoom_label.setText(f"{self.current_zoom}%")
        self.zoom_slider.setValue(self.current_zoom)
        # Apply zoom to text edit
        font = self.text_edit.font()
        font.setPointSize(int(self.font_size * self.current_zoom / 100))
        self.text_edit.setFont(font)
    
    def cut(self):
        self.text_edit.cut()
    
    def copy(self):
        self.text_edit.copy()
    
    def paste(self):
        self.text_edit.paste()
    
    def show_font_dialog(self):
        font, ok = QFontDialog.getFont(self.text_edit.font(), self)
        if ok:
            self.text_edit.setFont(font)
            self.font_family = font.family()
            self.font_size = font.pointSize()
            self.font_family_combo.setCurrentText(self.font_family)
            self.font_size_combo.setCurrentText(str(self.font_size))
    
    def show_paragraph_dialog(self):
        QMessageBox.information(self, "Paragraph", "Paragraph dialog would be implemented here.")
    
    def show_styles_dialog(self):
        QMessageBox.information(self, "Styles", "Styles dialog would be implemented here.")
    
    def export_pdf(self):
        QMessageBox.information(self, "Export PDF", "PDF export functionality would be implemented here.")
    
    def export_word(self):
        QMessageBox.information(self, "Export Word", "Word export functionality would be implemented here.")
    
    def export_html(self):
        QMessageBox.information(self, "Export HTML", "HTML export functionality would be implemented here.")

def main():
    app = QApplication(sys.argv)
    
    # Set application style
    app.setStyle('Fusion')
    
    window = RichTextEditor()
    window.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
