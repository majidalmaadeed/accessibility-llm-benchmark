import UIKit

class CalendarApplicationViewController: UIViewController {
    
    // MARK: - Properties
    private var currentDate = Date()
    private var selectedDate = Date()
    private var viewMode: ViewMode = .month
    private var events: [Event] = []
    private var isLoading = false
    
    enum ViewMode: String, CaseIterable {
        case month = "month"
        case week = "week"
        case day = "day"
    }
    
    // MARK: - UI Components
    private lazy var navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var viewModeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ViewMode.allCases.map { $0.rawValue.uppercased() })
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(viewModeChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("‹", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("›", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        collectionView.register(WeekDayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WeekDayHeaderView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var weekView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dayView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dayEventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Data
    private var calendarDays: [CalendarDay] = []
    private var weekDaysData: [CalendarDay] = []
    private var dayEvents: [Event] = []
    
    private let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadEvents()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Navigation Bar
        let navItem = UINavigationItem(title: "Calendar")
        navItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createEventButtonTapped))
        ]
        navigationBar.setItems([navItem], animated: false)
        
        // Add subviews
        view.addSubview(navigationBar)
        view.addSubview(viewModeSegmentedControl)
        view.addSubview(navigationView)
        view.addSubview(calendarCollectionView)
        view.addSubview(weekView)
        view.addSubview(dayView)
        view.addSubview(loadingIndicator)
        
        // Navigation view setup
        navigationView.addSubview(previousButton)
        navigationView.addSubview(dateLabel)
        navigationView.addSubview(nextButton)
        
        // Day view setup
        dayView.addSubview(dayEventsTableView)
        
        setupConstraints()
        updateDateLabel()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Navigation Bar
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // View Mode Segmented Control
            viewModeSegmentedControl.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            viewModeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewModeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Navigation View
            navigationView.topAnchor.constraint(equalTo: viewModeSegmentedControl.bottomAnchor, constant: 8),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 44),
            
            // Previous Button
            previousButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 44),
            previousButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Date Label
            dateLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: previousButton.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: nextButton.leadingAnchor, constant: -8),
            
            // Next Button
            nextButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 44),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Calendar Collection View
            calendarCollectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 16),
            calendarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            // Week View
            weekView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 16),
            weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weekView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            weekView.heightAnchor.constraint(equalToConstant: 100),
            
            // Day View
            dayView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 16),
            dayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            // Day Events Table View
            dayEventsTableView.topAnchor.constraint(equalTo: dayView.topAnchor),
            dayEventsTableView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayEventsTableView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            dayEventsTableView.bottomAnchor.constraint(equalTo: dayView.bottomAnchor),
            
            // Loading Indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Data Loading
    private func loadEvents() {
        isLoading = true
        loadingIndicator.startAnimating()
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.events = self.generateSampleEvents()
            self.updateCalendar()
            self.isLoading = false
            self.loadingIndicator.stopAnimating()
        }
    }
    
    private func generateSampleEvents() -> [Event] {
        return [
            Event(
                id: "1",
                title: "Team Meeting",
                description: "Weekly team standup",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 10, minute: 0))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 11, minute: 0))!,
                category: "work",
                isAllDay: false,
                location: "Conference Room A",
                attendees: ["john@example.com", "jane@example.com"],
                recurring: "weekly",
                reminders: ["15min", "1hour"]
            ),
            Event(
                id: "2",
                title: "Doctor Appointment",
                description: "Annual checkup",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 16, hour: 14, minute: 30))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 16, hour: 15, minute: 30))!,
                category: "appointment",
                isAllDay: false,
                location: "Medical Center",
                attendees: [],
                recurring: "none",
                reminders: ["1day", "2hours"]
            ),
            Event(
                id: "3",
                title: "Project Deadline",
                description: "Submit final report",
                startTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 20, hour: 17, minute: 0))!,
                endTime: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 20, hour: 17, minute: 0))!,
                category: "work",
                isAllDay: true,
                location: "",
                attendees: [],
                recurring: "none",
                reminders: ["1week", "1day"]
            )
        ]
    }
    
    // MARK: - Calendar Updates
    private func updateCalendar() {
        switch viewMode {
        case .month:
            updateMonthView()
        case .week:
            updateWeekView()
        case .day:
            updateDayView()
        }
    }
    
    private func updateMonthView() {
        let year = currentDate.year
        let month = currentDate.month
        let firstDay = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1))!
        let lastDay = Calendar.current.date(byAdding: .month, value: 1, to: firstDay)!.addingTimeInterval(-1)
        let startingDayOfWeek = Calendar.current.component(.weekday, from: firstDay) - 1
        
        calendarDays = []
        
        // Add empty cells for days before the first day of the month
        for _ in 0..<startingDayOfWeek {
            calendarDays.append(CalendarDay(date: Date(), dayNumber: 0, isEmpty: true))
        }
        
        // Add days of the month
        for day in 1...lastDay.day {
            let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
            let dayEvents = getEventsForDate(date)
            let isToday = Calendar.current.isDateInToday(date)
            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
            
            calendarDays.append(CalendarDay(
                date: date,
                dayNumber: day,
                isToday: isToday,
                isSelected: isSelected,
                isEmpty: false,
                hasEvents: !dayEvents.isEmpty,
                events: dayEvents
            ))
        }
        
        calendarCollectionView.reloadData()
    }
    
    private func updateWeekView() {
        let startOfWeek = Calendar.current.dateInterval(of: .weekOfYear, for: currentDate)!.start
        weekDaysData = []
        
        for i in 0..<7 {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!
            let dayEvents = getEventsForDate(date)
            let isToday = Calendar.current.isDateInToday(date)
            let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
            
            weekDaysData.append(CalendarDay(
                date: date,
                dayNumber: date.day,
                isToday: isToday,
                isSelected: isSelected,
                isEmpty: false,
                hasEvents: !dayEvents.isEmpty,
                events: dayEvents
            ))
        }
    }
    
    private func updateDayView() {
        dayEvents = getEventsForDate(currentDate)
        dayEventsTableView.reloadData()
    }
    
    private func getEventsForDate(_ date: Date) -> [Event] {
        return events.filter { event in
            Calendar.current.isDate(event.startTime, inSameDayAs: date)
        }
    }
    
    private func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dateLabel.text = formatter.string(from: currentDate)
    }
    
    // MARK: - Actions
    @objc private func viewModeChanged() {
        viewMode = ViewMode.allCases[viewModeSegmentedControl.selectedSegmentIndex]
        
        // Update visibility
        calendarCollectionView.isHidden = viewMode != .month
        weekView.isHidden = viewMode != .week
        dayView.isHidden = viewMode != .day
        
        updateCalendar()
    }
    
    @objc private func previousButtonTapped() {
        switch viewMode {
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
        case .week:
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
        case .day:
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        }
        updateDateLabel()
        updateCalendar()
    }
    
    @objc private func nextButtonTapped() {
        switch viewMode {
        case .month:
            currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
        case .week:
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
        case .day:
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        updateDateLabel()
        updateCalendar()
    }
    
    @objc private func todayButtonTapped() {
        currentDate = Date()
        selectedDate = Date()
        updateDateLabel()
        updateCalendar()
    }
    
    @objc private func createEventButtonTapped() {
        let eventModal = EventModalViewController()
        eventModal.onSave = { [weak self] event in
            self?.events.append(event)
            self?.updateCalendar()
        }
        present(eventModal, animated: true)
    }
    
    private func onDayClicked(_ day: CalendarDay) {
        guard !day.isEmpty else { return }
        
        selectedDate = day.date
        
        if !day.events.isEmpty {
            let eventDetails = EventDetailsViewController(event: day.events.first!)
            eventDetails.onDelete = { [weak self] event in
                self?.events.removeAll { $0.id == event.id }
                self?.updateCalendar()
            }
            present(eventDetails, animated: true)
        } else {
            createEventButtonTapped()
        }
        
        updateCalendar()
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarApplicationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        let day = calendarDays[indexPath.item]
        cell.configure(with: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekDayHeaderView", for: indexPath) as! WeekDayHeaderView
        header.configure(with: weekDays)
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarApplicationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = calendarDays[indexPath.item]
        onDayClicked(day)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarApplicationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 6) / 7
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
}

// MARK: - UITableViewDataSource
extension CalendarApplicationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let event = dayEvents[indexPath.row]
        cell.configure(with: event)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CalendarApplicationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let event = dayEvents[indexPath.row]
        let eventDetails = EventDetailsViewController(event: event)
        eventDetails.onDelete = { [weak self] event in
            self?.events.removeAll { $0.id == event.id }
            self?.updateCalendar()
        }
        present(eventDetails, animated: true)
    }
}

