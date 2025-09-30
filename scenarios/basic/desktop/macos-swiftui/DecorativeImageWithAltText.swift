import SwiftUI

struct DecorativeImageWithAltText: View {
    var body: some View {
        VStack(spacing: 0) {
            // Hero Section with Decorative Images
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 200)
                
                // Decorative Background Pattern - DECORATIVE IMAGE WITH ALT TEXT
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: "https://via.placeholder.com/100x100")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray)
                    }
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
                }
                
                // Another Decorative Element
                HStack {
                    AsyncImage(url: URL(string: "https://via.placeholder.com/80x80")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray)
                    }
                    .frame(width: 80, height: 80)
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                    Spacer()
                }
                
                // Main Content
                VStack(spacing: 16) {
                    Text("Discover Amazing Products")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Find the perfect items for your needs")
                        .font(.headline)
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                }
            }
            
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
                
                Button("Clothing") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Home") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Sports") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            // Products Grid
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    // Product 1
                    VStack(alignment: .leading, spacing: 12) {
                        ZStack {
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
                            
                            // Decorative Border Pattern - DECORATIVE IMAGE WITH ALT TEXT
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
                            .opacity(0.3)
                            
                            // Decorative Corner Element - DECORATIVE IMAGE WITH ALT TEXT
                            VStack {
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: "https://via.placeholder.com/20x20")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.gray)
                                    }
                                    .frame(width: 20, height: 20)
                                    .padding(.top, 8)
                                    .padding(.trailing, 8)
                                }
                                Spacer()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Wireless Headphones")
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
                    VStack(alignment: .leading, spacing: 12) {
                        ZStack {
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
                            
                            // Decorative Border Pattern - DECORATIVE IMAGE WITH ALT TEXT
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
                            .opacity(0.3)
                            
                            // Decorative Corner Element - DECORATIVE IMAGE WITH ALT TEXT
                            VStack {
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: "https://via.placeholder.com/20x20")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.gray)
                                    }
                                    .frame(width: 20, height: 20)
                                    .padding(.top, 8)
                                    .padding(.trailing, 8)
                                }
                                Spacer()
                            }
                        }
                        
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
                }
                .padding()
            }
        }
    }
}

#Preview {
    DecorativeImageWithAltText()
}
