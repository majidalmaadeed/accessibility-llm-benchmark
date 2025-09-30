import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QTableWidget, 
                             QTableWidgetItem, QHeaderView, QLineEdit, QComboBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class MissingTableHeader(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Employee Management")
        self.setGeometry(100, 100, 1000, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(10)
        main_layout.setContentsMargins(10, 10, 10, 10)
        
        # Search and filter section
        search_layout = QHBoxLayout()
        search_layout.setContentsMargins(0, 0, 0, 10)
        
        # Search entry
        self.search_entry = QLineEdit()
        self.search_entry.setPlaceholderText("Search employees...")
        self.search_entry.textChanged.connect(self.on_search_changed)
        search_layout.addWidget(self.search_entry)
        
        # Sort combo
        sort_combo = QComboBox()
        sort_options = [
            "Sort by Name",
            "Sort by Department", 
            "Sort by Position",
            "Sort by Salary",
            "Sort by Start Date",
            "Sort by Status"
        ]
        
        for option in sort_options:
            sort_combo.addItem(option)
        
        sort_combo.setCurrentIndex(0)
        sort_combo.currentTextChanged.connect(self.on_sort_changed)
        search_layout.addWidget(sort_combo)
        
        main_layout.addLayout(search_layout)
        
        # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
        # Create table widget - MISSING TABLE HEADER
        self.table_widget = QTableWidget()
        self.table_widget.setRowCount(6)
        self.table_widget.setColumnCount(4)
        
        # MISSING TABLE HEADER - Hide headers
        self.table_widget.horizontalHeader().setVisible(False)
        
        # Set column widths
        self.table_widget.setColumnWidth(0, 100)  # Status
        self.table_widget.setColumnWidth(1, 200)  # Employee Info
        self.table_widget.setColumnWidth(2, 250)  # Contact Info
        self.table_widget.setColumnWidth(3, 100)  # Actions
        
        # Load data
        self.load_employees()
        
        main_layout.addWidget(self.table_widget)
        
        # Status bar
        status_layout = QHBoxLayout()
        status_layout.setContentsMargins(0, 10, 0, 0)
        
        self.total_label = QLabel("Total Employees: 6")
        total_font = QFont()
        total_font.setBold(True)
        self.total_label.setFont(total_font)
        status_layout.addWidget(self.total_label)
        
        sort_info_label = QLabel("Sort by: Name ↓")
        sort_info_label.setAlignment(Qt.AlignRight)
        status_layout.addWidget(sort_info_label)
        
        main_layout.addLayout(status_layout)
        
    def load_employees(self):
        employees = [
            {
                "name": "John Smith",
                "department": "Engineering",
                "position": "Senior Developer",
                "salary": "$95,000",
                "start_date": "2022-01-15",
                "status": "Active",
                "email": "john.smith@company.com",
                "phone": "+1 (555) 123-4567"
            },
            {
                "name": "Sarah Johnson",
                "department": "Marketing",
                "position": "Marketing Manager",
                "salary": "$78,000",
                "start_date": "2021-08-22",
                "status": "Active",
                "email": "sarah.johnson@company.com",
                "phone": "+1 (555) 234-5678"
            },
            {
                "name": "Mike Chen",
                "department": "Sales",
                "position": "Sales Director",
                "salary": "$120,000",
                "start_date": "2020-03-10",
                "status": "Active",
                "email": "mike.chen@company.com",
                "phone": "+1 (555) 345-6789"
            },
            {
                "name": "Emily Davis",
                "department": "HR",
                "position": "HR Specialist",
                "salary": "$65,000",
                "start_date": "2023-02-01",
                "status": "Active",
                "email": "emily.davis@company.com",
                "phone": "+1 (555) 456-7890"
            },
            {
                "name": "David Wilson",
                "department": "Finance",
                "position": "Financial Analyst",
                "salary": "$72,000",
                "start_date": "2022-11-15",
                "status": "Active",
                "email": "david.wilson@company.com",
                "phone": "+1 (555) 567-8901"
            },
            {
                "name": "Lisa Brown",
                "department": "Operations",
                "position": "Operations Manager",
                "salary": "$88,000",
                "start_date": "2021-05-20",
                "status": "Active",
                "email": "lisa.brown@company.com",
                "phone": "+1 (555) 678-9012"
            }
        ]
        
        for i, employee in enumerate(employees):
            # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
            if employee["status"] == "Active":
                # STATUS BY SHAPE ONLY - Active status shown as square
                status_item = QTableWidgetItem("🟦")  # Square
            else:
                # STATUS BY SHAPE ONLY - Inactive status shown as circle
                status_item = QTableWidgetItem("🔴")  # Circle
            self.table_widget.setItem(i, 0, status_item)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            employee_info = QTableWidgetItem(f"{employee['name']}\n{employee['department']} • {employee['position']}")
            employee_font = QFont()
            employee_font.setBold(True)
            employee_info.setFont(employee_font)
            self.table_widget.setItem(i, 1, employee_info)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            contact_info = QTableWidgetItem(f"{employee['salary']} • {employee['start_date']}\n{employee['email']} • {employee['phone']}")
            self.table_widget.setItem(i, 2, contact_info)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            actions_item = QTableWidgetItem("👁️ ✏️")
            self.table_widget.setItem(i, 3, actions_item)
        
        # Store employees data
        self.employees = employees
        self.filtered_employees = employees.copy()
    
    def on_search_changed(self, text):
        search_text = text.lower()
        if search_text == "":
            self.filtered_employees = self.employees.copy()
        else:
            self.filtered_employees = [
                emp for emp in self.employees
                if search_text in emp["name"].lower() or
                   search_text in emp["department"].lower() or
                   search_text in emp["position"].lower() or
                   search_text in emp["email"].lower()
            ]
        self.update_display()
    
    def update_display(self):
        # Clear table
        self.table_widget.setRowCount(len(self.filtered_employees))
        
        for i, employee in enumerate(self.filtered_employees):
            # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
            if employee["status"] == "Active":
                # STATUS BY SHAPE ONLY - Active status shown as square
                status_item = QTableWidgetItem("🟦")  # Square
            else:
                # STATUS BY SHAPE ONLY - Inactive status shown as circle
                status_item = QTableWidgetItem("🔴")  # Circle
            self.table_widget.setItem(i, 0, status_item)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            employee_info = QTableWidgetItem(f"{employee['name']}\n{employee['department']} • {employee['position']}")
            employee_font = QFont()
            employee_font.setBold(True)
            employee_info.setFont(employee_font)
            self.table_widget.setItem(i, 1, employee_info)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            contact_info = QTableWidgetItem(f"{employee['salary']} • {employee['start_date']}\n{employee['email']} • {employee['phone']}")
            self.table_widget.setItem(i, 2, contact_info)
            
            # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
            actions_item = QTableWidgetItem("👁️ ✏️")
            self.table_widget.setItem(i, 3, actions_item)
        
        self.total_label.setText(f"Total Employees: {len(self.filtered_employees)}")
    
    def on_sort_changed(self, text):
        # Simple sorting implementation
        self.update_display()

def main():
    app = QApplication(sys.argv)
    window = MissingTableHeader()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
