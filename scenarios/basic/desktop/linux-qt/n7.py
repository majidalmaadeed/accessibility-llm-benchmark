import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QTextEdit)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class InsufficientButtonSpacing(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Document Editor")
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Toolbar
        toolbar_layout = QHBoxLayout()
        toolbar_layout.setSpacing(2)  # INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart
        toolbar_layout.setContentsMargins(10, 10, 10, 10)
        toolbar_layout.setAlignment(Qt.AlignCenter)
        
        # Action Buttons - INSUFFICIENT BUTTON SPACING
        action_buttons = [
            ("Save", self.on_save_clicked, "suggested-action"),
            ("Edit", self.on_edit_clicked, ""),
            ("Delete", self.on_delete_clicked, ""),
            ("Share", self.on_share_clicked, ""),
            ("Print", self.on_print_clicked, "")
        ]
        
        for label, callback, style_class in action_buttons:
            button = QPushButton(label)
            button.setFixedSize(80, 40)
            if style_class == "suggested-action":
                button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
            button.clicked.connect(callback)
            toolbar_layout.addWidget(button)
        
        main_layout.addLayout(toolbar_layout)
        
        # Formatting toolbar
        formatting_layout = QHBoxLayout()
        formatting_layout.setSpacing(2)  # INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
        formatting_layout.setContentsMargins(10, 0, 10, 10)
        formatting_layout.setAlignment(Qt.AlignCenter)
        
        # Formatting Options - INSUFFICIENT BUTTON SPACING
        formatting_buttons = [
            ("B", self.on_bold_clicked, "Bold"),
            ("I", self.on_italic_clicked, "Italic"),
            ("U", self.on_underline_clicked, "Underline"),
            ("A", self.on_align_left_clicked, "Align Left"),
            ("A", self.on_align_center_clicked, "Align Center"),
            ("A", self.on_align_right_clicked, "Align Right")
        ]
        
        for label, callback, tooltip in formatting_buttons:
            button = QPushButton(label)
            button.setFixedSize(40, 40)
            button.setToolTip(tooltip)
            button.clicked.connect(callback)
            toolbar_layout.addWidget(button)
        
        main_layout.addLayout(formatting_layout)
        
        # Quick actions toolbar
        quick_actions_layout = QHBoxLayout()
        quick_actions_layout.setSpacing(2)  # INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart
        quick_actions_layout.setContentsMargins(10, 0, 10, 10)
        quick_actions_layout.setAlignment(Qt.AlignCenter)
        
        # Quick Actions - INSUFFICIENT BUTTON SPACING
        quick_actions = [
            ("📄", self.on_new_document_clicked, "New Document"),
            ("📁", self.on_open_folder_clicked, "Open Folder"),
            ("💾", self.on_save_clicked, "Save"),
            ("🖨️", self.on_print_clicked, "Print"),
            ("📤", self.on_export_clicked, "Export"),
            ("🔍", self.on_search_clicked, "Search")
        ]
        
        for icon, callback, tooltip in quick_actions:
            button = QPushButton(icon)
            button.setFixedSize(40, 40)
            button.setToolTip(tooltip)
            button.clicked.connect(callback)
            quick_actions_layout.addWidget(button)
        
        main_layout.addLayout(quick_actions_layout)
        
        # Document content area
        content_frame = QFrame()
        content_frame.setFrameStyle(QFrame.Box)
        content_frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        content_layout = QVBoxLayout(content_frame)
        content_layout.setSpacing(10)
        content_layout.setContentsMargins(20, 20, 20, 20)
        
        # Document title
        title_label = QLabel("Sample Document")
        title_font = QFont()
        title_font.setPointSize(18)
        title_font.setBold(True)
        title_label.setFont(title_font)
        content_layout.addWidget(title_label)
        
        # Document content
        content_text = QTextEdit()
        content_text.setPlainText("This is a sample document content. You can edit this text when in edit mode. The document contains various sections and formatting options.")
        content_text.setFixedHeight(300)
        content_layout.addWidget(content_text)
        
        main_layout.addWidget(content_frame)
        
        # Status bar
        status_layout = QHBoxLayout()
        status_layout.setContentsMargins(10, 10, 10, 10)
        
        status_label = QLabel("Ready")
        status_layout.addWidget(status_label)
        
        word_count_label = QLabel("Words: 25")
        word_count_label.setAlignment(Qt.AlignRight)
        status_layout.addWidget(word_count_label)
        
        main_layout.addLayout(status_layout)
        
        # State
        self.is_editing = False
        self.is_deleting = False
        
    # Action button methods
    def on_save_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Save Document", "Document saved successfully!")
    
    def on_edit_clicked(self):
        self.is_editing = not self.is_editing
        if self.is_editing:
            self.findChild(QPushButton, "Edit").setText("Done")
        else:
            self.findChild(QPushButton, "Edit").setText("Edit")
        
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Edit Mode", f"Edit mode: {'ON' if self.is_editing else 'OFF'}")
    
    def on_delete_clicked(self):
        self.is_deleting = not self.is_deleting
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Delete Document", 
                               "Document deleted!" if self.is_deleting else "Are you sure you want to delete this document?")
    
    def on_share_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Share Document", "Document shared successfully!")
    
    def on_print_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Print Document", "Document sent to printer!")
    
    # Formatting button methods
    def on_bold_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Bold Formatting", "Bold formatting applied!")
    
    def on_italic_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Italic Formatting", "Italic formatting applied!")
    
    def on_underline_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Underline Formatting", "Underline formatting applied!")
    
    def on_align_left_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Align Left", "Text aligned to left!")
    
    def on_align_center_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Align Center", "Text aligned to center!")
    
    def on_align_right_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Align Right", "Text aligned to right!")
    
    # Quick action button methods
    def on_new_document_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "New Document", "New document created!")
    
    def on_open_folder_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Open Folder", "Folder opened!")
    
    def on_export_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Export Document", "Document exported successfully!")
    
    def on_search_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Search Document", "Search functionality activated!")

def main():
    app = QApplication(sys.argv)
    window = InsufficientButtonSpacing()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
