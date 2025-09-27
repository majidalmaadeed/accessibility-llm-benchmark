import 'package:flutter/material.dart';

class CalendarApplication extends StatefulWidget {
  const CalendarApplication({Key? key}) : super(key: key);

  @override
  State<CalendarApplication> createState() => _CalendarApplicationState();
}

class _CalendarApplicationState extends State<CalendarApplication> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String viewMode = 'month'; // month, week, day
  List<Map<String, dynamic>> events = [];
  bool showEventModal = false;
  bool showEventDetails = false;
  Map<String, dynamic>? selectedEvent;
  bool isLoading = false;
  List<String> recurringOptions = ['none', 'daily', 'weekly', 'monthly', 'yearly'];
  List<String> reminderSettings = ['none', '5min', '15min', '30min', '1hour', '1day'];
  List<String> categoryFilters = [];
  Map<String, dynamic> newEvent = {
    'title': '',
    'description': '',
    'startTime': '',
    'endTime': '',
    'category': 'personal',
    'isAllDay': false,
    'location': '',
    'attendees': [],
    'recurring': 'none',
    'reminders': [],
  };

  final List<Map<String, dynamic>> categories = [
    {'id': 'personal', 'name': 'Personal', 'color': Colors.green},
    {'id': 'work', 'name': 'Work', 'color': Colors.blue},
    {'id': 'meeting', 'name': 'Meeting', 'color': Colors.orange},
    {'id': 'appointment', 'name': 'Appointment', 'color': Colors.purple},
    {'id': 'reminder', 'name': 'Reminder', 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void loadEvents() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      events = generateSampleEvents();
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> generateSampleEvents() {
    return [
      {
        'id': '1',
        'title': 'Team Meeting',
        'description': 'Weekly team standup',
        'startTime': DateTime(2024, 1, 15, 10, 0),
        'endTime': DateTime(2024, 1, 15, 11, 0),
        'category': 'work',
        'isAllDay': false,
        'location': 'Conference Room A',
        'attendees': ['john@example.com', 'jane@example.com'],
        'recurring': 'weekly',
        'reminders': ['15min', '1hour'],
      },
      {
        'id': '2',
        'title': 'Doctor Appointment',
        'description': 'Annual checkup',
        'startTime': DateTime(2024, 1, 16, 14, 30),
        'endTime': DateTime(2024, 1, 16, 15, 30),
        'category': 'appointment',
        'isAllDay': false,
        'location': 'Medical Center',
        'attendees': [],
        'recurring': 'none',
        'reminders': ['1day', '2hours'],
      },
      {
        'id': '3',
        'title': 'Project Deadline',
        'description': 'Submit final report',
        'startTime': DateTime(2024, 1, 20, 17, 0),
        'endTime': DateTime(2024, 1, 20, 17, 0),
        'category': 'work',
        'isAllDay': true,
        'location': '',
        'attendees': [],
        'recurring': 'none',
        'reminders': ['1week', '1day'],
      },
    ];
  }

  List<DateTime> getDaysInMonth(DateTime date) {
    final year = date.year;
    final month = date.month;
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final daysInMonth = lastDay.day;
    final startingDayOfWeek = firstDay.weekday;

    final days = <DateTime>[];
    
    // Add empty cells for days before the first day of the month
    for (int i = 0; i < startingDayOfWeek - 1; i++) {
      days.add(DateTime(0));
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(DateTime(year, month, day));
    }

    return days;
  }

  List<Map<String, dynamic>> getEventsForDate(DateTime date) {
    if (date.year == 0) return [];
    return events.where((event) {
      final eventDate = event['startTime'] as DateTime;
      return eventDate.year == date.year &&
             eventDate.month == date.month &&
             eventDate.day == date.day;
    }).toList();
  }

  String formatDate(DateTime date) {
    return '${date.weekday == 1 ? 'Monday' : date.weekday == 2 ? 'Tuesday' : date.weekday == 3 ? 'Wednesday' : date.weekday == 4 ? 'Thursday' : date.weekday == 5 ? 'Friday' : date.weekday == 6 ? 'Saturday' : 'Sunday'}, ${date.day} ${date.month == 1 ? 'January' : date.month == 2 ? 'February' : date.month == 3 ? 'March' : date.month == 4 ? 'April' : date.month == 5 ? 'May' : date.month == 6 ? 'June' : date.month == 7 ? 'July' : date.month == 8 ? 'August' : date.month == 9 ? 'September' : date.month == 10 ? 'October' : date.month == 11 ? 'November' : 'December'} ${date.year}';
  }

  void navigateMonth(int direction) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + direction);
    });
  }

  void navigateWeek(int direction) {
    setState(() {
      currentDate = currentDate.add(Duration(days: direction * 7));
    });
  }

  void navigateDay(int direction) {
    setState(() {
      currentDate = currentDate.add(Duration(days: direction));
    });
  }

  void handleDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    final dayEvents = getEventsForDate(date);
    if (dayEvents.isNotEmpty) {
      setState(() {
        selectedEvent = dayEvents.first;
        showEventDetails = true;
      });
    }
  }

  void handleCreateEvent() {
    setState(() {
      newEvent = {
        'title': '',
        'description': '',
        'startTime': selectedDate.toIso8601String().substring(0, 16),
        'endTime': selectedDate.add(const Duration(hours: 1)).toIso8601String().substring(0, 16),
        'category': 'personal',
        'isAllDay': false,
        'location': '',
        'attendees': [],
        'recurring': 'none',
        'reminders': [],
      };
      showEventModal = true;
    });
  }

  void handleSaveEvent() {
    if (newEvent['title'].toString().trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the event')),
      );
      return;
    }

    final event = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      ...newEvent,
      'startTime': DateTime.parse(newEvent['startTime']),
      'endTime': DateTime.parse(newEvent['endTime']),
    };

    setState(() {
      events.add(event);
      showEventModal = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event created successfully')),
    );
  }

  void handleDeleteEvent(String eventId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                events.removeWhere((event) => event['id'] == eventId);
                showEventDetails = false;
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => setState(() => currentDate = DateTime.now()),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: handleCreateEvent,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildViewModeSelector(),
          _buildNavigation(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCalendarView(),
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ['month', 'week', 'day'].map((mode) {
          final isSelected = viewMode == mode;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilterChip(
              label: Text(mode.toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  viewMode = mode;
                });
              },
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (viewMode == 'month') {
                navigateMonth(-1);
              } else if (viewMode == 'week') {
                navigateWeek(-1);
              } else {
                navigateDay(-1);
              }
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            formatDate(currentDate),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () {
              if (viewMode == 'month') {
                navigateMonth(1);
              } else if (viewMode == 'week') {
                navigateWeek(1);
              } else {
                navigateDay(1);
              }
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    switch (viewMode) {
      case 'month':
        return _buildMonthView();
      case 'week':
        return _buildWeekView();
      case 'day':
        return _buildDayView();
      default:
        return _buildMonthView();
    }
  }

  Widget _buildMonthView() {
    final days = getDaysInMonth(currentDate);
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Column(
      children: [
        // Week days header
        Container(
          color: Colors.grey[200],
          child: Row(
            children: weekDays.map((day) => Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            )).toList(),
          ),
        ),
        // Calendar grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final dayEvents = getEventsForDate(date);
              final isToday = date.year != 0 && 
                             date.year == DateTime.now().year &&
                             date.month == DateTime.now().month &&
                             date.day == DateTime.now().day;
              final isSelected = date.year != 0 && 
                               date.year == selectedDate.year &&
                               date.month == selectedDate.month &&
                               date.day == selectedDate.day;

              return GestureDetector(
                onTap: () => date.year != 0 ? handleDateSelect(date) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: isToday ? Colors.blue[100] : 
                           isSelected ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      if (date.year != 0) ...[
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : 
                                     isToday ? Colors.blue : Colors.black,
                            ),
                          ),
                        ),
                        if (dayEvents.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: dayEvents.length > 3 ? 3 : dayEvents.length,
                              itemBuilder: (context, eventIndex) {
                                final event = dayEvents[eventIndex];
                                final category = categories.firstWhere(
                                  (c) => c['id'] == event['category'],
                                  orElse: () => categories.first,
                                );
                                return Container(
                                  height: 4,
                                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: category['color'],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              },
                            ),
                          ),
                        if (dayEvents.length > 3)
                          Text(
                            '+${dayEvents.length - 3}',
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekView() {
    final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    final weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      children: [
        // Week header
        Container(
          color: Colors.grey[200],
          child: Row(
            children: weekDays.map((day) {
              final dayEvents = getEventsForDate(day);
              final isToday = day.year == DateTime.now().year &&
                             day.month == DateTime.now().month &&
                             day.day == DateTime.now().day;
              final isSelected = day.year == selectedDate.year &&
                               day.month == selectedDate.month &&
                               day.day == selectedDate.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () => handleDateSelect(day),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue[100] : 
                             isSelected ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        Text(
                          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.white : 
                                   isToday ? Colors.blue : Colors.black,
                          ),
                        ),
                        if (dayEvents.isNotEmpty)
                          Container(
                            height: 4,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Week content
        Expanded(
          child: Container(
            color: Colors.white,
            child: const Center(
              child: Text('Week view content would go here'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayView() {
    final dayEvents = getEventsForDate(currentDate);
    final isToday = currentDate.year == DateTime.now().year &&
                   currentDate.month == DateTime.now().month &&
                   currentDate.day == DateTime.now().day;

    return Column(
      children: [
        // Day header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Text(
                currentDate.day.toString(),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentDate.month == 1 ? 'January' : 
                    currentDate.month == 2 ? 'February' : 
                    currentDate.month == 3 ? 'March' : 
                    currentDate.month == 4 ? 'April' : 
                    currentDate.month == 5 ? 'May' : 
                    currentDate.month == 6 ? 'June' : 
                    currentDate.month == 7 ? 'July' : 
                    currentDate.month == 8 ? 'August' : 
                    currentDate.month == 9 ? 'September' : 
                    currentDate.month == 10 ? 'October' : 
                    currentDate.month == 11 ? 'November' : 'December',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    currentDate.year.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Day events
        Expanded(
          child: dayEvents.isEmpty
              ? const Center(
                  child: Text(
                    'No events for this day',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: dayEvents.length,
                  itemBuilder: (context, index) {
                    final event = dayEvents[index];
                    final category = categories.firstWhere(
                      (c) => c['id'] == event['category'],
                      orElse: () => categories.first,
                    );

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: category['color'],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        title: Text(event['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['isAllDay'] 
                                  ? 'All Day' 
                                  : '${event['startTime'].toString().substring(11, 16)} - ${event['endTime'].toString().substring(11, 16)}',
                            ),
                            if (event['location'].toString().isNotEmpty)
                              Text(event['location']),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            selectedEvent = event;
                            showEventDetails = true;
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => setState(() => currentDate = DateTime.now()),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: handleCreateEvent,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildViewModeSelector(),
          _buildNavigation(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCalendarView(),
          ),
        ],
      ),
      bottomSheet: showEventModal ? _buildEventModal() : null,
      bottomSheet: showEventDetails ? _buildEventDetailsModal() : null,
    );
  }

  Widget _buildEventModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('New Event', () => setState(() => showEventModal = false)),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField('Title *', 'title', 'Event title'),
                    const SizedBox(height: 16),
                    _buildTextField('Description', 'description', 'Event description', maxLines: 3),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('Start Time', 'startTime', 'YYYY-MM-DDTHH:MM'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField('End Time', 'endTime', 'YYYY-MM-DDTHH:MM'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCategorySelector(),
                    const SizedBox(height: 16),
                    _buildTextField('Location', 'location', 'Event location'),
                  ],
                ),
              ),
            ),
          ),
          _buildModalFooter(
            'Cancel',
            'Save',
            () => setState(() => showEventModal = false),
            handleSaveEvent,
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetailsModal() {
    if (selectedEvent == null) return const SizedBox();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('Event Details', () => setState(() => showEventDetails = false)),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedEvent!['title'],
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedEvent!['isAllDay'] 
                          ? 'All Day' 
                          : '${selectedEvent!['startTime'].toString().substring(0, 16)} - ${selectedEvent!['endTime'].toString().substring(0, 16)}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    if (selectedEvent!['description'].toString().isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(selectedEvent!['description']),
                    ],
                    if (selectedEvent!['location'].toString().isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(selectedEvent!['location']),
                    ],
                    if (selectedEvent!['attendees'].isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text('Attendees', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...selectedEvent!['attendees'].map<Widget>((attendee) => Text(attendee)),
                    ],
                  ],
                ),
              ),
            ),
          ),
          _buildModalFooter(
            'Close',
            'Delete',
            () => setState(() => showEventDetails = false),
            () => handleDeleteEvent(selectedEvent!['id']),
            isDelete: true,
          ),
        ],
      ),
    );
  }

  Widget _buildModalHeader(String title, VoidCallback onClose) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildModalFooter(String leftText, String rightText, VoidCallback onLeft, VoidCallback onRight, {bool isDelete = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onLeft,
              child: Text(leftText),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onRight,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDelete ? Colors.red : Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(rightText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String field, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          maxLines: maxLines,
          onChanged: (value) {
            setState(() {
              newEvent[field] = value;
            });
          },
          controller: TextEditingController(text: newEvent[field] ?? ''),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = newEvent['category'] == category['id'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category['name']),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      newEvent['category'] = category['id'];
                    });
                  },
                  selectedColor: category['color'].withOpacity(0.3),
                  checkmarkColor: category['color'],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
