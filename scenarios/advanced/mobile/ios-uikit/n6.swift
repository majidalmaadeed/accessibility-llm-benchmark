import UIKit
import AVKit

class MediaPlayerFullInterfaceViewController: UIViewController {
    
    // MARK: - Properties
    
    private var playerView: UIView!
    private var controlsView: UIView!
    private var playlistView: UIView!
    private var progressSlider: UISlider!
    private var volumeSlider: UISlider!
    private var timeLabel: UILabel!
    private var durationLabel: UILabel!
    private var playPauseButton: UIButton!
    private var previousButton: UIButton!
    private var nextButton: UIButton!
    private var fullscreenButton: UIButton!
    private var qualityButton: UIButton!
    private var captionsButton: UIButton!
    private var playlistButton: UIButton!
    private var speedButton: UIButton!
    
    private var isPlaying: Bool = false
    private var currentTime: Double = 0
    private var duration: Double = 180
    private var volume: Float = 0.5
    private var playbackSpeed: Float = 1.0
    private var isFullscreen: Bool = false
    private var showCaptions: Bool = false
    private var showPlaylist: Bool = false
    private var selectedQuality: String = "1080p"
    private var currentTrack: Int = 0
    
    let qualities = ["360p", "720p", "1080p", "4K"]
    let speeds: [Float] = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPlayer()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateLayoutForOrientation(size)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .black
        
