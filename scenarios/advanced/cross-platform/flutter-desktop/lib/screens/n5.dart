import 'package:flutter/material.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  final TextEditingController _locationController = TextEditingController();
  String _selectedLocation = 'No location selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Map'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a location...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _searchLocation,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          
          // Map Controls
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _zoomIn,
                  child: const Text('Zoom In'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _zoomOut,
                  child: const Text('Zoom Out'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetView,
                  child: const Text('Reset'),
                ),
                const Spacer(),
                Text(_selectedLocation),
              ],
            ),
          ),
          
          // Map View
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.map,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Map View',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Interactive map with markers and layers',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _searchLocation() {
    if (_locationController.text.isNotEmpty) {
      setState(() {
        _selectedLocation = 'Searching for: ${_locationController.text}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Searching for ${_locationController.text}')),
      );
    }
  }

  void _zoomIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zooming in')),
    );
  }

  void _zoomOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Zooming out')),
    );
  }

  void _resetView() {
    setState(() {
      _selectedLocation = 'No location selected';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('View reset')),
    );
  }
}
