import SwiftUI

struct DataTableComplex: View {
    @State private var data: [Employee] = []
    @State private var filteredData: [Employee] = []
    @State private var sortColumn: String = ""
    @State private var sortDirection: SortDirection = .ascending
    @State private var searchQuery: String = ""
    @State private var selectedRows: Set<UUID> = []
    @State private var currentPage: Int = 1
    @State private var itemsPerPage: Int = 10
    @State private var showFilters: Bool = false
    @State private var columnFilters: [String: String] = [:]
    @State private var isLoading: Bool = false
    
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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                controlsView
                
                if showFilters {
                    filtersView
                }
                
                if isLoading {
                    loadingView
                } else if filteredData.isEmpty {
                    emptyStateView
                } else {
                    tableView
                }
                
                if !selectedRows.isEmpty {
                    bulkActionsView
                }
                
                paginationView
            }
            .navigationTitle("Employee Data Table")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadData()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Employee Data Table")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: { showFilters.toggle() }) {
                    Text(showFilters ? "Hide" : "Show")
                    Text("Filters")
                }
                .buttonStyle(.bordered)
                
                Button("Export CSV") {
                    exportData(format: "csv")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Export Excel") {
                    exportData(format: "excel")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var controlsView: some View {
        HStack {
            HStack {
                TextField("Search all columns...", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        handleSearch()
                    }
                
                Button(action: handleSearch) {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
            
            Text("Showing \(startItem)-\(endItem) of \(filteredData.count) entries")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Filters")
                    .font(.headline)
                Spacer()
                Button("Clear All") {
                    clearFilters()
                }
                .buttonStyle(.bordered)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                ForEach(columns.filter { $0.filterable }, id: \.key) { column in
                    VStack(alignment: .leading) {
                        Text(column.title)
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        TextField("Filter by \(column.title.lowercased())...", text: Binding(
                            get: { columnFilters[column.key] ?? "" },
                            set: { columnFilters[column.key] = $0 }
                        ))
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: columnFilters[column.key]) { _ in
                            applyFiltersAndSort()
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var tableView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: handleSelectAll) {
                        Image(systemName: isAllSelected ? "checkmark.square.fill" : "square")
                            .foregroundColor(isAllSelected ? .blue : .gray)
                    }
                    .buttonStyle(.plain)
                    
                    ForEach(columns, id: \.key) { column in
                        Button(action: { handleSort(column) }) {
                            HStack {
                                Text(column.title)
                                    .fontWeight(.semibold)
                                
                                if sortColumn == column.key {
                                    Image(systemName: sortDirection == .ascending ? "arrow.up" : "arrow.down")
                                        .font(.caption)
                                } else if column.sortable {
                                    Image(systemName: "arrow.up.arrow.down")
                                        .font(.caption)
                                        .opacity(0.3)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                
                // Data rows
                ForEach(paginatedData) { employee in
                    HStack {
                        Button(action: { handleSelectRow(employee.id) }) {
                            Image(systemName: selectedRows.contains(employee.id) ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedRows.contains(employee.id) ? .blue : .gray)
                        }
                        .buttonStyle(.plain)
                        
                        Text("\(employee.id)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(employee.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(employee.email)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(employee.department)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(employee.position)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(formatCurrency(employee.salary))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(employee.status)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(statusColor(employee.status))
                            .foregroundColor(.white)
                            .cornerRadius(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(formatDate(employee.joinDate))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 8) {
                            Button(action: { handleRowAction("edit", employee.id) }) {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(.bordered)
                            
                            Button(action: { handleRowAction("view", employee.id) }) {
                                Image(systemName: "eye")
                            }
                            .buttonStyle(.bordered)
                            
                            Button(action: { handleRowAction("delete", employee.id) }) {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(selectedRows.contains(employee.id) ? Color.blue.opacity(0.1) : Color.clear)
                    .onTapGesture {
                        handleSelectRow(employee.id)
                    }
                    
                    Divider()
                }
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading data...")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "table")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            Text("No data found")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Try adjusting your search or filter criteria")
                .foregroundColor(.secondary)
            
            Button("Clear all filters") {
                clearFilters()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var bulkActionsView: some View {
        HStack {
            Text("\(selectedRows.count) row\(selectedRows.count == 1 ? "" : "s") selected")
                .fontWeight(.semibold)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button("Export Selected") {
                    handleBulkAction("export")
                }
                .buttonStyle(.bordered)
                
                Button("Delete Selected") {
                    handleBulkAction("delete")
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                
                Button("Update Selected") {
                    handleBulkAction("update")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
    }
    
    private var paginationView: some View {
        HStack {
            Text("Page \(currentPage) of \(totalPages)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            HStack(spacing: 8) {
                Button("← Previous") {
                    previousPage()
                }
                .disabled(currentPage == 1)
                .buttonStyle(.bordered)
                
                ForEach(visiblePages, id: \.self) { page in
                    Button("\(page)") {
                        goToPage(page)
                    }
                    .buttonStyle(page == currentPage ? .borderedProminent : .bordered)
                }
                
                Button("Next →") {
                    nextPage()
                }
                .disabled(currentPage == totalPages)
                .buttonStyle(.bordered)
            }
            
            Spacer()
            
            HStack {
                Text("Items per page:")
                    .font(.caption)
                
                Picker("Items per page", selection: $itemsPerPage) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("25").tag(25)
                    Text("50").tag(50)
                    Text("100").tag(100)
                }
                .pickerStyle(.menu)
                .onChange(of: itemsPerPage) { _ in
                    currentPage = 1
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // MARK: - Computed Properties
    
    private var paginatedData: [Employee] {
        let start = (currentPage - 1) * itemsPerPage
        let end = start + itemsPerPage
        return Array(filteredData[start..<min(end, filteredData.count)])
    }
    
    private var totalPages: Int {
        Int(ceil(Double(filteredData.count) / Double(itemsPerPage)))
    }
    
    private var startItem: Int {
        (currentPage - 1) * itemsPerPage + 1
    }
    
    private var endItem: Int {
        min(currentPage * itemsPerPage, filteredData.count)
    }
    
    private var isAllSelected: Bool {
        !paginatedData.isEmpty && selectedRows.count == paginatedData.count
    }
    
    private var visiblePages: [Int] {
        let start = max(1, currentPage - 2)
        let end = min(totalPages, currentPage + 2)
        return Array(start...end)
    }
    
    // MARK: - Methods
    
    private func loadData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            data = generateSampleData()
            filteredData = data
            isLoading = false
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
                joinDate: Date().addingTimeInterval(-Double.random(in: 0...126144000)) // Random date within last 4 years
            ))
        }
        
        return employees
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
    
    private func handleSearch() {
        currentPage = 1
        applyFiltersAndSort()
    }
    
    private func applyFiltersAndSort() {
        var filtered = data
        
        // Apply search filter
        if !searchQuery.isEmpty {
            filtered = filtered.filter { employee in
                String(employee.id).contains(searchQuery) ||
                employee.name.localizedCaseInsensitiveContains(searchQuery) ||
                employee.email.localizedCaseInsensitiveContains(searchQuery) ||
                employee.department.localizedCaseInsensitiveContains(searchQuery) ||
                employee.position.localizedCaseInsensitiveContains(searchQuery) ||
                String(employee.salary).contains(searchQuery) ||
                employee.status.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        
        // Apply column filters
        for (column, value) in columnFilters {
            if !value.isEmpty {
                filtered = filtered.filter { employee in
                    switch column {
                    case "name":
                        return employee.name.localizedCaseInsensitiveContains(value)
                    case "email":
                        return employee.email.localizedCaseInsensitiveContains(value)
                    case "department":
                        return employee.department.localizedCaseInsensitiveContains(value)
                    case "position":
                        return employee.position.localizedCaseInsensitiveContains(value)
                    case "salary":
                        return String(employee.salary).contains(value)
                    case "status":
                        return employee.status.localizedCaseInsensitiveContains(value)
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
    }
    
    private func handleSelectAll() {
        if selectedRows.count == paginatedData.count {
            selectedRows.removeAll()
        } else {
            selectedRows = Set(paginatedData.map { $0.id })
        }
    }
    
    private func handleSelectRow(_ id: UUID) {
        if selectedRows.contains(id) {
            selectedRows.remove(id)
        } else {
            selectedRows.insert(id)
        }
    }
    
    private func handleBulkAction(_ action: String) {
        if selectedRows.isEmpty {
            // Show alert
            return
        }
        
        print("Bulk action: \(action) on \(selectedRows.count) selected rows")
        // Handle bulk action
    }
    
    private func handleRowAction(_ action: String, _ id: UUID) {
        print("Row action: \(action) on row \(id)")
        // Handle row action
    }
    
    private func exportData(format: String) {
        print("Exporting data as \(format)")
        // Handle export
    }
    
    private func clearFilters() {
        searchQuery = ""
        columnFilters.removeAll()
        currentPage = 1
        applyFiltersAndSort()
    }
    
    private func goToPage(_ page: Int) {
        currentPage = page
    }
    
    private func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
        }
    }
    
    private func nextPage() {
        if currentPage < totalPages {
            currentPage += 1
        }
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
    
    private func statusColor(_ status: String) -> Color {
        switch status {
        case "Active":
            return .green
        case "Inactive":
            return .red
        case "Pending":
            return .orange
        case "Terminated":
            return .gray
        default:
            return .blue
        }
    }
}

// MARK: - Supporting Types

struct Employee: Identifiable {
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

// MARK: - Preview

struct DataTableComplex_Previews: PreviewProvider {
    static var previews: some View {
        DataTableComplex()
    }
}
