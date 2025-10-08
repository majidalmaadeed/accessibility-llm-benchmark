import SwiftUI

struct KeyboardTrapInWidget: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var selectedTime = Date()
    @State private var showTimePicker = false
    @State private var eventTitle = ""
    @State private var eventDescription = ""
    @State private var selectedCalendar = "Personal"
    @State private var reminderTime = "15 minutes before"
    @State private var isRecurring = false
    @State private var recurringPattern = "Weekly"
    @State private var selectedColor = Color.blue
    @State private var inviteEmails = ""
    @State private var showSuccess = false
    @State private var isLoading = false
    
    let calendars = ["Personal", "Work", "Family", "Health", "Travel"]
    let reminderOptions = ["None", "5 minutes before", "15 minutes before", "30 minutes before", "1 hour before", "1 day before"]
    let recurringOptions = ["Daily", "Weekly", "Monthly", "Yearly"]
    let colorOptions = [Color.blue, Color.green, Color.red, Color.orange, Color.purple, Color.pink]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Create Event")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Schedule your upcoming event")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    // Event Form
                    VStack(spacing: 20) {
                        // Event Title
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Event Title")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter event title", text: $eventTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Date and Time Selection
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Date")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Button(action: {
                                    showDatePicker = true
                                }) {
                                    Text(selectedDate, style: .date)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                        .foregroundColor(.primary)
                                }
                                .sheet(isPresented: $showDatePicker) {
                                    DatePickerModal(
                                        selectedDate: $selectedDate,
                                        showDatePicker: $showDatePicker
                                    )
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Time")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Button(action: {
                                    showTimePicker = true
                                }) {
                                    Text(selectedTime, style: .time)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                        .foregroundColor(.primary)
                                }
                                .sheet(isPresented: $showTimePicker) {
                                    TimePickerModal(
                                        selectedTime: $selectedTime,
                                        showTimePicker: $showTimePicker
                                    )
                                }
                            }
                        }
                        
                        // Event Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter event description", text: $eventDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        // Calendar Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calendar")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Calendar", selection: $selectedCalendar) {
                                ForEach(calendars, id: \.self) { calendar in
                                    Text(calendar).tag(calendar)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        // Reminder
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Reminder")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Reminder", selection: $reminderTime) {
                                ForEach(reminderOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        // Recurring Event
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Recurring Event")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Toggle("", isOn: $isRecurring)
                            }
                            
                            if isRecurring {
                                Picker("Repeat", selection: $recurringPattern) {
                                    ForEach(recurringOptions, id: \.self) { option in
                                        Text(option).tag(option)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        
                        // Color Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Event Color")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            HStack(spacing: 12) {
                                ForEach(colorOptions, id: \.self) { color in
                                    Button(action: {
                                        selectedColor = color
                                    }) {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                            )
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }
                        
                        // Invite People
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Invite People")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter email addresses, separated by commas", text: $inviteEmails)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            // Cancel
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            createEvent()
                        }) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Text("Create Event")
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .disabled(isLoading || eventTitle.isEmpty)
                    }
                }
                .padding()
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Success", isPresented: $showSuccess) {
                Button("OK") {
                    // Navigate back
                }
            } message: {
                Text("Event created successfully!")
            }
        }
    }
    
    private func createEvent() {
        isLoading = true
        
        // Simulate event creation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            showSuccess = true
        }
    }
}

struct DatePickerModal: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    @State private var tempDate: Date
    @FocusState private var focusState: Bool
    
    init(selectedDate: Binding<Date>, showDatePicker: Binding<Bool>) {
        self._selectedDate = selectedDate
        self._showDatePicker = showDatePicker
        self._tempDate = State(initialValue: selectedDate.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Select Date")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                // Date Picker (creates keyboard trap)
                DatePicker("Event Date", selection: $tempDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .focused($focusState)
                    .onAppear {
                        focusState = true
                    }
                    .labelsHidden()
                    .padding()
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        showDatePicker = false
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        selectedDate = tempDate
                        showDatePicker = false
                    }) {
                        Text("Done")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .interactiveDismissDisabled() // Prevents dismissal by swipe, creating a trap
    }
}

struct TimePickerModal: View {
    @Binding var selectedTime: Date
    @Binding var showTimePicker: Bool
    @State private var tempTime: Date
    @FocusState private var focusState: Bool
    
    init(selectedTime: Binding<Date>, showTimePicker: Binding<Bool>) {
        self._selectedTime = selectedTime
        self._showTimePicker = showTimePicker
        self._tempTime = State(initialValue: selectedTime.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Select Time")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                // Time Picker (creates keyboard trap)
                DatePicker("Event Time", selection: $tempTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .focused($focusState)
                    .onAppear {
                        focusState = true
                    }
                    .labelsHidden()
                    .padding()
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        showTimePicker = false
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        selectedTime = tempTime
                        showTimePicker = false
                    }) {
                        Text("Done")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .interactiveDismissDisabled() // Prevents dismissal by swipe, creating a trap
    }
}

struct KeyboardTrapInWidget_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardTrapInWidget()
    }
}

