import SwiftUI

struct MissingTableHeader: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var sortBy = "name"
    @State private var sortOrder = "asc"
    @State private var selectedEmployee: Employee?
    @State private var showAddEmployee = false
    @State private var showFilters = false
    @State private var selectedDepartment = "all"
    @State private var selectedStatus = "all"
    
    let departments = ["all", "Engineering", "Marketing", "Sales", "HR", "Finance"]
    let statuses = ["all", "Active", "Inactive", "On Leave"]
    let sortOptions = ["name", "department", "position", "salary", "hireDate"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    HStack {
                        Text("Employee Directory")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            showAddEmployee = true
                        }) {
                            Image(systemName: "person.badge.plus")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search employees...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Filter Controls
                HStack {
                    Picker("Department", selection: $selectedDepartment) {
                        ForEach(departments, id: \.self) { dept in
                            Text(dept).tag(dept)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("More Filters")
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Employee List
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // Table Header (missing proper accessibility)
                        HStack {
                            Button(action: {
                                sortBy = "name"
                                sortOrder = sortOrder == "asc" ? "desc" : "asc"
                            }) {
                                HStack {
                                    Text("Name")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: sortBy == "name" ? (sortOrder == "asc" ? "arrow.up" : "arrow.down") : "arrow.up.arrow.down")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                sortBy = "department"
                                sortOrder = sortOrder == "asc" ? "desc" : "asc"
                            }) {
                                HStack {
                                    Text("Department")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: sortBy == "department" ? (sortOrder == "asc" ? "arrow.up" : "arrow.down") : "arrow.up.arrow.down")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                sortBy = "position"
                                sortOrder = sortOrder == "asc" ? "desc" : "asc"
                            }) {
                                HStack {
                                    Text("Position")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: sortBy == "position" ? (sortOrder == "asc" ? "arrow.up" : "arrow.down") : "arrow.up.arrow.down")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                sortBy = "salary"
                                sortOrder = sortOrder == "asc" ? "desc" : "asc"
                            }) {
                                HStack {
                                    Text("Salary")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: sortBy == "salary" ? (sortOrder == "asc" ? "arrow.up" : "arrow.down") : "arrow.up.arrow.down")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                sortBy = "hireDate"
                                sortOrder = sortOrder == "asc" ? "desc" : "asc"
                            }) {
                                HStack {
                                    Text("Hire Date")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: sortBy == "hireDate" ? (sortOrder == "asc" ? "arrow.up" : "arrow.down") : "arrow.up.arrow.down")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                        
                        // Employee Rows
                        ForEach(filteredEmployees) { employee in
                            EmployeeRow(employee: employee) {
                                selectedEmployee = employee
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedEmployee) { employee in
                EmployeeDetailView(employee: employee)
            }
            .sheet(isPresented: $showAddEmployee) {
                AddEmployeeView()
            }
            .sheet(isPresented: $showFilters) {
                FilterView(
                    selectedDepartment: $selectedDepartment,
                    selectedStatus: $selectedStatus
                )
            }
        }
    }
    
    var filteredEmployees: [Employee] {
        var employees = sampleEmployees
        
        if selectedDepartment != "all" {
            employees = employees.filter { $0.department == selectedDepartment }
        }
        
        if selectedStatus != "all" {
            employees = employees.filter { $0.status == selectedStatus }
        }
        
        if !searchText.isEmpty {
            employees = employees.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.position.localizedCaseInsensitiveContains(searchText) ||
                $0.department.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        switch sortBy {
        case "name":
            employees = employees.sorted { sortOrder == "asc" ? $0.name < $1.name : $0.name > $1.name }
        case "department":
            employees = employees.sorted { sortOrder == "asc" ? $0.department < $1.department : $0.department > $1.department }
        case "position":
            employees = employees.sorted { sortOrder == "asc" ? $0.position < $1.position : $0.position > $1.position }
        case "salary":
            employees = employees.sorted { sortOrder == "asc" ? $0.salary < $1.salary : $0.salary > $1.salary }
        case "hireDate":
            employees = employees.sorted { sortOrder == "asc" ? $0.hireDate < $1.hireDate : $0.hireDate > $1.hireDate }
        default:
            break
        }
        
        return employees
    }
}

struct EmployeeRow: View {
    let employee: Employee
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            // Profile Image
            AsyncImage(url: URL(string: employee.profileImageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            // Name
            VStack(alignment: .leading, spacing: 2) {
                Text(employee.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(employee.email)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Department
            Text(employee.department)
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Position
            Text(employee.position)
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Salary
            Text("$\(employee.salary, specifier: "%.0f")")
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Hire Date
            Text(employee.hireDate, style: .date)
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Status Badge
            Text(employee.status)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor(employee.status))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .padding()
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
        .onTapGesture {
            onTap()
        }
    }
    
    private func statusColor(_ status: String) -> Color {
        switch status {
        case "Active":
            return .green
        case "Inactive":
            return .red
        case "On Leave":
            return .orange
        default:
            return .gray
        }
    }
}

struct EmployeeDetailView: View {
    let employee: Employee
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: employee.profileImageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.gray)
                                        .font(.largeTitle)
                                )
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        
                        VStack(spacing: 8) {
                            Text(employee.name)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(employee.position)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text(employee.department)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // Employee Details
                    VStack(alignment: .leading, spacing: 16) {
                        DetailRow(title: "Email", value: employee.email, icon: "envelope")
                        DetailRow(title: "Phone", value: employee.phone, icon: "phone")
                        DetailRow(title: "Salary", value: "$\(employee.salary, specifier: "%.0f")", icon: "dollarsign.circle")
                        DetailRow(title: "Hire Date", value: employee.hireDate, style: .date, icon: "calendar")
                        DetailRow(title: "Status", value: employee.status, icon: "person.circle")
                        DetailRow(title: "Manager", value: employee.manager, icon: "person.2")
                        DetailRow(title: "Location", value: employee.location, icon: "location")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            // Edit employee
                        }) {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        
                        Button(action: {
                            // Send message
                        }) {
                            HStack {
                                Image(systemName: "message")
                                Text("Message")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Employee Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    let icon: String
    var style: Date.FormatStyle = .none
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if style != .none {
                    Text(value, style: style)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                } else {
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
        }
    }
}

struct AddEmployeeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var position = ""
    @State private var department = "Engineering"
    @State private var salary = ""
    @State private var hireDate = Date()
    @State private var manager = ""
    @State private var location = ""
    @State private var isLoading = false
    @State private var showSuccess = false
    
    let departments = ["Engineering", "Marketing", "Sales", "HR", "Finance"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Add New Employee")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Fill in the employee details below")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("First Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("First name", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last Name")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("Last name", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email Address")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("email@company.com", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("(555) 123-4567", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)
                        }
                        
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Position")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                TextField("Job title", text: $position)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Department")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Picker("Department", selection: $department) {
                                    ForEach(departments, id: \.self) { dept in
                                        Text(dept).tag(dept)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Salary")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Annual salary", text: $salary)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hire Date")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            DatePicker("", selection: $hireDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Manager")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Manager name", text: $manager)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Office location", text: $location)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    Button(action: {
                        addEmployee()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Add Employee")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading || name.isEmpty || email.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Add Employee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Employee added successfully!")
            }
        }
    }
    
    private func addEmployee() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            showSuccess = true
        }
    }
}

