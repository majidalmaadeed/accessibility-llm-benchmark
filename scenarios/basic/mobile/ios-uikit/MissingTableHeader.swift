import UIKit

class MissingTableHeaderViewController: UIViewController {
    
    private var tableView: UITableView!
    private var data: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    private func setupData() {
        data = [
            Employee(
                id: 1,
                name: "John Smith",
                department: "Engineering",
                position: "Senior Developer",
                email: "john.smith@company.com",
                phone: "+1 (555) 123-4567",
                salary: 95000,
                startDate: Date().addingTimeInterval(-86400 * 365 * 2),
                isActive: true
            ),
            Employee(
                id: 2,
                name: "Sarah Johnson",
                department: "Marketing",
                position: "Marketing Manager",
                email: "sarah.johnson@company.com",
                phone: "+1 (555) 234-5678",
                salary: 78000,
                startDate: Date().addingTimeInterval(-86400 * 365),
                isActive: true
            ),
            Employee(
                id: 3,
                name: "Mike Wilson",
                department: "Sales",
                position: "Sales Director",
                email: "mike.wilson@company.com",
                phone: "+1 (555) 345-6789",
                salary: 120000,
                startDate: Date().addingTimeInterval(-86400 * 365 * 3),
                isActive: true
            ),
            Employee(
                id: 4,
                name: "Emily Davis",
                department: "HR",
                position: "HR Specialist",
                email: "emily.davis@company.com",
                phone: "+1 (555) 456-7890",
                salary: 65000,
                startDate: Date().addingTimeInterval(-86400 * 180),
                isActive: true
            ),
            Employee(
                id: 5,
                name: "David Brown",
                department: "Finance",
                position: "Financial Analyst",
                email: "david.brown@company.com",
                phone: "+1 (555) 567-8901",
                salary: 72000,
                startDate: Date().addingTimeInterval(-86400 * 365 * 4),
                isActive: false
            ),
            Employee(
                id: 6,
                name: "Lisa Anderson",
                department: "Engineering",
                position: "Product Manager",
                email: "lisa.anderson@company.com",
                phone: "+1 (555) 678-9012",
                salary: 110000,
                startDate: Date().addingTimeInterval(-86400 * 365 * 5),
                isActive: true
            ),
            Employee(
                id: 7,
                name: "Robert Taylor",
                department: "Operations",
                position: "Operations Manager",
                email: "robert.taylor@company.com",
                phone: "+1 (555) 789-0123",
                salary: 85000,
                startDate: Date().addingTimeInterval(-86400 * 365 * 6),
                isActive: true
            ),
            Employee(
                id: 8,
                name: "Jennifer Martinez",
                department: "Customer Service",
                position: "Customer Success Manager",
                email: "jennifer.martinez@company.com",
                phone: "+1 (555) 890-1234",
                salary: 68000,
                startDate: Date().addingTimeInterval(-86400 * 200),
                isActive: true
            )
        ]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Employee Directory"
        
        // Search bar
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search employees..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Filter controls
        let filterStackView = UIStackView()
        filterStackView.axis = .horizontal
        filterStackView.distribution = .fillEqually
        filterStackView.spacing = 12
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterStackView)
        
