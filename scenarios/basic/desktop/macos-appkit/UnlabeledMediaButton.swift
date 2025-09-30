import Cocoa

class UnlabeledMediaButton: NSViewController {
    
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var videoImageView: NSImageView!
    @IBOutlet weak var progressSlider: NSSlider!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var durationLabel: NSTextField!
    
    private var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        
        // Video Image
        videoImageView.image = NSImage(named: "video_placeholder")
        videoImageView.imageScaling = .scaleProportionallyUpOrDown
        
        // UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name
        playButton.title = "▶️"
        playButton.target = self
        playButton.action = #selector(playButtonTapped)
        playButton.bezelStyle = .rounded
        playButton.font = NSFont.systemFont(ofSize: 24)
        
        // Progress Slider
        progressSlider.minValue = 0
        progressSlider.maxValue = 100
        progressSlider.doubleValue = 30
        progressSlider.target = self
        progressSlider.action = #selector(progressChanged)
        
        // Time Labels
        timeLabel.stringValue = "2:15"
        timeLabel.textColor = .white
        timeLabel.font = NSFont.systemFont(ofSize: 14)
        
        durationLabel.stringValue = "7:30"
        durationLabel.textColor = .white
        durationLabel.font = NSFont.systemFont(ofSize: 14)
    }
    
    @objc private func playButtonTapped() {
        isPlaying.toggle()
        playButton.title = isPlaying ? "⏸️" : "▶️"
    }
    
    @objc private func progressChanged() {
        // Handle progress change
    }
}

// MARK: - Storyboard Support
extension UnlabeledMediaButton {
    static func instantiate() -> UnlabeledMediaButton {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "UnlabeledMediaButton") as! UnlabeledMediaButton
    }
}
