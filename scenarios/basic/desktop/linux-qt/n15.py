import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QScrollArea, QMenu)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class RightClickOnlyMenu(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("File Manager")
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Toolbar
        toolbar_layout = QHBoxLayout()
        toolbar_layout.setSpacing(10)
        toolbar_layout.setContentsMargins(10, 10, 10, 10)
        toolbar_layout.setAlignment(Qt.AlignCenter)
        
        # Toolbar buttons
        toolbar_buttons = [
            ("📁", "New Folder", self.on_new_folder_clicked),
            ("📄", "New File", self.on_new_file_clicked),
            ("📤", "Upload", self.on_upload_clicked),
            ("📥", "Download", self.on_download_clicked)
        ]
        
        for icon, tooltip, callback in toolbar_buttons:
            button = QPushButton(icon)
            button.setFixedSize(50, 50)
            button.setToolTip(tooltip)
            button.clicked.connect(callback)
            toolbar_layout.addWidget(button)
        
        main_layout.addLayout(toolbar_layout)
        
        # Files section
        files_label = QLabel("Files")
        files_font = QFont()
        files_font.setPointSize(18)
        files_font.setBold(True)
        files_label.setFont(files_font)
        files_label.setContentsMargins(20, 20, 20, 10)
        main_layout.addWidget(files_label)
        
        # Files scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        # Files list
        self.files_widget = QWidget()
        self.files_layout = QVBoxLayout(self.files_widget)
        self.files_layout.setSpacing(10)
        self.files_layout.setContentsMargins(20, 20, 20, 20)
        
        scroll_area.setWidget(self.files_widget)
        main_layout.addWidget(scroll_area)
        
        # Status bar
        status_layout = QHBoxLayout()
        status_layout.setContentsMargins(10, 10, 10, 10)
        
        self.selected_item_label = QLabel("No item selected")
        status_layout.addWidget(self.selected_item_label)
        
        status_label = QLabel("Ready")
        status_label.setAlignment(Qt.AlignRight)
        status_layout.addWidget(status_label)
        
        main_layout.addLayout(status_layout)
        
        # Load files
        self.load_files()
        
    def load_files(self):
        files = [
            {
                "name": "document.pdf",
                "type": "PDF",
                "size": "2.5 MB",
                "last_modified": "2 hours ago",
                "is_folder": False
            },
            {
                "name": "Projects",
                "type": "Folder",
                "size": "15 items",
                "last_modified": "1 day ago",
                "is_folder": True
            },
            {
                "name": "image.jpg",
                "type": "JPEG",
                "size": "1.2 MB",
                "last_modified": "3 hours ago",
                "is_folder": False
            },
            {
                "name": "spreadsheet.xlsx",
                "type": "Excel",
                "size": "850 KB",
                "last_modified": "1 day ago",
                "is_folder": False
            },
            {
                "name": "audio.mp3",
                "type": "MP3",
                "size": "4.2 MB",
                "last_modified": "2 days ago",
                "is_folder": False
            }
        ]
        
        for file in files:
            file_frame = self.create_file_card(file)
            self.files_layout.addWidget(file_frame)
    
    def create_file_card(self, file):
        # File frame
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QHBoxLayout(frame)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # File icon
        icon = QLabel("📁" if file["is_folder"] else "📄")
        icon.setFixedSize(40, 40)
        icon.setStyleSheet("font-size: 24px;")
        main_layout.addWidget(icon)
        
        # File info
        info_layout = QVBoxLayout()
        
        # File name
        name_label = QLabel(file["name"])
        name_font = QFont()
        name_font.setPointSize(16)
        name_font.setBold(True)
        name_label.setFont(name_font)
        info_layout.addWidget(name_label)
        
        # File details
        details_label = QLabel(f"{file['type']} • {file['size']} • Modified {file['last_modified']}")
        info_layout.addWidget(details_label)
        
        main_layout.addLayout(info_layout)
        
        # Action buttons
        actions_layout = QHBoxLayout()
        actions_layout.setSpacing(10)
        
        view_button = QPushButton("👁️")
        view_button.setFixedSize(40, 40)
        view_button.clicked.connect(lambda: self.on_view_clicked(file))
        actions_layout.addWidget(view_button)
        
        edit_button = QPushButton("✏️")
        edit_button.setFixedSize(40, 40)
        edit_button.clicked.connect(lambda: self.on_edit_clicked(file))
        actions_layout.addWidget(edit_button)
        
        download_button = QPushButton("📤")
        download_button.setFixedSize(40, 40)
        download_button.clicked.connect(lambda: self.on_download_clicked(file))
        actions_layout.addWidget(download_button)
        
        main_layout.addLayout(actions_layout)
        
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        frame.setContextMenuPolicy(Qt.CustomContextMenu)
        frame.customContextMenuRequested.connect(lambda pos: self.show_context_menu(pos, file))
        
        return frame
    
    def show_context_menu(self, pos, file):
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        menu = QMenu(self)
        
        # Open item
        open_action = menu.addAction("Open")
        open_action.triggered.connect(lambda: self.on_context_open(file))
        
        # Rename item
        rename_action = menu.addAction("Rename")
        rename_action.triggered.connect(lambda: self.on_context_rename(file))
        
        # Copy item
        copy_action = menu.addAction("Copy")
        copy_action.triggered.connect(lambda: self.on_context_copy(file))
        
        # Move item
        move_action = menu.addAction("Move")
        move_action.triggered.connect(lambda: self.on_context_move(file))
        
        # Separator
        menu.addSeparator()
        
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        delete_action = menu.addAction("Delete")
        delete_action.triggered.connect(lambda: self.on_context_delete(file))
        
        # Show context menu
        menu.exec_(self.mapToGlobal(pos))
    
    def on_context_open(self, file):
        self.show_file_details(file)
    
    def on_context_rename(self, file):
        QMessageBox.information(self, "Rename File", f"Rename: {file['name']}")
    
    def on_context_copy(self, file):
        QMessageBox.information(self, "Copy File", f"Copy: {file['name']}")
    
    def on_context_move(self, file):
        QMessageBox.information(self, "Move File", f"Move: {file['name']}")
    
    def on_context_delete(self, file):
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        response = QMessageBox.question(self, "Delete File", 
                                       f"Are you sure you want to delete '{file['name']}'? This action cannot be undone.",
                                       QMessageBox.Yes | QMessageBox.No)
        
        if response == QMessageBox.Yes:
            # Handle delete
            QMessageBox.information(self, "File Deleted", f"'{file['name']}' has been deleted.")
    
    def on_view_clicked(self, file):
        self.show_file_details(file)
    
    def on_edit_clicked(self, file):
        QMessageBox.information(self, "Edit File", f"Edit: {file['name']}")
    
    def on_download_clicked(self, file):
        QMessageBox.information(self, "Download File", f"Download: {file['name']}")
    
    def show_file_details(self, file):
        QMessageBox.information(self, "File Details", 
                               f"Name: {file['name']}\n"
                               f"Type: {file['type']}\n"
                               f"Size: {file['size']}\n"
                               f"Last Modified: {file['last_modified']}")
    
    def on_new_folder_clicked(self):
        QMessageBox.information(self, "New Folder", "New folder created!")
    
    def on_new_file_clicked(self):
        QMessageBox.information(self, "New File", "New file created!")
    
    def on_upload_clicked(self):
        QMessageBox.information(self, "Upload Files", "Upload functionality activated!")
    
    def on_download_clicked(self):
        QMessageBox.information(self, "Download Files", "Download functionality activated!")

def main():
    app = QApplication(sys.argv)
    window = RightClickOnlyMenu()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
