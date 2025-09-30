import SwiftUI

struct KeyboardTrapInWidget: View {
    @State private var selectedDate = Date()
    @State private var isDatePickerOpen = false
    @State private var selectedTime = Date()
    @State private var isTimePickerOpen = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("Event Scheduler")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Schedule your events and appointments")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Event Form
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Event Details")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Event Title
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Title")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter event title", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // Event Description
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Description")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextEditor(text: .constant(""))
                                    .frame(minHeight: 100)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            // Date Selection - KEYBOARD TRAP IN WIDGET
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Date")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
                                Button(action: {
                                    isDatePickerOpen.toggle()
                                }) {
                                    HStack {
                                        Text("📅")
                                            .font(.headline)
                                        Text(selectedDate, style: .date)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("▼")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                                
                                if isDatePickerOpen {
                                    VStack {
                                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                            .datePickerStyle(GraphicalDatePickerStyle())
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(radius: 2)
                                        
                                        HStack {
                                            Button("Cancel") {
                                                isDatePickerOpen = false
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                            
                                            Button("Done") {
                                                isDatePickerOpen = false
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                        }
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                            
                            // Time Selection - KEYBOARD TRAP IN WIDGET
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Time")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                // KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
                                Button(action: {
                                    isTimePickerOpen.toggle()
                                }) {
                                    HStack {
                                        Text("🕐")
                                            .font(.headline)
                                        Text(selectedTime, style: .time)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("▼")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                                
                                if isTimePickerOpen {
                                    VStack {
                                        DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                            .datePickerStyle(WheelDatePickerStyle())
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(radius: 2)
                                        
                                        HStack {
                                            Button("Cancel") {
                                                isTimePickerOpen = false
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                            
                                            Button("Done") {
                                                isTimePickerOpen = false
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                        }
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                            }
                            
                            // Location
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Event Location")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter event location", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            // Attendees
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Attendees")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("Enter attendee emails", text: .constant(""))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button("Create Event") {
                            // Create event action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                        
                        Button("Save Draft") {
                            // Save draft action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        
                        Button("Cancel") {
                            // Cancel action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .padding()
            }
        }
    }
}

#Preview {
    KeyboardTrapInWidget()
}
