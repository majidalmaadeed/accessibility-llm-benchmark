import UIKit

class UnlabeledMediaButtonViewController: UIViewController {
    
    private var videoPlayer: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVideoPlayer()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Video Player"
        
        // Video container view
        let videoContainer = UIView()
        videoContainer.backgroundColor = .black
        videoContainer.layer.cornerRadius = 12
        videoContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoContainer)
        
        // Play/Pause button - using only emoji without accessible name
        let playButton = UIButton(type: .system)
        playButton.setTitle("▶️", for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        playButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        playButton.layer.cornerRadius = 35
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        videoContainer.addSubview(playButton)
        
        // Video info
        let videoTitle = UILabel()
        videoTitle.text = "Amazing Nature Documentary"
        videoTitle.font = UIFont.boldSystemFont(ofSize: 24)
        videoTitle.textAlignment = .center
        videoTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoTitle)
        
        let videoDescription = UILabel()
        videoDescription.text = "Experience the beauty of nature in this stunning 4K documentary featuring wildlife from around the world."
        videoDescription.font = UIFont.systemFont(ofSize: 16)
        videoDescription.textAlignment = .center
        videoDescription.numberOfLines = 0
        videoDescription.textColor = .secondaryLabel
        videoDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoDescription)
        
        // Video controls
        let controlsStack = UIStackView()
        controlsStack.axis = .horizontal
        controlsStack.distribution = .fillEqually
        controlsStack.spacing = 20
        controlsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlsStack)
        
        let rewindButton = UIButton(type: .system)
        rewindButton.setTitle("⏪", for: .normal)
        rewindButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        rewindButton.addTarget(self, action: #selector(rewindTapped), for: .touchUpInside)
        controlsStack.addArrangedSubview(rewindButton)
        
        let forwardButton = UIButton(type: .system)
        forwardButton.setTitle("⏩", for: .normal)
        forwardButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        forwardButton.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        controlsStack.addArrangedSubview(forwardButton)
        
        let volumeButton = UIButton(type: .system)
        volumeButton.setTitle("🔊", for: .normal)
        volumeButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        volumeButton.addTarget(self, action: #selector(volumeTapped), for: .touchUpInside)
        controlsStack.addArrangedSubview(volumeButton)
        
        let fullscreenButton = UIButton(type: .system)
        fullscreenButton.setTitle("⛶", for: .normal)
        fullscreenButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        fullscreenButton.addTarget(self, action: #selector(fullscreenTapped), for: .touchUpInside)
        controlsStack.addArrangedSubview(fullscreenButton)
        
        // Progress slider
        let progressSlider = UISlider()
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = 100
        progressSlider.value = 0
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.addTarget(self, action: #selector(progressChanged), for: .valueChanged)
        view.addSubview(progressSlider)
        
        // Time labels
        let timeStack = UIStackView()
        timeStack.axis = .horizontal
        timeStack.distribution = .equalSpacing
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeStack)
        
        let currentTimeLabel = UILabel()
        currentTimeLabel.text = "0:00"
        currentTimeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        currentTimeLabel.textColor = .secondaryLabel
        timeStack.addArrangedSubview(currentTimeLabel)
        
        let durationLabel = UILabel()
        durationLabel.text = "10:30"
        durationLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        durationLabel.textColor = .secondaryLabel
        timeStack.addArrangedSubview(durationLabel)
        
        // Video quality selector
        let qualityButton = UIButton(type: .system)
        qualityButton.setTitle("Quality: 1080p", for: .normal)
        qualityButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        qualityButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        qualityButton.layer.cornerRadius = 8
        qualityButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        qualityButton.translatesAutoresizingMaskIntoConstraints = false
        qualityButton.addTarget(self, action: #selector(qualityTapped), for: .touchUpInside)
        view.addSubview(qualityButton)
        
        // Subtitles button
        let subtitlesButton = UIButton(type: .system)
        subtitlesButton.setTitle("CC", for: .normal)
        subtitlesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        subtitlesButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
        subtitlesButton.layer.cornerRadius = 8
        subtitlesButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        subtitlesButton.translatesAutoresizingMaskIntoConstraints = false
        subtitlesButton.addTarget(self, action: #selector(subtitlesTapped), for: .touchUpInside)
        view.addSubview(subtitlesButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            videoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            videoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            videoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            videoContainer.heightAnchor.constraint(equalTo: videoContainer.widthAnchor, multiplier: 9/16),
            
            playButton.centerXAnchor.constraint(equalTo: videoContainer.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: videoContainer.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 70),
            playButton.heightAnchor.constraint(equalToConstant: 70),
            
            videoTitle.topAnchor.constraint(equalTo: videoContainer.bottomAnchor, constant: 20),
            videoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            videoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            videoDescription.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 8),
            videoDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            videoDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            controlsStack.topAnchor.constraint(equalTo: videoDescription.bottomAnchor, constant: 30),
            controlsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            controlsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            controlsStack.heightAnchor.constraint(equalToConstant: 50),
            
            progressSlider.topAnchor.constraint(equalTo: controlsStack.bottomAnchor, constant: 20),
            progressSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timeStack.topAnchor.constraint(equalTo: progressSlider.bottomAnchor, constant: 8),
            timeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            qualityButton.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: 30),
            qualityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            
            subtitlesButton.topAnchor.constraint(equalTo: timeStack.bottomAnchor, constant: 30),
            subtitlesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60)
        ])
    }
    
    private func setupVideoPlayer() {
        guard let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
        
        videoPlayer = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        if let playerLayer = playerLayer {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100) // Will be set properly in viewDidLayoutSubviews
            view.layer.addSublayer(playerLayer)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let playerLayer = playerLayer {
            let videoContainer = view.subviews.first { $0.backgroundColor == .black }
            playerLayer.frame = videoContainer?.bounds ?? .zero
        }
    }
    
    @objc private func playPauseTapped() {
        guard let player = videoPlayer else { return }
        
        if isPlaying {
            player.pause()
            if let button = findButton(with: "▶️") {
                button.setTitle("▶️", for: .normal)
            }
        } else {
            player.play()
            if let button = findButton(with: "▶️") {
                button.setTitle("⏸️", for: .normal)
            }
        }
        
        isPlaying.toggle()
    }
    
    @objc private func rewindTapped() {
        guard let player = videoPlayer else { return }
        let currentTime = player.currentTime()
        let newTime = CMTime(seconds: max(0, currentTime.seconds - 10), preferredTimescale: currentTime.timescale)
        player.seek(to: newTime)
    }
    
    @objc private func forwardTapped() {
        guard let player = videoPlayer else { return }
        let currentTime = player.currentTime()
        let newTime = CMTime(seconds: currentTime.seconds + 10, preferredTimescale: currentTime.timescale)
        player.seek(to: newTime)
    }
    
    @objc private func volumeTapped() {
        guard let player = videoPlayer else { return }
        player.isMuted.toggle()
        
        if let button = findButton(with: "🔊") {
            button.setTitle(player.isMuted ? "🔇" : "🔊", for: .normal)
        }
    }
    
    @objc private func fullscreenTapped() {
        // Toggle fullscreen mode
        if let button = findButton(with: "⛶") {
            button.setTitle("⛷", for: .normal)
        }
    }
    
    @objc private func progressChanged(_ slider: UISlider) {
        guard let player = videoPlayer else { return }
        let duration = player.currentItem?.duration.seconds ?? 0
        let newTime = CMTime(seconds: Double(slider.value) * duration / 100, preferredTimescale: 600)
        player.seek(to: newTime)
    }
    
    @objc private func qualityTapped() {
        let alert = UIAlertController(title: "Video Quality", message: "Select video quality", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "720p", style: .default) { _ in
            // Change quality to 720p
        })
        
        alert.addAction(UIAlertAction(title: "1080p", style: .default) { _ in
            // Change quality to 1080p
        })
        
        alert.addAction(UIAlertAction(title: "4K", style: .default) { _ in
            // Change quality to 4K
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func subtitlesTapped() {
        let alert = UIAlertController(title: "Subtitles", message: "Select subtitle language", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "English", style: .default) { _ in
            // Enable English subtitles
        })
        
        alert.addAction(UIAlertAction(title: "Spanish", style: .default) { _ in
            // Enable Spanish subtitles
        })
        
        alert.addAction(UIAlertAction(title: "French", style: .default) { _ in
            // Enable French subtitles
        })
        
        alert.addAction(UIAlertAction(title: "Off", style: .default) { _ in
            // Disable subtitles
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func findButton(with title: String) -> UIButton? {
        return view.subviews.compactMap { $0 as? UIButton }.first { $0.title(for: .normal) == title }
    }
}

import AVFoundation
