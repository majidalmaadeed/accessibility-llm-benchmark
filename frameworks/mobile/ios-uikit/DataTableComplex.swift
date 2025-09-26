import UIKit

class DataTableComplexViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var filterButton: UIBarButtonItem!
    private var exportButton: UIBarButtonItem!
    private var refreshControl: UIRefreshControl!
    
    private var data: [Employee] = []
    private var filteredData: [Employee] = []
    private var selectedRows: Set<UUID> = []
    private var currentPage: Int = 1
    private var itemsPerPage: Int = 10
    private var sortColumn: String = ""
    private var sortDirection: SortDirection = .ascending
    private var showFilters: Bool = false
    private var columnFilters: [String: String] = [:]
    private var isLoading: Bool = false
    
    let columns = [
        GridColumn("ID", key: "id"),
        GridColumn("Name", key: "name"),
        GridColumn("Email", key: "email"),
        GridColumn("Department", key: "department"),
        GridColumn("Position", key: "position"),
        GridColumn("Salary", key: "salary"),
        GridColumn("Status", key: "status"),
        GridColumn("Join Date", key: "joinDate"),
        GridColumn("Actions", key: "actions")
    ]
    
    let departments = ["Engineering", "Marketing", "Sales", "HR", "Finance"]
    let positions = ["Manager", "Developer", "Designer", "Analyst", "Coordinator"]
    let statuses = ["Active", "Inactive", "Pending", "Terminated"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Employee Data Table"
        
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        filterButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(toggleFilters)
        )
        
        exportButton = UIBarButtonItem(
            title: "Export",
            style: .plain,
            target: self,
            action: #selector(exportData)
        )
        
        navigationItem.rightBarButtonItems = [exportButton, filterButton]
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeCell")
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeader")
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search all columns..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Data Management
    
    private func loadData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.data = self.generateSampleData()
            self.filteredData = self.data
            self.tableView.reloadData()
            self.isLoading = false
        }
    }
    
    private func generateSampleData() -> [Employee] {
        var employees: [Employee] = []
        
        for i in 1...100 {
            employees.append(Employee(
                id: i,
                name: "Employee \(i)",
                email: "employee\(i)@company.com",
                department: departments.randomElement() ?? "Engineering",
                position: positions.randomElement() ?? "Developer",
                salary: Double.random(in: 40000...140000),
                status: statuses.randomElement() ?? "Active",
                joinDate: Date().addingTimeInterval(-Double.random(in: 0...126144000))
            ))
        }
        
        return employees
    }
    
    private func applyFiltersAndSort() {
        var filtered = data
        
        // Apply search filter
        if !searchBar.text?.isEmpty ?? true {
            let searchText = searchBar.text?.lowercased() ?? ""
            filtered = filtered.filter { employee in
                String(employee.id).contains(searchText) ||
                employee.name.lowercased().contains(searchText) ||
                employee.email.lowercased().contains(searchText) ||
                employee.department.lowercased().contains(searchText) ||
                employee.position.lowercased().contains(searchText) ||
                String(employee.salary).contains(searchText) ||
                employee.status.lowercased().contains(searchText)
            }
        }
        
        // Apply column filters
        for (column, value) in columnFilters {
            if !value.isEmpty {
                filtered = filtered.filter { employee in
                    switch column {
                    case "name":
                        return employee.name.lowercased().contains(value.lowercased())
                    case "email":
                        return employee.email.lowercased().contains(value.lowercased())
                    case "department":
                        return employee.department.lowercased().contains(value.lowercased())
                    case "position":
                        return employee.position.lowercased().contains(value.lowercased())
                    case "salary":
                        return String(employee.salary).contains(value)
                    case "status":
                        return employee.status.lowercased().contains(value.lowercased())
                    default:
                        return true
                    }
                }
            }
        }
        
        // Apply sorting
        if !sortColumn.isEmpty {
            filtered.sort { employee1, employee2 in
                let result: ComparisonResult
                
                switch sortColumn {
                case "id":
                    result = employee1.id.compare(employee2.id)
                case "name":
                    result = employee1.name.compare(employee2.name)
                case "email":
                    result = employee1.email.compare(employee2.email)
                case "department":
                    result = employee1.department.compare(employee2.department)
                case "position":
                    result = employee1.position.compare(employee2.position)
                case "salary":
                    result = employee1.salary.compare(employee2.salary)
                case "status":
                    result = employee1.status.compare(employee2.status)
                case "joinDate":
                    result = employee1.joinDate.compare(employee2.joinDate)
                default:
                    result = .orderedSame
                }
                
                return sortDirection == .ascending ? result == .orderedAscending : result == .orderedDescending
            }
        }
        
        filteredData = filtered
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func toggleFilters() {
        showFilters.toggle()
        // Show/hide filter view
    }
    
    @objc private func exportData() {
        // Export data logic
        print("Exporting data")
    }
    
    @objc private func refreshData() {
        loadData()
        refreshControl.endRefreshing()
    }
    
    private func handleSort(_ column: GridColumn) {
        guard column.sortable else { return }
        
        if sortColumn == column.key {
            sortDirection = sortDirection == .ascending ? .descending : .ascending
        } else {
            sortColumn = column.key
            sortDirection = .ascending
        }
        
        applyFiltersAndSort()
    }
    
    private func handleSelectAll() {
        if selectedRows.count == paginatedData.count {
            selectedRows.removeAll()
        } else {
            selectedRows = Set(paginatedData.map { $0.id })
        }
        tableView.reloadData()
    }
    
    private func handleSelectRow(_ id: UUID) {
        if selectedRows.contains(id) {
            selectedRows.remove(id)
        } else {
            selectedRows.insert(id)
        }
    }
    
    private func handleRowAction(_ action: String, _ id: UUID) {
        print("Row action: \(action) on row \(id)")
    }
    
    // MARK: - Computed Properties
    
    private var paginatedData: [Employee] {
        let start = (currentPage - 1) * itemsPerPage
        let end = start + itemsPerPage
        return Array(filteredData[start..<min(end, filteredData.count)])
    }
    
    private var isAllSelected: Bool {
        !paginatedData.isEmpty && selectedRows.count == paginatedData.count
    }
}

