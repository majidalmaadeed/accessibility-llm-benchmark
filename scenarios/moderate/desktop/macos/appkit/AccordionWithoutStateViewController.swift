import Cocoa
class AccordionWithoutStateViewController: NSViewController {
    // MARK: - UI Elements
    @IBOutlet weak var accordionStackView: NSStackView!
    // MARK: - State
    private var expandedItems: Set<Int> = []
    private var faqItems: [FAQItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFAQItems()
        setupUI()
    }
    private func setupFAQItems() {
        faqItems = [
            FAQItem(
            ),
            FAQItem(
            ),
            FAQItem(
                question: "What are the WCAG guidelines?",
            ),
            FAQItem(
            )
        ]
    }
    private func setupUI() {
        // Create accordion items
        for (index, item) in faqItems.enumerated() {
            let accordionItem = createAccordionItem(for: item, at: index)
            accordionStackView.addArrangedSubview(accordionItem)
        }
    }
    private func createAccordionItem(for item: FAQItem, at index: Int) -> NSView {
        let containerView = NSView()
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        containerView.layer?.cornerRadius = 8
        containerView.layer?.borderWidth = 1
        containerView.layer?.borderColor = NSColor.separatorColor.cgColor
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let questionButton = NSButton()
        questionButton.title = item.question
        questionButton.bezelStyle = .rounded
        questionButton.isBordered = false
        questionButton.alignment = .left
        questionButton.font = NSFont.systemFont(ofSize: 16, weight: .bold)
        questionButton.target = self
        questionButton.action = #selector(questionClicked(_:))
        questionButton.tag = index
        // Add expand/collapse indicator
        let headerStackView = NSStackView()
        headerStackView.orientation = .horizontal
        headerStackView.addArrangedSubview(questionButton)
        headerStackView.spacing = 10
        let answerView = NSView()
        answerView.isHidden = true
        answerView.wantsLayer = true
        answerView.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        NSLayoutConstraint.activate([
        ])
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(answerView)
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
        ])
        // Store references for later use
        return containerView
    }
        // Basic setup only
        for (index, item) in faqItems.enumerated() {
            if let questionButton = view.viewWithTag(index) as? NSButton {
            }
        }
    }
    @objc private func questionClicked(_ sender: NSButton) {
        let index = sender.tag
        toggleQuestion(at: index)
    }
    private func toggleQuestion(at index: Int) {
        if expandedItems.contains(index) {
            expandedItems.remove(index)
        } else {
            expandedItems.insert(index)
        }
        // Update UI
        updateAccordionItem(at: index)
    }
    private func updateAccordionItem(at index: Int) {
        guard let containerView = accordionStackView.arrangedSubviews[safe: index] else { return }
        let isExpanded = expandedItems.contains(index)
        // Find the answer view and update its visibility
        for subview in containerView.subviews {
            if let stackView = subview as? NSStackView {
                for stackSubview in stackView.arrangedSubviews {
                        stackSubview.isHidden = !isExpanded
                        break
                    }
                }
            }
        }
        // Update indicator
        if let stackView = containerView.subviews.first as? NSStackView,
           let headerStackView = stackView.arrangedSubviews.first as? NSStackView,
        }
    }
    override func keyDown(with event: NSEvent) {
        // Should handle Arrow keys to navigate between accordion items
        // Should handle Home/End keys to go to first/last item
        // Should handle Enter/Space to toggle items
        switch event.keyCode {
        case 36: // Enter
        case 49: // Space
            // Allow default button behavior
            super.keyDown(with: event)
        case 125: // Down arrow
            break
        case 126: // Up arrow
            break
        case 115: // Home
            if let firstButton = view.viewWithTag(0) as? NSButton {
                firstButton.becomeFirstResponder()
            }
        case 119: // End
            if let lastButton = view.viewWithTag(faqItems.count - 1) as? NSButton {
                lastButton.becomeFirstResponder()
            }
        default:
            super.keyDown(with: event)
        }
    }
    // Should implement methods to:
    // 1. Get all accordion items
    // 4. Handle programmatic expansion/collapse
}
// MARK: - Helper Extensions
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
struct FAQItem {
    let question: String
    let answer: String
}
/*
 How to Fix:
 */
