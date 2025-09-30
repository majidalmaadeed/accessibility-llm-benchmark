import UIKit
import AVFoundation

class AutoPlayingBackgroundVideoViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var isVideoPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVideoPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startVideoPlayback()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopVideoPlayback()
    }
    
    deinit {
        stopVideoPlayback()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Scroll view setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Hero section with video background
        let heroView = createHeroSection()
        contentView.addSubview(heroView)
        
        // Content sections
        let featuresView = createFeaturesSection()
        contentView.addSubview(featuresView)
        
        let aboutView = createAboutSection()
        contentView.addSubview(aboutView)
        
        let contactView = createContactSection()
        contentView.addSubview(contactView)
        
        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            heroView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroView.heightAnchor.constraint(equalToConstant: 400),
            
            featuresView.topAnchor.constraint(equalTo: heroView.bottomAnchor),
            featuresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            aboutView.topAnchor.constraint(equalTo: featuresView.bottomAnchor),
            aboutView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            contactView.topAnchor.constraint(equalTo: aboutView.bottomAnchor),
            contactView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contactView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createHeroSection() -> UIView {
        let heroView = UIView()
        heroView.backgroundColor = .black
        heroView.translatesAutoresizingMaskIntoConstraints = false
        
        // Video will be added as a layer
        
        // Overlay content
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(overlayView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Our Platform"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Experience the future of technology with our innovative solutions"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.9
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(subtitleLabel)
        
        let ctaButton = UIButton(type: .system)
        ctaButton.setTitle("Get Started", for: .normal)
        ctaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        ctaButton.setTitleColor(.black, for: .normal)
        ctaButton.backgroundColor = .white
        ctaButton.layer.cornerRadius = 25
        ctaButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(ctaButton)
        
        // Video control button (hidden by default)
        let videoControlButton = UIButton(type: .system)
        videoControlButton.setTitle("⏸️", for: .normal)
        videoControlButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        videoControlButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        videoControlButton.layer.cornerRadius = 25
        videoControlButton.addTarget(self, action: #selector(videoControlTapped), for: .touchUpInside)
        videoControlButton.translatesAutoresizingMaskIntoConstraints = false
        videoControlButton.isHidden = true
        overlayView.addSubview(videoControlButton)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: heroView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: heroView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: heroView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: heroView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: overlayView.trailingAnchor, constant: -20),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: overlayView.trailingAnchor, constant: -20),
            
            ctaButton.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            ctaButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            ctaButton.widthAnchor.constraint(equalToConstant: 150),
            ctaButton.heightAnchor.constraint(equalToConstant: 50),
            
            videoControlButton.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 20),
            videoControlButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -20),
            videoControlButton.widthAnchor.constraint(equalToConstant: 50),
            videoControlButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return heroView
    }
    
    private func createFeaturesSection() -> UIView {
        let featuresView = UIView()
        featuresView.backgroundColor = .systemBackground
        featuresView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Our Features"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        featuresView.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        featuresView.addSubview(stackView)
        
        let features = [
            ("🚀 Fast Performance", "Lightning-fast processing with optimized algorithms"),
            ("🔒 Secure & Reliable", "Enterprise-grade security with 99.9% uptime"),
            ("📱 Mobile Ready", "Fully responsive design for all devices"),
            ("🌍 Global Scale", "Serving customers worldwide with local support")
        ]
        
        for (icon, description) in features {
            let featureView = createFeatureItem(icon: icon, description: description)
            stackView.addArrangedSubview(featureView)
        }
        
        NSLayoutConstraint.activate([
            featuresView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            
            titleLabel.topAnchor.constraint(equalTo: featuresView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: featuresView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: featuresView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: featuresView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: featuresView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: -40)
        ])
        
        return featuresView
    }
    
    private func createFeatureItem(icon: String, description: String) -> UIView {
        let featureView = UIView()
        featureView.backgroundColor = .systemGray6
        featureView.layer.cornerRadius = 12
        featureView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = UIFont.systemFont(ofSize: 32)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(iconLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        featureView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            featureView.heightAnchor.constraint(equalToConstant: 80),
            
            iconLabel.leadingAnchor.constraint(equalTo: featureView.leadingAnchor, constant: 20),
            iconLabel.centerYAnchor.constraint(equalTo: featureView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: featureView.trailingAnchor, constant: -20),
            descriptionLabel.centerYAnchor.constraint(equalTo: featureView.centerYAnchor)
        ])
        
        return featureView
    }
    
    private func createAboutSection() -> UIView {
        let aboutView = UIView()
        aboutView.backgroundColor = .systemBlue
        aboutView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "About Us"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "We are a leading technology company dedicated to creating innovative solutions that transform businesses and improve lives. Our team of experts works tirelessly to deliver cutting-edge products and services that meet the evolving needs of our customers."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.alpha = 0.9
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(descriptionLabel)
        
        let statsStackView = UIStackView()
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 20
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        aboutView.addSubview(statsStackView)
        
        let stats = [
            ("1000+", "Happy Customers"),
            ("50+", "Countries"),
            ("24/7", "Support"),
            ("99.9%", "Uptime")
        ]
        
        for (number, label) in stats {
            let statView = createStatItem(number: number, label: label)
            statsStackView.addArrangedSubview(statView)
        }
        
        NSLayoutConstraint.activate([
            aboutView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: aboutView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: aboutView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: aboutView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: aboutView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: aboutView.trailingAnchor, constant: -20),
            
            statsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            statsStackView.leadingAnchor.constraint(equalTo: aboutView.leadingAnchor, constant: 20),
            statsStackView.trailingAnchor.constraint(equalTo: aboutView.trailingAnchor, constant: -20),
            statsStackView.bottomAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: -40)
        ])
        
        return aboutView
    }
    
    private func createStatItem(number: String, label: String) -> UIView {
        let statView = UIView()
        statView.translatesAutoresizingMaskIntoConstraints = false
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.boldSystemFont(ofSize: 24)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        statView.addSubview(numberLabel)
        
        let labelLabel = UILabel()
        labelLabel.text = label
        labelLabel.font = UIFont.systemFont(ofSize: 14)
        labelLabel.textColor = .white
        labelLabel.textAlignment = .center
        labelLabel.alpha = 0.8
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        statView.addSubview(labelLabel)
        
        NSLayoutConstraint.activate([
            statView.heightAnchor.constraint(equalToConstant: 60),
            
            numberLabel.topAnchor.constraint(equalTo: statView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: statView.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: statView.trailingAnchor),
            
            labelLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 4),
            labelLabel.leadingAnchor.constraint(equalTo: statView.leadingAnchor),
            labelLabel.trailingAnchor.constraint(equalTo: statView.trailingAnchor),
            labelLabel.bottomAnchor.constraint(equalTo: statView.bottomAnchor)
        ])
        
        return statView
    }
    
    private func createContactSection() -> UIView {
        let contactView = UIView()
        contactView.backgroundColor = .systemBackground
        contactView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Get In Touch"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contactView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Ready to get started? Contact us today to learn more about our services."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contactView.addSubview(descriptionLabel)
        
        let contactButton = UIButton(type: .system)
        contactButton.setTitle("Contact Us", for: .normal)
        contactButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.backgroundColor = .systemBlue
        contactButton.layer.cornerRadius = 25
        contactButton.addTarget(self, action: #selector(contactUsTapped), for: .touchUpInside)
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactView.addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            contactView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: contactView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contactView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contactView.trailingAnchor, constant: -20),
            
            contactButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            contactButton.centerXAnchor.constraint(equalTo: contactView.centerXAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: 150),
            contactButton.heightAnchor.constraint(equalToConstant: 50),
            contactButton.bottomAnchor.constraint(lessThanOrEqualTo: contactView.bottomAnchor, constant: -40)
        ])
        
        return contactView
    }
    
    // MARK: - Video Player Setup
    private func setupVideoPlayer() {
        guard let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
        
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        
        if let playerLayer = playerLayer {
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100) // Will be set properly in viewDidLayoutSubviews
            view.layer.addSublayer(playerLayer)
        }
        
        // Loop the video
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let playerLayer = playerLayer {
            let heroView = contentView.subviews.first { $0.backgroundColor == .black }
            playerLayer.frame = heroView?.bounds ?? .zero
        }
    }
    
    private func startVideoPlayback() {
        guard let player = player else { return }
        player.play()
        isVideoPlaying = true
    }
    
    private func stopVideoPlayback() {
        guard let player = player else { return }
        player.pause()
        isVideoPlaying = false
    }
    
    @objc private func playerDidFinishPlaying() {
        guard let player = player else { return }
        player.seek(to: .zero)
        player.play()
    }
    
    // MARK: - Actions
    @objc private func getStartedTapped() {
        let alert = UIAlertController(title: "Get Started", message: "Welcome! Let's begin your journey with us.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func videoControlTapped() {
        guard let player = player else { return }
        
        if isVideoPlaying {
            player.pause()
            isVideoPlaying = false
        } else {
            player.play()
            isVideoPlaying = true
        }
    }
    
    @objc private func contactUsTapped() {
        let alert = UIAlertController(title: "Contact Us", message: "Thank you for your interest! We'll get back to you soon.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
