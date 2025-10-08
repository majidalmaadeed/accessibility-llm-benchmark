import Cocoa
import AVKit

class AutoPlayingBackgroundVideo: NSViewController {
    
    @IBOutlet weak var videoPlayerView: AVPlayerView!
    @IBOutlet weak var videoOverlayView: NSView!
    @IBOutlet weak var playPauseButton: NSButton!
    @IBOutlet weak var videoTitleLabel: NSTextField!
    @IBOutlet weak var progressSlider: NSSlider!
    @IBOutlet weak var currentTimeLabel: NSTextField!
    @IBOutlet weak var durationLabel: NSTextField!
    
    @IBOutlet weak var featuredTitleLabel: NSTextField!
    @IBOutlet weak var featuredSubtitleLabel: NSTextField!
    @IBOutlet weak var categoriesStackView: NSStackView!
    @IBOutlet weak var recentVideosTableView: NSTableView!
    
    private var player: AVPlayer?
    private var isPlaying = false
    private var currentTime = 0.0
    private var duration = 30.0
    private var progressTimer: Timer?
    
    private var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVideoPlayer()
        loadVideos()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        
        // Video Overlay
        videoOverlayView.wantsLayer = true
        videoOverlayView.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.5).cgColor
        videoOverlayView.layer?.cornerRadius = 8
        
        // Play/Pause Button
        playPauseButton.title = "▶️"
        playPauseButton.font = NSFont.systemFont(ofSize: 40)
        playPauseButton.target = self
        playPauseButton.action = #selector(playPauseTapped)
        
        // Video Title
        videoTitleLabel.stringValue = "Flutter Development Tutorial"
        videoTitleLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        videoTitleLabel.textColor = .white
        videoTitleLabel.alignment = .center
        
        // Progress Slider
        progressSlider.minValue = 0
        progressSlider.maxValue = 100
        progressSlider.doubleValue = 30
        progressSlider.target = self
        progressSlider.action = #selector(progressChanged)
        
        // Time Labels
        currentTimeLabel.stringValue = "2:15"
        currentTimeLabel.textColor = .white
        currentTimeLabel.font = NSFont.systemFont(ofSize: 14)
        
        durationLabel.stringValue = "7:30"
        durationLabel.textColor = .white
        durationLabel.font = NSFont.systemFont(ofSize: 14)
        
        // Featured Content
        featuredTitleLabel.stringValue = "Featured Content"
        featuredTitleLabel.font = NSFont.systemFont(ofSize: 24, weight: .bold)
        
        featuredSubtitleLabel.stringValue = "Discover our latest videos and tutorials"
        featuredSubtitleLabel.font = NSFont.systemFont(ofSize: 18)
        featuredSubtitleLabel.textColor = .secondaryLabelColor
        featuredSubtitleLabel.alignment = .center
        
        // Video Categories
        setupVideoCategories()
        
        // Recent Videos Table View
        recentVideosTableView.dataSource = self
        recentVideosTableView.delegate = self
        recentVideosTableView.target = self
        recentVideosTableView.doubleAction = #selector(videoDoubleClicked)
    }
    
    private func setupVideoPlayer() {
        // AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
        let videoURL = URL(string: "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4")!
        player = AVPlayer(url: videoURL)
        videoPlayerView.player = player
        
        // Start auto-play
        player?.play()
        isPlaying = true
        startProgressTimer()
    }
    
    private func setupVideoCategories() {
        let categories = [
            ("🎥", "Tutorials", "Learn new skills"),
            ("🎬", "Documentaries", "Explore the world"),
            ("🎭", "Entertainment", "Fun and games")
        ]
        
        for (icon, title, subtitle) in categories {
            let categoryView = createCategoryView(icon: icon, title: title, subtitle: subtitle)
            categoriesStackView.addArrangedSubview(categoryView)
        }
    }
    
    private func createCategoryView(icon: String, title: String, subtitle: String) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.shadowOpacity = 0.2
        containerView.layer?.shadowOffset = NSSize(width: 0, height: 2)
        containerView.layer?.shadowRadius = 4
        
        let iconLabel = NSTextField()
        iconLabel.stringValue = icon
        iconLabel.font = NSFont.systemFont(ofSize: 32)
        iconLabel.isEditable = false
        iconLabel.isBordered = false
        iconLabel.backgroundColor = .clear
        
        let titleLabel = NSTextField()
        titleLabel.stringValue = title
        titleLabel.font = NSFont.boldSystemFont(ofSize: 16)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.backgroundColor = .clear
        
        let subtitleLabel = NSTextField()
        subtitleLabel.stringValue = subtitle
        subtitleLabel.font = NSFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .secondaryLabelColor
        subtitleLabel.isEditable = false
        subtitleLabel.isBordered = false
        subtitleLabel.backgroundColor = .clear
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            iconLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 8),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    private func loadVideos() {
        videos = [
            Video(title: "Getting Started with SwiftUI", content: "Learn the basics of SwiftUI development", author: "John Smith", duration: "15 min", imageName: "swiftui_video"),
            Video(title: "Advanced iOS Development", content: "Master advanced iOS development techniques", author: "Sarah Johnson", duration: "25 min", imageName: "ios_video"),
            Video(title: "Flutter Performance Optimization", content: "Optimize your Flutter apps for better performance", author: "Mike Chen", duration: "20 min", imageName: "flutter_video"),
            Video(title: "React Native Best Practices", content: "Best practices for React Native development", author: "Emily Davis", duration: "18 min", imageName: "reactnative_video")
        ]
        recentVideosTableView.reloadData()
    }
    
    private func startProgressTimer() {
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isPlaying {
                self.currentTime += 0.1
                if self.currentTime >= self.duration {
                    self.currentTime = 0
                }
                self.progressSlider.doubleValue = (self.currentTime / self.duration) * 100
                self.currentTimeLabel.stringValue = self.formatTime(self.currentTime)
            }
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    @objc private func playPauseTapped() {
        isPlaying.toggle()
        if isPlaying {
            player?.play()
            playPauseButton.title = "⏸️"
        } else {
            player?.pause()
            playPauseButton.title = "▶️"
        }
    }
    
    @objc private func progressChanged() {
        let newTime = (progressSlider.doubleValue / 100) * duration
        currentTime = newTime
        currentTimeLabel.stringValue = formatTime(currentTime)
    }
    
    @objc private func videoDoubleClicked() {
        let selectedRow = recentVideosTableView.selectedRow
        if selectedRow >= 0 && selectedRow < videos.count {
            let video = videos[selectedRow]
            showVideoDetails(video)
        }
    }
    
    private func showVideoDetails(_ video: Video) {
        let alert = NSAlert()
        alert.messageText = video.title
        alert.informativeText = """
        Author: \(video.author)
        Duration: \(video.duration)
        
        \(video.content)
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    deinit {
        progressTimer?.invalidate()
    }
}

// MARK: - NSTableViewDataSource
extension AutoPlayingBackgroundVideo: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return videos.count
    }
}

// MARK: - NSTableViewDelegate
extension AutoPlayingBackgroundVideo: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let video = videos[row]
        
        let cellView = NSTableCellView()
        
        if let column = tableColumn {
            switch column.identifier.rawValue {
            case "thumbnail":
                let imageView = NSImageView()
                imageView.image = NSImage(named: video.imageName)
                imageView.imageScaling = .scaleProportionallyUpOrDown
                imageView.wantsLayer = true
                imageView.layer?.cornerRadius = 4
                cellView.addSubview(imageView)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    imageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 60),
                    imageView.heightAnchor.constraint(equalToConstant: 40)
                ])
                
            case "content":
                let stackView = NSStackView()
                stackView.orientation = .vertical
                stackView.spacing = 4
                stackView.alignment = .leading
                
                let titleLabel = NSTextField()
                titleLabel.stringValue = video.title
                titleLabel.font = NSFont.boldSystemFont(ofSize: 14)
                titleLabel.isEditable = false
                titleLabel.isBordered = false
                titleLabel.backgroundColor = .clear
                titleLabel.maximumNumberOfLines = 2
                
                let contentLabel = NSTextField()
                contentLabel.stringValue = video.content
                contentLabel.font = NSFont.systemFont(ofSize: 12)
                contentLabel.textColor = .secondaryLabelColor
                contentLabel.isEditable = false
                contentLabel.isBordered = false
                contentLabel.backgroundColor = .clear
                contentLabel.maximumNumberOfLines = 2
                
                let authorLabel = NSTextField()
                authorLabel.stringValue = "By \(video.author) • \(video.duration)"
                authorLabel.font = NSFont.systemFont(ofSize: 10)
                authorLabel.textColor = .secondaryLabelColor
                authorLabel.isEditable = false
                authorLabel.isBordered = false
                authorLabel.backgroundColor = .clear
                
                stackView.addArrangedSubview(titleLabel)
                stackView.addArrangedSubview(contentLabel)
                stackView.addArrangedSubview(authorLabel)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
                ])
                
            case "actions":
                let stackView = NSStackView()
                stackView.orientation = .horizontal
                stackView.spacing = 8
                
                let playButton = NSButton()
                playButton.title = "▶️"
                playButton.font = NSFont.systemFont(ofSize: 16)
                playButton.target = self
                playButton.action = #selector(playButtonTapped)
                playButton.tag = row
                
                let shareButton = NSButton()
                shareButton.title = "↗️"
                shareButton.font = NSFont.systemFont(ofSize: 16)
                shareButton.target = self
                shareButton.action = #selector(shareButtonTapped)
                shareButton.tag = row
                
                stackView.addArrangedSubview(playButton)
                stackView.addArrangedSubview(shareButton)
                
                cellView.addSubview(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
                    stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8)
                ])
                
            default:
                break
            }
        }
        
        return cellView
    }
    
    @objc private func playButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < videos.count {
            let video = videos[row]
            // Handle play
            let alert = NSAlert()
            alert.messageText = "Play Video"
            alert.informativeText = "Playing: \(video.title)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    @objc private func shareButtonTapped(_ sender: NSButton) {
        let row = sender.tag
        if row >= 0 && row < videos.count {
            let video = videos[row]
            // Handle share
            let alert = NSAlert()
            alert.messageText = "Share Video"
            alert.informativeText = "Share: \(video.title)"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
}

// MARK: - Video Model
struct Video {
    let title: String
    let content: String
    let author: String
    let duration: String
    let imageName: String
}

// MARK: - Storyboard Support
extension AutoPlayingBackgroundVideo {
    static func instantiate() -> AutoPlayingBackgroundVideo {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "AutoPlayingBackgroundVideo") as! AutoPlayingBackgroundVideo
    }
}
