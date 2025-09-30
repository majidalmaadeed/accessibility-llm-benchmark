import 'package:flutter/material.dart';

class KeyboardTrapInWidget extends StatefulWidget {
  const KeyboardTrapInWidget({Key? key}) : super(key: key);

  @override
  State<KeyboardTrapInWidget> createState() => _KeyboardTrapInWidgetState();
}

class _KeyboardTrapInWidgetState extends State<KeyboardTrapInWidget> {
  bool showDatePicker = false;
  bool showTimePicker = false;
  bool showColorPicker = false;
  bool showFilePicker = false;
  bool showLocationPicker = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Color selectedColor = Colors.blue;
  String selectedFile = '';
  String selectedLocation = '';

  final List<Map<String, dynamic>> events = [
    {
      'id': 1,
      'title': 'Team Meeting',
      'date': '2024-01-25',
      'time': '10:00 AM',
      'location': 'Conference Room A',
      'color': Colors.blue,
      'description': 'Weekly team standup meeting'
    },
    {
      'id': 2,
      'title': 'Client Presentation',
      'date': '2024-01-26',
      'time': '2:00 PM',
      'location': 'Main Conference Room',
      'color': Colors.green,
      'description': 'Present quarterly results to client'
    },
    {
      'id': 3,
      'title': 'Project Deadline',
      'date': '2024-01-30',
      'time': '5:00 PM',
      'location': 'Office',
      'color': Colors.red,
      'description': 'Final submission for Q1 project'
    },
    {
      'id': 4,
      'title': 'Training Session',
      'date': '2024-02-01',
      'time': '9:00 AM',
      'location': 'Training Room',
      'color': Colors.orange,
      'description': 'New software training for team'
    },
  ];

  final List<String> locations = [
    'Conference Room A',
    'Conference Room B',
    'Main Conference Room',
    'Training Room',
    'Office',
    'Remote',
    'Client Office',
    'Hotel Meeting Room',
  ];

  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  void _showDatePicker() {
    setState(() {
      showDatePicker = true;
    });
  }

  void _showTimePicker() {
    setState(() {
      showTimePicker = true;
    });
  }

  void _showColorPicker() {
    setState(() {
      showColorPicker = true;
    });
  }

  void _showFilePicker() {
    setState(() {
      showFilePicker = true;
    });
  }

  void _showLocationPicker() {
    setState(() {
      showLocationPicker = true;
    });
  }

  void _closePicker() {
    setState(() {
      showDatePicker = false;
      showTimePicker = false;
      showColorPicker = false;
      showFilePicker = false;
      showLocationPicker = false;
    });
  }

  void _handleDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _handleTimeSelect(TimeOfDay time) {
    setState(() {
      selectedTime = time;
    });
  }