// MARK: - Calendar Day Cell
class CalendarDayCell: UICollectionViewCell {
    private let dayLabel = UILabel()
    private let eventIndicatorsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        
        dayLabel.font = UIFont.systemFont(ofSize: 16)
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventIndicatorsStackView.axis = .horizontal
        eventIndicatorsStackView.distribution = .fillEqually
        eventIndicatorsStackView.spacing = 2
        eventIndicatorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(eventIndicatorsStackView)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            dayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            eventIndicatorsStackView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
            eventIndicatorsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            eventIndicatorsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            eventIndicatorsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func configure(with day: CalendarDay) {
        if day.isEmpty {
            dayLabel.text = ""
            eventIndicatorsStackView.isHidden = true
            contentView.backgroundColor = .systemGray6
        } else {
            dayLabel.text = "\(day.dayNumber)"
            eventIndicatorsStackView.isHidden = !day.hasEvents
            
            if day.isToday {
                dayLabel.font = UIFont.boldSystemFont(ofSize: 16)
                dayLabel.textColor = .systemBlue
                contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            } else if day.isSelected {
                dayLabel.font = UIFont.boldSystemFont(ofSize: 16)
                dayLabel.textColor = .white
                contentView.backgroundColor = .systemBlue
            } else {
                dayLabel.font = UIFont.systemFont(ofSize: 16)
                dayLabel.textColor = .label
                contentView.backgroundColor = .systemBackground
            }
            
            // Add event indicators
            eventIndicatorsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            if day.hasEvents {
                for (index, event) in day.events.prefix(3).enumerated() {
                    let indicator = UIView()
                    indicator.backgroundColor = getCategoryColor(event.category)
                    indicator.layer.cornerRadius = 2
                    eventIndicatorsStackView.addArrangedSubview(indicator)
                }
            }
        }
    }
    
