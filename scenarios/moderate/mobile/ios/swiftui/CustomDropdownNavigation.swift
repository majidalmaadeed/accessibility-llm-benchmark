import SwiftUI

struct CustomDropdownNavigation: View {
    @State private var isOpen = false
    @State private var selectedValue = "all"
    @State private var selectedText = "All Categories"
    @State private var currentIndex = 0
    @FocusState private var isDropdownFocused: Bool
    
    let options = [
        (value: "all", text: "All Categories"),
        (value: "electronics", text: "Electronics"),
        (value: "clothing", text: "Clothing"),
        (value: "books", text: "Books"),
        (value: "home", text: "Home & Garden")
    ]
    
    let products: [String: [Product]] = [
        "all": [
            Product(name: "iPhone 15", category: "Electronics"),
            Product(name: "MacBook Pro", category: "Electronics"),
            Product(name: "Cotton T-Shirt", category: "Clothing"),
            Product(name: "JavaScript Guide", category: "Books"),
            Product(name: "Garden Tools", category: "Home & Garden")
        ],
        "electronics": [
            Product(name: "iPhone 15", category: "Electronics"),
            Product(name: "MacBook Pro", category: "Electronics")
        ],
        "clothing": [
            Product(name: "Cotton T-Shirt", category: "Clothing")
        ],
        "books": [
            Product(name: "JavaScript Guide", category: "Books")
        ],
        "home": [
            Product(name: "Garden Tools", category: "Home & Garden")
        ]
    ]
    
    var filteredProducts: [Product] {
        products[selectedValue] ?? []
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Product Filter")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Filter products by category using the dropdown below.")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Filter by Category:")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    // Custom Dropdown Implementation
                    VStack(alignment: .leading, spacing: 0) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isOpen.toggle()
                            }
                        }) {
                            HStack {
                                Text(selectedText)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.secondary)
                                    .rotationEffect(.degrees(isOpen ? 180 : 0))
                                    .animation(.easeInOut(duration: 0.2), value: isOpen)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isOpen ? Color.blue : Color(.systemGray4), lineWidth: 2)
                            )
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel("Category filter")
                        .accessibilityHint("Double tap to open dropdown")
                        .accessibilityValue(selectedText)
                        .accessibilityAddTraits(.isButton)
                        
                        if isOpen {
                            VStack(spacing: 0) {
                                ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                                    Button(action: {
                                        selectOption(value: option.value, text: option.text, index: index)
                                    }) {
                                        HStack {
                                            Text(option.text)
                                                .foregroundColor(selectedValue == option.value ? .white : .primary)
                                            Spacer()
                                            if selectedValue == option.value {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .padding()
                                        .background(selectedValue == option.value ? Color.blue : Color.clear)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .accessibilityLabel(option.text)
                                    .accessibilityAddTraits(selectedValue == option.value ? .isSelected : [])
                                    
                                    if index < options.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .transition(.opacity.combined(with: .scale))
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Filtered Results")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 200))
                    ], spacing: 16) {
                        ForEach(filteredProducts, id: \.name) { product in
                            VStack(spacing: 8) {
                                Text(product.name)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Text(product.category)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Accessibility Issues:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    accessibilityIssue("Incomplete keyboard navigation: Arrow keys don't navigate through options")
                    accessibilityIssue("Missing ARIA attributes: No aria-activedescendant or proper role attributes")
                    accessibilityIssue("Focus management: Focus doesn't move to options when dropdown opens")
                    accessibilityIssue("Screen reader announcements: No announcements when selection changes")
                    accessibilityIssue("Escape key handling: Escape doesn't close dropdown")
                    accessibilityIssue("Tab order: Options are not in proper tab sequence")
                }
                
                Text("How to Fix:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 8) {
                    fixItem("Add aria-activedescendant to track focused option")
                    fixItem("Implement arrow key navigation (Up/Down)")
                    fixItem("Add aria-selected to indicate selected state")
                    fixItem("Handle Escape key to close dropdown")
                    fixItem("Add aria-live region for selection announcements")
                    fixItem("Ensure proper focus management when opening/closing")
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            if isOpen {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isOpen = false
                }
            }
        }
    }
    
    private func selectOption(value: String, text: String, index: Int) {
        selectedValue = value
        selectedText = text
        currentIndex = index
        
        withAnimation(.easeInOut(duration: 0.2)) {
            isOpen = false
        }
        
        // Accessibility announcement
        UIAccessibility.post(notification: .announcement, argument: "Selected \(text)")
    }
    
    @ViewBuilder
    private func accessibilityIssue(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .fontWeight(.bold)
            Text(text)
                .font(.body)
        }
    }
    
    @ViewBuilder
    private func fixItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .fontWeight(.bold)
            Text(text)
                .font(.body)
        }
    }
}

struct Product {
    let name: String
    let category: String
}

// MARK: - Preview
struct CustomDropdownNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomDropdownNavigation()
            .previewDisplayName("Custom Dropdown Navigation")
    }
}