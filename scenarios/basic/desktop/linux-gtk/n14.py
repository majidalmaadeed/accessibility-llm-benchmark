import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class MissingTableHeader(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Employee Management")
        self.set_default_size(1000, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=10)
        self.add(main_box)
        
        # Search and filter section
        search_box = Gtk.HBox(spacing=10)
        search_box.set_margin_bottom(10)
        
        # Search entry
        self.search_entry = Gtk.SearchEntry()
        self.search_entry.set_placeholder_text("Search employees...")
        self.search_entry.connect("search-changed", self.on_search_changed)
        search_box.pack_start(self.search_entry, True, True, 0)
        
        # Sort combo
        sort_combo = Gtk.ComboBoxText()
        sort_options = [
            "Sort by Name",
            "Sort by Department",
            "Sort by Position",
            "Sort by Salary",
            "Sort by Start Date",
            "Sort by Status"
        ]
        
        for option in sort_options:
            sort_combo.append_text(option)
        
        sort_combo.set_active(0)
        sort_combo.connect("changed", self.on_sort_changed)
        search_box.pack_start(sort_combo, False, False, 0)
        
        main_box.pack_start(search_box, False, False, 0)
        
        # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
        # Create scrolled window for table
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        # Create tree view - MISSING TABLE HEADER
        self.tree_view = Gtk.TreeView()
        self.tree_view.set_headers_visible(False)  # MISSING TABLE HEADER - Hide headers
        
        # Create columns - MISSING TABLE HEADER
        # Column 1: Status (shape only)
        status_renderer = Gtk.CellRendererPixbuf()
        status_column = Gtk.TreeViewColumn("Status", status_renderer)
        status_column.set_cell_data_func(status_renderer, self.status_cell_data_func)
        self.tree_view.append_column(status_column)
        
        # Column 2: Employee Info
        employee_renderer = Gtk.CellRendererText()
        employee_column = Gtk.TreeViewColumn("Employee", employee_renderer)
        employee_column.set_cell_data_func(employee_renderer, self.employee_cell_data_func)
        self.tree_view.append_column(employee_column)
        
        # Column 3: Contact Info
        contact_renderer = Gtk.CellRendererText()
        contact_column = Gtk.TreeViewColumn("Contact", contact_renderer)
        contact_column.set_cell_data_func(contact_renderer, self.contact_cell_data_func)
        self.tree_view.append_column(contact_column)
        
        # Column 4: Actions
        actions_renderer = Gtk.CellRendererText()
        actions_column = Gtk.TreeViewColumn("Actions", actions_renderer)
        actions_column.set_cell_data_func(actions_renderer, self.actions_cell_data_func)
        self.tree_view.append_column(actions_column)
        
        # Create list store
        self.list_store = Gtk.ListStore(str, str, str, str, str, str, str, str)  # status, name, dept, pos, salary, date, email, phone
        
        # Load data
        self.load_employees()
        
        self.tree_view.set_model(self.list_store)
        self.tree_view.connect("row-activated", self.on_row_activated)
        
        scrolled_window.add(self.tree_view)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # Status bar
        status_box = Gtk.HBox(spacing=10)
        status_box.set_margin_top(10)
        
        self.total_label = Gtk.Label("Total Employees: 6")
        self.total_label.set_markup("<span weight='bold'>Total Employees: 6</span>")
        status_box.pack_start(self.total_label, False, False, 0)
        
        sort_info_label = Gtk.Label("Sort by: Name ↓")
        sort_info_label.set_halign(Gtk.Align.END)
        status_box.pack_start(sort_info_label, True, True, 0)
        
        main_box.pack_start(status_box, False, False, 0)
        
        # Store employees data
        self.employees = []
        self.filtered_employees = []
        
    def load_employees(self):
        self.employees = [
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
        self.filtered_employees = self.employees.copy()
        self.update_display()
    
    def update_display(self):
        self.list_store.clear()
        for employee in self.filtered_employees:
            self.list_store.append([
                employee["status"],
                employee["name"],
                f"{employee['department']} • {employee['position']}",
                f"{employee['salary']} • {employee['start_date']}",
                f"{employee['email']} • {employee['phone']}",
                "",  # Actions placeholder
                "",  # Additional data
                ""   # Additional data
            ])
        
        self.total_label.set_markup(f"<span weight='bold'>Total Employees: {len(self.filtered_employees)}</span>")
    
    def on_search_changed(self, entry):
        search_text = entry.get_text().lower()
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
    
    def on_sort_changed(self, combo):
        # Simple sorting implementation
        self.update_display()
    
    def status_cell_data_func(self, column, cell, model, iter, data):
        # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
        status = model[iter][0]
        if status == "Active":
            # STATUS BY SHAPE ONLY - Active status shown as square
            cell.set_property("icon-name", "gtk-apply")
        else:
            # STATUS BY SHAPE ONLY - Inactive status shown as circle
            cell.set_property("icon-name", "gtk-cancel")
    
    def employee_cell_data_func(self, column, cell, model, iter, data):
        # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
        name = model[iter][1]
        dept_pos = model[iter][2]
        cell.set_property("text", f"{name}\n{dept_pos}")
        cell.set_property("weight", 700)  # Bold for name
    
    def contact_cell_data_func(self, column, cell, model, iter, data):
        # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
        salary_date = model[iter][3]
        contact = model[iter][4]
        cell.set_property("text", f"{salary_date}\n{contact}")
    
    def actions_cell_data_func(self, column, cell, model, iter, data):
        # MISSING TABLE HEADER - Data table using <td> elements instead of <th> for column headers
        cell.set_property("text", "👁️ ✏️")
    
    def on_row_activated(self, tree_view, path, column):
        # Show employee details
        model = tree_view.get_model()
        iter = model.get_iter(path)
        name = model[iter][1]
        
        # Find employee data
        employee = None
        for emp in self.filtered_employees:
            if emp["name"] == name:
                employee = emp
                break
        
        if employee:
            dialog = Gtk.MessageDialog(
                transient_for=self,
                flags=0,
                message_type=Gtk.MessageType.INFO,
                buttons=Gtk.ButtonsType.OK,
                text="Employee Details"
            )
            dialog.format_secondary_text(f"""
Name: {employee['name']}
Department: {employee['department']}
Position: {employee['position']}
Salary: {employee['salary']}
Start Date: {employee['start_date']}
Status: {employee['status']}
Email: {employee['email']}
Phone: {employee['phone']}
            """)
            dialog.run()
            dialog.destroy()

def main():
    win = MissingTableHeader()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