struct FilterView: View {
    @Binding var selectedDepartment: String
    @Binding var selectedStatus: String
    @Environment(\.dismiss) private var dismiss
    @State private var salaryRange: ClosedRange<Double> = 30000...200000
    @State private var hireDateRange: ClosedRange<Date> = Date().addingTimeInterval(-31536000*10)...Date()
    
    let departments = ["all", "Engineering", "Marketing", "Sales", "HR", "Finance"]
    let statuses = ["all", "Active", "Inactive", "On Leave"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Department") {
                    Picker("Department", selection: $selectedDepartment) {
                        ForEach(departments, id: \.self) { dept in
                            Text(dept).tag(dept)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Status") {
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Salary Range") {
                    VStack {
                        HStack {
                            Text("$\(Int(salaryRange.lowerBound))")
                            Spacer()
                            Text("$\(Int(salaryRange.upperBound))")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        
                        RangeSlider(range: $salaryRange, in: 20000...300000, step: 5000)
                    }
                }
                
                Section("Hire Date Range") {
                    VStack {
                        DatePicker("From", selection: $hireDateRange.lowerBound, displayedComponents: .date)
                        DatePicker("To", selection: $hireDateRange.upperBound, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedDepartment = "all"
                        selectedStatus = "all"
                        salaryRange = 30000...200000
                        hireDateRange = Date().addingTimeInterval(-31536000*10)...Date()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Data Models
struct Employee: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let email: String
    let phone: String
    let position: String
    let department: String
    let salary: Double
    let hireDate: Date
    let status: String
    let manager: String
    let location: String
    let profileImageURL: String
}

let sampleEmployees = [
    Employee(
        name: "John Smith",
        email: "john.smith@company.com",
        phone: "(555) 123-4567",
        position: "Software Engineer",
        department: "Engineering",
        salary: 95000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 2),
        status: "Active",
        manager: "Sarah Johnson",
        location: "New York",
        profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150"
    ),
    Employee(
        name: "Sarah Johnson",
        email: "sarah.johnson@company.com",
        phone: "(555) 234-5678",
        position: "Engineering Manager",
        department: "Engineering",
        salary: 120000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 5),
        status: "Active",
        manager: "Mike Chen",
        location: "New York",
        profileImageURL: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150"
    ),
    Employee(
        name: "Mike Chen",
        email: "mike.chen@company.com",
        phone: "(555) 345-6789",
        position: "VP of Engineering",
        department: "Engineering",
        salary: 180000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 8),
        status: "Active",
        manager: "CEO",
        location: "San Francisco",
        profileImageURL: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150"
    ),
    Employee(
        name: "Emily Davis",
        email: "emily.davis@company.com",
        phone: "(555) 456-7890",
        position: "Marketing Specialist",
        department: "Marketing",
        salary: 65000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 1),
        status: "Active",
        manager: "David Wilson",
        location: "Chicago",
        profileImageURL: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150"
    ),
    Employee(
        name: "David Wilson",
        email: "david.wilson@company.com",
        phone: "(555) 567-8901",
        position: "Marketing Director",
        department: "Marketing",
        salary: 110000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 4),
        status: "Active",
        manager: "Lisa Brown",
        location: "Chicago",
        profileImageURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150"
    ),
    Employee(
        name: "Lisa Brown",
        email: "lisa.brown@company.com",
        phone: "(555) 678-9012",
        position: "Sales Manager",
        department: "Sales",
        salary: 100000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 3),
        status: "On Leave",
        manager: "Tom Anderson",
        location: "Los Angeles",
        profileImageURL: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
    ),
    Employee(
        name: "Tom Anderson",
        email: "tom.anderson@company.com",
        phone: "(555) 789-0123",
        position: "HR Director",
        department: "HR",
        salary: 105000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 6),
        status: "Active",
        manager: "CEO",
        location: "Seattle",
        profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150"
    ),
    Employee(
        name: "Anna Garcia",
        email: "anna.garcia@company.com",
        phone: "(555) 890-1234",
        position: "Financial Analyst",
        department: "Finance",
        salary: 75000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 2),
        status: "Active",
        manager: "Kevin Lee",
        location: "Boston",
        profileImageURL: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150"
    ),
    Employee(
        name: "Kevin Lee",
        email: "kevin.lee@company.com",
        phone: "(555) 901-2345",
        position: "CFO",
        department: "Finance",
        salary: 200000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 10),
        status: "Active",
        manager: "CEO",
        location: "Boston",
        profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150"
    ),
    Employee(
        name: "Rachel Green",
        email: "rachel.green@company.com",
        phone: "(555) 012-3456",
        position: "UX Designer",
        department: "Engineering",
        salary: 85000,
        hireDate: Date().addingTimeInterval(-86400 * 365 * 1),
        status: "Inactive",
        manager: "Sarah Johnson",
        location: "Remote",
        profileImageURL: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"
    )
]

struct MissingTableHeader_Previews: PreviewProvider {
    static var previews: some View {
        MissingTableHeader()
    }
}

