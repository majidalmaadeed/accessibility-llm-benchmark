import SwiftUI

struct SmallTouchTarget: View {
    @State private var selectedTab = 0
    @State private var isLoggedIn = false
    @State private var showProfile = false
    @State private var notifications = 5
    @State private var searchText = ""
    @State private var selectedCategory = "all"
    @State private var showFilters = false
    @State private var isPlaying = false
    @State private var currentSong = "Sample Song"
    @State private var currentArtist = "Sample Artist"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationView {
                ScrollView {
                    VStack(spacing: 16) {
                        // Header with search and profile
                        HStack {
                            Button(action: {
                                showProfile = true
                            }) {
                                Image(systemName: "person.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Text("Music App")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                // Notifications
                            }) {
                                ZStack {
                                    Image(systemName: "bell")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                    
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
                        .padding()
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search songs, artists, albums...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Category Filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["all", "pop", "rock", "jazz", "classical", "electronic"], id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        Text(category.capitalized)
                                            .font(.caption)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                            .foregroundColor(selectedCategory == category ? .white : .primary)
                                            .cornerRadius(15)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Featured Playlists
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Featured Playlists")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Button("See All") {
                                    // See all playlists
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(0..<5) { index in
                                        PlaylistCard(
                                            title: "Playlist \(index + 1)",
                                            subtitle: "\(Int.random(in: 10...50)) songs",
                                            imageName: "music.note"
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Recently Played
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Recently Played")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Button("Clear") {
                                    // Clear recent
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                            
                            LazyVStack(spacing: 8) {
                                ForEach(0..<10) { index in
                                    SongRow(
                                        title: "Song \(index + 1)",
                                        artist: "Artist \(index + 1)",
                                        duration: "3:\(String(format: "%02d", Int.random(in: 10...59)))",
                                        isPlaying: index == 0
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            
            // Search Tab
            NavigationView {
                VStack {
                    Text("Search")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("Search")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            
            // Library Tab
            NavigationView {
                VStack {
                    Text("Library")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("Library")
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Library")
            }
            .tag(2)
            
            // Profile Tab
            NavigationView {
                VStack {
                    Text("Profile")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("Profile")
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .tag(3)
        }
        .overlay(
            // Mini Player
            VStack {
                Spacer()
                
                if isPlaying {
                    VStack(spacing: 0) {
                        // Progress Bar
                        ProgressView(value: 0.3)
                            .progressViewStyle(LinearProgressViewStyle())
                            .accentColor(.blue)
                        
                        HStack {
                            // Song Info
                            VStack(alignment: .leading, spacing: 2) {
                                Text(currentSong)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                
                                Text(currentArtist)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            // Control Buttons
                            HStack(spacing: 16) {
                                Button(action: {
                                    // Previous
                                }) {
                                    Image(systemName: "backward.fill")
                                        .font(.caption)
                                }
                                
                                Button(action: {
                                    isPlaying.toggle()
                                }) {
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.caption)
                                }
                                
                                Button(action: {
                                    // Next
                                }) {
                                    Image(systemName: "forward.fill")
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            // More Options
                            Button(action: {
                                // More options
                            }) {
                                Image(systemName: "ellipsis")
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.1))
                    }
                }
            }
        )
        .sheet(isPresented: $showProfile) {
            ProfileView()
        }
    }
}

struct PlaylistCard: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 80, height: 80)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(width: 100)
    }
}

struct SongRow: View {
    let title: String
    let artist: String
    let duration: String
    let isPlaying: Bool
    
    var body: some View {
        HStack {
            // Play/Pause Button
            Button(action: {
                // Play song
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle")
                    .font(.title3)
                    .foregroundColor(isPlaying ? .blue : .gray)
            }
            
            // Song Info
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isPlaying ? .medium : .regular)
                    .foregroundColor(isPlaying ? .blue : .primary)
                    .lineLimit(1)
                
                Text(artist)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Duration
            Text(duration)
                .font(.caption)
                .foregroundColor(.secondary)
            
            // More Options
            Button(action: {
                // More options
            }) {
                Image(systemName: "ellipsis")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Header
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("John Doe")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("john.doe@example.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Profile Options
                VStack(spacing: 0) {
                    ProfileOptionRow(
                        icon: "person",
                        title: "Edit Profile",
                        action: {}
                    )
                    
                    ProfileOptionRow(
                        icon: "gear",
                        title: "Settings",
                        action: {}
                    )
                    
                    ProfileOptionRow(
                        icon: "bell",
                        title: "Notifications",
                        action: {}
                    )
                    
                    ProfileOptionRow(
                        icon: "lock",
                        title: "Privacy",
                        action: {}
                    )
                    
                    ProfileOptionRow(
                        icon: "questionmark.circle",
                        title: "Help & Support",
                        action: {}
                    )
                    
                    ProfileOptionRow(
                        icon: "arrow.right.square",
                        title: "Sign Out",
                        action: {},
                        isDestructive: true
                    )
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
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

struct ProfileOptionRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    var isDestructive: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isDestructive ? .red : .blue)
                    .frame(width: 24)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(isDestructive ? .red : .primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

struct SmallTouchTarget_Previews: PreviewProvider {
    static var previews: some View {
        SmallTouchTarget()
    }
}