// MARK: - UITableViewDataSource

extension DataTableComplexViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeTableViewCell
        let employee = paginatedData[indexPath.row]
        
        cell.configure(with: employee, isSelected: selectedRows.contains(employee.id))
        cell.onSelect = { [weak self] in
            self?.handleSelectRow(employee.id)
        }
        cell.onEdit = { [weak self] in
            self?.handleRowAction("edit", employee.id)
        }
        cell.onView = { [weak self] in
            self?.handleRowAction("view", employee.id)
        }
        cell.onDelete = { [weak self] in
            self?.handleRowAction("delete", employee.id)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DataTableComplexViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as! TableHeaderView
        headerView.configure(with: columns, sortColumn: sortColumn, sortDirection: sortDirection)
        headerView.onSort = { [weak self] column in
            self?.handleSort(column)
        }
        headerView.onSelectAll = { [weak self] in
            self?.handleSelectAll()
        }
        headerView.isAllSelected = isAllSelected
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let employee = paginatedData[indexPath.row]
        handleSelectRow(employee.id)
    }
}

// MARK: - UISearchBarDelegate

extension DataTableComplexViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applyFiltersAndSort()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        applyFiltersAndSort()
    }
}

// MARK: - Supporting Views

class EmployeeTableViewCell: UITableViewCell {
    
    private let selectButton = UIButton(type: .system)
    private let idLabel = UILabel()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let departmentLabel = UILabel()
    private let positionLabel = UILabel()
    private let salaryLabel = UILabel()
    private let statusLabel = UILabel()
    private let joinDateLabel = UILabel()
    private let actionsStackView = UIStackView()
    
    var onSelect: (() -> Void)?
    var onEdit: (() -> Void)?
    var onView: (() -> Void)?
    var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectButton.setImage(UIImage(systemName: "square"), for: .normal)
        selectButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        [idLabel, nameLabel, emailLabel, departmentLabel, positionLabel, salaryLabel, statusLabel, joinDateLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        salaryLabel.textColor = .systemBlue
        salaryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 4
        statusLabel.clipsToBounds = true
        
        actionsStackView.axis = .horizontal
        actionsStackView.spacing = 8
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let editButton = createActionButton(title: "Edit", action: #selector(editButtonTapped))
        let viewButton = createActionButton(title: "View", action: #selector(viewButtonTapped))
        let deleteButton = createActionButton(title: "Delete", action: #selector(deleteButtonTapped))
        deleteButton.setTitleColor(.systemRed, for: .normal)
        
        actionsStackView.addArrangedSubview(editButton)
        actionsStackView.addArrangedSubview(viewButton)
        actionsStackView.addArrangedSubview(deleteButton)
        
        [selectButton, idLabel, nameLabel, emailLabel, departmentLabel, positionLabel, salaryLabel, statusLabel, joinDateLabel, actionsStackView].forEach {
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func createActionButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: 24),
            selectButton.heightAnchor.constraint(equalToConstant: 24),
            
            idLabel.leadingAnchor.constraint(equalTo: selectButton.trailingAnchor, constant: 8),
            idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            idLabel.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: 120),
            
            departmentLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 8),
            departmentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            departmentLabel.widthAnchor.constraint(equalToConstant: 80),
            
            positionLabel.leadingAnchor.constraint(equalTo: departmentLabel.trailingAnchor, constant: 8),
            positionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 80),
            
            salaryLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 8),
            salaryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            salaryLabel.widthAnchor.constraint(equalToConstant: 80),
            
