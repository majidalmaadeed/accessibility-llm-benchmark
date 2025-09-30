import SwiftUI
import AVKit

struct AutoPlayingBackgroundVideo: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State private var showProfile = false
    @State private var notifications = 5
    @State private var selectedCategory = "all"
    @State private var showFilters = false
    @State private var selectedVideo: Video?
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var volume: Double = 0.5
    @State private var isMuted = false
    @State private var playbackSpeed: Double = 1.0
    @State private var showPlaylist = false
    @State private var isFullscreen = false
    @State private var player: AVPlayer?
    @State private var playerItem: AVPlayerItem?
    
    let categories = ["all", "music", "gaming", "education", "entertainment", "sports"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Video
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .ignoresSafeArea()
                        .onAppear {
                            player.play()
                        }
                        .onDisappear {
                            player.pause()
                        }
                }
                
                // Content Overlay
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 12) {
                        HStack {
                            Text("VideoHub")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                            
                            Spacer()
                            
                            HStack(spacing: 16) {
                                Button(action: {
                                    showPlaylist = true
                                }) {
                                    ZStack {
                                        Image(systemName: "list.bullet")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                        
                                        if !sampleVideos.isEmpty {
                                            Text("\(sampleVideos.count)")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .padding(4)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                                .offset(x: 8, y: -8)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    showProfile = true
                                }) {
                                    ZStack {
                                        Image(systemName: "person.circle")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                        
                                        if notifications > 0 {
                                            Text("\(notifications)")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                                .padding(4)
                                                .background(Color.red)
                                                .clipShape(Circle())
                                                .offset(x: 8, y: -8)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            
                            TextField("Search videos...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .foregroundColor(.white)
                                .placeholder(when: searchText.isEmpty) {
                                    Text("Search videos...")
                                        .foregroundColor(.white.opacity(0.7))
                                }
                        }
                        .padding()
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.black.opacity(0.2))
                    
                    // Category Filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category.capitalized)
                                        .font(.subheadline)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedCategory == category ? Color.white : Color.white.opacity(0.3))
                                        .foregroundColor(selectedCategory == category ? .black : .white)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.2))
                    
                    // Filter Controls
                    HStack {
                        Button(action: {
                            showFilters.toggle()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                Text("Filters")
                            }
                            .font(.subheadline)
                            .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("\(filteredVideos.count) videos")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.2))
                    
                    // Videos Grid
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(filteredVideos) { video in
                                VideoCard(
                                    video: video,
                                    onTap: {
                                        selectedVideo = video
                                        loadVideo(video)
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilters) {
                FilterView()
            }
            .sheet(item: $selectedVideo) { video in
                VideoDetailView(
                    video: video,
                    player: $player,
                    playerItem: $playerItem,
                    isPlaying: $isPlaying,
                    currentTime: $currentTime,
                    duration: $duration,
                    volume: $volume,
                    isMuted: $isMuted,
                    playbackSpeed: $playbackSpeed,
                    isFullscreen: $isFullscreen
                )
            }
            .sheet(isPresented: $showPlaylist) {
                PlaylistView(videos: sampleVideos)
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
            .onAppear {
                loadBackgroundVideo()
            }
        }
    }
    
    var filteredVideos: [Video] {
        var videos = sampleVideos
        
        if selectedCategory != "all" {
            videos = videos.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            videos = videos.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return videos
    }
    
    private func loadBackgroundVideo() {
        guard let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.isMuted = true
        player?.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    private func loadVideo(_ video: Video) {
        guard let url = URL(string: video.videoURL) else { return }
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.isMuted = isMuted
        player?.volume = Float(volume)
        player?.rate = Float(playbackSpeed)
    }
}

struct VideoCard: View {
    let video: Video
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Video Thumbnail
            AsyncImage(url: URL(string: video.thumbnailURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    )
            }
            .frame(height: 120)
            .clipped()
            .cornerRadius(8)
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Text(video.duration)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(4)
                    }
                    Spacer()
                }
                .padding(8)
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(video.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                
                Text(video.author)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .black, radius: 1)
                
                HStack {
                    Text("\(video.viewCount) views")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(color: .black, radius: 1)
                    
                    Spacer()
                    
                    Text(video.publishDate, style: .relative)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(color: .black, radius: 1)
                }
                
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < Int(video.rating) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    
                    Text("(\(video.rating, specifier: "%.1f"))")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(color: .black, radius: 1)
                }
            }
            .padding(.horizontal, 4)
        }
        .background(Color.black.opacity(0.3))
        .cornerRadius(12)
        .onTapGesture {
            onTap()
        }
    }
}

