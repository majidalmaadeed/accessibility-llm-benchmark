import UIKit

class CalendarApplicationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    private var headerView: UIView!
    private var navigationView: UIView!
    private var eventsTableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    private var monthLabel: UILabel!
    private var previousButton: UIButton!
    private var nextButton: UIButton!
    private var addEventButton: UIBarButtonItem!
    
    private var selectedDate: Date = Date()
    private var currentView: CalendarView = .month
    private var events: [CalendarEvent] = []
    private var showEventForm: Bool = false
    private var selectedEvent: CalendarEvent? = nil
    
    let viewTypes: [CalendarView] = [.day, .week, .month, .year]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadEvents()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Calendar"
        
        setupHeaderView()
        setupCollectionView()
        setupEventsTableView()
        setupNavigationView()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = .systemGray6
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        monthLabel = UILabel()
        monthLabel.text = formatDateHeader(selectedDate)
        monthLabel.font = UIFont.boldSystemFont(ofSize: 24)
        monthLabel.textAlignment = .center
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        previousButton = UIButton(type: .system)
        previousButton.setTitle("←", for: .normal)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        previousButton.addTarget(self, action: #selector(previousPeriod), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton = UIButton(type: .system)
        nextButton.setTitle("→", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.addTarget(self, action: #selector(nextPeriod), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl = UISegmentedControl(items: viewTypes.map { $0.displayName })
        segmentedControl.selectedSegmentIndex = viewTypes.firstIndex(of: currentView) ?? 2
        segmentedControl.addTarget(self, action: #selector(viewTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        [monthLabel, previousButton, nextButton, segmentedControl].forEach {
            headerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            monthLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            monthLabel.leadingAnchor.constraint(greaterThanOrEqualTo: previousButton.trailingAnchor, constant: 8),
            monthLabel.trailingAnchor.constraint(lessThanOrEqualTo: nextButton.leadingAnchor, constant: -8),
            
            previousButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            previousButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            previousButton.widthAnchor.constraint(equalToConstant: 44),
            previousButton.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 44),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            
            segmentedControl.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarHeaderView")
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    private func setupEventsTableView() {
        eventsTableView = UITableView(frame: .zero, style: .plain)
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        eventsTableView.backgroundColor = .systemGray6
        eventsTableView.separatorStyle = .none
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventsTableView)
    }
    
    private func setupNavigationView() {
        navigationView = UIView()
        navigationView.backgroundColor = .systemGray6
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationView)
        
        let todayButton = UIButton(type: .system)
        todayButton.setTitle("Today", for: .normal)
        todayButton.addTarget(self, action: #selector(goToToday), for: .touchUpInside)
        todayButton.translatesAutoresizingMaskIntoConstraints = false
        
        [todayButton].forEach {
            navigationView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            todayButton.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
            todayButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
            todayButton.widthAnchor.constraint(equalToConstant: 100),
            todayButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            eventsTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: navigationView.topAnchor),
            
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupNavigationBar() {
        addEventButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        navigationItem.rightBarButtonItem = addEventButton
    }
    
    // MARK: - Data Management
    
    private func loadEvents() {
        events = [
            CalendarEvent(
                id: UUID(),
                title: "Team Meeting",
                description: "Weekly team standup",
                startDate: Date().addingTimeInterval(3600),
                endDate: Date().addingTimeInterval(7200),
                category: "Work",
                isAllDay: false,
                location: "Conference Room A"
            ),
            CalendarEvent(
                id: UUID(),
                title: "Doctor Appointment",
                description: "Annual checkup",
                startDate: Date().addingTimeInterval(86400),
                endDate: Date().addingTimeInterval(90000),
                category: "Health",
                isAllDay: false,
                location: "Medical Center"
            ),
            CalendarEvent(
                id: UUID(),
                title: "Birthday Party",
                description: "Sarah's birthday celebration",
                startDate: Date().addingTimeInterval(172800),
                endDate: Date().addingTimeInterval(180000),
                category: "Family",
                isAllDay: false,
                location: "Home"
            )
        ]
        
        collectionView.reloadData()
        eventsTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func previousPeriod() {
        let calendar = Calendar.current
        switch currentView {
        case .day:
            selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        case .week:
            selectedDate = calendar.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? selectedDate
        case .month:
            selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
        case .year:
            selectedDate = calendar.date(byAdding: .year, value: -1, to: selectedDate) ?? selectedDate
        }
        updateHeader()
        collectionView.reloadData()
    }
    
    @objc private func nextPeriod() {
        let calendar = Calendar.current
        switch currentView {
        case .day:
            selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        case .week:
            selectedDate = calendar.date(byAdding: .weekOfYear, value: 1, to: selectedDate) ?? selectedDate
        case .month:
            selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
        case .year:
            selectedDate = calendar.date(byAdding: .year, value: 1, to: selectedDate) ?? selectedDate
        }
        updateHeader()
        collectionView.reloadData()
    }
    
    @objc private func viewTypeChanged(_ sender: UISegmentedControl) {
        currentView = viewTypes[sender.selectedSegmentIndex]
        updateHeader()
        collectionView.reloadData()
    }
    
    @objc private func goToToday() {
        selectedDate = Date()
        updateHeader()
        collectionView.reloadData()
    }
    
    @objc private func addEvent() {
        showEventForm = true
        // Present event form
    }
    
    private func updateHeader() {
        monthLabel.text = formatDateHeader(selectedDate)
    }
    
    private func formatDateHeader(_ date: Date) -> String {
        let formatter = DateFormatter()
        switch currentView {
        case .day:
            formatter.dateFormat = "EEEE, MMMM d, yyyy"
        case .week:
            formatter.dateFormat = "MMM d - d, yyyy"
        case .month:
            formatter.dateFormat = "MMMM yyyy"
        case .year:
            formatter.dateFormat = "yyyy"
        }
        return formatter.string(from: date)
    }
    
    private func eventsForDate(_ date: Date) -> [CalendarEvent] {
        let calendar = Calendar.current
        return events.filter { calendar.isDate($0.startDate, inSameDayAs: date) }
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarApplicationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentView {
        case .day:
            return 24 // Hours in a day
        case .week:
            return 7 // Days in a week
        case .month:
            return 42 // 6 weeks * 7 days
        case .year:
            return 12 // Months in a year
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        
        switch currentView {
        case .day:
            let hour = indexPath.item
            cell.configureForHour(hour: hour, events: eventsForDate(selectedDate))
        case .week:
            let calendar = Calendar.current
            let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start ?? selectedDate
            let date = calendar.date(byAdding: .day, value: indexPath.item, to: startOfWeek) ?? selectedDate
            cell.configureForDate(date: date, events: eventsForDate(date), isToday: isToday(date))
        case .month:
            let calendar = Calendar.current
            let startOfMonth = calendar.dateInterval(of: .month, for: selectedDate)?.start ?? selectedDate
            let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: startOfMonth)?.start ?? startOfMonth
            let date = calendar.date(byAdding: .day, value: indexPath.item, to: startOfWeek) ?? selectedDate
            cell.configureForDate(date: date, events: eventsForDate(date), isToday: isToday(date))
        case .year:
            let month = indexPath.item + 1
            cell.configureForMonth(month: month, year: Calendar.current.component(.year, from: selectedDate))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CalendarHeaderView", for: indexPath) as! CalendarHeaderView
            headerView.configure(for: currentView)
            return headerView
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate

extension CalendarApplicationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch currentView {
        case .day:
            // Handle hour selection
            break
        case .week, .month:
            // Handle date selection
            break
        case .year:
            // Handle month selection
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarApplicationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        switch currentView {
        case .day:
            return CGSize(width: width, height: height / 24)
        case .week:
            return CGSize(width: width / 7, height: height)
        case .month:
            return CGSize(width: width / 7, height: height / 6)
        case .year:
            return CGSize(width: width / 3, height: height / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

// MARK: - UITableViewDataSource

extension CalendarApplicationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        let event = events[indexPath.row]
        cell.configure(with: event)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CalendarApplicationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedEvent = events[indexPath.row]
        // Show event details
    }
}

// MARK: - Supporting Views

class CalendarDayCell: UICollectionViewCell {
    
    private let dayLabel = UILabel()
    private let eventIndicator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        dayLabel.font = UIFont.systemFont(ofSize: 14)
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventIndicator.backgroundColor = .systemBlue
        eventIndicator.layer.cornerRadius = 2
        eventIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        [dayLabel, eventIndicator].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            eventIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            eventIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventIndicator.widthAnchor.constraint(equalToConstant: 4),
            eventIndicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func configureForDate(date: Date, events: [CalendarEvent], isToday: Bool) {
        let day = Calendar.current.component(.day, from: date)
        dayLabel.text = "\(day)"
        dayLabel.textColor = isToday ? .systemBlue : .label
        dayLabel.font = isToday ? UIFont.boldSystemFont(ofSize: 14) : UIFont.systemFont(ofSize: 14)
        
        eventIndicator.isHidden = events.isEmpty
        backgroundColor = isToday ? UIColor.systemBlue.withAlphaComponent(0.1) : .clear
    }
    
    func configureForHour(hour: Int, events: [CalendarEvent]) {
        dayLabel.text = "\(hour):00"
        dayLabel.textColor = .label
        eventIndicator.isHidden = events.isEmpty
    }
    
    func configureForMonth(month: Int, year: Int) {
        let monthName = DateFormatter().monthSymbols[month - 1]
        dayLabel.text = monthName
        dayLabel.textColor = .label
        eventIndicator.isHidden = true
    }
}

class CalendarHeaderView: UICollectionReusableView {
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(for viewType: CalendarView) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        for day in days {
            let label = UILabel()
            label.text = day
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor = .secondaryLabel
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }
}

class EventTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let categoryLabel = UILabel()
    private let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .secondaryLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = .systemBlue
        categoryLabel.layer.cornerRadius = 4
        categoryLabel.clipsToBounds = true
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .secondaryLabel
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, timeLabel, categoryLabel, locationLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: categoryLabel.leadingAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: categoryLabel.leadingAnchor, constant: -8),
            
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: categoryLabel.leadingAnchor, constant: -8),
            locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryLabel.widthAnchor.constraint(equalToConstant: 60),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with event: CalendarEvent) {
        titleLabel.text = event.title
        timeLabel.text = formatTime(event.startDate)
        categoryLabel.text = event.category
        locationLabel.text = event.location
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

// MARK: - Supporting Types

enum CalendarView: CaseIterable {
    case day, week, month, year
    
    var displayName: String {
        switch self {
        case .day: return "Day"
        case .week: return "Week"
        case .month: return "Month"
        case .year: return "Year"
        }
    }
}

struct CalendarEvent {
    let id: UUID
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    let category: String
    let isAllDay: Bool
    let location: String
}
