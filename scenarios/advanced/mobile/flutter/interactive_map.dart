import 'package:flutter/material.dart';

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({Key? key}) : super(key: key);

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  String mapType = 'standard'; // standard, satellite, hybrid, terrain
  double zoomLevel = 10;
  Map<String, double> centerLocation = {'lat': 37.7749, 'lng': -122.4194};
  Map<String, dynamic>? selectedLocation;
  bool showLocationDetails = false;
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];
  bool showSearchResults = false;
  bool trafficEnabled = false;
  bool transitEnabled = false;
  bool bikeLanesEnabled = false;
  bool showLayers = false;
  bool showDirections = false;
  List<Map<String, dynamic>> directions = [];
  bool isLoading = false;
  Map<String, double>? userLocation;
  bool showUserLocation = true;
  List<Map<String, dynamic>> bookmarks = [];
  bool showBookmarks = false;
  bool showMapControls = true;

  final List<Map<String, dynamic>> mapTypes = [
    {'value': 'standard', 'label': 'Standard', 'icon': Icons.map},
    {'value': 'satellite', 'label': 'Satellite', 'icon': Icons.satellite},
    {'value': 'hybrid', 'label': 'Hybrid', 'icon': Icons.layers},
    {'value': 'terrain', 'label': 'Terrain', 'icon': Icons.terrain},
  ];

  final List<Map<String, dynamic>> sampleLocations = [
    {
      'id': '1',
      'name': 'Golden Gate Bridge',
      'address': 'Golden Gate Bridge, San Francisco, CA',
      'lat': 37.8199,
      'lng': -122.4783,
      'type': 'landmark',
      'rating': 4.8,
      'description': 'Famous suspension bridge spanning the Golden Gate strait.',
      'category': 'Tourist Attraction',
      'price': 0,
      'hours': '24/7',
      'phone': '(415) 921-5858',
    },
    {
      'id': '2',
      'name': 'Fisherman\'s Wharf',
      'address': 'Pier 39, San Francisco, CA',
      'lat': 37.8087,
      'lng': -122.4098,
      'type': 'attraction',
      'rating': 4.2,
      'description': 'Popular tourist destination with shops, restaurants, and sea lions.',
      'category': 'Shopping & Dining',
      'price': 0,
      'hours': '9:00 AM - 10:00 PM',
      'phone': '(415) 705-5500',
    },
    {
      'id': '3',
      'name': 'Alcatraz Island',
      'address': 'Alcatraz Island, San Francisco, CA',
      'lat': 37.8270,
      'lng': -122.4230,
      'type': 'landmark',
      'rating': 4.6,
      'description': 'Former federal prison, now a popular tourist attraction.',
      'category': 'Historical Site',
      'price': 45,
      'hours': '9:00 AM - 6:30 PM',
      'phone': '(415) 561-4926',
    },
    {
      'id': '4',
      'name': 'Lombard Street',
      'address': 'Lombard St, San Francisco, CA',
      'lat': 37.8021,
      'lng': -122.4187,
      'type': 'landmark',
      'rating': 4.3,
      'description': 'Famous steep, winding street with eight hairpin turns.',
      'category': 'Tourist Attraction',
      'price': 0,
      'hours': '24/7',
      'phone': 'N/A',
    },
    {
      'id': '5',
      'name': 'Union Square',
      'address': 'Union Square, San Francisco, CA',
      'lat': 37.7880,
      'lng': -122.4074,
      'type': 'shopping',
      'rating': 4.1,
      'description': 'Major shopping and entertainment district in downtown San Francisco.',
      'category': 'Shopping District',
      'price': 0,
      'hours': '10:00 AM - 9:00 PM',
      'phone': 'N/A',
    },
  ];

  final List<Map<String, dynamic>> sampleDirections = [
    {
      'step': 1,
      'instruction': 'Head north on Market St',
      'distance': '0.2 mi',
      'duration': '2 min',
      'icon': Icons.arrow_forward,
    },
    {
      'step': 2,
      'instruction': 'Turn right onto California St',
      'distance': '0.5 mi',
      'duration': '3 min',
      'icon': Icons.arrow_forward,
    },
    {
      'step': 3,
      'instruction': 'Continue straight onto Lombard St',
      'distance': '1.2 mi',
      'duration': '8 min',
      'icon': Icons.arrow_forward,
    },
    {
      'step': 4,
      'instruction': 'Arrive at destination',
      'distance': '0 mi',
      'duration': '0 min',
      'icon': Icons.location_on,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Simulate getting user location
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        userLocation = {'lat': 37.7749, 'lng': -122.4194};
      });
    });
  }

  void handleSearch() async {
    if (searchQuery.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      showSearchResults = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final results = sampleLocations.where((location) =>
        location['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
        location['address'].toLowerCase().contains(searchQuery.toLowerCase()) ||
        location['category'].toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    setState(() {
      searchResults = results;
      isLoading = false;
    });
  }

  void handleLocationSelect(Map<String, dynamic> location) {
    setState(() {
      selectedLocation = location;
      centerLocation = {'lat': location['lat'], 'lng': location['lng']};
      showSearchResults = false;
      searchQuery = '';
    });
  }

  void handleMapPress(double lat, double lng) {
    // Simulate getting location info from coordinates
    final mockLocation = {
      'id': 'temp',
      'name': 'Selected Location',
      'address': '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}',
      'lat': lat,
      'lng': lng,
      'type': 'custom',
      'rating': 0,
      'description': 'Location selected on map',
      'category': 'Custom Location',
      'price': 0,
      'hours': 'N/A',
      'phone': 'N/A',
    };
    setState(() {
      selectedLocation = mockLocation;
      showLocationDetails = true;
    });
  }

  void handleGetDirections() {
    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Location Selected')),
      );
      return;
    }
    setState(() {
      directions = sampleDirections;
      showDirections = true;
    });
  }

  void handleBookmarkLocation() {
    if (selectedLocation == null) return;

    final bookmark = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      ...selectedLocation!,
      'dateAdded': DateTime.now().toIso8601String(),
    };

    setState(() {
      bookmarks.add(bookmark);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location added to bookmarks')),
    );
  }

  void handleRemoveBookmark(String bookmarkId) {
    setState(() {
      bookmarks.removeWhere((bookmark) => bookmark['id'] == bookmarkId);
    });
  }

  Color getMarkerColor(String type) {
    switch (type) {
      case 'landmark': return Colors.red;
      case 'attraction': return Colors.teal;
      case 'shopping': return Colors.blue;
      case 'restaurant': return Colors.green;
      case 'hotel': return Colors.amber;
      default: return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Interactive Map'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildMapTypeSelector(),
          Expanded(
            child: _buildMapArea(),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for places...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.clear),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
              onSubmitted: (_) => handleSearch(),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: handleSearch,
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTypeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: mapTypes.map((type) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilterChip(
              label: Text(type['label']),
              selected: mapType == type['value'],
              onSelected: (selected) => setState(() => mapType = type['value']),
              avatar: Icon(type['icon'], size: 16),
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue,
            ),
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildMapArea() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Simulated Map View
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 64, color: Colors.grey[600]),
                const SizedBox(height: 8),
                Text(
                  'Interactive Map',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  '${centerLocation['lat']!.toStringAsFixed(4)}, ${centerLocation['lng']!.toStringAsFixed(4)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Zoom: ${zoomLevel.toInt()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Simulated Map Markers
          ...sampleLocations.map((location) => Positioned(
            left: (location['lng'] + 122.5) * 200,
            top: (37.8 - location['lat']) * 200,
            child: GestureDetector(
              onTap: () => handleLocationSelect(location),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: getMarkerColor(location['type']),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.location_on, size: 16, color: Colors.white),
              ),
            ),
          )),

          // User Location Marker
          if (userLocation != null && showUserLocation)
            Positioned(
              left: (userLocation!['lng'] + 122.5) * 200,
              top: (37.8 - userLocation!['lat']) * 200,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, size: 12, color: Colors.white),
              ),
            ),

          // Map Controls
          if (showMapControls)
            Positioned(
              right: 16,
              top: 16,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    onPressed: () => setState(() => zoomLevel = (zoomLevel + 1).clamp(1, 20)),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    onPressed: () => setState(() => zoomLevel = (zoomLevel - 1).clamp(1, 20)),
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    onPressed: () => setState(() => centerLocation = {'lat': 37.7749, 'lng': -122.4194}),
                    child: const Icon(Icons.my_location),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.layers, 'Layers', () => setState(() => showLayers = true)),
          _buildControlButton(Icons.bookmark, 'Bookmarks', () => setState(() => showBookmarks = true)),
          _buildControlButton(Icons.settings, 'Controls', () => setState(() => showMapControls = !showMapControls)),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.grey[600]),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Interactive Map'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildMapTypeSelector(),
          Expanded(
            child: _buildMapArea(),
          ),
          _buildBottomControls(),
        ],
      ),
      bottomSheet: showSearchResults ? _buildSearchResults() : null,
      bottomSheet: showLocationDetails ? _buildLocationDetails() : null,
      bottomSheet: showDirections ? _buildDirections() : null,
      bottomSheet: showLayers ? _buildLayersPanel() : null,
      bottomSheet: showBookmarks ? _buildBookmarksPanel() : null,
    );
  }

  Widget _buildSearchResults() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Search Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => showSearchResults = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.blue),
                      title: Text(searchResults[index]['name']),
                      subtitle: Text(searchResults[index]['address']),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => handleLocationSelect(searchResults[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    if (selectedLocation == null) return const SizedBox();

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Location Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => showLocationDetails = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedLocation!['name'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(selectedLocation!['rating'].toString()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedLocation!['address'],
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(selectedLocation!['description']),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.folder, selectedLocation!['category']),
                  if (selectedLocation!['price'] > 0)
                    _buildInfoRow(Icons.attach_money, '\$${selectedLocation!['price']}'),
                  _buildInfoRow(Icons.access_time, selectedLocation!['hours']),
                  if (selectedLocation!['phone'] != 'N/A')
                    _buildInfoRow(Icons.phone, selectedLocation!['phone']),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: handleGetDirections,
                          icon: const Icon(Icons.directions),
                          label: const Text('Directions'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: handleBookmarkLocation,
                          icon: const Icon(Icons.bookmark),
                          label: const Text('Bookmark'),
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
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildDirections() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Directions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => showDirections = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: directions.length,
              itemBuilder: (context, index) {
                final step = directions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(step['step'].toString()),
                  ),
                  title: Text(step['instruction']),
                  subtitle: Text('${step['distance']} • ${step['duration']}'),
                  trailing: Icon(step['icon'], color: Colors.blue),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayersPanel() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Map Layers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => showLayers = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SwitchListTile(
                  title: const Text('Traffic'),
                  value: trafficEnabled,
                  onChanged: (value) => setState(() => trafficEnabled = value),
                ),
                SwitchListTile(
                  title: const Text('Transit'),
                  value: transitEnabled,
                  onChanged: (value) => setState(() => transitEnabled = value),
                ),
                SwitchListTile(
                  title: const Text('Bike Lanes'),
                  value: bikeLanesEnabled,
                  onChanged: (value) => setState(() => bikeLanesEnabled = value),
                ),
                SwitchListTile(
                  title: const Text('User Location'),
                  value: showUserLocation,
                  onChanged: (value) => setState(() => showUserLocation = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarksPanel() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Bookmarks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => showBookmarks = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: bookmarks.isEmpty
                ? const Center(
                    child: Text(
                      'No bookmarks yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = bookmarks[index];
                      return ListTile(
                        leading: const Icon(Icons.bookmark, color: Colors.blue),
                        title: Text(bookmark['name']),
                        subtitle: Text(bookmark['address']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => handleRemoveBookmark(bookmark['id']),
                        ),
                        onTap: () => handleLocationSelect(bookmark),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
