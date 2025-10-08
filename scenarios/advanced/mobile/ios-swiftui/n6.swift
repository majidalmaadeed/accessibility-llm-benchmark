import SwiftUI
import AVKit

struct MediaPlayerFullInterface: View {
    @State private var isPlaying: Bool = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 180
    @State private var volume: Double = 0.5
    @State private var playbackSpeed: Double = 1.0
    @State private var isFullscreen: Bool = false
    @State private var showCaptions: Bool = false
    @State private var showQualityMenu: Bool = false
    @State private var selectedQuality: String = "1080p"
    @State private var showPlaylist: Bool = false
    @State private var currentTrack: Int = 0
    
    let qualities = ["360p", "720p", "1080p", "4K"]
    let speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
    
    var body: some View {
        VStack(spacing: 0) {
            if isFullscreen {
                fullscreenPlayerView
            } else {
                compactPlayerView
            }
        }
        .background(Color.black)
    }
    
    private var compactPlayerView: some View {
        VStack(spacing: 0) {
            videoPlayerView
            controlsView
            playlistView
        }
    }
    
    private var fullscreenPlayerView: some View {
        VStack(spacing: 0) {
            videoPlayerView
            fullscreenControlsView
        }
        .ignoresSafeArea()
    }
    
    private var videoPlayerView: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .aspectRatio(16/9, contentMode: .fit)
            
            VStack {
                HStack {
                    Button(action: { isFullscreen.toggle() }) {
                        Image(systemName: isFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button(action: { showQualityMenu.toggle() }) {
                        Text(selectedQuality)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(4)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Button(action: { previousTrack() }) {
                        Image(systemName: "backward.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button(action: { togglePlayPause() }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 60))
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button(action: { nextTrack() }) {
                        Image(systemName: "forward.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                
                Spacer()
                
                progressView
            }
        }
    }
    
    private var controlsView: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: { showPlaylist.toggle() }) {
                    Image(systemName: "list.bullet")
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Text("Track \(currentTrack + 1) of 10")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: { showCaptions.toggle() }) {
                    Image(systemName: showCaptions ? "captions.bubble.fill" : "captions.bubble")
                }
                .buttonStyle(.bordered)
            }
            
            HStack {
                Text(formatTime(currentTime))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Slider(value: $currentTime, in: 0...duration)
                    .accentColor(.blue)
                
                Text(formatTime(duration))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Button(action: { volume = max(0, volume - 0.1) }) {
                    Image(systemName: "speaker.fill")
                }
                .buttonStyle(.bordered)
                
                Slider(value: $volume, in: 0...1)
                    .accentColor(.blue)
                
                Button(action: { volume = min(1, volume + 0.1) }) {
                    Image(systemName: "speaker.wave.3.fill")
                }
                .buttonStyle(.bordered)
            }
            
            HStack {
                Text("Speed: \(String(format: "%.2fx", playbackSpeed))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                ForEach(speeds, id: \.self) { speed in
                    Button("\(String(format: "%.2fx", speed))") {
                        playbackSpeed = speed
                    }
                    .buttonStyle(speed == playbackSpeed ? .borderedProminent : .bordered)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var fullscreenControlsView: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { isFullscreen = false }) {
                    Image(systemName: "arrow.down.right.and.arrow.up.left")
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Button(action: { showQualityMenu.toggle() }) {
                    Text(selectedQuality)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(6)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
            
            HStack(spacing: 40) {
                Button(action: { previousTrack() }) {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .buttonStyle(.plain)
                
                Button(action: { togglePlayPause() }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 80))
                }
                .buttonStyle(.plain)
                
                Button(action: { nextTrack() }) {
                    Image(systemName: "forward.fill")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                HStack {
                    Text(formatTime(currentTime))
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Slider(value: $currentTime, in: 0...duration)
                        .accentColor(.white)
                    
                    Text(formatTime(duration))
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                HStack {
                    Button(action: { volume = max(0, volume - 0.1) }) {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    
                    Slider(value: $volume, in: 0...1)
                        .accentColor(.white)
                    
                    Button(action: { volume = min(1, volume + 0.1) }) {
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
    
    private var progressView: some View {
        VStack(spacing: 8) {
            HStack {
                Text(formatTime(currentTime))
                    .foregroundColor(.white)
                    .font(.caption)
                
                Spacer()
                
                Text(formatTime(duration))
                    .foregroundColor(.white)
                    .font(.caption)
            }
            
            ProgressView(value: currentTime, total: duration)
                .progressViewStyle(LinearProgressViewStyle())
                .accentColor(.white)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var playlistView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Playlist")
                    .font(.headline)
                
                Spacer()
                
                Button("Shuffle") {
                    // Shuffle playlist
                }
                .buttonStyle(.bordered)
            }
            
            if showPlaylist {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(0..<10, id: \.self) { index in
                            PlaylistItem(
                                title: "Track \(index + 1)",
                                artist: "Artist \(index + 1)",
                                duration: "3:45",
                                isCurrent: index == currentTrack,
                                isPlaying: index == currentTrack && isPlaying
                            ) {
                                selectTrack(index)
                            }
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // MARK: - Methods
    
    private func togglePlayPause() {
        isPlaying.toggle()
    }
    
    private func previousTrack() {
        if currentTrack > 0 {
            currentTrack -= 1
        }
    }
    
    private func nextTrack() {
        if currentTrack < 9 {
            currentTrack += 1
        }
    }
    
    private func selectTrack(_ index: Int) {
        currentTrack = index
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct PlaylistItem: View {
    let title: String
    let artist: String
    let duration: String
    let isCurrent: Bool
    let isPlaying: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(isCurrent ? .blue : .primary)
                
                Text(artist)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if isCurrent {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .foregroundColor(.blue)
            }
            
            Text(duration)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(isCurrent ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            onTap()
        }
    }
}

struct MediaPlayerFullInterface_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerFullInterface()
    }
}
