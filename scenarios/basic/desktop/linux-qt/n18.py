import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QTableWidget, 
                             QTableWidgetItem, QHeaderView, QLineEdit, QComboBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class StatusByShapeOnly(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Document Management System")
        self.setGeometry(100, 100, 1000, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(10)
        main_layout.setContentsMargins(10, 10, 10, 10)
        
        # Header
        header_layout = QVBoxLayout()
        header_layout.setAlignment(Qt.AlignCenter)
        
        title_label = QLabel("Document Management System")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(title_label)
        
        subtitle_label = QLabel("Review and approve documents")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        header_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(header_layout)
        
        # Filter options
        filter_layout = QHBoxLayout()
        filter_layout.setAlignment(Qt.AlignCenter)
        
        filter_buttons = [
            ("All", True),
            ("Pending", False),
            ("Approved", False),
            ("Rejected", False)
        ]
        
        for label, is_active in filter_buttons:
            button = QPushButton(label)
            if is_active:
                button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
            button.clicked.connect(lambda checked, l=label: self.on_filter_clicked(l))
            filter_layout.addWidget(button)
        
        main_layout.addLayout(filter_layout)
        
        # Documents section
        documents_label = QLabel("Documents")
        documents_font = QFont()
        documents_font.setPointSize(18)
        documents_font.setBold(True)
        documents_label.setFont(documents_font)
        documents_label.setContentsMargins(20, 20, 20, 10)
        main_layout.addWidget(documents_label)
        
        # Documents scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        # Documents list
        self.documents_widget = QWidget()
        self.documents_layout = QVBoxLayout(self.documents_widget)
        self.documents_layout.setSpacing(10)
        self.documents_layout.setContentsMargins(20, 20, 20, 20)
        
        scroll_area.setWidget(self.documents_widget)
        main_layout.addWidget(scroll_area)
        
        # Status bar
        status_layout = QHBoxLayout()
        status_layout.setContentsMargins(0, 10, 0, 0)
        
        self.total_label = QLabel("Total Documents: 4")
        total_font = QFont()
        total_font.setBold(True)
        self.total_label.setFont(total_font)
        status_layout.addWidget(self.total_label)
        
        sort_info_label = QLabel("Sort by: Name ↓")
        sort_info_label.setAlignment(Qt.AlignRight)
        status_layout.addWidget(sort_info_label)
        
        main_layout.addLayout(status_layout)
        
        # Load documents
        self.load_documents()
        
    def load_documents(self):
        documents = [
            {
                "name": "Project Proposal Q1 2024",
                "department": "Marketing",
                "size": "2.5 MB",
                "type": "PDF",
                "last_modified": "2024-01-15 14:30",
                "status": "pending"
            },
            {
                "name": "Budget Report 2023",
                "department": "Finance",
                "size": "1.8 MB",
                "type": "Excel",
                "last_modified": "2024-01-12 09:15",
                "status": "approved"
            },
            {
                "name": "Employee Handbook v2.1",
                "department": "HR",
                "size": "3.2 MB",
                "type": "PDF",
                "last_modified": "2024-01-10 16:45",
                "status": "rejected"
            },
            {
                "name": "Technical Specifications",
                "department": "Engineering",
                "size": "4.1 MB",
                "type": "PDF",
                "last_modified": "2024-01-08 11:20",
                "status": "pending"
            }
        ]
        
        for document in documents:
            document_frame = self.create_document_card(document)
            self.documents_layout.addWidget(document_frame)
    
    def create_document_card(self, document):
        # Document frame
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QHBoxLayout(frame)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
        status_container = QVBoxLayout()
        status_container.setAlignment(Qt.AlignCenter)
        
        status_shape = QLabel()
        if document["status"] == "approved":
            # STATUS BY SHAPE ONLY - Approved status shown as square
            status_shape.setText("🟦")  # Square
        elif document["status"] == "rejected":
            # STATUS BY SHAPE ONLY - Rejected status shown as circle
            status_shape.setText("🔴")  # Circle
        else:  # pending
            # STATUS BY SHAPE ONLY - Pending status shown as circle
            status_shape.setText("🟡")  # Circle
        
        status_shape.setStyleSheet("font-size: 24px;")
        status_shape.setFixedSize(30, 30)
        status_container.addWidget(status_shape)
        
        main_layout.addLayout(status_container)
        
        # Document info
        info_layout = QVBoxLayout()
        
        # Document name
        name_label = QLabel(document["name"])
        name_font = QFont()
        name_font.setPointSize(16)
        name_font.setBold(True)
        name_label.setFont(name_font)
        info_layout.addWidget(name_label)
        
        # Document details
        details_label = QLabel(f"{document['department']} • {document['size']} • {document['type']}")
        info_layout.addWidget(details_label)
        
        # Last modified
        modified_label = QLabel(f"Last modified: {document['last_modified']}")
        info_layout.addWidget(modified_label)
        
        main_layout.addLayout(info_layout)
        
        # Actions
        actions_layout = QHBoxLayout()
        actions_layout.setSpacing(10)
        
        view_button = QPushButton("👁️")
        view_button.setFixedSize(40, 40)
        view_button.clicked.connect(lambda: self.on_view_clicked(document))
        actions_layout.addWidget(view_button)
        
        edit_button = QPushButton("✏️")
        edit_button.setFixedSize(40, 40)
        edit_button.clicked.connect(lambda: self.on_edit_clicked(document))
        actions_layout.addWidget(edit_button)
        
        download_button = QPushButton("📤")
        download_button.setFixedSize(40, 40)
        download_button.clicked.connect(lambda: self.on_download_clicked(document))
        actions_layout.addWidget(download_button)
        
        main_layout.addLayout(actions_layout)
        
        return frame
    
    def on_filter_clicked(self, filter_type):
        # Update filter buttons
        for i in range(self.findChild(QHBoxLayout).count()):
            widget = self.findChild(QHBoxLayout).itemAt(i).widget()
            if isinstance(widget, QPushButton):
                widget.setStyleSheet("")
        
        # Find and highlight the clicked button
        for i in range(self.findChild(QHBoxLayout).count()):
            widget = self.findChild(QHBoxLayout).itemAt(i).widget()
            if isinstance(widget, QPushButton) and widget.text() == filter_type:
                widget.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
                break
        
        # Filter documents based on type
        # This is a simplified implementation
        pass
    
    def on_view_clicked(self, document):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Document Details", 
                               f"Name: {document['name']}\n"
                               f"Department: {document['department']}\n"
                               f"Position: {document['position']}\n"
                               f"Salary: {document['salary']}\n"
                               f"Start Date: {document['start_date']}\n"
                               f"Status: {document['status']}\n"
                               f"Email: {document['email']}\n"
                               f"Phone: {document['phone']}")
    
    def on_edit_clicked(self, document):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Edit Document", f"Edit: {document['name']}")
    
    def on_download_clicked(self, document):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Download Document", f"Download: {document['name']}")

def main():
    app = QApplication(sys.argv)
    window = StatusByShapeOnly()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