    private func getCategoryColor(_ category: String) -> UIColor {
        switch category {
        case "personal": return .systemGreen
        case "work": return .systemBlue
        case "meeting": return .systemOrange
        case "appointment": return .systemPurple
        case "reminder": return .systemRed
        default: return .systemBlue
        }
    }
}

// MARK: - Week Day Header View
class WeekDayHeaderView: UICollectionReusableView {
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGray6
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with weekDays: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for day in weekDays {
            let label = UILabel()
            label.text = day
            label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - Event Table View Cell
class EventTableViewCell: UITableViewCell {
    private let colorBar = UIView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        colorBar.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        locationLabel.textColor = .tertiaryLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(colorBar)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            colorBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            colorBar.widthAnchor.constraint(equalToConstant: 4),
            
            titleLabel.leadingAnchor.constraint(equalTo: colorBar.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            locationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with event: Event) {
        titleLabel.text = event.title
        timeLabel.text = event.isAllDay ? "All Day" : "\(event.startTime, formatter: timeFormatter) - \(event.endTime, formatter: timeFormatter)"
        locationLabel.text = event.location.isEmpty ? nil : event.location
        colorBar.backgroundColor = getCategoryColor(event.category)
    }
    
    private func getCategoryColor(_ category: String) -> UIColor {
        switch category {
        case "personal": return .systemGreen
        case "work": return .systemBlue
        case "meeting": return .systemOrange
        case "appointment": return .systemPurple
        case "reminder": return .systemRed
        default: return .systemBlue
        }
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

// MARK: - Event Modal View Controller
class EventModalViewController: UIViewController {
    var onSave: ((Event) -> Void)?
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let categorySegmentedControl = UISegmentedControl(items: ["Personal", "Work", "Meeting", "Appointment", "Reminder"])
    private let locationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "New Event"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        // Setup form fields
        titleTextField.placeholder = "Event Title"
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextView.text = "Event Description"
        descriptionTextView.textColor = .placeholderText
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 8
        
        startDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        
        categorySegmentedControl.selectedSegmentIndex = 0
        
        locationTextField.placeholder = "Location"
        locationTextField.borderStyle = .roundedRect
        
        // Add to view
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField,
            descriptionTextView,
            startDatePicker,
            endDatePicker,
            categorySegmentedControl,
            locationTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        
        let event = Event(
            id: UUID().uuidString,
            title: title,
            description: descriptionTextView.text,
            startTime: startDatePicker.date,
            endTime: endDatePicker.date,
            category: ["personal", "work", "meeting", "appointment", "reminder"][categorySegmentedControl.selectedSegmentIndex],
            isAllDay: false,
            location: locationTextField.text ?? "",
            attendees: [],
            recurring: "none",
            reminders: []
        )
        
        onSave?(event)
        dismiss(animated: true)
    }
}

// MARK: - Event Details View Controller
class EventDetailsViewController: UIViewController {
    let event: Event
    var onDelete: ((Event) -> Void)?
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Event Details"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        
        let titleLabel = UILabel()
        titleLabel.text = event.title
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        
        let timeLabel = UILabel()
        timeLabel.text = event.isAllDay ? "All Day" : "\(event.startTime, formatter: timeFormatter) - \(event.endTime, formatter: timeFormatter)"
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = .secondaryLabel
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = event.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        let locationLabel = UILabel()
        locationLabel.text = event.location.isEmpty ? nil : "Location: \(event.location)"
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, timeLabel, descriptionLabel, locationLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
    
    @objc private func deleteTapped() {
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.onDelete?(self.event)
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

// MARK: - Data Models
struct CalendarDay {
    let date: Date
    let dayNumber: Int
    let isToday: Bool
    let isSelected: Bool
    let isEmpty: Bool
    let hasEvents: Bool
    let events: [Event]
}

struct Event {
    let id: String
    let title: String
    let description: String
    let startTime: Date
    let endTime: Date
    let category: String
    let isAllDay: Bool
    let location: String
    let attendees: [String]
    let recurring: String
    let reminders: [String]
}

// MARK: - Date Extensions
extension Date {
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
}