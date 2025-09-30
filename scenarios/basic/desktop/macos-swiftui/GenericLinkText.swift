import SwiftUI

struct GenericLinkText: View {
    var body: some View {
        VStack(spacing: 0) {
            // Featured Article
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: "https://via.placeholder.com/400x200")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray)
                }
                .frame(height: 200)
                .cornerRadius(8)
                
                HStack {
                    Text("Featured")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                    Spacer()
                }
                
                Text("Building Scalable React Native Applications")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Text("Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Alex Thompson")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("January 20, 2024")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("12 min read")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // GENERIC LINK TEXT - "Read more" without context
                Button("Read more") {
                    // Read more action
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
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
                
                Button("Technology") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Design") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Business") {
                    // Filter action
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("Science") {
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
            
            // Articles List
            ScrollView {
                VStack(spacing: 16) {
                    Text("Recent Articles")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Article 1
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: "https://via.placeholder.com/120x80")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                        }
                        .frame(width: 120, height: 80)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Technology")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                                Spacer()
                            }
                            
                            Text("Understanding Flutter Performance Optimization")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Learn how to optimize your Flutter applications for better performance and user experience.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                            
                            HStack {
                                Text("By John Smith")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("2024-01-15")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                // GENERIC LINK TEXT - "Read more" without context
                                Button("Read more") {
                                    // Read more action
                                }
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .cornerRadius(6)
                                
                                Button("↗️") {
                                    // Share action
                                }
                                .font(.headline)
                                .frame(width: 32, height: 32)
                                .background(Color.gray)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Article 2
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: "https://via.placeholder.com/120x80")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                        }
                        .frame(width: 120, height: 80)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Design")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                                Spacer()
                            }
                            
                            Text("Mobile UI/UX Design Best Practices")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Essential design principles for creating intuitive and accessible mobile interfaces.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                            
                            HStack {
                                Text("By Sarah Johnson")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("2024-01-12")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                // GENERIC LINK TEXT - "Read more" without context
                                Button("Read more") {
                                    // Read more action
                                }
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .cornerRadius(6)
                                
                                Button("↗️") {
                                    // Share action
                                }
                                .font(.headline)
                                .frame(width: 32, height: 32)
                                .background(Color.gray)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Article 3
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: "https://via.placeholder.com/120x80")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                        }
                        .frame(width: 120, height: 80)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Technology")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.blue)
                                    .cornerRadius(4)
                                Spacer()
                            }
                            
                            Text("Cross-Platform Development Strategies")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("Compare different approaches to building apps that work across multiple platforms.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                            
                            HStack {
                                Text("By Mike Chen")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text("2024-01-10")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                // GENERIC LINK TEXT - "Read more" without context
                                Button("Read more") {
                                    // Read more action
                                }
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .cornerRadius(6)
                                
                                Button("↗️") {
                                    // Share action
                                }
                                .font(.headline)
                                .frame(width: 32, height: 32)
                                .background(Color.gray)
                                .cornerRadius(8)
                            }
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
    GenericLinkText()
}