struct VideoDetailView: View {
    let video: Video
    @Binding var player: AVPlayer?
    @Binding var playerItem: AVPlayerItem?
    @Binding var isPlaying: Bool
    @Binding var currentTime: Double
    @Binding var duration: Double
    @Binding var volume: Double
    @Binding var isMuted: Bool
    @Binding var playbackSpeed: Double
    @Binding var isFullscreen: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Video Player
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(16/9, contentMode: .fit)
                        .onAppear {
                            player.play()
                            isPlaying = true
                        }
                        .onDisappear {
                            player.pause()
                            isPlaying = false
                        }
                }
                
                // Video Info
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(video.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("\(video.viewCount) views")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("•")
                                    .foregroundColor(.secondary)
                                
                                Text(video.publishDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                ForEach(0..<5) { index in
                                    Image(systemName: index < Int(video.rating) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                                
                                Text("\(video.rating, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // Author Info
                        HStack {
                            AsyncImage(url: URL(string: video.authorImageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.gray)
                                    )
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(video.author)
                                    .font(.headline)
                                
                                Text("\(video.subscriberCount) subscribers")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                // Subscribe
                            }) {
                                Text("Subscribe")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.red)
                                    .cornerRadius(20)
                            }
                        }
                        
                        // Description
                        Text(video.description)
                            .font(.body)
                            .lineSpacing(4)
                        
                        // Tags
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 100))
                        ], spacing: 8) {
                            ForEach(video.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(12)
                            }
                        }
                        
                        // Action Buttons
                        HStack(spacing: 16) {
                            Button(action: {
                                // Like
                            }) {
                                HStack {
                                    Image(systemName: "hand.thumbsup")
                                    Text("\(video.likeCount)")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                // Dislike
                            }) {
                                HStack {
                                    Image(systemName: "hand.thumbsdown")
                                    Text("\(video.dislikeCount)")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
                            
                            Button(action: {
                                // Share
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Video")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PlaylistView: View {
    let videos: [Video]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(videos) { video in
                    HStack {
                        AsyncImage(url: URL(string: video.thumbnailURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .frame(width: 80, height: 60)
                        .clipped()
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(video.title)
                                .font(.headline)
                                .lineLimit(2)
                            
                            Text(video.author)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(video.duration)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Playlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Welcome to VideoHub")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Discover and watch amazing videos")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                VStack(spacing: 12) {
                    Button(action: {
                        // Edit profile
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit Profile")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Settings
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDuration = "all"
    @State private var selectedQuality = "all"
    @State private var selectedDateRange = "all"
    @State private var showOnlySubscribed = false
    
    let durations = ["all", "short", "medium", "long"]
    let qualities = ["all", "HD", "4K", "8K"]
    let dateRanges = ["all", "today", "week", "month", "year"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Duration") {
                    Picker("Duration", selection: $selectedDuration) {
                        ForEach(durations, id: \.self) { duration in
                            Text(duration.capitalized).tag(duration)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Quality") {
                    Picker("Quality", selection: $selectedQuality) {
                        ForEach(qualities, id: \.self) { quality in
                            Text(quality).tag(quality)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Date Range") {
                    Picker("Date Range", selection: $selectedDateRange) {
                        ForEach(dateRanges, id: \.self) { range in
                            Text(range.capitalized).tag(range)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Options") {
                    Toggle("Show Only Subscribed", isOn: $showOnlySubscribed)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedDuration = "all"
                        selectedQuality = "all"
                        selectedDateRange = "all"
                        showOnlySubscribed = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Data Models
struct Video: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let authorImageURL: String
    let subscriberCount: Int
    let videoURL: String
    let thumbnailURL: String
    let duration: String
    let viewCount: Int
    let likeCount: Int
    let dislikeCount: Int
    let rating: Double
    let publishDate: Date
    let category: String
    let tags: [String]
}

let sampleVideos = [
    Video(
        title: "Amazing Nature Documentary",
        description: "Explore the breathtaking beauty of nature in this stunning documentary featuring wildlife from around the world.",
        author: "Nature Channel",
        authorImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
        subscriberCount: 2500000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400",
        duration: "15:30",
        viewCount: 1250000,
        likeCount: 45000,
        dislikeCount: 1200,
        rating: 4.8,
        publishDate: Date().addingTimeInterval(-86400),
        category: "entertainment",
        tags: ["nature", "documentary", "wildlife", "beautiful"]
    ),
    Video(
        title: "Learn Swift Programming",
        description: "Complete tutorial on Swift programming language for iOS development. Perfect for beginners and intermediate developers.",
        author: "Code Academy",
        authorImageURL: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150",
        subscriberCount: 1800000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400",
        duration: "45:20",
        viewCount: 890000,
        likeCount: 32000,
        dislikeCount: 800,
        rating: 4.7,
        publishDate: Date().addingTimeInterval(-172800),
        category: "education",
        tags: ["programming", "swift", "ios", "tutorial"]
    ),
    Video(
        title: "Epic Gaming Moments",
        description: "Compilation of the most epic gaming moments from popular video games. Prepare to be amazed!",
        author: "Gaming Pro",
        authorImageURL: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150",
        subscriberCount: 3200000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?w=400",
        duration: "12:45",
        viewCount: 2100000,
        likeCount: 78000,
        dislikeCount: 2500,
        rating: 4.6,
        publishDate: Date().addingTimeInterval(-259200),
        category: "gaming",
        tags: ["gaming", "epic", "moments", "compilation"]
    ),
    Video(
        title: "Healthy Cooking Recipes",
        description: "Learn to cook delicious and healthy meals with these easy-to-follow recipes. Perfect for busy weeknights!",
        author: "Healthy Chef",
        authorImageURL: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150",
        subscriberCount: 950000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400",
        duration: "25:15",
        viewCount: 650000,
        likeCount: 28000,
        dislikeCount: 600,
        rating: 4.9,
        publishDate: Date().addingTimeInterval(-345600),
        category: "education",
        tags: ["cooking", "healthy", "recipes", "food"]
    ),
    Video(
        title: "Sports Highlights",
        description: "Best moments from this week's sports events. Football, basketball, tennis, and more!",
        author: "Sports Central",
        authorImageURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150",
        subscriberCount: 4100000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400",
        duration: "18:30",
        viewCount: 3200000,
        likeCount: 95000,
        dislikeCount: 3200,
        rating: 4.5,
        publishDate: Date().addingTimeInterval(-432000),
        category: "sports",
        tags: ["sports", "highlights", "football", "basketball"]
    ),
    Video(
        title: "Relaxing Music",
        description: "Beautiful instrumental music perfect for relaxation, meditation, or studying. Enjoy the peaceful melodies.",
        author: "Music Therapy",
        authorImageURL: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150",
        subscriberCount: 1200000,
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
        thumbnailURL: "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400",
        duration: "60:00",
        viewCount: 1800000,
        likeCount: 67000,
        dislikeCount: 1500,
        rating: 4.8,
        publishDate: Date().addingTimeInterval(-518400),
        category: "music",
        tags: ["music", "relaxing", "instrumental", "meditation"]
    )
]

// Extension for placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct AutoPlayingBackgroundVideo_Previews: PreviewProvider {
    static var previews: some View {
        AutoPlayingBackgroundVideo()
    }
}

