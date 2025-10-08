import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<CalendarEvent> _events = [
    CalendarEvent(title: 'Meeting 1', date: '2024-01-15', time: '10:00 AM'),
    CalendarEvent(title: 'Meeting 2', date: '2024-01-16', time: '2:00 PM'),
    CalendarEvent(title: 'Meeting 3', date: '2024-01-17', time: '9:00 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Application'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'January 2024',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _addEvent,
                  child: const Text('Add Event'),
                ),
              ],
            ),
          ),
          
          // Calendar Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Days of week
                  Row(
                    children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  
                  // Calendar days
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                      ),
                      itemCount: 35, // 5 weeks
                      itemBuilder: (context, index) {
                        final day = index - 6; // Start from day 1
                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: day > 0 && day <= 31 ? Colors.white : Colors.grey[100],
                          ),
                          child: Center(
                            child: Text(
                              day > 0 && day <= 31 ? day.toString() : '',
                              style: TextStyle(
                                color: day > 0 && day <= 31 ? Colors.black : Colors.grey,
                                fontWeight: day == 15 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Events List
          Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final event = _events[index];
                      return ListTile(
                        leading: const Icon(Icons.event),
                        title: Text(event.title),
                        subtitle: Text('${event.date} at ${event.time}'),
                        trailing: IconButton(
                          onPressed: () => _deleteEvent(index),
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: const Text('Event creation form would be here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _events.add(CalendarEvent(
                  title: 'New Event',
                  date: '2024-01-20',
                  time: '12:00 PM',
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }
}

class CalendarEvent {
  final String title;
  final String date;
  final String time;

  CalendarEvent({
    required this.title,
    required this.date,
    required this.time,
  });
}
