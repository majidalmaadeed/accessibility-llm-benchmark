import SwiftUI

struct MissingSkipLink: View {
    @State private var selectedTab = "home"
    
    var body: some View {
        VStack(spacing: 0) {
            // MISSING SKIP LINK - Page navigation without skip-to-content link
            // Tab Navigation
            HStack(spacing: 0) {
                Button("Home") {
                    selectedTab = "home"
                }
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "home" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("Products") {
                    selectedTab = "products"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "products" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "products" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("About") {
                    selectedTab = "about"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "about" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "about" ? .blue : .clear),
                    alignment: .bottom
                )
                
                Button("Contact") {
                    selectedTab = "contact"
                }
                .font(.headline)
                .foregroundColor(selectedTab == "contact" ? .blue : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedTab == "contact" ? .blue : .clear),
                    alignment: .bottom
                )
            }
            .background(Color.white)
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    VStack(spacing: 16) {
                        Text("Welcome to Our Website")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("Discover amazing products and services")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Button("Get Started") {
                            // Get started action
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(48)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Features Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Our Features")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            VStack(spacing: 8) {
                                Text("🚀")
                                    .font(.largeTitle)
                                Text("Fast Performance")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Lightning-fast loading times")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("🔒")
                                    .font(.largeTitle)
                                Text("Secure")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Your data is safe with us")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("💡")
                                    .font(.largeTitle)
                                Text("Innovative")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Cutting-edge technology")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                    
                    // Products Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Featured Products")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            VStack(alignment: .leading, spacing: 12) {
                                AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                }
                                .frame(height: 200)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Product 1")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Amazing product description")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    HStack {
                                        Text("$99.99")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        
                                        Text("$149.99")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .strikethrough()
                                    }
                                    
                                    Button("Add to Cart") {
                                        // Add to cart action
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                }
                                .frame(height: 200)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Product 2")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Another great product")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    HStack {
                                        Text("$199.99")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        
                                        Text("$249.99")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .strikethrough()
                                    }
                                    
                                    Button("Add to Cart") {
                                        // Add to cart action
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                AsyncImage(url: URL(string: "https://via.placeholder.com/200x200")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                }
                                .frame(height: 200)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Product 3")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Third amazing product")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    HStack {
                                        Text("$299.99")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        
                                        Text("$399.99")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .strikethrough()
                                    }
                                    
                                    Button("Add to Cart") {
                                        // Add to cart action
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MissingSkipLink()
}