            statusLabel.leadingAnchor.constraint(equalTo: salaryLabel.trailingAnchor, constant: 8),
            statusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 60),
            
            joinDateLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 8),
            joinDateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            joinDateLabel.widthAnchor.constraint(equalToConstant: 80),
            
            actionsStackView.leadingAnchor.constraint(equalTo: joinDateLabel.trailingAnchor, constant: 8),
            actionsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionsStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with employee: Employee, isSelected: Bool) {
        selectButton.isSelected = isSelected
        idLabel.text = "\(employee.id)"
        nameLabel.text = employee.name
        emailLabel.text = employee.email
        departmentLabel.text = employee.department
        positionLabel.text = employee.position
        salaryLabel.text = formatCurrency(employee.salary)
        statusLabel.text = employee.status
        joinDateLabel.text = formatDate(employee.joinDate)
        
        // Configure status label appearance
        switch employee.status {
        case "Active":
            statusLabel.backgroundColor = .systemGreen
            statusLabel.textColor = .white
        case "Inactive":
            statusLabel.backgroundColor = .systemRed
            statusLabel.textColor = .white
        case "Pending":
            statusLabel.backgroundColor = .systemOrange
            statusLabel.textColor = .white
        case "Terminated":
            statusLabel.backgroundColor = .systemGray
            statusLabel.textColor = .white
        default:
            statusLabel.backgroundColor = .systemBlue
            statusLabel.textColor = .white
        }
    }
    
    @objc private func selectButtonTapped() {
        onSelect?()
    }
    
    @objc private func editButtonTapped() {
        onEdit?()
    }
    
    @objc private func viewButtonTapped() {
        onView?()
    }
    
    @objc private func deleteButtonTapped() {
        onDelete?()
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

class TableHeaderView: UITableViewHeaderFooterView {
    
    private let selectAllButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    var onSort: ((GridColumn) -> Void)?
    var onSelectAll: (() -> Void)?
    var isAllSelected: Bool = false {
        didSet {
            selectAllButton.isSelected = isAllSelected
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGray6
        
        selectAllButton.setImage(UIImage(systemName: "square"), for: .normal)
        selectAllButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        selectAllButton.addTarget(self, action: #selector(selectAllButtonTapped), for: .touchUpInside)
        selectAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(selectAllButton)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            selectAllButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selectAllButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectAllButton.widthAnchor.constraint(equalToConstant: 24),
            selectAllButton.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.leadingAnchor.constraint(equalTo: selectAllButton.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with columns: [GridColumn], sortColumn: String, sortDirection: SortDirection) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for column in columns {
            let button = UIButton(type: .system)
            button.setTitle(column.title, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.contentHorizontalAlignment = .left
            
            if column.sortable {
                let imageName = sortColumn == column.key ? 
                    (sortDirection == .ascending ? "arrow.up" : "arrow.down") : 
                    "arrow.up.arrow.down"
                button.setImage(UIImage(systemName: imageName), for: .normal)
                button.semanticContentAttribute = .forceRightToLeft
                button.addTarget(self, action: #selector(columnButtonTapped(_:)), for: .touchUpInside)
                button.tag = columns.firstIndex(where: { $0.key == column.key }) ?? 0
            }
            
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func selectAllButtonTapped() {
        onSelectAll?()
    }
    
    @objc private func columnButtonTapped(_ sender: UIButton) {
        // Handle column sort
    }
}

// MARK: - Supporting Types

struct Employee {
    let id: UUID = UUID()
    let employeeId: Int
    let name: String
    let email: String
    let department: String
    let position: String
    let salary: Double
    let status: String
    let joinDate: Date
    
    init(id: Int, name: String, email: String, department: String, position: String, salary: Double, status: String, joinDate: Date) {
        self.employeeId = id
        self.name = name
        self.email = email
        self.department = department
        self.position = position
        self.salary = salary
        self.status = status
        self.joinDate = joinDate
    }
}

struct GridColumn {
    let title: String
    let key: String
    let sortable: Bool
    let filterable: Bool
    
    init(_ title: String, key: String, sortable: Bool = true, filterable: Bool = true) {
        self.title = title
        self.key = key
        self.sortable = sortable
        self.filterable = filterable
    }
}

enum SortDirection {
    case ascending, descending
}
