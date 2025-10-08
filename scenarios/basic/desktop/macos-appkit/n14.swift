import Cocoa

class MissingTableHeader: NSViewController {
    
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var sortPopUpButton: NSPopUpButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var totalLabel: NSTextField!
    @IBOutlet weak var sortInfoLabel: NSTextField!
    
    private var employees: [Employee] = []
    private var filteredEmployees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadEmployees()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Search Field
        searchField.placeholderString = "Search employees..."
        searchField.target = self
        searchField.action = #selector(searchChanged)
        
        // Sort Popup
        sortPopUpButton.removeAllItems()
        sortPopUpButton.addItems(withTitles: [
            "Sort by Name",
            "Sort by Department", 
            "Sort by Position",
            "Sort by Salary",
            "Sort by Start Date",
            "Sort by Status"
        ])
        sortPopUpButton.target = self
        sortPopUpButton.action = #selector(sortChanged)
        
        // Table View - MISSING TABLE HEADER
        tableView.dataSource = self
        tableView.delegate = self
        tableView.headerView = nilng <td> elements instead of <th> for column headers
        tableView.target = self
        tableView.doubleAction = #selector(rowDoubleClicked)
        
        // Status Labels
        totalLabel.font = NSFont.boldSystemFont(ofSize: 14)
        sortInfoLabel.font = NSFont.systemFont(ofSize: 12)
        sortInfoLabel.textColor = .secondaryLabelColor
    }
    
    private func loadEmployees() {
        employees = [
            Employee(name: "John Smith", department: "Engineering", position: "Senior Developer", salary: "$95,000", startDate: "2022-01-15", status: "Active", email: "john.smith@company.com", phone: "+1 (555) 123-4567"),
            Employee(name: "Sarah Johnson", department: "Marketing", position: "Marketing Manager", salary: "$78,000", startDate: "2021-08-22", status: "Active", email: "sarah.johnson@company.com", phone: "+1 (555) 234-5678"),
            Employee(name: "Mike Chen", department: "Sales", position: "Sales Director", salary: "$120,000", startDate: "2020-03-10", status: "Active", email: "mike.chen@company.com", phone: "+1 (555) 345-6789"),
            Employee(name: "Emily Davis", department: "HR", position: "HR Specialist", salary: "$65,000", startDate: "2023-02-01", status: "Active", email: "emily.davis@company.com", phone: "+1 (555) 456-7890"),
            Employee(name: "David Wilson", department: "Finance", position: "Financial Analyst", salary: "$72,000", startDate: "2022-11-15", status: "Active", email: "david.wilson@company.com", phone: "+1 (555) 567-8901"),
            Employee(name: "Lisa Brown", department: "Operations", position: "Operations Manager", salary: "$88,000", startDate: "2021-05-20", status: "Active", email: "lisa.brown@company.com", phone: "+1 (555) 678-9012")
        ]
        filteredEmployees = employees
        updateUI()
    }
    
    private func updateUI() {
        tableView.reloadData()
        totalLabel.stringValue = "Total Employees: \(filteredEmployees.count)"
        sortInfoLabel.stringValue = "Sort by: Name ↓"
    }
    
    @objc private func searchChanged() {
        let searchText = searchField.stringValue.lowercased()
        if searchText.isEmpty {
            filteredEmployees = employees
        } else {
            filteredEmployees = employees.filter { employee in
                employee.name.lowercased().contains(searchText) ||
                employee.department.lowercased().contains(searchText) ||
                employee.position.lowercased().contains(searchText) ||
                employee.email.lowercased().contains(searchText)
            }
        }
        updateUI()
    }
    
    @objc private func sortChanged() {
        let selectedSort = sortPopUpButton.selectedItem?.title ?? "Sort by Name"
        
        switch selectedSort {
        case "Sort by Name":
            filteredEmployees.sort { $0.name < $1.name }
        case "Sort by Department":
            filteredEmployees.sort { $0.department < $1.department }
        case "Sort by Position":
            filteredEmployees.sort { $0.position < $1.position }
        case "Sort by Salary":
            filteredEmployees.sort { $0.salary < $1.salary }
        case "Sort by Start Date":
            filteredEmployees.sort { $0.startDate < $1.startDate }
        case "Sort by Status":
            filteredEmployees.sort { $0.status < $1.status }
        default:
            break
        }
        updateUI()
    }
    
    @objc private func rowDoubleClicked() {
        let selectedRow = tableView.selectedRow
        if selectedRow >= 0 && selectedRow < filteredEmployees.count {
            let employee = filteredEmployees[selectedRow]
            showEmployeeDetails(employee)
        }
    }
    
    private func showEmployeeDetails(_ employee: Employee) {
        let alert = NSAlert()
        alert.messageText = "Employee Details"
        alert.informativeText = """
        Name: \(employee.name)
        Department: \(employee.department)
        Position: \(employee.position)
        Salary: \(employee.salary)
        Start Date: \(employee.startDate)
        Status: \(employee.status)
        Email: \(employee.email)
        Phone: \(employee.phone)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - NSTableViewDataSource
extension MissingTableHeader: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filteredEmployees.count
    }
}

// MARK: - NSTableViewDelegate
extension MissingTableHeader: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let employee = filteredEmployees[row]ng <td> elements instead of <th> for column headers
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            let textField = NSTextField()
            textField.isEditable = false
            textField.isBordered = false
            textField.backgroundColor = .clear
            textField.font = NSFont.systemFont(ofSize: 14)
            
            switch column.identifier.rawValue {
            case "name":
                textField.stringValue = employee.name
                textField.font = NSFont.boldSystemFont(ofSize: 14)
            case "department":
                textField.stringValue = "\(employee.department) • \(employee.position)"
                textField.textColor = .secondaryLabelColor
                textField.font = NSFont.systemFont(ofSize: 12)
            case "salary":
                textField.stringValue = "\(employee.salary) • \(employee.startDate)"
                textField.textColor = .secondaryLabelColor
                textField.font = NSFont.systemFont(ofSize: 12)
            case "contact":
                textField.stringValue = "\(employee.email) • \(employee.phone)"
                textField.textColor = .secondaryLabelColor
                textField.font = NSFont.systemFont(ofSize: 12)
            case "status":
                textField.stringValue = employee.status
                textField.textColor = .secondaryLabelColor
                textField.font = NSFont.systemFont(ofSize: 12)
            case "actions":
                let button = NSButton()
                button.title = "👁️"
                button.font = NSFont.systemFont(ofSize: 16)
                button.target = self
                button.action = #selector(viewButtonTapped)
                button.tag = row
                return button
            default:
                textField.stringValue = ""
            }
            
            cellView.textField = textField
            cellView.addSubview(textField)
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
                textField.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
            ])
        }
        
        return cellView
    }
    
    @objc private func viewButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < filteredEmployees.count {
            let employee = filteredEmployees[row]
            showEmployeeDetails(employee)
        }
    }
}

// MARK: - Employee Model
struct Employee {
    let name: String
    let department: String
    let position: String
    let salary: String
    let startDate: String
    let status: String
    let email: String
    let phone: String
}

// MARK: - Storyboard Support
extension MissingTableHeader {
    static func instantiate() -> MissingTableHeader {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "MissingTableHeader") as! MissingTableHeader
    }
}