        setupPlayerView()
        setupControlsView()
        setupPlaylistView()
        setupConstraints()
    }
    
    private func setupPlayerView() {
        playerView = UIView()
        playerView.backgroundColor = .black
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        // Video placeholder
        let videoPlaceholder = UIView()
        videoPlaceholder.backgroundColor = .systemGray2
        videoPlaceholder.layer.cornerRadius = 8
        videoPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        playerView.addSubview(videoPlaceholder)
        
        let playIcon = UILabel()
        playIcon.text = "▶️"
        playIcon.font = UIFont.systemFont(ofSize: 60)
        playIcon.textAlignment = .center
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        videoPlaceholder.addSubview(playIcon)
        
        // Top controls
        let topControlsView = UIView()
        topControlsView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        topControlsView.translatesAutoresizingMaskIntoConstraints = false
        playerView.addSubview(topControlsView)
        
        fullscreenButton = UIButton(type: .system)
        fullscreenButton.setTitle("⛶", for: .normal)
        fullscreenButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        fullscreenButton.setTitleColor(.white, for: .normal)
        fullscreenButton.addTarget(self, action: #selector(toggleFullscreen), for: .touchUpInside)
        fullscreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        qualityButton = UIButton(type: .system)
        qualityButton.setTitle(selectedQuality, for: .normal)
        qualityButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        qualityButton.setTitleColor(.white, for: .normal)
        qualityButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        qualityButton.layer.cornerRadius = 4
        qualityButton.addTarget(self, action: #selector(showQualityMenu), for: .touchUpInside)
        qualityButton.translatesAutoresizingMaskIntoConstraints = false
        
        [fullscreenButton, qualityButton].forEach {
            topControlsView.addSubview($0)
        }
        
        // Center controls
        let centerControlsView = UIView()
        centerControlsView.translatesAutoresizingMaskIntoConstraints = false
        playerView.addSubview(centerControlsView)
        
        previousButton = UIButton(type: .system)
        previousButton.setTitle("⏮", for: .normal)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        previousButton.setTitleColor(.white, for: .normal)
        previousButton.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        playPauseButton = UIButton(type: .system)
        playPauseButton.setTitle("⏸", for: .normal)
        playPauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        playPauseButton.setTitleColor(.white, for: .normal)
        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton = UIButton(type: .system)
        nextButton.setTitle("⏭", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        [previousButton, playPauseButton, nextButton].forEach {
            centerControlsView.addSubview($0)
        }
        
        // Bottom controls
        let bottomControlsView = UIView()
        bottomControlsView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bottomControlsView.translatesAutoresizingMaskIntoConstraints = false
        playerView.addSubview(bottomControlsView)
        
        timeLabel = UILabel()
        timeLabel.text = "0:00"
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        progressSlider = UISlider()
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = Float(duration)
        progressSlider.value = Float(currentTime)
        progressSlider.addTarget(self, action: #selector(progressChanged(_:)), for: .valueChanged)
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel = UILabel()
        durationLabel.text = formatTime(duration)
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .white
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [timeLabel, progressSlider, durationLabel].forEach {
            bottomControlsView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            videoPlaceholder.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 16),
            videoPlaceholder.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16),
            videoPlaceholder.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
            videoPlaceholder.heightAnchor.constraint(equalToConstant: 200),
            
            playIcon.centerXAnchor.constraint(equalTo: videoPlaceholder.centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: videoPlaceholder.centerYAnchor),
            
            topControlsView.topAnchor.constraint(equalTo: playerView.topAnchor),
            topControlsView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            topControlsView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            topControlsView.heightAnchor.constraint(equalToConstant: 50),
            
            fullscreenButton.topAnchor.constraint(equalTo: topControlsView.topAnchor, constant: 8),
            fullscreenButton.leadingAnchor.constraint(equalTo: topControlsView.leadingAnchor, constant: 16),
            
            qualityButton.topAnchor.constraint(equalTo: topControlsView.topAnchor, constant: 8),
            qualityButton.trailingAnchor.constraint(equalTo: topControlsView.trailingAnchor, constant: -16),
            qualityButton.widthAnchor.constraint(equalToConstant: 60),
            qualityButton.heightAnchor.constraint(equalToConstant: 30),
            
            centerControlsView.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            centerControlsView.centerYAnchor.constraint(equalTo: playerView.centerYAnchor),
            centerControlsView.heightAnchor.constraint(equalToConstant: 60),
            centerControlsView.widthAnchor.constraint(equalToConstant: 200),
            
            previousButton.leadingAnchor.constraint(equalTo: centerControlsView.leadingAnchor),
            previousButton.centerYAnchor.constraint(equalTo: centerControlsView.centerYAnchor),
            
            playPauseButton.centerXAnchor.constraint(equalTo: centerControlsView.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: centerControlsView.centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: centerControlsView.trailingAnchor),
            nextButton.centerYAnchor.constraint(equalTo: centerControlsView.centerYAnchor),
            
            bottomControlsView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            bottomControlsView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            bottomControlsView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            bottomControlsView.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.leadingAnchor.constraint(equalTo: bottomControlsView.leadingAnchor, constant: 16),
            timeLabel.centerYAnchor.constraint(equalTo: bottomControlsView.centerYAnchor),
            
            progressSlider.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
            progressSlider.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -8),
            progressSlider.centerYAnchor.constraint(equalTo: bottomControlsView.centerYAnchor),
            
            durationLabel.trailingAnchor.constraint(equalTo: bottomControlsView.trailingAnchor, constant: -16),
            durationLabel.centerYAnchor.constraint(equalTo: bottomControlsView.centerYAnchor)
        ])
    }
    
    private func setupControlsView() {
        controlsView = UIView()
        controlsView.backgroundColor = .systemGray6
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlsView)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        playlistButton = createControlButton(title: "📋", action: #selector(togglePlaylist))
        captionsButton = createControlButton(title: "💬", action: #selector(toggleCaptions))
        speedButton = createControlButton(title: "⚡", action: #selector(showSpeedMenu))
        
        [playlistButton, captionsButton, speedButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        let volumeLabel = UILabel()
        volumeLabel.text = "🔊"
        volumeLabel.font = UIFont.systemFont(ofSize: 20)
        volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        volumeSlider = UISlider()
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 1
        volumeSlider.value = volume
        volumeSlider.addTarget(self, action: #selector(volumeChanged(_:)), for: .valueChanged)
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        let volumeMaxLabel = UILabel()
        volumeMaxLabel.text = "🔊"
        volumeMaxLabel.font = UIFont.systemFont(ofSize: 20)
        volumeMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let trackLabel = UILabel()
        trackLabel.text = "Track \(currentTrack + 1) of 10"
        trackLabel.font = UIFont.systemFont(ofSize: 14)
        trackLabel.textColor = .secondaryLabel
        trackLabel.textAlignment = .center
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [stackView, volumeLabel, volumeSlider, volumeMaxLabel, trackLabel].forEach {
            controlsView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: controlsView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            
            volumeLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            volumeLabel.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            
            volumeSlider.leadingAnchor.constraint(equalTo: volumeLabel.trailingAnchor, constant: 8),
            volumeSlider.trailingAnchor.constraint(equalTo: volumeMaxLabel.leadingAnchor, constant: -8),
            volumeSlider.centerYAnchor.constraint(equalTo: volumeLabel.centerYAnchor),
            
            volumeMaxLabel.centerYAnchor.constraint(equalTo: volumeLabel.centerYAnchor),
            volumeMaxLabel.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            
            trackLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 16),
            trackLabel.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: 16),
            trackLabel.trailingAnchor.constraint(equalTo: controlsView.trailingAnchor, constant: -16),
            trackLabel.bottomAnchor.constraint(equalTo: controlsView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupPlaylistView() {
        playlistView = UIView()
        playlistView.backgroundColor = .systemGray6
        playlistView.isHidden = true
        playlistView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playlistView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Playlist"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let shuffleButton = UIButton(type: .system)
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.addTarget(self, action: #selector(shufflePlaylist), for: .touchUpInside)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, shuffleButton, tableView].forEach {
            playlistView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: playlistView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: playlistView.leadingAnchor, constant: 16),
            
            shuffleButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            shuffleButton.trailingAnchor.constraint(equalTo: playlistView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: playlistView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: playlistView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: playlistView.bottomAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            
            controlsView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlsView.heightAnchor.constraint(equalToConstant: 120),
            
            playlistView.topAnchor.constraint(equalTo: controlsView.bottomAnchor),
            playlistView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playlistView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playlistView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupPlayer() {
        // Initialize player
    }
    
    private func createControlButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    
    @objc private func togglePlayPause() {
        isPlaying.toggle()
        playPauseButton.setTitle(isPlaying ? "⏸" : "▶️", for: .normal)
    }
    
    @objc private func previousTrack() {
        if currentTrack > 0 {
            currentTrack -= 1
        }
    }
    
    @objc private func nextTrack() {
        if currentTrack < 9 {
            currentTrack += 1
        }
    }
    
    @objc private func toggleFullscreen() {
        isFullscreen.toggle()
        fullscreenButton.setTitle(isFullscreen ? "⛶" : "⛶", for: .normal)
    }
    
    @objc private func showQualityMenu() {
        let alert = UIAlertController(title: "Select Quality", message: nil, preferredStyle: .actionSheet)
        
        for quality in qualities {
            alert.addAction(UIAlertAction(title: quality, style: .default) { _ in
                self.selectedQuality = quality
                self.qualityButton.setTitle(quality, for: .normal)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func toggleCaptions() {
        showCaptions.toggle()
        captionsButton.setTitle(showCaptions ? "💬" : "💬", for: .normal)
    }
    
    @objc private func togglePlaylist() {
        showPlaylist.toggle()
        playlistView.isHidden = !showPlaylist
    }
    
    @objc private func showSpeedMenu() {
        let alert = UIAlertController(title: "Select Speed", message: nil, preferredStyle: .actionSheet)
        
        for speed in speeds {
            alert.addAction(UIAlertAction(title: "\(speed)x", style: .default) { _ in
                self.playbackSpeed = speed
                self.speedButton.setTitle("⚡ \(speed)x", for: .normal)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func shufflePlaylist() {
        print("Shuffling playlist")
    }
    
    @objc private func progressChanged(_ sender: UISlider) {
        currentTime = Double(sender.value)
        timeLabel.text = formatTime(currentTime)
    }
    
    @objc private func volumeChanged(_ sender: UISlider) {
        volume = sender.value
    }
    
    // MARK: - Helper Methods
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func updateLayoutForOrientation(_ size: CGSize) {
        // Handle orientation changes
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension MediaPlayerFullInterfaceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistTableViewCell
        
        let track = PlaylistTrack(
            title: "Track \(indexPath.row + 1)",
            artist: "Artist \(indexPath.row + 1)",
            duration: "3:45",
            isCurrent: indexPath.row == currentTrack,
            isPlaying: indexPath.row == currentTrack && isPlaying
        )
        
        cell.configure(with: track)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentTrack = indexPath.row
        tableView.reloadData()
    }
}

// MARK: - Supporting Views

class PlaylistTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let durationLabel = UILabel()
    private let statusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistLabel.font = UIFont.systemFont(ofSize: 14)
        artistLabel.textColor = .secondaryLabel
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .secondaryLabel
        durationLabel.textAlignment = .right
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, artistLabel, durationLabel, statusLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            artistLabel.trailingAnchor.constraint(lessThanOrEqualTo: durationLabel.leadingAnchor, constant: -8),
            artistLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            durationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            durationLabel.widthAnchor.constraint(equalToConstant: 40),
            
            statusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -8),
            statusLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with track: PlaylistTrack) {
        titleLabel.text = track.title
        artistLabel.text = track.artist
        durationLabel.text = track.duration
        
        if track.isCurrent {
            statusLabel.text = track.isPlaying ? "⏸" : "▶️"
            statusLabel.textColor = .systemBlue
            backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        } else {
            statusLabel.text = ""
            backgroundColor = .clear
        }
    }
}

// MARK: - Supporting Types

struct PlaylistTrack {
    let title: String
    let artist: String
    let duration: String
    let isCurrent: Bool
    let isPlaying: Bool
}
