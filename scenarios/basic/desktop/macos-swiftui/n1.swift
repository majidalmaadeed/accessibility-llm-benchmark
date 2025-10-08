import SwiftUI

struct AutoPlayingBackgroundVideo: View {
    @State private var isPlaying = true
    @State private var currentTime = 0.0
    @State private var duration = 30.0
    
    var body: some View {
        VStack(spacing: 0) {
            // Hero Section with Auto-playing Background Video
            ZStack {
                // AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 400)
                    .overlay(
                        VStack {
                            Text("🎬")
                                .font(.system(size: 60))
                            Text("Auto-playing Video")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("This video plays automatically")
                                .font(.headline)
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                    )
                    .onAppear {
                        startAutoPlay()
                    }
                
                // Video Overlay
                VStack {
                    HStack {
                        Spacer()
                        Button(isPlaying ? "⏸️" : "▶️") {
                            isPlaying.toggle()
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(25)
                        .padding()
                    }
                    Spacer()
                }
            }
            
            // Main Content
            ScrollView {
                VStack(spacing: 24) {
                    // Featured Content
                    VStack(spacing: 16) {
                        Text("Featured Content")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Discover our latest videos and tutorials")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    // Video Categories
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Video Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                            VStack(spacing: 8) {
                                Text("🎥")
                                    .font(.largeTitle)
                                Text("Tutorials")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Learn new skills")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("🎬")
                                    .font(.largeTitle)
                                Text("Documentaries")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Explore the world")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            
                            VStack(spacing: 8) {
                                Text("🎭")
                                    .font(.largeTitle)
                                Text("Entertainment")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Fun and games")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                    
                    // Recent Videos
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Videos")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            // Video 1
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
                                    Text("Getting Started with SwiftUI")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Learn the basics of SwiftUI development")
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
                                        Text("15 min")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Button("▶️") {
                                            // Play action
                                        }
                                        .font(.headline)
                                        .frame(width: 32, height: 32)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                        
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
                            
                            // Video 2
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
                                    Text("Advanced iOS Development")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Master advanced iOS development techniques")
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
                                        Text("25 min")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Button("▶️") {
                                            // Play action
                                        }
                                        .font(.headline)
                                        .frame(width: 32, height: 32)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                        
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
                    }
                }
                .padding()
            }
        }
    }
    
    private func startAutoPlay() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if isPlaying {
                currentTime += 0.1
                if currentTime >= duration {
                    currentTime = 0
                }
            }
        }
    }
}

#Preview {
    AutoPlayingBackgroundVideo()
}