  void _handleColorSelect(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void _handleFileSelect(String file) {
    setState(() {
      selectedFile = file;
    });
  }

  void _handleLocationSelect(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Event Scheduler'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new event functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Quick Actions
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildActionButton(
                          'Select Date',
                          Icons.calendar_today,
                          _showDatePicker,
                        ),
                        _buildActionButton(
                          'Select Time',
                          Icons.access_time,
                          _showTimePicker,
                        ),
                        _buildActionButton(
                          'Choose Color',
                          Icons.palette,
                          _showColorPicker,
                        ),
                        _buildActionButton(
                          'Attach File',
                          Icons.attach_file,
                          _showFilePicker,
                        ),
                        _buildActionButton(
                          'Set Location',
                          Icons.location_on,
                          _showLocationPicker,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Events List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return _buildEventCard(events[index]);
                  },
                ),
              ),
            ],
          ),
          
          // Custom Pickers - KEYBOARD TRAP IN WIDGET
          if (showDatePicker) _buildDatePicker(),
          if (showTimePicker) _buildTimePicker(),
          if (showColorPicker) _buildColorPicker(),
          if (showFilePicker) _buildFilePicker(),
          if (showLocationPicker) _buildLocationPicker(),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: event['color'],
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          event['title'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${event['date']} at ${event['time']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              event['location'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              event['description'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          onSelected: (value) {
            // Handle menu selection
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 300,
          height: 400,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _closePicker,
                    ),
                  ],
                ),
              ),
              
              // Date Picker Content - KEYBOARD TRAP
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Calendar Widget (simplified)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                          ),
                          itemCount: 35, // 5 weeks
                          itemBuilder: (context, index) {
                            final day = index - 6; // Start from day 1
                            final isCurrentMonth = day > 0 && day <= 31;
                            final isSelected = isCurrentMonth && day == selectedDate.day;
                            
                            return GestureDetector(
                              onTap: isCurrentMonth ? () {
                                _handleDateSelect(DateTime(selectedDate.year, selectedDate.month, day));
                              } : null,
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue[700] : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    isCurrentMonth ? '$day' : '',
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black87,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Action Buttons - KEYBOARD TRAP: No escape key handling
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _closePicker,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _closePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Select'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 300,
          height: 350,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Select Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _closePicker,
                    ),
                  ],
                ),
              ),
              
              // Time Picker Content - KEYBOARD TRAP
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Time Display
                      Text(
                        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Time Selection (simplified)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Hour
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_up),
                                onPressed: () {
                                  final newHour = (selectedTime.hour + 1) % 24;
                                  _handleTimeSelect(TimeOfDay(hour: newHour, minute: selectedTime.minute));
                                },
                              ),
                              Text(
                                selectedTime.hour.toString().padLeft(2, '0'),
                                style: const TextStyle(fontSize: 24),
                              ),
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  final newHour = (selectedTime.hour - 1 + 24) % 24;
                                  _handleTimeSelect(TimeOfDay(hour: newHour, minute: selectedTime.minute));
                                },
                              ),
                            ],
                          ),
                          
                          const Text(':', style: TextStyle(fontSize: 24)),
                          
                          // Minute
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_up),
                                onPressed: () {
                                  final newMinute = (selectedTime.minute + 15) % 60;
                                  _handleTimeSelect(TimeOfDay(hour: selectedTime.hour, minute: newMinute));
                                },
                              ),
                              Text(
                                selectedTime.minute.toString().padLeft(2, '0'),
                                style: const TextStyle(fontSize: 24),
                              ),
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  final newMinute = (selectedTime.minute - 15 + 60) % 60;
                                  _handleTimeSelect(TimeOfDay(hour: selectedTime.hour, minute: newMinute));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Action Buttons - KEYBOARD TRAP: No escape key handling
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _closePicker,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _closePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Select'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Choose Color',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _closePicker,
                    ),
                  ],
                ),
              ),
              
              // Color Picker Content - KEYBOARD TRAP
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Selected Color Display
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: selectedColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Color Options
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1,
                          ),
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            final color = colors[index];
                            final isSelected = color == selectedColor;
                            
                            return GestureDetector(
                              onTap: () => _handleColorSelect(color),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.black : Colors.grey,
                                    width: isSelected ? 3 : 1,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Action Buttons - KEYBOARD TRAP: No escape key handling
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _closePicker,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _closePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Select'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePicker() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 300,
          height: 400,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Select File',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _closePicker,
                    ),
                  ],
                ),
              ),
              
              // File Picker Content - KEYBOARD TRAP
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // File List
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final files = [
                              'Document.pdf',
                              'Image.jpg',
                              'Spreadsheet.xlsx',
                              'Presentation.pptx',
                              'Text.txt',
                            ];
                            
                            return ListTile(
                              leading: const Icon(Icons.insert_drive_file),
                              title: Text(files[index]),
                              onTap: () => _handleFileSelect(files[index]),
                            );
                          },
                        ),
                      ),
                      
                      // Action Buttons - KEYBOARD TRAP: No escape key handling
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _closePicker,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _closePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Select'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 300,
          height: 400,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Select Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: _closePicker,
                    ),
                  ],
                ),
              ),
              
              // Location Picker Content - KEYBOARD TRAP
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Location List
                      Expanded(
                        child: ListView.builder(
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            final location = locations[index];
                            final isSelected = location == selectedLocation;
                            
                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(location),
                              trailing: isSelected ? const Icon(Icons.check) : null,
                              onTap: () => _handleLocationSelect(location),
                            );
                          },
                        ),
                      ),
                      
                      // Action Buttons - KEYBOARD TRAP: No escape key handling
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _closePicker,
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _closePicker();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[700],
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Select'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
