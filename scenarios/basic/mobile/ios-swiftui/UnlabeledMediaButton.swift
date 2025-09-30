import SwiftUI

struct UnlabeledMediaButton: View {
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 180
    @State private var volume: Double = 0.5
    @State private var isMuted = false
    @State private var playbackSpeed: Double = 1.0
    @State private var selectedQuality = "HD"
    @State private var showPlaylist = false
    @State private var isFullscreen = false
    
    let qualities = ["SD", "HD", "4K"]
    let speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
    
    var body: some View {
        VStack(spacing: 20) {
            // Video Player Area
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 200)
                    .cornerRadius(12)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isFullscreen.toggle()
                        }) {
                            Image(systemName: isFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Play/Pause Button
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                    }
                    
                    Spacer()
                }
            }
            
            // Progress Bar
            VStack(spacing: 8) {
                Slider(value: $currentTime, in: 0...duration)
                    .accentColor(.blue)
                
                HStack {
                    Text(formatTime(currentTime))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(formatTime(duration))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Control Buttons
            HStack(spacing: 30) {
                Button(action: {
                    currentTime = max(0, currentTime - 10)
                }) {
                    Image(systemName: "gobackward.10")
                        .font(.title2)
                }
                
                Button(action: {
                    isMuted.toggle()
                }) {
                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.fill")
                        .font(.title2)
                }
                
                Button(action: {
                    showPlaylist.toggle()
                }) {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                }
                
                Button(action: {
                    // Share functionality
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                }
            }
            .foregroundColor(.primary)
            
            // Volume Control
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.secondary)
                
                Slider(value: $volume, in: 0...1)
                    .accentColor(.blue)
                
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.secondary)
            }
            
            // Quality and Speed Controls
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Quality")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Picker("Quality", selection: $selectedQuality) {
                        ForEach(qualities, id: \.self) { quality in
                            Text(quality).tag(quality)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Speed")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Picker("Speed", selection: $playbackSpeed) {
                        ForEach(speeds, id: \.self) { speed in
                            Text("\(speed, specifier: "%.2f")x").tag(speed)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            
            // Playlist (if shown)
            if showPlaylist {
                VStack(alignment: .leading) {
                    Text("Playlist")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(0..<10) { index in
                                HStack {
                                    Image(systemName: "music.note")
                                        .foregroundColor(.blue)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Video \(index + 1)")
                                            .font(.subheadline)
                                        Text("Duration: 3:45")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    if index == 0 {
                                        Image(systemName: "play.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 200)
                }
            }
        }
        .padding()
        .navigationTitle("Media Player")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct UnlabeledMediaButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UnlabeledMediaButton()
        }
    }
}

