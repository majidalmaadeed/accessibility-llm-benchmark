import SwiftUI

struct SmallTouchTarget: View {
    @State private var isLiked = false
    @State private var isBookmarked = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab Navigation
            HStack(spacing: 0) {
                Button("Following") {
                    // Tab action
                }
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.blue),
                    alignment: .bottom
                )
                
                Button("Discover") {
                    // Tab action
                }
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                Button("Trending") {
                    // Tab action
                }
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .background(Color.white)
            
            // Posts Feed
            ScrollView {
                VStack(spacing: 16) {
                    // Post 1
                    VStack(alignment: .leading, spacing: 12) {
                        // Post Header
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("john_doe")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("2h")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // SMALL TOUCH TARGET - Only 20x20px on mobile interface
                            Button("⋯") {
                                // More options action
                            }
                            .font(.title2)
                            .frame(width: 20, height: 20)
                            .background(Color.gray)
                        }
                        
                        // Post Image
                        AsyncImage(url: URL(string: "https://via.placeholder.com/400x300")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                        }
                        .frame(height: 300)
                        .cornerRadius(8)
                        
                        // Post Actions
                        HStack(spacing: 16) {
                            // SMALL TOUCH TARGET - Only 20x20px
                            Button(isLiked ? "♥" : "♡") {
                                isLiked.toggle()
                            }
                            .font(.headline)
                            .foregroundColor(isLiked ? .red : .gray)
                            .frame(width: 20, height: 20)
                            
                            Button("💬") {
                                // Comments action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                            
                            Button("↗️") {
                                // Share action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                            
                            Spacer()
                            
                            Button(isBookmarked ? "🔖" : "🔖") {
                                isBookmarked.toggle()
                            }
                            .font(.headline)
                            .foregroundColor(isBookmarked ? .blue : .gray)
                            .frame(width: 20, height: 20)
                        }
                        
                        Text("42 likes")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack(alignment: .top, spacing: 8) {
                            Text("john_doe")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Beautiful sunset from my hike today! 🏔️ #nature #photography")
                                .font(.subheadline)
                        }
                        
                        Text("View all 8 comments")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Post 2
                    VStack(alignment: .leading, spacing: 12) {
                        // Post Header
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("sarah_j")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("4h")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // SMALL TOUCH TARGET - Only 20x20px on mobile interface
                            Button("⋯") {
                                // More options action
                            }
                            .font(.title2)
                            .frame(width: 20, height: 20)
                            .background(Color.gray)
                        }
                        
                        // Post Image
                        AsyncImage(url: URL(string: "https://via.placeholder.com/400x300")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                        }
                        .frame(height: 300)
                        .cornerRadius(8)
                        
                        // Post Actions
                        HStack(spacing: 16) {
                            // SMALL TOUCH TARGET - Only 20x20px
                            Button("♡") {
                                // Like action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                            
                            Button("💬") {
                                // Comments action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                            
                            Button("↗️") {
                                // Share action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                            
                            Spacer()
                            
                            Button("🔖") {
                                // Bookmark action
                            }
                            .font(.headline)
                            .frame(width: 20, height: 20)
                        }
                        
                        Text("28 likes")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        HStack(alignment: .top, spacing: 8) {
                            Text("sarah_j")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Just finished reading an amazing book! Highly recommend it to everyone.")
                                .font(.subheadline)
                        }
                        
                        Text("View all 12 comments")
                            .font(.caption)
                            .foregroundColor(.gray)
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
    SmallTouchTarget()
}
