import SwiftUI

struct UnlabeledMediaButton: View {
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Rectangle()
                .fill(Color.gray)
                .frame(height: 60)
                .overlay(
                    Text("Video Player")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            // Main Content
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Video Area
                    ZStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 300)
                            .overlay(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/400x300")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray)
                                }
                            )
                        
                        // Video Overlay
                        Rectangle()
                            .fill(Color.black.opacity(0.5))
                            .overlay(
                                HStack {
                                    // UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name
                                    Button(action: {
                                        isPlaying.toggle()
                                    }) {
                                        Text(isPlaying ? "⏸️" : "▶️")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                            .frame(width: 60, height: 60)
                                    }
                                }
                            )
                        
                        // Video Title
                        VStack {
                            Spacer()
                            Text("Flutter Development Tutorial")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 60)
                        }
                    }
                    
                    // Progress Bar
                    VStack(spacing: 8) {
                        ProgressView(value: 0.3)
                            .progressViewStyle(LinearProgressViewStyle(tint: .red))
                            .frame(height: 4)
                        
                        HStack {
                            Text("2:15")
                                .foregroundColor(.white)
                            Spacer()
                            Text("7:30")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            // Controls
            HStack(spacing: 5) {
                Button("⏮️") {
                    // Previous action
                }
                .font(.system(size: 16))
                .frame(width: 50, height: 50)
                .background(Color.gray)
                
                Button(isPlaying ? "⏸️" : "▶️") {
                    isPlaying.toggle()
                }
                .font(.system(size: 20))
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                
                Button("⏭️") {
                    // Next action
                }
                .font(.system(size: 16))
                .frame(width: 50, height: 50)
                .background(Color.gray)
                
                Button("🔊") {
                    // Volume action
                }
                .font(.system(size: 16))
                .frame(width: 50, height: 50)
                .background(Color.gray)
                
                Button("⛶") {
                    // Fullscreen action
                }
                .font(.system(size: 16))
                .frame(width: 50, height: 50)
                .background(Color.gray)
            }
            .padding()
        }
    }
}

#Preview {
    UnlabeledMediaButton()
}
