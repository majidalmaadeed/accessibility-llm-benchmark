import UIKit

class RichTextEditorViewController: UIViewController {
    
    // MARK: - Properties
    
    private var textView: UITextView!
    private var toolbarView: UIView!
    private var stylePanelView: UIView!
    private var statusBarView: UIView!
    private var scrollView: UIScrollView!
    
    private var isBold: Bool = false
    private var isItalic: Bool = false
    private var isUnderline: Bool = false
    private var fontSize: CGFloat = 16
    private var textColor: UIColor = .label
    private var backgroundColor: UIColor = .clear
    private var alignment: NSTextAlignment = .left
    private var showStylePanel: Bool = false
    private var showMediaPicker: Bool = false
    private var showLinkDialog: Bool = false
    private var linkURL: String = ""
    private var linkText: String = ""
    private var wordCount: Int = 0
    private var characterCount: Int = 0
    private var undoStack: [String] = []
    private var redoStack: [String] = []
    private var canUndo: Bool = false
    private var canRedo: Bool = false
    
    let fontSizes: [CGFloat] = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48]
    let textColors: [UIColor] = [.label, .systemRed, .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemPink, .systemBrown]
    let backgroundColors: [UIColor] = [.clear, .systemYellow, .systemGreen, .systemBlue, .systemRed, .systemOrange, .systemPurple, .systemGray]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextView()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Rich Text Editor"
        
        setupToolbarView()
        setupStylePanelView()
        setupTextView()
        setupStatusBarView()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupToolbarView() {
        toolbarView = UIView()
        toolbarView.backgroundColor = .systemGray6
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbarView)
        
        let topToolbar = createTopToolbar()
        let bottomToolbar = createBottomToolbar()
        
        [topToolbar, bottomToolbar].forEach {
            toolbarView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            topToolbar.topAnchor.constraint(equalTo: toolbarView.topAnchor),
            topToolbar.leadingAnchor.constraint(equalTo: toolbarView.leadingAnchor),
            topToolbar.trailingAnchor.constraint(equalTo: toolbarView.trailingAnchor),
            topToolbar.heightAnchor.constraint(equalToConstant: 44),
            
            bottomToolbar.topAnchor.constraint(equalTo: topToolbar.bottomAnchor),
            bottomToolbar.leadingAnchor.constraint(equalTo: toolbarView.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: toolbarView.trailingAnchor),
            bottomToolbar.heightAnchor.constraint(equalToConstant: 44),
            bottomToolbar.bottomAnchor.constraint(equalTo: toolbarView.bottomAnchor)
        ])
    }
    
    private func createTopToolbar() -> UIView {
        let toolbar = UIView()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let undoButton = createToolbarButton(title: "↶", action: #selector(undo))
        let redoButton = createToolbarButton(title: "↷", action: #selector(redo))
        let boldButton = createToolbarButton(title: "B", action: #selector(toggleBold))
        let italicButton = createToolbarButton(title: "I", action: #selector(toggleItalic))
        let underlineButton = createToolbarButton(title: "U", action: #selector(toggleUnderline))
        let styleButton = createToolbarButton(title: "Aa", action: #selector(toggleStylePanel))
        let mediaButton = createToolbarButton(title: "📷", action: #selector(showMediaPicker))
        let linkButton = createToolbarButton(title: "🔗", action: #selector(showLinkDialog))
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, redoButton, boldButton, italicButton, underlineButton, styleButton, mediaButton, linkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        toolbar.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: toolbar.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: -8)
        ])
        
        return toolbar
    }
    
    private func createBottomToolbar() -> UIView {
        let toolbar = UIView()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let leftAlignButton = createToolbarButton(title: "⬅", action: #selector(setLeftAlignment))
        let centerAlignButton = createToolbarButton(title: "↔", action: #selector(setCenterAlignment))
        let rightAlignButton = createToolbarButton(title: "➡", action: #selector(setRightAlignment))
        let bulletButton = createToolbarButton(title: "•", action: #selector(insertBulletList))
        let numberButton = createToolbarButton(title: "1.", action: #selector(insertNumberedList))
        let quoteButton = createToolbarButton(title: """, action: #selector(insertQuote))
        
        let stackView = UIStackView(arrangedSubviews: [leftAlignButton, centerAlignButton, rightAlignButton, bulletButton, numberButton, quoteButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        toolbar.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: toolbar.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: -8)
        ])
        
        return toolbar
    }
    
    private func setupStylePanelView() {
        stylePanelView = UIView()
        stylePanelView.backgroundColor = .systemGray6
        stylePanelView.isHidden = true
        stylePanelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stylePanelView)
        
        let fontSizeLabel = UILabel()
        fontSizeLabel.text = "Font Size"
        fontSizeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        fontSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSizePicker = UIPickerView()
        fontSizePicker.delegate = self
        fontSizePicker.dataSource = self
        fontSizePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let textColorLabel = UILabel()
        textColorLabel.text = "Text Color"
        textColorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        textColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textColorCollectionView = createColorCollectionView(colors: textColors, action: #selector(textColorSelected(_:)))
        
        let backgroundColorLabel = UILabel()
        backgroundColorLabel.text = "Background Color"
        backgroundColorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        backgroundColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundColorCollectionView = createColorCollectionView(colors: backgroundColors, action: #selector(backgroundColorSelected(_:)))
        
        [fontSizeLabel, fontSizePicker, textColorLabel, textColorCollectionView, backgroundColorLabel, backgroundColorCollectionView].forEach {
            stylePanelView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            fontSizeLabel.topAnchor.constraint(equalTo: stylePanelView.topAnchor, constant: 16),
            fontSizeLabel.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            fontSizeLabel.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            
            fontSizePicker.topAnchor.constraint(equalTo: fontSizeLabel.bottomAnchor, constant: 8),
            fontSizePicker.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            fontSizePicker.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            fontSizePicker.heightAnchor.constraint(equalToConstant: 100),
            
            textColorLabel.topAnchor.constraint(equalTo: fontSizePicker.bottomAnchor, constant: 16),
            textColorLabel.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            textColorLabel.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            
            textColorCollectionView.topAnchor.constraint(equalTo: textColorLabel.bottomAnchor, constant: 8),
            textColorCollectionView.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            textColorCollectionView.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            textColorCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            backgroundColorLabel.topAnchor.constraint(equalTo: textColorCollectionView.bottomAnchor, constant: 16),
            backgroundColorLabel.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            backgroundColorLabel.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            
            backgroundColorCollectionView.topAnchor.constraint(equalTo: backgroundColorLabel.bottomAnchor, constant: 8),
            backgroundColorCollectionView.leadingAnchor.constraint(equalTo: stylePanelView.leadingAnchor, constant: 16),
            backgroundColorCollectionView.trailingAnchor.constraint(equalTo: stylePanelView.trailingAnchor, constant: -16),
            backgroundColorCollectionView.heightAnchor.constraint(equalToConstant: 50),
            backgroundColorCollectionView.bottomAnchor.constraint(equalTo: stylePanelView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupTextView() {
        textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: fontSize)
        textView.textColor = textColor
        textView.backgroundColor = backgroundColor
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
    }
    
    private func setupStatusBarView() {
        statusBarView = UIView()
        statusBarView.backgroundColor = .systemGray6
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusBarView)
        
        let wordCountLabel = UILabel()
        wordCountLabel.text = "Words: 0"
        wordCountLabel.font = UIFont.systemFont(ofSize: 12)
        wordCountLabel.textColor = .secondaryLabel
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let characterCountLabel = UILabel()
        characterCountLabel.text = "Characters: 0"
        characterCountLabel.font = UIFont.systemFont(ofSize: 12)
        characterCountLabel.textColor = .secondaryLabel
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSizeLabel = UILabel()
        fontSizeLabel.text = "Font: 16pt"
        fontSizeLabel.font = UIFont.systemFont(ofSize: 12)
        fontSizeLabel.textColor = .secondaryLabel
        fontSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [wordCountLabel, characterCountLabel, fontSizeLabel].forEach {
            statusBarView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            wordCountLabel.leadingAnchor.constraint(equalTo: statusBarView.leadingAnchor, constant: 16),
            wordCountLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            
            characterCountLabel.centerXAnchor.constraint(equalTo: statusBarView.centerXAnchor),
            characterCountLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor),
            
            fontSizeLabel.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor, constant: -16),
            fontSizeLabel.centerYAnchor.constraint(equalTo: statusBarView.centerYAnchor)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toolbarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stylePanelView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor),
            stylePanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stylePanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: stylePanelView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: statusBarView.topAnchor),
            
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Helper Methods
    
    private func createToolbarButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }
    
    private func createColorCollectionView(colors: [UIColor], action: Selector) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func updateCounts() {
        let text = textView.text ?? ""
        wordCount = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count
        characterCount = text.count
    }
    
    private func saveToUndoStack() {
        undoStack.append(textView.text)
        if undoStack.count > 50 {
            undoStack.removeFirst()
        }
        canUndo = undoStack.count > 1
    }
    
    // MARK: - Actions
    
    @objc private func undo() {
        guard undoStack.count > 1 else { return }
        
        let currentText = undoStack.removeLast()
        redoStack.append(currentText)
        
        if let previousText = undoStack.last {
            textView.text = previousText
            updateCounts()
        }
        
        canUndo = undoStack.count > 1
        canRedo = !redoStack.isEmpty
    }
    
    @objc private func redo() {
        guard !redoStack.isEmpty else { return }
        
        let textToRedo = redoStack.removeLast()
        undoStack.append(textToRedo)
        textView.text = textToRedo
        updateCounts()
        
        canUndo = undoStack.count > 1
        canRedo = !redoStack.isEmpty
    }
    
    @objc private func toggleBold() {
        isBold.toggle()
        applyFormatting()
    }
    
    @objc private func toggleItalic() {
        isItalic.toggle()
        applyFormatting()
    }
    
    @objc private func toggleUnderline() {
        isUnderline.toggle()
        applyFormatting()
    }
    
    @objc private func toggleStylePanel() {
        showStylePanel.toggle()
        stylePanelView.isHidden = !showStylePanel
    }
    
    @objc private func showMediaPicker() {
        showMediaPicker = true
        // Present media picker
    }
    
    @objc private func showLinkDialog() {
        let alert = UIAlertController(title: "Insert Link", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Link Text"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "URL"
        }
        
        alert.addAction(UIAlertAction(title: "Insert", style: .default) { _ in
            if let linkText = alert.textFields?[0].text,
               let url = alert.textFields?[1].text {
                self.insertLink(text: linkText, url: url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func setLeftAlignment() {
        alignment = .left
        textView.textAlignment = alignment
    }
    
    @objc private func setCenterAlignment() {
        alignment = .center
        textView.textAlignment = alignment
    }
    
    @objc private func setRightAlignment() {
        alignment = .right
        textView.textAlignment = alignment
    }
    
    @objc private func insertBulletList() {
        insertText("• ")
    }
    
    @objc private func insertNumberedList() {
        insertText("1. ")
    }
    
    @objc private func insertQuote() {
        insertText("\"\"")
    }
    
    @objc private func textColorSelected(_ sender: UIButton) {
        // Handle text color selection
    }
    
    @objc private func backgroundColorSelected(_ sender: UIButton) {
        // Handle background color selection
    }
    
    @objc private func done() {
        // Save document
        dismiss(animated: true)
    }
    
    private func applyFormatting() {
        // Apply formatting to selected text
        updateCounts()
        saveToUndoStack()
    }
    
    private func insertText(_ text: String) {
        let newText = (textView.text ?? "") + text
        textView.text = newText
        updateCounts()
        saveToUndoStack()
    }
    
    private func insertLink(text: String, url: String) {
        let linkText = "[\(text)](\(url))"
        insertText(linkText)
    }
}

// MARK: - UITextViewDelegate

extension RichTextEditorViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updateCounts()
        saveToUndoStack()
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension RichTextEditorViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Int(fontSizes[row]))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fontSize = fontSizes[row]
        textView.font = UIFont.systemFont(ofSize: fontSize)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension RichTextEditorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCollectionViewCell
        
        if collectionView.superview == stylePanelView.subviews.first(where: { $0 is UICollectionView && $0.frame.minY < 200 }) {
            cell.configure(with: textColors[indexPath.item])
        } else {
            cell.configure(with: backgroundColors[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.superview == stylePanelView.subviews.first(where: { $0 is UICollectionView && $0.frame.minY < 200 }) {
            textColor = textColors[indexPath.item]
            textView.textColor = textColor
        } else {
            backgroundColor = backgroundColors[indexPath.item]
            textView.backgroundColor = backgroundColor
        }
    }
}

// MARK: - Supporting Views

class ColorCollectionViewCell: UICollectionViewCell {
    
    private let colorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        colorView.layer.cornerRadius = 15
        colorView.layer.borderWidth = 2
        colorView.layer.borderColor = UIColor.systemGray4.cgColor
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with color: UIColor) {
        colorView.backgroundColor = color
    }
    
    override var isSelected: Bool {
        didSet {
            colorView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
        }
    }
}