        let departmentButton = UIButton(type: .system)
        departmentButton.setTitle("Department", for: .normal)
        departmentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        departmentButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        departmentButton.layer.cornerRadius = 8
        departmentButton.addTarget(self, action: #selector(departmentFilterTapped), for: .touchUpInside)
        filterStackView.addArrangedSubview(departmentButton)
        
        let statusButton = UIButton(type: .system)
        statusButton.setTitle("Status", for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        statusButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        statusButton.layer.cornerRadius = 8
        statusButton.addTarget(self, action: #selector(statusFilterTapped), for: .touchUpInside)
        filterStackView.addArrangedSubview(statusButton)
        
        let sortButton = UIButton(type: .system)
        sortButton.setTitle("Sort", for: .normal)
        sortButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sortButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        sortButton.layer.cornerRadius = 8
        sortButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        filterStackView.addArrangedSubview(sortButton)
        
        // Table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Results count
        let resultsLabel = UILabel()
        resultsLabel.text = "\(data.count) employees found"
        resultsLabel.font = UIFont.systemFont(ofSize: 14)
        resultsLabel.textColor = .secondaryLabel
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            filterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterStackView.heightAnchor.constraint(equalToConstant: 40),
            
            resultsLabel.topAnchor.constraint(equalTo: filterStackView.bottomAnchor, constant: 8),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func departmentFilterTapped() {
        let alert = UIAlertController(title: "Filter by Department", message: "Select department to filter", preferredStyle: .actionSheet)
        
        let departments = Array(Set(data.map { $0.department })).sorted()
        
        alert.addAction(UIAlertAction(title: "All Departments", style: .default) { _ in
            // Show all employees
        })
        
        for department in departments {
            alert.addAction(UIAlertAction(title: department, style: .default) { _ in
                // Filter by department
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func statusFilterTapped() {
        let alert = UIAlertController(title: "Filter by Status", message: "Select status to filter", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All Employees", style: .default) { _ in
            // Show all employees
        })
        
        alert.addAction(UIAlertAction(title: "Active Only", style: .default) { _ in
            // Filter active employees
        })
        
        alert.addAction(UIAlertAction(title: "Inactive Only", style: .default) { _ in
            // Filter inactive employees
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func sortTapped() {
        let alert = UIAlertController(title: "Sort Employees", message: "Choose sorting option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Name A-Z", style: .default) { _ in
            self.data.sort { $0.name < $1.name }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Name Z-A", style: .default) { _ in
            self.data.sort { $0.name > $1.name }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Department", style: .default) { _ in
            self.data.sort { $0.department < $1.department }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Salary High to Low", style: .default) { _ in
            self.data.sort { $0.salary > $1.salary }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Start Date", style: .default) { _ in
            self.data.sort { $0.startDate > $1.startDate }
            self.tableView.reloadData()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MissingTableHeaderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        let employee = data[indexPath.row]
        cell.configure(with: employee)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MissingTableHeaderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let employee = data[indexPath.row]
        showEmployeeDetail(employee)
    }
}

// MARK: - UISearchBarDelegate
extension MissingTableHeaderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Implement search functionality
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Employee Detail
extension MissingTableHeaderViewController {
    private func showEmployeeDetail(_ employee: Employee) {
        let alert = UIAlertController(title: employee.name, message: "Department: \(employee.department)\nPosition: \(employee.position)\nEmail: \(employee.email)\nPhone: \(employee.phone)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default) { _ in
            // Edit employee
        })
        
        alert.addAction(UIAlertAction(title: "Contact", style: .default) { _ in
            // Contact employee
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Employee Cell
class EmployeeCell: UITableViewCell {
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let departmentLabel = UILabel()
    private let positionLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let salaryLabel = UILabel()
    private let statusLabel = UILabel()
    private let startDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .default
        backgroundColor = .systemBackground
        
        // Container view
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        // Name label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)
        
        // Department label
        departmentLabel.font = UIFont.systemFont(ofSize: 14)
        departmentLabel.textColor = .systemBlue
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(departmentLabel)
        
        // Position label
        positionLabel.font = UIFont.systemFont(ofSize: 14)
        positionLabel.textColor = .secondaryLabel
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(positionLabel)
        
        // Email label
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        emailLabel.textColor = .tertiaryLabel
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(emailLabel)
        
        // Phone label
        phoneLabel.font = UIFont.systemFont(ofSize: 12)
        phoneLabel.textColor = .tertiaryLabel
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(phoneLabel)
        
        // Salary label
        salaryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        salaryLabel.textColor = .systemGreen
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(salaryLabel)
        
        // Status label
        statusLabel.font = UIFont.systemFont(ofSize: 12)
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 4
        statusLabel.clipsToBounds = true
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(statusLabel)
        
        // Start date label
        startDateLabel.font = UIFont.systemFont(ofSize: 12)
        startDateLabel.textColor = .tertiaryLabel
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(startDateLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            departmentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            departmentLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            positionLabel.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 2),
            positionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            positionLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            emailLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            emailLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2),
            phoneLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            phoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            salaryLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 2),
            salaryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            salaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            salaryLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8),
            
            statusLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            statusLabel.widthAnchor.constraint(equalToConstant: 60),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            
            startDateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            startDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            startDateLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(with employee: Employee) {
        nameLabel.text = employee.name
        departmentLabel.text = employee.department
        positionLabel.text = employee.position
        emailLabel.text = employee.email
        phoneLabel.text = employee.phone
        salaryLabel.text = String(format: "$%.0f", employee.salary)
        
        if employee.isActive {
            statusLabel.text = "Active"
            statusLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            statusLabel.textColor = .systemGreen
        } else {
            statusLabel.text = "Inactive"
            statusLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            statusLabel.textColor = .systemRed
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        startDateLabel.text = formatter.string(from: employee.startDate)
    }
}

// MARK: - Data Models
struct Employee {
    let id: Int
    let name: String
    let department: String
    let position: String
    let email: String
    let phone: String
    let salary: Double
    let startDate: Date
    let isActive: Bool
}
