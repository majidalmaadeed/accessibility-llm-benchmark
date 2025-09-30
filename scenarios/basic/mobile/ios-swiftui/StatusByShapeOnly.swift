import SwiftUI

struct StatusByShapeOnly: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var showProfile = false
    @State private var notifications = 5
    @State private var selectedCategory = "all"
    @State private var showFilters = false
    @State private var selectedTask: Task?
    @State private var showAddTask = false
    @State private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var showLogin = false
    
    let categories = ["all", "work", "personal", "shopping", "health", "finance"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    HStack {
                        Text("TaskManager")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                showAddTask = true
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            
                            Button(action: {
                                showProfile = true
                            }) {
                                ZStack {
                                    Image(systemName: "person.circle")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                    
                                    if notifications > 0 {
                                        Text("\(notifications)")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                            .offset(x: 8, y: -8)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search tasks...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.capitalized)
                                    .font(.subheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // Filter Controls
                HStack {
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filters")
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("\(filteredTasks.count) tasks")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Tasks List
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredTasks) { task in
                            TaskCard(
                                task: task,
                                onTap: {
                                    selectedTask = task
                                },
                                onToggleComplete: {
                                    toggleTaskComplete(task)
                                },
                                onDelete: {
                                    deleteTask(task)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterView()
            }
            .sheet(item: $selectedTask) { task in
                TaskDetailView(
                    task: task,
                    onToggleComplete: {
                        toggleTaskComplete(task)
                    },
                    onDelete: {
                        deleteTask(task)
                    }
                )
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView()
            }
            .sheet(isPresented: $showProfile) {
                ProfileView(
                    isLoggedIn: $isLoggedIn,
                    username: $username,
                    password: $password,
                    showLogin: $showLogin
                )
            }
            .sheet(isPresented: $showLogin) {
                LoginView(
                    isLoggedIn: $isLoggedIn,
                    username: $username,
                    password: $password
                )
            }
        }
    }
    
    var filteredTasks: [Task] {
        var tasks = sampleTasks
        
        if selectedCategory != "all" {
            tasks = tasks.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            tasks = tasks.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return tasks.sorted { $0.dueDate < $1.dueDate }
    }
    
    private func toggleTaskComplete(_ task: Task) {
        // In a real app, this would update the task in the data source
        print("Toggled task: \(task.title)")
    }
    
    private func deleteTask(_ task: Task) {
        // In a real app, this would remove the task from the data source
        print("Deleted task: \(task.title)")
    }
}

struct TaskCard: View {
    let task: Task
    let onTap: () -> Void
    let onToggleComplete: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Status Indicator (using shape only)
            Button(action: onToggleComplete) {
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "circle")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            
            // Task Content
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                        .strikethrough(task.isCompleted)
                    
                    Spacer()
                    
                    // Priority Indicator (using shape only)
                    if task.priority == .high {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                    } else if task.priority == .medium {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.caption)
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "minus.circle")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                
                if !task.description.isEmpty {
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack {
                    // Category Badge
                    Text(task.category.capitalized)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(categoryColor(task.category))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    // Due Date
                    Text(task.dueDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Progress Bar (for tasks with subtasks)
                if !task.subtasks.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Progress")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("\(task.completedSubtasks)/\(task.subtasks.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        ProgressView(value: Double(task.completedSubtasks), total: Double(task.subtasks.count))
                            .progressViewStyle(LinearProgressViewStyle())
                            .accentColor(progressColor(task.completedSubtasks, task.subtasks.count))
                    }
                }
            }
            
            // Action Buttons
            VStack(spacing: 8) {
                Button(action: onTap) {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "work":
            return .blue
        case "personal":
            return .green
        case "shopping":
            return .orange
        case "health":
            return .red
        case "finance":
            return .purple
        default:
            return .gray
        }
    }
    
    private func progressColor(_ completed: Int, _ total: Int) -> Color {
        let progress = Double(completed) / Double(total)
        if progress == 1.0 {
            return .green
        } else if progress >= 0.5 {
            return .orange
        } else {
            return .red
        }
    }
}

struct TaskDetailView: View {
    let task: Task
    let onToggleComplete: () -> Void
    let onDelete: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Task Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(task.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(task.isCompleted ? .secondary : .primary)
                                .strikethrough(task.isCompleted)
                            
                            Spacer()
                            
                            // Priority Indicator (using shape only)
                            if task.priority == .high {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            } else if task.priority == .medium {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "minus.circle")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                        
                        if !task.description.isEmpty {
                            Text(task.description)
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        
                        HStack {
                            Text(task.category.capitalized)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(categoryColor(task.category))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                            
                            Spacer()
                            
                            Text("Due: \(task.dueDate, style: .date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // Subtasks
                    if !task.subtasks.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Subtasks")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            ForEach(task.subtasks, id: \.self) { subtask in
                                HStack {
                                    // Subtask Status Indicator (using shape only)
                                    Image(systemName: subtask.hasPrefix("✓") ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(subtask.hasPrefix("✓") ? .green : .gray)
                                    
                                    Text(subtask.hasPrefix("✓") ? String(subtask.dropFirst(2)) : subtask)
                                        .font(.subheadline)
                                        .foregroundColor(subtask.hasPrefix("✓") ? .secondary : .primary)
                                        .strikethrough(subtask.hasPrefix("✓"))
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    // Notes
                    if !task.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Notes")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(task.notes)
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: onToggleComplete) {
                            HStack {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                Text(task.isCompleted ? "Mark Incomplete" : "Mark Complete")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(task.isCompleted ? Color.orange : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        
                        Button(action: onDelete) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Task Details")
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
    
    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "work":
            return .blue
        case "personal":
            return .green
        case "shopping":
            return .orange
        case "health":
            return .red
        case "finance":
            return .purple
        default:
            return .gray
        }
    }
}

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var category = "work"
    @State private var priority = TaskPriority.medium
    @State private var dueDate = Date()
    @State private var notes = ""
    @State private var subtasks: [String] = []
    @State private var newSubtask = ""
    @State private var isLoading = false
    @State private var showSuccess = false
    
    let categories = ["work", "personal", "shopping", "health", "finance"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Add New Task")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Create a new task to stay organized")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Task Title")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter task title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter task description", text: $description, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Category")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Picker("Category", selection: $category) {
                                    ForEach(categories, id: \.self) { cat in
                                        Text(cat.capitalized).tag(cat)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Priority")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Picker("Priority", selection: $priority) {
                                    Text("Low").tag(TaskPriority.low)
                                    Text("Medium").tag(TaskPriority.medium)
                                    Text("High").tag(TaskPriority.high)
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Due Date")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            DatePicker("", selection: $dueDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter additional notes", text: $notes, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Subtasks")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            HStack {
                                TextField("Add subtask", text: $newSubtask)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Button(action: {
                                    if !newSubtask.isEmpty {
                                        subtasks.append(newSubtask)
                                        newSubtask = ""
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            ForEach(subtasks, id: \.self) { subtask in
                                HStack {
                                    Text(subtask)
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        subtasks.removeAll { $0 == subtask }
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    Button(action: {
                        addTask()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Add Task")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading || title.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Add Task")
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
                Text("Task added successfully!")
            }
        }
    }
    
    private func addTask() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            showSuccess = true
        }
    }
}

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @Binding var showLogin: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoggedIn {
                    // Logged in view
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text("Welcome, \(username)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            Button(action: {
                                // Edit profile
                            }) {
                                HStack {
                                    Image(systemName: "pencil")
                                    Text("Edit Profile")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                // Settings
                            }) {
                                HStack {
                                    Image(systemName: "gear")
                                    Text("Settings")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isLoggedIn = false
                                username = ""
                                password = ""
                            }) {
                                HStack {
                                    Image(systemName: "power")
                                    Text("Logout")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                } else {
                    // Not logged in view
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("Welcome to TaskManager")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Sign in to sync your tasks across devices")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            showLogin = true
                        }) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
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

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Enter your credentials to continue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        TextField("Enter your username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        SecureField("Enter your password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        performLogin()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Sign In")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(isLoading || username.isEmpty || password.isEmpty)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") {
                    showError = false
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func performLogin() {
        isLoading = true
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            
            if username.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields"
                showError = true
            } else if username == "test" && password == "password" {
                isLoggedIn = true
                dismiss()
            } else {
                errorMessage = "Invalid username or password"
                showError = true
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedStatus = "all"
    @State private var selectedPriority = "all"
    @State private var selectedDateRange = "all"
    @State private var showOnlyOverdue = false
    
    let statuses = ["all", "completed", "pending"]
    let priorities = ["all", "low", "medium", "high"]
    let dateRanges = ["all", "today", "week", "month"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Status") {
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status.capitalized).tag(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Priority") {
                    Picker("Priority", selection: $selectedPriority) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority.capitalized).tag(priority)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Date Range") {
                    Picker("Date Range", selection: $selectedDateRange) {
                        ForEach(dateRanges, id: \.self) { range in
                            Text(range.capitalized).tag(range)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Options") {
                    Toggle("Show Only Overdue", isOn: $showOnlyOverdue)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedStatus = "all"
                        selectedPriority = "all"
                        selectedDateRange = "all"
                        showOnlyOverdue = false
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
enum TaskPriority: String, CaseIterable {
    case low = "low"
    case medium = "medium"
    case high = "high"
}

struct Task: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let category: String
    let priority: TaskPriority
    let dueDate: Date
    let isCompleted: Bool
    let notes: String
    let subtasks: [String]
    let completedSubtasks: Int
    let createdAt: Date
    let updatedAt: Date
}

let sampleTasks = [
    Task(
        title: "Complete project proposal",
        description: "Write and submit the quarterly project proposal for the new marketing campaign",
        category: "work",
        priority: .high,
        dueDate: Date().addingTimeInterval(86400),
        isCompleted: false,
        notes: "Need to include budget breakdown and timeline",
        subtasks: ["Research market trends", "Draft initial proposal", "Review with team", "Submit to management"],
        completedSubtasks: 2,
        createdAt: Date().addingTimeInterval(-86400),
        updatedAt: Date().addingTimeInterval(-3600)
    ),
    Task(
        title: "Buy groceries",
        description: "Purchase weekly groceries including fruits, vegetables, and household items",
        category: "shopping",
        priority: .medium,
        dueDate: Date().addingTimeInterval(172800),
        isCompleted: false,
        notes: "Check for sales on organic produce",
        subtasks: ["Make shopping list", "Go to supermarket", "Check prices", "Pay and return home"],
        completedSubtasks: 1,
        createdAt: Date().addingTimeInterval(-172800),
        updatedAt: Date().addingTimeInterval(-7200)
    ),
    Task(
        title: "Schedule doctor appointment",
        description: "Book annual checkup with primary care physician",
        category: "health",
        priority: .medium,
        dueDate: Date().addingTimeInterval(259200),
        isCompleted: true,
        notes: "Appointment scheduled for next Tuesday at 2 PM",
        subtasks: ["Call doctor's office", "Check availability", "Confirm appointment", "Add to calendar"],
        completedSubtasks: 4,
        createdAt: Date().addingTimeInterval(-259200),
        updatedAt: Date().addingTimeInterval(-10800)
    ),
    Task(
        title: "Review budget",
        description: "Analyze monthly expenses and adjust budget for next month",
        category: "finance",
        priority: .high,
        dueDate: Date().addingTimeInterval(345600),
        isCompleted: false,
        notes: "Focus on reducing dining out expenses",
        subtasks: ["Gather receipts", "Categorize expenses", "Calculate totals", "Identify savings opportunities"],
        completedSubtasks: 0,
        createdAt: Date().addingTimeInterval(-345600),
        updatedAt: Date().addingTimeInterval(-14400)
    ),
    Task(
        title: "Call mom",
        description: "Weekly phone call with mother to catch up",
        category: "personal",
        priority: .low,
        dueDate: Date().addingTimeInterval(432000),
        isCompleted: false,
        notes: "Ask about her garden and upcoming visit",
        subtasks: ["Check schedule", "Make the call", "Update on family news"],
        completedSubtasks: 0,
        createdAt: Date().addingTimeInterval(-432000),
        updatedAt: Date().addingTimeInterval(-18000)
    ),
    Task(
        title: "Update resume",
        description: "Refresh resume with latest job experience and skills",
        category: "work",
        priority: .medium,
        dueDate: Date().addingTimeInterval(518400),
        isCompleted: false,
        notes: "Include recent project achievements and new certifications",
        subtasks: ["Review current resume", "Add new experiences", "Update skills section", "Proofread and format"],
        completedSubtasks: 1,
        createdAt: Date().addingTimeInterval(-518400),
        updatedAt: Date().addingTimeInterval(-21600)
    )
]

struct StatusByShapeOnly_Previews: PreviewProvider {
    static var previews: some View {
        StatusByShapeOnly()
    }
}

