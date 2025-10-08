import SwiftUI

struct MissingImageAltText: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text("TechStore")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Discover amazing tech products")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding()
            
            // Category Filter
            HStack(spacing: 8) {
                Button("All") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Electronics") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Wearables") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Audio") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Accessories") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            // Product Grid
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    // Product 1
                    VStack(alignment: .leading, spacing: 12) {native text
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
                            Text("Wireless Bluetooth Headphones")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("⭐⭐⭐⭐☆")
                                    .font(.caption)
                                Text("4.5")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
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
                    
                    // Product 2
                    VStack(alignment: .leading, spacing: 12) {native text
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
                            Text("Smart Watch")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("⭐⭐⭐⭐⭐")
                                    .font(.caption)
                                Text("4.8")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
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
                    
                    // Product 3
                    VStack(alignment: .leading, spacing: 12) {native text
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
                            Text("Portable Bluetooth Speaker")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("⭐⭐⭐⭐☆")
                                    .font(.caption)
                                Text("4.3")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("$79.99")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                
                                Text("$99.99")
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
                .padding()
            }
        }
    }
}

#Preview {
    MissingImageAltText()
}
